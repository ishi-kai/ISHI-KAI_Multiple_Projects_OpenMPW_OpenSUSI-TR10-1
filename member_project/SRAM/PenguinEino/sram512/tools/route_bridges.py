#!/usr/bin/env python3
"""Replace actual wire crossings with contact-connected metal overpasses.

Only routed conductors and their contacts change. Native cells, checking
decks and schematic connections remain untouched; final strict LVS and
official DRC, including failing candidates, are always recorded.
"""
import argparse,shutil
from collections import defaultdict
from common import *
from layout_rectangular import build
from routing_poly import route_connectivity
from route_local import read_paths
from repair_poly_crossings import route_shapes
from physical_top import named_macro,verify_and_repair

def main(source):
    source=Path(source).resolve();l,core,r,original=build(True,True)
    info=json.loads((source/'routing/routing.json').read_text())
    assert info['grid_um']==r.step/1000 and info['node_names']=={str(v):k for k,v in r.ids.items()}
    assert json.loads((source/'placement.json').read_text())==json.loads((original/'placement.json').read_text())
    old=db.Layout();old.read(str(source/'placed.gds'))
    for li in l.layer_indexes():
        spec=l.get_info(li)
        assert (db.Region(core.begin_shapes_rec(li))^
                db.Region(old.cell('sram512').begin_shapes_rec(old.layer(spec)))).is_empty(),spec
    paths=read_paths(source/'routing/routes.txt');names={v:k for k,v in r.ids.items()};plane=r.nx*r.ny
    native=[db.Region(core.begin_shapes_rec(l.layer(*layer))) for layer in ((13,0),(20,0),(8,1))]
    active=db.Region(core.begin_shapes_rec(l.layer(3,1)))+db.Region(core.begin_shapes_rec(l.layer(3,2)))
    nativecuts=[db.Region(core.begin_shapes_rec(l.layer(*layer))) for layer in ((19,0),(11,0))]
    shapes={n:route_shapes(r,e) for n,e in paths.items()};owners=defaultdict(set)
    for nid,edges in paths.items():
        for e in edges:
            for u in e:owners[u].add(nid)
    crosses=sorted((u for u,ids in owners.items() if len(ids)>1),key=lambda u:-u//plane)
    offsets=[(0,0)]+[(dx*m*r.step,dy*m*r.step) for m in range(1,9) for dx,dy in ((0,1),(0,-1),(1,0),(-1,0))]
    changes=[]
    def unit_nodes(k,a,b):
        assert a.x==b.x or a.y==b.y
        dx=(b.x>a.x)-(b.x<a.x);dy=(b.y>a.y)-(b.y<a.y)
        steps=(abs(a.x-b.x)+abs(a.y-b.y))//r.step
        return [k*plane+((a.y+i*dy*r.step)//r.step)*r.nx+(a.x+i*dx*r.step)//r.step for i in range(steps+1)]
    for u in crosses:
        current=[nid for nid in owners[u] if any(u in e for e in paths[nid])]
        if len(current)<2:continue
        repaired=False
        for nid in sorted(current,key=lambda n:len(paths[n])):
            layer,point=r.point(u)
            if layer not in (1,2):continue
            adjacent=defaultdict(set)
            for a,b in paths[nid]:adjacent[a].add(b);adjacent[b].add(a)
            if len(adjacent[u])!=2:continue
            arms=[]
            for first in adjacent[u]:
                arm=[u];v=first
                while v//plane==layer and len(arm)<24:
                    arm.append(v)
                    if len(adjacent[v])!=2:break
                    v=next(iter(adjacent[v]-{arm[-2]}))
                arms.append(arm)
            if len(arms)!=2:continue
            kind=1 if layer==2 else 0;half=1300 if kind else 1700;cut_half=500 if kind else 700
            foreign=[native[k]-(r.regions[k].get(nid,db.Region()) if k<2 else db.Region())+
                     sum((s[0][k] for n,s in shapes.items() if n!=nid),db.Region()) for k in range(3)]
            allcuts=[nativecuts[k]+sum((s[1][k] for s in shapes.values()),db.Region()) for k in range(2)]
            allgc=native[2]+sum((s[0][2] for s in shapes.values()),db.Region())
            choices=sorted(((a,b) for a in range(2,len(arms[0])) for b in range(2,len(arms[1]))),key=lambda t:sum(t))
            for ai,bi in choices:
                chain=list(reversed(arms[0][:ai+1]))+arms[1][1:bi+1]
                pts=[r.point(v)[1] for v in chain]
                original_wire=db.Region(db.Path(pts,(3400 if layer==1 else 1000)).polygon())
                if layer==1 and not (original_wire&native[1]).is_empty():continue
                removed={frozenset(e) for e in zip(chain,chain[1:])}
                for dx,dy in offsets:
                    moved=[db.Point(p.x+dx,p.y+dy) for p in pts]
                    if any(p.x<1700 or p.x>1795300 or p.y<1700 or p.y>596600 for p in moved):continue
                    extra=[db.Region(),db.Region(),db.Region()]
                    extra[0].insert(db.Path(moved,1800,900,900).polygon())
                    pads=db.Region();cuts=db.Region()
                    for p in (moved[0],moved[-1]):
                        pads.insert(db.Box(p.x-half,p.y-half,p.x+half,p.y+half))
                        cuts.insert(db.Box(p.x-cut_half,p.y-cut_half,p.x+cut_half,p.y+cut_half))
                    extra[0]+=pads;extra[layer]+=pads
                    w=3400 if layer==1 else 1000
                    for a,b in ((pts[0],moved[0]),(pts[-1],moved[-1])):
                        extra[layer].insert(db.Path([a,b],w,w//2,w//2).polygon())
                    if any(not (extra[k].sized((1450,2050,1250)[k])&foreign[k]).is_empty() for k in range(3)):continue
                    if not (extra[2].sized(450)&active).is_empty():continue
                    if kind:
                        if not (pads.sized(1250)&allcuts[0]).is_empty():continue
                        if not (cuts.sized(1050)&allcuts[1]).is_empty():continue
                    else:
                        if not (cuts.sized(1250)&allgc).is_empty():continue
                        if not (cuts.sized(1550)&allcuts[0]).is_empty():continue
                        if not (cuts.sized(50)&allcuts[1]).is_empty():continue
                    keep=[e for e in paths[nid] if frozenset(e) not in removed]
                    assert len(paths[nid])-len(keep)==len(chain)-1
                    for k,ps in [(0,moved),(layer,[pts[0],moved[0]]),(layer,[pts[-1],moved[-1]])]:
                        for a,b in zip(ps,ps[1:]):keep+=list(zip((ns:=unit_nodes(k,a,b)),ns[1:]))
                    for p in (moved[0],moved[-1]):
                        base=(p.y//r.step)*r.nx+p.x//r.step;keep.append((base,base+layer*plane))
                    paths[nid]=keep;shapes[nid]=route_shapes(r,keep);repaired=True
                    changes.append(dict(net=names[nid],from_layer=('M2' if layer==1 else 'GC'),to_layer='M1',
                        crossing_um=[point.x/1000,point.y/1000],contact_positions_um=[[p.x/1000,p.y/1000] for p in (moved[0],moved[-1])],
                        offset_um=[dx/1000,dy/1000],replaced_edges=len(removed)))
                    print(changes[-1],flush=True);break
                if repaired:break
            if repaired:break
        if not repaired:print('No clear bridge',r.point(u),[names[n] for n in current],flush=True)
    _,_,_,pins=r.prepare();connectivity=route_connectivity(pins,paths)
    assert connectivity['passed'],connectivity
    work=source.with_name(source.name+'_bridges');work.mkdir(parents=True,exist_ok=True);(work/'routing').mkdir(exist_ok=True)
    for name in ('placement.json','ports.json','array_geometry.json','placed.gds'):shutil.copy2(source/name,work/name)
    for name in ('router.bin','routing_input.json'):shutil.copy2(source/'routing'/name,work/'routing'/name)
    output=['0']
    for nid,edges in paths.items():output.append(f'{nid} {len(edges)}');output.extend(f'{a} {b}' for a,b in edges)
    (work/'routing/routes.txt').write_text('\n'.join(output)+'\n')
    info.update(source_search_passed=info['passed'],passed=False,physical_bridges=changes,
                graph_connectivity=connectivity,gc_routes=r.draw(paths))
    write_json(work/'routing/routing.json',info)
    top=named_macro(l,core,work,array_y=118.2);result=verify_and_repair(l,top,work);box=top.dbbox()
    result.update(physical_bridges=changes,graph_connectivity=connectivity,
                  dimensions_um=[box.width(),box.height()],source=str(source))
    write_json(work/'result.json',result)
    print(result['drc'],result['lvs'],result['dimensions_um'],flush=True)
    return all(result[k]['passed'] for k in ('drc','lvs'))

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('source',type=Path);a=p.parse_args()
    raise SystemExit(0 if main(a.source) else 1)
