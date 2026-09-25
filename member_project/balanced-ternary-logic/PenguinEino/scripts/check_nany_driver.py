"""Verify a real two-NANY driver connection without changing the primitive.
The first NANY input is tied to VDD only in this physical test fixture.
Checks strict LVS, Drawing DRC and complete mask DRC; not a functional FA.
"""
from pathlib import Path
import json
import klayout.db as db
from verify_nany_layout import ROOT,WORK,reference,drc,lvs,mask,sha

def check(src=None,metadata=None):
 src=Path(src or ROOT/'nany.gds');meta=json.loads(Path(metadata or ROOT/'layout/nany.ports.json').read_text());p=meta['ports'];gap=12;w=meta['width_um'];pitch=w+gap
 l=db.Layout();l.read(str(src));inv=l.cell('nany');top=l.create_cell('nany_driver_check');u=l.dbu
 def box(layer,x0,y0,x1,y1):top.shapes(l.layer(*layer)).insert(db.Box(*[round(v/u) for v in [x0,y0,x1,y1]]))
 def wire(layer,points,width):
  h=width/2
  for (x,y),(xx,yy) in zip(points,points[1:]):
   assert x==xx or y==yy
   box(layer,min(x,xx)-h,min(y,yy)-h,max(x,xx)+h,max(y,yy)+h)
 def label(layer,name,x,y):top.shapes(l.layer(*layer)).insert(db.Text(name,db.Trans(round(x/u),round(y/u))))
 top.insert(db.CellInstArray(inv.cell_index(),db.Trans()))
 top.insert(db.CellInstArray(inv.cell_index(),db.Trans(round(pitch/u),0)))
 # Join both supply rails across the declared gap.
 for name in ['VDD','VSS']:
  x,y=p[name]['position_um'];wire((13,0),[(w-1,y),(pitch+1,y)],3.4);label((48,0),name,w+gap/2,y)
 # VMID is a continuous M2 rail. Inputs b are tied to it in this fixture.
 mx,my=p['VMID']['position_um'];wire((20,0),[(mx,my),(pitch+mx,my)],3.4);label((49,0),'VMID',w+gap/2,my)
 ix,iy=p['a']['position_um'];_,by=p['b']['position_um'];_,py=p['VDD']['position_um']
 wire((20,0),[(ix,iy),(-6,iy)],3.4)
 box((19,0),-6-.7,iy-.7,-6+.7,iy+.7)
 box((13,0),-6-1.7,iy-1.7,-6+1.7,iy+1.7)
 wire((13,0),[(-6,iy),(-6,py),(2,py)],3.4)
 wire((20,0),[(ix,by),(-12,by),(-12,my),(ix,my)],3.4)
 wire((20,0),[(pitch+ix,by),(pitch-4,by),(pitch-4,my)],3.4)
 ox,oy=p['vout']['position_um'];destx=pitch+ix
 wire((20,0),[(ox,oy),(w+gap/2,oy),(w+gap/2,iy),(destx,iy)],3.4)
 label((49,0),'vout',pitch+ox,oy)
 d=WORK/'driver';d.mkdir(parents=True,exist_ok=True);gds=d/'driver.gds';l.write(str(gds))
 ref=reference();text=ref.read_text();out=d/'reference.spice';out.write_text(text+'\n.subckt nany_driver_check VDD VSS VMID vout\nXdriver VDD VMID mid VDD VSS VMID nany\nXload mid VMID vout VDD VSS VMID nany\n.ends\n')
 result=dict(source_sha256=sha(src),scope='Two unchanged NANY primitives with shared power rails and a routed driver output to load input. Driver input tied to VDD in fixture only.',gap_um=gap,drc=drc(gds,top.name,d/'drawing'),lvs=lvs(gds,top.name,out,d/'lvs'),mask_drc=mask(gds,top.name,d/'manufacturing'))
 result['passed']=all(result[k]['passed'] for k in ['drc','lvs','mask_drc']);(ROOT/'reports/nany_driver.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result,indent=2));return result
if __name__=='__main__':
 import argparse
 p=argparse.ArgumentParser(description=__doc__);p.add_argument('--gds');p.add_argument('--metadata');a=p.parse_args()
 raise SystemExit(0 if check(a.gds,a.metadata)['passed'] else 1)
