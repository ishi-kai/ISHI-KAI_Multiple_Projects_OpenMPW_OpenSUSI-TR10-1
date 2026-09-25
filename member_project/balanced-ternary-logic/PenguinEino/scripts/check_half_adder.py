"""Netlist half_adder_tb.sch and verify all 72 directed transitions of SUM/CARRY.
Test 10/100 fF loads and +/-2 ns input skew at 27 C, +/-5 V.
No schematic edits. Results: simulation/half_adder_checks/. Native plot file: each case/view.spice.
"""
from pathlib import Path
import re,subprocess,itertools,json
from concurrent.futures import ThreadPoolExecutor
import numpy as np
ROOT=Path(__file__).resolve().parents[1];WORK=ROOT/'simulation/half_adder_checks'
STATES=list(itertools.product([-5,0,5],repeat=2))
def values(a,b):
 f=lambda x,y:-5*np.sign(x+y)
 t=f(a,b);u=f(b,t);na=-a;c=f(na,u);d=f(t,c);nd=-d;s=f(nd,c)
 assert c==(a if a==b else 0) and a+b==s+3*c
 return np.array([t,u,na,c,d,nd,s])
def route():
 adj={i:[j for j in range(9) if j!=i] for i in range(9)};stack=[0];out=[]
 while stack:
  if adj[stack[-1]]:stack.append(adj[stack[-1]].pop())
  else:out.append(stack.pop())
 return out[::-1]
def prepare():
 WORK.mkdir(exist_ok=True)
 p=subprocess.run(['xschem','-r','-x','--rcfile',str(ROOT/'simulation/verify.xschemrc'),'-s','--command','xschem netlist; puts [xschem get infowindow_text]; exit','-o',str(WORK),str(ROOT/'half_adder_tb.sch')],capture_output=True,text=True)
 (WORK/'netlist.log').write_text(p.stdout+p.stderr)
 if p.returncode or 'Error:' in p.stdout+p.stderr:raise RuntimeError('Netlist failed')
 return re.sub(r'\n\+\s*',' ',(WORK/'half_adder_tb.spice').read_text())
def run(job,base):
 mode,cap,skew=job;d=WORK/mode;d.mkdir(exist_ok=True);rr=route();hold=100
 assert len(rr)==73 and len(set(zip(rr,rr[1:])))==72
 s=base
 for col,net in enumerate(['a','b']):
  pts=[f'0 {STATES[rr[0]][col]}']
  for k in range(1,len(rr)):
   edge=k*hold+(abs(skew) if (skew>0 and col==1) or (skew<0 and col==0) else 0)
   pts.extend([f'{edge}n {STATES[rr[k-1]][col]}',f'{edge+1}n {STATES[rr[k]][col]}'])
  s=re.sub(r'^V'+net.upper()+r' .*$',f'V{net.upper()} {net} 0 PWL('+ ' '.join(pts)+')',s,flags=re.M)
 for net in ['sum','carry']:s=re.sub(r'^C'+net+r' .*$',f'C{net} {net} 0 {cap}f',s,flags=re.M)
 vectors='v(a) v(b) v(xdut.t) v(xdut.u) v(xdut.na) v(carry) v(xdut.d) v(xdut.nd) v(sum)'
 control=f'.control\nsave all\nset wr_singlescale\nset wr_vecnames\ntran 0.2n {len(rr)*hold}n\nwrdata data.txt '+vectors+'\nquit\n.endc'
 s=re.sub(r'\.control.*?\.endc',control,s,flags=re.S)
 (d/'tb.spice').write_text(s)
 (d/'view.spice').write_text(s.replace('\nquit\n',"\nplot v(a) v(b) v(sum) title 'Half Adder SUM'\nplot v(a) v(b) v(carry) title 'Half Adder CARRY'\n"))
 p=subprocess.run(['ngspice','-b','tb.spice'],cwd=d,capture_output=True,text=True,timeout=240)
 (d/'run.log').write_text(p.stdout+p.stderr)
 if p.returncode or re.search(r'Error:|failed|Timestep too small',p.stdout+p.stderr,re.I):raise RuntimeError(mode+' simulation error')
 a=np.loadtxt(d/'data.txt',skiprows=1)
 if not np.isfinite(a).all() or np.max(abs(a[:,1:]))>7:raise RuntimeError(mode+' nonphysical output')
 t=a[:,0]*1e9;rows=[]
 for k in range(1,len(rr)):
  start=k*hold;end=(k+1)*hold-1;target=values(*STATES[rr[k]]);out=np.array([np.interp(end,t,a[:,j]) for j in range(3,10)])
  m=(t>=start+1+abs(skew))&(t<=end);tt=t[m];bad=np.flatnonzero(np.any(abs(a[m][:,[6,9]]-target[[3,6]])>.5,axis=1))
  settle=0 if not len(bad) else float(tt[bad[-1]+1]-start-1-abs(skew)) if bad[-1]<len(tt)-1 else None
  rows.append(dict(old=STATES[rr[k-1]],new=STATES[rr[k]],max_internal_error=float(max(abs(out-target))),output_error=float(max(abs(out[[3,6]]-target[[3,6]]))),sum_error=float(abs(out[6]-target[6])),carry_error=float(abs(out[3]-target[3])),settle_ns=settle))
 return dict(mode=mode,count=len(rows),max_internal_error=max(x['max_internal_error'] for x in rows),output_error=max(x['output_error'] for x in rows),max_settle_ns=max((x['settle_ns'] for x in rows if x['settle_ns'] is not None),default=0),unsettled=sum(x['settle_ns'] is None for x in rows),transitions=rows)
def main():
 base=prepare();jobs=[('tran_10f',10,0),('tran_100f',100,0),('skew_a',10,-2),('skew_b',10,2)]
 with ThreadPoolExecutor(max_workers=3) as pool:
  rows=[]
  for r in pool.map(lambda j:run(j,base),jobs):rows.append(r);print({k:v for k,v in r.items() if k not in ['points','transitions']},flush=True);(WORK/'results.json').write_text(json.dumps(rows,indent=2))
 if any(r.get('unsettled',0) or r['output_error']>.5 or r.get('max_internal_error',0)>.5 for r in rows):raise RuntimeError('Half Adder verification failed')
if __name__=='__main__':main()
