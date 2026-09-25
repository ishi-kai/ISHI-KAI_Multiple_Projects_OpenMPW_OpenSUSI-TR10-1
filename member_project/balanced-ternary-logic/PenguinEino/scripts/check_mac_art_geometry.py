"""Check art isolation and preserve all pre-existing functional geometry."""
from pathlib import Path
import json,subprocess
import klayout.db as db
ROOT=Path(__file__).resolve().parents[1]
def main():
 oldfile=ROOT/'simulation/silicon_art/before.gds';oldfile.parent.mkdir(parents=True,exist_ok=True);oldfile.write_bytes(subprocess.check_output(['git','show','a15d63a:mac.gds'],cwd=ROOT))
 old=db.Layout();old.read(str(oldfile));new=db.Layout();new.read(str(ROOT/'mac.gds'));a=old.cell('mac');b=new.cell('mac');art=new.cell('silicon_art');assert art
 added={}
 for info in set(old.layer_infos()+new.layer_infos()):
  if info.layer in (48,49):continue  # Terminal label placement is checked separately.
  r=db.Region(a.begin_shapes_rec(old.layer(info)));t=db.Region(b.begin_shapes_rec(new.layer(info)))
  if info.layer in (13,19,20):assert (r-t).is_empty(),info
  else:assert (r^t).is_empty(),info
  if not (t-r).is_empty():added[str(info)]=(t-r).area()*.001**2
 ar=db.Region(art.begin_shapes_rec(new.layer(20,0))).merged()
 for layer in (13,19,20):
  metal=db.Region(b.begin_shapes_rec(new.layer(layer,0))).merged()
  if layer==20:metal=metal-ar
  assert (ar.sized(3000)&metal).is_empty(),layer
 result=dict(passed=True,all_original_functional_geometry_preserved=True,art_clearance_from_functional_M1_M2_vias_um=3,added_area_um2=added,art_bbox_um=str(art.dbbox()))
 (ROOT/'reports/mac_art_geometry.json').write_text(json.dumps(result,indent=2)+'\n');print(result)
if __name__=='__main__':main()
