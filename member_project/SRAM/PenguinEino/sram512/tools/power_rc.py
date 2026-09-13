"""Conservative supply-network resistance sensitivity from actual metal.

No foundry metal-resistance/RC corner is available in the public dev deck.
Sheet and via resistances are explicit experiment parameters. Each connected
metal polygon is represented by a star. Half its perimeter divided by the DRC
minimum width is used as a conservative route-square proxy. Actual widened
rails therefore receive no resistance credit. This is not a calibrated field
solver extraction or a mathematically certified bound. Current sharing
between individual parallel cuts is not resolved by this lumped model.
"""
import copy
import numpy as np
from shapely.geometry import Polygon,Point
from shapely.strtree import STRtree
from common import *
from power_grid import network

def add_power_rc(folder,original,sheet_ohm,via_ohm=1.0):
    assert sheet_ohm>0 and via_ohm>0
    l,nets=network(folder);core=l.cell('sram512');records=copy.deepcopy(original)
    lines=[];nodes=[];info={}
    for name,data in nets.items():
        slug=name.lower();parts=data['regions'];g=data['graph'];res={}
        def center(k,i):return f'power_{slug}_m{k+1}_{i}'
        def load(i):return f'power_{slug}_load_{i}'
        for k,regions in enumerate(parts):
            for i,region in enumerate(regions):
                squares=region.perimeter()/2/(1800 if k==0 else 3000)
                res[k,i]=max(.001,sheet_ohm*squares)
        # Every metal-to-metal edge has the two polygon half-resistances and
        # the explicit contact resistance. The graph retains physical loops.
        for j,(a,b,d) in enumerate(g.edges(data=True)):
            resistance=(res[a]+res[b])/2+via_ohm/d['cut_count']
            lines.append(f'Rpower_{slug}_edge_{j} {center(*a)} {center(*b)} {resistance:.12g}')
        labels=[s.text for s in core.shapes(l.layer(49,0)).each()
                if s.is_text() and s.text.string==name]
        assert len(labels)==1
        pt=labels[0].trans.disp
        source=next(i for i,r in enumerate(parts[1]) if not r.interacting(db.Region(db.Box(pt.x-1,pt.y-1,pt.x+1,pt.y+1))).is_empty())
        external='vdd' if name=='VDD' else '0'
        lines.append(f'Rpower_{slug}_port {external} {center(1,source)} {res[1,source]/2:.12g}')
        # Map a supply terminal to the nearest actual M1 of that same supply.
        # MOS locations are from the strict-LVS extraction, not the schematic.
        polygons=[]
        for region in parts[0]:
            p=next(region.each())
            polygons.append(Polygon([(q.x/1000,q.y/1000) for q in p.each_point_hull()],
                                    [[(q.x/1000,q.y/1000) for q in p.each_point_hole(h)] for h in range(p.holes())]))
        tree=STRtree(polygons);used=set();mapped=[]
        for record in records:
            pins=[p for p,n in record['nets'].items() if n==slug]
            if not pins:continue
            point=Point(record['position_um']);i=int(tree.nearest(point));used.add(i)
            for pin in pins:record['nets'][pin]=load(i)
            mapped.append(dict(instance=record['instance'],model=record['model'],pins=pins,
                               m1_component=i,distance_um=float(point.distance(polygons[i]))))
        for i in sorted(used):
            lines.append(f'Rpower_{slug}_load_{i} {center(0,i)} {load(i)} {res[0,i]/2:.12g}')
            nodes.append(load(i))
        info[name]=dict(metal_components=len(g),via_groups=g.number_of_edges(),
                        load_groups=len(used),maximum_polygon_resistance_ohm=max(res.values()),
                        maximum_terminal_mapping_distance_um=max(v['distance_um'] for v in mapped),
                        terminal_map=mapped)
    return records,lines,nodes,dict(sheet_ohm=sheet_ohm,via_ohm=via_ohm,networks=info,
        scope=__doc__,source_gds_sha256=sha(folder/'sram512.gds'))

def verify_power(path,case,vdd):
    from analog import load_raw
    t,w=load_raw(path);rows=[]
    for supply,prefix in [('VDD','v(power_vdd_load_'),('VSS','v(power_vss_load_')]:
        for name,v in w.items():
            if not name.startswith(prefix):continue
            # Include start-up and every active access; the separate digital
            # checks assess the guaranteed voltage windows at sampling times.
            rows.append(dict(supply=supply,node=name[2:-1],min_v=float(v.min()),max_v=float(v.max())))
    assert rows
    return dict(load_nodes=len(rows),
                minimum_vdd=min(v['min_v'] for v in rows if v['supply']=='VDD'),
                maximum_vdd=max(v['max_v'] for v in rows if v['supply']=='VDD'),
                minimum_vss=min(v['min_v'] for v in rows if v['supply']=='VSS'),
                maximum_vss=max(v['max_v'] for v in rows if v['supply']=='VSS'),
                worst_vdd_nodes=sorted((v for v in rows if v['supply']=='VDD'),key=lambda v:v['min_v'])[:5],
                worst_vss_nodes=sorted((v for v in rows if v['supply']=='VSS'),key=lambda v:-v['max_v'])[:5])
