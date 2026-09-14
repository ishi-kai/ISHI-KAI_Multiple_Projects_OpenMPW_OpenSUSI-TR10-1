"""Exercise the unmodified GUI LVS macro with its default file lookup."""
import json
import os
from pathlib import Path
import pya

work = Path(os.environ['SRAM_SUBMISSION_CHECK_DIR'])
pdk = Path(os.environ['PDK_ROOT']) / os.environ['PDK']
app = pya.Application.instance()
window = app.main_window()
view = window.load_layout(str(work/'sram512.gds'), 0)
view.cell = view.layout().cell('sram512')
macro = pya.Macro(str(pdk/'libs.tech/klayout/tech/lvs/lvs.lylvs'))
# No $input, $circuit, $top_cell, or port-relaxation variables: use the
# displayed top and the official simulation/<top>.spice default.
macro.run()
lvs = window.current_view().lvsdb(0)
assert lvs is not None
pairs = list(lvs.xref().each_circuit_pair())
top = lvs.netlist().circuit_by_name('sram512')
assert top is not None
errors = [e.message for e in lvs.each_error()]
strict_ports = lvs.flag_missing_ports(top)
result = dict(passed=bool(pairs) and not errors and strict_ports and all(
    p.status() == pya.NetlistCrossReference.Match for p in pairs),
    top=top.name, circuit_pairs=[str(p.status()) for p in pairs],
    errors=errors, strict_ports=strict_ports,
    reference='simulation/sram512.spice', reference_override=False)
lvs.write(str(work/'sram512.lvsdb'))
(work/'gui_lvs.json').write_text(json.dumps(result, indent=2)+'\n')
print(json.dumps(result), flush=True)
app.exit(0 if result['passed'] else 1)
