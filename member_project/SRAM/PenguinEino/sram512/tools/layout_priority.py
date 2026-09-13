#!/usr/bin/env python3
"""Route the analogue common lines first, then the remaining digital nets."""
import argparse,shutil
from layout_rectangular import build
from routing_poly import RouterPoly
from physical_top import named_macro,verify_and_repair
from common import *

def prepare(reuse_critical=False):
    layout,core,base,source=build(True)
    work=WORK/'layout/rectangular_priority';work.mkdir(parents=True,exist_ok=True)
    for name in ('placement.json','ports.json','array_geometry.json'):shutil.copy2(source/name,work/name)
    first=RouterPoly.from_router(base,550,extra_um=(2.75,3.3))
    selected={base.ids[n] for n in ('y','yb','preb')}
    first.pins={nid:base.pins[nid] for nid in selected}
    if reuse_critical:
        data=(work/'critical/routes.txt').read_text().splitlines();assert data[0]=='1'
        paths={};i=1
        while i<len(data):
            nid,n=map(int,data[i].split());i+=1
            paths[nid]=[tuple(map(int,s.split())) for s in data[i:i+n]];i+=n
        first.draw(paths)
    else:
        assert first.route(work/'critical',30,selective=True),'Critical common lines could not be routed.'
    for nid in selected:
        for k in range(2):base.regions[k][nid]+=first.drawn_regions[nid][k]
        base.pins[nid]=[]
        name=next(n for n,j in base.ids.items() if j==nid)
        trapezoids=first.drawn_regions[nid][1].decompose_trapezoids()
        pieces=[p.polygon.dup() for p in trapezoids.each()]
        assert pieces,name
        shape=max(pieces,key=lambda p:p.area())
        vertices=list(shape.each_point_hull())
        point=db.Point(round(sum(p.x for p in vertices)/len(vertices)),round(sum(p.y for p in vertices)/len(vertices)))
        assert shape.inside(point)
        core.shapes(layout.layer(49,0)).insert(db.Text(name.upper(),db.Trans(point)))
    core.write(str(work/'placed.gds'))
    return layout,core,base,work

def main(iterations,reuse_critical=False,critical_only=False):
    layout,core,router,work=prepare(reuse_critical)
    if critical_only:return True
    success=router.route(work/'routing',iterations,selective=True)
    top=named_macro(layout,core,work,array_y=118.2)
    result=verify_and_repair(layout,top,work);box=top.dbbox()
    result.update(router_passed=success,dimensions_um=[box.width(),box.height()],physical_rows=16,physical_columns=32)
    write_json(REPORTS/'layout_rectangular_priority.json',result)
    print(result['drc'],result['lvs'],result['dimensions_um'],flush=True)
    return success and all(result[k]['passed'] for k in ('drc','lvs')) and box.height()<=600+1e-6 and box.width()<=1800+1e-6

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('--iterations',type=int,default=600)
    p.add_argument('--reuse-critical',action='store_true');p.add_argument('--critical-only',action='store_true');a=p.parse_args()
    raise SystemExit(0 if main(a.iterations,a.reuse_critical,a.critical_only) else 1)
