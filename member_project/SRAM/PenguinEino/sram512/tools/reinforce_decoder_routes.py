#!/usr/bin/env python3
"""Add legal metal shunts to long decoder GC routes, retaining the original wires."""
import argparse
import shutil
from itertools import combinations
from common import *
from postlayout import observation_name
from layout_analog import pc


def rectangle_points(box):
    return [(box.left,box.bottom),(box.right,box.bottom),(box.right,box.top),(box.left,box.top)]


def candidates(a,b,foreign,box):
    """Two-bend routes on the actual 50 nm drawing grid, including narrow gaps."""
    yield [a,db.Point(b.x,a.y),b]
    yield [a,db.Point(a.x,b.y),b]
    x={a.x,b.x};y={a.y,b.y}
    nearby=(foreign & db.Region(box.enlarged(15000))).merged()
    for polygon in nearby.each():
        for point in polygon.each_point_hull():
            for delta in (-2350,2350):
                x.add(50*round((point.x+delta)/50))
                y.add(50*round((point.y+delta)/50))
    x={v for v in x if box.left-15000<=v<=box.right+15000}
    y={v for v in y if box.bottom-15000<=v<=box.top+15000}
    for mid in sorted(y,key=lambda v:abs(v-a.y)+abs(v-b.y)):
        yield [a,db.Point(a.x,mid),db.Point(b.x,mid),b]
    for mid in sorted(x,key=lambda v:abs(v-a.x)+abs(v-b.x)):
        yield [a,db.Point(mid,a.y),db.Point(mid,b.y),b]


def main(source,name):
    source=Path(source).resolve();old=json.loads((source/'checks/result.json').read_text())
    assert old['gds_sha256']==sha(source/'sram512.gds')
    assert all(old[k]['passed'] for k in ('drc','lvs'))
    layout=db.Layout();layout.read(str(source/'sram512.gds'))
    core=layout.cell('sram512');top=layout.cell('sram512_macro')
    cell=layout.cell('pcell_core')
    before={i:db.Region(cell.begin_shapes_rec(i)) for i in layout.layer_indexes()}
    extraction=db.LayoutVsSchematic();extraction.read(str(source/'checks/sram512_macro.lvsdb'))
    circuit=extraction.netlist().circuit_by_name('sram512')
    nets={observation_name(p.second().name):p.first() for p in extraction.xref().each_net_pair(circuit)
          if p.first() is not None and p.second() is not None}
    specs=[(8,1),(13,0),(11,0)]
    idx=[extracted_layer_index(extraction,layout,core,s) for s in specs]
    active=(db.Region(core.begin_shapes_rec(layout.layer(3,1)))+
            db.Region(core.begin_shapes_rec(layout.layer(3,2)))).merged()
    changes=[]
    for netname in ('xcol_decode.cl0','ca2b','ra0'):
        gc,own,contacts=[extraction.polygons_of_net(nets[netname],i,True).merged() for i in idx]
        actual=db.Region(core.begin_shapes_rec(layout.layer(13,0))).merged()
        foreign=(actual-own).merged();keepout=foreign.sized(1400)
        bridges=sorted([p for p in gc.each() if (db.Region(p)&active).is_empty()],
                       key=lambda p:-p.area())
        for polygon in bridges:
            hits=[p.bbox().center() for p in contacts.interacting(db.Region(polygon)).each()]
            pairs=sorted(combinations(hits,2),key=lambda ab:-(abs(ab[0].x-ab[1].x)+abs(ab[0].y-ab[1].y)))
            if not pairs:continue
            options=[]
            # CL0 is the lowest bus; the free M1 corridor lies 0.45 um
            # below its existing GC centerline, inside the same core box.
            if netname=='xcol_decode.cl0' and polygon.bbox().top==1300:
                a=min(hits,key=lambda p:p.x);b=max(hits,key=lambda p:p.x)
                options.append([a,db.Point(a.x,-450),db.Point(b.x,-450),b])
            else:
                for a,b in pairs:
                    if abs(a.x-b.x)+abs(a.y-b.y)<10000:continue
                    options.extend(candidates(a,b,foreign,polygon.bbox()))
            for points in options:
                points=[p for i,p in enumerate(points) if not i or p!=points[i-1]]
                route=db.Region(db.Path(points,1800,900,900).polygon())
                addition=(route-own).merged()
                if addition.is_empty() or not (addition&keepout).is_empty():continue
                bounds=route.bbox()
                if bounds.bottom < -1700 or bounds.top>598300:continue
                core.shapes(layout.layer(13,0)).insert(route)
                own+=route
                change=dict(net=netname,source_gc_bbox_um=[v/1000 for v in
                            (polygon.bbox().left,polygon.bbox().bottom,polygon.bbox().right,polygon.bbox().top)],
                            points_um=[[p.x/1000,p.y/1000] for p in points],
                            added_m1_area_um2=addition.area()*1e-6,width_um=1.8)
                changes.append(change);print(change,flush=True)
                break
            else:print('No two-bend shunt:',netname,polygon.bbox(),flush=True)
    assert changes
    pc.fill_metal_notches(layout,core)
    assert all((r^db.Region(cell.begin_shapes_rec(i))).is_empty() for i,r in before.items())
    assert top.dbbox().width()<=1800 and top.dbbox().height()<=600
    work=WORK/'layout'/name;work.mkdir(parents=True,exist_ok=True)
    for filename in ('placement.json','ports.json','coordinate_frames.json','array_geometry.json','reference.spice'):
        shutil.copy2(source/filename,work/filename)
    gds=work/'sram512.gds';top.write(str(gds))
    result=verify_layout(gds,top.name,work/'reference.spice',work/'checks')
    result.update(source_gds_sha256=old['gds_sha256'],metal_shunts=changes)
    result['passed']=all(result[k]['passed'] for k in ('drc','lvs'))
    write_json(work/'decoder_changes.json',result)
    print(result['drc'],result['lvs'],flush=True)
    return result


if __name__=='__main__':
    parser=argparse.ArgumentParser();parser.add_argument('source',type=Path)
    parser.add_argument('--name',default='decoder_shunts16x32')
    args=parser.parse_args();raise SystemExit(0 if main(args.source,args.name)['passed'] else 1)
