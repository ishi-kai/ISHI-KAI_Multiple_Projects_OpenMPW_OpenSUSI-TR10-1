"""Run inside KLayout GUI (-r), using the official macros without path overrides."""
from pathlib import Path
import hashlib
import json
import pya

ROOT = Path(__file__).resolve().parents[1]
TECH = Path('/home/ishi-kai/pdk/TR-1um/libs.tech/klayout/tech')
app = pya.Application.instance()
try:
    cv = app.main_window().load_layout(str(ROOT / 'inverter.gds'), 0)
    cv.cell = cv.layout().cell('inverter')
    view = app.main_window().current_view()
    before = view.num_rdbs()
    pya.Macro(str(TECH / 'drc/drc.lydrc')).run()
    print('DRC report count:', before, '->', view.num_rdbs(), flush=True)
    assert view.num_rdbs() > before, 'Drawing DRC did not create a report'
    drc = view.rdb(before)
    drc.save(str(ROOT / 'simulation/inverter_gui_drc.lyrdb'))
    pya.Macro(str(TECH / 'lvs/lvs.lylvs')).run()
    lvs = view.lvsdb(0)
    assert lvs is not None, 'LVS did not create a report'
    lvs.write(str(ROOT / 'simulation/inverter_gui_lvs.lvsdb'))
    pairs = list(lvs.xref().each_circuit_pair())
    matched = bool(pairs) and all(p.status() == pya.NetlistCrossReference.Match for p in pairs)
    errors = [e.message for e in lvs.each_error()]
    result = dict(gds=str(ROOT / 'inverter.gds'),
                  gds_sha256=hashlib.sha256((ROOT / 'inverter.gds').read_bytes()).hexdigest(),
                  drawing_drc_items=drc.num_items(), lvs_match=matched,
                  lvs_errors=errors, default_macro_paths=True,
                  passed=drc.num_items() == 0 and matched and not errors)
    (ROOT / 'reports/inverter_gui.json').write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps(result), flush=True)
    app.exit(0 if result['passed'] else 1)
except Exception:
    import traceback
    traceback.print_exc()
    app.exit(1)
