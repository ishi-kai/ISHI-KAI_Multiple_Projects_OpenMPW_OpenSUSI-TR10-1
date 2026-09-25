"""Verify actual MUL schematics: DC input bands, 72 transitions, loads and input skew."""
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor
import hashlib,itertools,json,re,subprocess,tempfile
import numpy as np
ROOT=Path(__file__).resolve().parents[1];WORK=ROOT/'simulation/mul'
PDK=Path('/home/ishi-kai/pdk/TR-1um');STATES=list(itertools.product([-5,0,5],repeat=2))
BASELINE=[24,16,15,46,6.5,17,13.5,5,20]
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def prepare():
 d=WORK/'netlist';d.mkdir(parents=True,exist_ok=True)
 rc=d/'xschemrc';rc.write_text(f'set XSCHEM_LIBRARY_PATH {{{ROOT}:/usr/local/share/xschem/xschem_library:{PDK}/libs.tech/xschem:{PDK}/libs.tech/xschem/TR-1umLIB}}\nset LIB {{{PDK}/libs.tech/spice/models}}\nset lvs_netlist 0\nset top_is_subckt 0\nset spiceprefix 1\n')
 p=subprocess.run(['xschem','-r','-x','--rcfile',str(rc),'-s','--command','xschem netlist; puts [xschem get infowindow_text]; exit','-o',str(d),str(ROOT/'mul_tb.sch')],capture_output=True,text=True)
 log=p.stdout+p.stderr;(d/'netlist.log').write_text(log)
 if p.returncode or re.search(r'Error:|IS MISSING|SKIPPING',log):raise RuntimeError(log)
 s=re.sub(r'\n\+\s*',' ',(d/'mul_tb.spice').read_text())
 for a,b in STATES:assert -min(-min(a,b),max(a,b))==a*b/5
 return s

def area(cfg):
 p,n,r,pp,nn,rr,pi,ni,ri=cfg
 return 4*(p+n)+2*(pp+nn)+pi+ni+2.8*(4*r+2*rr+2*ri)
def variant(base,cfg):
 for i,kind in enumerate(('nand','nor','inv')):
  p,n,r=cfg[i*3:i*3+3]
  def change(m):
   s=m[0]
   s=re.sub(r'(?im)^(X\S+ .*? PMOS w=)\S+',lambda q:q[1]+f'{p}u',s)
   s=re.sub(r'(?im)^(X\S+ .*? NMOS w=)\S+',lambda q:q[1]+f'{n}u',s)
   s=re.sub(r'(?im)^(X\S+ .*? F_RR w=\S+ l=)\S+',lambda q:q[1]+f'{r}u',s)
   return s
  base=re.sub(r'(?ims)^\.subckt mul_'+kind+r' .*?^\.ends\b[^\n]*',change,base)
 return base

def execute(s,folder=None):
 def go(d):
  (d/'data.txt').unlink(missing_ok=True);(d/'tb.spice').write_text(s)
  p=subprocess.run(['ngspice','-b','tb.spice'],cwd=d,capture_output=True,text=True,timeout=240)
  log=p.stdout+p.stderr
  if folder:
   (d/'run.log').write_text(log)
   (d/'view.spice').write_text(s.replace('\nquit\n',"\nplot v(a) v(b) v(p) title 'MUL verification'\n"))
  if p.returncode or re.search(r'Error:|Timestep too small|failed',log,re.I):raise RuntimeError(log[-1500:])
  a=np.loadtxt(d/'data.txt',skiprows=1)
  if not np.isfinite(a).all() or abs(a[:,1:]).max()>7:raise RuntimeError('Invalid/nonphysical voltage')
  return a
 if folder:
  d=WORK/folder;d.mkdir(parents=True,exist_ok=True);return go(d)
 with tempfile.TemporaryDirectory(dir=WORK) as d:return go(Path(d))

def route():
 adj={i:[j for j in range(9) if j!=i] for i in range(9)};st=[0];out=[]
 while st:
  if adj[st[-1]]:st.append(adj[st[-1]].pop())
  else:out.append(st.pop())
 rr=out[::-1];assert len(rr)==73 and len(set(zip(rr,rr[1:])))==72
 return rr

def run(base,cfg,mode='dc',cap=10,temp=27,supply=5,step=.5,skew=0,edge=1,hold=120,folder=None):
 s=variant(base,cfg)
 s=re.sub(r'(?m)^\.temp .*$',f'.temp {temp}',s)
 s=re.sub(r'(?m)^VDD .*$',f'VDD VDD 0 {supply}',s);s=re.sub(r'(?m)^VSS .*$',f'VSS VSS 0 {-supply}',s)
 s=re.sub(r'(?m)^Cload .*$',f'Cload p 0 {cap}f',s)
 rr=route()
 for col,net in enumerate(('a','b')):
  val='0'
  if mode=='tran':
   pts=[f'0 {STATES[rr[0]][col]*supply/5}']
   for k in range(1,len(rr)):
    offset=abs(skew) if (skew>0 and col==1) or (skew<0 and col==0) else 0
    t=k*hold+offset
    pts.extend([f'{t}n {STATES[rr[k-1]][col]*supply/5}',f'{t+edge}n {STATES[rr[k]][col]*supply/5}'])
   pts.append(f'{len(rr)*hold}n {STATES[rr[-1]][col]*supply/5}')
   val='PWL('+' '.join(pts)+')'
  s=re.sub(r'(?m)^V'+net.upper()+r' .*$',f'V{net.upper()} {net} 0 {val}',s)
 vectors='v(a) v(b) v(p) v(t1) v(xdut.t2) v(t3)'
 command=f'dc VA {-supply} {supply} {step} VB {-supply} {supply} {step}' if mode=='dc' else f'tran 0.2n {len(rr)*hold}n 0 0.5n'
 ctrl=f'.control\nsave {vectors}\nset wr_singlescale\nset wr_vecnames\n{command}\nwrdata data.txt {vectors}\nquit\n.endc'
 s=re.sub(r'\.control.*?\.endc',lambda _:ctrl,s,flags=re.S)
 a=execute(s,folder)
 result=dict(cfg=list(cfg),area_proxy_um2=area(cfg),mode=mode,cap_fF=cap,temp_C=temp,supply_V=supply)
 if mode=='dc':
  x,y,z=a[:,1:4].T;details=[];bands={str(v):0. for v in (.5,1.)}
  for aa,bb in STATES:
   aa=aa*supply/5;bb=bb*supply/5
   dist=np.maximum(abs(x-aa),abs(y-bb));j=np.argmin(dist)
   if dist[j]>1e-6:raise RuntimeError('Grid misses a nominal input')
   target=aa*bb/supply
   row=dict(a_V=aa,b_V=bb,expected_V=target,p_V=float(z[j]),internal_V=a[j,4:].tolist(),error_V=abs(float(z[j])-target))
   for rad in bands:
    err=float(max(abs(z[dist<=float(rad)+1e-8]-target)));row[f'band_{rad}_V']=err;bands[rad]=max(bands[rad],err)
   details.append(row)
  margin=0.
  for rad in np.arange(step,2.5,step):
   worst=max(float(max(abs(z[np.maximum(abs(x-aa*supply/5),abs(y-bb*supply/5))<=rad+1e-8]-aa*bb*supply/25))) for aa,bb in STATES)
   if worst>.5:break
   margin=float(rad)
  result.update(error_V=max(r['error_V'] for r in details),bands_V=bands,points=details,sampled_input_margin_V=margin,grid_step_V=step)
  return result
 t=a[:,0]*1e9;z=a[:,3];rows=[]
 for k in range(1,len(rr)):
  old=STATES[rr[k-1]];new=STATES[rr[k]];target=new[0]*new[1]*supply/25;prev=old[0]*old[1]*supply/25
  start=k*hold;done=start+edge+abs(skew);end=(k+1)*hold-1
  mask=(t>=done)&(t<=end);tt=t[mask];zz=z[mask];bad=np.flatnonzero(abs(zz-target)>.5)
  settling=0. if not len(bad) else float(tt[bad[-1]+1]-done) if bad[-1]<len(tt)-1 else None
  row=dict(old=old,new=new,expected_V=target,output_V=float(np.interp(end,t,z)),error_V=abs(float(np.interp(end,t,z))-target),settle_ns=settling)
  if target==prev:row['same_output_glitch_V']=float(max(abs(zz-target)))
  else:
   m=(t>=start)&(t<=end);ts=t[m];y0=np.interp(start-.1,t,z);y1=np.interp(end,t,z);progress=(z[m]-y0)/(y1-y0)
   def cross(q):
    ids=np.flatnonzero(progress>=q)
    if not len(ids):return None
    j=ids[0];return float(ts[j] if j==0 else np.interp(q,progress[j-1:j+1],ts[j-1:j+1]))
   t10,t90=cross(.1),cross(.9);row['rise_ns' if target>prev else 'fall_ns']=None if t10 is None or t90 is None else t90-t10
  rows.append(row)
 result.update(count=len(rows),error_V=max(r['error_V'] for r in rows),unsettled=sum(r['settle_ns'] is None for r in rows),settle_ns=max((r['settle_ns'] for r in rows if r['settle_ns'] is not None),default=0),
               rise_ns=max((r.get('rise_ns') or 0 for r in rows),default=0),fall_ns=max((r.get('fall_ns') or 0 for r in rows),default=0),
               same_output_glitch_V=max((r.get('same_output_glitch_V',0) for r in rows),default=0),transitions=rows)
 return result

def native(base):
 d=WORK/'native_tb';d.mkdir(exist_ok=True)
 for f in d.glob('mul_*.txt'):f.unlink()
 text='\n'.join(l for l in base.splitlines() if not l.startswith('plot ')).replace('.endc','quit\n.endc')
 (d/'tb.spice').write_text(text)
 p=subprocess.run(['ngspice','-b','tb.spice'],cwd=d,capture_output=True,text=True,timeout=240)
 log=p.stdout+p.stderr;(d/'run.log').write_text(log)
 ok=p.returncode==0 and 'PASS:' in log and not re.search(r'FAIL:|Error:|Timestep too small',log)
 measurements={k:float(v) for k,v in re.findall(r'^(dc_\d_\d|p_\d)\s*=\s*([-+\d.eE]+)',log,re.M)}
 ok=bool(ok and len(measurements)==19)
 for f in ['mul_tran.txt']+[f'mul_dc_{i}.txt' for i in range(3)]:
  a=np.loadtxt(d/f,skiprows=1)
  ok=ok and np.isfinite(a).all() and abs(a[:,1:]).max()<=7
 return dict(passed=bool(ok),measurements=measurements)

def main():
 base=prepare();cfg=json.loads((ROOT/'design/mul_sizes.json').read_text())['selected']
 n=native(base);print('Native TB:',n['passed'],flush=True)
 jobs=[('selected_dc',cfg,dict(step=.125)),('baseline_dc',BASELINE,dict(step=.125)),
       ('selected_10f',cfg,dict(mode='tran')),('baseline_10f',BASELINE,dict(mode='tran')),
       ('selected_100f',cfg,dict(mode='tran',cap=100)),
       ('selected_skew_a_2ns',cfg,dict(mode='tran',skew=-2)),('selected_skew_b_2ns',cfg,dict(mode='tran',skew=2)),
       ('selected_slow_edges_10ns',cfg,dict(mode='tran',edge=10)),
       ('selected_0C',cfg,dict(mode='tran',temp=0)),('selected_85C',cfg,dict(mode='tran',temp=85))]
 for temp,supply in itertools.product((0,27,85),(4.5,5)):
  if temp==27 and supply==5:continue
  jobs.append((f'dc_{temp}C_{supply}V',cfg,dict(temp=temp,supply=supply,step=.125)))
 results={}
 def task(job):
  name,c,kw=job;r=run(base,c,folder=name,**kw)
  r['passed']=r['error_V']<=.5 and (r['bands_V']['0.5']<=.5 if r['mode']=='dc' else r['unsettled']==0)
  return name,r
 with ThreadPoolExecutor(max_workers=3) as pool:
  for name,r in pool.map(task,jobs):
   results[name]=r
   print(name,'pass',r['passed'],'error',r['error_V'],'settle',r.get('settle_ns'),'band',r.get('bands_V'),flush=True)
   (WORK/'validation_partial.json').write_text(json.dumps(results,indent=2)+'\n')
 sources=[ROOT/f'{stem}.{ext}' for stem in ('mul','mul_nand','mul_nor','mul_inv') for ext in ('sch','sym')]+[ROOT/'mul_tb.sch']
 report=dict(passed=n['passed'] and all(r['passed'] for r in results.values()),native=n,selected=cfg,baseline=BASELINE,
             area_proxy_definition='sum(MOS W*L) + sum(RR W*L), no wells/contacts/routing',results=results,
             source_sha256={p.name:sha(p) for p in sources},
             model_sha256={str(p.relative_to(PDK)):sha(p) for p in (PDK/'libs.tech/spice/models').rglob('*') if p.is_file()})
 (ROOT/'reports/mul.json').write_text(json.dumps(report,indent=2)+'\n')
 print('Overall:',report['passed'],flush=True)
 return report['passed']
if __name__=='__main__':raise SystemExit(0 if main() else 1)
