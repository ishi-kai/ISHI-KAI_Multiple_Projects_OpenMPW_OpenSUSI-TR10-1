#!/usr/bin/env python3
"""Physical well, supply landing and boundary terminal completion.

Only process drawing geometry and real port labels are changed. The original
dev DRC and strict LVS are run again on every candidate, including failures.
"""
import argparse
from collections import defaultdict
from common import *
from physical_top import verify_and_repair

def finish(folder,source=None):
    folder=Path(folder).resolve();work=WORK/'layout'/(folder.name+'_finished')
    work.mkdir(parents=True,exist_ok=True)
    layout=db.Layout();layout.read(str(source or folder/'sram512.gds'))
    top=layout.cell('sram512_macro');core=layout.cell('sram512')
    original=db.Layout();original.read(str(WORK/'layout/input_clamp_compact_row/cell.gds'))
    clamp=layout.cell('sram512_input_clamp')
    # Existing routes may land on the original diode's M1 pad. Preserve
    # that real connected metal when moving only the junction downwards.
    old_m1=db.Region(clamp.begin_shapes_rec(layout.layer(13,0)))
    clamp.clear()
    clamp.copy_tree(original.cell('sram512_input_clamp'))
    clamp.shapes(layout.layer(13,0)).insert(old_m1)
    placements=json.loads((folder/'placement.json').read_text());rows=defaultdict(list)
    for p in placements:
        if p['instance'].startswith('bank') or p['instance']=='sense':continue
        assert not p.get('mirror',False)
        pitch=layout.cell(p['kind']).dbbox().width()-12.6
        rows[p['y']].append((p['x'],p['x']+pitch))
    fills=[]
    for y,cells in rows.items():
        groups=[]
        for x,end in sorted(cells):
            if groups and abs(x-groups[-1][1])<.01:groups[-1][1]=end
            else:groups.append([x,end])
        for x,end in groups:
            box=db.DBox(x-6.3,y+23.2,end+6.3,y+66.8).to_itype(layout.dbu)
            core.shapes(layout.layer(140,0)).insert(box);fills.append(str(box))
    # Extend real M2 to enclose the lowest VSS via and expose both supplies
    # at the top boundary. No extra input or signal pin is introduced.
    powers={}
    for name,x in [('VDD',1320),('VSS',1342)]:
        core.shapes(layout.layer(20,0)).insert(db.DBox(x-7,87.0,x+7,598.3).to_itype(layout.dbu))
        for cell in (core,top):
            for layer in (48,49):
                shapes=cell.shapes(layout.layer(layer,0))
                for shape in list(shapes.each()):
                    if shape.is_text() and shape.text.string.upper()==name:shapes.erase(shape)
            cell.shapes(layout.layer(49,0)).insert(db.Text(name,db.Trans(round(x*1000),595600)))
        powers[name]=dict(layer='M2',landing_um=[x-7,592.3,x+7,598.3],label_um=[x,595.6])
    result=verify_and_repair(layout,top,work)
    box=top.dbbox();result.update(source=str(source or folder/'sram512.gds'),
        bbox_um=[box.left,box.bottom,box.right,box.top],
        dimensions_um=[box.width(),box.height()],
        dimensions_passed=box.width()<=1800+1e-6 and box.height()<=600+1e-6,
        clamp_variant='input_clamp_compact_row',well_fills_nm=fills,power_terminals=powers)
    write_json(work/'completion.json',result)
    print(result['drc'],result['lvs'],result['dimensions_um'],flush=True)
    return result

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('folder',type=Path);p.add_argument('--source',type=Path)
    a=p.parse_args();result=finish(a.folder,a.source)
    raise SystemExit(0 if result['dimensions_passed'] and all(result[k]['passed'] for k in ('drc','lvs')) else 1)
