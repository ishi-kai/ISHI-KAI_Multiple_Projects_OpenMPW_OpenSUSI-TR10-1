#!/usr/bin/env python3
"""Hierarchical HA: unchanged BT primitives, two rows and a central routing channel."""
from pathlib import Path
import hashlib
import json
import pya as db
from arithmetic_helpers import import_tree

ROOT = Path(__file__).resolve().parents[1]
DBU = .001
M1, M2, V1 = (13,0), (20,0), (19,0)
PLACEMENTS = [
    ('x_na', 'inverter', 40, 200, {'vin':'a', 'vout':'na'}),
    ('x_t', 'nany', 160, 200, {'a':'a', 'b':'b', 'vout':'t'}),
    ('x_u', 'nany', 328, 200, {'a':'b', 'b':'t', 'vout':'u'}),
    ('x_c', 'nany', 496, 200, {'a':'na', 'b':'u', 'vout':'carry'}),
    ('x_d', 'nany', 184, 0, {'a':'t', 'b':'carry', 'vout':'d'}),
    ('x_nd', 'inverter', 352, 0, {'vin':'d', 'vout':'nd'}),
    ('x_s', 'nany', 508, 0, {'a':'nd', 'b':'carry', 'vout':'sum'}),
]
TRACKS = {name:128+6*i for i,name in enumerate(['a','b','t','u','na','carry','d','nd','sum','VMID'])}

def build():
    sources = [ROOT/'inverter.gds', ROOT/'nany.gds']
    layout = db.Layout(); layout.dbu = DBU; layout.technology_name = 'TR-1um'
    top = layout.create_cell('half_adder')
    cells = {name:import_tree(layout,ROOT/(name+'.gds'),name) for name in ('inverter','nany')}
    metadata = {name:json.loads((ROOT/f'layout/{name}.ports.json').read_text()) for name in cells}
    routes = []; endpoints = {name:[] for name in TRACKS}; placements=[]
    def box(layer,x0,y0,x1,y1):
        top.shapes(layout.layer(*layer)).insert(db.Box(*[round(v/DBU) for v in (x0,y0,x1,y1)]))
    def wire(net,layer,points,width=3.4):
        h=width/2
        for (x,y),(xx,yy) in zip(points,points[1:]):
            assert x==xx or y==yy
            box(layer,min(x,xx)-h,min(y,yy)-h,max(x,xx)+h,max(y,yy)+h)
        routes.append(dict(net=net,layer=layer,points_um=points,width_um=width))
    def via(net,x,y):
        box(V1,x-.7,y-.7,x+.7,y+.7)
        for layer in (M1,M2):box(layer,x-1.7,y-1.7,x+1.7,y+1.7)
    def label(name,layer,x,y):
        target=(48,0) if layer==M1 else (49,0)
        top.shapes(layout.layer(*target)).insert(db.Text(name,db.Trans(round(x/DBU),round(y/DBU))))
    for role,kind,x,y,pins in PLACEMENTS:
        instance=top.insert(db.CellInstArray(cells[kind].cell_index(),db.Trans(round(x/DBU),round(y/DBU))))
        instance.set_property('role',role)
        assert abs(cells[kind].dbbox().width()-metadata[kind]['width_um'])<1e-9
        placements.append(dict(role=role,cell=kind,origin_um=[x,y],pins=pins))
        ports=metadata[kind]['ports']; width=metadata[kind]['width_um']
        upper=y>0
        for port,net in dict(pins,**({'VMID':'VMID'} if kind=='nany' else {})).items():
            px,py=ports[port]['position_um']; px+=x; py+=y
            if port=='vout':ex=x+width-4
            elif kind=='inverter':ex=x-14
            else:
                offsets={'a':18,'b':12,'VMID':6} if upper else {'a':6,'b':12,'VMID':18}
                ex=x-offsets[port]
            layer=tuple(ports[port]['layer'])
            wire(net,layer,[(px,py),(ex,py)])
            if layer==M1:via(net,ex,py)
            ty=TRACKS[net]
            wire(net,M2,[(ex,py),(ex,ty)])
            via(net,ex,ty); endpoints[net].append(ex)
        if kind=='inverter':
            # Bring short INV VDD rail to the shared row VDD height in its empty right gutter.
            _,py=ports['VDD']['position_um'];py+=y
            wire('VDD',M1,[(x+width-1.7,py),(x+width+12,py),(x+width+12,y+113.3)])
    # Shared row power rails. Vertical signals use M2 and cross these without vias.
    # Preserve the right-side lower-row VMID access used by the hand-routed FA.
    wire('VMID',M2,[(588,38),(642,38)])
    for y in (0,200):
        for net,dy,gx in [('VSS',1.7,10),('VDD',113.3,4)]:
            lo,hi=(-14.3,1.7) if net=='VSS' else (-1.7,10.3)
            box(M1,0,y+dy+lo,660,y+dy+hi)
            direction=-1 if net=='VSS' else 1
            count=4 if net=='VSS' else 3
            for j in range(count):via(net,gx,y+dy+direction*4*j)
            wire(net,M2,[(gx,y+dy),(gx,y+dy+direction*4*(count-1))])
    wire('VDD',M2,[(4,113.3),(4,313.3)])
    wire('VSS',M2,[(10,1.7),(10,201.7)])
    portspec={}
    for net in TRACKS:
        y=TRACKS[net];xs=endpoints[net]
        if net in ('a','b','VMID'): xs.append(20)
        if net in ('carry','sum'): xs.append(656)
        wire(net,M1,[(min(xs),y),(max(xs),y)])
        if net in ('a','b','VMID','carry','sum'):
            x=20 if net in ('a','b','VMID') else 656
            label(net,M1,x,y)
            portspec[net]=dict(layer=M1,label_layer=(48,0),position_um=[x,y])
    for net,x,y in [('VDD',656,313.3),('VSS',656,1.7)]:
        label(net,M1,x,y)
        portspec[net]=dict(layer=M1,label_layer=(48,0),position_um=[x,y])
    # Verify the library merge did not change any primitive geometry (including name collisions).
    for kind,c in cells.items():
        src=db.Layout();src.read(str(ROOT/f'{kind}.gds'))
        for info in src.layer_infos():
            assert (db.Region(c.begin_shapes_rec(layout.layer(info))) ^ db.Region(src.cell(kind).begin_shapes_rec(src.layer(info)))).is_empty(),(kind,str(info))
    target=ROOT/'half_adder.gds';layout.write(str(target))
    meta=dict(top_cell='half_adder',dbu_um=DBU,placement_grid_um=.05,library='BT',
              sources={p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in sources},
              instances=placements,ports=portspec,routes=routes,tracks_um=TRACKS,
              bbox_um=[top.dbbox().left,top.dbbox().bottom,top.dbbox().right,top.dbbox().top],
              device_counts=dict(PMOS=22,NMOS=22,F_RR=14),
              gds_sha256=hashlib.sha256(target.read_bytes()).hexdigest())
    (ROOT/'layout/half_adder.ports.json').write_text(json.dumps(meta,indent=2)+'\n')
    print(target,top.dbbox())

if __name__=='__main__':build()
