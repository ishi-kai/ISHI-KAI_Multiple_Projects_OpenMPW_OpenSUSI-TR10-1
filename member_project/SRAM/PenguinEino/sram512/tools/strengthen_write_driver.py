#!/usr/bin/env python3
"""Widen the two common write pulldowns using the original dev PCells."""
import argparse,shutil
from common import *
from layout_analog import pc,mos
from geometry_audit import audit
from manufacturing import verify as mask_verify


def main(source):
    source=Path(source).resolve();work=WORK/'layout/final16x32_pd10p2'
    checks=json.loads((source/'checks/result.json').read_text())
    assert checks['gds_sha256']==sha(source/'sram512.gds')
    assert all(checks[k]['passed'] for k in ('drc','lvs'))
    work.mkdir(parents=True,exist_ok=True)
    l=db.Layout();l.read(str(source/'sram512.gds'));l.technology_name='TR-1um'
    top=l.cell('sram512_macro');cell=l.cell('sense_fixture')
    before={i:db.Region([p.dup() for p in db.Region(top.begin_shapes_rec(i)).each()])
            for i in l.layer_indexes() if l.get_info(i).layer not in (48,49)}
    targets=[i for i in cell.each_inst() if i.cell.name.startswith('fet_n') and i.dtrans.disp.x in (93.5,115.5)]
    assert len(targets)==2 and all(abs(i.dtrans.disp.y-6.8)<1e-6 for i in targets)
    for i in targets:i.delete()
    d=pc.Drawing(l,cell)
    for x in (93.5,115.5):mos(d,'n',x,6.8,10.2)
    # Wider source/drain pads leave narrow U-shaped gaps against their own
    # existing escape wires. Fill within each connected M1 polygon, then
    # independently recheck connectivity and every original spacing rule.
    pc.fill_metal_notches(l,l.cell('sram512'))
    changed={}
    for i,old in before.items():
        delta=old^db.Region(top.begin_shapes_rec(i))
        if delta.is_empty():continue
        spec=l.get_info(i)
        assert (spec.layer,spec.datatype) in ((3,2),(8,1),(11,0),(13,0)),spec
        changed[str(spec)]=delta.area()*l.dbu*l.dbu
    for name in ('placement.json','ports.json','coordinate_frames.json','array_geometry.json'):
        shutil.copy2(source/name,work/name)
    generated=netlist(ROOT/'sram512/schematics/sram512_macro.sch',work/'schematic',lvs=True)
    text=re.sub(r'(?im)^X(\S+)(\s+\S+\s+\S+\s+\S+\s+\S+\s+(?:NMOS|PMOS)\b)',r'M\1\2',generated.read_text())
    ref=work/'reference.spice';ref.write_text(text);path=work/'sram512.gds';top.write(str(path))
    result=verify_layout(path,top.name,ref,work/'checks')
    result.update(source_gds_sha256=checks['gds_sha256'],write_pulldown_width_um=10.2,
                  changed_devices=2,changed_geometry_um2=changed)
    write_json(work/'result.json',result);print(result['drc'],result['lvs'],flush=True)
    if not all(result[k]['passed'] for k in ('drc','lvs')):return result
    result['geometry']=audit(work,require_origin=True)
    result['manufacturing']=mask_verify(work);result['passed']=result['manufacturing']['passed']
    write_json(work/'result.json',result);write_json(REPORTS/'write_driver_strengthening.json',result)
    return result


if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('source',type=Path);a=p.parse_args()
    raise SystemExit(0 if main(a.source).get('passed',False) else 1)
