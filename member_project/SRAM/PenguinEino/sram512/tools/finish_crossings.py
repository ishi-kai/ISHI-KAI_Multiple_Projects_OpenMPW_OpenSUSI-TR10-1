#!/usr/bin/env python3
"""Resolve local crossing geometry on the 50 nm process drawing grid.

The coarse routing grid misses narrow legal metal corridors. These explicit
paths use measured clearances and existing contact sites. Native devices,
schematic connectivity and all foundry checks are unchanged.
"""
import shutil
from common import *
from layout_rectangular import build
from routing_poly import read_paths
from physical_top import named_macro,verify_and_repair

def main():
    source=WORK/'layout/rectangular_mirrored_v2750'
    work=WORK/'layout/rectangular_manual_channels'
    layout,core,r,_=build(True,True)
    old=db.Layout();old.read(str(source/'placed.gds'))
    for i in layout.layer_indexes():
        spec=layout.get_info(i)
        assert (db.Region(core.begin_shapes_rec(i))^
                db.Region(old.cell('sram512').begin_shapes_rec(old.layer(spec)))).is_empty(),spec
    paths=read_paths(source/'routing/routes.txt');plane=r.nx*r.ny
    def node(layer,x,y):
        assert round(x*1000)%r.step==0 and round(y*1000)%r.step==0
        return layer*plane+round(y*1000)//r.step*r.nx+round(x*1000)//r.step
    def remove(name,layer,points,contacts=()):
        edges=set()
        for a,b in zip(points,points[1:]):
            u=node(layer,*a);v=node(layer,*b)
            delta=1 if a[1]==b[1] else r.nx
            if v<u:delta=-delta
            while u!=v:edges.add(frozenset((u,u+delta)));u+=delta
        for x,y in contacts:edges.add(frozenset((node(0,x,y),node(layer,x,y))))
        nid=r.ids[name];before=paths[nid]
        after=[e for e in before if frozenset(e) not in edges]
        assert len(before)-len(after)==len(edges),(name,len(before)-len(after),len(edges))
        paths[nid]=after
    # CL0 already has two M1/GC contacts at y=66. Replace the complete GC
    # U-shaped bridge with M1, using the open corridor above the VDD rail.
    remove('xcol_decode__cl0',2,[(1306.25,66),(1306.25,63.25),(1322.75,63.25),(1322.75,66)],
           contacts=[(1306.25,66),(1322.75,66)])
    # Move a short field-GC leg 2 um to the right, leaving enough room for
    # a new CA2B contact to the left and its M1 crossing above the other net.
    remove('xrow__r1_2',2,[(1080.75,225.5),(1083.5,225.5),(1083.5,217.25),(1080.75,217.25)])
    remove('ca2b',2,[(1078,222.75),(1089,222.75)],contacts=[(1089,222.75)])
    remove('ca2b',0,[(1089,222.75),(1091.75,222.75),(1091.75,220),(1094.5,220)])
    remove('xcol_decode__ch3',0,[(1075.25,220),(1080.75,220),(1080.75,217.25),(1083.5,217.25)])
    remove('ca1',1,[(1325.5,41.25),(1325.5,52.25)])
    remove('reset',1,[(1317.25,46.75),(1331,46.75),(1331,49.5),(1333.75,49.5),(1333.75,60.5),(1331,60.5),(1331,66)],contacts=[(1331,66)])
    remove('reset',0,[(1331,66),(1331,68.75),(1336.5,68.75)])
    remove('reset',1,[(1336.5,68.75),(1342,68.75),(1342,66)],contacts=[(1336.5,68.75),(1342,66)])
    remove('reset',0,[(1342,66),(1347.5,66)])
    work.mkdir(parents=True,exist_ok=True);(work/'routing').mkdir(exist_ok=True)
    for name in ('placement.json','ports.json','array_geometry.json','placed.gds'):shutil.copy2(source/name,work/name)
    for name in ('router.bin','routing_input.json'):shutil.copy2(source/'routing'/name,work/'routing'/name)
    output=['0']
    for nid,edges in paths.items():output.append(f'{nid} {len(edges)}');output.extend(f'{a} {b}' for a,b in edges)
    (work/'routing/routes.txt').write_text('\n'.join(output)+'\n')
    info=json.loads((source/'routing/routing.json').read_text());info['gc_routes']=r.draw(paths)
    edits=[]
    def wire(name,layer,points,width):
        assert all(round(v*1000)%50==0 for pt in points for v in pt)
        spec={'M1':(13,0),'M2':(20,0),'GC':(8,1)}[layer]
        shape=db.DPath([db.DPoint(*p) for p in points],width,width/2,width/2).to_itype(.001).polygon()
        core.shapes(layout.layer(*spec)).insert(shape)
        edits.append(dict(net=name,layer=layer,points_um=points,width_um=width))
    wire('COL_DECODE.CL0','M1',[(1306.25,66),(1306.25,64.55),(1322.75,64.55),(1322.75,66)],1.8)
    wire('ROW.R1_2','GC',[(1080.75,225.5),(1085.5,225.5),(1085.5,217.25),(1080.75,217.25)],1)
    wire('CA2B','GC',[(1078,222.75),(1081.75,222.75),(1081.75,222.25)],1)
    wire('CA2B','M1',[(1081.75,222.25),(1094.5,222.25),(1094.5,220)],1.8)
    wire('CA2B','M1',[(1094.5,220),(1094.5,222.25)],2.6)
    wire('COL_DECODE.CH3','M1',[(1075.25,220),(1077,220),(1077,218.55),(1083.5,218.55),(1083.5,217.25)],1.8)
    for spec,half in [((13,0),1.3),((8,1),1.3),((11,0),.5)]:
        core.shapes(layout.layer(*spec)).insert(db.DBox(1081.75-half,222.25-half,1081.75+half,222.25+half).to_itype(.001))
    from metal_detour import detour,draw_detour
    ca1_detour=detour(layout,core,r,'ca1',(1,1325.5,41.25),(1,1325.5,52.25),work/'ca1_detour',
                        bounds=(1250,0,1375,80),allow_gc=True,
                        reserved=[(1,[(1317.25,46.75),(1331,46.75)],3.4)],emit=False)
    assert ca1_detour['contacts'][-2:]==[{'kind':'CO','point_um':[1326.4,64.55]},
                                        {'kind':'V1','point_um':[1326.8,64.95]}]
    # The search considers new contacts separately. Separate this new V1
    # from the new CO and GC landing; stacked contacts are not permitted.
    ca1_detour['contacts'][-1]['point_um']=[1330.05,66]
    ca1_detour['paths'][-2]['points_um']=[[1326.4,64.55],[1330.05,64.55],[1330.05,66]]
    ca1_detour['paths'][-1]['points_um']=[[1330.05,66],[1325.5,66],[1325.5,52.25]]
    ca1_detour['contact_escape']='V1 moved away from the new field-GC contact.'
    draw_detour(layout,core,r,'ca1',ca1_detour)
    write_json(work/'ca1_detour/detour.json',ca1_detour)
    reset_detour=detour(layout,core,r,'reset',(1,1317.25,46.75),(0,1347.5,66),work/'reset_detour',
                        bounds=(1250,0,1375,80))
    wire('RESET','M1',[(1347.5,66),(1347.5,68.75)],3.4)
    info.update(passed=False,manual_paths=edits,source_gds_sha256=sha(source/'sram512.gds'))
    info['ca1_detour']=ca1_detour;info['reset_detour']=reset_detour
    write_json(work/'routing/routing.json',info)
    top=named_macro(layout,core,work,array_y=118.2)
    from physical_hierarchy import column_gate_wrappers
    info['column_gate_hierarchy']=column_gate_wrappers(layout,top)
    write_json(work/'routing/routing.json',info)
    result=verify_and_repair(layout,top,work);box=top.dbbox()
    result.update(manual_paths=edits,dimensions_um=[box.width(),box.height()])
    write_json(work/'result.json',result)
    print(result['drc'],result['lvs'],result['dimensions_um'],flush=True)
    return all(result[k]['passed'] for k in ('drc','lvs'))

if __name__=='__main__':raise SystemExit(0 if main() else 1)
