"""Bounded NSIGN sizing; no schematic edits. Run after netlisting nsign_tb into simulation/nsign_tuning.
Config: main P width, main N width, clamp P width, clamp N width, upper RR L, lower RR L (um).
All MOS L=1um, RR W=2.8um. Outputs under simulation/nsign_tuning/.
"""
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor
import re,itertools,json,subprocess,tempfile
import numpy as np
ROOT=Path(__file__).resolve().parents[1];WORK=ROOT/'simulation/nsign_tuning'
BASE=re.search(r'^\.subckt nsign .*?^\.ends', (WORK/'nsign_tb.spice').read_text(),re.M|re.S)[0]
MODEL='/home/ishi-kai/pdk/TR-1um/libs.tech/spice/models/ip62_models'
STATES=list(itertools.product([-1,0,1],repeat=2));BASELINE=(46,16,46,16,17,17);SELECTED=(34,11,14,8,16,16)
def route():
 adj={i:[j for j in range(9) if j!=i] for i in range(9)};st=[0];out=[]
 while st:
  if adj[st[-1]]:st.append(adj[st[-1]].pop())
  else:out.append(st.pop())
 return out[::-1]
ROUTE=route()
def cell(cfg):
 p,n,cp,cn,rt,rb=cfg;s=BASE
 for nm,w in [('XXM3',p),('XXM5',p),('XXM1',n),('XXM2',n),('XXM6',cp),('XXM8',cp),('XXM7',cn),('XXM9',cn)]:
  s=re.sub(r'(^'+nm+r'.*? w=)\S+',lambda m:m[1]+f'{w}u',s,flags=re.M)
 for nm,ll in [('XR2',rt),('XR1',rb)]:s=re.sub(r'(^'+nm+r'.*? l=)\S+',lambda m:m[1]+f'{ll}u',s,flags=re.M)
 return s
def area(cfg):return 2*sum(cfg[:4])+2.8*sum(cfg[4:])
def run(cfg,temp=27,v=5,step=.5,tran=False,cap=10,keep=None,skew=0):
 sources=[];hold=80
 for col,net in enumerate(['a','b']):
  val='0'
  if tran:
   pts=[f'0 {STATES[ROUTE[0]][col]*v}']
   for k in range(1,len(ROUTE)):
    edge=k*hold+(abs(skew) if (skew>0 and col==1) or (skew<0 and col==0) else 0)
    pts.extend([f'{edge}n {STATES[ROUTE[k-1]][col]*v}',f'{edge+1}n {STATES[ROUTE[k]][col]*v}'])
   val='PWL('+' '.join(pts)+')'
  sources.append(f'V{net} {net} 0 {val}')
 cmd=f'tran 0.1n {hold*len(ROUTE)}n' if tran else f'dc Va {-v} {v} {step} Vb {-v} {v} {step}'
 s=f'NSIGN sizing {cfg}\n.include {MODEL}\n'+cell(cfg)+f'\nXdut a b y vp vn 0 nsign\nVDD vp 0 {v}\nVSS vn 0 {-v}\nCload y 0 {cap}f\n'+'\n'.join(sources)+f'\n.temp {temp}\n.options rshunt=1e12\n.nodeset v(y)=0 v(xdut.net1)={v} v(xdut.net2)={v} v(xdut.net3)={-v} v(xdut.net4)={-v} v(xdut.net5)=0 v(xdut.net6)=0\n.control\nset wr_singlescale\nset wr_vecnames\n{cmd}\nwrdata data.txt v(a) v(b) v(y)\nquit\n.endc\n.end\n'
 def execute(d):
  (d/'tb.spice').write_text(s);p=subprocess.run(['ngspice','-b','tb.spice'],cwd=d,capture_output=True,text=True,timeout=150)
  if keep:(d/'run.log').write_text(p.stdout+p.stderr);(d/'view.spice').write_text(s.replace('\nquit\n','\nplot v(a) v(b) v(y)\n'))
  if p.returncode or re.search(r'Error:|failed|Timestep too small',p.stdout+p.stderr,re.I):raise RuntimeError('ngspice failed')
  data=np.loadtxt(d/'data.txt',skiprows=1)
  if not np.isfinite(data).all() or np.max(abs(data[:,1:]))>v+2:raise RuntimeError('nonphysical root')
  return data
 if keep:d=WORK/keep;d.mkdir(exist_ok=True);data=execute(d)
 else:
  with tempfile.TemporaryDirectory(dir=WORK) as dd:data=execute(Path(dd))
 a,b,y=data[:,1:].T
 if not tran:
  nom=[];bands={str(r):0. for r in [.25,.5,.75,1,1.25]};detail=[]
  for aa,bb in STATES:
   dist=np.maximum(abs(a-aa*v),abs(b-bb*v));exp=-np.sign(aa+bb)*v;k=np.argmin(dist);nom.append(float(y[k]));rec={'state':[aa,bb],'nominal':float(y[k])}
   for rad in bands:
    err=float(max(abs(y[dist<=float(rad)+1e-8]-exp)));bands[rad]=max(bands[rad],err);rec[rad]=err
   detail.append(rec)
  return dict(cfg=list(cfg),area=area(cfg),error=max(abs(q['nominal']+np.sign(sum(q['state']))*v) for q in detail),bands=bands,outputs=nom,details=detail)
 t=data[:,0]*1e9;rows=[]
 for k in range(1,len(ROUTE)):
  old=-np.sign(sum(STATES[ROUTE[k-1]]))*v;new=-np.sign(sum(STATES[ROUTE[k]]))*v;start=k*hold;edge_end=start+abs(skew)+1;end=(k+1)*hold-1
  sel=(t>=edge_end)&(t<end);tt=t[sel];yy=y[sel];bad=np.flatnonzero(abs(yy-new)>.5)
  settle=0 if not len(bad) else float(tt[bad[-1]+1]-edge_end) if bad[-1]<len(tt)-1 else 999.
  rec={'from':STATES[ROUTE[k-1]],'to':STATES[ROUTE[k]],'settle':settle,'error':abs(float(np.interp(end,t,y))-new)}
  if old!=new:
   y0=np.interp(start-.1,t,y);y1=np.interp(end,t,y);m=(t>=start)&(t<=end);ts=t[m];progress=(y[m]-y0)/(y1-y0)
   def cross(q):
    ids=np.flatnonzero(progress>=q)
    if not len(ids):return float('nan')
    j=ids[0];return float(ts[j] if j==0 else np.interp(q,progress[j-1:j+1],ts[j-1:j+1]))
   rec['rise' if new>old else 'fall']=cross(.9)-cross(.1)
  rows.append(rec)
 return dict(cfg=list(cfg),area=area(cfg),cap=cap,temp=temp,settle=max(q['settle'] for q in rows),rise=max(q.get('rise',0) for q in rows),fall=max(q.get('fall',0) for q in rows),error=max(q['error'] for q in rows),transitions=rows)
def screen(cfg):
 try:return run(cfg)
 except RuntimeError as e:return dict(cfg=list(cfg),area=area(cfg),error=999,bands={'0.5':999,'1':999},rejected=str(e))
def main():
 cfgs=[(p,n,cp,cn,rl,rl) for p,n,cp,cn,rl in itertools.product([10,14,20,28,38],[3.4,4.5,6.5,9,12],[3.4,6,10],[3.4,6],[13,17,22]) if 2<=p/n<=4.5]
 cfgs.extend([BASELINE,SELECTED])
 with ThreadPoolExecutor(max_workers=4) as pool:rows=list(pool.map(screen,cfgs))
 (WORK/'coarse.json').write_text(json.dumps(rows,indent=2))
 good=[r for r in rows if r['error']<=.15 and r['bands']['0.5']<=.3 and r['bands']['1']<=.5]
 print('screened',len(rows),'passed',len(good),flush=True)
 shortlist=sorted(good,key=lambda r:r['area'])[:8]
 for r in sorted(good,key=lambda r:r['bands']['1'])[:3]:
  if r not in shortlist:shortlist.append(r)
 def timing(r):
  r['timing']=run(r['cfg'],tran=True);return r
 with ThreadPoolExecutor(max_workers=4) as pool:shortlist=list(pool.map(timing,shortlist))
 (WORK/'shortlist.json').write_text(json.dumps(shortlist,indent=2))
 for r in shortlist:print(r['cfg'],r['area'],r['error'],r['bands']['1'],r['timing']['settle'],flush=True)
def validate_selected():
 jobs=[('selected_dc',SELECTED,dict(step=.125)),('baseline_dc',BASELINE,dict(step=.125)),
       ('selected_10f',SELECTED,dict(tran=True)),('baseline_10f',BASELINE,dict(tran=True)),
       ('selected_100f',SELECTED,dict(tran=True,cap=100)),('selected_85c',SELECTED,dict(tran=True,temp=85)),
       ('selected_skew_a',SELECTED,dict(tran=True,skew=-2)),('selected_skew_b',SELECTED,dict(tran=True,skew=2))]
 def task(job):
  name,cfg,kw=job;return name,run(cfg,keep=name,**kw)
 with ThreadPoolExecutor(max_workers=4) as pool:rows=dict(pool.map(task,jobs))
 rows['corners']=[]
 for temp,v in itertools.product([0,27,85],[4.5,5,5.5]):
  q=run(SELECTED,temp=temp,v=v,step=.125,keep=f'selected_dc_{temp}_{v}');q.update(temp=temp,supply=v);rows['corners'].append(q)
 (WORK/'validated.json').write_text(json.dumps(rows,indent=2))
 print('Validation results:',WORK/'validated.json')
if __name__=='__main__':
 import argparse
 parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--validate',action='store_true',help='Recheck selected sizes, baseline, load, skew and temperature/supply grid')
 if parser.parse_args().validate:validate_selected()
 else:main()

