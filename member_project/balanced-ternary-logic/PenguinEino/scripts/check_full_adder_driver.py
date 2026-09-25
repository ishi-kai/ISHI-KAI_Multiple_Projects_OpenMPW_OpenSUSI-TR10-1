"""Separate physical fixture to diagnose the FA's floating external gate warnings.

Tie a,b,cin to existing VDD spines in a temporary parent; leave the actual FA alone.
"""
from concurrent.futures import ThreadPoolExecutor
import json
import klayout.db as db
from verify_full_adder_layout import ROOT,WORK,reference,lvs,sha,drc,mask


def check():
    source=ROOT/'full_adder.gds'
    layout=db.Layout();layout.read(str(source));u=layout.dbu
    fa=layout.cell('full_adder');top=layout.create_cell('full_adder_driver_check')
    top.insert(db.CellInstArray(fa.cell_index(),db.Trans()))
    def box(layer,x0,y0,x1,y1):
        top.shapes(layout.layer(*layer)).insert(db.Box(*[round(v/u) for v in (x0,y0,x1,y1)]))
    # These spines belong to VDD in HA1 and HA2. Horizontal M1 reaches only
    # the external input tracks at these coordinates, avoiding all outputs.
    connections=[('a',-92.05,-76.05,29.75),('b',-92.05,-76.05,35.75),('cin',604.9,620.9,35.75)]
    for _,x,xend,y in connections:
        box((13,0),x-1.7,y-1.7,xend+1.7,y+1.7)
        box((20,0),x-1.7,y-1.7,x+1.7,y+1.7)
        box((19,0),x-.7,y-.7,x+.7,y+.7)
    for shape in fa.shapes(layout.layer(48,0)).each():
        if shape.is_text() and shape.text.string in ('VDD','VSS','VMID','sum','cout'):
            top.shapes(layout.layer(48,0)).insert(shape.text)
    d=WORK/'driver';d.mkdir(parents=True,exist_ok=True)
    gds=d/'driver.gds';layout.write(str(gds))
    ref=d/'reference.spice'
    ref.write_text(reference().read_text()+'\n.subckt full_adder_driver_check VDD VSS VMID sum cout\nXdut VDD VDD VDD sum cout VDD VSS VMID full_adder\n.ends\n')
    with ThreadPoolExecutor(max_workers=3) as pool:
        f1=pool.submit(drc,gds,top.name,d/'drawing')
        f2=pool.submit(lvs,gds,ref,d/'lvs',top.name)
        f3=pool.submit(mask,gds,top.name,d/'manufacturing')
        result=dict(source_sha256=sha(source),scope='Separate fixture with all three external FA inputs tied to VDD; no waiver regions or changes to the functional FA.',
                    drc=f1.result(),lvs=f2.result(),mask_drc=f3.result())
    result['passed']=all(result[k]['passed'] for k in ('drc','lvs','mask_drc'))
    (ROOT/'reports/full_adder_driver.json').write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(result,indent=2),flush=True)
    return result


if __name__=='__main__':raise SystemExit(0 if check()['passed'] else 1)
