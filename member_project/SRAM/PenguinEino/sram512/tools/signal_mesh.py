"""Distributed signal RC on the extracted conductor topology.

GC/CO/M1/V1/M2 branches and loops are retained. MOS terminals are separate
physical taps. Degree-two wire chains become RC pi sections with exactly the
same resistance, total capacitance and first capacitance moment along R.
This is geometry-based sensitivity analysis, not qualified foundry PEX.
"""
from collections import defaultdict
import math
import networkx as nx
import numpy as np
from scipy.spatial import cKDTree
from scipy.sparse.linalg import splu
from common import *
from postlayout import observation_name
from power_mesh import medial, connect


def resistances(graph, root, sinks):
    for a,b,d in graph.edges(data=True):
        d['conductance'] = 1 / d['r']
    order = list(graph)
    keep = [i for i,n in enumerate(order) if n != root]
    ids = {order[i]:j for j,i in enumerate(keep)}
    matrix = nx.laplacian_matrix(graph, nodelist=order, weight='conductance').tocsc()
    matrix = matrix[keep,:][:,keep].tocsc()
    rhs = np.zeros((len(keep), len(sinks)))
    for i,n in enumerate(sinks):
        if n != root:
            rhs[ids[n], i] = 1
    solution = splu(matrix).solve(rhs)
    return [0 if n == root else float(solution[ids[n],i]) for i,n in enumerate(sinks)]


def section_chains(graph, anchors, sections):
    """Preserve topology and terminal nodes; interpolate internal C along R."""
    anchors = set(anchors) | {n for n in graph if graph.degree(n) != 2}
    out = nx.Graph()
    for n in anchors:
        out.add_node(n, c=graph.nodes[n]['c'])
    visited = set()
    next_id = max(graph) + 1
    chains = 0
    for start in sorted(anchors):
        for neighbor in graph[start]:
            edge = tuple(sorted((start,neighbor)))
            if edge in visited:
                continue
            path = [start, neighbor]
            visited.add(edge)
            while path[-1] not in anchors:
                previous, current = path[-2:]
                following = next(n for n in graph[current] if n != previous)
                visited.add(tuple(sorted((current,following))))
                path.append(following)
            lengths = [graph[a][b]['r'] for a,b in zip(path,path[1:])]
            total = sum(lengths)
            count = min(sections, len(lengths))
            # A loop returning to its anchor needs intermediate nodes.
            if path[0] == path[-1]:
                count = max(count, 3)
            knots = [start]
            for _ in range(count - 1):
                knots.append(next_id)
                out.add_node(next_id, c=0.)
                next_id += 1
            knots.append(path[-1])
            for a,b in zip(knots,knots[1:]):
                connect(out,a,b,total/count)
            coordinate = 0.
            for i,n in enumerate(path[1:-1]):
                coordinate += lengths[i]
                fraction = coordinate / total * count
                left = min(count - 1, int(fraction))
                weight = fraction - left
                cap = graph.nodes[n]['c']
                out.nodes[knots[left]]['c'] += cap * (1 - weight)
                out.nodes[knots[left+1]]['c'] += cap * weight
            chains += 1
    assert len(visited) == graph.number_of_edges()
    assert nx.is_connected(out)
    assert abs(sum(d['c'] for _,d in graph.nodes(data=True)) -
               sum(d['c'] for _,d in out.nodes(data=True))) < 1e-7
    return out, chains


def calculate(folder, records, geometry, coefficients, names, sections=4, grid_um=.25):
    folder = Path(folder)
    assert sections >= 1
    model = dict(version=1, grid_um=grid_um, sections=sections, coefficients=coefficients,
                 contact_ohm=1., via_ohm=1., nets=sorted(names))
    cache = folder / f'signal_mesh_{hashlib.sha256(json.dumps(model,sort_keys=True).encode()).hexdigest()[:12]}.json'
    if cache.exists():
        old = json.loads(cache.read_text())
        if old['source_gds_sha256'] == sha(folder/'sram512.gds') and old['model'] == model:
            return old
    layout = db.Layout(); layout.read(str(folder/'sram512.gds'))
    core = layout.cell('sram512')
    extraction = db.LayoutVsSchematic(); extraction.read(str(folder/'checks/sram512_macro.lvsdb'))
    circuit = extraction.netlist().circuit_by_name('sram512')
    aliases = {observation_name(p.second().name):p.first() for p in extraction.xref().each_net_pair(circuit)
               if p.first() is not None and p.second() is not None}
    specs = ((8,1),(13,0),(20,0),(11,0),(19,0))
    indexes = [extracted_layer_index(extraction,layout,core,s) for s in specs]
    active = (db.Region(core.begin_shapes_rec(layout.layer(3,1))) +
              db.Region(core.begin_shapes_rec(layout.layer(3,2)))).merged()
    layer_names = ('GC_field','M1','M2')
    results = {}
    for name in sorted(names):
        net = aliases[name]
        regions = [[db.Region(p) for p in extraction.polygons_of_net(net,indexes[k],True).merged().each()]
                   for k in range(3)]
        graph = nx.Graph(); trees = {}; keys = {}; widths = {}; caps = defaultdict(lambda: [0.,0.,0.])
        for k,parts in enumerate(regions):
            co = coefficients[layer_names[k]]
            for i,region in enumerate(parts):
                branch, points, ws = medial(region,grid_um)
                mapping = {j:(k,i,j) for j in branch}
                graph.add_nodes_from(mapping.values())
                keys[k,i] = mapping; trees[k,i] = cKDTree(points); widths[k,i] = ws
                for a,b,d in branch.edges(data=True):
                    first,second = mapping[a],mapping[b]
                    connect(graph,first,second,co['sheet_ohm']*d['squares'])
                    length = float(np.linalg.norm(points[a]-points[b]))
                    midpoint = (points[a]+points[b])*.5
                    x,y = (round(float(v)*1000) for v in midpoint)
                    intrinsic = k == 0 and not active.interacting(db.Region(db.Box(x-1,y-1,x+1,y+1))).is_empty()
                    cap = 0. if intrinsic else length*(float(ws[a]+ws[b])*.5*co['area_ff_um2']+2*co['edge_ff_um'])
                    caps[first][k] += cap*.5; caps[second][k] += cap*.5
        def nearest(k,point,component=None):
            choices = [(trees[k,i].query(point),i) for i in range(len(regions[k]))
                       if component is None or component == i]
            assert choices,(name,k,point)
            (distance,j),i = min(choices,key=lambda x:x[0][0]); j=int(j)
            return keys[k,i][j], float(distance)
        for idx,ends in ((3,(0,1)),(4,(1,2))):
            for polygon in extraction.polygons_of_net(net,indexes[idx],True).merged().each():
                cut = db.Region(polygon); center = polygon.bbox().center()
                point = (center.x/1000,center.y/1000); hits=[]
                for k in ends:
                    components = [i for i,r in enumerate(regions[k]) if not r.interacting(cut).is_empty()]
                    if not components:
                        break  # diffusion contact, not a GC bridge
                    assert len(components)==1
                    n,gap=nearest(k,point,components[0])
                    lead=gap*coefficients[layer_names[k]]['sheet_ohm']/widths[k,components[0]][n[2]]
                    hits.append((n,lead))
                if len(hits)==2:
                    connect(graph,hits[0][0],hits[1][0],1+hits[0][1]+hits[1][1])
        assert nx.is_connected(graph),(name,'disconnected signal conductor graph')
        scale=[]
        for k,layer in enumerate(layer_names):
            co=coefficients[layer]; actual=geometry[name][layer]
            total=actual['area_um2']*co['area_ff_um2']+actual['perimeter_um']*co['edge_ff_um']
            estimated=sum(caps[n][k] for n in graph)
            assert estimated>0 or total==0,(name,layer,total)
            scale.append(total/estimated if estimated else 0)
        for n in graph:
            graph.nodes[n]['c']=sum(caps[n][k]*scale[k] for k in range(3))
        mapping=[];drivers=[];by_column=defaultdict(list)
        for i,r in enumerate(records):
            if r['model'] not in ('NMOS','PMOS'):
                continue
            for pin,net_name in r['nets'].items():
                if net_name != name:
                    continue
                n,gap=nearest(0 if pin=='G' else 1,r['position_um'])
                if pin=='G':assert gap<=2,(name,i,gap)
                mapping.append(dict(device=i,pin=pin,node=n,distance_um=gap))
                if pin in ('D','S'):drivers.append(n)
                if pin=='G' and re.fullmatch(r'wl\d+',name):
                    q=next((n for n in r['nets'].values() if re.match(r'xarray\.xr\d+c\d+\.q',n)),None)
                    assert q,(name,i)
                    col=int(re.search(r'c(\d+)\.',q)[1]);by_column[col].append(n)
        assert drivers,(name,'no physical driver terminal')
        root=drivers[0]
        ids={n:i for i,n in enumerate(graph)}
        for m in mapping:m['node']=ids[m['node']]
        root=ids[root];graph=nx.relabel_nodes(graph,ids,copy=True)
        node_labels={root:name}
        if by_column:
            distance=nx.single_source_dijkstra_path_length(graph,root,weight='r')
            for segment,col in enumerate((0,15,16,31),1):
                n=max((ids[n] for n in by_column[col]),key=lambda n:distance[n])
                assert n not in node_labels
                node_labels[n]=f'rc_{name}_{segment}'
        protected={m['node'] for m in mapping}|set(node_labels)
        reduced,chains=section_chains(graph,protected,sections)
        sinks=sorted(protected-{root},key=lambda n:n)[:2]
        if by_column:sinks=[n for n in node_labels if n!=root]
        else:
            distance=nx.single_source_dijkstra_path_length(graph,root,weight='r')
            sinks=sorted(protected-{root},key=lambda n:distance[n])[-4:]
        before=resistances(graph,root,sinks);after=resistances(reduced,root,sinks)
        relative=max(abs(a-b)/max(abs(a),1e-6) for a,b in zip(before,after))
        assert relative<1e-6,(name,relative,'DC reduction changed resistance')
        label=lambda n:node_labels.get(n,f'sig_{name.replace(".","_")}_n{n}')
        terminals=[{**m,'node':label(m['node'])} for m in mapping]
        total_c=sum(d['c'] for _,d in reduced.nodes(data=True))
        assert abs(total_c-geometry[name]['cap_ff'])<1e-6
        results[name]=dict(sampled_nodes=len(graph),reduced_nodes=len(reduced),chains=chains,
            nodes=[dict(name=label(n),cap_ff=float(d['c'])) for n,d in reduced.nodes(data=True)],
            edges=[dict(a=label(a),b=label(b),resistance_ohm=d['r']) for a,b,d in reduced.edges(data=True)],
            terminals=terminals,cap_ff=total_c,
            dc_validation=dict(relative_error=relative,sink_nodes=[label(n) for n in sinks],
                               original_ohm=before,reduced_ohm=after),
            maximum_path_ohm=max(distance[m['node']] for m in mapping),
            observation_columns=[0,15,16,31] if by_column else None,
            source_node=name)
        print('signal topology',name,len(graph),'->',len(reduced),'nodes',flush=True)
    result=dict(source_gds_sha256=sha(folder/'sram512.gds'),model=model,nets=results,scope=__doc__)
    write_json(cache,result)
    return result


def add_mesh(folder,records,geometry,coefficients,names,scale,sections=4):
    details=calculate(folder,records,geometry,coefficients,names,sections)
    lines=[];observed=[]
    for name,net in details['nets'].items():
        slug=name.replace('.','_')
        for i,e in enumerate(net['edges']):
            lines.append(f'Rsignal_{slug}_{i} {e["a"]} {e["b"]} {e["resistance_ohm"]*scale:.12g}')
        for i,n in enumerate(net['nodes']):
            if n['cap_ff']>0:
                lines.append(f'Csignal_{slug}_{i} {n["name"]} 0 {n["cap_ff"]*scale:.12g}f')
        for m in net['terminals']:
            assert records[m['device']]['nets'][m['pin']]==name
            records[m['device']]['nets'][m['pin']]=m['node']
        observed.extend({m['node'] for m in net['terminals']} |
                        {n['name'] for n in net['nodes'] if n['name'].startswith('rc_wl')})
    return lines,observed,details


def verify_waveform(path,case,vdd,details):
    """Check every access-gate tap, retaining the existing 90/10% levels."""
    from analog import load_raw
    t,w=load_raw(path)
    return verify_samples(t,w,case,vdd,details)

def verify_samples(t,w,case,vdd,details):
    failures=[];checks=0;period=case['period_ns']
    for name,net in details['nets'].items():
        if not re.fullmatch(r'wl\d+',name):continue
        row=int(name[2:])
        gates={m['node'] for m in net['terminals'] if m['pin']=='G'}
        for op in case['operations']:
            first,e=op['first'],op['e0']
            for a,z,bit in ((first+.3*period,e+2.9*period,0),
                            (e+3.3*period,e+4.9*period,int(row==op['row'])),
                            (e+5.3*period,e+7.8*period,0)):
                lo,hi=np.searchsorted(t,(a,z));hi=int(np.searchsorted(t,z,'right'))
                assert hi>lo
                for node in sorted(gates):
                    checks+=1;v=w['v('+node.lower()+')'][lo:hi]
                    low,high=float(v.min()),float(v.max())
                    if (low<.9*vdd if bit else high>.1*vdd):
                        failures.append(dict(net=name,gate=node,expected=bit,start_ns=a,end_ns=z,min_v=low,max_v=high))
    return dict(passed=not failures,checks=checks,failure_count=len(failures),failures=failures[:40],
        scope='Every physical WL gate tap before, during and after each access, using unchanged 90/10% rail windows.')
