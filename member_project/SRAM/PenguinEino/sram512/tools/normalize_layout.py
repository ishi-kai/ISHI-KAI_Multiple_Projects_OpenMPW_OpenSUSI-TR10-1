#!/usr/bin/env python3
"""Give the checked seven-port macro a nonnegative submission origin."""
import argparse,shutil
from common import *


def normalize(source):
    source=Path(source).resolve();work=WORK/'layout/final16x32'
    checks=json.loads((source/'checks/result.json').read_text())
    assert all(checks[k]['passed'] for k in ('drc','lvs'))
    assert checks['gds_sha256']==sha(source/'sram512.gds')
    l=db.Layout();l.read(str(source/'sram512.gds'));top=l.cell('sram512_macro')
    box=top.bbox();offset=db.Trans(-box.left,-box.bottom)
    before={i:db.Region([p.dup() for p in db.Region(top.begin_shapes_rec(i)).each()])
            for i in l.layer_indexes() if l.get_info(i).layer not in (48,49)}
    top.transform(offset)
    for i,region in before.items():
        assert (region.transformed(offset)^db.Region(top.begin_shapes_rec(i))).is_empty()
    bbox=top.dbbox()
    assert bbox.left>=0 and bbox.bottom>=0 and bbox.right<=1800+1e-6 and bbox.top<=600+1e-6
    work.mkdir(parents=True,exist_ok=True)
    for name in ('reference.spice','placement.json','array_geometry.json'):
        shutil.copy2(source/name,work/name)
    pins={}
    for number in (48,49):
        for shape in top.shapes(l.layer(number,0)).each():
            if shape.is_text():
                label=shape.text;point=label.trans.disp
                pins[label.string]=dict(layer=f'M{number-47}',position_um=[point.x/1000,point.y/1000])
    assert set(pins)=={'CLK','RESET','SDI','WE','SDO','VDD','VSS'}
    write_json(work/'ports.json',pins)
    write_json(work/'coordinate_frames.json',dict(
        core_to_submission_offset_um=[offset.disp.x/1000,offset.disp.y/1000],
        placement_and_array_geometry_frame='sram512 internal cell',ports_frame='sram512_macro submission top'))
    gds=work/'sram512.gds';top.write(str(gds))
    result=verify_layout(gds,top.name,work/'reference.spice',work/'checks')
    result.update(source_gds_sha256=checks['gds_sha256'],translation_only=True,
                  dimensions_um=[bbox.width(),bbox.height()],bbox_um=[bbox.left,bbox.bottom,bbox.right,bbox.top],pins=pins)
    write_json(work/'result.json',result)
    print(result['drc'],result['lvs'],result['dimensions_um'],flush=True)
    return work,result


if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('source',type=Path);a=p.parse_args()
    _,r=normalize(a.source)
    raise SystemExit(0 if all(r[k]['passed'] for k in ('drc','lvs')) else 1)
