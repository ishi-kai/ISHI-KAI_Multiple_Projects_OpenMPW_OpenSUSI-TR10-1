"""Separate physical fixture: tie only the HA external inputs to VDD.
Qualify input floating-gate warnings without modifying the functional HA.
"""
from pathlib import Path
import json
import klayout.db as db
from verify_half_adder_layout import ROOT, WORK, reference, drc, lvs, mask, sha

def check():
    src=ROOT/'half_adder.gds'; l=db.Layout();l.read(str(src));u=l.dbu
    ha=l.cell('half_adder');top=l.create_cell('half_adder_driver_check')
    top.insert(db.CellInstArray(ha.cell_index(),db.Trans()))
    meta=json.loads((ROOT/'layout/half_adder.ports.json').read_text())
    def box(layer,x0,y0,x1,y1):top.shapes(l.layer(*layer)).insert(db.Box(*[round(v/u) for v in (x0,y0,x1,y1)]))
    for name in ('a','b'):
        x,y=meta['ports'][name]['position_um']
        # Existing HA VDD M2 spine is x=4, spanning y=113.3...313.3.
        box((13,0),4-1.7,y-1.7,x+1.7,y+1.7)
        box((20,0),4-1.7,y-1.7,4+1.7,y+1.7)
        box((19,0),4-.7,y-.7,4+.7,y+.7)
    for name in ('VDD','VSS','VMID','sum','carry'):
        x,y=meta['ports'][name]['position_um']
        top.shapes(l.layer(48,0)).insert(db.Text(name,db.Trans(round(x/u),round(y/u))))
    d=WORK/'driver';d.mkdir(parents=True,exist_ok=True)
    gds=d/'driver.gds';l.write(str(gds))
    ref=d/'reference.spice'
    ref.write_text(reference().read_text()+'\n.subckt half_adder_driver_check VDD VSS VMID sum carry\nXha VDD VDD sum carry VDD VSS VMID half_adder\n.ends\n')
    result=dict(source_sha256=sha(src),scope='Separate fixture with HA inputs tied to VDD; functional HA remains unchanged.',
                drc=drc(gds,top.name,d/'drawing'),lvs=lvs(gds,top.name,ref,d/'lvs'),mask_drc=mask(gds,top.name,d/'manufacturing'))
    result['passed']=all(result[k]['passed'] for k in ('drc','lvs','mask_drc'))
    (ROOT/'reports/half_adder_driver.json').write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(result,indent=2))
    return result
if __name__=='__main__':raise SystemExit(0 if check()['passed'] else 1)
