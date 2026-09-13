"""Explicit, readable 16x32 gate construction, shared by schematic/layout tools.

This is not logic synthesis. DFFs, feedback MUXs, phase comparisons and
predecoders are instantiated directly; RTL remains an independent reference.
"""
from collections import Counter
from common import *

ROWS=16; COLS=32; RX_BITS=10; CLOCKS=18

class Block:
    def __init__(self,name,inputs,outputs,inouts=('VDD','VSS')):
        self.name=name;self.inputs=list(inputs);self.outputs=list(outputs);self.inouts=list(inouts)
        self.parts=[];self.notes=[]
    @property
    def ports(self):return self.inputs+self.outputs+self.inouts
    def add(self,kind,name,x,y,**nets):
        self.parts.append(dict(kind=kind,name=name,nets={'VDD':'VDD','GND':'VSS',**nets},xy=[x,y]))
        return nets.get('Y',nets.get('Q'))
    def logic(self,op,name,inputs,out,x,y):
        assert 2<=len(inputs)<=4
        kind=f'AND{len(inputs)}_X1' if op=='AND' else f'OR{len(inputs)}'
        return self.add(kind,name,x,y,Y=out,**dict(zip('ABCD',inputs)))
    def ff(self,name,d,q,x,y,qb=None):
        self.add('DFFR',name,x,y,D=d,Q=q,QB=qb or q+'B',CK='CLK',RST='RESET')
    def hold(self,name,d,q,en,x,y,qb=None):
        self.add('MUX2',name+'_hold',x,y,A=q,B=d,S=en,Y=q+'_D')
        self.ff(name,q+'_D',q,x+300,y+30,qb)

def phase():
    b=Block('sram512_phase',['CLK','RESET'],['RX']+[f'E{i}' for i in range(8)])
    b.notes=[('MODULO-18 COUNTER: count before CLK names the action ON that edge',-300,-400),
             ('RX0..RX9 receive RA[3:0], CA[4:0], DIN (MSB first); E0..E7 perform one access',-300,-330),
             ('FULL 5-BIT PHASE COMPARISONS (no asynchronous control outputs)',1850,-300)]
    b.logic('AND','count_low_zero',[f'C{i}B' for i in range(4)],'LOW_ZERO',0,1650)
    b.logic('OR','count_run',['C4B','LOW_ZERO'],'COUNT_RUN',450,1650)
    b.notes.append(('COUNT_RUN = count < 17; states 17..31 go to 0',-180,1810))
    for i in range(5):
        y=i*300
        if i>=2:b.logic('AND',f'carry{i}',[f'C{j}' for j in range(i)],f'CARRY{i}',-160,y+120)
        toggle='C0B'
        if i:
            toggle=f'TOGGLE{i}'
            b.add('XOR2',f'toggle{i}',160,y,A=f'C{i}',B='C0' if i==1 else f'CARRY{i}',Y=toggle)
        b.logic('AND',f'next{i}',[toggle,'COUNT_RUN'],f'NEXT{i}',480,y)
        b.ff(f'counter{i}',f'NEXT{i}',f'C{i}',850,y+30)
    for i in range(8):
        value=10+i;y=i*240
        inputs=[f'C{j}'+('' if value>>j&1 else 'B') for j in range(4)]
        b.logic('AND',f'phase{i}_low',inputs,f'E{i}_LOW',2140,y)
        b.logic('AND',f'phase{i}',[f'E{i}_LOW','C4' if value&16 else 'C4B'],f'E{i}',2470,y)
        b.notes.append((f'{value:05b} = {value} : E{i}',2620,y+85))
    b.logic('AND','rx_low',['C2B','C1B'],'RX_LOW',1560,2160)
    b.logic('OR','rx_upper',['C3B','RX_LOW'],'RX_UPPER',1890,2160)
    b.logic('AND','rx',['C4B','RX_UPPER'],'RX',2230,2160)
    b.notes.append(('RX = count < 10',2320,2290))
    return b

FRAME=['DIN']+[f'CA{i}' for i in range(5)]+[f'RA{i}' for i in range(4)]
def frame():
    b=Block('sram512_frame',['CLK','RESET','RX','SDI'],[n+s for n in FRAME for s in ('','B')])
    b.notes=[('SHARED RECEIVE / ACCESS STORAGE: 10 DFFR + 10 feedback MUX2',-250,-300),
             ('RX=1 shifts; RX=0 holds the complete frame. All FFs use the same ungated CLK.',-250,-230)]
    for i,q in enumerate(FRAME):
        x=(i%5)*760;y=(i//5)*780
        b.hold('frame_'+q,'SDI' if i==0 else FRAME[i-1],q,'RX',x,y)
        b.notes.append((f'bit {i}: {q}',x+170,y-100))
    return b

def control():
    b=Block('sram512_control',['CLK','RESET','WE','SOUT']+[f'E{i}' for i in range(7)],
            ['PREB','WL_EN','WRITE_EN','SAE','READ_DATA'])
    b.notes=[('REGISTERED ACCESS CONTROL: six DFFR, including W and read-result storage',-150,-330),
             ('E0 PC | E1 release | E2 write drive | E3 WL | E4 sense | E5 WL off | E6 capture / PD off',-150,-260)]
    b.ff('pc','E0','PC_ON',1800,30,'PREB')
    b.logic('OR','wl_window',['E3','E4'],'WL_D',850,310);b.ff('wl','WL_D','WL_EN',1800,340)
    b.logic('OR','write_window',[f'E{i}' for i in (2,3,4,5)],'WRITE_WINDOW',300,610)
    b.logic('AND','write_data',['WRITE_WINDOW','W'],'WRITE_D',850,610)
    b.ff('write','WRITE_D','WRITE_EN',1800,640)
    b.add('INV_X1','we_b',-100,910,A='WE',Y='WE_B')
    b.logic('AND','track_first',['WE_B','E0'],'TRACK_FIRST',300,930)
    b.logic('OR','track_later_window',['E1','E2','E3'],'TRACK_WINDOW',-100,1230)
    b.logic('AND','track_later',['TRACK_WINDOW','WB'],'TRACK_LATER',300,1250)
    b.logic('OR','track_data',['TRACK_FIRST','TRACK_LATER'],'TRACK_D',850,1090)
    b.ff('track','TRACK_D','TRACK',1800,1120,'SAE')
    b.hold('mode','WE','W','E0',600,1580)
    b.logic('AND','read_capture',['E6','WB'],'READ_CAPTURE',300,1910)
    b.hold('result','SOUT','READ_DATA','READ_CAPTURE',600,2240)
    b.notes.append(('W samples WE only at E0. SDO storage updates only on read E6.',-150,2530))
    return b

def row():
    b=Block('sram512_row_decoder',[f'RA{i}' for i in range(4)]+['WL_EN'],[f'WL{i}' for i in range(16)])
    b.notes=[('4-to-16 ROW DECODER: 2+2 predecode, AND3_X1 per 32-cell wordline',-180,-330),
             ('WL_EN=0 keeps every WL LOW; row address is fixed before the access window',-180,-260)]
    for i in range(4):b.add('INV_X1',f'address_b{i}',-150,i*480,A=f'RA{i}',Y=f'RA{i}B')
    b.notes.append(('Four address complements are generated inside the row decoder.',-180,2710))
    for g in range(2):
        for value in range(4):
            b.logic('AND',f'pre{g}_{value}',[f'RA{2*g+j}'+('' if value>>j&1 else 'B') for j in range(2)],
                    f'R{g}_{value}',350,g*1300+value*250)
    for r in range(16):
        x=1400+(r//8)*1050;y=(r%8)*300
        b.add('AND3_X1',f'driver{r}',x,y,A=f'R0_{r%4}',B=f'R1_{r//4}',C='WL_EN',Y=f'WL{r}')
    b.notes.append(('One continuous WL per row crosses both adjacent 16-column physical blocks.',-180,2780))
    return b

def column():
    b=Block('sram512_col_decoder',[f'CA{i}{s}' for i in range(5) for s in ('','B')],[f'COL{i}' for i in range(32)])
    b.notes=[('5-to-32 COLUMN DECODER: 2+3 predecode; one column selected at a stable address',-180,-330),
             ('No COL_EN. Address shifts only while WL / write are OFF; E0 restores precharge.',-180,-260)]
    for value in range(4):
        b.logic('AND',f'low{value}',[f'CA{j}'+('' if value>>j&1 else 'B') for j in range(2)],f'CL{value}',350,value*260)
    for value in range(8):
        b.logic('AND',f'high{value}',[f'CA{2+j}'+('' if value>>j&1 else 'B') for j in range(3)],f'CH{value}',350,1200+value*260)
    for c in range(32):
        b.logic('AND',f'select{c}',[f'CL{c%4}',f'CH{c//4}'],f'COL{c}',1450+(c//8)*650,(c%8)*380)
    return b

def blocks():return [phase(),frame(),control(),row(),column()]

def definitions():
    source=(WORK/'library/library_reference.spice').read_text()
    return {m[1]:dict(pins=m[2].split(),text=m[0]) for m in re.finditer(
        r'(?ims)^\.subckt\s+(\S+)[ \t]+([^\n]+)\n.*?^\.ends[^\n]*',source)}

def block_spice(b,defs):
    lines=[f'.subckt {b.name} '+ ' '.join(b.ports)]
    for p in b.parts:
        pins=defs[p['kind']]['pins']
        lines.append('X'+p['name']+' '+' '.join(p['nets'][pin] for pin in pins)+' '+p['kind'])
    return '\n'.join(lines+[f'.ends {b.name}'])

if __name__=='__main__':
    defs=definitions();bs=blocks()
    write_json(HERE/'design.json',dict(rows=ROWS,columns=COLS,receive_bits=RX_BITS,clocks_per_operation=CLOCKS,
        blocks=[dict(name=b.name,ports=b.ports,parts=b.parts) for b in bs],
        bom=dict(Counter(p['kind'] for b in bs for p in b.parts))))
    (WORK/'blocks.spice').write_text('\n\n'.join(block_spice(b,defs) for b in bs)+'\n')
