#!/usr/bin/env python3
"""Route extra metal between selected physical islands of one existing LVS net."""
import argparse,shutil
import networkx as nx
from common import *
from postlayout import observation_name
from routing import Router
from layout_analog import pc


def main(source,name,step_um=1.1):
    source=Path(source).resolve();check=json.loads((source/'checks/result.json').read_text())
    assert check['gds_sha256']==sha(source/'sram512.gds')
    assert all(check[k]['passed'] for k in ('drc','lvs'))
    layout=db.Layout();layout.read(str(source/'sram512.gds'))
    core=layout.cell('sram512');top=layout.cell('sram512_macro')
    extraction=db.LayoutVsSchematic();extraction.read(str(source/'checks/sram512_macro.lvsdb'))
    circuit=extraction.netlist().circuit_by_name('sram512')
    nets={observation_name(p.second().name):p.first() for p in extraction.xref().each_net_pair(circuit)
          if p.first() is not None and p.second() is not None}
    specs=((13,0),(20,0),(19,0))
    indexes=[extracted_layer_index(extraction,layout,core,s) for s in specs]
    router=Router(layout,core,(946.,0.,1584.,352.),step=round(step_um*1000))
    actual=[db.Region(core.begin_shapes_rec(layout.layer(*s))).merged() for s in specs[:2]]
    selected={};description=[]
    for netname,points in [('ca2b',[(1300.2,198.3),(1067.2,112.95)]),
                        ('ra0',[(1484.2,273.05),(1237.6,22.4)])]:
        polygons=[extraction.polygons_of_net(nets[netname],i,True).merged() for i in indexes]
        parts=[[db.Region(p) for p in reg.each()] for reg in polygons[:2]]
        graph=nx.Graph()
        for k,layer in enumerate(parts):graph.add_nodes_from((k,i) for i in range(len(layer)))
        for polygon in polygons[2].each():
            via=db.Region(polygon)
            ends=[next((k,i) for i,r in enumerate(parts[k]) if not r.interacting(via).is_empty()) for k in range(2)]
            graph.add_edge(*ends)
        components=list(nx.connected_components(graph));chosen=[]
        for x,y in points:
            point=db.Region(db.Box(round(x*1000)-1,round(y*1000)-1,round(x*1000)+1,round(y*1000)+1))
            hits=[j for j,component in enumerate(components)
                  if any(k==0 and not parts[k][i].interacting(point).is_empty() for k,i in component)]
            assert len(hits)==1,(netname,x,y,hits)
            chosen.append(hits[0])
        if len(set(chosen))==1:
            print(netname,'already joined by metal',flush=True);continue
        nid=router.netid(netname);selected[netname]=polygons[:2]
        for k in range(2):router.regions[k][nid]=polygons[k]
        for j in chosen:
            regions=[sum((parts[k][i] for kk,i in components[j] if kk==k),db.Region()) for k in range(2)]
            router.pins[nid].append((netname+f'.island{j}',regions))
        description.append(dict(net=netname,physical_contact_positions_um=points,
                                original_metal_components=len(components),joined_components=chosen))
    assert selected
    for k in range(2):router.regions[k][-1]=actual[k]-sum((r[k] for r in selected.values()),db.Region())
    work=WORK/'layout'/name;work.mkdir(parents=True,exist_ok=True)
    success=router.route(work/'routing',5)
    pc.fill_metal_notches(layout,core)
    assert top.dbbox().width()<=1800 and top.dbbox().height()<=600
    for filename in ('placement.json','ports.json','coordinate_frames.json','array_geometry.json','reference.spice'):
        shutil.copy2(source/filename,work/filename)
    gds=work/'sram512.gds';top.write(str(gds))
    result=verify_layout(gds,top.name,work/'reference.spice',work/'checks')
    result.update(source_gds_sha256=check['gds_sha256'],router_passed=success,metal_shunts=description)
    result['passed']=success and all(result[k]['passed'] for k in ('drc','lvs'))
    write_json(work/'decoder_changes.json',result)
    print(result['drc'],result['lvs'],flush=True)
    return result


if __name__=='__main__':
    parser=argparse.ArgumentParser();parser.add_argument('source',type=Path)
    parser.add_argument('--name',default='decoder_metal16x32');parser.add_argument('--step-um',type=float,default=1.1)
    args=parser.parse_args();raise SystemExit(0 if main(args.source,args.name,args.step_um)['passed'] else 1)
