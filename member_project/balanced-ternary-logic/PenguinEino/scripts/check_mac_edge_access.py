"""Verify physical preservation and straight, noncrossing perimeter access."""
from pathlib import Path
import hashlib,json,subprocess
import klayout.db as db
ROOT=Path(__file__).resolve().parents[1]
def main():
 baseline=ROOT/'simulation/mac_edge_before.gds';baseline.write_bytes(subprocess.check_output(['git','show','e904eed:mac.gds'],cwd=ROOT))
 old=db.Layout();old.read(str(baseline));ly=db.Layout();ly.read(str(ROOT/'mac.gds'));top=ly.cell('mac')
 assert ly.dbu==.001
 for info in set(old.layer_infos()+ly.layer_infos()):
  if info.layer in (48,49):continue  # Top-level terminal labels intentionally move.
  before=db.Region(old.cell('mac').begin_shapes_rec(old.layer(info)));after=db.Region(top.begin_shapes_rec(ly.layer(info)))
  assert (before-after).is_empty(),('Removed geometry',info)
  if info.layer not in (13,19,20):assert (before^after).is_empty(),info
 for info in ly.layer_infos():
  a=db.Region(old.cell('silicon_art').begin_shapes_rec(old.layer(info)));b=db.Region(ly.cell('silicon_art').begin_shapes_rec(ly.layer(info)));assert (a^b).is_empty(),info
 regs={n:db.Region(top.begin_shapes_rec(ly.layer(n,0))).merged() for n in (13,20)}
 ports=json.loads((ROOT/'layout/mac.ports.json').read_text())['ports'];checked={};corridors=[]
 for name,p in ports.items():
  x,y=p['position_um'];layer=p['layer'][0];assert x in (10,1780)
  pt=db.Point(round(x*1000),round(y*1000));own=[poly for poly in regs[layer].each() if poly.inside(pt)];assert len(own)==1,name
  left=x==10;bounds=[0 if left else x,y-1.7,x if left else 1800,y+1.7]
  corridor=db.Region(db.Box(*(round(v*1000) for v in bounds)))
  # Only this terminal's metal may intersect the straight horizontal exit.
  assert (corridor & (regs[layer]-db.Region(own[0]))).is_empty(),name
  for other,c in corridors:assert (corridor&c).is_empty(),(name,other)
  corridors.append((name,corridor))
  assert any(s.is_text() and s.text.string==name and s.text.x==pt.x and s.text.y==pt.y for s in top.shapes(ly.layer(*p['label_layer'])).each()),name
  checked[name]=dict(layer=layer,position_um=[x,y],edge='left' if left else 'right',outward_corridor_um=bounds,clear=True)
 assert len(checked)==11
 result=dict(passed=True,gds_sha256=hashlib.sha256((ROOT/'mac.gds').read_bytes()).hexdigest(),baseline_commit='e904eed',original_geometry_preserved=True,art_unchanged=True,ports=checked,scope='Straight 3.4 um wide outward access to the allocation boundary; exit corridors do not overlap each other or other same-layer metal.')
 (ROOT/'reports/mac_edge_access.json').write_text(json.dumps(result,indent=2)+'\n');print('PASS: 11 edge ports, clear outward corridors, original circuit and art preserved')
if __name__=='__main__':main()
