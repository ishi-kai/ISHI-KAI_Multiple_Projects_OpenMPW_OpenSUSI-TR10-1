"""Check that the official PDK DRC can run against the current GUI layout."""

from pathlib import Path
import sys
import time

import pya


PACKAGE_ROOT = Path(__file__).resolve().parents[1] / "python"
sys.path.insert(0, str(PACKAGE_ROOT))

from tr1um_live_drc.controller import install


runset = Path(
    "/home/ishi-kai/pdk/TR-1um/libs.tech/klayout/tech/drc/run.drc"
)
assert runset.is_file()
view = pya.Application.instance().main_window().current_view()
assert view is not None and view.active_cellview().is_valid()
main_window = pya.Application.instance().main_window()
print(
    "Marker browser API:",
    [name for name in dir(main_window) if "marker" in name.lower() or "rdb" in name.lower()],
)
cellview = view.active_cellview()
layout = cellview.layout()
cell = cellview.cell
wn_index = layout.find_layer(140, 0)
wn_count = 0 if wn_index is None else pya.Region(cell.begin_shapes_rec(wn_index)).size()
print(f"Current DRC cell={cell.name}, WN polygons={wn_count}")

macro = pya.Macro(str(runset))
before = int(view.num_rdbs())
print(f"Official DRC interpreter: {macro.interpreter_name()}")
started = time.perf_counter()
result = macro.run()
elapsed_ms = (time.perf_counter() - started) * 1000
after = int(view.num_rdbs())
assert after == before + 1
database = view.rdb(after - 1)
print(
    f"Official in-GUI DRC macro result: {result}; "
    f"RDB={database.name()}, items={database.num_items()}, {elapsed_ms:.1f} ms"
)
for category in database.each_category():
    count = int(category.num_items())
    if count:
        print(f"  {category.name()}: {count}")
for item in database.each_item():
    values = list(item.each_value())
    print(
        "First RDB item:",
        database.category_by_id(item.category_id()).name(),
        [(value.to_s(), value.is_edge_pair(), value.is_polygon()) for value in values],
    )
    break
found = [index for index in range(view.num_rdbs()) if view.rdb(index) == database]
assert found == [after - 1]
view.remove_rdb(found[0])
assert int(view.num_rdbs()) == before

# Exercise the controller's debounced official-DRC path on a known violation.
scale = int(round(1.0 / layout.dbu))
ap = layout.layer(3, 1)
wn = layout.layer(140, 0)
cell.shapes(ap).insert(
    pya.Box(100 * scale, 0, 110 * scale, 10 * scale)
)
cell.shapes(wn).insert(
    pya.Box(94 * scale, -6 * scale, 116 * scale, 16 * scale)
)
controller = install()
controller.run_official_now(force=True)
assert controller._official_rdb is not None
assert controller._markers, "official RDB was not rendered as overlay markers"
category_names = {
    category.name().split(":", 1)[0]
    for category in controller._official_rdb.each_category()
    if category.num_items()
}
assert "AP.WN" in category_names
managed_count = int(view.num_rdbs())
controller.run_official_now(force=True)
print(
    "Managed RDB refresh:",
    controller._official_rdb_index(),
    managed_count,
    int(view.num_rdbs()),
)
assert controller._official_rdb_index() is not None
assert int(view.num_rdbs()) == managed_count
assert controller._markers, "refreshed official markers are missing"
print(
    "Controller official auto-DRC: AP.WN detected; "
    f"{controller._official_rdb.num_items()} total item(s)"
)
controller.shutdown()
