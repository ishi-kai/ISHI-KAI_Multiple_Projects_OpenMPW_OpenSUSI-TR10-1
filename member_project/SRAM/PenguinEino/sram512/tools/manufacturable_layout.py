#!/usr/bin/env python3
"""Separate diode implant edges by changing the actual device placement.

The compact input cell's junction dimensions stay 3.6 x 3.6 um. Moving its
two junctions vertically avoids the adjacent logic-cell implant edges.
The actual well boundary is adjusted with full drawing/mask DRC and LVS.
"""
import shutil
from common import *


def main():
    source=WORK/'layout/rectangular_final_drawing'
    work=WORK/'layout/rectangular_manufacturable'
    work.mkdir(parents=True,exist_ok=True)
    l=db.Layout();l.read(str(source/'sram512.gds'))
    top=l.cell('sram512_macro');core=l.cell('sram512')
    wn=l.layer(140,0)
    for name in ('DFFR','MUX2','BUF_X4','INV_X1','sram512_input_clamp'):
        c=l.cell(name)
        before=db.Region(c.begin_shapes_rec(wn))
        local=db.Region(c.shapes(wn))
        assert (before^local).is_empty(),name
        after=before & db.Region(db.Box(-100000,25000,200000,100000))
        c.shapes(wn).clear();c.shapes(wn).insert(after)
    clamp=l.cell('sram512_input_clamp')
    original_clamp_m1=db.Region([p.dup() for p in
        db.Region(clamp.begin_shapes_rec(l.layer(13,0))).each()])
    moved=[]
    for inst in list(clamp.each_inst()):
        name=inst.cell.name
        if name not in ('diode_p','diode_n'):continue
        old=inst.trans;new_y=34000 if name=='diode_p' else 13050
        inst.trans=db.Trans(old.rot,old.is_mirror(),old.disp.x,new_y)
        moved.append(dict(device=name,old_y_um=old.disp.y/1000,new_y_um=new_y/1000))
    assert len(moved)==2
    # Existing signal routes land on the original diode metal. Keep those
    # connected pads while moving only the junctions and their contacts.
    clamp.shapes(l.layer(13,0)).insert(original_clamp_m1)
    clamp.shapes(l.layer(13,0)).insert(db.Box(6450,32200,10050,40300))
    placements=json.loads((source/'placement.json').read_text())
    cuts=db.Region()
    for p in placements:
        if p['kind']=='sram512_input_clamp':
            x,y=p['x'],p['y']
            cuts.insert(db.DBox(x-3.55,y+23.2,x+30,y+25).to_itype(.001))
    before=db.Region(core.shapes(wn))
    core.shapes(wn).clear();core.shapes(wn).insert(before-cuts)
    # Allow the generated N-well mask's 1.5 um extension at the top edge.
    # Remove one redundant well contact from the AND3 rail, leaving its
    # other five contacts, and trim only that now-free 0.4 um well margin.
    # All MOS and all M1/M2/gate routing remain at their original positions.
    driver=l.cell('AND3_X1')
    an=l.layer(3,2);co=l.layer(11,0)
    for index,box in [(an,db.Box(-1300,53700,1300,56300)),
                      (co,db.Box(-500,54500,500,55500))]:
        shapes=db.Region(driver.shapes(index));cut=db.Region(box)
        assert (shapes&cut).area()==cut.area()
        driver.shapes(index).clear();driver.shapes(index).insert(shapes-cut)
    well=db.Region(driver.shapes(wn))
    driver.shapes(wn).clear()
    driver.shapes(wn).insert(well & db.Region(db.Box(-5900,-100000,100000,100000)))
    for name in ('ports.json','array_geometry.json','reference.spice'):
        shutil.copy2(source/name,work/name)
    write_json(work/'placement.json',placements)
    gds=work/'sram512.gds';top.write(str(gds))
    result=verify_layout(gds,top.name,work/'reference.spice',work/'checks')
    result.update(source_gds_sha256=sha(source/'sram512.gds'),diode_moves=moved,
                  well_lower_boundary_um=25.0,
                  and3_well_contact_removed_um=[0,55],and3_well_left_trim_um=.4)
    write_json(work/'result.json',result)
    print(result['drc'],result['lvs'],flush=True)
    return result


if __name__=='__main__':
    result=main()
    raise SystemExit(0 if all(result[k]['passed'] for k in ('drc','lvs')) else 1)
