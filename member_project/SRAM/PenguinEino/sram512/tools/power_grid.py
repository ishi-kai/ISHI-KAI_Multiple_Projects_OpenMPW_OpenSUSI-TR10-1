#!/usr/bin/env python3
"""Inspect actual metal supply connectivity and add real parallel power vias."""
import argparse,shutil
import networkx as nx
from common import *
from physical_top import verify_and_repair
from routing import Router,raster

def bypass(folder,name,net,x,y,radius=80):
    """Add a second physical route across a bottleneck, using fresh vias.

    The two terminals are the actual M1 and M2 components meeting at the
    specified via. Existing vias are excluded from the new route, so merely
    rediscovering the old connection cannot count as an improvement.
    """
    folder=Path(folder).resolve();l,nets=network(folder)
    top=l.cell('sram512_macro');core=l.cell('sram512')
    work=WORK/'layout'/name;work.mkdir(parents=True,exist_ok=True)
    for filename in ('placement.json','reference.spice'):
        shutil.copy2(folder/filename,work/filename)
    origin=db.Point(round(x*1000),round(y*1000))
    cut=db.Region(db.Box(origin.x-700,origin.y-700,origin.x+700,origin.y+700))
    selected=[]
    for regions in nets[net]['regions']:
        hits=[r for r in regions if not r.interacting(cut).is_empty()]
        assert len(hits)==1,(net,x,y,len(hits))
        selected.append(hits[0])
    box=top.bbox()&db.Box(origin.x-round(radius*1000),origin.y-round(radius*1000),
                         origin.x+round(radius*1000),origin.y+round(radius*1000))
    # Keep the global grid origin for compatibility with the routing writer.
    r=Router(l,core,(0,0,top.dbbox().right,top.dbbox().top),step=2750)
    own=[sum(rs,db.Region()) for rs in nets[net]['regions']]
    actual=[db.Region(core.begin_shapes_rec(l.layer(k,0))) for k in (13,20)]
    r.add_geometry([actual[k]-own[k] for k in range(2)])
    r.add_geometry(own,net)
    search=db.Region(box)
    r.add_geometry([selected[0]&search,db.Region()],net,'new_route.M1')
    r.add_geometry([db.Region(),selected[1]&search],net,'new_route.M2')
    prepare=r.prepare
    def fresh_vias_only():
        fixed,via,viametal,pins=prepare()
        cuts=db.Region(core.begin_shapes_rec(l.layer(19,0)))
        forbidden=cuts.sized(2200)
        via[raster(forbidden,r.step,r.nx,r.ny)]=1
        return fixed,via,viametal,pins
    r.prepare=fresh_vias_only
    success=r.route(work/'bypass_routing',100)
    assert success,'No legal new connection found'
    result=verify_and_repair(l,top,work)
    result.update(source_gds_sha256=sha(folder/'sram512.gds'),
                  bypass=dict(net=net,origin_um=[x,y],search_radius_um=radius))
    if all(result[k]['passed'] for k in ('drc','lvs')):
        _,after=network(work)
        result['largest_remaining_bridges']={n:v['bridges'][:10] for n,v in after.items()}
    write_json(work/'power_changes.json',result);write_json(REPORTS/(name+'.json'),result)
    print(result['drc'],result['lvs'],flush=True)
    return result

def network(folder):
    folder=Path(folder);result=json.loads((folder/'checks/result.json').read_text())
    assert all(result[k]['passed'] for k in ('drc','lvs'))
    assert result['gds_sha256']==sha(folder/'sram512.gds')
    v=db.LayoutVsSchematic();v.read(str(folder/'checks/sram512_macro.lvsdb'))
    l=db.Layout();l.read(str(folder/'sram512.gds'));core=l.cell('sram512')
    indices={}
    for key,num in [('M1',13),('V1',19),('M2',20)]:
        indices[key]=extracted_layer_index(v,l,core,(num,0))
    result={}
    for n in v.netlist().circuit_by_name('sram512').each_net():
        if n.name not in ('VDD','VSS'):continue
        polys=[list(v.polygons_of_net(n,indices[k],True).merged().each()) for k in ('M1','M2')]
        regions=[[db.Region(p) for p in ps] for ps in polys];g=nx.Graph()
        for k,ps in enumerate(polys):
            for i,p in enumerate(ps):g.add_node((k,i))
        for p in v.polygons_of_net(n,indices['V1'],True).merged().each():
            cut=db.Region(p);ends=[]
            for k,ps in enumerate(regions):
                hits=[(k,i) for i,reg in enumerate(ps) if not reg.interacting(cut).is_empty()]
                assert len(hits)==1,(n.name,p,hits)
                ends+=hits
            a,b=ends
            if not g.has_edge(a,b):g.add_edge(a,b,cut_count=0,centers=[])
            g[a][b]['cut_count']+=1;point=p.bbox().center();g[a][b]['centers'].append((point.x,point.y))
        assert nx.is_connected(g),(n.name,'Metal power network is disconnected; substrate is not a wire.')
        labels=[s.text for s in core.shapes(l.layer(49,0)).each() if s.is_text() and s.text.string==n.name]
        assert len(labels)==1,(n.name,labels)
        point=labels[0].trans.disp
        source=next((1,i) for i,p in enumerate(polys[1]) if p.inside(db.Point(point.x,point.y)))
        bridges=[]
        for a,b in nx.bridges(g):
            tmp=g.copy();tmp.remove_edge(a,b)
            side=nx.node_connected_component(tmp,a)
            if source in side:side=nx.node_connected_component(tmp,b)
            bridges.append(dict(nodes_downstream=len(side),**g[a][b]))
        result[n.name]=dict(graph=g,regions=regions,bridges=sorted(bridges,key=lambda b:-b['nodes_downstream']))
    return l,result

def strengthen(folder,name,widen_m1=0):
    folder=Path(folder).resolve();l,nets=network(folder);top=l.cell('sram512_macro');core=l.cell('sram512')
    work=WORK/'layout'/name;work.mkdir(parents=True,exist_ok=True)
    for filename in ('placement.json','reference.spice'):
        if (folder/filename).exists():shutil.copy2(folder/filename,work/filename)
    actual=[db.Region(core.begin_shapes_rec(l.layer(n,0))).merged() for n in (13,20)]
    cuts=db.Region(core.begin_shapes_rec(l.layer(19,0))).merged()
    gate=db.Region(core.begin_shapes_rec(l.layer(8,1)));co=db.Region(core.begin_shapes_rec(l.layer(11,0)))
    bounds=top.bbox();changes=[];unresolved=[];widening=[]
    offsets=sorted([(x*3000,y*3000) for x in range(-5,6) for y in range(-5,6) if x or y],key=lambda p:(abs(p[0])+abs(p[1]),p))
    offsets += sorted([(x*500,y*500) for x in range(-30,31) for y in range(-30,31)
                       if (x or y) and (x%6 or y%6)],key=lambda p:(abs(p[0])+abs(p[1]),p))
    for net,info in nets.items():
        own=[sum(rs,db.Region()) for rs in info['regions']]
        forbidden=[(actual[k]-own[k]).sized(space) for k,space in enumerate((1450,2050))]
        for bridge in info['bridges']:
            target=4 if bridge['nodes_downstream']>=300 else 2 if bridge['nodes_downstream']>=40 else 1
            count=bridge['cut_count']
            if count>=target:continue
            origin=db.Point(*bridge['centers'][0]);added=[]
            search=db.Region(db.Box(origin.x-20000,origin.y-20000,origin.x+20000,origin.y+20000))
            localcuts=cuts&search;localgate=gate&search;localco=co&search
            localforbidden=[r&search for r in forbidden]
            # Dense standard-cell access sometimes leaves a legal 50 nm-grid
            # landing between a contact and a signal rail. Include those exact
            # geometric boundary candidates instead of relaxing any spacing.
            xs=set();ys=set()
            for region,clearance in [(localcuts,2250),(localgate,1950),(localco,1750)]+[(r,1700) for r in localforbidden]:
                for poly in region.each():
                    for point in poly.each_point_hull():
                        for sign in (-1,1):
                            x=point.x+sign*clearance-origin.x;y=point.y+sign*clearance-origin.y
                            if abs(x)<=15000:xs.add(x)
                            if abs(y)<=15000:ys.add(y)
            exact=sorted([(x,y) for x in xs for y in ys],key=lambda p:(abs(p[0])+abs(p[1]),p))
            for dx,dy in offsets+exact:
                center=origin+db.Point(dx,dy);via=db.Region(db.Box(center.x-700,center.y-700,center.x+700,center.y+700))
                if not (via.sized(1550)&localcuts).is_empty():continue
                if not (via.sized(1250)&localgate).is_empty():continue
                if not (via.sized(1050)&localco).is_empty():continue
                points=[origin,db.Point(center.x,origin.y),center]
                metal=db.Region(db.Path(points,3400,1700,1700).polygon())
                if not (metal-db.Region(bounds)).is_empty():continue
                if any(not (metal&region).is_empty() for region in localforbidden):continue
                for k,num in enumerate((13,20)):
                    core.shapes(l.layer(num,0)).insert(metal);actual[k]+=metal;own[k]+=metal
                core.shapes(l.layer(19,0)).insert(via);cuts+=via;localcuts+=via;count+=1;added.append([center.x/1000,center.y/1000])
                if count==target:break
            changes.append(dict(net=net,origin_um=[origin.x/1000,origin.y/1000],
                                downstream_metal_components=bridge['nodes_downstream'],old_cuts=bridge['cut_count'],
                                new_cuts=count,added_vias_um=added))
            if count<target:unresolved.append(changes[-1])
        if widen_m1:
            # Add actual M1 within the available spacing. Preserve every old
            # contact and rail, and remove potential sub-minimum-width slivers.
            wanted=own[0].sized(round(widen_m1*1000))
            allowed=wanted-(actual[0]-own[0]).sized(2050)
            expanded=(allowed.sized(-900).sized(900)+own[0])&db.Region(bounds)
            expanded=(expanded.sized(750).sized(-750)+own[0])&db.Region(bounds)
            added=expanded-own[0]
            assert (added.sized(1400)&(actual[0]-own[0])).is_empty(),net
            core.shapes(l.layer(13,0)).insert(added);actual[0]+=added
            widening.append(dict(net=net,requested_growth_um=widen_m1,added_area_um2=added.area()*1e-6))
    result=verify_and_repair(l,top,work)
    result.update(source_gds_sha256=sha(folder/'sram512.gds'),parallel_vias=changes,unresolved=unresolved,m1_widening=widening,
                  scope='Physical via redundancy only. Wire current capacity and supply IR drop require separate analysis.')
    write_json(work/'power_changes.json',result);write_json(REPORTS/(name+'.json'),result)
    print('via improvements',len(changes),'unresolved',len(unresolved),result['drc'],result['lvs'],flush=True)
    return result

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('folder',type=Path);p.add_argument('--name',default='power_h720');p.add_argument('--widen-m1',type=float,default=0)
    p.add_argument('--bypass',nargs=3,metavar=('NET','X_UM','Y_UM'));a=p.parse_args()
    result=bypass(a.folder,a.name,a.bypass[0],float(a.bypass[1]),float(a.bypass[2])) if a.bypass else strengthen(a.folder,a.name,a.widen_m1)
    raise SystemExit(0 if all(result[k]['passed'] for k in ('drc','lvs')) and not result.get('unresolved') else 1)
