"""Screen resistor-free 2T PTI/NTI at +/-5 V. Results under simulation/threshold_inverters.
Sizing tuple: Wp,Lp,Wn,Ln in um. Area is sum(W*L), not layout area.
"""
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor
import subprocess,tempfile,json,itertools,re
import numpy as np
ROOT=Path(__file__).resolve().parents[1];WORK=ROOT/'simulation/threshold_inverters'
MODEL='/home/ishi-kai/pdk/TR-1um/libs.tech/spice/models/ip62_models'
SEQ=[-5,0,5,0,-5,5,-5]
def target(kind,x,v=5):return v if x<0 or (x==0 and kind=='pti') else -v
def simulate(kind,cfg,cap=10,temp=27,v=5,tran=False,keep=None):
 wp,lp,wn,ln=cfg
 source='0'
 if tran:
  pts=[f'0 {-v}']
  for k in range(1,len(SEQ)):pts.extend([f'{k*200}n {SEQ[k-1]*v/5}',f'{k*200+1}n {SEQ[k]*v/5}'])
  source='PWL('+' '.join(pts)+')'
 cmd='tran 0.05n 1400n' if tran else f'dc VIN {-v} {v} {v/80}'
 s=f'''{kind} 2T trial {cfg}
.include {MODEL}
XP y vin vp vp PMOS w={wp}u l={lp}u nrd=0 nrs=0
XN y vin vn vn NMOS w={wn}u l={ln}u nrd=0 nrs=0
VDD vp 0 {v}
VSS vn 0 {-v}
VIN vin 0 {source}
Cload y 0 {cap}f
.temp {temp}
.control
set wr_singlescale
set wr_vecnames
{cmd}
wrdata data.txt v(vin) v(y)
quit
.endc
.end
'''
 def execute(d):
  (d/'tb.spice').write_text(s);p=subprocess.run(['ngspice','-b','tb.spice'],cwd=d,capture_output=True,text=True,timeout=90)
  if keep:(d/'run.log').write_text(p.stdout+p.stderr)
  if p.returncode or re.search('Error:|Timestep too small',p.stdout+p.stderr):raise RuntimeError(p.stderr[-1000:])
  a=np.loadtxt(d/'data.txt',skiprows=1)
  if not np.isfinite(a).all() or abs(a[:,1:]).max()>v+2:raise RuntimeError('Nonphysical result')
  return a
 if keep:d=WORK/keep;d.mkdir(exist_ok=True);a=execute(d)
 else:
  with tempfile.TemporaryDirectory(dir=WORK) as d:a=execute(Path(d))
 result=dict(kind=kind,cfg=cfg,area=wp*lp+wn*ln,temp=temp,supply=v,cap=cap)
 if not tran:
  x,y=a[:,1:].T;nom=[float(np.interp(xx,x,y)) for xx in [-v,0,v]]
  bands=[float(max(abs(y[abs(x-xx)<=.5+1e-7]-target(kind,xx,v)))) for xx in [-v,0,v]]
  crossing=float(np.interp(0,y[::-1],x[::-1]))
  result.update(outputs=nom,error=max(abs(yy-target(kind,xx,v)) for xx,yy in zip([-v,0,v],nom)),band_error=max(bands),switch_at_vout0=crossing)
 else:
  t=a[:,0]*1e9;y=a[:,2];rows=[]
  for k in range(1,len(SEQ)):
   expected=target(kind,SEQ[k],v);mask=(t>=k*200+1)&(t<=(k+1)*200-1);tt=t[mask];bad=np.flatnonzero(abs(y[mask]-expected)>.5)
   settle=0 if not len(bad) else float(tt[bad[-1]+1]-k*200-1) if bad[-1]<len(tt)-1 else None
   rows.append(dict(old=SEQ[k-1],new=SEQ[k],error=abs(float(np.interp((k+1)*200-1,t,y))-expected),settle_ns=settle))
  result.update(transitions=rows,error=max(r['error'] for r in rows),settle_ns=max((r['settle_ns'] for r in rows if r['settle_ns'] is not None),default=0),unsettled=sum(r['settle_ns'] is None for r in rows))
 return result

def main():
 WORK.mkdir(exist_ok=True)
 jobs=[]
 for kind,w,l in itertools.product(['pti','nti'],[3.4,5,7,10,14,20,28,40,56,80,112],[1,2,3,4,6,8,12,16]):
  cfg=(w,1,3.4,l) if kind=='pti' else (3.4,l,w,1);jobs.append((kind,cfg))
 with ThreadPoolExecutor(max_workers=4) as pool:rows=list(pool.map(lambda j:simulate(*j),jobs))
 (WORK/'screen.json').write_text(json.dumps(rows,indent=2))
 short=[]
 for kind in ['pti','nti']:
  good=sorted([r for r in rows if r['kind']==kind and r['error']<=.25 and r['band_error']<=.5],key=lambda r:r['area'])
  print(kind,'passing',len(good),'smallest',good[:5],flush=True)
  for r in good[:5]:short.append(simulate(kind,r['cfg'],tran=True))
 (WORK/'shortlist.json').write_text(json.dumps(short,indent=2))
 print('timing',short,flush=True)
if __name__=='__main__':main()
