"""Generate the ternary latch/SRAM schematics and self-checking native-ngspice TBs."""
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
HEADER='v {xschem version=3.4.8RC file_version=1.3}\nG {}\nK {}\nV {}\nS {}\nF {}\nE {}\n'
SEQ=[-5,0,5,0,-5,5,-5]
class Sch:
 def __init__(self,title):self.s=HEADER;self.n=0;self.text(40,-140,title,.38)
 def text(self,x,y,t,size=.24):self.s+=f'T {{{t}}} {x} {y} 0 0 {size} {size} {{}}\n'
 def comp(self,sym,x,y,props,rot=0,flip=0):self.s+=f'C {{{sym}}} {x} {y} {rot} {flip} {{{props}}}\n'
 def wire(self,x,y,xx,yy,net):self.s+=f'N {x} {y} {xx} {yy} {{lab={net}}}\n'
 def label(self,x,y,net,kind='lab_pin',flip=0):
  self.n+=1;self.comp(f'devices/{kind}.sym',x,y,f'name=l{self.n} lab={net}',flip=flip)
 def source(self,name,net,value,x,y,kind='vsource',negative='GND'):
  self.comp(f'devices/{kind}.sym',x,y,f'name={name}\nvalue="{value}"\nsavecurrent=false\nhide_texts=true')
  self.label(x,y-30,net);self.label(x,y+30,negative,'gnd' if negative=='GND' else 'lab_pin');self.text(x+30,y-10,name)
 def cap(self,name,net,value,x,y):
  self.comp('devices/capa.sym',x,y,f'name={name} value={value} m=1');self.label(x,y-30,net);self.label(x,y+30,'GND','gnd')
 def code(self,txt,x,y,name='SIMULATION'):
  self.comp('devices/code.sym',x,y,f'name={name}\nonly_toplevel=true\nvalue="{txt}"')
 def setup(self,ctrl,x=1150,y=720):
  self.comp('devices/code.sym',x,y,'name=TR_1um_MODELS\nonly_toplevel=true\nformat="tcleval( @value )"\nvalue=".include $::LIB/ip62_models"')
  self.code(ctrl,x+300,y)
  self.comp('devices/netlist_options.sym',x+600,y,'name=NETLIST_OPTIONS\nlvs_netlist=false\ntop_is_subckt=false\nspiceprefix=true\nhiersep=.')
 def save(self,name):(ROOT/f'{name}.sch').write_text(self.s)
def symbol(name,title,pins):
 s='v {xschem version=3.4.8RC file_version=1.3}\nK {type=subcircuit\nformat="@name @pinlist @symname"\ntemplate="name=x1"}\nG {}\nV {}\nS {}\nE {}\n'
 ybot=120 if name=='ternary_sram' else 60
 s+=f'L 4 -80 -80 80 -80 {{}}\nL 4 80 -80 80 {ybot} {{}}\nL 4 80 {ybot} -80 {ybot} {{}}\nL 4 -80 {ybot} -80 -80 {{}}\nT {{{title}}} -65 -12 0 0 0.24 0.24 {{}}\nT {{@name}} 10 -145 0 0 0.2 0.2 {{}}\n'
 for pin,direction,x,y in pins:
  ex= max(-80,min(80,x));ey=max(-80,min(ybot,y))
  s+=f'L 4 {x} {y} {ex} {ey} {{}}\nB 5 {x-2.5} {y-2.5} {x+2.5} {y+2.5} {{name={pin} dir={direction}}}\n'
  tx=-73 if x<0 else 42 if x>0 else 5;ty=y-18 if x else ey+5 if y<0 else ey-23
  s+=f'T {{{pin}}} {tx} {ty} 0 0 0.18 0.18 {{}}\n'
 (ROOT/f'{name}.sym').write_text(s)
LPINS=[('Q','out',-120,0),('QB','out',120,0),('VDD','inout',0,-120),('VSS','inout',0,100)]
SPINS=[('BL','inout',-140,-40),('BLB','inout',-140,40),('WL','in',-140,100),('Q','out',140,-40),('QB','out',140,40),('VDD','inout',0,-120),('VSS','inout',0,160)]
def dut(s,cell,name,x,y,nets):
 s.comp(str(ROOT/f'{cell}.sym'),x,y,f'name={name}')
 for (p,d,dx,dy),net in zip(LPINS if cell=='ternary_latch' else SPINS,nets):
  ex=dx+(-40 if dx<0 else 40 if dx>0 else 0);ey=dy+(-20 if dy<0 and not dx else 20 if dy>0 and not dx else 0)
  s.wire(x+dx,y+dy,x+ex,y+ey,net);s.label(x+ex,y+ey,net,flip=int(dx>0))
def supplies(s,y=480):
 s.source('VDD','VDD','5',120,y);s.source('VSS','VSS','-5',360,y)
def start(ic):return '.temp 27\n'+ic+'\n.control\nsave all\nset wr_singlescale\nset wr_vecnames\nsetplot const\nlet failures=0\n'
def measure(name,node,time,target):
 return f'meas tran {name} find v({node}) at={time}n\nif abs({name}-({target})) > 0.5\nlet const.failures=const.failures+1\necho FAIL: {name} expected {target} V\nend\n'
def finish(title):return f'if const.failures = 0\necho PASS: {title}\nelse\necho FAIL: {title}\nend\nprint const.failures\n.endc'
def build_core():
 s=Sch('TERNARY STORAGE CORE / two cross-coupled inverters / 4 MOS + 4 R')
 s.text(40,-80,'Q / QB: (-5,+5), (0,0), (+5,-5) V. VDD=+5 V; VSS=-5 V.')
 s.comp(str(ROOT/'inverter.sym'),300,220,'name=x_q');s.comp(str(ROOT/'inverter.sym'),700,220,'name=x_qb',flip=1)
 for x in (300,700):
  s.wire(x,120,x,160,'VDD');s.label(x,120,'VDD')
  s.wire(x,280,x,320,'VSS');s.label(x,320,'VSS')
 for x,y,xx,yy in [(370,220,420,220),(420,220,420,400),(820,220,820,400),(760,220,820,220),(420,400,920,400)]:s.wire(x,y,xx,yy,'Q')
 for x,y,xx,yy in [(580,220,630,220),(580,80,580,220),(180,80,580,80),(180,80,180,220),(180,220,240,220),(580,80,920,80)]:s.wire(x,y,xx,yy,'QB')
 s.label(920,400,'Q','opin');s.label(920,80,'QB','opin')
 s.label(180,520,'VDD','iopin');s.label(460,520,'VSS','iopin')
 s.text(40,610,'INV is the existing inverter.sch; primitive dimensions remain unchanged.')
 s.text(40,650,'No explicit capacitors or initialization sources inside this cell.')
 s.save('ternary_latch');symbol('ternary_latch','3-level latch',LPINS)
def build_sram():
 s=Sch('TERNARY SRAM BITCELL / latch + two NMOS access devices / 6 MOS + 4 R')
 s.text(40,-80,'Data: -5 / 0 / +5 V. WL OFF=-5 V; ON=+5 V. Bodies connect to VSS.')
 s.comp(str(ROOT/'ternary_latch.sym'),500,300,'name=x_store')
 s.label(500,180,'VDD');s.label(500,400,'VSS')
 mos='model=NMOS\nw=3.4u\nl=1u\nm=1\nspiceprefix=X\nas=0\nad=0\nps=0\npd=0\nnrd=0\nnrs=0'
 s.comp('TR-1umLIB/MN.sym',200,260,'name=XM_A\n'+mos,rot=1)
 s.comp('TR-1umLIB/MN.sym',800,260,'name=XM_AB\n'+mos,rot=3,flip=1)
 for x in (200,800):
  s.wire(x,100,x,260,'WL');s.wire(x,300,x,480,'VSS');s.label(x,480,'VSS')
 s.wire(200,100,800,100,'WL');s.label(200,100,'WL','ipin')
 for a,b,net in [(80,170,'BL'),(230,380,'Q'),(620,770,'QB'),(830,920,'BLB')]:s.wire(a,300,b,300,net)
 s.label(80,300,'BL','iopin');s.label(920,300,'BLB','iopin')
 for x,net in [(300,'Q'),(700,'QB')]:s.wire(x,300,x,380,net);s.label(x,380,net,'opin')
 s.label(320,570,'VDD','iopin');s.label(620,570,'VSS','iopin')
 s.text(40,650,'Q/QB are storage-node monitor ports; attach loads only in the TB.')
 s.text(40,690,'Access W/L = 3.4u / 1u. No precharge, sense amplifier, or write driver in the cell.')
 s.save('ternary_sram');symbol('ternary_sram','T-SRAM',SPINS)
def build_hold_tb():
 s=Sch('TERNARY LATCH / 3 STATES + FINITE DISTURBANCE / standalone stability TB')
 s.text(40,-80,'27 C; VDD=+5 V; VSS=-5 V; 10 fF per storage node (TB only).')
 for k,x in enumerate((240,660,1080)):
  q=f'q{k}';qb=f'qb{k}';dut(s,'ternary_latch',f'x{k}',x,140,[q,qb,'VDD','VSS'])
  s.cap(f'CQ{k}',q,'10f',x-100,340);s.cap(f'CQB{k}',qb,'10f',x+100,340)
  # Both polarities of differential current disturbance, 10 ns plateaus.
  pulse='PWL(0 0 200n 0 201n 5u 211n 5u 212n 0 500n 0 501n -5u 511n -5u 512n 0 1u 0)'
  s.source(f'IK{k}',q,pulse,x-100,530,'isource',negative=qb)
  s.text(x-145,600,f'IK{k}: Q -> QB, +/-5 uA')
 supplies(s,770)
 s.text(1510,-80,'SEQUENCE / ns',.3)
 rows=['Initial Q/QB: -4.5/+4.5, +0.5/-0.5, +4.5/-4.5 V',
       '0-199: release perturbed initial state; settle',
       '200-212: +5 uA Q-to-QB disturbance (1 ns edges)',
       '212-499: recover and retain',
       '500-512: -5 uA Q-to-QB disturbance (1 ns edges)',
       '512-1000: recover and retain',
       'Samples: 199 / 499 / 999 ns; tolerance +/-0.5 V',
       'Expect Q/QB = -5/+5, 0/0, +5/-5 V.',
       '.ic sets only startup; no source clamps the stored voltage.',
       'RUN: Netlist -> Simulate. Native ngspice plots.']
 for i,t in enumerate(rows):s.text(1510,-30+i*48,t)
 ctrl=start('.ic v(q0)=-4.5 v(qb0)=4.5 v(q1)=0.5 v(qb1)=-0.5 v(q2)=4.5 v(qb2)=-4.5')+'tran 0.2n 1000n 0 0.5n\n'
 for k,v in enumerate((-5,0,5)):
  for t in (199,499,999):
   ctrl+=measure(f'q{k}_{t}',f'q{k}',t,v)+measure(f'qb{k}_{t}',f'qb{k}',t,-v)
  ctrl+=f"plot v(q{k}) v(qb{k}) ylimit -5.5 5.5 title 'Latch: stored Q={v} V, perturb and recover'\n"
 ctrl+='wrdata ternary_latch_hold.txt v(q0) v(qb0) v(q1) v(qb1) v(q2) v(qb2)\n'+finish('three-state hold and disturbance recovery')
 s.setup(ctrl,1510,590);s.save('ternary_latch_tb')
def pwl(values):return 'PWL('+' '.join(f'{t}n {v}' for t,v in values)+')'
def build_write_tb():
 s=Sch('TERNARY SRAM / IDEAL-DRIVE WRITE + WL-OFF HOLD / all six state transitions')
 s.text(40,-80,'27 C; +/-5 V supply; access NMOS W/L=3.4u/1u; Q/QB load=10 fF each.')
 dut(s,'ternary_sram','xdut',440,180,['BL','BLB','WL','Q','QB','VDD','VSS'])
 s.cap('CQ','Q','10f',800,200);s.cap('CQB','QB','10f',1020,200)
 supplies(s,570)
 bl=[(0,-5)];wl=[(0,-5)]
 for k,v in enumerate(SEQ):
  t=k*400
  if k:bl.extend([(t+20,SEQ[k-1]),(t+21,v)])
  wl.extend([(t+50,-5),(t+51,5),(t+150,5),(t+151,-5)])
 bl.append((2800,SEQ[-1]));wl.append((2800,-5))
 s.source('VBL','BL',pwl(bl),600,570);s.source('VBLB','BLB',pwl([(t,-v) for t,v in bl]),840,570);s.source('VWL','WL',pwl(wl),1080,570)
 s.text(40,690,'Ideal complementary BL/BLB drivers model external write equipment.')
 s.text(40,730,'WL goes LOW before judging rail restoration. Q=0 V is a stored data state.')
 s.text(1260,-80,'SEQUENCE / ns / nominal hold voltages',.3)
 s.text(1260,-30,'Slot             BL / BLB       WL ON             Hold sample')
 for k,v in enumerate(SEQ):s.text(1260,20+44*k,f'{400*k:4}-{400*(k+1):4}        {v:+} / {-v:+} V        {400*k+51:4}-{400*k+150:4}          {400*k+399:4}')
 for i,t in enumerate(['BL changes at slot+20..21 ns; WL edges are 1 ns.',
                       'Measure write @+149 ns, hold @+299 and +399 ns.',
                       'Hold assertions: Q=BL, QB=BLB within +/-0.5 V.',
                       'High level during WL ON can have NMOS pass loss.',
                       'No precharge or sense amplifier. Read TB is separate.',
                       'RUN: Netlist -> Simulate; native voltage plots.']):s.text(1260,360+42*i,t)
 ctrl=start('.ic v(Q)=-5 v(QB)=5')+'tran 0.2n 2800n 0 0.5n\n'
 for k,v in enumerate(SEQ):
  ctrl+=f'meas tran write_q_{k} find v(Q) at={400*k+149}n\nmeas tran write_qb_{k} find v(QB) at={400*k+149}n\n'
  for t in (400*k+299,400*k+399):ctrl+=measure(f'hold_q_{t}','Q',t,v)+measure(f'hold_qb_{t}','QB',t,-v)
 ctrl+="plot v(Q) v(QB) ylimit -5.5 5.5 title 'SRAM storage: write and hold'\nplot v(BL) v(BLB) v(WL) ylimit -5.5 5.5 title 'SRAM ideal bitline drivers and WL'\nwrdata ternary_sram_write.txt v(Q) v(QB) v(BL) v(BLB) v(WL)\n"+finish('all six writes and WL-off hold')
 s.setup(ctrl,1260,680);s.save('ternary_sram_tb')
def build_read_tb():
 s=Sch('TERNARY SRAM / FLOATING BITLINE READ / no precharge or sense amplifier')
 s.text(40,-80,'Three separate runs: QINIT=-5 / 0 / +5 V, QBINIT=-QINIT. Bitlines initially 0 V.')
 dut(s,'ternary_sram','xdut',440,180,['BL','BLB','WL','Q','QB','VDD','VSS'])
 s.cap('CQ','Q','10f',800,200);s.cap('CQB','QB','10f',1020,200)
 s.cap('CBL','BL','10f',180,460);s.cap('CBLB','BLB','10f',440,460)
 supplies(s,660);s.source('VWL','WL','PWL(0 -5 200n -5 201n 5 700n 5 701n -5 1000n -5)',660,660)
 s.text(40,780,'BL/BLB have capacitors only. No voltage source drives them during read.')
 s.text(40,825,'Their starting voltages are explicit TB initial conditions, not a precharge circuit.')
 for i,t in enumerate(['SEQUENCE / ns','0-200: WL OFF, retain state; BL/BLB float','200-201: WL rises to +5 V','201-700: read into capacitive bitlines','699: measure storage nodes and bitline differential','700-701: WL falls to -5 V','999: check retained Q/QB','Storage tolerance +/-0.5 V; nonzero read |BL-BLB| > 1 V.',
                       'Zero read: |BL-BLB| < 0.5 V; also check both near 0 V.',
                       'NMOS read-high is not required to reach +5 V.',
                       'BLINIT / BLBINIT in SIMULATION set bitline initial voltage.',
                       'RUN: Netlist -> Simulate. Three state plots.']):s.text(1260,-80+i*48,t,.3 if i==0 else .24)
 ctrl=start(".param QINIT=-5 BLINIT=0 BLBINIT=0\n.ic v(Q)='QINIT' v(QB)='-QINIT' v(BL)='BLINIT' v(BLB)='BLBINIT'")
 for k,v in enumerate((-5,0,5)):
  if k:ctrl+=f'alterparam QINIT={v}\nreset\nsave all\n'
  ctrl+='tran 0.2n 1000n 0 0.5n\nlet diff=v(BL)-v(BLB)\n'
  for t in (199,699,999):ctrl+=measure(f'q{k}_{t}','Q',t,v)+measure(f'qb{k}_{t}','QB',t,-v)
  ctrl+=f'meas tran read_diff_{k} find diff at=699n\nmeas tran read_bl_{k} find v(BL) at=699n\nmeas tran read_blb_{k} find v(BLB) at=699n\n'
  cond=f'read_diff_{k} > -1' if v<0 else f'read_diff_{k} < 1' if v>0 else f'abs(read_diff_{k}) > 0.5'
  ctrl+=f'if {cond}\nlet const.failures=const.failures+1\necho FAIL: read differential state {v}\nend\n'
  if v==0:ctrl+=measure('zero_bl','BL',699,0)+measure('zero_blb','BLB',699,0)
  ctrl+=f"plot v(Q) v(QB) v(BL) v(BLB) ylimit -5.5 5.5 title 'SRAM floating read: initial Q={v} V'\nwrdata ternary_sram_read_{k}.txt v(Q) v(QB) v(BL) v(BLB) v(WL)\n"
 ctrl+=finish('three-state floating-bitline read and retention')
 s.setup(ctrl,1260,660);s.save('ternary_sram_read_tb')
if __name__=='__main__':
 build_core();build_sram();build_hold_tb();build_write_tb();build_read_tb()
