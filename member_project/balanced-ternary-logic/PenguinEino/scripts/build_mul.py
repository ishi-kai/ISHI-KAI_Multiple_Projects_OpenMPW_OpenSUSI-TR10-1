"""Generate the four-gate balanced-ternary multiplier and native SPICE testbench.
Private MUL gate variants keep unrelated primitive/FA/SRAM sizing unchanged.
"""
from pathlib import Path
import itertools,json,re
from build_ternary_sram import Sch,start,measure,finish
ROOT=Path(__file__).resolve().parents[1]
BASELINE=[24,16,15,46,6.5,17,13.5,5,20]
STATES=list(itertools.product([-5,0,5],repeat=2))
def gate(kind,values):
 src='inverter' if kind=='inv' else kind
 name=f'mul_{kind}';p,n,r=values
 text=(ROOT/f'{src}.sch').read_text()
 def edit(m):
  v=m[0]
  if 'model=PMOS' in v:v=re.sub(r'(?m)^w=\S+',f'w={p:g}u',v)
  elif 'model=NMOS' in v:v=re.sub(r'(?m)^w=\S+',f'w={n:g}u',v)
  elif 'model=F_RR' in v:v=re.sub(r'(?m)^l=\S+',f'l={r:g}e-06',v)
  return v
 text=re.sub(r'C \{TR-1umLIB/.*?\n[^}]*\}',edit,text,flags=re.S)
 text=re.sub(r'PMOS: W = [\d.]+ um',f'PMOS: W = {p:g} um',text)
 text=re.sub(r'NMOS: W = [\d.]+ um',f'NMOS: W = {n:g} um',text)
 text=re.sub(r'RR1 / RR2: W = 2.8 um / L = [\d.]+ um',f'RR1 / RR2: W = 2.8 um / L = {r:g} um',text)
 text=text.replace('BALANCED TERNARY','MUL VARIANT / BALANCED TERNARY',1)
 (ROOT/f'{name}.sch').write_text(text.rstrip()+'\n')
 sym=(ROOT/f'{src}.sym').read_text()
 if kind=='inv':sym=sym.replace('T {inverter}','T {mul_inv}')
 (ROOT/f'{name}.sym').write_text(sym)
def create(cfg):
 for k,kind in enumerate(('nand','nor','inv')):gate(kind,cfg[k*3:k*3+3])
 s=Sch('BALANCED TERNARY MULTIPLIER / P = A x B / NAND x2 + NOR + INV')
 s.text(40,-80,'Logic -1 / 0 / +1 corresponds to -5 / 0 / +5 V. VDD=+5 V, VSS=-5 V.')
 for nm,kind,x,y in [('x_t1','nand',320,160),('x_t2','nor',320,480),('x_t3','inv',670,480),('x_p','nand',1060,300)]:
  s.comp(str(ROOT/f'mul_{kind}.sym'),x,y,f'name={nm}')
  s.label(x,y-60,'VDD');s.label(x,y+60,'VSS')
 for y,net in [(140,'a'),(180,'b')]:s.wire(120,y,260,y,net);s.label(120,y,net,'ipin')
 for y,net in [(460,'a'),(500,'b')]:s.wire(120,y,260,y,net);s.label(120,y,net)
 for x,y,xx,yy,net in [(390,160,860,160,'t1'),(860,160,860,280,'t1'),(860,280,1000,280,'t1'),(390,480,610,480,'t2'),(740,480,900,480,'t3'),(900,320,900,480,'t3'),(900,320,1000,320,'t3'),(1130,300,1270,300,'p')]:s.wire(x,y,xx,yy,net)
 s.label(500,160,'t1');s.label(500,480,'t2');s.label(840,480,'t3');s.label(1270,300,'p','opin')
 # Expose the existing nodes; MAC adds one INV to t1 to obtain MIN.
 s.wire(500,160,500,60,'t1');s.wire(500,60,1270,60,'t1');s.label(1270,60,'t1','opin')
 s.wire(840,480,840,600,'t3');s.wire(840,600,1270,600,'t3');s.label(1270,600,'t3','opin')
 s.label(160,680,'VDD','iopin');s.label(400,680,'VSS','iopin')
 for i,t in enumerate(['t1 = -min(a,b)', 't2 = -max(a,b); t3 = -t2 = max(a,b)', 'p = -min(t1,t3) = a*b / 5 (voltages)', '14 MOS + 8 RR. No internal load capacitor.', 'MUL variants are sized separately; existing NAND/NOR/INV remain unchanged.']):s.text(40,770+i*45,t)
 s.save('mul')
 sym=(ROOT/'nand.sym').read_text().replace('name=vout dir=out','name=p dir=out').replace('name=V+','name=VDD').replace('name=V-','name=VSS').replace('T {NAND}','T {MUL}')
 # Remove the output inversion bubble; this is an arithmetic block.
 sym=sym.replace('A 4 45 0 5 0 360 {}\n','').replace('L 4 50 0 70 0','L 4 40 0 70 0')
 sym+='L 4 40 -20 70 -20 {}\nB 5 67.5 -22.5 72.5 -17.5 {name=t1 dir=out}\nL 4 40 20 70 20 {}\nB 5 67.5 17.5 72.5 22.5 {name=t3 dir=out}\nT {NMN} 5 -34 0 0 0.12 0.12 {}\nT {MAX} 5 22 0 0 0.12 0.12 {}\n'
 (ROOT/'mul.sym').write_text(sym)
 s=Sch('TERNARY MUL / 9 INPUT STATES + DC TRANSFER / native ngspice plots')
 s.text(40,-80,'27 C; +/-5 V supply; output Cload=10 fF. Expected p=a*b/5 in volts.')
 s.comp(str(ROOT/'mul.sym'),420,180,'name=xdut')
 for x,y,net in [(360,160,'a'),(360,200,'b'),(420,120,'VDD'),(420,240,'VSS'),(490,180,'p'),(490,160,'t1'),(490,200,'t3')]:s.label(x,y,net)
 s.wire(490,180,720,180,'p');s.wire(720,180,720,250,'p');s.comp('devices/capa.sym',720,280,'name=Cload value=10f m=1');s.label(720,310,'GND','gnd')
 for k,(name,net,val) in enumerate([('VDD','VDD','5'),('VSS','VSS','-5')]):s.source(name,net,val,120+k*220,520)
 seq=STATES+[STATES[0]]
 for col,net in enumerate(('a','b')):
  pts=[f'0 {seq[0][col]}']
  for k in range(1,len(seq)):pts += [f'{200*k}n {seq[k-1][col]}',f'{200*k+1}n {seq[k][col]}']
  pts.append(f'{200*len(seq)}n {seq[-1][col]}')
  s.source('V'+net.upper(),net,'PWL('+' '.join(pts)+')',560+220*col,520)
 s.text(40,640,'Edit VA / VB for stimuli; Cload for output load; SIMULATION for analyses.')
 s.text(40,690,'RUN: disable LVS -> Netlist -> Simulate. All devices are in child cells.')
 s.text(1110,-100,'SEQUENCE / ns / expected settled voltage',.3)
 s.text(1110,-50,'Interval           A        B        P       Sample')
 for k,(a,b) in enumerate(seq):s.text(1110,k*40,f'{200*k:4}-{200*(k+1):4}        {a:+}       {b:+}       {a*b/5:+g}        {200*k+199}')
 s.text(1110,450,'1 ns edges. Samples must be within +/-0.5 V of expected.')
 s.text(1110,490,'DC: sweep A -5..+5 V for B=-5, 0, +5 V.')
 s.text(1110,530,'72 directed transitions, load, skew and margins: scripts/check_mul.py')
 ctrl=start('.options rshunt=1e12\n.nodeset v(p)=5 v(t1)=5 v(xdut.t2)=5 v(t3)=-5')
 for k,b in enumerate((-5,0,5)):
  ctrl+=f'alter VB dc={b}\ndc VA -5 5 0.03125\n'
  for j,a in enumerate((-5,0,5)):
   name=f'dc_{k}_{j}';target=a*b/5
   ctrl+=f'meas dc {name} find v(p) at={a}\nif abs({name}-({target})) > 0.5\nlet const.failures=const.failures+1\necho FAIL: {name} expected {target} V\nend\n'
  ctrl+=f"plot v(a) v(p) ylimit -5.5 5.5 title 'MUL DC: B={b} V'\nwrdata mul_dc_{k}.txt v(a) v(p) v(t1) v(xdut.t2) v(t3)\n"
 ctrl+='reset\nsave all\ntran 0.2n 2000n 0 0.5n\n'
 for k,(a,b) in enumerate(seq):ctrl+=measure(f'p_{k}','p',200*k+199,a*b/5)
 ctrl+="plot v(a) v(b) v(p) ylimit -5.5 5.5 title 'MUL: all nine input states'\nplot v(t1) v(xdut.t2) v(t3) title 'MUL internal nodes'\nwrdata mul_tran.txt v(a) v(b) v(p) v(t1) v(xdut.t2) v(t3)\n"+finish('MUL truth table and transient sequence')
 s.setup(ctrl,1110,650);s.save('mul_tb')
if __name__=='__main__':
 p=ROOT/'design/mul_sizes.json';cfg=json.loads(p.read_text())['selected'] if p.exists() else BASELINE
 create(cfg)
