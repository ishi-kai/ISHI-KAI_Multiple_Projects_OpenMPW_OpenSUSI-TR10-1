"""Re-netlist current schematics and run a reproducible bounded circuit review.
python3 scripts/review_circuits.py; results and runnable SPICE TBs: simulation/review/.
No circuit geometry is changed. Embedded caps are preserved; external load is explicit.
"""
from pathlib import Path
import subprocess,re,json,itertools,hashlib
from concurrent.futures import ThreadPoolExecutor
import numpy as np
ROOT=Path(__file__).resolve().parents[1]; WORK=ROOT/'simulation/review';WORK.mkdir(parents=True,exist_ok=True)
MODEL='/home/ishi-kai/pdk/TR-1um/libs.tech/spice/models/ip62_models'
GATES=['inverter','nand','nor','nsign']; CELLS={}; SEEDS={}; META={}
def netlist(name):
 d=WORK/'netlists'/name;d.mkdir(parents=True,exist_ok=True)
 cmd=['xschem','-r','-x','--rcfile',str(ROOT/'simulation/verify.xschemrc'),'-s','--command','xschem netlist; puts [xschem get infowindow_text]; exit','-o',str(d),str(ROOT/(name+'.sch'))]
 q=subprocess.run(cmd,capture_output=True,text=True);(d/'netlist.log').write_text(q.stdout+q.stderr)
 if q.returncode or 'Error:' in q.stdout+q.stderr:raise RuntimeError(name+': '+q.stdout+q.stderr)
 return (d/(name+'.spice')).read_text()
def prepare():
 for g in GATES:
  raw=netlist(g);body=[];seed={}
  for line in raw.splitlines():
   if line.startswith(('X','C')):
    body.append(line)
    x=line.split()
    if line.startswith('X') and x[5] in ('PMOS','NMOS'):
     val=5 if x[5]=='PMOS' else -5
     for n in [x[1],x[3]]:
      if n.startswith('net'):seed.setdefault(n,set()).add(val)
  CELLS[g]='.subckt '+g+(' vin y vp vn\n' if g=='inverter' else ' a b y vp vn vzero\n' if g=='nsign' else ' a b y vp vn\n')+'\n'.join(re.sub(r'(?<!\S)(vout|V\+|V-|V0|VDD|VSS|VMID)(?!\S)',lambda m:{'vout':'y','V+':'vp','V-':'vn','V0':'vzero','VDD':'vp','VSS':'vn','VMID':'vzero'}[m[0]],s) for s in body)+'\n.ends\n'
  SEEDS[g]={n:list(v)[0] if len(v)==1 else 0 for n,v in seed.items()}
  META[g]={'sha256':hashlib.sha256((ROOT/(g+'.sch')).read_bytes()).hexdigest(),'devices':body,'embedded_caps':[s for s in body if s.startswith('C')]}
  (WORK/(g+'_snapshot.sch')).write_text((ROOT/(g+'.sch')).read_text())
 for g in GATES:
  raw=netlist(g+'_tb');cell=re.search(r'^\.subckt '+g+r' .*?^\.ends',raw,re.M|re.S)
  if not cell:raise RuntimeError(g+' TB does not instantiate its cell')
  dev=[l for l in cell[0].splitlines() if l.startswith('X')]
  def sig(lines):return sorted((x.split()[0], ' '.join(x.split()[5:])) for x in lines if x.startswith('X'))
  META[g]['tb_device_parameters_match']=sig(dev)==sig(META[g]['devices'])
  source={x.split()[0]:x.split() for x in META[g]['devices'] if x.startswith('X')}
  target={x.split()[0]:x.split() for x in dev}
  mapping={n:n for n in ['vin','a','b','vout','V+','V-','V0','VDD','VSS','VMID','GND']};ok=source.keys()==target.keys()
  for name,x in source.items():
   if name not in target:continue
   pin_count=3 if x[4]=='F_RR' else 4
   for n,m in zip(x[1:1+pin_count],target[name][1:1+pin_count]):
    if n in mapping and mapping[n]!=m:ok=False
    if n not in mapping and m in mapping.values():ok=False
    mapping[n]=m
  META[g]['tb_topology_match']=ok
 (WORK/'manifest.json').write_text(json.dumps(META,indent=2))
def expected(g,s):
 if g=='inverter':return -s[0]
 if g=='nand':return -min(s)
 if g=='nor':return -max(s)
 return -float(np.sign(sum(s)))
def states(g):return list(itertools.product([-1,0,1],repeat=1 if g=='inverter' else 2))
def inst(g,name,inputs,out):return f'X{name} '+ ' '.join(inputs)+f' {out} vp vn '+('0 ' if g=='nsign' else '')+g
def run(label,body,commands,v=5,temp=27):
 d=WORK/label;d.mkdir(exist_ok=True)
 g,lines=body
 guesses=[]
 for line in lines.splitlines():
  x=line.split()
  if x and x[0].startswith('X') and x[-1] in GATES:
   guesses.extend(f'v({x[0].lower()}.{n})={val*v/5}' for n,val in SEEDS[x[-1]].items())
   guesses.append(f'v({x[2] if x[-1]=="inverter" else x[3]})=0')
 seeds=' '.join(guesses) if g=='chain' else ' '.join(f'v(xdut.{n})={val*v/5}' for n,val in SEEDS[g].items())
 text=f'Review {label}\n.include {MODEL}\n'+''.join(CELLS.values())+f'\nVDD vp 0 {v}\nVSS vn 0 {-v}\n'+lines+f'\n.temp {temp}\n.options rshunt=1e12\n.nodeset v(y)=0 {seeds}\n.control\nset wr_singlescale\nset wr_vecnames\nsave all\n'+commands+'\nquit\n.endc\n.GLOBAL GND\n.end\n'
 (d/'tb.spice').write_text(text)
 if 'tran ' in commands:
  vectors=commands.split('wrdata data.txt ',1)[1].splitlines()[0]
  (d/'view.spice').write_text(text.replace('\nquit\n',f'\nplot {vectors}\n'))
 p=subprocess.run(['ngspice','-b','tb.spice'],cwd=d,capture_output=True,text=True,timeout=240)
 (d/'run.log').write_text(p.stdout+p.stderr)
 if p.returncode or re.search(r'Error:|failed|Timestep too small',p.stdout+p.stderr,re.I):raise RuntimeError(label+' simulation failed; inspect log')
 a=np.loadtxt(d/'data.txt',skiprows=1)
 if not np.isfinite(a).all() or np.max(abs(a[:,1:]))>v+2:raise RuntimeError(label+' nonphysical numerical root')
 return a

def dc(job):
 g,temp,v=job
 body=inst(g,'dut',['a'] if g=='inverter' else ['a','b'],'y')+'\nVA a 0 0\nVB b 0 0'
 step=.125
 cmd=f'dc VA {-v} {v} {step}'+('' if g=='inverter' else f' VB {-v} {v} {step}')+'\nwrdata data.txt v(a) v(b) v(y)'
 d=run(f'{g}_dc_{temp}_{v}',(g,body),cmd,v,temp);a,b,y=d[:,1],d[:,2],d[:,3]
 bands={};nom=[];details=[]
 for state in states(g):
  dist=abs(a-state[0]*v)
  if len(state)==2:dist=np.maximum(dist,abs(b-state[1]*v))
  idx=np.argmin(dist);target=expected(g,state)*v;nom.append(float(y[idx]));detail={'state':state,'nominal':float(y[idx])}
  for radius in [.25,.5,1]:
   mask=dist<=radius+1e-8;err=abs(y[mask]-target);key=str(radius);bands[key]=max(bands.get(key,0),float(max(err)));detail[key]=float(max(err))
  details.append(detail)
 return dict(gate=g,temp=temp,supply=v,nominal=nom,nominal_error=max(abs(q['nominal']-expected(g,q['state'])*v) for q in details),bands=bands,details=details)
def route(n):
 adj={i:[j for j in range(n) if j!=i] for i in range(n)};st=[0];out=[]
 while st:
  if adj[st[-1]]:st.append(adj[st[-1]].pop())
  else:out.append(st.pop())
 return out[::-1]
def transient(job):
 g,mode=job;ss=states(g);rr=route(len(ss));hold=100;skew=2 if mode=='skew_b_late' else -2 if mode=='skew_a_late' else 0
 lines=[inst(g,'dut',['a'] if g=='inverter' else ['a','b'],'y')]
 for col,node in enumerate(['a'] if g=='inverter' else ['a','b']):
  pts=[f'0 {ss[rr[0]][col]*5}']
  for k in range(1,len(rr)):
   edge=k*hold+(abs(skew) if (skew>0 and col==1) or (skew<0 and col==0) else 0)
   pts.extend([f'{edge}n {ss[rr[k-1]][col]*5}',f'{edge+1}n {ss[rr[k]][col]*5}'])
  lines.append(f'V{node} {node} 0 PWL('+' '.join(pts)+')')
 basecap=10 if META[g]['embedded_caps'] else 0
 ext=(100 if mode=='100f' else 10)-basecap
 if ext:lines.append(f'Cexternal y 0 {ext}f')
 outs=[]
 if mode=='fanout4':
  for j,h in enumerate(GATES):
   ins=['y'] if h=='inverter' else ['y','vp' if h=='nand' else 'vn' if h=='nor' else '0']
   lines.append(inst(h,'load'+str(j),ins,'load'+str(j)));outs.append('load'+str(j))
   lines.append(f'Cl{j} load{j} 0 10f')
 d=run(f'{g}_tran_{mode}',(g,'\n'.join(lines)),f'tran 0.2n {len(rr)*hold}n\nwrdata data.txt v(a) '+('v(b) ' if g!='inverter' else '')+'v(y) '+' '.join('v('+o+')' for o in outs))
 t=d[:,0]*1e9;yi=2 if g=='inverter' else 3;y=d[:,yi];rec=[]
 for k in range(1,len(rr)):
  old=expected(g,ss[rr[k-1]])*5;new=expected(g,ss[rr[k]])*5;end=(k+1)*hold-1;start=k*hold;edge_end=start+1+abs(skew)
  sel=(t>=edge_end)&(t<=end);tt=t[sel];yy=y[sel];bad=np.flatnonzero(abs(yy-new)>.5)
  settling=0 if not len(bad) else float(tt[bad[-1]+1]-edge_end) if bad[-1]<len(tt)-1 else None
  final=float(np.interp(end,t,y));r={'from':ss[rr[k-1]],'to':ss[rr[k]],'error':abs(final-new),'settle_ns':settling}
  if old==new:
   m=(t>=start)&(t<=end);r['same_output_glitch_V']=float(max(abs(y[m]-new)))
  if outs:r['receiver_error']=max(abs(float(np.interp(end,t,d[:,yi+1+j]))+new) for j in range(4))
  rec.append(r)
 return dict(gate=g,mode=mode,count=len(rec),max_error=max(q['error'] for q in rec),max_settle_ns=max((q['settle_ns'] for q in rec if q['settle_ns'] is not None),default=0),unsettled=sum(q['settle_ns'] is None for q in rec),max_same_output_glitch=max((q.get('same_output_glitch_V',0) for q in rec),default=0),max_receiver_error=max((q.get('receiver_error',0) for q in rec),default=0),transitions=rec)
def chain(temp=27):
 sequence=[-5,0,5,0,-5,5,-5,-1,-.5,-.2,0,.2,.5,1,0]
 pts=['0 -5']
 for k,v in enumerate(sequence):
  if k:pts.append(f'{k*200+1}n {v}')
  pts.append(f'{(k+1)*200}n {v}')
 lines=['VA a 0 PWL('+' '.join(pts)+')']
 kinds=['inverter','nand','nor','nsign','inverter','nsign']
 for i,g in enumerate(kinds):
  previous='a' if i==0 else 's'+str(i)
  ins=[previous] if g=='inverter' else [previous,'vp' if g=='nand' else 'vn' if g=='nor' else '0']
  lines.append(inst(g,'stage'+str(i+1),ins,'s'+str(i+1)))
 lines.append('Cfinal s6 0 10f')
 d=run(f'mixed_chain_{temp}',('chain','\n'.join(lines)),f'tran 0.2n {len(sequence)*200}n\nwrdata data.txt v(a) '+' '.join(f'v(s{i})' for i in range(1,7)),temp=temp)
 rows=[]
 for k,v in enumerate(sequence):
  ideal=0 if abs(v)<=1 else v
  outputs=[float(np.interp(((k+1)*200-1)*1e-9,d[:,0],d[:,i+1])) for i in range(1,7)]
  rows.append(dict(input=v,outputs=outputs,max_error=max(abs(y-ideal*(-1)**(i+1)) for i,y in enumerate(outputs))))
 return dict(temp=temp,gates=kinds,samples=rows,max_error=max(r['max_error'] for r in rows))

def summarize():
 dcrows=json.loads((WORK/'dc.json').read_text());trans=json.loads((WORK/'transient.json').read_text());chains=json.loads((WORK/'chain.json').read_text())
 summary={
  'dc_conditions':len(dcrows),'transient_conditions':len(trans),'directed_transitions':sum(x['count'] for x in trans),
  'dc_nominal_pass':all(x['nominal_error']<=.5 for x in dcrows),
  'dc_half_volt_band_pass':all(x['bands']['0.5']<=.5 for x in dcrows),
  'transient_settled_pass':all(x['max_error']<=.5 and x['unsettled']==0 and x['max_receiver_error']<=.5 for x in trans),
  'chain_sampled_pass':all(x['max_error']<=.5 for x in chains),
  'source_unchanged':all(hashlib.sha256((ROOT/(g+'.sch')).read_bytes()).hexdigest()==META[g]['sha256'] for g in GATES)
 }
 (WORK/'summary.json').write_text(json.dumps(summary,indent=2));print(json.dumps(summary,indent=2),flush=True)
 return summary

def main():
 prepare()
 with ThreadPoolExecutor(max_workers=4) as pool:
  dcrows=list(pool.map(dc,[(g,t,v) for g in GATES for t in [0,27,85] for v in [4.5,5,5.5]]))
 (WORK/'dc.json').write_text(json.dumps(dcrows,indent=2));print('DC complete',flush=True)
 jobs=[(g,m) for g in GATES for m in ['10f','100f','fanout4']+([] if g=='inverter' else ['skew_b_late','skew_a_late'])]
 with ThreadPoolExecutor(max_workers=4) as pool:
  rows=[]
  for r in pool.map(transient,jobs):rows.append(r);print(r['gate'],r['mode'],r['max_error'],r['max_settle_ns'],flush=True);(WORK/'transient.json').write_text(json.dumps(rows,indent=2))
 (WORK/'chain.json').write_text(json.dumps([chain(27),chain(85)],indent=2))
 summarize()
if __name__=='__main__':main()
