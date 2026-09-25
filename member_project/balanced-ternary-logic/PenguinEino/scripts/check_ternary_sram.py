"""Netlist actual SRAM schematics and run native TBs plus initial-state/access checks."""
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor
import hashlib,itertools,json,re,subprocess
import numpy as np
ROOT=Path(__file__).resolve().parents[1]
WORK=ROOT/'simulation/ternary_sram'
PDK=Path('/home/ishi-kai/pdk/TR-1um')
TBS=['ternary_latch_tb','ternary_sram_tb','ternary_sram_read_tb']
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def netlist(name):
 d=WORK/name;d.mkdir(parents=True,exist_ok=True)
 rc=d/'xschemrc';rc.write_text(f'set XSCHEM_LIBRARY_PATH {{{ROOT}:/usr/local/share/xschem/xschem_library:{PDK}/libs.tech/xschem:{PDK}/libs.tech/xschem/TR-1umLIB}}\nset LIB {{{PDK}/libs.tech/spice/models}}\nset lvs_netlist 0\nset top_is_subckt 0\nset spiceprefix 1\n')
 p=subprocess.run(['xschem','-r','-x','--rcfile',str(rc),'-s','--command','xschem netlist; puts [xschem get infowindow_text]; exit','-o',str(d),str(ROOT/f'{name}.sch')],capture_output=True,text=True)
 log=p.stdout+p.stderr;(d/'netlist.log').write_text(log)
 if p.returncode or re.search(r'Error:|IS MISSING|SKIPPING',log):raise RuntimeError(log)
 return re.sub(r'\n\+\s*',' ',(d/f'{name}.spice').read_text())
def simulate(d,text):
 d.mkdir(parents=True,exist_ok=True);(d/'batch.spice').write_text(text)
 p=subprocess.run(['ngspice','-b','batch.spice'],cwd=d,capture_output=True,text=True,timeout=180)
 log=p.stdout+p.stderr;(d/'run.log').write_text(log)
 return dict(completed=p.returncode==0 and not bool(re.search(r'Error:|Timestep too small|failed',log,re.I)),passed=p.returncode==0 and 'PASS:' in log and not bool(re.search(r'Error:|FAIL:|Timestep too small',log)),log=log)
def native(name,text):
 d=WORK/name
 r=simulate(d,'\n'.join(l for l in text.splitlines() if not l.startswith('plot ')).replace('.endc','quit\n.endc'))
 metrics={k:float(v) for k,v in re.findall(r'^([\w]+)\s*=\s*([-+\d.eE]+)',r.pop('log'),re.M)}
 r.update(name=name,measurements=metrics)
 # Independently reject missing data, nonfinite / grossly nonphysical voltages.
 files=['ternary_latch_hold.txt'] if name=='ternary_latch_tb' else ['ternary_sram_write.txt'] if name=='ternary_sram_tb' else [f'ternary_sram_read_{i}.txt' for i in range(3)]
 for file in files:
  a=np.loadtxt(d/file,skiprows=1)
  if not np.isfinite(a).all() or np.max(np.abs(a[:,1:]))>7:r['passed']=False
 return r

def fixture_header(base):
 # Reuse the actual Xschem-generated subcircuits, including the PDK wrappers.
 sub=base[base.lower().index('.subckt ternary_sram '):]
 sub=re.sub(r'(?im)^\.end\s*$','',sub)
 return ('SRAM characterization fixture\n'
         f'.include {PDK}/libs.tech/spice/models/ip62_models\n'
         +sub+'\n.temp 27\nVDD VDD 0 5\nVSS VSS 0 -5\n')

def fixture_run(folder,s,vectors,stop=1000):
 d=WORK/folder;d.mkdir(parents=True,exist_ok=True)
 (d/'data.txt').unlink(missing_ok=True)
 s+=f'.control\nset wr_singlescale\nset wr_vecnames\nsave {vectors}\ntran 0.5n {stop}n 0 0.5n\nwrdata data.txt {vectors}\nquit\n.endc\n.end\n'
 r=simulate(d,s)
 if not r['completed']:raise RuntimeError(str(d)+' simulation incomplete')
 a=np.loadtxt(d/'data.txt',skiprows=1)
 if not np.isfinite(a).all() or a[-1,0]<stop*1e-9-1e-15 or abs(a[:,1:]).max()>7:
  raise RuntimeError(str(d)+' invalid waveform')
 return a

def initial_neighborhood(base):
 s=fixture_header(base);cases=[]
 for nominal in (-5,0,5):
  qs=[-5,-4.75,-4.5] if nominal<0 else [-.5,0,.5] if nominal==0 else [4.5,4.75,5]
  qbs=[-v for v in qs]
  cases.extend((nominal,q,qb) for q,qb in itertools.product(qs,qbs))
 for k,(_,q,qb) in enumerate(cases):
  s+=f'X{k} q{k} qb{k} VDD VSS ternary_latch\nCQ{k} q{k} 0 10f\nCQB{k} qb{k} 0 10f\n.ic v(q{k})={q} v(qb{k})={qb}\n'
 a=fixture_run('hold_neighborhood',s,' '.join(f'v(q{k}) v(qb{k})' for k in range(len(cases))))
 rows=[]
 for k,(v,q,qb) in enumerate(cases):
  final=a[-1,1+2*k:3+2*k];err=float(max(abs(final-[v,-v])))
  rows.append(dict(target_q_V=v,initial_V=[q,qb],final_V=final.tolist(),max_error_V=err,passed=err<=.5))
 return dict(cases=rows,passed=all(r['passed'] for r in rows))

def write_pairs(base):
 s=fixture_header(base)+'VWL WL 0 PWL(0 -5 100n -5 101n 5 250n 5 251n -5 700n -5)\n'
 cases=list(itertools.product([-5,0,5],repeat=2))
 for k,(old,new) in enumerate(cases):
  s+=f'X{k} bl{k} blb{k} WL q{k} qb{k} VDD VSS ternary_sram\nCQ{k} q{k} 0 10f\nCQB{k} qb{k} 0 10f\n.ic v(q{k})={old} v(qb{k})={-old}\n'
  # At 400 ns deliberately reverse the driven bitlines with WL OFF.
  off=-new if new else 5
  s+=f'VBL{k} bl{k} 0 PWL(0 {new} 400n {new} 401n {off} 700n {off})\nVBLB{k} blb{k} 0 PWL(0 {-new} 400n {-new} 401n {-off} 700n {-off})\n'
 a=fixture_run('write_pairs',s,' '.join(f'v(q{k}) v(qb{k})' for k in range(len(cases))),700)
 rows=[]
 for k,(old,new) in enumerate(cases):
  samples=[[float(np.interp(t*1e-9,a[:,0],a[:,c])) for c in (1+2*k,2+2*k)] for t in (99,399,699)]
  err=max(float(max(abs(np.array(v)-[target,-target]))) for v,target in zip(samples,[old,new,new]))
  rows.append(dict(old_q_V=old,new_q_V=new,before_write_V=samples[0],after_write_V=samples[1],after_off_bitline_reversal_V=samples[2],max_error_V=err,passed=err<=.5))
 return dict(cases=rows,passed=all(r['passed'] for r in rows))

def read_load(base,cap):
 s=fixture_header(base)+'VWL WL 0 PWL(0 -5 200n -5 201n 5 700n 5 701n -5 1000n -5)\n'
 cases=list(itertools.product([-5,0,5],repeat=3))
 for k,(q,bl,blb) in enumerate(cases):
  s+=f'X{k} bl{k} blb{k} WL q{k} qb{k} VDD VSS ternary_sram\nCQ{k} q{k} 0 10f\nCQB{k} qb{k} 0 10f\nCBL{k} bl{k} 0 {cap}f\nCBLB{k} blb{k} 0 {cap}f\n.ic v(q{k})={q} v(qb{k})={-q} v(bl{k})={bl} v(blb{k})={blb}\n'
 vectors=' '.join(f'v(q{k}) v(qb{k}) v(bl{k}) v(blb{k})' for k in range(len(cases)))
 a=fixture_run(f'read_load_{cap}f',s,vectors);rows=[]
 for k,(q,bl,blb) in enumerate(cases):
  final=a[-1,1+4*k:3+4*k]
  at_read=np.array([float(np.interp(699e-9,a[:,0],a[:,c])) for c in range(1+4*k,5+4*k)])
  during=(a[:,0]>=200e-9)&(a[:,0]<=701e-9)
  excursion=float(np.max(abs(a[during,1+4*k:3+4*k]-[q,-q])))
  err=float(max(abs(final-[q,-q])));diff=at_read[2]-at_read[3]
  decode=diff < -1 if q<0 else diff>1 if q>0 else abs(diff)<.5 and max(abs(at_read[2:]))<.5
  ok=err<=.5 and max(abs(at_read[:2]-[q,-q]))<=.5 and decode
  rows.append(dict(stored_q_V=q,initial_bl_V=bl,initial_blb_V=blb,at_read_q_qb_bl_blb_V=at_read.tolist(),final_q_qb_V=final.tolist(),peak_storage_excursion_V=excursion,read_differential_V=float(diff),retained=bool(err<=.5),passed=bool(ok)))
 return dict(bitline_cap_fF=cap,passed_cases=sum(r['passed'] for r in rows),total_cases=len(rows),cases=rows)

def main():
 bases={name:netlist(name) for name in TBS}
 with ThreadPoolExecutor(max_workers=3) as pool:results=list(pool.map(lambda n:native(n,bases[n]),TBS))
 base=bases['ternary_sram_tb']
 with ThreadPoolExecutor(max_workers=2) as pool:
  h=pool.submit(initial_neighborhood,base);w=pool.submit(write_pairs,base)
  hold,writes=h.result(),w.result()
 # Large simultaneous circuits: run load points sequentially to bound memory.
 loads=[]
 for cap in (10,100,1000):
  r=read_load(base,cap);loads.append(r)
  print(f"Read CBL={cap} fF: {r['passed_cases']}/{r['total_cases']} cases",flush=True)
 primary=all(r['passed'] for r in results) and hold['passed'] and writes['passed'] and loads[0]['passed_cases']==27
 sources=[p for p in ROOT.glob('ternary*.*') if p.suffix in ('.sch','.sym')]+[ROOT/'inverter.sch',ROOT/'inverter.sym']
 models=[p for p in (PDK/'libs.tech/spice/models').rglob('*') if p.is_file()]
 out=dict(nominal_passed=primary,temperature_C=27,supply_V=[-5,5],storage_cap_fF=10,native=results,hold_neighborhood=hold,write_pairs=writes,
          read_characterization=loads,all_characterized_reads_passed=all(r['passed_cases']==r['total_cases'] for r in loads),
          source_sha256={p.name:sha(p) for p in sources},model_sha256={str(p.relative_to(PDK)):sha(p) for p in models})
 (ROOT/'reports/ternary_sram.json').write_text(json.dumps(out,indent=2)+'\n')
 print('Native TBs:',[(r['name'],r['passed']) for r in results])
 print('Hold neighborhood:',hold['passed'],'Write pairs + deselected isolation:',writes['passed'])
 print('Nominal passed:',primary,'All larger-load characterization passed:',out['all_characterized_reads_passed'])
 return primary
if __name__=='__main__':raise SystemExit(0 if main() else 1)
