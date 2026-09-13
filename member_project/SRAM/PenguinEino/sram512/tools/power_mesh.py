"""Width-aware supply resistance sensitivity on the actual metal topology.

Metal polygons are sampled on a stated grid, reduced to their medial paths,
and assigned R = sheet_R * path_length / local_width. Local width uses the
inside distance transform minus one sampling interval. Series-only nodes are
eliminated exactly; branches, loops, every actual via, and load taps remain.
This is an explicit numerical sensitivity model, not a foundry PEX deck.
It improves on the earlier whole-polygon perimeter proxy without replacing
that failed experiment or changing any circuit/DRC/LVS acceptance criterion.
"""
import copy,math
import numpy as np
import networkx as nx
from scipy.ndimage import distance_transform_edt
from scipy.spatial import cKDTree
from skimage.morphology import skeletonize
from shapely.geometry import Polygon,Point
from shapely.strtree import STRtree
from common import *
from routing import raster
from power_grid import network

def medial(region,step_um=.25):
    step=round(step_um*1000);b=region.bbox()
    origin=(math.floor(b.left/step)*step-step,math.floor(b.bottom/step)*step-step)
    cols=math.ceil((b.right-origin[0])/step)+2;rows=math.ceil((b.top-origin[1])/step)+2
    sample=(origin[0]+step//2,origin[1]+step//2)
    mask=np.zeros((rows,cols),bool)
    mask.ravel()[raster(region,step,cols,rows,sample)]=True
    dist=distance_transform_edt(mask)*step_um
    thin=skeletonize(mask);ys,xs=np.nonzero(thin)
    ids=np.full(mask.shape,-1,np.int32);ids[ys,xs]=np.arange(len(xs))
    points=np.column_stack((xs*step_um+sample[0]/1000,ys*step_um+sample[1]/1000))
    widths=np.maximum(step_um,2*dist[ys,xs]-step_um)
    graph=nx.Graph();graph.add_nodes_from(range(len(xs)))
    for dy,dx in ((0,1),(1,-1),(1,0),(1,1)):
        yy=ys+dy;xx=xs+dx;ok=(yy>=0)&(yy<rows)&(xx>=0)&(xx<cols)
        for a,y,x in zip(np.flatnonzero(ok),yy[ok],xx[ok]):
            z=int(ids[y,x])
            if z<0:continue
            # Avoid spurious triangles around an existing orthogonal corner.
            if dx and dy and (ids[ys[a],x]>=0 or ids[y,xs[a]]>=0):continue
            squares=step_um*math.hypot(dx,dy)*.5*(1/widths[a]+1/widths[z])
            graph.add_edge(int(a),z,squares=float(squares))
    assert nx.is_connected(graph),(str(b),len(graph),'sampled metal disconnected')
    return graph,points,widths

def connect(g,a,b,resistance,kind='metal'):
    if a==b:return
    assert resistance>0
    if g.has_edge(a,b):
        old=g[a][b]['r'];g[a][b]['r']=1/(1/old+1/resistance)
        g[a][b]['kind']='parallel'
    else:g.add_edge(a,b,r=float(resistance),kind=kind)

def reduce_series(g,protected):
    todo=[n for n in g if n not in protected and g.degree(n)<=2]
    while todo:
        n=todo.pop()
        if n not in g or n in protected:continue
        adjacent=list(g[n])
        if len(adjacent)>2:continue
        if len(adjacent)==2:
            a,b=adjacent;connect(g,a,b,g[n][a]['r']+g[n][b]['r'],'series')
        g.remove_node(n)
        for a in adjacent:
            if a not in protected and g.degree(a)<=2:todo.append(a)
    assert nx.is_connected(g)

def add_power_mesh(folder,original,sheet_ohm,via_ohm=1.,step_um=.25):
    assert sheet_ohm>0 and via_ohm>0 and step_um>0
    l,nets=network(folder);core=l.cell('sram512');records=copy.deepcopy(original)
    lines=[];observed=[];details={}
    for name,data in nets.items():
        slug=name.lower();g=nx.Graph();coords={};width={};trees={};keys={};protected=set()
        polygons=[]
        for k,regions in enumerate(data['regions']):
            for i,region in enumerate(regions):
                branch,pts,ws=medial(region,step_um)
                mapping={j:(k,i,j) for j in branch};keys[k,i]=mapping
                trees[k,i]=cKDTree(pts)
                for j in branch:coords[mapping[j]]=pts[j];width[mapping[j]]=ws[j]
                for a,b,d in branch.edges(data=True):connect(g,mapping[a],mapping[b],sheet_ohm*d['squares'])
                if k==0:
                    p=next(region.each())
                    polygons.append(Polygon([(q.x/1000,q.y/1000) for q in p.each_point_hull()],
                        [[(q.x/1000,q.y/1000) for q in p.each_point_hole(h)] for h in range(p.holes())]))
        def nearest(component,point):
            distance,index=trees[component].query(point)
            n=keys[component][int(index)];protected.add(n)
            return n,float(distance)*sheet_ohm/width[n]
        via_edges=[]
        for a,b,d in data['graph'].edges(data=True):
            for x,y in d['centers']:
                first,ra=nearest(a,(x/1000,y/1000));second,rb=nearest(b,(x/1000,y/1000))
                resistance=ra+via_ohm+rb
                connect(g,first,second,resistance,'via')
                via_edges.append(dict(position_um=[x/1000,y/1000],ends=[first,second],r=resistance))
        labels=[s.text for s in core.shapes(l.layer(49,0)).each() if s.is_text() and s.text.string==name]
        assert len(labels)==1
        point=labels[0].trans.disp
        comp=next(i for i,r in enumerate(data['regions'][1]) if
            not r.interacting(db.Region(db.Box(point.x-1,point.y-1,point.x+1,point.y+1))).is_empty())
        source,source_r=nearest((1,comp),(point.x/1000,point.y/1000))
        tree=STRtree(polygons);loads={};mapping=[]
        for j,record in enumerate(records):
            pins=[p for p,n in record['nets'].items() if n==slug]
            if not pins:continue
            pt=Point(record['position_um']);i=int(tree.nearest(pt));n,_=nearest((0,i),record['position_um'])
            # A diffusion/body terminal is mapped to the nearest same-net M1
            # path. Semiconductor spreading/contact resistance is not invented.
            if n not in loads:loads[n]=f'power_{slug}_load_{len(loads)}'
            for pin in pins:record['nets'][pin]=loads[n]
            mapping.append(dict(device=j,pins=pins,node=loads[n],m1_component=i,
                                distance_to_metal_um=float(pt.distance(polygons[i]))))
        raw_nodes=len(g);raw_edges=g.number_of_edges()
        assert nx.is_connected(g),name
        reduce_series(g,protected)
        ids={n:i for i,n in enumerate(g)}
        def label(n):return loads.get(n,f'power_{slug}_mesh_{ids[n]}')
        for j,(a,b,d) in enumerate(g.edges(data=True)):
            lines.append(f'Rpower_{slug}_mesh_{j} {label(a)} {label(b)} {d["r"]:.12g}')
        external='vdd' if name=='VDD' else '0'
        lines.append(f'Rpower_{slug}_port {external} {label(source)} {max(.001,source_r):.12g}')
        # Keep both ends of each individual physical via observable. This
        # checks transient current sharing in the same resistance network,
        # rather than dividing the total supply current by the via count.
        via_branches=[dict(position_um=v['position_um'],a=label(v['ends'][0]),
                           b=label(v['ends'][1]),resistance_ohm=v['r']) for v in via_edges]
        observed+=sorted(set(loads.values())|{v[k] for v in via_branches for k in ('a','b')})
        details[name]=dict(sampled_nodes=raw_nodes,sampled_edges=raw_edges,
            reduced_nodes=len(g),reduced_edges=g.number_of_edges(),load_nodes=len(loads),
            physical_via_cuts=len(via_edges),via_branches=via_branches,
            maximum_mapping_distance_um=max(m['distance_to_metal_um'] for m in mapping),
            terminal_map=mapping,port_node=label(source),port_lead_resistance_ohm=source_r,
            mesh_nodes=[dict(net=label(n),position_um=coords[n].tolist(),layer=n[0]+1,width_um=float(width[n])) for n in g],
            mesh_edges=[dict(a=label(a),b=label(b),resistance_ohm=d['r'],kind=d['kind']) for a,b,d in g.edges(data=True)])
        print(name,'power mesh',raw_nodes,'->',len(g),'nodes;',len(loads),'load taps',flush=True)
    return records,lines,observed,dict(sheet_ohm=sheet_ohm,via_ohm=via_ohm,grid_um=step_um,
        scope=__doc__,networks=details,source_gds_sha256=sha(folder/'sram512.gds'))

def verify_via_currents(path,info):
    """Compare individual TC currents with the published current limits.

    The 0.78 mA continuous and 7.8 mA instantaneous limits are from OS00
    rev1.1, table I-3-3. RMS is also checked against the continuous limit as
    a conservative heating screen. This is conditional on the explicit
    uncalibrated sheet/via-R model, not an electromigration signoff deck.
    """
    from analog import load_raw
    t,w=load_raw(path);dt=np.diff(t);span=t[-1]-t[0]
    assert span>0
    rows=[]
    for supply,network in info['networks'].items():
        for branch in network['via_branches']:
            current=(w[f'v({branch["a"]})']-w[f'v({branch["b"]})'])/branch['resistance_ohm']
            peak=float(np.max(np.abs(current)))
            average=float(np.sum((np.abs(current[1:])+np.abs(current[:-1]))*.5*dt)/span)
            rms=float(np.sqrt(np.sum((current[1:]**2+current[:-1]**2)*.5*dt)/span))
            rows.append(dict(supply=supply,position_um=branch['position_um'],peak_a=peak,
                             mean_absolute_a=average,rms_a=rms,
                             passed=peak<=.0078 and rms<=.00078))
    assert rows
    failures=[r for r in rows if not r['passed']]
    return dict(passed=not failures,checks=2*len(rows),physical_vias=len(rows),
                failure_count=len(failures),failures=failures[:20],
                maximum_peak_a=max(r['peak_a'] for r in rows),maximum_rms_a=max(r['rms_a'] for r in rows),
                worst_peak_vias=sorted(rows,key=lambda r:-r['peak_a'])[:10],
                limits_a=dict(instantaneous=.0078,continuous=.00078,rms_screen=.00078),
                reference='OpenSUSI OS00 reference manual rev1.1, table I-3-3',scope=verify_via_currents.__doc__)

def validate():
    """Nontrivial analytic checks on straight sheets and a split current path."""
    from scipy.sparse import coo_matrix
    from scipy.sparse.linalg import spsolve
    def resistance(g,a,b):
        ids={n:i for i,n in enumerate(g)};row=[];col=[];values=[]
        for u,v,d in g.edges(data=True):
            i,j=ids[u],ids[v];c=1/d['r']
            row +=[i,j,i,j];col +=[i,j,j,i];values +=[c,c,-c,-c]
        matrix=coo_matrix((values,(row,col)),shape=(len(g),len(g))).tocsr()
        keep=np.array([i for i in range(len(g)) if i!=ids[b]])
        current=np.zeros(len(g));current[ids[a]]=1
        solution=spsolve(matrix[keep][:,keep],current[keep]);return float(solution[np.flatnonzero(keep==ids[a])[0]])
    result=[]
    for w in (2.,4.,14.):
        previous=None
        for step in (.25,.125):
            region=db.Region(db.DBox(0,-w/2,100,w/2).to_itype(.001))
            graph,points,widths=medial(region,step);g=nx.Graph()
            for a,b,d in graph.edges(data=True):connect(g,a,b,d['squares'])
            tree=cKDTree(points);a=int(tree.query((0,0))[1]);b=int(tree.query((100,0))[1])
            r=resistance(g,a,b)+math.dist(points[a],(0,0))/widths[a]+math.dist(points[b],(100,0))/widths[b]
            expected=100/w;error=r/expected-1
            assert -.03<=error<=.18,(w,step,r,expected,error)
            if previous is not None:assert abs(error)<abs(previous)
            previous=error;result.append(dict(width_um=w,grid_um=step,resistance_sheet_multiples=r,analytic=expected,error_fraction=error))
    g=nx.Graph()
    for a,b,r in [('s','a',2),('a','t',3),('s','b',4),('b','t',6)]:connect(g,a,b,r)
    before=resistance(g,'s','t');reduce_series(g,{'s','t'});after=resistance(g,'s','t')
    assert abs(before-10/3)<1e-12 and abs(after-before)<1e-12
    return dict(passed=True,straight_sheet_checks=result,parallel_path_resistance=after,
                limitations='Analytic checks bound sampling error for straight wires; arbitrary junctions remain an approximate medial-path model.')

if __name__=='__main__':
    answer=validate();write_json(REPORTS/'power_mesh_validation.json',answer);print(answer)
