"""Run with KLayout -z -t -r; render the saved FA without modifying its GDS."""
from pathlib import Path
import pya
ROOT=Path(__file__).resolve().parents[1]
app=pya.Application.instance()
try:
    cv=app.main_window().load_layout(str(ROOT/'full_adder.gds'),0)
    cv.cell=cv.layout().cell('full_adder')
    view=app.main_window().current_view()
    view.load_layer_props('/home/ishi-kai/pdk/TR-1um/libs.tech/klayout/tech/TR-1um.lyp')
    view.add_missing_layers()
    view.min_hier_levels=0
    view.max_hier_levels=10
    view.zoom_fit()
    view.save_image(str(ROOT/'layout/full_adder.png'),2400,800)
    app.exit(0)
except Exception:
    import traceback
    traceback.print_exc()
    app.exit(1)
