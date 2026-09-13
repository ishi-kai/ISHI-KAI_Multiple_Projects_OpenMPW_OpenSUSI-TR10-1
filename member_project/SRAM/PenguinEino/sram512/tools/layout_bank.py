#!/usr/bin/env python3
"""Physical 16x16 half-array, with sixteen column switches and final ANDs."""
from layout_analog import *
from routing import *

AX=0; AY=147; CY=104.5; GY=66; COMPACT=False; DECODE_GC_BUS=False; MINIMUM_PC=False
def bank_work():return WORK/('layout/bank_min_pc' if MINIMUM_PC else 'layout/bank_compact_bus' if DECODE_GC_BUS else 'layout/bank_compact' if COMPACT else 'layout/bank')
def trans(x,y,mirror=False):
    return db.Trans(db.Trans.M0 if mirror else db.Trans.R0,round(x*1000),round(y*1000))

def macros():
    for name in ('array16','columns16'):
        w=bank_work()/name;w.mkdir(parents=True,exist_ok=True)
        l=db.Layout();l.dbu=.001;l.technology_name='TR-1um'
        if name=='array16':
            core=pc.bitcell(l,family='six_single');c=pc.array(l,core,16,16,gap=22)
            source=pc.reference(c.name,16,16)
        else:
            c=column_bank(l,16,gap=22,ground_below_logic=True,ground_depth=CY+11 if DECODE_GC_BUS else CY-5.5,
                          logic_rail=GY-CY if MINIMUM_PC else None,minimum_pc=MINIMUM_PC)
            source=reference(c.name,16)
            if MINIMUM_PC:source=source.replace('w=10.2u','w=3.4u')
        gds=w/'macro.gds';ref=w/'reference.spice';c.write(str(gds));ref.write_text(source)
        rr=verify_layout(gds,c.name,ref,w/'checks');print(name,rr['drc'],rr['lvs'],flush=True)
        assert all(rr[k]['passed'] for k in ('drc','lvs')),rr

def build():
    w=bank_work();w.mkdir(parents=True,exist_ok=True)
    l=db.Layout();l.read(str(WORK/'library/access/library.gds'));l.technology_name='TR-1um'
    def imp(name,cell):
        s=db.Layout();s.read(str(w/name/'macro.gds'));c=l.create_cell(cell);c.copy_tree(s.cell(cell));return c
    arr=imp('array16','pcell_16x16');col=imp('columns16','sram512_columns_16');gate=l.cell('AND2_X1')
    gate_report=WORK/'library/access/AND2_X1/AND2_X1.lvsdb'
    if COMPACT:
        # An additional real contact on A, outside the NMOS active, makes
        # the column input accessible beyond the cell's ground rail.
        gd=pc.Drawing(l,gate)
        gd.wire('GC',[(6.1,4.5),(6.1,2.2),(8.25,2.2),(8.25,-3.3),(2.75,-3.3),(2.75,-5.5)],1)
        gd.contact(2.75,-5.5,'GC')
        gd.box('GC',2.75,-5.5,8.75,-2.8)
        gd.wire('M1',[(2.75,-5.5),(-2.75,-5.5)],1.8);gd.via(-2.75,-5.5)
        gd.wire('M2',[(-2.75,-5.5),(0,-5.5)],3.4)
        if DECODE_GC_BUS:
            # A second A contact passes through the real gaps between the
            # separate well taps. It remains outside both active regions.
            gd.wire('GC',[(6.1,51.1),(6.1,52.8),(8.25,52.8),(8.25,59.4)],1)
            gd.contact(8.25,59.4,'GC')
        gw=w/'column_gate';gw.mkdir(exist_ok=True);path=gw/'cell.gds';gate.write(str(path))
        check=verify_layout(path,gate.name,WORK/'library/interfaces/AND2_X1/reference.spice',gw)
        print('column A escape',check['drc'],check['lvs'],flush=True)
        assert all(check[k]['passed'] for k in ('drc','lvs'))
        gate_report=gw/'AND2_X1.lvsdb'
    bounds=(-49.5,-5.5,390.5,588.5) if MINIMUM_PC else ((-49.5,-16.5 if DECODE_GC_BUS else 0,374,599.5) if COMPACT else (-44,-33,374,621.5))
    top=l.create_cell('sram512_bank');d=pc.Drawing(l,top);r=Router(l,top,bounds,step=2750 if COMPACT else 5500)
    for c,y,path in [(arr,AY,'array16'),(col,CY,'columns16')]:
        tr=trans(0,y);top.insert(db.CellInstArray(c.cell_index(),tr))
        mapping={n:n for n in physical_labels(c,l)}
        r.add_extracted(c,w/path/f'checks/{c.name}.lvsdb',tr,mapping,c.name)
    def wire(name,layer,points,width=None):
        k=0 if layer=='M1' else 1;width=width or (1.8 if k==0 else 3.4)
        poly=db.DPath([db.DPoint(*p) for p in points],width,width/2,width/2).to_itype(.001).polygon()
        top.shapes(l.layer(*(M1 if k==0 else M2))).insert(poly)
        regs=[db.Region(),db.Region()];regs[k].insert(poly);r.add_geometry(regs,name)
        return regs
    def via(name,x,y):
        d.via(x,y);pad=db.Region(db.Box(round((x-1.7)*1000),round((y-1.7)*1000),round((x+1.7)*1000),round((y+1.7)*1000)))
        r.add_geometry([pad,pad],name)
    for c in range(16):
        x=c*22;tr=trans(x,GY,True);top.insert(db.CellInstArray(gate.cell_index(),tr))
        r.add_extracted(gate,gate_report,tr,
            dict(A=f'CL{c%4}',B=f'CH{c//4}',Y=f'COL{c}',VDD='VDD',GND='VSS'),f'Xselect{c}')
        # COL crosses the standard-cell ground rail in M2, then uses M1 in
        # the open channel, leaving horizontal M2 tracks for predecoding.
        name=f'col{c}';wire(name,'M1',[(x+16.5,55),(x+16.5,61.5)])
        via(name,x+16.5,61.5)
        if COMPACT:
            wire(name,'M2',[(x+16.5,61.5),(x+16.5,66),(x+11,66),(x+11,CY-11)])
        else:
            wire(name,'M2',[(x+16.5,61.5),(x+16.5,77)])
            via(name,x+16.5,77);wire(name,'M1',[(x+16.5,77),(x+16.5,CY-11),(x+11,CY-11)])
        via(name,x+11,CY-11);r.pins[r.netid(name)]=[]
        for name,dx in [('bl',-.4),('blb',18.4)]:
            wire(f'{name}{c}','M1',[(x+dx,CY+(33.2 if MINIMUM_PC else 40)),(x+dx,AY+5.7)])
            r.pins[r.netid(f'{name}{c}')]=[]
    for side,bx in [(-1,0),(1,352)]:
        for name,off,y0 in [('vdd',14.4,11 if MINIMUM_PC else CY+31.5),('vss',19.8,66 if MINIMUM_PC else 5.5)]:
            wire(name,'M1',[(bx+side*off,y0),(bx+side*off,AY+464.9)],3.4)
    if MINIMUM_PC:wire('vdd','M1',[(-14.4,11),(366.4,11)],2.6)
    if COMPACT:
        # Four adjacent column selects share CH. Join those real M2 input
        # landing pads locally before routing the remaining predecode buses.
        for group in range(4):
            name=f'ch{group}';nid=r.netid(name)
            extra=wire(name,'M2',[(group*88+11,38.5),(group*88+77,38.5)])
            regs=[db.Region(),db.Region()];keep=[]
            for label,terminal in r.pins[nid]:
                if label.startswith('Xselect'):
                    for k in range(2):regs[k]+=terminal[k]
                else:keep.append((label,terminal))
            for k in range(2):regs[k]+=extra[k]
            r.pins[nid]=keep+[(f'CHbus{group}',regs)]
        # CL0 uses the open track between the select gates and the bitline
        # pull-down devices. The other three CL buses keep the inner tracks.
        nid=r.netid('cl0');regs=[db.Region(),db.Region()]
        extra=wire('cl0','M2',[(0,77),(264,77)])
        for col_index in (0,4,8,12):
            stub=wire('cl0','M2',[(col_index*22,71.5),(col_index*22,77)])
            for k in range(2):extra[k]+=stub[k]
        for label,terminal in r.pins[nid]:
            for k in range(2):regs[k]+=terminal[k]
        for k in range(2):regs[k]+=extra[k]
        r.pins[nid]=[('CL0bus',regs)]
    # Expose actual wordline wires at a legal coarse-grid access point.
    for row in range(16):
        y=AY+(row*29.6+2.7 if row%2==0 else (row+1)*29.6-2.7)
        gy=round(y/5.5)*5.5;direction=gy-y
        long_leg=(row%2==1 and direction>=0) or (row%2==0 and direction<0)
        x=-33 if long_leg else -27.5;name=f'wl{row}'
        extra=wire(name,'M2',[(-9.6,y),(x,y),(x,gy)])
        label,regs=r.pins[r.netid(name)][0];r.pins[r.netid(name)][0]=(label,[regs[k]+extra[k] for k in range(2)])
        d.label('M2',name.upper(),x,gy)
        if MINIMUM_PC:
            reach=-x
            wire(name,'M2',[(361.6,y),(352+reach,y),(352+reach,gy)])
    # Decode buses have independent external terminals on the decoder-facing edge.
    for i,name in enumerate([f'CL{i}' for i in range(4)]+[f'CH{i}' for i in range(4)]):
        x=-44 if COMPACT else -33;y=11+i*11 if COMPACT else -22+i*16.5
        if MINIMUM_PC and i==0:y=16.5
        pad=db.Region(db.Box(round((x-1.7)*1000),round((y-1.7)*1000),round((x+1.7)*1000),round((y+1.7)*1000)))
        top.shapes(l.layer(*M2)).insert(pad);d.label('M2',name,x,y)
        r.add_geometry([db.Region(),pad],name,'PORT.'+name)
    if DECODE_GC_BUS:
        # These three global decode buses occupy field below the logic row.
        # M1 stubs cross other GC buses without joining them; each intended
        # junction uses a physical CO. The bus spacing includes CO landing
        # enclosure, not only the minimum bare-GC spacing.
        for bit,yy in [(1,1.1),(2,-2.2),(3,-5.5)]:
            name=f'cl{bit}';start=-44+(bit-1)*5.5
            xs=[c*22+8.25 for c in range(bit,16,4)]
            d.wire('GC',[(start,yy),(xs[-1],yy)],1)
            for x in xs:
                d.contact(x,yy,'GC')
                wire(name,'M1',[(x,6.6),(x,yy)])
                pad=db.Region(db.DBox(x-1.3,yy-1.3,x+1.3,yy+1.3).to_itype(.001))
                r.add_geometry([pad,db.Region()],name)
            d.contact(start,yy,'GC');target=11+bit*11
            wire(name,'M1',[(start,yy),(start,target),(-44,target)])
            pad=db.Region(db.DBox(start-1.3,yy-1.3,start+1.3,yy+1.3).to_itype(.001))
            r.add_geometry([pad,db.Region()],name);via(name,-44,target)
            # Physical GC+CO+M1 now joins the complete net. Official LVS
            # independently verifies this connection instead of the router.
            r.pins[r.netid(name)]=[]
    vdy=24.7 if MINIMUM_PC else 31.5
    for name,y,x,gy in [('preb',CY+11.5,-27.5,CY+11),('y',CY+5.5,-33,CY+5.5),('yb',CY,-38.5,CY),('vdd',CY+vdy,-27.5,round((CY+vdy)/2.75)*2.75 if MINIMUM_PC else CY+33)]:
        extra=wire(name,'M2',[(-14.4,y),(x,y),(x,gy)])
        terms=r.pins[r.netid(name)]
        for j,(label,regs) in enumerate(terms):
            if label.startswith(col.name+'.'):terms[j]=(label,[regs[k]+extra[k] for k in range(2)])
        d.label('M2',name.upper(),x,gy)
    d.label('M1','VSS',-19.8,66 if MINIMUM_PC else 5.5)
    if MINIMUM_PC:
        # Reserve real space for the top-level power and WL_EN buses. This
        # is a router obstacle only; no dummy shape enters the GDS or DRC.
        r.add_geometry([db.Region(),db.Region(db.DBox(-49.5,-5.5,390.5,10).to_itype(.001))])
    top.write(str(w/'placed.gds'))
    return l,top,r,w

def ref(top):
    arr=(bank_work()/'array16/reference.spice').read_text()
    col=(bank_work()/'columns16/reference.spice').read_text()
    gate=(WORK/'library/interfaces/AND2_X1/reference.spice').read_text()
    defs=parse(arr+'\n'+col+'\n'+gate)
    ports=[f'WL{i}' for i in range(16)]+[f'CL{i}' for i in range(4)]+[f'CH{i}' for i in range(4)]+['Y','YB','PREB','VDD','VSS']
    lines=['* Physical half-array reference',f'.subckt {top} '+' '.join(ports)]
    for name,kind in [('array','pcell_16x16'),('columns','sram512_columns_16')]:
        lines.append('X'+name+' '+' '.join(defs[kind]['pins'])+' '+kind)
    for c in range(16):
        m=dict(a=f'CL{c%4}',b=f'CH{c//4}',y=f'COL{c}',vdd='VDD',gnd='VSS')
        lines.append(f'Xselect{c} '+' '.join(m[n] for n in defs['and2_x1']['pins'])+' AND2_X1')
    return '\n'.join(lines+[f'.ends {top}',arr,col,gate])

if __name__=='__main__':
    import argparse
    ap=argparse.ArgumentParser();ap.add_argument('--macros',action='store_true');ap.add_argument('--place-only',action='store_true');ap.add_argument('--compact',action='store_true');a=ap.parse_args()
    if a.compact:COMPACT=True;AY=125;CY=82.5
    if a.macros:macros()
    l,c,r,w=build()
    if not a.place_only:
        success=r.route(w/'routing',300 if COMPACT else 100);pc.fill_metal_notches(l,c);gds=w/'bank.gds';c.write(str(gds))
        source=w/'reference.spice';source.write_text(ref(c.name))
        result=verify_layout(gds,c.name,source,w/'checks');print(result['drc'],result['lvs'],flush=True)
        if success and result['lvs']['passed'] and not result['drc']['passed']:
            # Close narrow notches in each electrically connected M2 net.
            # Independent net regions prevent closing a gap between signals.
            v=db.LayoutVsSchematic();v.read(str(w/'checks/sram512_bank.lvsdb'))
            circuit=v.netlist().circuit_by_name(c.name)
            actual=db.Region(c.begin_shapes_rec(l.layer(*M2)))
            index=next(i for i in v.layer_indexes() if (v.layer_by_index(i)^actual).is_empty())
            added=db.Region()
            for n in circuit.each_net():
                old=v.polygons_of_net(n,index,True)
                added+=old.sized(1000).sized(-1000)-old
            if not added.is_empty():
                c.shapes(l.layer(*M2)).insert(added.merged());c.write(str(gds))
                result=verify_layout(gds,c.name,source,w/'checks')
                result['m2_notch_fill_um2']=added.area()*l.dbu*l.dbu
                print('connected-net M2 notch fill',result['drc'],result['lvs'],flush=True)
        write_json(REPORTS/('layout_bank_compact.json' if COMPACT else 'layout_bank.json'),result)
        if not success or not all(result[k]['passed'] for k in ('drc','lvs')):raise SystemExit(1)
