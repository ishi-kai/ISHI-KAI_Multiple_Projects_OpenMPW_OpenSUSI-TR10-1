"""Width guide for the native Path tool (KLayout 0.30.4+)."""

import builtins
import math

import pya


KEY = "_path_start_preview"


class PreviewPlugin(pya.Plugin):
    def __init__(self, owner, view):
        super().__init__()
        self.owner = owner
        self.layout_view = view
        self.position = None
        self.creating = False
        self.markers = []
        self.box = None

    def hide(self):
        if self.box is None:
            return
        self.box = None
        for marker in self.markers:
            if not marker._destroyed():
                marker.set(pya.DBox())

    def refresh(self):
        view = self.layout_view
        if view._destroyed():
            return
        if (not self.owner.enabled or self.position is None or self.creating
                or view.mode_name() != "path" or not view.is_editable()
                or not view.active_cellview().is_valid()):
            self.hide()
            return
        width = float(view.get_config("edit-path-width") or 0)
        if not math.isfinite(width) or width <= 0:
            self.hide()
            return
        # Same obj_snap implementation as native PathService::snap2_details.
        point = self.snap2(self.position, False)
        half = width / 2
        box = pya.DBox(point.x-half, point.y-half,
                       point.x+half, point.y+half)
        if (self.box is not None and self.box == box
                and len(self.markers) == 2
                and all(not marker._destroyed() for marker in self.markers)):
            return
        self.box = box
        if len(self.markers) != 2 or any(marker._destroyed() for marker in self.markers):
            for marker in self.markers:
                if not marker._destroyed():
                    marker._destroy()
            self.markers = [pya.Marker(view), pya.Marker(view)]
            for marker in self.markers:
                marker.color = 0x80FFFF
                marker.frame_color = 0x80FFFF
                marker.line_width = 2
                marker.vertex_size = 0
                marker.halo = 1
                marker.dismissable = False
        self.markers[0].set(pya.DEdge(point.x-half, point.y, point.x+half, point.y))
        self.markers[1].set(pya.DEdge(point.x, point.y-half, point.x, point.y+half))

    def mouse_moved_event(self, point, buttons, prio):
        self.position = point
        self.refresh()
        return False

    def leave_event(self, prio):
        self.position = None
        self.hide()
        return False


class CreationHooks(pya.EditorHooks):
    def __init__(self, owner):
        super().__init__()
        self.owner = owner
        self.active = None
        self.register("PathStartPreview")

    def begin_create_shapes(self, cellview, layer):
        self.active = self.owner.for_view(cellview.view())
        if self.active is not None:
            self.active.creating = True
            self.active.hide()

    def end_create_shapes(self):
        if self.active is not None:
            self.active.creating = False
            self.active = None


class PreviewFactory(pya.PluginFactory):
    def __init__(self):
        super().__init__()
        self.enabled = True
        self.plugins = []
        self.has_tool_entry = False
        self.register(100001, "path_start_preview", "Path start preview")
        self.hooks = CreationHooks(self)
        window = pya.Application.instance().main_window()
        self.action = pya.Action()
        self.action.title = "Path start preview"
        self.action.checkable = True
        self.action.checked = True
        self.action.on_triggered = self.toggle
        window.menu().insert_item("tools_menu.end", "path_start_preview", self.action)
        # Refresh even if width/mode changes while the pointer is stationary.
        self.timer = pya.QTimer(window)
        self.timer.setInterval(50)
        self.timer.timeout(self.refresh)
        self.timer.start()

    def create_plugin(self, manager, root, view):
        plugin = PreviewPlugin(self, view)
        self.plugins.append(plugin)
        return plugin

    def for_view(self, view):
        return next((p for p in self.plugins
                     if not p._destroyed() and p.layout_view == view), None)

    def refresh(self):
        self.plugins[:] = [p for p in self.plugins
                           if not p._destroyed() and not p.layout_view._destroyed()]
        for plugin in self.plugins:
            plugin.refresh()

    def toggle(self):
        self.enabled = bool(self.action.checked)
        self.refresh()


def install():
    # Macro can also be run manually in an already open KLayout session.
    owner = getattr(builtins, KEY, None)
    if owner is None:
        owner = PreviewFactory()
        setattr(builtins, KEY, owner)
    return owner
