#!/usr/bin/env python3
"""Explicit placement of the 2x2 controller and its SPICE TB (no synthesis).

Run only when intentionally regenerating these schematics: manual edits to the
output .sch/.sym files will be overwritten. Verification does not regenerate.
"""
from pathlib import Path
import json
import os
import re

ROOT = Path(__file__).resolve().parents[1]
PDK = Path(os.environ.get('PDK_ROOT', '/home/ishi-kai/pdk')) / os.environ.get('PDK', 'TR-1um')
LIB = PDK / 'libs.tech/xschem/TR-1um_5_stdcell'
OUT = ROOT / 'build/serial_sch'

class Sheet:
    def __init__(self):
        self.lines = ['v {xschem version=3.4.8RC file_version=1.3}', 'G {}', 'K {}', 'V {}', 'S {}', 'E {}']
        self.pins = {}
        self.cells = {}
        self.attached = set()
    def comp(self, sym, x, y, props, rot=0):
        self.lines.append(f'C {{{sym}}} {x} {y} {rot} 0 {{{props}}}')
    def wire(self, points, net):
        for (x,y),(a,b) in zip(points,points[1:]):
            if (x,y)!=(a,b):
                assert x==a or y==b
                self.lines.append(f'N {x} {y} {a} {b} {{lab={net}}}')
    def label(self, x, y, net, rot=0, onwire=False):
        self.comp('devices/lab_wire.sym' if onwire else 'devices/lab_pin.sym', x,y,
                  f'name=l{len(self.lines)} lab={net}',rot)
    def text(self, text, x, y, size=.3):
        self.lines.append(f'T {{{text}}} {x} {y} 0 0 {size} {size} {{}}')
    def port(self, name, x, y, direction='in'):
        kind = {'in':'ipin','out':'opin','inout':'iopin'}[direction]
        self.comp(f'devices/{kind}.sym',x,y,f'name=p{name} lab={name}')
    def gate(self, kind, name, x, y, **nets):
        self.comp(f'TR-1um_5_stdcell/{kind}.sym',x,y,'name='+name)
        mapped = {}
        for m in re.finditer(r'B 5 ([-\d.]+) ([-\d.]+) ([-\d.]+) ([-\d.]+) \{name=(\w+) dir=\w+\}', (LIB/(kind+'.sym')).read_text()):
            pin=m[5]; px=x+round((float(m[1])+float(m[3]))/2); py=y+round((float(m[2])+float(m[4]))/2)
            net=nets.get(pin, 'VDD' if pin=='VDD' else 'VSS' if pin=='GND' else name+'_'+pin)
            self.pins[name,pin]=(px,py,net)
            mapped[pin]=net
        self.cells[name]={'type':kind, 'nets':mapped}
        return name
    def at(self, name, pin):
        return self.pins[name,pin][:2]
    def lead(self, name, pin, points, label=True):
        x,y,net=self.pins[name,pin]
        self.wire([(x,y)]+points,net)
        self.attached.add((name,pin))
        if label:
            self.label(*points[-1],net,2 if points[-1][0]>x else 0)
    def link(self, a, pa, b, pb, via=(), label=False):
        x,y,net=self.pins[a,pa];xx,yy,other=self.pins[b,pb]
        assert net==other,(a,pa,b,pb,net,other)
        self.wire([(x,y)]+list(via)+[(xx,yy)],net)
        self.attached.update([(a,pa),(b,pb)])
        if label:
            self.label(x+30,y,net,onwire=True)
    def finish(self):
        # Supply labels and shared inter-section signals only. Data paths,
        # MUX feedback and DFF D inputs have already been explicitly wired.
        for key,(x,y,net) in self.pins.items():
            if key not in self.attached:
                if key[1]=='QB' and net.endswith('_QB'):
                    self.comp('devices/noconn.sym',x,y,f'name=nc{len(self.lines)}')
                else:
                    self.label(x,y,net,2 if key[1] in ['Q','QB','Y','GND'] else 0)
    def save(self, name):
        (ROOT/'learning/schematics'/name).write_text('\n'.join(self.lines)+'\n')


def controller():
    s=Sheet()
    s.text('SERIAL SRAM CONTROLLER | 2 x 2 | 13 DFFR | asynchronous RESET',-180,-420,.48)
    s.text('CLK steps through RX0 / RX1 / RX2 / E0 ... E7. All gates below are real PDK cells.',-180,-355,.3)
    s.text('A  /  MODULO-11 COUNTER',-180,-250,.36)
    # Counter: count+1 for 0..9; zero for 10..15.
    for i in range(4):
        y=60+280*i
        if i:
            s.gate('XOR2',f'xtoggle{i}',210,y-20,A=f'C{i}',B='C0' if i==1 else f'CARRY{i}',Y=f'TOGGLE{i}')
        s.gate('AND2_X1',f'xnext{i}',560,y,A='C0B' if i==0 else f'TOGGLE{i}',B='COUNT_RUN',Y=f'NEXT{i}')
        s.gate('DFFR',f'xcnt{i}',1010,y+30,D=f'NEXT{i}',Q=f'C{i}',QB=f'C{i}B',CK='CLK',RST='RESET')
        s.link(f'xnext{i}','Y',f'xcnt{i}','D',label=True)
        if i:s.link(f'xtoggle{i}','Y',f'xnext{i}','A')
        s.lead(f'xcnt{i}','Q',[(1220,y)])
        s.lead(f'xcnt{i}','QB',[(1220,y+40)])
        s.lead(f'xcnt{i}','CK',[(900,y+40)],False)
        s.lead(f'xcnt{i}','RST',[(1010,y+110),(950,y+110)],False)
        s.lead(f'xnext{i}','B',[(490,y+20)],False)
    for x,net,start,end in [(900,'CLK',-60,1070),(950,'RESET',-20,1090),(490,'COUNT_RUN',-110,1020)]:
        s.wire([(x,start),(x,end)],net)
        if net=='COUNT_RUN':s.label(x,start,net,onwire=True)
    s.port('CLK',900,-60);s.port('RESET',950,-20)
    s.gate('AND2_X1','xcarry2',0,1200,A='C0',B='C1',Y='CARRY2')
    s.gate('AND3_X1','xcarry3',520,1200,A='C0',B='C1',C='C2',Y='CARRY3')
    s.gate('OR2','xupper',0,1430,A='C1',B='C2',Y='UPPER')
    s.gate('NAND2','xrun',310,1450,A='C3',B='UPPER',Y='COUNT_RUN')
    s.link('xupper','Y','xrun','B',via=[(230,1430),(230,1470)])
    s.text('COUNT_RUN = !(C3 & (C2 | C1)): advance 0..9; wrap 10..15 to 0',-180,1600,.24)

    # Shared count / complement rails make each equality comparison visible.
    s.text('B  /  CURRENT-COUNT DECODE',1510,-250,.36)
    rails={f'C{i}{b}':1450+25*(2*i+j) for i in range(4) for j,b in enumerate(['','B'])}
    for n,x in rails.items():
        top=-140 if n.endswith('B') else -80
        s.wire([(x,top),(x,1450)],n);s.label(x,top,n,onwire=True)
    for e in range(8):
        v=e+3;y=100+180*e
        nets={p:f'C{bit}'+('' if (v>>bit)&1 else 'B') for p,bit in zip('ABCD',[3,2,1,0])}
        s.gate('AND4_X1',f'xdecode{e}',1830,y,**nets,Y=f'E{e}')
        for p,n in nets.items():
            px,py=s.at(f'xdecode{e}',p)
            s.lead(f'xdecode{e}',p,[(rails[n],py)],False)
        s.lead(f'xdecode{e}','Y',[(2180,y)])
        if e==7:s.comp('devices/noconn.sym',2180,y,'name=nc_e7')
        s.text(f'{v:04b}  =  {v}  /  E{e}',1930,y+70,.23)
    s.gate('NAND2','xrx_low',1370,1690,A='C0',B='C1',Y='RX_LOW')
    s.gate('AND3_X1','xrx',1810,1690,A='C3B',B='C2B',C='RX_LOW',Y='RX')
    s.link('xrx_low','Y','xrx','C',via=[(1640,1690),(1640,1710)])
    s.text('RX = count < 3. E0 = count == 3. Decode is sampled by DFFs.',1370,1860,.24)

    # Output equations are separate visible gate chains ending in DFFs.
    s.text('C  /  REGISTERED CONTROL OUTPUTS',2530,-250,.36)
    # One DFF's QB directly drives both physical precharge domains.
    s.gate('DFFR','xpc',4380,130,D='E0',Q='PC_ON',QB='PREB',CK='CLK',RST='RESET')
    s.lead('xpc','Q',[(4590,100)],False)
    s.label(4510,100,'PC_ON',onwire=True)
    s.comp('devices/noconn.sym',4590,100,'name=nc_pc_on')
    s.lead('xpc','D',[(4000,100)])
    s.lead('xpc','QB',[(4650,140)],False);s.port('PREB',4650,140,'out')
    s.text('PC_ON.QB -> PREB (also common-line YPREB)',3900,265,.25)
    s.gate('OR2','xwl_d',3450,440,A='E3',B='E4',Y='WL_D')
    s.gate('DFFR','xwl',4380,470,D='WL_D',Q='WL_EN',CK='CLK',RST='RESET')
    s.link('xwl_d','Y','xwl','D',label=True)
    s.lead('xwl','Q',[(4650,440)],False);s.port('WL_EN',4650,440,'out')
    s.gate('OR4','xwrite_window',2690,750,A='E2',B='E3',C='E4',D='E5',Y='WRITE_WINDOW')
    s.gate('AND2_X1','xwrite_d',3450,770,A='WRITE_WINDOW',B='W',Y='WRITE_D')
    s.link('xwrite_window','Y','xwrite_d','A',label=True)
    s.gate('DFFR','xwrite',4380,800,D='WRITE_D',Q='WRITE_EN',CK='CLK',RST='RESET')
    s.link('xwrite_d','Y','xwrite','D',label=True)
    s.lead('xwrite','Q',[(4650,770)],False);s.port('WRITE_EN',4650,770,'out')
    s.gate('INV_X1','xwe_b',2700,1050,A='WE',Y='WE_B')
    s.gate('AND2_X1','xtrack_e0',3190,1070,A='WE_B',B='E0',Y='TRACK_E0')
    s.link('xwe_b','Y','xtrack_e0','A')
    s.gate('OR3','xtrack_window',2690,1400,A='E1',B='E2',C='E3',Y='TRACK_WINDOW')
    s.gate('AND2_X1','xtrack_later',3190,1420,A='TRACK_WINDOW',B='W_B',Y='TRACK_LATER')
    s.link('xtrack_window','Y','xtrack_later','A')
    s.gate('OR2','xtrack_d',3780,1260,A='TRACK_E0',B='TRACK_LATER',Y='TRACK_D')
    s.link('xtrack_e0','Y','xtrack_d','A',via=[(3540,1070),(3540,1240)])
    s.link('xtrack_later','Y','xtrack_d','B',via=[(3600,1420),(3600,1280)])
    s.gate('DFFR','xtrack',4380,1290,D='TRACK_D',Q='TRACK',QB='SAE',CK='CLK',RST='RESET')
    s.lead('xtrack','Q',[(4590,1260)],False)
    s.label(4510,1260,'TRACK',onwire=True)
    s.comp('devices/noconn.sym',4590,1260,'name=nc_track')
    s.link('xtrack_d','Y','xtrack','D',label=True)
    s.lead('xtrack','QB',[(4650,1300)],False);s.port('SAE',4650,1300,'out')
    s.text('E0 uses external WE; E1..E3 use the held W. SAE is TRACK.QB.',2540,1600,.25)
    # Shared physical CLK and RESET trunks beside all four output DFFs.
    for name,y in [('xpc',100),('xwl',440),('xwrite',770),('xtrack',1260)]:
        s.lead(name,'CK',[(4180,y+40)],False)
        s.lead(name,'RST',[(4380,y+110),(4240,y+110)],False)
    for x,n in [(4180,'CLK'),(4240,'RESET')]:
        s.wire([(x,-80),(x,1490)],n);s.label(x,-80,n,onwire=True)

    def enabled_register(name, x, y, data, q, enable, qb=None, output=False):
        # Y aligned to D, and a visible loop back from Q to MUX A.
        mx=name+'_mux';ff=name+'_ff'
        s.gate('MUX2',mx,x+100,y,A=q,B=data,S=enable,Y=name+'_D')
        nets=dict(D=name+'_D',Q=q,CK='CLK',RST='RESET')
        if qb:nets['QB']=qb
        s.gate('DFFR',ff,x+400,y+30,**nets)
        s.link(mx,'Y',ff,'D',label=True)
        s.link(ff,'Q',mx,'A',via=[(x+550,y),(x+550,y-120),(x+20,y-120),(x+20,y-20)])
        s.lead(ff,'Q',[(x+620,y)],not output)
        if output:s.port(q,x+620,y,'out')
        s.lead(ff,'CK',[(x+340,y+40),(x+340,y+130)],False)
        s.lead(ff,'RST',[(x+400,y+180)],False)
        s.lead(mx,'S',[(x+120,y+230)],False)
        return mx,ff

    s.text('D  /  SHARED FRAME: SDI -> DIN -> CA -> RA  (MUX holds when RX=0)',-180,1990,.34)
    shifts=[]
    frame=['DIN','CA','RA']
    for i in range(3):
        x=900*i;mx,ff=enabled_register(f'xshift{i}',x,2250,'SDI' if i==0 else frame[i-1],frame[i],'RX',output=True)
        shifts.append((mx,ff))
        s.text(['After RX2: DIN','After RX2: CA','After RX2: RA'][i],x+300,2170,.23)
    s.lead(shifts[0][0],'B',[(-150,2270)],False);s.port('SDI',-150,2270)
    for i in range(1,3):
        x=900*i;s.link(shifts[i-1][1],'Q',shifts[i][0],'B',via=[(x-120,2250),(x-120,2270)])
    for dy,n in [(130,'CLK'),(180,'RESET'),(230,'RX')]:
        s.wire([(-150,2250+dy),(2540,2250+dy)],n);s.label(-150,2250+dy,n,onwire=True)

    s.text('During RX: RA / CA / DIN shift; WL and write are OFF; SAE=1 isolates the SA.',-180,2660,.27)
    s.text('After RX2: the complete address and data stay fixed through E0..E7.',-180,2730,.27)
    s.text('E0 samples WE and precharges bitlines. No second address/data register bank.',-180,2800,.27)
    s.text('E  /  WRITE MODE: sample WE at E0 only',2830,2660,.3)
    mx,ff=enabled_register('xcmd3',2700,2920,'WE','W','E0','W_B')
    s.lead(mx,'B',[(2550,2940)],False);s.port('WE',2550,2940)
    s.text('W held during shifting and E1..E7',2800,3280,.24)
    for dy,n in [(130,'CLK'),(180,'RESET'),(230,'E0')]:
        s.wire([(2550,2920+dy),(3510,2920+dy)],n);s.label(2550,2920+dy,n,onwire=True)

    s.text('F  /  READ RESULT: capture at read E6; hold through writes',2830,1990,.3)
    s.gate('AND2_X1','xread_capture',2750,2130,A='E6',B='W_B',Y='READ_CAPTURE')
    mx,ff=enabled_register('xread',3270,2250,'SOUT','SDO','READ_CAPTURE')
    s.lead(mx,'B',[(3090,2270)],False);s.port('SOUT',3090,2270)
    s.port('SDO',3890,2250,'out')
    for dy,n in [(130,'CLK'),(180,'RESET'),(230,'READ_CAPTURE')]:
        s.wire([(3200,2250+dy),(3970,2250+dy)],n);s.label(3200,2250+dy,n,onwire=True)
    s.text('All MUX: S=0 -> A (feedback); S=1 -> B (new data).',-180,3430,.28)
    s.text('RST pins connect directly to RESET. Q resets LOW; QB resets HIGH. No custom bit-register symbols.',-180,3490,.28)
    s.text('NC: intentionally no circuit load; named nets remain available for waveform probes.',-180,3550,.25)
    s.port('VDD',3930,2910,'inout');s.port('VSS',3930,3050,'inout')
    s.finish()
    return s


def controller_symbol():
    name='sram_serial_controller';width=280;height=370
    lines=['v {xschem version=3.4.8RC file_version=1.3}',
           'K {type=subcircuit\nformat="@name @pinlist @symname"\ntemplate="name=xctrl"\n}',
           f'P 4 5 {-width} {-height} {width} {-height} {width} {height} {-width} {height} {-width} {-height} {{}}',
           'T {SERIAL CONTROLLER} -250 -340 0 0 0.3 0.3 {}',
           'T {2 x 2 / 13 DFFR} -250 -295 0 0 0.25 0.25 {}',
           'T {RX0 RX1 RX2 -> E0 ... E7} -250 300 0 0 0.23 0.23 {}',
           'T {@name} 190 -400 0 0 0.22 0.22 {}']
    pins={}
    for i,n in enumerate(['CLK','RESET','SDI','WE','SOUT']):pins[n]=(-300,-170+85*i,'in')
    for i,n in enumerate(['RA','CA','DIN','PREB','WRITE_EN','WL_EN','SAE','SDO']):pins[n]=(300,-245+70*i,'out')
    pins.update(VDD=(0,-390,'inout'),VSS=(0,390,'inout'))
    for n,(x,y,d) in pins.items():
        lines.append(f'B 5 {x-2.5} {y-2.5} {x+2.5} {y+2.5} {{name={n} dir={d}}}')
        xx=(-width if x<0 else width) if x else 0;yy=y if x else (-height if y<0 else height)
        lines.append(f'L 4 {x} {y} {xx} {yy} {{}}')
        lines.append(f'T {{{n}}} {xx+12 if x<0 else xx-125 if x>0 else 15} {y-5 if x else y+(35 if y<0 else -35)} 0 0 0.22 0.22 {{}}')
    return '\n'.join(lines)+'\n',pins


def testbench(pins):
    from serial_spice_stimulus import scenario, pwl
    case=scenario();s=Sheet()
    old=(ROOT/'learning/schematics/sram_tb_array_write_control.sch').read_text()
    replaced={(-680,430),(-680,510),(-680,940),(-680,1470),(-680,1550),(1000,1440),
              (-40,0),(460,0),(760,0),(1260,0),(110,1170),(610,1170)}
    for rec in re.split(r'(?=^[A-Z] )',old,flags=re.M):
        if rec.startswith('N '):s.lines.append(rec.rstrip().replace('YPREB','PREB'))
        elif rec.startswith('C '):
            m=re.match(r'C \{([^}]+)\} (-?\d+) (-?\d+)',rec)
            sym,x,y=m[1],int(m[2]),int(m[3])
            if sym in ['devices/vsource.sym','devices/code.sym','devices/netlist_options.sym'] or y>=1900:continue
            if sym=='devices/lab_pin.sym' and (x,y) in replaced:continue
            s.lines.append(rec.rstrip().replace('YPREB','PREB'))
            # SRAM Q/QB are waveform probes, with no electrical load in this TB.
            if sym=='devices/lab_pin.sym' and re.search(r'\blab=QB?[01][01]\b',rec):
                net=re.search(r'\blab=(\w+)',rec)[1]
                s.comp('devices/noconn.sym',x,y,f'name=nc_{net}')
    s.text('SERIAL 2 x 2 SRAM | 7-pin interface | real standard-cell controller',-2130,-350,.43)
    s.text('SRAM cells above / column mux and common lines in the middle / shared write and sense below',-800,-250,.27)
    s.text('COLUMN 0',100,-175);s.text('COLUMN 1',900,-175)
    s.text('ROW DECODE',-680,180);s.text('COLUMN DECODE',-730,1240,.27)
    s.text('COMMON PRECHARGE / WRITE / SENSE',-180,1730,.3)
    s.text('CBL=10f, CY=100f: added learning loads, not extracted capacitance',-180,1790,.25)
    cx,cy=-1450,2280
    s.comp('sram_serial_controller.sym',cx,cy,'name=xctrl')
    coords={n:(cx+x,cy+y) for n,(x,y,_) in pins.items()}
    for n in ['VDD','VSS']:
        s.label(*coords[n],'GND' if n=='VSS' else n)
    for n,bus,endpoint in [('RA',-1050,(-680,430)),('CA',-1010,(-680,940)),
                            ('DIN',-970,(-680,1470)),('WL_EN',-930,(-680,510)),
                            ('WRITE_EN',-890,(-680,1550))]:
        x,y=coords[n];ex,ey=endpoint
        s.wire([(x,y),(bus,y),(bus,ey),(ex,ey)],n)
        s.label(ex,ey,n)
    x,y=coords['PREB']
    s.wire([(x,y),(-810,y),(-810,-40),(1260,-40)],'PREB')
    for gx in [-40,460,760,1260]:s.wire([(gx,-40),(gx,0)],'PREB')
    s.wire([(-810,1070),(610,1070),(610,1170)],'PREB')
    s.wire([(110,1070),(110,1170)],'PREB')
    s.label(-810,-40,'PREB',onwire=True)
    x,y=coords['SAE'];s.wire([(x,y),(930,y),(930,1440),(1000,1440)],'SAE');s.label(930,y,'SAE',onwire=True)
    x,y=coords['SOUT'];s.wire([(1500,1320),(1860,1320),(1860,2750),(-1840,2750),(-1840,y),(x,y)],'SOUT')
    x,y=coords['SDO'];s.wire([(x,y),(-540,y)],'SDO');s.port('SDO',-540,y,'out')
    s.comp('devices/capa.sym',-620,y+80,'name=CSDO value=10f m=1')
    s.wire([(-620,y),(-620,y+50)],'SDO');s.comp('devices/gnd.sym',-620,y+110,'name=g_sdo lab=GND')
    for n in ['CLK','RESET','SDI','WE']:
        x,y=coords[n]
        s.comp('devices/vsource.sym',-2070,y+30,f'name=V{n}\nvalue="{pwl(n,case["timeline"])}"\nsavecurrent=false\nhide_texts=true')
        s.wire([(-2070,y),(x,y)],n);s.label(-1970,y,n,onwire=True)
        s.comp('devices/gnd.sym',-2070,y+60,f'name=g_{n} lab=GND')
    s.comp('devices/vsource.sym',-2070,1840,'name=VVDD value=5 savecurrent=false')
    s.label(-2070,1810,'VDD');s.comp('devices/gnd.sym',-2070,1870,'name=g_vdd lab=GND')
    s.text('EXTERNAL INPUTS ONLY',-2140,1960,.28)
    s.text('SOUT returns to result FF -> SDO',-300,2720,.27)
    notes=['ONE OPERATION = 11 rising edges / CLK=100 ns',
           'RX0: RA / RX1: CA / RX2: DIN (read: dummy 0)',
           'E0: frame held; latch WE; precharge; read SA reset',
           'E1: precharge OFF', 'E2: write pull-down ON (write only)',
           'E3: WL_EN HIGH', 'E4: SAE HIGH / sense decision',
           'E5: WL_EN LOW / write pull-down stays ON',
           'E6: release write / latch SOUT into SDO',
           'E7: finish / next CLK receives next RA',
           '', 'Startup RESET: no CLK until 250 ns.',
           '16 checkerboard writes/reads, then partial RX reset.',
           'Read old cell after reset, then another write/read.',
           'RX shifts RA/CA/DIN; E0..E7 holds. WE sampled at E0.',
           'No .ic: only written SRAM cells have expected contents.',
           'Q/QB NC markers: waveform probes, no circuit load.',
           '', 'CONTROL INTERNALS: descend into xctrl (e).',
           'Flat sheet: DFFR + MUX feedback is directly visible.',
           'All RST pins use asynchronous RESET; no helper bit symbols.']
    for i,n in enumerate(notes):s.text(n,2230,-200+48*i,.27)
    for i,o in enumerate(case['operations']):
        s.text(f'{o["first"]:5d} ns RX: {"W" if o["write"] else "R"} row{o["row"]} col{o["col"]} = {o["data"]}',2230,860+i*38,.25)
    signals=['CLK','RESET','SDI','WE','SDO','RA','CA','DIN','PREB','WL_EN','WRITE_EN','SAE',
             'WL0','WL1','COL0','COL1','PD_Y','PD_YB','BL0','BLB0','BL1','BLB1','Y','YB','SOUT','SOUTB']
    signals += ['Q'+str(r)+str(c) for r in range(2) for c in range(2)]
    signals += ['QB'+str(r)+str(c) for r in range(2) for c in range(2)]
    signals += ['xctrl.'+n for n in ['C0','C1','C2','C3','W','RX','E0','E1','E2','E3','E4','E5','E6','E7']]
    control=['.param CBL=10f CY=100f','.control','save '+' '.join('v('+n+')' for n in signals),
             f'tran 0.5n {case["stop"]}n','let failures = 0']
    for i,o in enumerate(case['operations']):
        n='cell'+str(i);at=o['e0']+780
        control += [f'meas tran {n} find v(Q{o["row"]}{o["col"]}) at={at}n',
                    f'if {n} '+('< 4.5' if o['data'] else '> 0.5'),' let failures = failures + 1','end']
        if not o['write']:
            n='read'+str(i);control += [f'meas tran {n} find v(SDO) at={o["e0"]+680}n',
                    f'if {n} '+('< 4.5' if o['data'] else '> 0.5'),' let failures = failures + 1','end']
    control += ['if failures = 0',' echo PASS: serial writes and reads; run scripts/verify_serial_spice.py for RTL and timing checks',
                'else',' echo FAIL: serial SRAM; inspect measurements',' print failures','end',
                'let count = (v(xctrl.C0)+2*v(xctrl.C1)+4*v(xctrl.C2)+8*v(xctrl.C3))/5',
                'set wr_singlescale','set wr_vecnames',
                'wrdata serial_spice_waveforms.txt '+' '.join('v('+n+')' for n in signals),
                'write sram_tb_serial.raw',
                "plot v(CLK) v(SDI) v(WE) xlimit 180n 1500n title 'SERIAL INPUT: RX at 250 / 350 / 450 ns, E0 at 550 ns'",
                "plot count xlimit 180n 2550n title 'COUNT: 0..10; pre-edge count names the action'",
                "plot v(RA) v(CA) v(DIN) v(xctrl.W) xlimit 180n 2550n title 'FRAME: RA/CA/DIN shift during RX; hold E0..E7; W samples WE at E0'",
                "plot v(SOUT) v(SDO) title 'READ RESULT: SDO captures SOUT at E6 and holds through writes'",
                "plot v(Q00) v(Q01) v(Q10) v(Q11) title 'STORED CELLS: written by serial commands, no initial-value forcing'"]
    for i,n in enumerate(['PREB','WRITE_EN','WL_EN','SAE']):control.append(f'let {n}_T = v({n})/5+{6-2*i}')
    control += ["plot PREB_T WRITE_EN_T WL_EN_T SAE_T xlimit 450n 2450n title 'CONTROLS: PREB+6 WRITE_EN+4 WL_EN+2 SAE+0'",'.endc']
    s.comp('devices/code.sym',2230,1870,'name=TR_1um_MODELS\nonly_toplevel=true\nformat="tcleval( @value )"\nvalue=".include $::LIB/ip62_models"')
    s.comp('devices/code.sym',2590,1870,'name=SIMULATION\nonly_toplevel=true\nvalue="'+'\n'.join(control)+'"')
    s.comp('devices/netlist_options.sym',2230,2060,'name=NETLIST_OPTIONS\nlvs_netlist=false\ntop_is_subckt=false\nspiceprefix=true\nhiersep=. ')
    return s

def main():
    OUT.mkdir(parents=True,exist_ok=True)
    s=controller();s.save('sram_serial_controller.sch')
    sym,pins=controller_symbol();(ROOT/'learning/schematics/sram_serial_controller.sym').write_text(sym)
    (OUT/'intended_connections.json').write_text(json.dumps(s.cells,indent=2)+'\n')
    (OUT/'symbol_pins.json').write_text(json.dumps(pins,indent=2)+'\n')
    testbench(pins).save('sram_tb_serial.sch')
    print(f'Controller: {len(s.cells)} standard cells; '+str(sum(c['type']=='DFFR' for c in s.cells.values()))+' DFFR')

if __name__=='__main__':main()
