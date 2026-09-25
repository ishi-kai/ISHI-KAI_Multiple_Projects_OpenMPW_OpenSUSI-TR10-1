"""Independent terminal/body/dimension checks and package fingerprint audit."""
from pathlib import Path
from collections import Counter
import hashlib,json,re,subprocess
import klayout.db as db
from check_full_adder_extracted import normalized
from check_half_adder_extracted import subckts
from build_submission import electrical
ROOT=Path(__file__).resolve().parents[1];OUT=ROOT/'reports/final_review'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
 defs=subckts(normalized((ROOT/'mac.extracted').read_text()));devices=[]
 def descend(name,prefix,bind):
  def node(n):return bind.get(n,prefix+'.'+n)
  for line in defs[name]['lines']:
   kind=line[-1].lower()
   if kind in defs:descend(kind,prefix+'.'+line[0],dict(zip(defs[kind]['pins'],[node(n) for n in line[1:-1]])))
   else:
    rr=line[4]=='F_RR';k=4 if rr else 5;devices.append(dict(name=prefix+'.'+line[0],model=line[k],nodes=[node(n) for n in line[1:k]],params=dict(x.split('=',1) for x in line[k+1:])))
 descend('mac','mac',{p:p for p in defs['mac']['pins']})
 count=Counter(d['model'] for d in devices);assert count=={'PMOS':59,'NMOS':59,'F_RR':46}
 bodies=[];sizes=[];input_uses={n:[] for n in ('x','a','b','cin')}
 for d in devices:
  body='VDD' if d['model'] in ('PMOS','F_RR') else 'VSS'
  if d['nodes'][-1]!=body:bodies.append(d)
  if d['model']=='F_RR':
   if d['params']['L']!='30u' or d['params']['W']!='2.8u':sizes.append(d)
  else:
   if d['params']['L']!='1u' or not 3.4<=float(d['params']['W'][:-1])<=60:sizes.append(d)
  for n in input_uses:
   for pos,net in enumerate(d['nodes']):
    if net==n:input_uses[n].append(dict(device=d['name'],terminal=pos,model=d['model']))
 assert not bodies and not sizes
 assert all(uses and all(x['terminal']==1 and x['model'] in ('NMOS','PMOS') for x in uses) for uses in input_uses.values())
 # No inferred port-name mapping: compare each actual top net's two names.
 p=json.loads((OUT/'physical.json').read_text())['mac'];assert p['sha256']==sha(ROOT/'mac.gds')
 lvs=db.LayoutVsSchematic();lvs.read(p['lvs']['report']);xref=lvs.xref();pair=next(c for c in xref.each_circuit_pair() if c.first().name.lower()=='mac')
 pin_names={pin.name() for pin in pair.first().each_pin()};mapped={}
 for pairnet in xref.each_net_pair(pair):
  if pairnet.first() and pairnet.first().name in pin_names:
   mapped[pairnet.first().name]=pairnet.second().name;assert pairnet.first().name.lower()==pairnet.second().name.lower()
 assert set(mapped)==pin_names==set(defs['mac']['pins'])
 manifest=json.loads((ROOT/'reports/submission_manifest.json').read_text());assert manifest['source_gds_sha256']==sha(ROOT/'mac.gds')
 for name,h in manifest['files'].items():assert sha(ROOT/'submission'/name)==h['sha256'],name
 assert set(manifest['files'])=={str(p.relative_to(ROOT/'submission')) for p in (ROOT/'submission').rglob('*') if p.is_file()}
 for name in ['mac','mul','mul_nand','mul_nor','mul_inv','inverter','nany','half_adder','full_adder']:
  for ext in ['.sch','.sym']:
   assert (ROOT/'submission'/(name+ext)).read_text()==(ROOT/(name+ext)).read_text().replace(str(ROOT)+'/', '')
 for what,key in [('mac','mac'),('submission/mac','submission/mac')]:
  ext=Path(json.loads((OUT/'physical.json').read_text())[key]['lvs']['extracted']);assert electrical(ext.read_text())==electrical((ROOT/'mac.extracted').read_text())
 annotations=[]
 for name in ['inverter','nany','mul_inv','mul_nand','mul_nor']:
  s=(ROOT/(name+'.sch')).read_text()
  for num,line in enumerate(s.splitlines(),1):
   if line.startswith('T {RR1 / RR2:') or line.startswith('T {R1/R2:'):
    annotations.append(dict(file=name+'.sch',line=num,text=line))
 result=dict(passed=True,gds_sha256=sha(ROOT/'mac.gds'),submitted_gds_sha256=sha(ROOT/'submission/mac.gds'),device_counts=dict(count),body_errors=bodies,size_errors=sizes,actual_RR_um=dict(W=2.8,L=30),external_inputs_gate_only={n:len(v) for n,v in input_uses.items()},top_pin_correspondence=mapped,package_manifest_and_dependencies_match=True,annotation_findings=annotations,scope='Actual extracted connectivity, every body/SUB, all device dimensions, named top-port LVS correspondence, portable package and existing manifest.')
 (OUT/'delivery.json').write_text(json.dumps(result,indent=2)+'\n');print({k:v for k,v in result.items() if k!='annotation_findings'})
if __name__=='__main__':main()
