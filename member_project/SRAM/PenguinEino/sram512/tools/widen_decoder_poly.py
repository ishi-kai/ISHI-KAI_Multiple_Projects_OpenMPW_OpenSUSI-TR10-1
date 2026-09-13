#!/usr/bin/env python3
"""Widen actual long field-GC conductors within the unused legal space."""
import argparse,shutil
from common import *
from postlayout import observation_name


def main(source,name,growth_um=.4):
    source=Path(source).resolve();old=json.loads((source/'checks/result.json').read_text())
    assert old['gds_sha256']==sha(source/'sram512.gds')
    assert all(old[k]['passed'] for k in ('drc','lvs'))
    layout=db.Layout();layout.read(str(source/'sram512.gds'))
    core=layout.cell('sram512');top=layout.cell('sram512_macro')
    original=layout.cell('pcell_core')
    before={i:db.Region(original.begin_shapes_rec(i)) for i in layout.layer_indexes()}
    extraction=db.LayoutVsSchematic();extraction.read(str(source/'checks/sram512_macro.lvsdb'))
    circuit=extraction.netlist().circuit_by_name('sram512')
    nets={observation_name(p.second().name):p.first() for p in extraction.xref().each_net_pair(circuit)
          if p.first() is not None and p.second() is not None}
    specs=((8,1),(11,0));indexes=[extracted_layer_index(extraction,layout,core,s) for s in specs]
    active=(db.Region(core.begin_shapes_rec(layout.layer(3,1)))+
            db.Region(core.begin_shapes_rec(layout.layer(3,2)))).merged()
    contacts=db.Region(core.begin_shapes_rec(layout.layer(11,0))).merged()
    vias=db.Region(core.begin_shapes_rec(layout.layer(19,0))).merged()
    radius=round(growth_um*1000);assert radius>0 and radius%50==0
    changes=[]
    for name_ in ('ca2b','ra0'):
        own,own_contacts=[extraction.polygons_of_net(nets[name_],i,True).merged() for i in indexes]
        actual=db.Region(core.begin_shapes_rec(layout.layer(8,1))).merged()
        forbidden=((actual-own).sized(1250)+active.sized(450)+
                   (contacts-own_contacts).sized(1050)+vias.sized(1250)).merged()
        bridges=db.Region([p for p in own.each() if max(p.bbox().width(),p.bbox().height())>10000
                           and (db.Region(p)&active).is_empty()])
        addition=((bridges.sized(radius)-own)-forbidden).merged()
        restored=[]
        if name_=='ca2b':
            # Keep the existing compact upper elbow at its original width.
            # Partially widening that elbow makes narrow local notches;
            # widen the long isolated portions of the conductor instead.
            restored=[(1030.,208.,1085.,226.)]
            for bounds in restored:
                addition-=db.Region(db.Box(*(round(v*1000) for v in bounds)))
        assert not addition.is_empty(),name_
        core.shapes(layout.layer(8,1)).insert(addition)
        change=dict(net=name_,maximum_lateral_growth_um=growth_um,
                    original_field_bridge_area_um2=bridges.area()*1e-6,
                    added_gc_area_um2=addition.area()*1e-6,gate_channel_modified=False,
                    original_width_restored_at_um=restored)
        changes.append(change);print(change,flush=True)
    assert all((r^db.Region(original.begin_shapes_rec(i))).is_empty() for i,r in before.items())
    assert top.dbbox().width()<=1800 and top.dbbox().height()<=600
    work=WORK/'layout'/name;work.mkdir(parents=True,exist_ok=True)
    for filename in ('placement.json','ports.json','coordinate_frames.json','array_geometry.json','reference.spice'):
        shutil.copy2(source/filename,work/filename)
    gds=work/'sram512.gds';top.write(str(gds))
    result=verify_layout(gds,top.name,work/'reference.spice',work/'checks')
    result.update(source_gds_sha256=old['gds_sha256'],field_gc_widening=changes)
    result['passed']=all(result[k]['passed'] for k in ('drc','lvs'))
    write_json(work/'decoder_changes.json',result)
    print(result['drc'],result['lvs'],flush=True)
    return result


if __name__=='__main__':
    parser=argparse.ArgumentParser();parser.add_argument('source',type=Path)
    parser.add_argument('--name',default='decoder_gcwide16x32');parser.add_argument('--growth-um',type=float,default=.4)
    args=parser.parse_args();raise SystemExit(0 if main(args.source,args.name,args.growth_um)['passed'] else 1)
