#!/usr/bin/env python3
"""Generate only the dedicated sram512*.sch/.sym files, never the 2x2 design."""
from collections import defaultdict
from common import *
from design import blocks,FRAME,ROWS,COLS,definitions
import build_serial_schematics as base
base.LIB=LIB/'TR-1um_5_stdcell'

class Sheet(base.Sheet):
    def save(self, name):
        SCHEMATICS.mkdir(parents=True, exist_ok=True)
        (SCHEMATICS/name).write_text('\n'.join(self.lines)+'\n')
    def __init__(self):
        super().__init__();self.dirs={};self.port_names=set()
    def device(self,kind,name,x,y,nets,attrs=''):
        std=(LIB/'TR-1um_5_stdcell'/(kind+'.sym')).exists()
        mos=kind in ('MN','MP','DP','DN')
        sym=(LIB/'TR-1um_5_stdcell' if std else LIB/'TR-1umLIB' if mos else SCHEMATICS)/(kind+'.sym')
        self.comp(('TR-1um_5_stdcell/' if std else 'TR-1umLIB/' if mos else '')+kind+'.sym',x,y,'name=x'+name+(' '+attrs if attrs else ''))
        for m in re.finditer(r'B 5 ([-\d.]+) ([-\d.]+) ([-\d.]+) ([-\d.]+) \{name=(\w+) dir=(\w+)\}',sym.read_text()):
            px=x+round((float(m[1])+float(m[3]))/2);py=y+round((float(m[2])+float(m[4]))/2)
            pin=m[5];net=nets[pin] if pin in nets else 'VDD' if pin in ('Vdd','VDD') else 'VSS' if pin in ('Vss','GND','VSS') else name+'_'+pin
            self.pins[name,pin]=(px,py,net);self.dirs[name,pin]=m[6]
        self.cells[name]={'type':kind,'nets':nets}
    def port(self,name,x,y,direction='in'):
        super().port(name,x,y,direction);self.port_names.add(name)
    def named_port(self,name,x,y,direction='in'):
        self.port(name,x,y,direction)
        self.wire([(x,y),(x+60,y)],name)
        self.comp('devices/lab_pin.sym',x+60,y,
                  f'name=l{len(self.lines)} lab={name} hide_texts=true')
    def finish(self):
        counts=defaultdict(int)
        for _,_,n in self.pins.values():counts[n]+=1
        for key,(x,y,n) in self.pins.items():
            if key in self.attached:continue
            self.label(x,y,n,2 if self.dirs[key]=='out' else 0)
            if self.dirs[key]=='out' and counts[n]==1 and n not in self.port_names:
                self.comp('devices/noconn.sym',x,y,f'name=nc{len(self.lines)}')
    def simple_links(self):
        """Wire local gate chains; shared buses get explicit names between sections."""
        nets=defaultdict(list)
        for key,(_,_,net) in self.pins.items():nets[net].append(key)
        for net,keys in nets.items():
            if len(keys)!=2 or net in ('CLK','RESET','VDD','VSS'):continue
            src=next((k for k in keys if self.dirs[k]=='out'),None)
            if src is None:continue
            dst=next(k for k in keys if k!=src)
            if src in self.attached or dst in self.attached:continue
            x,y=self.at(*src);xx,yy=self.at(*dst)
            if 0<xx-x<850 and abs(y-yy)<390:
                mid=10*round((x+xx)/20)
                self.link(*src,*dst,via=[(mid,y),(mid,yy)],label=False)
                self.label(mid,y,net,onwire=True)

def symbol(name,inputs,outputs,inouts=('VDD','VSS'),width=280,pitch=60):
    h=max(180,((max(len(inputs),len(outputs))-1)*pitch)//2+80)
    pts={}
    for names,x in ((inputs,-width//2-20),(outputs,width//2+20)):
        for i,n in enumerate(names):pts[n]=(x,round((i-(len(names)-1)/2)*pitch/10)*10)
    for i,n in enumerate(inouts):pts[n]=(0,-h-20 if i==0 else h+20)
    custom_symbol(name,pts,{**dict.fromkeys(inputs,'in'),**dict.fromkeys(outputs,'out'),**dict.fromkeys(inouts,'inout')},(-width//2,-h,width//2,h))

def custom_symbol(name,points,dirs,box):
    x1,y1,x2,y2=box
    lines=['v {xschem version=3.4.8RC file_version=1.3}',
           'K {type=subcircuit\nformat="@name @pinlist @symname"\ntemplate="name=x1"\n}',
           f'P 4 5 {x1} {y1} {x2} {y1} {x2} {y2} {x1} {y2} {x1} {y1} {{}}',
           f'T {{{name}}} {x1+20} -20 0 0 0.3 0.3 {{}}',
           f'T {{@name}} {x2-80} {y1-30} 0 0 0.2 0.2 {{}}']
    for n,(x,y) in points.items():
        lines.append(f'B 5 {x-2.5} {y-2.5} {x+2.5} {y+2.5} {{name={n} dir={dirs[n]}}}')
        xx=max(x1,min(x2,x));yy=max(y1,min(y2,y))
        lines.append(f'L 4 {x} {y} {xx} {yy} {{}}')
        tx=xx+10 if x<x1 else xx-10 if x>x2 else xx+8
        ty=yy-5 if y>=y1 else yy+8
        lines.append(f'T {{{n}}} {tx} {ty} 0 {int(x>x2)} 0.2 0.2 {{}}')
    (SCHEMATICS/(name+'.sym')).write_text('\n'.join(lines)+'\n')

def logic_sheet(b):
    s=Sheet()
    for text,x,y in b.notes:s.text(text,x,y,.3)
    for p in b.parts:s.device(p['kind'],p['name'],*p['xy'],p['nets'])
    # Explicit feedback paths for the enabled registers.
    for p in b.parts:
        if p['kind']!='MUX2':continue
        mx=p['name'];ff=next(q['name'] for q in b.parts if q['kind']=='DFFR' and q['nets']['D']==p['nets']['Y'])
        ax,ay=s.at(mx,'A');qx,qy=s.at(ff,'Q')
        loop_y=min(ay,qy)-100;right=qx+80;left=ax-50
        s.link(ff,'Q',mx,'A',via=[(right,qy),(right,loop_y),(left,loop_y),(left,ay)])
        s.label(right,loop_y,p['nets']['A'],onwire=True)
        s.link(mx,'Y',ff,'D')
    s.simple_links()
    if b.name=='sram512_phase':
        rails={f'C{i}{z}':1350+40*(2*i+j) for i in range(5) for j,z in enumerate(('','B'))}
        for n,x in rails.items():
            s.wire([(x,-140),(x,1800)],n);s.label(x,-140,n,onwire=True)
        for i in range(8):
            for pin in 'ABCD':
                key=(f'phase{i}_low',pin);x,y,n=s.pins[key]
                s.lead(*key,[(rails[n],y)],False)
            key=(f'phase{i}','B');x,y,n=s.pins[key]
            # The fifth-bit tap runs above this comparator, clear of its first-stage pins.
            s.lead(*key,[(x-40,y),(x-40,y+90),(rails[n],y+90)],False)
    # One visible CLK and RESET pair per vertical bank of DFFs.
    groups=defaultdict(list)
    for p in b.parts:
        if p['kind']=='DFFR':groups[p['xy'][0]].append(p['name'])
    for x,ffs in groups.items():
        for pin,dx in [('CK',-140),('RST',-80)]:
            points=[]
            for name in ffs:
                px,py=s.at(name,pin);y=py if pin=='CK' else py+40
                s.lead(name,pin,[(px,y),(x+dx,y)],False);points.append(y)
            lo=min(points)-50;hi=max(points)+30
            s.wire([(x+dx,lo),(x+dx,hi)],'CLK' if pin=='CK' else 'RESET')
            s.label(x+dx,lo,'CLK' if pin=='CK' else 'RESET',onwire=True)
    for i,n in enumerate(b.inputs):s.named_port(n,-520,10+i*90)
    for n in b.outputs:
        source=next(k for k,(_,_,net) in s.pins.items() if net==n and s.dirs[k]=='out')
        px,py=s.at(*source)
        s.lead(*source,[(px+200,py)],False);s.port(n,px+200,py,'out')
    for i,n in enumerate(b.inouts):s.named_port(n,-520,-200+i*70,'inout')
    s.finish();s.save(b.name+'.sch')
    symbol(b.name,b.inputs,b.outputs,b.inouts,pitch=40 if b.name=='sram512_row_decoder' else 60)

def bitcell_array():
    source=(ROOT/'learning/schematics/sram.sch').read_text().replace('lab=Vdd','lab=VDD').replace('lab=Vss','lab=VSS')
    source=re.sub(r'C \{devices/opin.sym\}([^\n]+lab=Q[B]?\})',r'C {devices/lab_pin.sym}\1',source)
    (ROOT/'sram512/schematics/sram512_bitcell.sch').write_text(source)
    pts={'WL':(-100,0),'BL':(-40,-100),'BLB':(40,-100),'VDD':(100,-40),'VSS':(100,40)}
    custom_symbol('sram512_bitcell',pts,{n:'in' if n=='WL' else 'inout' for n in pts},(-80,-80,80,60))
    s=Sheet();s.text('512-bit 6T ARRAY | 16 rows x 32 columns | minimum 3.4/1 um MOS',-300,-440,.5)
    for r in range(ROWS):
        y=r*280
        for c in range(COLS):
            x=c*320
            wl=f'WL{r}'
            s.device('sram512_bitcell',f'r{r}c{c}',x,y,dict(WL=wl,BL=f'BL{c}',BLB=f'BLB{c}',VDD='VDD',VSS='VSS'))
            s.lead(f'r{r}c{c}','WL',[(x-130,y),(x-130,y+100)],False)
            for p,dx in [('BL',-110),('BLB',110)]:
                px,py=s.at(f'r{r}c{c}',p);s.lead(f'r{r}c{c}',p,[(x+dx,py)],False)
        for first,name in [(0,f'WL{r}')]:
            s.wire([(first*320-300,y+100),((first+31)*320-130,y+100)],name)
            s.port(name,first*320-300,y+100)
    for c in range(COLS):
        for n,dx in [('BL',-110),('BLB',110)]:
            x=c*320+dx;s.wire([(x,-240),(x,(ROWS-1)*280-100)],f'{n}{c}')
            s.port(f'{n}{c}',x,-240,'inout')
    s.named_port('VDD',-300,-340,'inout');s.named_port('VSS',-100,-340,'inout')
    s.finish();s.save('sram512_array.sch')
    pts={f'WL{r}':(-3220,-300+40*r) for r in range(16)}
    for c in range(32):
        pts[f'BL{c}']=(-3100+c*200-50,720);pts[f'BLB{c}']=(-3100+c*200+50,720)
    pts.update(VDD=(-200,-720),VSS=(200,-720))
    custom_symbol('sram512_array',pts,{n:'in' if n.startswith('WL') else 'inout' for n in pts},(-3200,-700,3200,700))

def column_cell():
    s=Sheet();s.text('ONE COLUMN: local precharge + nMOS pass MUX',-300,-360,.35)
    for side,bl,y in [(0,'BL','Y'),(1,'BLB','YB')]:
        x=side*600
        s.device('MP','pc'+bl,x,-160,dict(D=bl,G='PREB',S='VDD',BG='VDD'),'model=PMOS w=3.4u l=1u m=1 spiceprefix=X')
        s.device('MN','mux'+bl,x,160,dict(D=bl,G='COL',S=y,BG='VSS'),'model=NMOS w=5.1u l=1u m=1 spiceprefix=X')
        # PMOS drain to bitline, continuing physically to the pass transistor.
        s.link('pc'+bl,'D','mux'+bl,'D')
        px,py=s.at('pc'+bl,'D');s.wire([(px,py),(px+150,py)],bl);s.port(bl,px+150,py,'inout')
        px,py=s.at('mux'+bl,'S');s.wire([(px,py),(px,py+100)],y);s.port(y,px,py+100,'inout')
    for i,n in enumerate(('PREB','COL','VDD','VSS')):s.named_port(n,-280,-200+i*160,'inout' if n.startswith('V') else 'in')
    s.finish();s.save('sram512_column.sch')
    pts={'BL':(-50,-160),'BLB':(50,-160),'Y':(-50,160),'YB':(50,160),'COL':(0,160),
         'PREB':(-100,-50),'VDD':(0,-160),'VSS':(100,50)}
    custom_symbol('sram512_column',pts,{n:'in' if n in ('COL','PREB') else 'inout' for n in pts},(-80,-140,80,140))

def controller():
    s=Sheet();s.text('512-bit SERIAL CONTROLLER | 10 receive clocks + 8 access clocks',-800,-800,.45)
    s.device('BUF_X4','clock',-800,-450,dict(A='CLK',Y='CKI'))
    s.device('BUF_X4','reset',-800,-220,dict(A='RESET',Y='RSTI'))
    s.device('sram512_phase','phase',-250,0,dict(CLK='CKI',RESET='RSTI',RX='RX',**{f'E{i}':f'E{i}' for i in range(8)}))
    s.device('sram512_frame','frame',750,0,dict(CLK='CKI',RESET='RSTI',RX='RX',SDI='SDI',**{n+z:n+z for n in FRAME for z in ('','B')}))
    s.device('sram512_control','control',-250,1100,dict(CLK='CKI',RESET='RSTI',WE='WE',SOUT='SOUT',
        **{f'E{i}':f'E{i}' for i in range(7)},PREB='PREB_I',SAE='SAE_I',WL_EN='WL_EN',WRITE_EN='WRITE_EN',READ_DATA='READ_DATA'))
    for i,(net,src) in enumerate([('PREB','PREB_I'),('SAE','SAE_I'),('SDO','READ_DATA')]):
        s.device('BUF_X4',net.lower()+'_drive',500,950+i*260,dict(A=src,Y=net))
    s.simple_links()
    ins=['CLK','RESET','SDI','WE','SOUT'];outs=[n+z for n in FRAME for z in ('','B')]+['PREB','SAE','WL_EN','WRITE_EN','SDO']
    for i,n in enumerate(ins):s.named_port(n,-1100,300+i*150)
    for i,n in enumerate(outs):s.named_port(n,1450,-450+i*80,'out')
    s.named_port('VDD',-800,-690,'inout');s.named_port('VSS',-500,-690,'inout')
    s.finish();s.save('sram512_controller.sch');symbol('sram512_controller',ins,outs)

def top(tb=False):
    s=Sheet();s.text('SRAM512 | 16 x 32 | 7-pin serial interface | 5 V',-1100,-1000,.55)
    s.device('sram512_array','array',4000,0,{**{f'WL{r}':f'WL{r}' for r in range(16)},
        **{f'{n}{c}':f'{n}{c}' for n in ('BL','BLB') for c in range(32)}})
    s.device('sram512_row_decoder','row',300,0,{**{f'RA{i}':f'RA{i}' for i in range(4)},'WL_EN':'WL_EN',**{f'WL{r}':f'WL{r}' for r in range(16)}})
    for r in range(16):
        for j,p in enumerate(('WL',)):
            s.link('row',f'{p}{r}','array',f'{p}{r}')
            s.label(620,-300+40*r,f'{p}{r}',onwire=True)
    for c in range(32):
        x=900+c*200
        s.device('sram512_column',f'col{c}',x,1300,dict(BL=f'BL{c}',BLB=f'BLB{c}',Y='Y',YB='YB',COL=f'COL{c}',PREB='PREB'))
        for n in ('BL','BLB'):
            s.link('array',f'{n}{c}',f'col{c}',n)
            px,_=s.at(f'col{c}',n);s.label(px,940,f'{n}{c}',onwire=True)
        for n,y in [('Y',1560),('YB',1600)]:
            px,py=s.at(f'col{c}',n);s.lead(f'col{c}',n,[(px,y)],False)
    for n,y in [('Y',1560),('YB',1600)]:s.wire([(800,y),(7300,y)],n);s.label(800,y,n,onwire=True)
    # Wide decoder symbol places one output directly under each column MUX.
    pts={f'COL{c}':(-3100+c*200,-180) for c in range(32)}
    pts.update({f'CA{i}{z}':(-3220,-120+25*(2*i+j)) for i in range(5) for j,z in enumerate(('','B'))})
    pts.update(VDD=(0,-180),VSS=(0,180))
    custom_symbol('sram512_col_decoder',pts,{n:'out' if n.startswith('COL') else 'inout' if n.startswith('V') else 'in' for n in pts},(-3200,-160,3200,160))
    s.device('sram512_col_decoder','col_decode',4000,2140,{**{f'CA{i}{z}':f'CA{i}{z}' for i in range(5) for z in ('','B')},**{f'COL{c}':f'COL{c}' for c in range(32)}})
    for c in range(32):
        s.link('col_decode',f'COL{c}',f'col{c}','COL')
        s.label(900+c*200,1850,f'COL{c}',onwire=True)
    s.device('sense_amp_7t','sense',5600,2730,dict(BL='Y',BLB='YB',SAE='SAE',SOUT='SOUT',SOUTB='SOUTB'))
    for pin,y,dx in [('BL',1560,90),('BLB',1600,170)]:
        x,yy=s.at('sense',pin);s.lead('sense',pin,[(x-dx,yy),(x-dx,y)],False)
    for i,n in enumerate(('Y','YB')):
        x=2400+i*1300
        s.device('MP','pc_'+n,x,2500,dict(D=n,G='PREB',S='VDD',BG='VDD'),'model=PMOS w=10.2u l=1u m=1 spiceprefix=X')
        s.device('MN','write_'+n,x,2940,dict(D=n,G='PD_'+n,S='VSS',BG='VSS'),'model=NMOS w=10.2u l=1u m=1 spiceprefix=X')
        px,py=s.at('pc_'+n,'D');bus=1560 if i==0 else 1600
        s.lead('pc_'+n,'D',[(px+120,py),(px+120,bus)],False)
        px,py=s.at('write_'+n,'D');s.lead('write_'+n,'D',[(px+180,py),(px+180,bus)],False)
        s.device('AND2_X1','write_data'+str(i),x-450,2940,dict(A='DINB' if i==0 else 'DIN',B='WRITE_EN',Y='PD_'+n))
        s.link('write_data'+str(i),'Y','write_'+n,'G')
        s.label(x-200,2940,'PD_'+n,onwire=True)
    ports=['CLK','RESET','SDI','WE','SDO','VDD','VSS']
    outmap={n+z:n+z for n in FRAME for z in ('','B')}
    outmap.update({n:n for n in ('CLK','RESET','SDI','WE','SDO','SOUT','PREB','SAE','WL_EN','WRITE_EN')})
    s.device('sram512_controller','ctrl',0,2040,outmap)
    s.text('INPUT GATE ANTENNA CLAMPS | pad / ESD network connects at chip integration',-1100,760,.28)
    for i,n in enumerate(('CLK','RESET','SDI','WE')):
        s.device('sram512_input_clamp','input_'+n.lower(),-1100+i*420,980,dict(IN=n,VDD='VDD',VSS='VSS'))
    if not tb:
        for i,n in enumerate(ports):s.named_port(n,-1100,1400+i*140,'inout' if n.startswith('V') else 'out' if n=='SDO' else 'in')
    s.text('Common lines Y / YB feed the shared write pulldown and 7T sense amplifier',1000,3270,.34)
    s.text('E0 precharge; E1 release; E2 write drive; E3 WL; E4 SAE; E5 WL off; E6 capture; E7 end',1000,3340,.3)
    if tb:
        from analog import scenario,pwl,control
        case=scenario()
        for i,n in enumerate(('VDD','CLK','RESET','SDI','WE')):
            x=-1100+i*600;y=3900
            value="'VSUP'" if n=='VDD' else pwl(case['events'][n])
            s.comp('devices/vsource.sym',x,y,f'name=V{n} value="{value}"')
            s.label(x,y-30,n);s.label(x,y+30,'VSS')
            s.text(n+' stimulus',x-100,y-180,.3)
        s.comp('devices/gnd.sym',-1100,4050,'name=g0 lab=0')
        loads=[(f'{p}{i}','CBLWIRE') for i in range(32) for p in ('BL','BLB')]
        loads +=[(f'WL{i}','CWLWIRE') for i in range(16)]+[(n,'CYWIRE') for n in ('Y','YB')]+[('SDO','CSDO')]
        s.text('SIMULATION-ONLY EXTRA WIRE LOADS (MOS intrinsic capacitance is already present)',2200,3690,.34)
        for i,(n,param) in enumerate(loads):
            x=2300+(i%16)*300;y=3910+(i//16)*230
            s.comp('devices/capa.sym',x,y,f'name=CLOAD_{n} value="\'{param}\'"')
            s.label(x,y-30,n);s.label(x,y+30,'VSS')
        s.comp('devices/code.sym',-1100,4330,'name=MODELS only_toplevel=true format="tcleval( @value )" value=".include $::LIB/ip62_models"')
        s.comp('devices/code.sym',-550,4330,'name=SIMULATION only_toplevel=true value="'+control(case).replace('"','\\"')+'"')
        s.comp('devices/netlist_options.sym',0,4330,'name=TB_OPTIONS lvs_netlist=false top_is_subckt=false spiceprefix=true hiersep=. ')
        for i,op in enumerate(case['operations']):
            s.text(f'{op["first"]/1000:g} us: {"W" if op["write"] else "R"} row {op["row"]}, column {op["col"]} = {op["data"]}',-1100,4570+i*60,.28)
        s.finish();s.lines=[line.replace('lab=VSS','lab=0') for line in s.lines]
        s.save('sram512_tb.sch');write_json(HERE/'analog_scenario.json',case)
    else:
        s.finish();s.save('sram512.sch');symbol('sram512',['CLK','RESET','SDI','WE'],['SDO'])

def macro():
    s=Sheet()
    s.text('SRAM512 MACRO | 16 x 32 | seven external connections',-550,-430,.45)
    s.text('The inner sheet contains the complete cell array and peripheral circuits.',-550,-370,.3)
    ports=['CLK','RESET','SDI','WE','SDO','VDD','VSS']
    s.device('sram512','core',0,0,{n:n for n in ports})
    for i,n in enumerate(ports):
        s.named_port(n,-550,-210+i*90,'inout' if n.startswith('V') else 'out' if n=='SDO' else 'in')
    s.finish();s.save('sram512_macro.sch')
    symbol('sram512_macro',['CLK','RESET','SDI','WE'],['SDO'])

def main():
    from layout_inputs import schematic as input_schematic
    input_schematic()
    for b in blocks():logic_sheet(b)
    bitcell_array();column_cell();controller();top();top(True);macro()
    path=netlist(ROOT/'sram512/schematics/sram512.sch',WORK/'schematic')
    print(path)

if __name__=='__main__':main()
