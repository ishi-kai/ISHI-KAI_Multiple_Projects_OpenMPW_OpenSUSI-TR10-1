"""Five current extracted slices: selected ripple/add/sub/multiply-add diagnostics."""
from pathlib import Path
import itertools,json,re,time
import numpy as np
import check_mac as logic
from check_half_adder_extracted import subckts
ROOT=logic.ROOT;WORK=ROOT/'simulation/final_review/chain5';REPORT=ROOT/'reports/final_review'
def main():
 source=ROOT/'simulation/final_review/extracted/mac_extracted.spice';defs=subckts(source.read_text());pins=defs['mac']['pins']
 cases=[]
 def add(name,x,a,b):cases.append(dict(name=name,x=x,a=a,b=b))
 add('initial',[0]*5,[0]*5,1)
 for sign in (1,-1):
  for low in (-sign,0,sign,0,-sign):add(f'carry_{sign}_{low}',[sign]*5,[low,0,0,0,0],1)
 add('subtract',[1]*5,[-1]*5,-1);add('subtract_reverse',[-1]*5,[1]*5,-1)
 add('multiply',[0]*5,[1,-1,0,1,-1],-1)
 add('zero_product',[1,0,-1,0,1],[1]*5,0)
 rng=np.random.default_rng(20260925)
 for k in range(8):add('mac_'+str(k),rng.integers(-1,2,5).tolist(),rng.integers(-1,2,5).tolist(),int(rng.integers(-1,2)))
 hold=5000;edge=1;bindings=[];lines=['* Five extracted MAC slices: diagnostic, not pad/package PEX',f'.include {logic.PDK}/libs.tech/spice/models/ip62_models',f'.include "{source}"','.temp 27','.options rshunt=1e12 method=gear maxord=2 reltol=1e-3 abstol=1e-9 vntol=1e-5 trtol=10','VDD VDD 0 5','VSS VSS 0 -5','VMID VMID 0 0']
 probes=[]
 for i in range(5):
  bind=dict(VDD='VDD',VSS='VSS',VMID='VMID',x=f'x{i}',a=f'a{i}',b='b',cin='0' if i==0 else f'c{i-1}',sum=f's{i}',cout=f'c{i}',and_out=f'and{i}',or_out=f'or{i}');bindings.append(bind)
  lines.append(f'xchip{i} '+' '.join(bind[n] for n in pins)+' mac')
  for n in [f's{i}',f'c{i}',f'and{i}',f'or{i}']:lines.extend([f'Cl_{n} {n} 0 10p',f'Rl_{n} {n} 0 1meg']);probes.append(n)
  for field in ('x','a'):
   net=f'{field}{i}';points=['0 0']
   for k in range(1,len(cases)):
    points.extend([f'{hold*k}n {5*cases[k-1][field][i]}',f'{hold*k+edge}n {5*cases[k][field][i]}'])
   points.append(f'{hold*len(cases)}n {5*cases[-1][field][i]}');lines.append(f'V{net} {net} 0 PWL('+' '.join(points)+')')
 points=['0 5']
 for k in range(1,len(cases)):points.extend([f'{hold*k}n {5*cases[k-1]["b"]}',f'{hold*k+edge}n {5*cases[k]["b"]}'])
 lines.append('Vb b 0 PWL('+' '.join(points)+')')
 # Starting estimates for the all-zero internal logic; rails are supplied explicitly.
 seed=json.loads((ROOT/'simulation/final_review/extracted/operating_point.json').read_text())
 for i,bind in enumerate(bindings):
  for name,val in seed.items():
   if name.endswith('#branch'):continue
   target=name.replace('xdut.',f'xchip{i}.') if name.startswith('xdut.') else bind.get(name,bind.get(name.upper()))
   if target and target not in ('VDD','VSS','VMID','0','b') and not target.startswith(('x0','x1','x2','x3','x4','a0','a1','a2','a3','a4')):lines.append(f'.nodeset v({target})=0')
 vectors=' '.join('v('+n+')' for n in probes)
 lines+=['.control','set wr_vecnames','set wr_singlescale','set numdgt=15','op','print all',f'save {vectors}',f'tran 20n {len(cases)*hold}n 0 20n',f'wrdata data.txt {vectors}','quit','.endc','.end']
 start=time.time();logic.simulate(WORK,'\n'.join(lines)+'\n')
 data=np.loadtxt(WORK/'data.txt',skiprows=1);assert np.isfinite(data).all() and data.shape[1]==21 and data[-1,0]>=len(cases)*hold*1e-9-1e-14
 log=(WORK/'run.log').read_text();op={m[1]:float(m[2]) for m in re.finditer(r'(?m)^(\S+)\s+=\s+([-+]?\d[\d.eE+-]*)\s*$',log)};assert all(abs(v)<6 for n,v in op.items() if not n.endswith('#branch'))
 rows=[];t=data[:,0]*1e9
 for k,c in enumerate(cases):
  expected=[];carry=0;sums=[]
  for i in range(5):
   total=c['x'][i]+c['a'][i]*c['b']+carry
   s,carry=next((s,cy) for s,cy in itertools.product((-1,0,1),repeat=2) if s+3*cy==total)
   expected.extend([5*s,5*carry,5*min(c['a'][i],c['b']),5*max(c['a'][i],c['b'])]);sums.append(s)
  assert sum(3**i*(c['x'][i]+c['a'][i]*c['b']) for i in range(5))==sum(3**i*s for i,s in enumerate(sums))+3**5*carry
  end=(k+1)*hold-1;obs=np.array([np.interp(end,t,data[:,j]) for j in range(1,21)]);err=float(max(abs(obs-expected)))
  indices=np.flatnonzero((t>=k*hold+edge)&(t<=end));bad=np.flatnonzero(np.any(abs(data[indices,1:]-expected)>.5,axis=1));settle=0 if not len(bad) else None if bad[-1]==len(indices)-1 else float(t[indices[bad[-1]+1]]-k*hold-edge)
  rows.append(dict(**c,max_error_V=err,settle_ns=settle,passed=err<=.5 and settle is not None))
 result=dict(passed=all(r['passed'] for r in rows),cases=rows,states=len(rows),max_error_V=max(r['max_error_V'] for r in rows),max_settle_ns=max(r['settle_ns'] or 0 for r in rows),extracted_sha256=logic.sha(ROOT/'mac.extracted'),gds_sha256=logic.sha(ROOT/'mac.gds'),wall_s=time.time()-start,scope='Selected 5-chip equivalent chain, 27 C ideal shared rails, 10 pF || 1 Mohm per output plus next Cin gate load, 5 us hold. No wire RC/pad/package, not exhaustive.')
 (REPORT/'chain5.json').write_text(json.dumps(result,indent=2)+'\n');print({k:v for k,v in result.items() if k!='cases'},flush=True)
if __name__=='__main__':main()
