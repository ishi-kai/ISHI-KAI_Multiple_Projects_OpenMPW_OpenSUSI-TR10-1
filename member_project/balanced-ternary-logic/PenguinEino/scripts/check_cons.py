"""Netlist cons_tb.sch and verify 2-D DC margin plus all 72 directed transitions.
No schematic edits. Results: simulation/cons_checks/. Native plot file: each case/view.spice.
"""
from pathlib import Path
import re,subprocess,itertools,json
from concurrent.futures import ThreadPoolExecutor
import numpy as np
ROOT=Path(__file__).resolve().parents[1];WORK=ROOT/'simulation/cons_checks'
STATES=list(itertools.product([-5,0,5],repeat=2))
def values(a,b):
 f=lambda x,y:-5*np.sign(x+y)
 t=f(a,b);u=f(b,t);na=-a;return np.array([t,u,na,a if a==b else 0])
def route():
 adj={i:[j for j in range(9) if j!=i] for i in range(9)};stack=[0];out=[]
 while stack:
  if adj[stack[-1]]:stack.append(adj[stack[-1]].pop())
  else:out.append(stack.pop())
 return out[::-1]
def prepare():
 WORK.mkdir(exist_ok=True)
 p=subprocess.run(['xschem','-r','-x','--rcfile',str(ROOT/'simulation/verify.xschemrc'),'-s','--command','xschem netlist; puts [xschem get infowindow_text]; exit','-o',str(WORK),str(ROOT/'cons_tb.sch')],capture_output=True,text=True)
 (WORK/'netlist.log').write_text(p.stdout+p.stderr)
 if p.returncode or 'Error:' in p.stdout+p.stderr:raise RuntimeError('Netlist failed')
 return re.sub(r'\n\+\s*',' ',(WORK/'cons_tb.spice').read_text())
def run(job,base):
 mode,cap,skew=job;d=WORK/mode;d.mkdir(exist_ok=True);rr=route();hold=100
 s=base.replace('v(vout)=-5','v(vout)=0') if mode=='dc' else base
 for col,net in enumerate(['a','b']):
  val='0'
  if mode!='dc':
   pts=[f'0 {STATES[rr[0]][col]}']
   for k in range(1,len(rr)):
    edge=k*hold+(abs(skew) if (skew>0 and col==1) or (skew<0 and col==0) else 0)
    pts.extend([f'{edge}n {STATES[rr[k-1]][col]}',f'{edge+1}n {STATES[rr[k]][col]}'])
   val='PWL('+' '.join(pts)+')'
  s=re.sub(r'^V'+net.upper()+r' .*$',f'V{net.upper()} {net} 0 {val}',s,flags=re.M)
 s=re.sub(r'^Cload .*$',f'Cload vout 0 {cap}f',s,flags=re.M)
 cmd='dc VA -5 5 0.25 VB -5 5 0.25' if mode=='dc' else f'tran 0.2n {len(rr)*hold}n'
 vectors='v(a) v(b) v(xdut.t) v(xdut.u) v(xdut.na) v(vout)'
 control='.control\nsave all\nset wr_singlescale\nset wr_vecnames\n'+cmd+'\nwrdata data.txt '+vectors+'\nquit\n.endc'
 if mode=='dc':
  # Reset between logic neighborhoods: avoid remote RR-model roots in unused transition regions.
  commands=[]
  for k,(aa,bb) in enumerate(STATES):
   commands.extend(['reset',f'dc VA {max(-5,aa-.5)} {min(5,aa+.5)} 0.25 VB {max(-5,bb-.5)} {min(5,bb+.5)} 0.25',f'wrdata data{k}.txt '+vectors])
  control='.control\nsave all\nset wr_singlescale\nset wr_vecnames\n'+'\n'.join(commands)+'\nquit\n.endc'
 s=re.sub(r'\.control.*?\.endc',control,s,flags=re.S);(d/'tb.spice').write_text(s);(d/'view.spice').write_text(s.replace('\nquit\n',f'\nplot {vectors}\n'))
 if mode=='dc':
  outputs=[]
  for k,(aa,bb) in enumerate(STATES):
   case=re.sub(r'\.control.*?\.endc','.control\nsave all\nset wr_singlescale\nset wr_vecnames\n'+f'dc VA {max(-5,aa-.5)} {min(5,aa+.5)} 0.25 VB {max(-5,bb-.5)} {min(5,bb+.5)} 0.25\nwrdata data{k}.txt '+vectors+'\nquit\n.endc',s,flags=re.S)
   for node,val in zip(['xdut.t','xdut.u','xdut.na','vout'],values(aa,bb)):
    case=re.sub(r'v\('+re.escape(node)+r'\)=[^\s]+',f'v({node})={val}',case)
   (d/f'case{k}.spice').write_text(case)
   (d/f'case{k}_view.spice').write_text(case.replace('\nquit\n',f'\nplot {vectors}\n'))
   if k==4:
    (d/'tb.spice').write_text(case)
    (d/'view.spice').write_text(case.replace('\nquit\n',f'\nplot {vectors}\n'))
   q=subprocess.run(['ngspice','-b',f'case{k}.spice'],cwd=d,capture_output=True,text=True,timeout=240);outputs.append(q.stdout+q.stderr)
   if q.returncode:raise RuntimeError('DC case '+str(k)+' failed')
  p=subprocess.CompletedProcess([],0,stdout='\n'.join(outputs),stderr='')
 else:p=subprocess.run(['ngspice','-b','tb.spice'],cwd=d,capture_output=True,text=True,timeout=240)
 (d/'run.log').write_text(p.stdout+p.stderr)
 if p.returncode or re.search(r'Error:|failed|Timestep too small',p.stdout+p.stderr,re.I):raise RuntimeError(mode+' simulation error')
 a=np.vstack([np.loadtxt(d/f'data{k}.txt',skiprows=1) for k in range(9)]) if mode=='dc' else np.loadtxt(d/'data.txt',skiprows=1)
 if not np.isfinite(a).all() or np.max(abs(a[:,1:]))>7:raise RuntimeError(mode+' nonphysical output')
 if mode=='dc':
  result=[]
  for aa,bb in STATES:
   dist=np.maximum(abs(a[:,1]-aa),abs(a[:,2]-bb));idx=np.argmin(dist);target=values(aa,bb);nominal=a[idx,3:7]
   result.append(dict(inputs=[aa,bb],outputs=nominal.tolist(),max_internal_error=float(max(abs(nominal-target))),output_error=float(abs(nominal[-1]-target[-1])),half_volt_band=float(max(abs(a[dist<=.50001,-1]-target[-1])))))
  return dict(mode=mode,nominal_max_error=max(x['output_error'] for x in result),half_volt_band=max(x['half_volt_band'] for x in result),points=result)
 t=a[:,0]*1e9;rows=[]
 for k in range(1,len(rr)):
  start=k*hold;end=(k+1)*hold-1;target=values(*STATES[rr[k]]);out=np.array([np.interp(end,t,a[:,j]) for j in range(3,7)])
  m=(t>=start+1+abs(skew))&(t<=end);tt=t[m];bad=np.flatnonzero(abs(a[m,-1]-target[-1])>.5)
  settle=0 if not len(bad) else float(tt[bad[-1]+1]-start-1-abs(skew)) if bad[-1]<len(tt)-1 else None
  rows.append(dict(old=STATES[rr[k-1]],new=STATES[rr[k]],max_internal_error=float(max(abs(out-target))),output_error=float(abs(out[-1]-target[-1])),settle_ns=settle))
 return dict(mode=mode,count=len(rows),max_internal_error=max(x['max_internal_error'] for x in rows),output_error=max(x['output_error'] for x in rows),max_settle_ns=max((x['settle_ns'] for x in rows if x['settle_ns'] is not None),default=0),unsettled=sum(x['settle_ns'] is None for x in rows),transitions=rows)
def main():
 base=prepare();jobs=[('dc',10,0),('tran_10f',10,0),('tran_100f',100,0),('skew_a',10,-2),('skew_b',10,2)]
 with ThreadPoolExecutor(max_workers=3) as pool:
  rows=[]
  for r in pool.map(lambda j:run(j,base),jobs):rows.append(r);print({k:v for k,v in r.items() if k not in ['points','transitions']},flush=True);(WORK/'results.json').write_text(json.dumps(rows,indent=2))
if __name__=='__main__':main()
