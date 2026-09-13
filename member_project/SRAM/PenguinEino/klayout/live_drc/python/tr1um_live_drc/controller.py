"""KLayout GUI controller for fast and official TR-1um live DRC."""

from __future__ import annotations

import builtins
import hashlib
import os
import traceback
from collections import Counter
from contextlib import contextmanager
from pathlib import Path

import pya

from .engine import (
    WATCH_LAYER_INFO,
    inspection_halo_dbu,
    load_pdk_rules,
    run_fast_drc,
)


POLL_INTERVAL_MS = 300
OFFICIAL_DRC_DEBOUNCE_MS = 900
MAX_MARKERS = 300
STATUS_PRIORITY = 5
CONTROLLER_KEY = "_tr1um_live_drc_controller"


@contextmanager
def _hold_layout_display(window):
    """Keep the canvas painted while DRC temporarily selects its progress page.

    DRC's AbstractProgress switches MainWindow's central stack immediately,
    even for sub-second runs. Suppress painting for this synchronous call and
    restore the previous state on success or failure. This does not alter the
    official runset or disable progress for unrelated operations.
    """
    updates_enabled = window.updatesEnabled
    window.setUpdatesEnabled(False)
    try:
        yield
    finally:
        window.setUpdatesEnabled(updates_enabled)


class _CallbackAction(pya.Action):
    def __init__(self, title, callback, *, checkable=False, checked=False):
        super().__init__()
        self.title = title
        self.checkable = checkable
        self.checked = checked
        self._callback = callback

    def triggered(self):
        self._callback(self)


class LiveDrcController:
    def __init__(self):
        self.app = pya.Application.instance()
        self.main_window = self.app.main_window()
        self.enabled = True
        self.official_enabled = True
        self._busy = False
        self._official_busy = False
        self._signature = None
        self._view = None
        self._markers = []
        self._official_rdb = None
        self._official_rdb_view = None
        self.rules, self.rule_source = load_pdk_rules()
        self.official_runset = self._find_official_runset()
        self._actions = []
        self._install_menu()

        self._timer = pya.QTimer(self.main_window)
        self._timer.setInterval(POLL_INTERVAL_MS)
        self._timer.timeout(self._poll)
        self._timer.start()

        self._official_timer = pya.QTimer(self.main_window)
        self._official_timer.setSingleShot(True)
        self._official_timer.setInterval(OFFICIAL_DRC_DEBOUNCE_MS)
        self._official_timer.timeout(self._run_official_drc)

        source = str(self.rule_source) if self.rule_source else "embedded fallback rules"
        print(f"TR-1um Live DRC loaded ({source})")
        if self.official_runset is not None:
            print(f"TR-1um official auto-DRC enabled ({self.official_runset})")
        else:
            self.official_enabled = False
            print("TR-1um official auto-DRC disabled (run.drc not found)")

    def _find_official_runset(self):
        candidates = []
        if self.rule_source is not None:
            candidates.append(self.rule_source.parents[2] / "drc/run.drc")
        pdk_root = os.environ.get("PDK_ROOT")
        pdk = os.environ.get("PDK")
        if pdk_root and pdk:
            candidates.append(
                Path(pdk_root) / pdk / "libs.tech/klayout/tech/drc/run.drc"
            )
        for path in candidates:
            if path.is_file():
                return path.resolve()
        return None

    def _install_menu(self):
        menu = self.main_window.menu()
        if not menu.is_menu("tools_menu.tr1um_live_drc"):
            menu.insert_menu(
                "tools_menu.end", "tr1um_live_drc", "TR-1um Live DRC"
            )

        toggle = _CallbackAction(
            "Enabled", self._toggle, checkable=True, checked=True
        )
        official_toggle = _CallbackAction(
            "Official DRC after edits",
            self._toggle_official,
            checkable=True,
            checked=self.official_runset is not None,
        )
        run = _CallbackAction(
            "Run fast DRC now", lambda _action: self.run_now(force=True)
        )
        run_official = _CallbackAction(
            "Run official DRC now",
            lambda _action: self.run_official_now(force=True),
        )
        show_official = _CallbackAction(
            "Show official results", lambda _action: self.show_official_results()
        )
        clear = _CallbackAction("Clear markers", lambda _action: self.clear_markers())
        self._actions.extend(
            (toggle, official_toggle, run, run_official, show_official, clear)
        )
        menu.insert_item(
            "tools_menu.tr1um_live_drc.end", "enabled", toggle
        )
        menu.insert_item(
            "tools_menu.tr1um_live_drc.end", "official_enabled", official_toggle
        )
        menu.insert_item(
            "tools_menu.tr1um_live_drc.end", "run_fast_now", run
        )
        menu.insert_item(
            "tools_menu.tr1um_live_drc.end", "run_official_now", run_official
        )
        menu.insert_item(
            "tools_menu.tr1um_live_drc.end", "show_official", show_official
        )
        menu.insert_item(
            "tools_menu.tr1um_live_drc.end", "clear", clear
        )

    def _toggle(self, action):
        self.enabled = bool(action.checked)
        self._signature = None
        if self.enabled:
            self.run_now(force=True)
            self._schedule_official_drc()
        else:
            self._official_timer.stop()
            self.clear_markers()
            self._remove_official_rdb()
            self.main_window.message(
                "TR-1um Live DRC: disabled", 2500, STATUS_PRIORITY
            )

    def _toggle_official(self, action):
        self.official_enabled = bool(action.checked) and self.official_runset is not None
        if self.official_enabled:
            self._schedule_official_drc()
        else:
            self._official_timer.stop()
            self._remove_official_rdb()
            self.run_now(force=True)

    def _current_context(self):
        view = self.main_window.current_view()
        if view is None:
            return None
        cellview = view.active_cellview()
        if not cellview.is_valid() or cellview.cell is None:
            return None
        technology = cellview.technology
        env_pdk = os.environ.get("PDK", "")
        if technology not in ("", "TR-1um") and env_pdk != "TR-1um":
            return None
        return view, cellview, cellview.layout(), cellview.cell

    def _shape_signature(self, view, cellview, layout, cell):
        clip_box = view.box().to_itype(layout.dbu)
        search_box = clip_box.enlarged(inspection_halo_dbu(layout, self.rules))
        layer_state = []
        for layer_name, (layer, datatype) in sorted(WATCH_LAYER_INFO.items()):
            layer_index = layout.find_layer(layer, datatype)
            if layer_index is None:
                continue
            iterator = cell.begin_shapes_rec_touching(layer_index, search_box)
            digest = hashlib.blake2b(digest_size=16)
            count = 0
            while not iterator.at_end():
                shape = iterator.shape()
                # Region consumes area shapes.  Ignore labels and guide objects
                # so editing them does not trigger an unnecessary DRC pass.
                if (
                    shape.is_box()
                    or shape.is_polygon()
                    or shape.is_path()
                    or shape.is_text()
                ):
                    shape_hash = int(shape.hash()) & 0xFFFFFFFFFFFFFFFF
                    transform_hash = (
                        int(iterator.itrans().hash()) & 0xFFFFFFFFFFFFFFFF
                    )
                    digest.update(shape_hash.to_bytes(8, "little"))
                    digest.update(transform_hash.to_bytes(8, "little"))
                    count += 1
                iterator.next()
            layer_state.append((layer_index, count, digest.hexdigest()))

        return (
            int(self.main_window.current_view_index),
            int(cellview.index()),
            int(cell.cell_index()),
            view.box().to_s(),
            tuple(layer_state),
        )

    def _poll(self):
        if self._busy or not self.enabled:
            return
        context = self._current_context()
        if context is None:
            if self._view is not None:
                self.clear_markers()
                self._view = None
                self._signature = None
            return

        view, cellview, layout, cell = context
        if self._view is None or self._view != view:
            self.clear_markers()
            self._remove_official_rdb()
            self._view = view
            self._signature = None

        signature = self._shape_signature(view, cellview, layout, cell)
        if signature != self._signature:
            previous = self._signature
            self._signature = signature
            self.run_now(force=False)
            # A viewport-only change needs a new clipped fast pass, but the
            # whole-cell official result remains valid and need not be rerun.
            viewport_only = (
                previous is not None
                and previous[:3] == signature[:3]
                and previous[3] != signature[3]
            )
            if not viewport_only:
                self._schedule_official_drc()

    def _schedule_official_drc(self):
        if (
            self.enabled
            and self.official_enabled
            and self.official_runset is not None
        ):
            self._official_timer.stop()
            self._official_timer.start()

    def run_now(self, *, force=True):
        if self._busy or (not self.enabled and not force):
            return
        context = self._current_context()
        if context is None:
            return
        view, cellview, layout, cell = context
        self._busy = True
        try:
            clip_box = view.box().to_itype(layout.dbu)
            result = run_fast_drc(
                layout,
                cell,
                clip_box=clip_box,
                rules=self.rules,
                pdk_rule_source=self.rule_source,
            )
            self._show_result(view, layout.dbu, result)
        except Exception as exc:
            traceback.print_exc()
            self.clear_markers()
            self.main_window.message(
                f"TR-1um Live DRC error: {exc}", 7000, STATUS_PRIORITY
            )
        finally:
            self._busy = False

    def run_official_now(self, *, force=True):
        self._official_timer.stop()
        self._run_official_drc(force=force)

    def _run_official_drc(self, *, force=False):
        if self._official_busy or self._busy:
            if not force:
                self._schedule_official_drc()
            return
        if self.official_runset is None:
            self.main_window.message(
                "TR-1um Live DRC: official run.drc not found",
                5000,
                STATUS_PRIORITY,
            )
            return
        if not force and (not self.enabled or not self.official_enabled):
            return
        context = self._current_context()
        if context is None:
            return
        view, cellview, layout, cell = context
        self._official_busy = True
        self.main_window.message(
            "TR-1um Live DRC: running official PDK DRC...",
            -1,
            STATUS_PRIORITY,
        )
        before = [view.rdb(index) for index in range(view.num_rdbs())]
        try:
            macro = pya.Macro(str(self.official_runset))
            if not macro.interpreter_name().startswith("DRC"):
                raise RuntimeError(
                    f"unexpected runset interpreter: {macro.interpreter_name()}"
                )
            with _hold_layout_display(self.main_window):
                return_code = macro.run()
            if return_code != 0:
                raise RuntimeError(f"official DRC exited with code {return_code}")

            new_indices = []
            for index in range(view.num_rdbs()):
                candidate = view.rdb(index)
                if not any(candidate == old for old in before):
                    new_indices.append(index)
            if not new_indices:
                raise RuntimeError("official DRC did not create a report database")

            rdb_index = new_indices[-1]
            database = view.rdb(rdb_index)
            existing_index = self._official_rdb_index()
            if existing_index is not None and self._official_rdb_view == view:
                # ReportDatabase.assign crashes KLayout 0.30.9 while the marker
                # browser is attached.  Remove the old managed DB through the
                # LayoutView API, then attach the newly generated one.
                self._official_rdb = None
                self._official_rdb_view = None
                view.remove_rdb(existing_index)
                if existing_index < rdb_index:
                    rdb_index -= 1
                database = view.rdb(rdb_index)
            else:
                self._remove_official_rdb()
            self._official_rdb = database
            self._official_rdb_view = view

            # Do not call show_rdb here: reopening the marker browser after
            # every edit causes a distracting window flash.  Render the flat
            # official DRC geometries as normal overlay markers instead.  The
            # complete RDB remains available through "Show official results".
            self._show_official_markers(view, database)
            self._show_official_summary(database)
        except Exception as exc:
            traceback.print_exc()
            self.main_window.message(
                f"TR-1um official auto-DRC error: {exc}",
                7000,
                STATUS_PRIORITY,
            )
        finally:
            self._official_busy = False

    def _show_official_summary(self, database):
        total = int(database.num_items())
        categories = []
        for category in database.each_category():
            count = int(category.num_items())
            if count:
                rule_id = category.name().split(":", 1)[0]
                categories.append((rule_id, count))
        categories.sort(key=lambda item: (-item[1], item[0]))
        if total == 0:
            self.main_window.message(
                "TR-1um official DRC: no violations",
                2500,
                STATUS_PRIORITY,
            )
            return
        summary = ", ".join(
            f"{rule_id} x{count}" for rule_id, count in categories[:4]
        )
        self.main_window.message(
            f"TR-1um official DRC: {total} items ({summary})",
            -1,
            STATUS_PRIORITY,
        )

    def _show_official_markers(self, view, database):
        self.clear_markers(clear_status=False)
        marker_budget = MAX_MARKERS
        for item in database.each_item():
            geometry = None
            for value in item.each_value():
                if value.is_edge_pair():
                    # Marker has no DEdgePair overload.  Convert the pair to a
                    # minimally expanded polygon in micron coordinates.
                    geometry = value.edge_pair().polygon(0.001)
                elif value.is_polygon():
                    geometry = value.polygon()
                elif value.is_box():
                    geometry = value.box()
                elif value.is_path():
                    geometry = value.path()
                elif value.is_edge():
                    geometry = value.edge()
                elif value.is_text():
                    geometry = value.text()
                if geometry is not None:
                    break
            if geometry is None:
                continue
            marker = pya.Marker(view)
            marker.set(geometry)
            marker.color = 0xFF3030
            marker.frame_color = 0xFF3030
            marker.line_width = 2
            marker.vertex_size = 0
            marker.halo = 1
            marker.dismissable = False
            self._markers.append(marker)
            marker_budget -= 1
            if marker_budget <= 0:
                break

    def _official_rdb_index(self):
        if self._official_rdb is None or self._official_rdb_view is None:
            return None
        view = self._official_rdb_view
        for index in range(view.num_rdbs()):
            if view.rdb(index) == self._official_rdb:
                return index
        return None

    def show_official_results(self):
        index = self._official_rdb_index()
        if index is None:
            self.main_window.message(
                "TR-1um Live DRC: no official result yet",
                3000,
                STATUS_PRIORITY,
            )
            return
        view = self._official_rdb_view
        cellview = view.active_cellview()
        view.show_rdb(index, int(cellview.index()))

    def _remove_official_rdb(self):
        index = self._official_rdb_index()
        if index is not None:
            try:
                self._official_rdb_view.remove_rdb(index)
            except Exception:
                pass
        self._official_rdb = None
        self._official_rdb_view = None

    def _show_result(self, view, dbu, result):
        self.clear_markers(clear_status=False)
        marker_budget = MAX_MARKERS
        counts = Counter()

        for violation in result.violations:
            counts[violation.rule_id] += violation.count
            for polygon in violation.geometry.each():
                if marker_budget <= 0:
                    break
                marker = pya.Marker(view)
                marker.set(polygon.to_dtype(dbu))
                marker.color = 0xFF3030
                marker.frame_color = 0xFF3030
                marker.line_width = 2
                marker.vertex_size = 0
                marker.halo = 1
                marker.dismissable = False
                self._markers.append(marker)
                marker_budget -= 1
            if marker_budget <= 0:
                break

        if result.marker_count == 0:
            self.main_window.message(
                "TR-1um Live DRC: no geometric violations in view",
                2500,
                STATUS_PRIORITY,
            )
            return

        summary = ", ".join(
            f"{rule_id} x{count}" for rule_id, count in counts.most_common(4)
        )
        truncated = result.marker_count > MAX_MARKERS
        suffix = f"; showing first {MAX_MARKERS}" if truncated else ""
        self.main_window.message(
            f"TR-1um Live DRC: {result.marker_count} markers ({summary}){suffix}",
            -1,
            STATUS_PRIORITY,
        )

    def clear_markers(self, *, clear_status=True):
        for marker in self._markers:
            try:
                marker.set(pya.DBox())
                marker._destroy()
            except Exception:
                pass
        self._markers = []
        if clear_status:
            try:
                self.main_window.clear_message(STATUS_PRIORITY)
            except Exception:
                self.main_window.message("", 1, STATUS_PRIORITY)

    def shutdown(self):
        try:
            self._timer.stop()
            self._timer._destroy()
            self._official_timer.stop()
            self._official_timer._destroy()
        except Exception:
            pass
        self.clear_markers()
        self._remove_official_rdb()


def install():
    previous = getattr(builtins, CONTROLLER_KEY, None)
    if previous is not None:
        try:
            previous.shutdown()
        except Exception:
            pass
    controller = LiveDrcController()
    setattr(builtins, CONTROLLER_KEY, controller)
    return controller
