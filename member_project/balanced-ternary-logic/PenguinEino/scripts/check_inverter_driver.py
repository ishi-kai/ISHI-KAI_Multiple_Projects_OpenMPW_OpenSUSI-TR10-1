"""Verify a real two-INV driver connection without changing the primitive.
The first INV input is tied to VDD only in this physical test fixture.
Checks strict LVS, Drawing DRC and complete mask DRC; not a functional FA.
"""
from pathlib import Path
import json
import klayout.db as db
from verify_inverter_layout import ROOT,WORK,reference,drc,lvs,mask,sha

def check():
 src=ROOT/'inverter.gds';meta=json.loads((ROOT/'layout/inverter.ports.json').read_text());p=meta['ports'];gap=12;w=meta['width_um'];pitch=w+gap
 l=db.Layout();l.read(str(src));inv=l.cell('inverter');top=l.create_cell('inverter_driver_check');u=l.dbu
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
 ix,iy=p['vin']['position_um'];_,py=p['VDD']['position_um']
 wire((13,0),[(ix,iy),(-4,iy),(-4,py),(2,py)],2.6)
 ox,oy=p['vout']['position_um'];destx=pitch+ix
 # M2 output-to-input route and correctly enclosed M1/M2 landing.
 wire((20,0),[(ox,oy),(w+gap/2,oy),(w+gap/2,iy),(destx,iy)],3.4)
 box((13,0),destx-1.7,iy-1.7,destx+1.7,iy+1.7)
 box((20,0),destx-1.7,iy-1.7,destx+1.7,iy+1.7)
 box((19,0),destx-.7,iy-.7,destx+.7,iy+.7)
 label((49,0),'vout',pitch+ox,oy)
 d=WORK/'driver';d.mkdir(parents=True,exist_ok=True);gds=d/'driver.gds';l.write(str(gds))
 ref=reference();text=ref.read_text();out=d/'reference.spice';out.write_text(text+'\n.subckt inverter_driver_check VDD VSS vout\nXdriver VDD mid VDD VSS inverter\nXload mid vout VDD VSS inverter\n.ends\n')
 result=dict(source_sha256=sha(src),scope='Two unchanged INV primitives with shared power rails and a routed driver output to load input. Driver input tied to VDD in fixture only.',gap_um=gap,drc=drc(gds,top.name,d/'drawing'),lvs=lvs(gds,top.name,out,d/'lvs'),mask_drc=mask(gds,top.name,d/'manufacturing'))
 result['passed']=all(result[k]['passed'] for k in ['drc','lvs','mask_drc']);(ROOT/'reports/inverter_driver.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result,indent=2));return result
if __name__=='__main__':raise SystemExit(0 if check()['passed'] else 1)
