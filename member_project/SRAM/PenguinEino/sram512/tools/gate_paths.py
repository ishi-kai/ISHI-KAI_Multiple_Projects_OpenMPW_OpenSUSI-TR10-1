"""Bound gate-branch resistance along the actual GC/CO/M1/V1/M2 paths.

The older stress model placed the sum of every branch's resistance in each
branch. This tool instead follows the connected, width-aware physical metal
and gate-poly geometry. A shortest resistive path is an upper bound on the
two-terminal resistance of a passive network (parallel alternatives omitted).
It is still a lumped branch sensitivity model, not foundry-qualified PEX.
"""
import math
from collections import defaultdict
import networkx as nx
from scipy.spatial import cKDTree
from common import *
from postlayout import observation_name
from power_mesh import medial,connect


def calculate(folder,records,coefficients,grid_um=.25):
    folder=Path(folder);cache=folder/f'gate_paths_{grid_um:g}.json'
    model=dict(grid_um=grid_um,coefficients=coefficients,contact_ohm=1.0,via_ohm=1.0,version=1)
    if cache.exists():
        old=json.loads(cache.read_text())
        if old['gds_sha256']==sha(folder/'sram512.gds') and old['model']==model:return old
    l=db.Layout();l.read(str(folder/'sram512.gds'));core=l.cell('sram512')
    v=db.LayoutVsSchematic();v.read(str(folder/'checks/sram512_macro.lvsdb'))
    circuit=v.netlist().circuit_by_name('sram512')
    aliases={observation_name(p.second().name):p.first() for p in v.xref().each_net_pair(circuit)
             if p.first() is not None and p.second() is not None}
    specs=((8,1),(13,0),(20,0),(11,0),(19,0))
    indexes=[extracted_layer_index(v,l,core,s) for s in specs]
    sheet=[coefficients[k]['sheet_ohm'] for k in ('GC_field','M1','M2')]
    gates=defaultdict(list);drivers=defaultdict(list)
    for r in records:
        if r['model'] not in ('NMOS','PMOS'):continue
        n=r['nets']['G']
        if n in aliases and not n.startswith(('xarray.','physical_')) and not re.fullmatch(r'wl\d+',n):
            gates[n].append(r)
        for pin in ('D','S'):drivers[r['nets'][pin]].append(r)
    out={}
    for name,loads in gates.items():
        n=aliases[name]
        regions=[[db.Region(p) for p in v.polygons_of_net(n,indexes[k],True).merged().each()] for k in range(3)]
        graph=nx.Graph();trees={};widths={};points={};ids={}
        for k,parts in enumerate(regions):
            for i,region in enumerate(parts):
                g,pt,w=medial(region,grid_um)
                trees[k,i]=cKDTree(pt);widths[k,i]=w;points[k,i]=pt
                ids[k,i]={j:(k,i,j) for j in g}
                graph.add_nodes_from(ids[k,i].values())
                for a,b,d in g.edges(data=True):connect(graph,ids[k,i][a],ids[k,i][b],sheet[k]*d['squares'])
        def nearest(k,point,component=None):
            choices=[(trees[k,i].query(point),i) for i in range(len(regions[k]))
                     if component is None or i==component]
            assert choices,(name,k,point)
            (distance,j),i=min(choices,key=lambda a:a[0][0]);j=int(j)
            return ids[k,i][j],float(distance)*sheet[k]/widths[k,i][j],float(distance)
        for idx,ends in ((3,(0,1)),(4,(1,2))):
            for p in v.polygons_of_net(n,indexes[idx],True).merged().each():
                cut=db.Region(p);center=p.bbox().center();point=(center.x/1000,center.y/1000)
                hit=[]
                for k in ends:
                    matches=[i for i,r in enumerate(regions[k]) if not r.interacting(cut).is_empty()]
                    # Diffusion contacts attach the driver; they do not bridge GC.
                    if not matches:break
                    assert len(matches)==1,(name,k,p,matches)
                    hit.append(nearest(k,point,matches[0]))
                if len(hit)==2:connect(graph,hit[0][0],hit[1][0],1+hit[0][1]+hit[1][1])
        assert nx.is_connected(graph),(name,'disconnected physical conductor mesh',nx.number_connected_components(graph))
        if not drivers[name]:
            # External pins do not need the gate-branch approximation here;
            # their pad/input wiring is short and modeled by the original TB.
            continue
        root,lead,_=nearest(1,drivers[name][0]['position_um'])
        distance=nx.single_source_dijkstra_path_length(graph,root,weight='r')
        groups=defaultdict(list)
        for r in loads:
            sink,extra,gap=nearest(0,r['position_um'])
            assert gap<=2.0,(name,r['position_um'],gap,'gate is not on extracted GC')
            groups[str(r['instance'])].append(distance[sink]+lead+extra)
        out[name]=dict(branches={key:max(values) for key,values in groups.items()},
                       mesh_nodes=len(graph),mesh_edges=graph.number_of_edges(),
                       minimum_branch_ohm=min(min(x) for x in groups.values()),
                       maximum_branch_ohm=max(max(x) for x in groups.values()))
        if name in ('xctrl.rsti','xctrl.cki','preb'):print('physical gate paths',name,out[name]['maximum_branch_ohm'],flush=True)
    result=dict(gds_sha256=sha(folder/'sram512.gds'),model=model,nets=out,scope=__doc__)
    write_json(cache,result)
    return result


if __name__=='__main__':
    import argparse
    from postlayout import devices
    from wire_rc import COEFFICIENTS
    p=argparse.ArgumentParser();p.add_argument('folder',type=Path);p.add_argument('--grid',type=float,default=.25);a=p.parse_args()
    folder=a.folder.resolve();rs,_=devices(folder)
    result=calculate(folder,rs,COEFFICIENTS,a.grid)
    print('nets',len(result['nets']),flush=True)
