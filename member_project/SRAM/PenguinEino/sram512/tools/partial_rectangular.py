#!/usr/bin/env python3
"""Refine selected routes while preserving all other real metal and GC."""
import argparse,shutil
from collections import defaultdict
from layout_rectangular import build
from physical_top import named_macro,verify_and_repair
from routing_poly import RouterPoly
from common import *

def main(signals,iterations=80,mirror_banks=False,source=None):
    layout,core,base,original=build(True,mirror_banks)
    source=Path(source).resolve() if source is not None else original
    info=json.loads((source/'routing/routing.json').read_text())
    route_options=json.loads((source/'routing/routing_input.json').read_text())
    base.via_pitch_nm=round(route_options.get('via_grid_um',5.5)*1000)
    assert info['node_names']=={str(v):k for k,v in base.ids.items()}
    assert info['grid_um']==base.step/1000
    assert json.loads((source/'placement.json').read_text())==json.loads((original/'placement.json').read_text())
    old=db.Layout();old.read(str(source/'placed.gds'))
    for li in layout.layer_indexes():
        spec=layout.get_info(li)
        assert (db.Region(core.begin_shapes_rec(li))^
                db.Region(old.cell('sram512').begin_shapes_rec(old.layer(spec)))).is_empty(),spec
    bad={base.ids[name] for name in signals};data=(source/'routing/routes.txt').read_text().splitlines()
    paths={};i=1
    while i<len(data):
        nid,n=map(int,data[i].split());i+=1
        if nid not in bad:paths[nid]=[tuple(map(int,line.split())) for line in data[i:i+n]]
        i+=n
    base.draw(paths)
    for nid,edges in paths.items():
        name=next(n for n,j in base.ids.items() if j==nid)
        if name in {'vdd','vss','clk','reset','sdi','we','sdo'}:continue
        u=next((u for edge in edges for u in edge if base.point(u)[0]<2),None)
        if u is None:continue
        k,point=base.point(u);parts=name.split('__')
        label='.'.join([s[1:] if s.startswith('x') else s for s in parts[:-1]]+parts[-1:]).upper()
        core.shapes(layout.layer(48+k,0)).insert(db.Text(label,db.Trans(point)))
    fine=RouterPoly.from_router(base,550,extra_um=(2.75,3.3))
    for k,layer in enumerate(((13,0),(20,0))):
        actual=db.Region(core.begin_shapes_rec(layout.layer(*layer)))
        native=sum((base.regions[k].get(nid,db.Region()) for nid in bad),db.Region())
        regs=defaultdict(db.Region);regs[-1]=actual-native
        for nid in bad:regs[nid]=base.regions[k].get(nid,db.Region())
        fine.regions[k]=regs
    # Start at the real driver. Joining dense gate-input escapes first can
    # consume the driver's only legal contact/metal escape in a greedy tree.
    def terminal_order(term):
        label=term[0]
        return (0 if label.startswith('PORT.') or label.rsplit('.',1)[-1] in ('Q','QB','Y') else 1,label)
    fine.pins={nid:sorted(base.pins[nid],key=terminal_order) for nid in bad}
    tag=hashlib.sha256(','.join(sorted(signals)).encode()).hexdigest()[:8]
    work=WORK/'layout'/(source.name+'_refined_'+tag);work.mkdir(parents=True,exist_ok=True)
    for name in ('placement.json','ports.json','array_geometry.json'):shutil.copy2(source/name,work/name)
    core.write(str(work/'placed.gds'))
    success=fine.route(work/'routing',iterations,selective=True)
    top=named_macro(layout,core,work,array_y=118.2)
    result=verify_and_repair(layout,top,work);box=top.dbbox()
    result.update(router_passed=success,rerouted_signals=signals,
                  dimensions_um=[box.width(),box.height()],physical_rows=16,physical_columns=32,
                  source_placement_sha256=sha(source/'placed.gds'))
    write_json(REPORTS/'layout_rectangular_refined.json',result)
    print(result['drc'],result['lvs'],result['dimensions_um'],flush=True)
    return success and all(result[k]['passed'] for k in ('drc','lvs')) and box.height()<=600+1e-6 and box.width()<=1800+1e-6

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('signals',nargs='+');p.add_argument('--iterations',type=int,default=80);p.add_argument('--mirror-banks',action='store_true');p.add_argument('--source',type=Path);a=p.parse_args()
    raise SystemExit(0 if main(a.signals,a.iterations,a.mirror_banks,a.source) else 1)
