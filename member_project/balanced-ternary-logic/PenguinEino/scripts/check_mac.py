"""Verify the multiply-add slice from fresh schematic or verified extracted netlists."""
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor
import argparse,hashlib,itertools,json,re,subprocess
import numpy as np
from build_mac import STATES,oracle
ROOT=Path(__file__).resolve().parents[1];PDK=Path('/home/ishi-kai/pdk/TR-1um');WORK=ROOT/'simulation/mac'
REUSE_VALIDATED=False
PROBES=['x','a','b','cin','sum','cout','xdut.p','and_out','or_out'];VECTORS=' '.join(f'v({n})' for n in PROBES)

def sha(p):return hashlib.sha256(Path(p).read_bytes()).hexdigest()
def netlist():
 d=WORK/'netlist';d.mkdir(parents=True,exist_ok=True)
 rc=d/'xschemrc';rc.write_text(f'set XSCHEM_LIBRARY_PATH {{{ROOT}:/usr/local/share/xschem/xschem_library:{PDK}/libs.tech/xschem:{PDK}/libs.tech/xschem/TR-1umLIB}}\nset LIB {{{PDK}/libs.tech/spice/models}}\nset lvs_netlist 0\nset top_is_subckt 0\nset spiceprefix 1\n')
 p=subprocess.run(['xschem','-r','-x','--rcfile',str(rc),'-s','--command','set result [xschem netlist]; puts [xschem get infowindow_text]; exit $result','-o',str(d),str(ROOT/'mac_tb.sch')],capture_output=True,text=True)
 log=p.stdout+p.stderr;(d/'netlist.log').write_text(log)
 if p.returncode or re.search('Error:|SKIPPING|IS MISSING',log):raise RuntimeError(log)
 return re.sub(r'\n\+\s*',' ',(d/'mac_tb.spice').read_text())

def simulate(d,s):
 d.mkdir(parents=True,exist_ok=True)
 dependencies={str(p):sha(p) for p in (PDK/'libs.tech/spice/models').rglob('*') if p.is_file()}
 for quoted,plain in re.findall(r'(?im)^\s*\.include\s+(?:"([^"]+)"|(\S+))',s):
  p=Path(quoted or plain);p=p if p.is_absolute() else d/p
  dependencies[str(p.resolve())]=sha(p)
 context=d/'input_dependencies.json'
 if REUSE_VALIDATED and context.exists() and json.loads(context.read_text())==dependencies and (d/'tb.spice').exists() and (d/'tb.spice').read_text()==s and (d/'results.json').exists():
  previous=json.loads((d/'results.json').read_text());log=(d/'run.log').read_text()
  if previous.get('passed') and 'ngspice-46+ done' in log and ((d/'data.txt').exists() or (d/'mac_tran.txt').exists()):return log
 (d/'tb.spice').write_text(s)
 with (d/'run.log').open('w') as f:p=subprocess.run(['ngspice','-b','tb.spice'],cwd=d,stdout=f,stderr=subprocess.STDOUT,timeout=7200)
 log=(d/'run.log').read_text()
 if p.returncode or re.search(r'Error:|FAIL:|Timestep too small|failed|Nodeset on non-existent node',log,re.I):raise RuntimeError(str(d)+' failed: '+log[-1000:])
 assert all(Path(p).exists() and sha(p)==h for p,h in dependencies.items()),'Simulation dependency changed during run'
 context.write_text(json.dumps(dependencies,indent=2)+'\n')
 return log

def evaluate(path,sequence,hold,edge=1):
 a=np.loadtxt(path,skiprows=1);assert a.shape[1]==10
 if not np.isfinite(a).all() or abs(a[:,1:]).max()>7 or a[-1,0]<len(sequence)*hold*1e-9-1e-14:raise RuntimeError('Invalid/truncated waveforms')
 t=a[:,0]*1e9;rows=[]
 for k,state in enumerate(sequence):
  end=(k+1)*hold-1;target=np.array([*oracle(*state),state[1]*state[2]/5,min(state[1:3]),max(state[1:3])]);obs=np.array([np.interp(end,t,a[:,j]) for j in range(5,10)])
  ins=np.array([np.interp(end,t,a[:,j]) for j in range(1,5)]);assert max(abs(ins-state))<1e-5
  lo=np.searchsorted(t,k*hold+edge);hi=np.searchsorted(t,end,side='right');idx=np.arange(lo,hi)
  bad=np.flatnonzero(np.any(abs(a[idx][:,[5,6,8,9]]-target[[0,1,3,4]])>.5,axis=1))
  settle=0. if not len(bad) else float(t[idx[bad[-1]+1]]-k*hold-edge) if bad[-1]<len(idx)-1 else None
  rows.append(dict(old=sequence[k-1] if k else None,new=state,sum_V=float(obs[0]),cout_V=float(obs[1]),product_V=float(obs[2]),and_V=float(obs[3]),or_V=float(obs[4]),sum_cout_error_V=float(max(abs(obs[:2]-target[:2]))),and_or_error_V=float(max(abs(obs[3:]-target[3:]))),output_error_V=float(max(abs(obs[[0,1,3,4]]-target[[0,1,3,4]]))),product_error_V=float(abs(obs[2]-target[2])),settle_ns=settle))
 result=dict(samples=len(sequence),transitions=len(sequence)-1,max_output_error_V=max(r['output_error_V'] for r in rows),max_product_error_V=max(r['product_error_V'] for r in rows),max_sum_cout_error_V=max(r['sum_cout_error_V'] for r in rows),max_and_or_error_V=max(r['and_or_error_V'] for r in rows),max_settle_ns=max((r['settle_ns'] for r in rows[1:] if r['settle_ns'] is not None),default=0),unsettled=sum(r['settle_ns'] is None for r in rows),rows=rows)
 result['passed']=result['unsettled']==0 and max(result['max_output_error_V'],result['max_product_error_V'])<=.5
 return result

def route(single=False):
 adj={i:[j for j in range(81) if j!=i and (not single or sum(x!=y for x,y in zip(STATES[i],STATES[j]))==1)] for i in range(81)}
 stack=[0];out=[]
 while stack:
  if adj[stack[-1]]:stack.append(adj[stack[-1]].pop())
  else:out.append(stack.pop())
 out=out[::-1];n=648 if single else 6480
 assert len(out)==n+1 and len(set(zip(out,out[1:])))==n
 return [STATES[i] for i in out]

def native(base,root):
 d=root/'tb_sequence';s=re.sub(r'^plot .*\n','',base,flags=re.M).replace('save all',f'save {VECTORS}').replace('.endc','quit\n.endc')
 log=simulate(d,s);assert 'PASS: multiply-add all 81 states' in log
 assert len(re.findall(r'^tran_\d+_\w+\s+=',log,re.M))==82*5
 r=evaluate(d/'mac_tran.txt',STATES+[STATES[0]],1000)
 (d/'view.spice').write_text(base);(d/'results.json').write_text(json.dumps(r,indent=2)+'\n')
 return dict(mode='all_81_inputs',load_fF=10000,hold_ns=1000,max_step_ns=10,load_resistance_ohm=1e6,**{k:v for k,v in r.items() if k!='rows'})

def transitions(base,root,cap=10000,single=False,sequence=None,name=None):
 sequence=route(single) if sequence is None else sequence;hold=1000
 name=name or f'{"single_input_648" if single else "all_6480"}_{cap}f';d=root/name;s=base
 # 81-state comparison against the tighter 1e-4 / 1 pA run changes settled
 # voltages by <1 mV. Use 1 nA to avoid resolving irrelevant off-state noise.
 s=s.replace('reltol=1e-4','reltol=1e-3 abstol=1e-9 vntol=1e-5 trtol=10')
 for j,net in enumerate(PROBES[:4]):
  pts=[f'0 {sequence[0][j]}']
  for k in range(1,len(sequence)):pts.extend([f'{hold*k}n {sequence[k-1][j]}',f'{hold*k+1}n {sequence[k][j]}'])
  pts.append(f'{hold*len(sequence)}n {sequence[-1][j]}')
  s,n=re.subn(r'(?m)^V'+net.upper()+r' .*$',f'V{net.upper()} {net} 0 PWL('+' '.join(pts)+')',s);assert n==1
 for net in ('sum','cout','and_out','or_out'):s,n=re.subn(r'(?m)^C'+net+r' .*$',f'C{net} {net} 0 {cap}f',s);assert n==1
 ctrl=f'.control\nsave {VECTORS}\nset wr_singlescale\nset wr_vecnames\ntran 20n {len(sequence)*hold}n 0 20n\nwrdata data.txt {VECTORS}\nquit\n.endc'
 s=re.sub(r'\.control.*?\.endc',lambda _:ctrl,s,flags=re.S);simulate(d,s)
 (d/'view.spice').write_text(s.replace('\nquit\n',"\nplot v(x) v(a) v(b) v(cin) v(sum) title 'MAC SUM'\nplot v(sum) v(cout) title 'MAC outputs'\nplot v(and_out) v(or_out) title 'AND OR'\n"))
 r=evaluate(d/'data.txt',sequence,hold);(d/'results.json').write_text(json.dumps(r,indent=2)+'\n')
 return dict(mode=name,load_fF=cap,max_step_ns=20,hold_ns=hold,load_resistance_ohm=1e6,solver=dict(method='gear',maxord=2,reltol=1e-3,abstol_A=1e-9,vntol_V=1e-5,trtol=10),**{k:v for k,v in r.items() if k!='rows'})

def exhaustive_parallel(base,root,workers=4):
 sequence=route();parts=[];covered=[]
 for i in range(16):
  lo=6480*i//16;hi=6480*(i+1)//16
  parts.append(([STATES[0]]+sequence[lo:hi+1],f'all_6480_10000f/chunk_{i}'))
  covered.extend(zip(sequence[lo:hi],sequence[lo+1:hi+1]))
 assert len(covered)==6480 and len(set(covered))==6480
 with ThreadPoolExecutor(max_workers=workers) as pool:
  fs=[pool.submit(transitions,base,root,10000,False,seq,name) for seq,name in parts];rows=[f.result() for f in fs]
 result=dict(mode='all_6480_10000f',load_fF=10000,max_step_ns=20,hold_ns=1000,transitions=6480,unique_directed_transitions=6480,samples=sum(r['samples'] for r in rows),
  unsettled=sum(r['unsettled'] for r in rows),passed=all(r['passed'] for r in rows),chunks=rows,
  initialization='Sixteen Euler slices, each preceded by initial and source-state holds. Original 6480 edges plus setup transitions.')
 for k in ('max_output_error_V','max_product_error_V','max_sum_cout_error_V','max_and_or_error_V','max_settle_ns'):result[k]=max(r[k] for r in rows)
 (root/'all_6480_10000f/results_summary.json').write_text(json.dumps(result,indent=2)+'\n')
 return result

def main(quick=False):
 files=[name+ext for name in ('mac','mul','mul_nand','mul_nor','mul_inv','full_adder','half_adder','inverter','nany') for ext in ('.sch','.sym')]+['mac_tb.sch']
 sources={name:sha(ROOT/name) for name in files}
 base=netlist();root=WORK/'schematic';rows=[native(base,root)];print(rows[0],flush=True)
 if not quick:
  rows.append(exhaustive_parallel(base,root));print(rows[-1],flush=True)
  rows.append(transitions(base,root,10000,True));print(rows[-1],flush=True)
 assert sources=={name:sha(ROOT/name) for name in files},'Schematic changed during verification'
 r=dict(passed=all(v['passed'] for v in rows),scope='schematic',cases=rows,temperature_C=27,supplies_V=[-5,0,5],source_sha256=sources,model_sha256={str(p.relative_to(PDK)):sha(p) for p in (PDK/'libs.tech/spice/models').rglob('*') if p.is_file()})
 (ROOT/f'reports/mac{"_quick" if quick else ""}.json').write_text(json.dumps(r,indent=2)+'\n')
 if not r['passed']:raise RuntimeError('MAC verification failed')
if __name__=='__main__':
 p=argparse.ArgumentParser();p.add_argument('--quick',action='store_true');p.add_argument('--resume',action='store_true',help='Reuse only exact, dependency-validated decks and re-evaluate all saved waveforms.');a=p.parse_args();REUSE_VALIDATED=a.resume;main(a.quick)
