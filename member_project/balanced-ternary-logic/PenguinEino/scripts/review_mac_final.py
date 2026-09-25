"""Final current-revision review; keep evidence separate from historical reports."""
from pathlib import Path
from collections import Counter
import argparse,hashlib,itertools,json,re,subprocess,time,shutil
import numpy as np
import review_mac as r
import check_mac as logic
import check_mac_extracted as ex
ROOT=r.ROOT;WORK=ROOT/'simulation/final_review';REPORT=ROOT/'reports/final_review'
r.WORK=WORK;r.REPORT=REPORT

def physical():
 r.audit();r.verify_logic();r.physical();r.pcell_audit()
 for script,source,target in [('check_mac_driver.py','reports/mac_driver.json','driver.json'),('check_mac_alignment.py','reports/mac_alignment/power_geometry.json','power_geometry.json')]:
  subprocess.run(['python3',str(ROOT/'scripts'/script)],check=True,stdout=subprocess.DEVNULL)
  shutil.copy2(ROOT/source,REPORT/target)
 active=logic.PDK;src=Path('/home/ishi-kai/src/TR-1um')
 files={str(p.relative_to(active)):logic.sha(p) for p in (active/'libs.tech/klayout/tech/python').rglob('*.py')}
 differences=[n for n,h in files.items() if not (src/n).exists() or logic.sha(src/n)!=h]
 branch=subprocess.check_output(['git','branch','--show-current'],cwd=src,text=True).strip()
 r.output('pdk_pcell_source',dict(branch=branch,revision=subprocess.check_output(['git','rev-parse','HEAD'],cwd=src,text=True).strip(),pcell_source_hashes=files,source_differences=differences,passed=branch=='dev' and not differences))

def simulations():
 logic.WORK=WORK/'mac';ex.WORK=WORK/'extracted';logic.REUSE_VALIDATED=False
 base,layout,raw=ex.prepare();rows=[]
 for kind,fn in [('native',lambda:logic.native(base,ex.WORK)),('exhaustive',lambda:logic.exhaustive_parallel(base,ex.WORK)),('single',lambda:logic.transitions(base,ex.WORK,10000,True))]:
  start=time.time();row=fn();rows.append(row)
  result=dict(passed=all(x['passed'] for x in rows),complete=len(rows)==3,gds_sha256=layout['gds_sha256'],extracted_sha256=logic.sha(ROOT/'mac.extracted'),cases=rows,model_sha256={str(p.relative_to(logic.PDK)):logic.sha(p) for p in (logic.PDK/'libs.tech/spice/models').rglob('*') if p.is_file()},scope='Fresh current extracted simulations; 27 C, +/-5 V, 10 pF || 1 Mohm, 1 us hold, no wire RC.')
  r.output('fresh_extracted',result);print(kind,{k:v for k,v in row.items() if k!='chunks'},'wall_s',time.time()-start,flush=True)
 assert logic.sha(ROOT/'mac.gds')==layout['gds_sha256']

def recheck(scope,folder,final=False):
 result={};allstates=list(itertools.product((-1,0,1),repeat=4))
 def assess(paths,mode,source):
  coverage=Counter();maxerr=np.zeros(5);failures=[];count=0;manifest={}
  for path in paths:
   folder=path.parent;deps=json.loads((folder/'input_dependencies.json').read_text());assert all(logic.sha(p)==h for p,h in deps.items()),folder
   log=(folder/'run.log').read_text();assert 'ngspice-46+ done' in log and not re.search(r'Error:|simulation\(s\) aborted|Timestep too small',log,re.I)
   data=np.loadtxt(path,skiprows=1);assert data.shape[1]==10 and np.isfinite(data).all() and abs(data[:,1:]).max()<7
   hold=1000;n=round(data[-1,0]*1e9/hold);assert abs(data[-1,0]-n*1e-6)<1e-12
   sample=np.array([[np.interp((k+1)*hold-1,data[:,0]*1e9,data[:,j]) for j in range(1,10)] for k in range(n)])
   states=np.rint(sample[:,:4]/5).astype(int);assert abs(sample[:,:4]-states*5).max()<1e-5
   expected=np.array([r.oracle(s) for s in states])*5;observed=sample[:,[4,5,7,8,6]];errors=abs(observed-expected);maxerr=np.maximum(maxerr,errors.max(axis=0));failures.extend(np.where(np.any(errors>.5,axis=1))[0].tolist());count+=n
   first=1 if mode=='all' else 0
   coverage.update((tuple(a),tuple(b)) for a,b in zip(states[first:-1],states[first+1:]))
   manifest[str(path.relative_to(ROOT))]=logic.sha(path)
  expected={(a,b) for a in allstates for b in allstates if a!=b and (mode=='all' or sum(x!=y for x,y in zip(a,b))==1)}
  assert set(coverage)==expected and all(v==1 for v in coverage.values())
  result[mode]=dict(passed=not failures,unique_transitions=len(coverage),each_once=True,samples=count,max_errors_V=dict(zip(['sum','cout','and','or','product'],maxerr.tolist())),raw_sha256=manifest,source=source)
 for mode,paths in [('all',sorted((folder/'all_6480_10000f').glob('chunk_*/data.txt'))),('single',[folder/'single_input_648_10000f/data.txt'])]:assess(paths,mode,str(folder.relative_to(ROOT)))
 r.output('independent_'+scope,result);print('independent',scope,{k:(v['passed'],v['unique_transitions']) for k,v in result.items()},flush=True)

if __name__=='__main__':
 p=argparse.ArgumentParser();p.add_argument('mode',choices=['physical','simulate','saved','fresh_recheck']);a=p.parse_args()
 if a.mode=='physical':physical()
 elif a.mode=='simulate':simulations()
 elif a.mode=='saved':
  recheck('schematic',ROOT/'simulation/mac/schematic');recheck('baseline_extracted',ROOT/'simulation/mac/extracted')
 else:recheck('fresh_extracted',WORK/'extracted',True)
