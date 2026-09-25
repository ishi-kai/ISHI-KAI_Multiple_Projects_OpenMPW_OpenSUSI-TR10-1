"""Run inside KLayout: exercise default GUI macros in an isolated mirror."""
from pathlib import Path
import hashlib,json,shutil
import pya
ROOT=Path(__file__).resolve().parents[1];TECH=Path('/home/ishi-kai/pdk/TR-1um/libs.tech/klayout/tech');app=pya.Application.instance()
try:
 results={}
 for name in ('mul','mac'):
  work=ROOT/f'simulation/arithmetic_layout/{name}/gui';(work/'simulation').mkdir(parents=True,exist_ok=True)
  shutil.copy2(ROOT/f'{name}.gds',work/f'{name}.gds');shutil.copy2(ROOT/f'simulation/{name}.spice',work/f'simulation/{name}.spice')
  cv=app.main_window().load_layout(str(work/f'{name}.gds'),1);cv.cell=cv.layout().cell(name);view=app.main_window().current_view()
  n=view.num_rdbs();pya.Macro(str(TECH/'drc/drc.lydrc')).run();assert view.num_rdbs()>n;drc=view.rdb(n);drc.save(str(work/'gui_drc.lyrdb'))
  pya.Macro(str(TECH/'lvs/lvs.lylvs')).run();lvs=view.lvsdb(0);assert lvs;lvs.write(str(work/'gui_lvs.lvsdb'))
  pairs=list(lvs.xref().each_circuit_pair());errors=[e.message for e in lvs.each_error()];logs=[str(e.message) for e in lvs.each_log_entry()]
  r=dict(gds_sha256=hashlib.sha256((ROOT/f'{name}.gds').read_bytes()).hexdigest(),drawing_drc_items=drc.num_items(),lvs_errors=errors,lvs_logs=logs,circuits=[str(p.status()) for p in pairs],default_macro_paths=True)
  r['passed']=drc.num_items()==0 and bool(pairs) and all(p.status()==pya.NetlistCrossReference.Match for p in pairs) and not errors and not logs;results[name]=r
 result=dict(passed=all(r['passed'] for r in results.values()),cells=results);(ROOT/'reports/arithmetic_gui.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result));app.exit(0 if result['passed'] else 1)
except Exception:
 import traceback;traceback.print_exc();app.exit(1)
