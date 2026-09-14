#!/usr/bin/env python3
"""Keep the serial chain together and put counter/phase logic beside control.

The electrical circuit is unchanged. Nine address FF/MUX pairs form the bottom
row; DIN remains with the control gates. Two real M2 supply trunks distribute
power directly to the control rows instead of feeding them through a long
bottom rail and a single via.
"""
import argparse
from layout_analog import pc
from routing import *
from verify_digital import parse,digital_parts
from placement import improve
from physical_top import named_macro,verify_and_repair

def build(height):
    extra=round((height-600)/5.5)*5.5;driver_y=110+round(extra/11)*5.5
    dy=82.5+round(extra/33)*5.5
    work=WORK/f'layout/frame_bottom_h{height}';work.mkdir(parents=True,exist_ok=True)
    l=db.Layout();l.read(str(WORK/'layout/bank/bank.gds'));l.technology_name='TR-1um'
    source=db.Layout();source.read(str(WORK/'library/access/library.gds'));lib={}
    parts=digital_parts(parse((WORK/'schematic/sram512.spice').read_text()));byname={p['name']:p for p in parts}
    for kind in sorted({p['kind'].upper() for p in parts}):
        c=l.cell(kind)
        if c is None:c=l.create_cell(kind);c.copy_tree(source.cell(kind))
        lib[kind]=c
    for name,path in [('sram512_shared','layout/sense/shared.gds'),('sram512_input_clamp','layout/input_clamp_compact/cell.gds')]:
        s=db.Layout();s.read(str(WORK/path));c=l.create_cell(name);c.copy_tree(s.cell(name));lib[name]=c
    top=l.create_cell('sram512');d=pc.Drawing(l,top)
    r=Router(l,top,(0,0,1793,math.floor((height-3.4)/5.5)*5.5))
    placements=[];placed=set();anchors=defaultdict(list)
    def width(p):return lib[p['kind'].upper()].dbbox().width()-12.6
    def put(c,name,x,y,check,mapping,rotation=0):
        tr=db.Trans(rotation//90,False,round(x*1000),round(y*1000));top.insert(db.CellInstArray(c.cell_index(),tr))
        r.add_extracted(c,check,tr,mapping,name)
        placements.append(dict(instance=name,kind=c.name,x=x,y=y,rotation=rotation,mirror=False))
        for n in set(mapping.values()):anchors[n.lower()].append((x+20,y+27.5))
    def place(p,x,y):
        c=lib[p['kind'].upper()];put(c,p['name'],x,y,WORK/f'library/access/{c.name}/{c.name}.lvsdb',p['nets']);placed.add(p['name'])
    bank=l.cell('sram512_bank')
    for b in range(2):
        mapping={n:n for n in ('y','yb','preb','vdd','vss')}
        mapping.update({f'wl{i}':f'wl{i}' if b==0 else f'wl_r{i}' for i in range(16)})
        mapping.update({f'cl{i}':f'xcol_decode__cl{i}' for i in range(4)})
        mapping.update({f'ch{i}':f'xcol_decode__ch{i+4*b}' for i in range(4)})
        put(bank,f'bank{b}',627+660*b,220+extra,WORK/'layout/bank/checks/sram512_bank.lvsdb',mapping,90)
        # Pin coordinates matter for the non-local bank nets.
        tr=db.Trans(db.Trans.R90,round((627+660*b)*1000),round((220+extra)*1000))
        for n,(_,point) in physical_labels(bank,l).items():
            if n in mapping:
                xy=tr*point;anchors[mapping[n]].append((xy.x/1000,xy.y/1000))
        placed.update(f'xcol_decode__xselect{i}' for i in range(16*b,16*(b+1)))
    for b in range(2):
        for row in range(16):
            place(byname[f'xrow__xdriver{row}' if b==0 else f'xrow__xdriver_right{row}'],16.5+682*b+(15-row)*27.5,driver_y)
    x=456.5
    for p in parts:
        if p['name'].startswith('xrow__') and p['name'] not in placed:place(p,x,driver_y);x+=width(p)
    assert abs(x-698.5)<.01
    put(lib['sram512_shared'],'sense',1177,110,WORK/'layout/sense/checks/sram512_shared.lvsdb',
        {n:n for n in physical_labels(lib['sram512_shared'],l)})
    x=16.5
    for bit in ['ra3','ra2','ra1','ra0','ca4','ca3','ca2','ca1','ca0']:
        base='xctrl__xframe__xframe_'+bit
        for name in (base+'_hold',base):p=byname[name];place(p,x,11);x+=width(p)
    assert abs(x-1254)<.01,x
    for i,n in enumerate(('CLK','RESET','SDI','WE')):
        put(lib['sram512_input_clamp'],'input_'+n.lower(),1254+16.5*i,11,
            WORK/'layout/input_clamp_compact/checks/sram512_input_clamp.lvsdb',{'in':n.lower(),'vdd':'vdd','vss':'vss'})
    remain=[p for p in parts if p['name'] not in placed]
    caps=[418]+[429]*6;starts=[1364]+[1353]*6;rows=[[] for _ in caps];used=[0.]*7
    for p in sorted(remain,key=width,reverse=True):
        choices=[j for j in range(7) if used[j]+width(p)<=caps[j]+1e-6];assert choices
        j=max(choices,key=lambda j:used[j]);rows[j].append(p);used[j]+=width(p)
    rows=improve(rows,remain,width,anchors,x0=starts,dy=dy,capacity=caps)
    for j,ps in enumerate(rows):
        x=starts[j]
        for p in ps:place(p,x,11+dy*j);x+=width(p)
    assert placed==set(byname),set(byname)-placed
    for name,xx in [('vdd',1320),('vss',1342)]:
        regs=[db.Region(),db.Region()]
        def metal(k,points,width):
            poly=db.DPath([db.DPoint(*p) for p in points],width,width/2,width/2).to_itype(.001).polygon()
            top.shapes(l.layer(*(M1 if k==0 else M2))).insert(poly);regs[k].insert(poly)
        metal(1,[(xx,11),(xx,height-11)],14)
        for j in range(7):
            yy=11+dy*j+(55 if name=='vdd' else 0);end=starts[j]+sum(width(p) for p in rows[j])
            metal(0,[(16.5 if j==0 else xx,yy),(end,yy)],2.6)
            metal(0,[(xx,yy-4.5),(xx,yy+4.5)],3.4)
            for offset in (-4.5,-1.5,1.5,4.5):
                top.shapes(l.layer(*VIA)).insert(db.DBox(xx-.7,yy+offset-.7,xx+.7,yy+offset+.7).to_itype(.001))
        r.add_geometry(regs,name,'supply_trunk.'+name)
    for i,name in enumerate(('VSS','VDD','CLK','RESET','SDI','WE','SDO')):
        x=1342 if name=='VSS' else 1320 if name=='VDD' else 1793;y=22 if name in ('VSS','VDD') else 22+77*i
        pad=db.Region(db.DBox(x-1.7,y-1.7,x+1.7,y+1.7).to_itype(.001))
        top.shapes(l.layer(*M2)).insert(pad);d.label('M2',name,x,y);r.add_geometry([db.Region(),pad],name,'PORT.'+name)
    write_json(work/'placement.json',placements);top.write(str(work/'placed.gds'))
    return l,top,r,work

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('--height',type=int,default=600);p.add_argument('--iterations',type=int,default=1200);a=p.parse_args()
    l,top,r,work=build(a.height);success=r.route(work/'routing',a.iterations);top=named_macro(l,top,work)
    if not success:
        top.write(str(work/'sram512.gds'));write_json(work/'routing_failure.json',dict(passed=False,stage='global routing',gds_sha256=sha(work/'sram512.gds')))
        raise SystemExit(1)
    result=verify_and_repair(l,top,work);result.update(router_passed=success,bbox_um=str(top.dbbox()))
    write_json(REPORTS/f'frame_bottom_h{a.height}.json',result);print(result['drc'],result['lvs'],flush=True)
    raise SystemExit(0 if all(result[k]['passed'] for k in ('drc','lvs')) else 1)
