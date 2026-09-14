#!/usr/bin/env python3
"""Physical 16 horizontal rows by 32 vertical columns, in 1800 x 600 um."""
import argparse
from collections import defaultdict
from layout_analog import pc
from routing_poly import RouterPoly
from routing import *
from verify_digital import parse,digital_parts
from placement import improve
from physical_top import named_macro,verify_and_repair

def build(reuse_placement=False,mirror_banks=False,clock_backbone=False,via_pitch_um=5.5,
          placement_overrides=None,output_work=None):
    original=WORK/('layout/rectangular_mirrored' if mirror_banks else 'layout/rectangular_shared_wl')
    work=original.with_name(original.name+'_clock') if clock_backbone else original
    if via_pitch_um!=5.5:work=work.with_name(work.name+f'_v{round(via_pitch_um*1000)}')
    if output_work is not None:work=Path(output_work).resolve()
    work.mkdir(parents=True,exist_ok=True)
    dx=22 if mirror_banks else 0
    layout=db.Layout();layout.read(str(WORK/'library/access/library.gds'))
    layout.technology_name='TR-1um'
    def imp(path,name):
        src=db.Layout();src.read(str(path));c=layout.create_cell(name);c.copy_tree(src.cell(name));return c
    bank=imp(WORK/'layout/bank_min_pc/bank.gds','sram512_bank')
    clamp=imp(WORK/'layout/input_clamp_compact_row/cell.gds','sram512_input_clamp')
    sense=imp(WORK/'layout/sense/shared.gds','sram512_shared')
    top=layout.create_cell('sram512');draw=pc.Drawing(layout,top)
    r=RouterPoly(layout,top,(0,0,1793,594),2750)
    r.via_pitch_nm=round(via_pitch_um*1000)
    parts=digital_parts(parse((WORK/'schematic/sram512.spice').read_text()))
    parts += [dict(name='input_'+n.lower(),kind=clamp.name,
                   nets={'IN':n.lower(),'VDD':'vdd','VSS':'vss'}) for n in ('CLK','RESET','SDI','WE')]
    byname={p['name']:p for p in parts};placements=[];placed=set();anchors=defaultdict(list)
    def insert(cell,name,x,y,mapping,check,rotation=0,mirror=False):
        tr=db.Trans(rotation//90,mirror,round(x*1000),round(y*1000))
        top.insert(db.CellInstArray(cell.cell_index(),tr));r.add_extracted(cell,check,tr,mapping,name)
        placements.append(dict(instance=name,kind=cell.name,x=x,y=y,rotation=rotation,mirror=mirror))
        mapping={k.lower():v.lower() for k,v in mapping.items()}
        for pin,(_,point) in physical_labels(cell,layout).items():
            if pin in mapping:
                p=tr*point;anchors[mapping[pin]].append((p.x/1000,p.y/1000))
    for b,x in enumerate((55,495)):
        mapping={n:n for n in ('vdd','vss','preb','y','yb')}
        mapping.update({f'wl{i}':f'wl{i}' for i in range(16)})
        mapping.update({f'cl{i}':f'xcol_decode__cl{3-i if mirror_banks else i}' for i in range(4)})
        mapping.update({f'ch{i}':f'xcol_decode__ch{(3-i if mirror_banks else i)+b*4}' for i in range(4)})
        insert(bank,f'bank{b}',x+(352 if mirror_banks else 0),5.5,mapping,
               WORK/'layout/bank_min_pc/checks/sram512_bank.lvsdb',180 if mirror_banks else 0,mirror_banks)
        placements[-1]['logical_columns']=[b*16+(15-i if mirror_banks else i) for i in range(16)]
        placed.update(f'xcol_decode__xselect{i+b*16}' for i in range(16))
    def width(p):return 16.5 if p['kind']==clamp.name else layout.cell(p['kind'].upper()).dbbox().width()-12.6
    def place(p,x,y,rotation=0):
        if placement_overrides and p['name'] in placement_overrides:
            assert rotation==0,'Local moves are limited to ordinary control rows.'
            x,new_y=placement_overrides[p['name']]
            assert new_y==y,'Keep each moved cell on its existing power rails.'
        cell=clamp if p['kind']==clamp.name else layout.cell(p['kind'].upper())
        check=WORK/'layout/input_clamp_compact_row/checks/sram512_input_clamp.lvsdb' if cell==clamp else WORK/f'library/access/{cell.name}/{cell.name}.lvsdb'
        insert(cell,p['name'],x,y,p['nets'],check,rotation);placed.add(p['name'])
    for row in range(16):
        place(byname[f'xrow__xdriver{row}'],891+dx,146.9+29.6*row,270)
    insert(sense,'sense',984.5+dx,0,{n:n for n in physical_labels(sense,layout)},WORK/'layout/sense/checks/sram512_shared.lvsdb')
    remain=[p for p in parts if p['name'] not in placed]
    starts=[1149.5+dx]+[984.5+dx]*7;bases=[5.5+74.25*j for j in range(8)]
    # AND4's real input escapes extend beyond its supply rails. Give the
    # last counter row one additional track of vertical separation.
    bases[-1]+=2.75
    caps=[1754.5-x for x in starts];rows=[[] for _ in caps];used=[0.]*8
    allowed={p['name']:([7] if p['kind']=='and4_x1' else list(range(8))) for p in remain}
    for p in sorted(remain,key=lambda p:(p['kind']=='and4_x1',width(p)),reverse=True):
        choices=[j for j in allowed[p['name']] if used[j]+width(p)<=caps[j]];assert choices
        j=min(choices,key=lambda j:used[j]/caps[j]);rows[j].append(p);used[j]+=width(p)
    if reuse_placement:
        placement_file=work/'placement.json'
        if not placement_file.exists():placement_file=original/'placement.json'
        old=json.loads(placement_file.read_text());wanted={p['name']:p for p in remain}
        old_bases=sorted({p['y'] for p in old if p['instance'] in wanted});assert len(old_bases)==len(bases)
        rows=[[] for _ in bases]
        for p in sorted(old,key=lambda p:p['x']):
            if p['instance'] in wanted:rows[old_bases.index(p['y'])].append(wanted.pop(p['instance']))
        assert not wanted
        assert all(sum(width(p) for p in row)<=cap+1e-6 for row,cap in zip(rows,caps))
    else:rows=improve(rows,remain,width,anchors,x0=starts,y0=bases,capacity=caps,allowed_rows=allowed)
    for j,row in enumerate(rows):
        x=starts[j]
        for p in row:place(p,x,bases[j]);x+=width(p)
        # Extend the existing VDD well across each abutted control row.
        end=max([x]+[q['x']+width(byname[q['instance']]) for q in placements
                     if q['y']==bases[j] and q['rotation']==0 and q['instance'] in byname])
        assert end<=1754.5+1e-6
        draw.box('WN',starts[j]-6.3,bases[j]+23.2,end+6.3,bases[j]+66.8)
    assert placed==set(byname)
    def metal(name,k,points,width):
        polygon=db.DPath([db.DPoint(*p) for p in points],width,width/2,width/2).to_itype(.001).polygon()
        top.shapes(layout.layer(*(M1 if k==0 else M2))).insert(polygon)
        regs=[db.Region(),db.Region()];regs[k].insert(polygon);r.add_geometry(regs,name)
        return regs
    def via(name,x,y):
        draw.via(x,y);pad=db.Region(db.DBox(x-1.7,y-1.7,x+1.7,y+1.7).to_itype(.001))
        r.add_geometry([pad,pad],name)
    def multi_via(name,x,y):
        metal(name,0,[(x,y-4.5),(x,y+4.5)],3.4)
        for off in (-4.5,-1.5,1.5,4.5):via(name,x,y+off)
    # Wide physical supplies are reserved before any signal routing.
    for name,xx in [('vdd',1768),('vss',1790)]:
        pad=db.Region(db.DBox(xx-7,-.7,xx+7,598.3).to_itype(.001))
        top.shapes(layout.layer(*M2)).insert(pad);r.add_geometry([db.Region(),pad],name,'power_trunk.'+name)
        for j,row in enumerate(rows):
            yy=bases[j]+(55 if name=='vdd' else 0)
            metal(name,0,[(starts[j],yy),(xx,yy)],2.6);multi_via(name,xx,yy)
        label_y=595.6;draw.label('M2',name.upper(),xx,label_y)
    for name,yy,row_y,driver_x,join_x,spine_off in [('vdd',9.9 if mirror_banks else 8.25,bases[0]+55,(946+dx,),962.5+dx,14.4),
                                           ('vss',2.75,bases[0],(891+dx,),973.5+dx,19.8)]:
        if mirror_banks:
            metal(name,1,[(29.2,yy),(join_x-22,yy)],4.4)
            metal(name,1,[(join_x-24.75,yy),(join_x,yy)],3.4)
        else:metal(name,1,[(407,yy),(join_x,yy)],3.4)
        for x in driver_x:
            metal(name,0,[(x,589.2),(x,yy)],2.6);via(name,x,yy)
        for bx in (55,495):
            x=bx-spine_off if mirror_banks else bx+352+spine_off
            metal(name,0,[(x,16.5 if name=='vdd' else 71.5),(x,yy)],3.4)
            sign=(-1 if name=='vdd' else 1)*(-1 if mirror_banks else 1)
            end=x+6*sign
            metal(name,0,[(x,yy),(end,yy)],3.4)
            for off in (0,3,6):via(name,x+sign*off,yy)
        via(name,join_x,yy)
        if name=='vss':
            # The analogue ground rail is at y=0, not at digital y=5.5.
            # Go around that macro, crossing VDD on the other metal layer.
            turn_x=957+dx;turn_y=22
            metal(name,0,[(join_x,yy),(join_x,turn_y)],3.4)
            multi_via(name,join_x,turn_y)
            metal(name,1,[(join_x,turn_y),(turn_x,turn_y),(turn_x,bases[1])],4.4)
            multi_via(name,turn_x,bases[1])
            metal(name,0,[(turn_x,bases[1]),(starts[1],bases[1])],3.4)
        else:
            metal(name,0,[(join_x,yy),(join_x,row_y),(starts[0],row_y)],2.6)
    metal('vss',0,[(968+dx,5.5),(973.5+dx,5.5)],3.4)
    def joined(name,predicate,extra):
        nid=r.netid(name);regs=[db.Region(),db.Region()];keep=[];count=0;connections=[]
        for label,terminal in r.pins[nid]:
            if predicate(label):
                for k in range(2):regs[k]+=terminal[k]
                connections.append((label,terminal[1].merged()))
                count+=1
            else:keep.append((label,terminal))
        assert count,(name,'no matching terminals')
        # This helper consolidates only physically connected M2 buses.
        # Check every actual extracted pin, rather than assuming that a
        # hard-coded coordinate represents the cell's current access point.
        assert extra[0].is_empty()
        connections += [('wire',db.Region(p)) for p in extra[1].merged().each()]
        reached={0}
        while True:
            added={i for i,(_,g) in enumerate(connections) if i not in reached
                   and any(not g.interacting(connections[j][1]).is_empty() for j in reached)}
            if not added:break
            reached|=added
        assert len(reached)==len(connections),(name,'unconnected physical bus',
            [label for i,(label,_) in enumerate(connections) if i not in reached])
        for k in range(2):regs[k]+=extra[k]
        r.pins[nid]=keep+[(f'PhysicalBus.{name}.{len(keep)}',regs)]
    # A single physical WL joins both banks, with one right-side AND3 driver.
    # Join the legal grid escapes, preserving the close even/odd WL spacing.
    for row in range(16):
        y=118.2+(row*29.6+2.7 if row%2==0 else (row+1)*29.6-2.7)
        gy=round(y/5.5)*5.5+5.5;direction=gy-5.5-y
        reach=33 if (row%2==1 and direction>=0) or (row%2==0 and direction<0) else 27.5
        name=f'wl{row}';output=902+dx;jog=(874.5 if row%2 else 896.5)+dx;end=495+352+reach
        extra=metal(name,1,[(output,124.9+29.6*row),(jog,124.9+29.6*row),(jog,gy),(end,gy)],3.4)
        bridge=metal(name,1,[(55+352+reach,gy),(495-reach,gy)],3.4)
        for k in range(2):extra[k]+=bridge[k]
        joined(name,lambda label:True,extra)
        draw.label('M2',name.upper(),end,gy)
    # C is WL_EN on all row drivers. B selects a group of four adjacent
    # rows; A selects one row within each group. Only real connected pins
    # are consolidated for the routing search, then checked by strict LVS.
    extra=[db.Region(),db.Region()]
    for xx,lo,hi in [(951.5+dx,135.9,579.9)]:
        seg=metal('wl_en',1,[(xx,lo),(xx,hi)],3.4)
        for k in range(2):extra[k]+=seg[k]
    joined('wl_en',lambda label:label.startswith('xrow__xdriver'),extra)
    draw.label('M2','WL_EN',951.5+dx,135.9)
    for group in range(4):
        for xx,y0 in [(907.5+dx,135.9)]:
            name=f'xrow__r1_{group}'
            seg=metal(name,1,[(xx,y0+29.6*4*group),(xx,y0+29.6*(4*group+3))],3.4)
            wanted={f'xrow__xdriver{row}.B' for row in range(group*4,group*4+4)}
            joined(name,lambda label:label in wanted,seg)
    if clock_backbone:
        # Reserve a connected metal clock spine and one track above every
        # digital row. The router only needs to connect nearby FF terminals.
        clock='xctrl__cki';spine=968+dx;end=1754.5
        backbone=metal(clock,1,[(spine,bases[0]+66),(spine,bases[-1]+66)],3.4)
        # Last-row AND4 inputs already occupy the upper edge; their FFs
        # connect locally to the vertical spine and the preceding row.
        for base_y in bases[:-1]:
            segment=metal(clock,1,[(spine,base_y+66),(end,base_y+66)],3.4)
            backbone[1]+=segment[1]
        r.pins[r.netid(clock)].append(('clock_backbone',backbone))
    # The sense macro's extracted supply terminals are connected by the
    # router; its device terminals do not use standard-cell rail positions.
    # Five signal contacts at the lower outside edge, selected from actual
    # free M2 sites. Supplies are exposed at the upper-right outside edge.
    ports={};blocked=db.Region(top.begin_shapes_rec(layout.layer(*M2))).sized(3750)
    candidates=[x*5.5 for x in range(201,319)]
    for name,target in zip(('CLK','RESET','SDI','WE','SDO'),(1122,1265,1413.5,1551,1705)):
        available=[x for x in candidates if (blocked&db.Region(db.DBox(x-.01,-.01,x+.01,.01).to_itype(.001))).is_empty()]
        assert available,name;x=min(available,key=lambda x:abs(x-target));candidates=[v for v in candidates if abs(v-x)>22]
        pad=db.Region(db.DBox(x-1.7,-1.7,x+1.7,1.7).to_itype(.001));top.shapes(layout.layer(*M2)).insert(pad)
        r.add_geometry([db.Region(),pad],name,'PORT.'+name);draw.label('M2',name,x,0);ports[name]=[x,0]
    write_json(work/'placement.json',placements);write_json(work/'ports.json',ports)
    write_json(work/'array_geometry.json',dict(rows=16,columns=32,row_direction='horizontal',column_direction='vertical',
        half_array_origins_um=[[55,123.7],[495,123.7]],cell_pitch_um=[22,29.6],rotation_degrees=0,
        continuous_wordlines=16,drivers_per_row=1,bank_horizontal_reflection=mirror_banks,
        logical_columns_increase_left_to_right=True))
    # Catch an overlap between independently named metal nets before
    # routing. Geometry DRC alone cannot identify such electrical shorts.
    names={v:k for k,v in r.ids.items()}
    for k,regions in enumerate(r.regions):
        nets=[i for i in regions if i>0]
        for j,a in enumerate(nets):
            for b in nets[j+1:]:
                overlap=regions[a]&regions[b]
                assert overlap.is_empty(),('placement short',k,names[a],names[b],str(overlap.bbox()))
    top.write(str(work/'placed.gds'));return layout,top,r,work

def main(place_only=False,iterations=300,reuse_placement=False,mirror_banks=False,clock_backbone=False,via_pitch_um=5.5):
    layout,core,r,work=build(reuse_placement,mirror_banks,clock_backbone,via_pitch_um)
    if place_only:
        from layout import lvs_reference
        ref=work/'placed_reference.spice';ref.write_text(lvs_reference())
        result=verify_layout(work/'placed.gds',core.name,ref,work/'placement_checks')
        print('Placement only:',result['drc'],flush=True);return False
    success=r.route(work/'routing',iterations)
    top=named_macro(layout,core,work,array_y=118.2,column_label_y=61.5)
    result=verify_and_repair(layout,top,work);box=top.dbbox()
    result.update(router_passed=success,dimensions_um=[box.width(),box.height()],physical_rows=16,physical_columns=32)
    write_json(REPORTS/'layout_rectangular16x32.json',result)
    print(result['drc'],result['lvs'],result['dimensions_um'],flush=True)
    return success and box.width()<=1800+1e-6 and box.height()<=600+1e-6 and all(result[k]['passed'] for k in ('drc','lvs'))

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('--place-only',action='store_true');p.add_argument('--iterations',type=int,default=300);p.add_argument('--reuse-placement',action='store_true');p.add_argument('--mirror-banks',action='store_true');p.add_argument('--clock-backbone',action='store_true');p.add_argument('--via-pitch',type=float,choices=[2.75,5.5],default=5.5);a=p.parse_args()
    raise SystemExit(0 if main(a.place_only,a.iterations,a.reuse_placement,a.mirror_banks,a.clock_backbone,a.via_pitch) else 1)
