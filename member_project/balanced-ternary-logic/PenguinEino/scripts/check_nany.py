"""Verify canonical nany.sch via its symbol: DC neighborhoods and all 72 transitions.
Results: simulation/nany_checks. Run: python3 scripts/check_nany.py
"""
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor
import subprocess,re,json,itertools,hashlib
import numpy as np
from check_half_adder import route,STATES
ROOT=Path(__file__).resolve().parents[1];WORK=ROOT/'simulation/nany_checks'
def netlist(name):
 d=WORK/name;d.mkdir(parents=True,exist_ok=True)
 rc=d/'xschemrc';pdk=Path('/home/ishi-kai/pdk/TR-1um')
 rc.write_text(f'set XSCHEM_LIBRARY_PATH {{{ROOT}:/usr/local/share/xschem/xschem_library:{pdk}/libs.tech/xschem}}\nset LIB {{{pdk}/libs.tech/spice/models}}\nset lvs_netlist 0\nset top_is_subckt 0\nset spiceprefix 1\n')
 p=subprocess.run(['xschem','-r','-x','--rcfile',str(rc),'-s','--command','xschem netlist; puts [xschem get infowindow_text]; exit','-o',str(d),str(ROOT/f'{name}.sch')],capture_output=True,text=True)
 (d/'netlist.log').write_text(p.stdout+p.stderr)
 if p.returncode or re.search('Error:|SKIP RECORD',p.stdout+p.stderr):raise RuntimeError(name+' netlist failed')
 return re.sub(r'\n\+\s*',' ',(d/f'{name}.spice').read_text())
def devices(base,name):
 block=re.search(r'^\.subckt '+name+r' .*?^\.ends',base,re.M|re.S)
 if not block:raise RuntimeError('Missing '+name)
 return sorted(l.strip() for l in block[0].splitlines() if l and l[0].lower() in 'xrclmb')
def run(job,base):
 mode,cap,skew=job;d=WORK/mode;d.mkdir(exist_ok=True);rr=route();hold=100;s=base
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
 cmd='dc VA -5 5 0.125 VB -5 5 0.125' if mode=='dc' else f'tran 0.1n {len(rr)*hold}n'
 ctrl='.control\nsave all\nset wr_singlescale\nset wr_vecnames\n'+cmd+'\nwrdata data.txt v(a) v(b) v(vout)\nquit\n.endc'
 s=re.sub(r'\.control.*?\.endc',ctrl,s,flags=re.S);(d/'batch.spice').write_text(s)
 (d/'view.spice').write_text(s.replace('\nquit\n',"\nplot v(a) v(b) v(vout) title 'NANY'\n"))
 p=subprocess.run(['ngspice','-b','batch.spice'],cwd=d,capture_output=True,text=True,timeout=240);(d/'run.log').write_text(p.stdout+p.stderr)
 if p.returncode or re.search('Error:|Timestep too small',p.stdout+p.stderr):raise RuntimeError(mode+' simulation error')
 a=np.loadtxt(d/'data.txt',skiprows=1)
 if not np.isfinite(a).all() or abs(a[:,1:]).max()>7:raise RuntimeError(mode+' nonphysical output')
 if mode=='dc':
  rows=[]
  for aa,bb in STATES:
   target=-5*np.sign(aa+bb);dist=np.maximum(abs(a[:,1]-aa),abs(a[:,2]-bb));idx=np.argmin(dist)
   rows.append(dict(inputs=[aa,bb],output=float(a[idx,3]),error=float(abs(a[idx,3]-target)),half_volt_band=float(max(abs(a[dist<=.50001,3]-target)))))
  return dict(mode=mode,points=rows,error=max(r['error'] for r in rows),band_error=max(r['half_volt_band'] for r in rows))
 t=a[:,0]*1e9;rows=[]
 for k in range(1,len(rr)):
  target=-5*np.sign(sum(STATES[rr[k]]));end=(k+1)*hold-1;edge_end=k*hold+1+abs(skew);mask=(t>=edge_end)&(t<=end);tt=t[mask];bad=np.flatnonzero(abs(a[mask,3]-target)>.5)
  settle=0 if not len(bad) else float(tt[bad[-1]+1]-edge_end) if bad[-1]<len(tt)-1 else None
  rows.append(dict(old=STATES[rr[k-1]],new=STATES[rr[k]],error=abs(float(np.interp(end,t,a[:,3]))-target),settle_ns=settle))
 return dict(mode=mode,count=len(rows),error=max(r['error'] for r in rows),settle_ns=max((r['settle_ns'] for r in rows if r['settle_ns'] is not None),default=0),unsettled=sum(r['settle_ns'] is None for r in rows),transitions=rows)
def main():
 base=netlist('nany_tb');actual=devices(base,'nany')
 # The legacy NSIGN is retained as a historical reference, not used by the IC HA.
 old=netlist('nsign_tb');legacy=[l.replace('V+','VDD').replace('V-','VSS').replace('V0','VMID') for l in devices(old,'nsign')]
 same=(actual==legacy)
 assert sum(' PMOS ' in l or ' NMOS ' in l for l in actual)==8
 assert sum(' F_RR ' in l for l in actual)==2
 assert not any(l[0].lower()=='c' for l in actual)
 manifest=dict(cell='nany',ports=['a','b','vout','VDD','VSS','VMID'],devices=actual,device_sha256=hashlib.sha256('\n'.join(actual).encode()).hexdigest(),matches_legacy_nsign=same)
 (WORK/'manifest.json').write_text(json.dumps(manifest,indent=2))
 frozen=ROOT/'design/nany_mac_rr30.json'
 assert frozen.exists(),'Missing reviewed NANY baseline'
 if frozen.exists():
  baseline=json.loads(frozen.read_text())
  if manifest['device_sha256']!=baseline['device_sha256']:raise RuntimeError('NANY differs from the reviewed RR30 schematic baseline')
 jobs=[('dc',10,0),('tran_10f',10,0),('tran_100f',100,0),('skew_a',10,-2),('skew_b',10,2)]
 rows=[]
 with ThreadPoolExecutor(max_workers=3) as pool:
  for r in pool.map(lambda j:run(j,base),jobs):
   rows.append(r);print({k:v for k,v in r.items() if k not in ['points','transitions']},flush=True);(WORK/'results.json').write_text(json.dumps(rows,indent=2))
 if any(r['error']>.5 or r.get('band_error',0)>.5 or r.get('unsettled',0) for r in rows):raise RuntimeError('NANY verification failed')
 summary=dict(passed=True,device_sha256=manifest['device_sha256'],schematic_sha256=hashlib.sha256((ROOT/'nany.sch').read_bytes()).hexdigest(),cases=[{k:v for k,v in r.items() if k not in ('points','transitions')} for r in rows],scope='Nominal +/-5 V, 27 C; all 72 transitions at 10/100 fF, input skew +/-2 ns, DC neighborhoods. Not the 10 pF MAC specification.')
 (ROOT/'reports/mac_improvements/nany_regression.json').write_text(json.dumps(summary,indent=2)+'\n')
if __name__=='__main__':main()
