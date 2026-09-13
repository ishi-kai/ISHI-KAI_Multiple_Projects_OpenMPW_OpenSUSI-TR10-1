"""Name physical interconnect and verify a seven-port SRAM macro.

The wrapper is an ordinary hierarchy level, also present in Xschem. Internal
wire labels aid LVS correspondence without exposing extra package pins.
No rule, comparison setting, device, or electrical connection is changed.
"""
import math, struct
from common import *
from routing import M1,M2

def named_macro(layout,core,work,array_y=147,column_label_y=61.5):
    info=json.loads((work/'routing/routing.json').read_text())
    names={int(k):v for k,v in info['node_names'].items()}
    nx,ny,_,_=struct.unpack('4i',(work/'routing/router.bin').read_bytes()[:16])
    step=round(info['grid_um']*1000);plane=nx*ny
    lines=(work/'routing/routes.txt').read_text().splitlines();i=1
    ports={'VDD','VSS','CLK','RESET','SDI','WE','SDO'}
    while i<len(lines):
        nid,n=map(int,lines[i].split());i+=1
        # A field-GC route must still receive its electrical correspondence
        # label on an actual M1/M2 segment, as required by the official deck.
        edges=[tuple(map(int,v.split())) for v in lines[i:i+n]];i+=n
        edge=next(((a,b) if a//plane<2 else (b,a) for a,b in edges if min(a//plane,b//plane)<2),None)
        name=names[nid]
        if edge and name.upper() not in ports:
            u=edge[0];layer=u//plane;v=u%plane
            point=db.Point((v%nx)*step,(v//nx)*step)
            path=name.split('__')
            label='.'.join([s[1:] if s.startswith('x') else s for s in path[:-1]]+path[-1:]).upper()
            core.shapes(layout.layer(48+layer,0)).insert(db.Text(label,db.Trans(point)))
    for p in json.loads((work/'placement.json').read_text()):
        if not p['instance'].startswith('bank'):continue
        b=int(p['instance'][-1])
        tr=db.Trans(p.get('rotation',0)//90,p.get('mirror',False),round(p['x']*1000),round(p['y']*1000))
        for col in range(16):
            logical_col=p.get('logical_columns',list(range(b*16,b*16+16)))[col]
            for prefix,x in [('BL',col*22-.4),('BLB',col*22+18.4)]:
                point=tr*db.Point(round(x*1000),round((array_y+5.7)*1000))
                core.shapes(layout.layer(48,0)).insert(db.Text(prefix+str(logical_col),db.Trans(point)))
            point=tr*db.Point(round((col*22+(11 if column_label_y==-11 else 16.5))*1000),round(column_label_y*1000))
            core.shapes(layout.layer(49,0)).insert(db.Text('COL'+str(logical_col),db.Trans(point)))
    top=layout.create_cell('sram512_macro')
    top.insert(db.CellInstArray(core.cell_index(),db.Trans()))
    for layer in (48,49):
        for shape in core.shapes(layout.layer(layer,0)).each():
            if shape.is_text() and shape.text.string.upper() in ports:
                top.shapes(layout.layer(layer,0)).insert(shape.text)
    return top

def reference(work):
    from schematics import macro
    macro()
    source=netlist(ROOT/'sram512/schematics/sram512_macro.sch',work/'schematic',lvs=True)
    text=source.read_text()
    return re.sub(r'(?im)^X(\S+)(\s+\S+\s+\S+\s+\S+\s+\S+\s+(?:NMOS|PMOS)\b)',r'M\1\2',text)

def verify_and_repair(layout,top,work):
    """Repair a narrow same-net junction only after strict LVS has matched.

    The repair is real M1 on the process drawing grid. A conservative spacing
    check excludes all other actual metal; official DRC and LVS are rerun.
    """
    gds=work/'sram512.gds';top.write(str(gds))
    ref=work/'reference.spice';ref.write_text(reference(work))
    result=verify_layout(gds,top.name,ref,work/'checks')
    if not result['lvs']['passed'] or result['drc']['passed']:return result
    v=db.LayoutVsSchematic();v.read(str(work/'checks'/f'{top.name}.lvsdb'))
    core=layout.cell('sram512');circuit=v.netlist().circuit_by_name(core.name)
    actual=db.Region(core.begin_shapes_rec(layout.layer(*M1)))
    index=next(i for i in v.layer_indexes() if (v.layer_by_index(i)^actual).is_empty())
    added=db.Region();repairs=[]
    for net in circuit.each_net():
        own=v.polygons_of_net(net,index,True)
        for pair in own.width_check(1800).each():
            b=pair.bbox().enlarged(1000)
            b=db.Box(math.floor(b.left/50)*50,math.floor(b.bottom/50)*50,
                     math.ceil(b.right/50)*50,math.ceil(b.top/50)*50)
            pad=db.Region(b)
            if not (pad.sized(1400)&(actual-own)).is_empty():continue
            added+=pad;repairs.append(dict(net=net.name,box_nm=str(b)))
    if added.is_empty():return result
    core.shapes(layout.layer(*M1)).insert(added.merged());top.write(str(gds))
    result=verify_layout(gds,top.name,ref,work/'checks')
    result['m1_junction_repairs']=repairs
    return result
