#!/usr/bin/env python3
"""Move two decoder gates to free row-end sites and reroute affected nets.

PCell arrays and circuitry are unchanged. Retained routes are fixed physical
obstacles; only nets incident on a move, a crossing, or a new footprint are
routed again. Original foundry DRC and strict LVS remain the acceptance tests.
"""
import argparse
from common import *
from layout_rectangular import build
from route_local import read_paths
from repair_poly_crossings import route_shapes
from routing_poly import RouterPoly,route_connectivity
from physical_top import named_macro,verify_and_repair

def main(iterations=200):
    source=WORK/'layout/rectangular_mirrored_v2750'
    work=WORK/'layout/rectangular_relocated01'
    moves={'xcol_decode__xlow3':(1688.5,5.5),
           'xcol_decode__xhigh3':(1666.5,154.0)}
    layout,core,base,_=build(True,True,via_pitch_um=2.75,
                           placement_overrides=moves,output_work=work)
    original=json.loads((source/'placement.json').read_text())
    placed=json.loads((work/'placement.json').read_text())
    before={p['instance']:p for p in original}
    changed=[p for p in placed if p!=before[p['instance']]]
    assert {p['instance'] for p in changed}==set(moves)
    info=json.loads((source/'routing/routing.json').read_text())
    assert info['grid_um']==base.step/1000
    assert info['node_names']=={str(v):k for k,v in base.ids.items()}
    paths=read_paths(source/'routing/routes.txt')
    bad={base.ids[n] for n in ('ca1','reset','xcol_decode__cl0','ca2b','xrow__r1_2')}
    for nid,terms in base.pins.items():
        if any(any(label.startswith(name+'.') for name in moves) for label,_ in terms):
            if nid not in (base.ids['vdd'],base.ids['vss']):bad.add(nid)
    footprints=db.Region()
    for p in changed:
        cell=layout.cell(p['kind'])
        box=cell.bbox().transformed(db.Trans(round(p['x']*1000),round(p['y']*1000))).enlarged(7000)
        footprints.insert(box)
    # Retain no route through a moved cell's new active area or contacts.
    for nid,edges in paths.items():
        if nid in bad:continue
        regions,cuts=route_shapes(base,edges)
        if any(not (reg&footprints).is_empty() for reg in regions+cuts):bad.add(nid)
    names={v:k for k,v in base.ids.items()}
    print('Moved',list(moves),'reroute',len(bad),[names[n] for n in sorted(bad)],flush=True)
    retained={nid:edges for nid,edges in paths.items() if nid not in bad}
    base.draw(retained)
    fine=RouterPoly.from_router(base,2750)
    from collections import defaultdict
    for k,layer in enumerate(((13,0),(20,0))):
        actual=db.Region(core.begin_shapes_rec(layout.layer(*layer)))
        own={nid:base.regions[k].get(nid,db.Region()) for nid in bad}
        regs=defaultdict(db.Region);regs[-1]=actual-sum(own.values(),db.Region());regs.update(own)
        fine.regions[k]=regs
    fine.pins={nid:base.pins[nid] for nid in bad}
    core.write(str(work/'retained.gds'))
    success=fine.route(work/'routing',iterations,selective=True)
    new_paths=read_paths(work/'routing/routes.txt')
    combined={**retained,**new_paths}
    # Both passes have the same physical grid; record a complete route list
    # for extraction labels and subsequent local repair.
    output=[str(int(success))]
    for nid,edges in combined.items():
        output.append(f'{nid} {len(edges)}');output.extend(f'{a} {b}' for a,b in edges)
    (work/'routing/routes.txt').write_text('\n'.join(output)+'\n')
    route_info=json.loads((work/'routing/routing.json').read_text())
    route_info.update(relocated=changed,rerouted_nets=[names[n] for n in sorted(bad)],
                      source_gds_sha256=sha(source/'sram512.gds'))
    write_json(work/'routing/routing.json',route_info)
    top=named_macro(layout,core,work,array_y=118.2)
    result=verify_and_repair(layout,top,work);box=top.dbbox()
    result.update(router_passed=success,relocated=changed,dimensions_um=[box.width(),box.height()])
    write_json(work/'result.json',result)
    print(result['drc'],result['lvs'],result['dimensions_um'],flush=True)
    return success and all(result[k]['passed'] for k in ('drc','lvs'))

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('--iterations',type=int,default=200);a=p.parse_args()
    raise SystemExit(0 if main(a.iterations) else 1)
