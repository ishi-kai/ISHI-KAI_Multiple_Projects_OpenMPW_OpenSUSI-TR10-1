#!/usr/bin/env python3
"""Repair local routing conflicts while retaining connected wire fragments.

Native terminals come from the separately verified cells. Kept graph edges
are actual M1/M2/GC wires with physical contacts; no abstract connection is
emitted in their place. Official strict LVS and full DRC decide the result.
"""
import argparse,shutil
from collections import defaultdict
import networkx as nx
from common import *
from layout_rectangular import build
from routing_poly import RouterPoly
from repair_poly_crossings import route_shapes
from physical_top import named_macro,verify_and_repair

def read_paths(path):
    data=path.read_text().splitlines();i=1;paths={}
    while i<len(data):
        nid,n=map(int,data[i].split());i+=1
        paths[nid]=[tuple(map(int,line.split())) for line in data[i:i+n]];i+=n
    return paths

def main(source,radius=22,iterations=80):
    source=Path(source).resolve();layout,core,base,original=build(True,True)
    info=json.loads((source/'routing/routing.json').read_text())
    route_options=json.loads((source/'routing/routing_input.json').read_text())
    base.via_pitch_nm=round(route_options.get('via_grid_um',5.5)*1000)
    assert info['grid_um']==base.step/1000
    assert info['node_names']=={str(v):k for k,v in base.ids.items()}
    assert json.loads((source/'placement.json').read_text())==json.loads((original/'placement.json').read_text())
    old=db.Layout();old.read(str(source/'placed.gds'))
    for li in layout.layer_indexes():
        spec=layout.get_info(li)
        assert (db.Region(core.begin_shapes_rec(li))^
                db.Region(old.cell('sram512').begin_shapes_rec(old.layer(spec)))).is_empty(),spec
    allpaths=read_paths(source/'routing/routes.txt');bad=set();areas=[]
    for line in (source/'routing/routes.txt.conflicts').read_text().splitlines():
        layer,x,y,*ids=map(int,line.split());bad.update(ids)
        areas.append(db.Box(x*base.step-round(radius*1000),y*base.step-round(radius*1000),
                            x*base.step+round(radius*1000),y*base.step+round(radius*1000)))
    area=db.Region(areas).merged();kept={};fragments={};removed=0
    for nid,edges in allpaths.items():
        if nid not in bad:kept[nid]=edges;continue
        retain=[]
        for a,b in edges:
            _,pa=base.point(a);_,pb=base.point(b)
            box=db.Box(min(pa.x,pb.x),min(pa.y,pb.y),max(pa.x,pb.x),max(pa.y,pb.y)).enlarged(1)
            if area.interacting(db.Region(box)).is_empty():retain.append((a,b))
            else:removed+=1
        graph=nx.Graph();graph.add_edges_from(retain)
        native={-i-1:term for i,(_,term) in enumerate(base.pins[nid])}
        graph.add_nodes_from(native)
        # Exact grid access points on a native terminal all refer to that
        # same conductor, as established by the leaf's strict extraction.
        points=[(u,*base.point(u)) for u in list(graph) if u>=0]
        for token,regs in native.items():
            for u,k,p in points:
                if k>=2:continue
                if not regs[k].interacting(db.Region(db.Box(p.x-1,p.y-1,p.x+1,p.y+1))).is_empty():
                    graph.add_edge(token,u)
        groups=[];final=[]
        for component in nx.connected_components(graph):
            ce=[e for e in retain if e[0] in component]
            regs,_=route_shapes(base,ce)
            for token in component:
                if token<0:
                    for k in range(2):regs[k]+=native[token][k]
            # An orphaned field-GC fragment carries no native terminal.
            # Remove it instead of manufacturing an isolated conductor.
            if regs[0].is_empty() and regs[1].is_empty():continue
            final+=ce;groups.append((f'kept_fragment_{len(groups)}',regs[:2]))
        kept[nid]=final;fragments[nid]=groups
    base.draw(kept)
    # Labels on every retained signal survive the selective routing pass.
    names={v:k for k,v in base.ids.items()}
    for nid,edges in kept.items():
        if names[nid] in {'vdd','vss','clk','reset','sdi','we','sdo'}:continue
        u=next((u for e in edges for u in e if base.point(u)[0]<2),None)
        if u is None:continue
        k,p=base.point(u);parts=names[nid].split('__')
        label='.'.join([s[1:] if s.startswith('x') else s for s in parts[:-1]]+parts[-1:]).upper()
        core.shapes(layout.layer(48+k,0)).insert(db.Text(label,db.Trans(p)))
    fine=RouterPoly.from_router(base,550,extra_um=(2.75,3.3))
    fine.gc_owned={nid:base.drawn_regions[nid][2] for nid in bad if nid in base.drawn_regions}
    for k,layer in enumerate(((13,0),(20,0))):
        actual=db.Region(core.begin_shapes_rec(layout.layer(*layer)))
        own={nid:base.regions[k].get(nid,db.Region())+base.drawn_regions.get(nid,[db.Region()]*3)[k] for nid in bad}
        regs=defaultdict(db.Region);regs[-1]=actual-sum(own.values(),db.Region())
        regs.update(own);fine.regions[k]=regs
    fine.pins=fragments
    work=source.with_name(source.name+f'_local{radius:g}');work.mkdir(parents=True,exist_ok=True)
    for name in ('placement.json','ports.json','array_geometry.json'):shutil.copy2(source/name,work/name)
    core.write(str(work/'placed.gds'))
    print('Local repair',len(bad),'nets,',removed,'removed edges,',sum(map(len,fragments.values())),'fragments',flush=True)
    success=fine.route(work/'routing',iterations,selective=True)
    top=named_macro(layout,core,work,array_y=118.2)
    result=verify_and_repair(layout,top,work);box=top.dbbox()
    result.update(router_passed=success,source=str(source),radius_um=radius,
                  local_nets=[names[nid] for nid in sorted(bad)],removed_edges=removed,
                  dimensions_um=[box.width(),box.height()],physical_rows=16,physical_columns=32)
    write_json(work/'result.json',result)
    print(result['drc'],result['lvs'],result['dimensions_um'],flush=True)
    return success and all(result[k]['passed'] for k in ('drc','lvs'))

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('source',type=Path);p.add_argument('--radius',type=float,default=22)
    p.add_argument('--iterations',type=int,default=80);a=p.parse_args()
    raise SystemExit(0 if main(a.source,a.radius,a.iterations) else 1)
