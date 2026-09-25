"""Run with KLayout -z -t -r; read-only core previews."""
from pathlib import Path
import pya
root=Path(__file__).resolve().parents[1];app=pya.Application.instance()
try:
 for name,w,h in [('mul',1400,1000),('mac',2400,1200)]:
  cv=app.main_window().load_layout(str(root/f'{name}.gds'),1);cv.cell=cv.layout().cell(name)
  view=app.main_window().current_view();view.load_layer_props('/home/ishi-kai/pdk/TR-1um/libs.tech/klayout/tech/TR-1um.lyp');view.add_missing_layers();view.min_hier_levels=0;view.max_hier_levels=10;view.zoom_fit();view.save_image(str(root/f'layout/{name}.png'),w,h)
 app.exit(0)
except Exception:
 import traceback;traceback.print_exc();app.exit(1)
