"""Run with KLayout itself to exercise UI-only APIs used by the macro."""

import sys
from pathlib import Path

import pya


PACKAGE_ROOT = Path(__file__).resolve().parents[1] / "python"
sys.path.insert(0, str(PACKAGE_ROOT))

from tr1um_live_drc.controller import install
from tr1um_live_drc.engine import run_fast_drc


controller = install()
view = pya.Application.instance().main_window().current_view()
assert view is not None, "GUI smoke test requires a layout"
view.zoom_fit()
controller._poll()
assert controller._official_timer.isActive(), "official DRC was not scheduled"
initial_markers = len(controller._markers)

# Mirror the AP.WN enclosure case reported by the official DRC browser.
cellview = view.active_cellview()
layout = cellview.layout()
cell = cellview.cell
scale = int(round(1.0 / layout.dbu))
ap = layout.layer(3, 1)
wn = layout.layer(140, 0)
cell.shapes(ap).insert(pya.Box(0, 0, 10 * scale, 10 * scale))
cell.shapes(wn).insert(
    pya.Box(-6 * scale, -6 * scale, 16 * scale, 16 * scale)
)
clip_box = view.box().to_itype(layout.dbu)
ap_wn_result = run_fast_drc(
    layout, cell, clip_box=clip_box, rules=controller.rules
)
assert any(v.rule_id == "AP.WN" for v in ap_wn_result.violations), (
    "AP.WN enclosure violation was not detected"
)
controller._poll()
assert len(controller._markers) > initial_markers, "AP.WN marker was not shown"
initial_markers = len(controller._markers)

# Emulate a newly committed, too-narrow M2 route and let the poller notice it.
m2 = layout.layer(20, 0)
cell.shapes(m2).insert(pya.Box(0, 0, scale, 10 * scale))
controller._poll()
assert len(controller._markers) > initial_markers, "edit was not detected"

# A vertex edit can keep both the shape count and bounding box unchanged.  The
# recursive geometry signature must still notice it.
m1 = layout.layer(13, 0)
editable = cell.shapes(m1).insert(pya.Box(20 * scale, 0, 24 * scale, 4 * scale))
box_signature = controller._shape_signature(view, cellview, layout, cell)
editable.polygon = pya.Polygon(
    [
        pya.Point(20 * scale, 0),
        pya.Point(24 * scale, 0),
        pya.Point(24 * scale, 4 * scale),
        pya.Point(22 * scale, 2 * scale),
        pya.Point(20 * scale, 4 * scale),
    ]
)
polygon_signature = controller._shape_signature(view, cellview, layout, cell)
assert polygon_signature != box_signature, "same-bbox polygon edit was not detected"

# Child-cell geometry is part of the active cell's flattened DRC region.
child = layout.create_cell("LIVE_DRC_SMOKE_CHILD")
cell.insert(pya.CellInstArray(child.cell_index(), pya.Trans()))
empty_child_signature = controller._shape_signature(view, cellview, layout, cell)
child.shapes(m1).insert(pya.Box(30 * scale, 0, 31 * scale, 10 * scale))
edited_child_signature = controller._shape_signature(view, cellview, layout, cell)
assert edited_child_signature != empty_child_signature, "child-cell edit was not detected"

# Recognition and label layers affect the official deck even though the fast
# Region checker does not consume them directly.
before_esd = controller._shape_signature(view, cellview, layout, cell)
cell.shapes(layout.layer(63, 2)).insert(
    pya.Box(0, 0, 2 * scale, 2 * scale)
)
after_esd = controller._shape_signature(view, cellview, layout, cell)
assert after_esd != before_esd, "ESD recognition-layer edit was not detected"

before_label = after_esd
cell.shapes(layout.layer(48, 0)).insert(pya.Text("LIVE_DRC", pya.Trans()))
after_label = controller._shape_signature(view, cellview, layout, cell)
assert after_label != before_label, "metal label edit was not detected"
controller._poll()
print(
    f"GUI smoke test: geometry/hierarchy/recognition/label edits detected; "
    f"{len(controller._markers)} marker(s)"
)
controller.shutdown()
