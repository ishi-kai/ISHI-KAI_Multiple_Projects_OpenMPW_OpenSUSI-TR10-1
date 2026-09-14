"""Run the official GUI macro with its default schematic and current-view source."""
from pathlib import Path
import pya

ROOT = Path(__file__).resolve().parents[3]
app = pya.Application.instance()
mw = app.main_window()
cv = mw.load_layout(str(ROOT / 'learning/layout/sram.gds'), 0)
cv.cell = cv.layout().cell('sram_array')
v = mw.current_view()
print('GUI source:', cv.cell.name)
macro = pya.Macro('/home/ishi-kai/pdk/TR-1um/libs.tech/klayout/tech/lvs/lvs.lylvs')
macro.run()
lvs = v.lvsdb(0)
assert lvs is not None
pairs = list(lvs.xref().each_circuit_pair())
assert len(pairs) == 1
assert pairs[0].first().name == 'sram_array'
assert pairs[0].status() == pya.NetlistCrossReference.Match
assert not list(lvs.each_error())
assert lvs.flag_missing_ports(pairs[0].first())
print('GUI default official LVS: PASS, strict ports PASS, no extraction errors')
app.exit(0)
