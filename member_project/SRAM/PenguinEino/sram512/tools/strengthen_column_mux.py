#!/usr/bin/env python3
"""Replace only the column pass PCells in a routed, checked SRAM.

The 64 pass NMOS become W=5.1/L=1 um using the unmodified PDK PCell.
Moving their centers 0.85 um south preserves the north active edge and
well spacing. All parent routing, bitcells and other devices stay fixed.
The current editable Xschem hierarchy is the independent LVS reference.
"""
import argparse,shutil
from layout_analog import pc,mos
from common import *
from geometry_audit import audit
from manufacturing import verify as mask_verify


def main(source):
    source=Path(source).resolve();work=WORK/'layout/final16x32_mux5p1'
    checks=json.loads((source/'checks/result.json').read_text())
    assert all(checks[k]['passed'] for k in ('drc','lvs'))
    assert sha(source/'sram512.gds')==checks['gds_sha256']
    work.mkdir(parents=True,exist_ok=True)
    l=db.Layout();l.read(str(source/'sram512.gds'));l.technology_name='TR-1um'
    tile=l.cell('sram512_column_tile');top=l.cell('sram512_macro')
    assert tile is not None
    old={i:db.Region([p.dup() for p in db.Region(top.begin_shapes_rec(i)).each()])
         for i in l.layer_indexes() if l.get_info(i).layer not in (48,49)}
    targets=[i for i in tile.each_inst() if i.cell.name.startswith('fet_n')]
    assert len(targets)==2
    assert sorted([i.dtrans.disp.x for i in targets])==[2,16]
    assert all(abs(i.dtrans.disp.y)<1e-6 for i in targets)
    for inst in targets:inst.delete()
    drawing=pc.Drawing(l,tile)
    for x in (2,16):mos(drawing,'n',x,-.85,5.1)
    # Only PCell active, gate, contacts and local M1 may change. All wells,
    # M2, vias, and parent routes remain fixed.
    changed={}
    for i,before in old.items():
        delta=before^db.Region(top.begin_shapes_rec(i))
        if delta.is_empty():continue
        number=l.get_info(i).layer
        assert (number,l.get_info(i).datatype) in ((3,2),(8,1),(11,0),(13,0)),(number,'unexpected changed layer')
        changed[str(l.get_info(i))]=delta.area()*l.dbu*l.dbu
    assert changed
    for name in ('placement.json','array_geometry.json','ports.json','coordinate_frames.json'):
        shutil.copy2(source/name,work/name)
    generated=netlist(ROOT/'sram512/schematics/sram512_macro.sch',work/'schematic',lvs=True)
    text=re.sub(r'(?im)^X(\S+)(\s+\S+\s+\S+\s+\S+\s+\S+\s+(?:NMOS|PMOS)\b)',r'M\1\2',generated.read_text())
    ref=work/'reference.spice';ref.write_text(text)
    path=work/'sram512.gds';top.write(str(path))
    result=verify_layout(path,top.name,ref,work/'checks')
    result.update(source_gds_sha256=checks['gds_sha256'],column_mux_width_um=5.1,
                  modified_pass_devices=64,changed_geometry_um2=changed,
                  reason='Restore write strength when the selected wordline rises slowly.')
    write_json(work/'result.json',result)
    print(result['drc'],result['lvs'],flush=True)
    if not all(result[k]['passed'] for k in ('drc','lvs')):return result
    result['geometry']=audit(work,require_origin=True)
    result['manufacturing']=mask_verify(work)
    result['passed']=result['manufacturing']['passed']
    write_json(work/'result.json',result)
    write_json(REPORTS/'column_mux_strengthening.json',result)
    return result


if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('source',type=Path);a=p.parse_args()
    raise SystemExit(0 if main(a.source).get('passed',False) else 1)
