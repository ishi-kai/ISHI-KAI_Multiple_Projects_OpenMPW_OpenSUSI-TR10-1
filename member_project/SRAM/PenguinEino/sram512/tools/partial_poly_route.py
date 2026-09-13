#!/usr/bin/env python3
"""Re-route selected conflicting signals; keep every other physical wire."""
import argparse,shutil
from detail_route import restore
from routing_poly import RouterPoly
from physical_top import named_macro,verify_and_repair
from common import *

def main(folder,wanted,iterations,reuse_routes=None):
    folder=Path(folder).resolve();info=json.loads((folder/'routing/routing.json').read_text())
    l,top,base=restore(folder,info);coarse=RouterPoly.from_router(base,round(info['grid_um']*1000))
    names={int(k):v for k,v in info['node_names'].items()};bad={k for k,v in names.items() if v in wanted}
    assert len(bad)==len(wanted)
    lines=(folder/'routing/routes.txt').read_text().splitlines();i=1;good={}
    while i<len(lines):
        nid,n=map(int,lines[i].split());i+=1;edges=[tuple(map(int,s.split())) for s in lines[i:i+n]];i+=n
        if nid not in bad:good[nid]=edges
    coarse.draw(good)
    for nid,edges in good.items():
        if names[nid].upper() in {'VDD','VSS','CLK','RESET','SDI','WE','SDO'}:continue
        found=next((u for edge in edges for u in edge if coarse.point(u)[0]<2),None)
        if found is None:continue
        layer,point=coarse.point(found);path=names[nid].split('__')
        name='.'.join([s[1:] if s.startswith('x') else s for s in path[:-1]]+path[-1:]).upper()
        top.shapes(l.layer(48+layer,0)).insert(db.Text(name,db.Trans(point)))
    fine=RouterPoly.from_router(base,550,extra_um=(2.75,3.3))
    for k,layer in enumerate(((13,0),(20,0))):
        actual=db.Region(top.begin_shapes_rec(l.layer(*layer)))
        native=sum((base.regions[k].get(nid,db.Region()) for nid in bad),db.Region())
        from collections import defaultdict
        regs=defaultdict(db.Region);regs[-1]=actual-native
        for nid in bad:regs[nid]=base.regions[k].get(nid,db.Region())
        fine.regions[k]=regs
    fine.pins={nid:base.pins[nid] for nid in bad}
    work=WORK/'layout'/(folder.name+('_partial_inspected' if reuse_routes else '_partial'));work.mkdir(parents=True,exist_ok=True)
    shutil.copy2(folder/'placement.json',work/'placement.json');top.write(str(work/'placed.gds'))
    print('Selected signals',wanted,flush=True)
    if reuse_routes:
        routing=work/'routing';routing.mkdir(exist_ok=True)
        shutil.copy2(reuse_routes,routing/'routes.txt')
        shutil.copy2(Path(reuse_routes).parent/'diagnostic.bin',routing/'router.bin')
        data=Path(reuse_routes).read_text().splitlines();i=1;paths={};success=data[0]=='1'
        while i<len(data):
            nid,n=map(int,data[i].split());i+=1;paths[nid]=[tuple(map(int,s.split())) for s in data[i:i+n]];i+=n
        write_json(routing/'routing.json',dict(passed=success,nets=len(paths),grid_um=.55,
            node_names={v:k for k,v in fine.ids.items()},conductors=['M1','M2','GC'],gc_routes=fine.draw(paths)))
    else:success=fine.route(work/'routing',iterations)
    top=named_macro(l,top,work)
    if not success and not reuse_routes:
        top.write(str(work/'sram512.gds'));return False
    result=verify_and_repair(l,top,work);result.update(router_passed=success,rerouted_signals=wanted,bbox_um=str(top.dbbox()))
    write_json(REPORTS/(work.name+'.json'),result);print(result['drc'],result['lvs'],flush=True)
    return all(result[k]['passed'] for k in ('drc','lvs'))

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('folder',type=Path);p.add_argument('signals',nargs='+');p.add_argument('--iterations',type=int,default=80)
    p.add_argument('--reuse-routes',type=Path)
    a=p.parse_args();raise SystemExit(0 if main(a.folder,a.signals,a.iterations,a.reuse_routes) else 1)
