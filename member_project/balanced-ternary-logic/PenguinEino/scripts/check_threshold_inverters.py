"""Netlist PTI/NTI, run schematic TBs, then test 100 fF and a temperature/supply DC grid."""
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor
import subprocess,re,json,itertools
import numpy as np
ROOT=Path(__file__).resolve().parents[1];WORK=ROOT/'simulation/threshold_inverters'
SEQ=[-5,0,5,0,-5,5,-5]
def expected(kind,x,v=5):return v if x<0 or (x==0 and kind=='pti') else -v

def prepare(kind):
 d=WORK/kind;d.mkdir(parents=True,exist_ok=True)
 p=subprocess.run(['xschem','-r','-x','--rcfile',str(ROOT/'simulation/verify.xschemrc'),'-s','--command','xschem netlist; puts [xschem get infowindow_text]; exit','-o',str(d),str(ROOT/f'{kind}_tb.sch')],capture_output=True,text=True)
 (d/'netlist.log').write_text(p.stdout+p.stderr)
 if p.returncode or re.search('Error:|SKIP RECORD',p.stdout+p.stderr):raise RuntimeError(kind+' netlist failed')
 base=re.sub(r'\n\+\s*',' ',(d/f'{kind}_tb.spice').read_text())
 return base

def execute(d,s):
 d.mkdir(exist_ok=True);(d/'batch.spice').write_text(s)
 p=subprocess.run(['ngspice','-b','batch.spice'],cwd=d,capture_output=True,text=True,timeout=120)
 (d/'run.log').write_text(p.stdout+p.stderr)
 if p.returncode or re.search('Error:|FAIL:|Timestep too small',p.stdout+p.stderr):raise RuntimeError(str(d)+' simulation failed')

def timing(kind,a):
 t=a[:,0]*1e9;y=a[:,2];rows=[]
 for k in range(1,len(SEQ)):
  start=k*200;end=(k+1)*200-1;tar=expected(kind,SEQ[k]);mask=(t>=start+1)&(t<=end);tt=t[mask];bad=np.flatnonzero(abs(y[mask]-tar)>.5)
  settle=0 if not len(bad) else float(tt[bad[-1]+1]-start-1) if bad[-1]<len(tt)-1 else None
  row=dict(old=SEQ[k-1],new=SEQ[k],error=abs(float(np.interp(end,t,y))-tar),settle_ns=settle)
  if expected(kind,SEQ[k-1])!=tar:
   y0=float(np.interp(start-.1,t,y));y1=float(np.interp(end,t,y));m=(t>=start)&(t<=end);ts=t[m];progress=(y[m]-y0)/(y1-y0)
   def crossing(q):
    ids=np.flatnonzero(progress>=q)
    if not len(ids):raise RuntimeError('Transition did not finish')
    j=ids[0];return float(ts[j] if not j else np.interp(q,progress[j-1:j+1],ts[j-1:j+1]))
   row['rise_ns' if y1>y0 else 'fall_ns']=crossing(.9)-crossing(.1)
  rows.append(row)
 return dict(error=max(r['error'] for r in rows),settle_ns=max((r['settle_ns'] for r in rows if r['settle_ns'] is not None),default=0),unsettled=sum(r['settle_ns'] is None for r in rows),rise_ns=max(r.get('rise_ns',0) for r in rows),fall_ns=max(r.get('fall_ns',0) for r in rows),transitions=rows)

def run(kind,base,mode,temp=27,v=5,cap=10):
 d=WORK/f'{kind}_{mode}_{temp}_{v}_{cap}'
 s=re.sub(r'^\.temp .*$',f'.temp {temp}',base,flags=re.M)
 s=re.sub(r'^VDD .*$',f'VDD V+ 0 {v}',s,flags=re.M);s=re.sub(r'^VSS .*$',f'VSS V- 0 {-v}',s,flags=re.M)
 s=re.sub(r'^Cload .*$',f'Cload vout 0 {cap}f',s,flags=re.M)
 if mode=='dc':
  s=re.sub(r'^VIN .*$','VIN vin 0 0',s,flags=re.M)
  cmd=f'dc VIN {-v} {v} {v/320}'
 else:cmd='tran 0.05n 1400n'
 ctrl='.control\nset wr_singlescale\nset wr_vecnames\n'+cmd+'\nwrdata data.txt v(vin) v(vout)\nquit\n.endc'
 s=re.sub(r'\.control.*?\.endc',ctrl,s,flags=re.S);execute(d,s)
 a=np.loadtxt(d/'data.txt',skiprows=1)
 if not np.isfinite(a).all() or abs(a[:,1:]).max()>v+2:raise RuntimeError('Nonphysical output')
 r=dict(kind=kind,mode=mode,temp=temp,supply=v,cap=cap)
 if mode=='dc':
  x,y=a[:,1:].T;outs=[float(np.interp(xx,x,y)) for xx in [-v,0,v]]
  band=max(float(max(abs(y[abs(x-xx)<=.5+1e-7]-expected(kind,xx,v)))) for xx in [-v,0,v])
  r.update(outputs=outs,error=max(abs(yy-expected(kind,xx,v)) for xx,yy in zip([-v,0,v],outs)),band_error=band,switch_at_vout0=float(np.interp(0,y[::-1],x[::-1])))
 else:r.update(timing(kind,a))
 return r

def main():
 bases={k:prepare(k) for k in ['pti','nti']}
 for kind,base in bases.items():
  s='\n'.join(l for l in base.splitlines() if not l.startswith('plot ')).replace('.endc','quit\n.endc');execute(WORK/kind,s)
 jobs=[(k,'dc',t,v,10) for k,t,v in itertools.product(bases,[0,27,85],[4.5,5,5.5])]+[(k,'tran',27,5,100) for k in bases]
 with ThreadPoolExecutor(max_workers=4) as pool:rows=list(pool.map(lambda j:run(j[0],bases[j[0]],*j[1:]),jobs))
 for kind in bases:
  a=np.loadtxt(WORK/kind/f'{kind}_tran.txt',skiprows=1);r=dict(kind=kind,mode='tran',temp=27,supply=5,cap=10);r.update(timing(kind,a));rows.append(r)
 (WORK/'validated.json').write_text(json.dumps(rows,indent=2))
 for k in bases:
  dc=[r for r in rows if r['kind']==k and r['mode']=='dc'];tr=[r for r in rows if r['kind']==k and r['mode']=='tran']
  print(k,'max DC band error',max(r['band_error'] for r in dc),'timing',tr,flush=True)
 if any(r.get('band_error',r['error'])>.5 or r.get('unsettled',0) for r in rows):raise RuntimeError('Validation outside +/-0.5 V')
if __name__=='__main__':main()
