"""Bounded nominal NAND sizing exploration. Outputs: simulation/nand_tuning/."""
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor
import itertools,json,re,subprocess,tempfile
import numpy as np
ROOT=Path(__file__).resolve().parents[1];WORK=ROOT/'simulation/nand_tuning'
BASE=(WORK/'nand_tb.spice').read_text().split('**** begin user architecture code')[0]
BASE=re.sub(r'\n\+\s*',' ',BASE)
MODEL='/home/ishi-kai/pdk/TR-1um/libs.tech/spice/models/ip62_models'
STATES=list(itertools.product([-5,0,5],repeat=2))
# Euler circuit of the complete directed graph: every ordered pair once.
def route():
 adj={i:[j for j in range(9) if j!=i] for i in range(9)};stack=[0];out=[]
 while stack:
  if adj[stack[-1]]:stack.append(adj[stack[-1]].pop())
  else:out.append(stack.pop())
 return list(reversed(out))
ROUTE=route()

def run(cfg,tran=False,cap=10,temp=27,step=1):
 p,n,rw,rl=cfg;s=BASE
 for name,w in [('XXM1',p),('XXM3',p),('XXM2',n),('XXM4',n)]:
  s=re.sub(r'(^'+name+r'.*? w=)\S+',lambda m:m[1]+f'{w}u',s,flags=re.M)
 for name in ['XR1','XR2']:
  s=re.sub(r'(^'+name+r'.*? w=)\S+ l=\S+',lambda m:m[1]+f'{rw}u l={rl}u',s,flags=re.M)
 s=re.sub(r'^Cload .*$',f'Cload vout 0 {cap}f',s,flags=re.M)
 for col,name in enumerate(['VA','VB']):
  val='0'
  if tran:
   points=[f'0 {STATES[ROUTE[0]][col]}']
   for i,k in enumerate(ROUTE):
    points.append(f'{(i+1)*40}n {STATES[k][col]}')
    if i<len(ROUTE)-1:points.append(f'{(i+1)*40+1}n {STATES[ROUTE[i+1]][col]}')
   val='PWL('+' '.join(points)+')'
  s=re.sub(r'^'+name+r' .*$',f'{name} {"a" if col==0 else "b"} 0 {val}',s,flags=re.M)
 cmd=f'tran 0.1n {len(ROUTE)*40}n' if tran else f'dc VA -5 5 {step} VB -5 5 {step}'
 s+=f'\n.include {MODEL}\n.temp {temp}\n.nodeset v(vout)=5\n.control\n{cmd}\nwrdata data.txt v(a) v(b) v(vout)\nquit\n.endc\n.GLOBAL GND\n.end\n'
 with tempfile.TemporaryDirectory(dir=WORK) as folder:
  d=Path(folder);(d/'run.spice').write_text(s)
  r=subprocess.run(['ngspice','-b','run.spice'],cwd=d,capture_output=True,text=True)
  if r.returncode or re.search('Error:|failed',r.stdout+r.stderr,re.I):raise RuntimeError(r.stdout+r.stderr)
  data=np.loadtxt(d/'data.txt')
 if not tran:
  a,b,y=data[:,1],data[:,3],data[:,5];errs=[];band=[];nom=[]
  for aa,bb in STATES:
   expected=-min(aa,bb)
   m=(abs(a-aa)<1e-8)&(abs(b-bb)<1e-8);nom.append(float(y[m][0]));errs.append(abs(nom[-1]-expected))
   m=(abs(a-aa)<=1+1e-8)&(abs(b-bb)<=1+1e-8);band.append(float(max(abs(y[m]-expected))))
  return dict(cfg=list(cfg),area=2*p+2*n+2*rw*rl,error=max(errs),band=max(band),outputs=nom),data
 t,y=data[:,0]*1e9,data[:,5];settle=[];rise=[];fall=[]
 for i in range(1,len(ROUTE)):
  old=-min(STATES[ROUTE[i-1]]);new=-min(STATES[ROUTE[i]])
  mask=(t>=i*40+1)&(t<(i+1)*40-.01);tt,yy=t[mask],y[mask]
  bad=np.flatnonzero(abs(yy-new)>.5)
  delay=0 if not len(bad) else (float(tt[bad[-1]+1]-i*40-1) if bad[-1]+1<len(tt) else 40.)
  settle.append(delay)
  # 10-90% crossings relative to measured settled levels, for output-changing transitions.
  if new!=old:
   y0=float(np.interp(i*40-.1,t,y));y1=float(np.interp((i+1)*40-.1,t,y))
   m=(t>=i*40)&(t<(i+1)*40-.01);tseg=t[m];progress=(y[m]-y0)/(y1-y0)
   def crossing(q):
    k=np.flatnonzero(progress>=q)
    if not len(k):return float('nan')
    k=k[0]
    return float(tseg[k] if k==0 else np.interp(q,progress[k-1:k+1],tseg[k-1:k+1]))
   (rise if new>old else fall).append(crossing(.9)-crossing(.1))
 return dict(settle=max(settle),rise=max(rise),fall=max(fall)),data

def dc(cfg):return run(cfg)[0]
if __name__=='__main__':
 cfgs=list(itertools.product([6.8,10,13.5,18,24,32],[5,8,12,18,26,40],[2.8,4],[13,18,24,30,40]))
 with ThreadPoolExecutor(max_workers=4) as pool:rows=list(pool.map(dc,cfgs))
 (WORK/'dc.json').write_text(json.dumps(rows,indent=2))
 good=[r for r in rows if r['error']<=.25 and r['band']<=.5]
 shortlist=sorted(good,key=lambda r:r['area'])[:10]
 # Add best flatness in a compact area envelope.
 for r in sorted([r for r in good if r['area']<300],key=lambda r:r['band'])[:3]:
  if r not in shortlist:shortlist.append(r)
 print('DC candidates',len(rows),'pass',len(good),'shortlist',len(shortlist),flush=True)
 def timing(r):
  r['timing10']=run(r['cfg'],True)[0]
  return r
 with ThreadPoolExecutor(max_workers=4) as pool:shortlist=list(pool.map(timing,shortlist))
 (WORK/'shortlist.json').write_text(json.dumps(shortlist,indent=2))
 print(json.dumps(shortlist,indent=2),flush=True)
