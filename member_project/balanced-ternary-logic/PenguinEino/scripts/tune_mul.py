"""Bounded MUL sizing search using the actual generated four-gate netlist.
Dimensions [NAND Wp,Wn,RR L, NOR Wp,Wn,RR L, INV Wp,Wn,RR L] in um.
All MOS L=1um, RR W=2.8um. Area proxy excludes contacts/wells/routing.
"""
from concurrent.futures import ThreadPoolExecutor
import itertools,json
from check_mul import ROOT,WORK,BASELINE,prepare,run,area

def valid(cfg):
 return all(v>= (13 if i%3==2 else 3.4) for i,v in enumerate(cfg))
def good(r):return r.get('error_V',999)<=.25 and r.get('bands_V',{}).get('1.0',999)<=.4

def main():
 base=prepare();seen={};outdir=WORK/'tuning';outdir.mkdir(exist_ok=True)
 def screen(cfg):
  try:r=run(base,cfg)
  except RuntimeError as e:r=dict(cfg=list(cfg),area_proxy_um2=area(cfg),error_V=999,rejected=str(e))
  return r
 def batch(cfgs):
  cfgs=sorted(set(tuple(c) for c in cfgs if valid(c))-set(seen))
  with ThreadPoolExecutor(max_workers=4) as pool:
   for c,r in zip(cfgs,pool.map(screen,cfgs)):seen[c]=r
  (outdir/'dc_candidates.json').write_text(json.dumps(list(seen.values()),indent=2)+'\n')
  print('Screened',len(seen),'passing',sum(good(r) for r in seen.values()),flush=True)
 def dimensions(sn,sr,si,rl):
  c=[]
  for i,scale in enumerate((sn,sr,si)):
   c += [max(3.4,round(BASELINE[3*i]*scale*2)/2),max(3.4,round(BASELINE[3*i+1]*scale*2)/2),BASELINE[3*i+2] if rl==0 else rl]
  return c
 cfgs=[dimensions(*j) for j in itertools.product((.4,.6,.8,1.),(.4,.6,.8,1.),(.7,1.),(13,15,0))]+[BASELINE]
 batch(cfgs)
 seeds=sorted([r for r in seen.values() if good(r)],key=lambda r:r['area_proxy_um2'])[:5]
 if not seeds:raise RuntimeError('No candidate meets DC requirements')
 # Perturb ratios and each resistor length around compact valid points.
 local=[]
 for seed in seeds:
  for i in range(9):
   for f in (.8,1.2):
    c=seed['cfg'].copy();c[i]=round(c[i]*f*2)/2 if i%3!=2 else max(13,round(c[i]+(-1 if f<1 else 1)))
    local.append(c)
 batch(local)
 dcgood=[r for r in seen.values() if good(r)]
 short=sorted(dcgood,key=lambda r:r['area_proxy_um2'])[:8]
 for r in sorted([r for r in dcgood if r['area_proxy_um2']<area(BASELINE)],key=lambda r:r['bands_V']['1.0'])[:3]:
  if r not in short:short.append(r)
 if tuple(BASELINE) not in [tuple(r['cfg']) for r in short]:short.append(seen[tuple(BASELINE)])
 def transient(r):
  try:r['timing']=run(base,r['cfg'],'tran')
  except RuntimeError as e:r['timing']=dict(unsettled=72,rejected=str(e))
  return r
 with ThreadPoolExecutor(max_workers=3) as pool:short=list(pool.map(transient,short))
 (outdir/'shortlist.json').write_text(json.dumps(short,indent=2)+'\n')
 for r in short:
  t=r['timing'];print(r['cfg'],'area',r['area_proxy_um2'],'nom',r['error_V'],'band1',r['bands_V']['1.0'],'settle',t.get('settle_ns'),'rise/fall',t.get('rise_ns'),t.get('fall_ns'),'unsettled',t['unsettled'],flush=True)
 # Do not automatically mutate the schematic. Selection is recorded after review.
if __name__=='__main__':main()
