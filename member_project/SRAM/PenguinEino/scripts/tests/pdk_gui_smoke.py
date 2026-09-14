"""Run with the profile launcher inside KLayout, using hidden GUI views."""
import json,os,sys
from pathlib import Path
import pya

root=Path(__file__).resolve().parents[2]
pdk=Path(os.environ['PDK_ROOT'])/os.environ['PDK']
sys.path.insert(0,str(root/'klayout/live_drc/python'))
from tr1um_live_drc.controller import install

controller=install()
assert controller.rule_source==pdk/'libs.tech/klayout/tech/python/cells/rules_def.py',controller.rule_source
assert controller.official_runset==pdk/'libs.tech/klayout/tech/drc/run.drc',controller.official_runset
assert Path(sys.modules['cells'].__file__).resolve()==pdk/'libs.tech/klayout/tech/python/cells/__init__.py'
lib=pya.Library.library_by_name('TR-1um','TR-1um')
assert lib is not None
assert {'fet_n','fet_p'}<=set(lib.layout().pcell_names())
view=pya.Application.instance().main_window().current_view()
assert view is not None
if 'test_top' in globals():
    cv=view.active_cellview()
    view.select_cell(cv.layout().cell(test_top).cell_index(),view.active_cellview_index)
controller.run_official_now(force=True)
assert controller._official_rdb is not None
categories={c.name():c.num_items() for c in controller._official_rdb.each_category() if c.num_items()}
if 'expect_co_gg' in globals():assert any(c.startswith('CO.GG:') for c in categories),categories
result=dict(profile=os.environ['SRAM_PDK_PROFILE'],pdk_directory=str(pdk),
            rule_source=str(controller.rule_source),runset=str(controller.official_runset),
            pcell_source=sys.modules['cells'].__file__,
            top=view.active_cellview().cell.name,gui_drc_items=controller._official_rdb.num_items(),
            categories=categories,passed=True)
dest=root/'build/pdk_checks/gui'/os.environ['SRAM_PDK_PROFILE'];dest.mkdir(parents=True,exist_ok=True)
(dest/f'result_{result["top"]}.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps(result),flush=True)
controller.shutdown()
