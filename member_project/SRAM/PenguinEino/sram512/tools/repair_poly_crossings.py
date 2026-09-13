#!/usr/bin/env python3
"""Replace a conflicting GC segment with a real M1 overpass and two COs.

Only actual routed geometry changes. Candidate bridges must fit the original
process clearances; final unchanged-deck DRC and strict LVS are mandatory.
"""
import argparse,shutil,struct
from collections import defaultdict
from detail_route import restore
from routing_poly import RouterPoly
from physical_top import named_macro,verify_and_repair
from common import *

def route_shapes(r,edges):
    regions=[db.Region(),db.Region(),db.Region()];cuts=[db.Region(),db.Region()]
    for a,b in edges:
        ka,pa=r.point(a);kb,pb=r.point(b)
        if ka==kb:
            w=(1800,3400,1000)[ka];regions[ka].insert(db.Path([pa,pb],w,w//2,w//2).polygon())
        else:
            kind=int(ka==2 or kb==2);half=1300 if kind else 1700
            for k in ((0,2) if kind else (0,1)):regions[k].insert(db.Box(pa.x-half,pa.y-half,pa.x+half,pa.y+half))
            half=500 if kind else 700;cuts[kind].insert(db.Box(pa.x-half,pa.y-half,pa.x+half,pa.y+half))
    return regions,cuts

def repair(folder):
    folder=Path(folder).resolve();info=json.loads((folder/'routing/routing.json').read_text())
    assert info['conductors']==['M1','M2','GC']
    l,top,original=restore(folder,info);r=RouterPoly.from_router(original,round(info['grid_um']*1000))
    lines=(folder/'routing/routes.txt').read_text().splitlines();i=1;paths={};owners=defaultdict(set)
    plane=r.nx*r.ny
    while i<len(lines):
        nid,n=map(int,lines[i].split());i+=1
        paths[nid]=[tuple(map(int,s.split())) for s in lines[i:i+n]];i+=n
        for edge in paths[nid]:
            for u in edge:
                if u//plane==2:owners[u].add(nid)
    crossings=[u for u,ids in owners.items() if len(ids)>1]
    print('GC crossings',len(crossings),flush=True)
    names={int(k):v for k,v in info['node_names'].items()}
    native=[db.Region(top.begin_shapes_rec(l.layer(*layer))) for layer in ((13,0),(20,0),(8,1))]
    active=db.Region(top.begin_shapes_rec(l.layer(3,1)))+db.Region(top.begin_shapes_rec(l.layer(3,2)))
    nativecuts=[db.Region(top.begin_shapes_rec(l.layer(*layer))) for layer in ((19,0),(11,0))]
    shapes={nid:route_shapes(r,edges) for nid,edges in paths.items()};changes=[]
    for u in crossings:
        done=False
        for nid in sorted(owners[u]):
            adjacent=defaultdict(set)
            for a,b in paths[nid]:adjacent[a].add(b);adjacent[b].add(a)
            if len(adjacent[u])!=2:continue
            arms=[]
            for first in adjacent[u]:
                arm=[u];v=first
                while v//plane==2 and len(arm)<10:
                    arm.append(v)
                    if len(adjacent[v])!=2:break
                    v=next(iter(adjacent[v]-{arm[-2]}))
                arms.append(arm)
            block_m1=native[0]+sum((s[0][0] for k,s in shapes.items() if k!=nid),db.Region())
            foreign_gc=native[2]+sum((s[0][2] for k,s in shapes.items() if k!=nid),db.Region())
            allvia=nativecuts[0]+sum((s[1][0] for s in shapes.values()),db.Region())
            allco=nativecuts[1]+sum((s[1][1] for s in shapes.values()),db.Region())
            candidates=sorted(((a,b) for a in range(2,len(arms[0])) for b in range(2,len(arms[1]))),key=lambda t:sum(t))
            for ai,bi in candidates:
                chain=list(reversed(arms[0][:ai+1]))+arms[1][1:bi+1]
                points=[r.point(v)[1] for v in chain];metal=db.Region(db.Path(points,1800,900,900).polygon())
                pads=db.Region();co=db.Region()
                for p in (points[0],points[-1]):
                    pads.insert(db.Box(p.x-1300,p.y-1300,p.x+1300,p.y+1300))
                    co.insert(db.Box(p.x-500,p.y-500,p.x+500,p.y+500))
                metal+=pads
                if not (metal.sized(1450)&block_m1).is_empty():continue
                if not (pads.sized(1250)&foreign_gc).is_empty():continue
                if not (pads.sized(450)&active).is_empty():continue
                if not (pads.sized(1250)&allvia).is_empty():continue
                if not (co.sized(1050)&allco).is_empty():continue
                removed={frozenset(e) for e in zip(chain,chain[1:])}
                keep=[e for e in paths[nid] if frozenset(e) not in removed]
                assert len(paths[nid])-len(keep)==len(chain)-1
                replacement=[(a%plane,b%plane) for a,b in zip(chain,chain[1:])]
                replacement +=[(chain[0],chain[0]%plane),(chain[-1],chain[-1]%plane)]
                paths[nid]=keep+replacement;shapes[nid]=route_shapes(r,paths[nid]);done=True
                changes.append(dict(net=names[nid],crossing_um=[r.point(u)[1].x/1000,r.point(u)[1].y/1000],
                    contact_positions_um=[[p.x/1000,p.y/1000] for p in (points[0],points[-1])],removed_gc_edges=len(removed)))
                print(changes[-1],flush=True);break
            if done:break
        if not done:raise RuntimeError(f'No legal M1 bridge at {r.point(u)[1]} for {[names[k] for k in owners[u]]}')
    work=WORK/'layout'/(folder.name+'_bridges');work.mkdir(parents=True,exist_ok=True);(work/'routing').mkdir(exist_ok=True)
    shutil.copy2(folder/'placement.json',work/'placement.json');shutil.copy2(folder/'placed.gds',work/'placed.gds')
    shutil.copy2(folder/'routing/router.bin',work/'routing/router.bin')
    output=['0']
    for nid,edges in paths.items():output.append(f'{nid} {len(edges)}');output +=[f'{a} {b}' for a,b in edges]
    (work/'routing/routes.txt').write_text('\n'.join(output)+'\n')
    info.update(passed=False,source_router_passed=info['passed'],physical_bridge_repairs=changes,gc_routes=r.draw(paths))
    write_json(work/'routing/routing.json',info);top=named_macro(l,top,work)
    result=verify_and_repair(l,top,work);result.update(physical_bridge_repairs=changes,bbox_um=str(top.dbbox()),source=str(folder))
    info['passed']=all(result[k]['passed'] for k in ('drc','lvs'));write_json(work/'routing/routing.json',info)
    output[0]=str(int(info['passed']));(work/'routing/routes.txt').write_text('\n'.join(output)+'\n')
    write_json(REPORTS/(work.name+'.json'),result);print(result['drc'],result['lvs'],flush=True)
    return result

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('folder',type=Path);a=p.parse_args();r=repair(a.folder)
    raise SystemExit(0 if all(r[k]['passed'] for k in ('drc','lvs')) else 1)
