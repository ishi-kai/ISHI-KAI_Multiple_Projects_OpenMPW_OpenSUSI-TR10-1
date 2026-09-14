"""Geometry-based RC sensitivity model, not a calibrated foundry RC deck.

Actual conductor area/perimeter are read from the official extracted connectivity.
The explicit sheet-R and area/edge-C assumptions are swept. Four sections model
BL, WL and common-line loading; other gate loads receive unequal branch RC.
"""
import copy,math
import numpy as np
from collections import defaultdict
from common import *
from postlayout import observation_name

COEFFICIENTS={
    'M1':dict(width_um=1.8,sheet_ohm=1.0,area_ff_um2=.05,edge_ff_um=.02),
    'M2':dict(width_um=3.4,sheet_ohm=1.0,area_ff_um2=.03,edge_ff_um=.02),
    # An explicit sensitivity assumption, not a foundry value for GC wiring.
    # The published 120 ohm/square RS resistor specification does not
    # characterize a narrow field-GC interconnect or its contacts.
    'GC_field':dict(width_um=1.0,sheet_ohm=120.0,area_ff_um2=.05,edge_ff_um=.02),
}

def geometry(folder):
    v=db.LayoutVsSchematic();v.read(str(folder/'checks/sram512_macro.lvsdb'))
    l=db.Layout();l.read(str(folder/'sram512.gds'));core=l.cell('sram512')
    c=v.netlist().circuit_by_name(core.name)
    names={p.first().cluster_id:observation_name(p.second().name) for p in v.xref().each_net_pair(c)
           if p.first() is not None and p.second() is not None}
    layers={}
    for name,num,datatype in [('M1',13,0),('M2',20,0),('GC_field',8,1)]:
        layers[name]=extracted_layer_index(v,l,core,(num,datatype))
    active=(db.Region(core.begin_shapes_rec(l.layer(3,1)))+
            db.Region(core.begin_shapes_rec(l.layer(3,2)))).merged()
    out={}
    def measure(n,name,transform):
        if name in ('vdd','vss'):return
        entry={};cap=0;res=0
        for layer,idx in layers.items():
            g=v.polygons_of_net(n,idx,True).merged()
            if layer=='GC_field':
                # Bring private child nets into top-cell coordinates before
                # excluding active overlap. The MOS model already supplies
                # the intrinsic gate capacitance in those channel regions.
                tr=db.ICplxTrans(transform.mag,transform.angle,transform.is_mirror(),
                                  round(transform.disp.x*1000),round(transform.disp.y*1000))
                g=(g.transformed(tr)-active).merged()
            a=g.area()*1e-6;p=g.perimeter()*1e-3;co=COEFFICIENTS[layer]
            cap+=a*co['area_ff_um2']+p*co['edge_ff_um']
            # Total square count is a conservative series sum of all branches,
            # not an assertion that the physical branched net is a single wire.
            res+=a/co['width_um']**2*co['sheet_ohm']
            entry[layer]=dict(area_um2=a,perimeter_um=p)
        entry.update(cap_ff=cap,resistance_series_sum_ohm=res);out[name]=entry
    sequence=0
    def walk(circuit,mapping,transform,top=False):
        nonlocal sequence
        sequence+=1;inst=sequence
        local={n.cluster_id:mapping.get(n.cluster_id,f'physical_{inst}_{n.cluster_id}') for n in circuit.each_net()}
        for n in circuit.each_net():
            # Parent extraction already includes metal of connected child pins.
            # Child-private wires must be counted here, once per placed cell.
            if top or n.cluster_id not in mapping:measure(n,local[n.cluster_id],transform)
        for sub in circuit.each_subcircuit():
            child=sub.circuit_ref()
            pins={child.net_for_pin(p.id()).cluster_id:local[sub.net_for_pin(p.id()).cluster_id] for p in child.each_pin()}
            walk(child,pins,transform*sub.trans)
    walk(c,names,db.DCplxTrans(),True)
    # Conservation check across hierarchy: every signal field-GC polygon
    # must be accounted for once, including transformed private child nets.
    gc=db.Region(core.begin_shapes_rec(l.layer(8,1)))
    power_gc=db.Region()
    for n in c.each_net():
        if names.get(n.cluster_id) in ('vdd','vss'):
            power_gc+=v.polygons_of_net(n,layers['GC_field'],True)
    expected=(gc-active-power_gc).merged().area()*1e-6
    measured=sum(entry['GC_field']['area_um2'] for entry in out.values())
    assert abs(expected-measured)<1e-5,(expected,measured,'field-GC area accounting')
    return out

def add_rc(folder,original,scale,physical_gate_paths=False,signal_mesh=False,signal_sections=4):
    assert scale>0
    records=copy.deepcopy(original);geo=geometry(folder)
    gate_paths=None
    if physical_gate_paths:
        from gate_paths import calculate
        gate_paths=calculate(folder,original,COEFFICIENTS)
    lines=[];nodes=[];done=set();ladder_nets={};groups_info={}
    mesh_names={f'wl{r}' for r in range(16)}|{'xctrl.xphase.c4b'} if signal_mesh else set()
    mesh_info=None
    def node(n,i):return 'rc_'+n.replace('.','_')+'_'+str(i)
    def ladder(net,loads):
        if not loads:return
        info=geo[net];r=max(.01,info['resistance_series_sum_ohm']*scale)/4
        cap=max(.001,info['cap_ff']*scale)/4
        ns=[net]+[node(net,i) for i in range(1,5)]
        for i in range(1,5):
            lines.extend([f'Rwire_{len(lines)} {ns[i-1]} {ns[i]} {r:.12g}',
                          f'Cwire_{len(lines)+1} {ns[i]} 0 {cap:.12g}f'])
        for record,pin,segment in loads:record['nets'][pin]=ns[segment]
        done.add(net);nodes.extend(ns[1:]);ladder_nets[net]=dict(resistance_ohm=4*r,cap_ff=4*cap)
    # Six-transistor cell accesses retain their logical row/column identity
    # through the independently matched LVS net correspondence.
    bitloads=defaultdict(list);wlloads=defaultdict(list);common=defaultdict(list)
    for record in records:
        if record['model'] not in ('NMOS','PMOS'):continue
        ns=record['nets'];q=next((n for n in ns.values() if re.match(r'xarray\.xr\d+c\d+\.q',n)),None)
        if q:
            m=re.search(r'xr(\d+)c(\d+)',q);row,col=map(int,m.groups())
            for pin,n in ns.items():
                if re.fullmatch(r'blb?\d+',n):bitloads[n].append((record,pin,row//4+1))
                if re.fullmatch(r'wl\d+',n):wlloads[n].append((record,pin,(31-col)//8+1))
        if record['model']=='NMOS' and re.fullmatch(r'col\d+',ns['G']):
            for pin,n in ns.items():
                if n in ('y','yb'):common[n].append((record,pin,int(ns['G'][3:])))
    for n,loads in {**bitloads,**wlloads}.items():
        if n not in mesh_names:ladder(n,loads)
    for n,loads in common.items():
        drivers=[r['position_um'] for r in records if r['model'] in ('NMOS','PMOS') and r['nets'].get('G') in ('preb','pd_y','pd_yb')
                 and n in (r['nets']['D'],r['nets']['S'])]
        assert drivers,n
        x=sum(p[0] for p in drivers)/len(drivers);y=sum(p[1] for p in drivers)/len(drivers)
        ranked=sorted(loads,key=lambda t:math.hypot(t[0]['position_um'][0]-x,t[0]['position_um'][1]-y))
        ladder(n,[(r,p,i//8+1) for i,(r,p,col) in enumerate(ranked)])
    if mesh_names:
        from signal_mesh import add_mesh
        mesh_lines,mesh_nodes,mesh_info=add_mesh(folder,records,geo,COEFFICIENTS,mesh_names,scale,signal_sections)
        lines+=mesh_lines;nodes+=mesh_nodes;done|=mesh_names
        for n,info in mesh_info['nets'].items():
            if n.startswith('wl'):
                ladder_nets[n]=dict(resistance_ohm=info['maximum_path_ohm']*scale,
                                   cap_ff=info['cap_ff']*scale,topology='physical branched signal mesh')
    for n,info in geo.items():
        if n in done or info['cap_ff']==0:continue
        # Feedback nodes within the bitcell keep local interconnect capacitance.
        groups=defaultdict(list)
        if not n.startswith(('xarray.','physical_')):
            for r in records:
                if r['model'] in ('NMOS','PMOS') and r['nets']['G']==n:groups[r['instance']].append(r)
        if not groups:
            lines.append(f'Cwire_{len(lines)} {n} 0 {info["cap_ff"]*scale:.12g}f');continue
        drivers=[r['position_um'] for r in records if r['model'] in ('NMOS','PMOS') and n in (r['nets']['D'],r['nets']['S'])]
        source=drivers[0] if drivers else [1793,250]
        distances={i:max(math.hypot(r['position_um'][0]-source[0],r['position_um'][1]-source[1]) for r in rs) for i,rs in groups.items()}
        longest=max(max(distances.values()),1)
        for i,rs in groups.items():
            load=node(n,'g'+str(i));factor=.25+.75*distances[i]/longest
            resistance=max(.01,info['resistance_series_sum_ohm']*scale*factor)
            if gate_paths and n in gate_paths['nets']:
                resistance=max(.01,gate_paths['nets'][n]['branches'][str(i)]*scale)
            cap=info['cap_ff']*scale/len(groups)
            lines.extend([f'Rwire_{len(lines)} {n} {load} {resistance:.12g}',
                          f'Cwire_{len(lines)+1} {load} 0 {cap:.12g}f'])
            for r in rs:r['nets']['G']=load
            if n in ('xctrl.cki','xctrl.rsti','preb','sae','wl_en'):nodes.append(load)
        groups_info[n]=dict(branches=len(groups),series_sum_ohm=info['resistance_series_sum_ohm']*scale,cap_ff=info['cap_ff']*scale)
    summary=dict(kind='geometry-based RC sensitivity; uncalibrated coefficients',scale=scale,
                 coefficients=COEFFICIENTS,segments=4,ladder_nets=ladder_nets,gate_loads=groups_info,
                 assumptions=['Series square count sums all conductor branches conservatively.',
                              'Field GC excludes active overlap; intrinsic MOS gate capacitance is not added twice.',
                              'GC sheet R=120 ohm/square is an uncalibrated sensitivity assumption; it is not a qualified GC wiring coefficient.',
                              'CO contact resistance is not separately calibrated or modeled.',
                              'Capacitance is represented to ground; scale sweep also stresses coupling load.',
                              'Power-rail resistance is not included in this signal-RC model.'],geometry=geo)
    if gate_paths:
        summary['gate_path_model']=dict(model=gate_paths['model'],scope=gate_paths['scope'],
            gds_sha256=gate_paths['gds_sha256'],nets=gate_paths['nets'])
        summary['assumptions'][0]='BL/WL/common lines retain the series-sum stress model; other gate branches use real shortest resistive paths as two-terminal resistance bounds.'
    if mesh_info:
        summary['signal_mesh']=mesh_info
        summary['assumptions'][0]='WL and C4B retain actual conductor branches and loops; remaining BL/common lines keep the earlier ladder stress model and other gate branches the documented branch approximation.'
    return records,lines,nodes,summary

def verify_rc(path,case,vdd=5):
    """Check physical RC load nodes, including the ends of every array wire."""
    from analog import load_raw
    t,w=load_raw(path);period=case['period_ns'];failures=[];checks=0
    def vector(name):return w['v('+name+')']
    def level(name,b,a,z=None):
        nonlocal checks
        checks+=1;v=vector(name)
        values=np.array([np.interp(a,t,v)]) if z is None else v[np.searchsorted(t,a):np.searchsorted(t,z,'right')]
        assert len(values),(name,a,z)
        low=float(values.min());high=float(values.max())
        if low<.9*vdd if b else high>.1*vdd:
            failures.append(dict(net=name,expected=b,start_ns=a,end_ns=z,min_v=low,max_v=high))
    for op in case['operations']:
        e=op['e0'];first=op['first']
        for row in range(16):
            for prefix in ('wl',):
                for segment in range(1,5):
                    name=f'rc_{prefix}{row}_{segment}'
                    level(name,0,first+.3*period,e+2.9*period)
                    level(name,int(row==op['row']),e+3.3*period,e+4.9*period)
                    level(name,0,e+5.3*period,e+7.8*period)
        for col in range(32):
            for prefix in ('bl','blb'):
                for segment in range(1,5):level(f'rc_{prefix}{col}_{segment}',1,e+.8*period)
        for name in ('y','yb'):
            for segment in range(1,5):level(f'rc_{name}_{segment}',1,e+.8*period)
        for key in w:
            if key.startswith('v(rc_preb_g'):
                name=key[2:-1];level(name,0,e+.7*period,e+.9*period);level(name,1,e+1.3*period,e+7.8*period)
            elif key.startswith('v(rc_sae_g'):
                name=key[2:-1]
                level(name,int(op['write']),e+.3*period,e+3.9*period)
                level(name,1,e+4.3*period,e+7.8*period)
    clock_nodes=[key[2:-1] for key in w if key.startswith('v(rc_xctrl_cki_g')]
    assert len(clock_nodes)>=21,len(clock_nodes)
    rising=[];falling=[]
    def crossing(name,a,rise):
        nonlocal checks
        checks+=1
        lo=max(0,np.searchsorted(t,a)-1);hi=np.searchsorted(t,a+.3*period)
        v=vector(name)[lo:hi];ti=t[lo:hi]
        mask=(v[:-1]<vdd/2)&(v[1:]>=vdd/2) if rise else (v[:-1]>vdd/2)&(v[1:]<=vdd/2)
        ix=np.flatnonzero(mask)
        if len(ix)!=1:
            failures.append(dict(net=name,start_ns=a,rise=rise,crossings=len(ix)));return float('nan')
        i=ix[0];return float(ti[i]+(vdd/2-v[i])*(ti[i+1]-ti[i])/(v[i+1]-v[i]))
    for op in case['operations']:
        for j in range(18):
            start=op['first']+j*period
            rising.append([crossing(n,start,True) for n in clock_nodes])
            falling.append([crossing(n,start+.5*period,False) for n in clock_nodes])
    rising=np.array(rising);falling=np.array(falling)
    return dict(passed=not failures,checks=checks,failure_count=len(failures),failures=failures[:40],
                clock_branches=len(clock_nodes),
                maximum_clock_rising_skew_ns=float(np.nanmax(np.ptp(rising,axis=1))),
                minimum_clock_high_ns=float(np.nanmin(falling-rising)),
                minimum_clock_low_ns=float(np.nanmin(rising[1:]-falling[:-1])),
                scope='All four BL/WL/common-line RC sections, control gate loads, and every physical clock branch.')
