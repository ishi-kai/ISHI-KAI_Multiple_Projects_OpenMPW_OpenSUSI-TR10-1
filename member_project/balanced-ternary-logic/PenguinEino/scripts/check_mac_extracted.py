"""Verify the device network extracted from the strictly LVS-qualified MAC GDS."""
from pathlib import Path
import json,re
import klayout.db as db
import check_mac as logic
import verify_arithmetic_layout as verify
from check_full_adder_extracted import normalized
from check_half_adder_extracted import subckts
ROOT=logic.ROOT;WORK=ROOT/'simulation/mac/extracted'

def lvs_mapping(report,defs):
 """Use the fresh strict-LVS cross-reference, including every primitive node."""
 comparison=db.LayoutVsSchematic();comparison.read(report['lvs']['report'])
 xref=comparison.xref();pairs={p.first().name.lower():p for p in xref.each_circuit_pair()}
 mapping={}
 def walk(kind,old,new,old_bind,new_bind):
  pair=pairs[kind]
  def resolve(net,prefix,bindings):return bindings.get(net.name.lower(),prefix+'.'+net.name.lower().replace('$','n_ex_'))
  for p in xref.each_net_pair(pair):
   assert p.first() and p.second()
   a=resolve(p.second(),old,old_bind);b=resolve(p.first(),new,new_bind)
   if a in mapping:assert mapping[a]==b,(a,b,mapping[a])
   mapping[a]=b
  for p in xref.each_subcircuit_pair(pair):
   a,b=p.first(),p.second()
   ab={pin.name().lower():resolve(a.net_for_pin(pin.id()),new,new_bind) for pin in a.circuit_ref().each_pin()}
   bb={pin.name().lower():resolve(b.net_for_pin(pin.id()),old,old_bind) for pin in b.circuit_ref().each_pin()}
   # LVS database serialization may renumber anonymous instance IDs. Match
   # the exported SPICE instance by its full named pin connectivity instead.
   child=a.circuit_ref().name.lower()
   wanted={pin.name().lower():a.net_for_pin(pin.id()).name.lower().replace('$','n_ex_') for pin in a.circuit_ref().each_pin()}
   hits=[]
   for line in defs[kind]['lines']:
    if line[-1].lower()!=child:continue
    def decode(n):return re.sub(r'\\x([0-9a-fA-F]{2})',lambda m:chr(int(m[1],16)),n.lower())
    actual=dict(zip((decode(n) for n in defs[child]['pins']),(decode(n) for n in line[1:-1])))
    if actual==wanted:hits.append(line[0].lower())
   assert len(hits)==1,(kind,child,wanted,hits)
   walk(child,old+'.x'+b.name.lower(),new+'.'+hits[0],bb,ab)
 pins={pin.name().lower():pin.name().lower() for pin in pairs['mac'].first().each_pin()}
 walk('mac','xdut','xdut',pins,pins)
 return mapping

def prepare():
 WORK.mkdir(parents=True,exist_ok=True)
 report=json.loads((ROOT/'reports/mac_layout.json').read_text())
 assert report['drawing_lvs_passed'] and report['gds_sha256']==logic.sha(ROOT/'mac.gds')
 assert report['reference_sha256']==logic.sha(verify.reference('mac'))
 for name,digest in report['rules_sha256'].items():assert logic.sha(verify.PDK/name)==digest,name
 raw=(ROOT/'mac.extracted').read_text();assert raw==Path(report['lvs']['extracted']).read_text()
 extracted=normalized(raw);defs=subckts(extracted)
 assert set(defs)=={'mac','mul','mul_nand','mul_nor','mul_inv','full_adder','half_adder','nany','inverter'}
 assert set(defs['mac']['pins'])=={'x','a','b','cin','sum','cout','VDD','VSS','VMID','and_out','or_out'}
 def instances(kind):
  return [dict(name=l[0].lower(),kind=l[-1].lower(),pins=dict(zip(defs[l[-1].lower()]['pins'],l[1:-1]))) for l in defs[kind]['lines'] if l[-1].lower() in defs]
 def find(rows,kind,**pins):
  hit=[r for r in rows if r['kind']==kind and all(r['pins'][k]==v for k,v in pins.items())];assert len(hit)==1,(kind,pins,hit)
  return hit[0]
 mac=instances('mac');fa=find(mac,'full_adder',a='x',cin='cin');mul=find(mac,'mul',a='a',b='b');assert fa['pins']['b']==mul['pins']['p']
 mapping=lvs_mapping(report,defs)
 find(mac,'inverter',vin=mul['pins']['t1'],vout='and_out')
 o1=find(mac,'inverter',vin=mul['pins']['t3'])
 find(mac,'inverter',vin=o1['pins']['vout'],vout='or_out')
 children=instances('mul');t1=find(children,'mul_nand',a='a',b='b');t2=find(children,'mul_nor',a='a',b='b');t3=find(children,'mul_inv',vin=t2['pins']['vout'])
 for n,i in [('t2',t2)]:mapping['xdut.x_mul.'+n]=f'xdut.{mul["name"]}.'+i['pins']['vout']
 base=logic.netlist()
 # A coarse generic seed can find an unphysical model branch (hundreds of V).
 # Solve the fresh schematic OP, then use its corresponding nodes only as
 # Newton starting estimates; do not clamp nodes or skip the extracted OP.
 op=re.sub(r'\.control.*?\.endc','.control\nset numdgt=15\nop\nprint all\nquit\n.endc',base,flags=re.S)
 log=logic.simulate(WORK/'schematic_op_seed',op)
 vals={m[1].lower():float(m[2]) for m in re.finditer(r'(?m)^(\S+)\s+=\s+([-+]?\d[\d.eE+-]*)\s*$',log)}
 assert vals and all(abs(v)<6 for k,v in vals.items() if not k.endswith('#branch'))
 assert abs(vals['sum']+5)<.5 and abs(vals['cout'])<.5
 seeds=[]
 for old,new in mapping.items():
  assert old in vals,old
  seeds.append(f'.nodeset v({old})={vals[old]:.12g}')
 base=re.sub(r'(?m)^\.nodeset[^\n]*','',base).replace('.control','\n'.join(seeds)+'\n.control')
 base=re.sub(r'^\.subckt\s+.*?^\.ends\b[^\n]*','',base,flags=re.M|re.S|re.I)
 base=re.sub(r'^xdut .*$', 'xdut '+' '.join(defs['mac']['pins'])+' mac',base,flags=re.M|re.I)
 def remap(m):
  n=m[1]
  if n.startswith('xdut.'):assert n in mapping,('Unmapped node',n)
  return 'v('+mapping.get(n,n)+')'
 base=re.sub(r'v\(([^)]+)\)',remap,base,flags=re.I)
 include=WORK/'mac_extracted.spice';include.write_text(extracted+'\n')
 base=re.sub(r'^\.end\s*$',lambda _:f'.include "{include}"\n.end',base,flags=re.M|re.I)
 # Reject a formally converged but nonphysical extracted operating point.
 op=re.sub(r'\.control.*?\.endc','.control\nset numdgt=15\nop\nprint all\nquit\n.endc',base,flags=re.S)
 oplog=logic.simulate(WORK/'extracted_op_check',op)
 assert 'Nodeset on non-existent node' not in oplog
 opvals={m[1].lower():float(m[2]) for m in re.finditer(r'(?m)^(\S+)\s+=\s+([-+]?\d[\d.eE+-]*)\s*$',oplog)}
 assert opvals and all(abs(v)<6 for k,v in opvals.items() if not k.endswith('#branch'))
 assert set(mapping.values())<=set(opvals),'A mapped extraction node does not exist'
 for n,target in [('sum',-5),('cout',0),(mapping['xdut.p'],5)]:assert abs(opvals[n]-target)<.5,(n,opvals[n])
 (WORK/'operating_point.json').write_text(json.dumps(opvals,indent=2)+'\n')
 (WORK/'node_mapping.json').write_text(json.dumps(mapping,indent=2)+'\n');(WORK/'extracted_tb.spice').write_text(base)
 logic.VECTORS=' '.join(f'v({mapping.get(n,n)})' for n in logic.PROBES)
 return base,report,raw

def exhaustive_parallel(base):
 return logic.exhaustive_parallel(base,WORK)

def main():
 base,layout,raw=prepare();rows=[logic.native(base,WORK)];print(rows[0],flush=True)
 rows.append(exhaustive_parallel(base));print(rows[-1],flush=True)
 rows.append(logic.transitions(base,WORK,10000,True));print(rows[-1],flush=True)
 r=dict(passed=all(x['passed'] for x in rows),scope='LVS-extracted MOS/RR network with device geometry and intrinsic PDK capacitances. No interconnect RC.',
  gds_sha256=layout['gds_sha256'],extracted_sha256=logic.sha(ROOT/'mac.extracted'),reference_sha256=layout['reference_sha256'],temperature_C=27,supplies_V=[-5,0,5],tolerance_V=.5,cases=rows,
  model_sha256={str(p.relative_to(verify.PDK)):logic.sha(p) for p in (verify.PDK/'libs.tech/spice/models').rglob('*') if p.is_file()})
 assert logic.sha(ROOT/'mac.gds')==r['gds_sha256']
 (ROOT/'reports/mac_extracted.json').write_text(json.dumps(r,indent=2)+'\n')
 if not r['passed']:raise RuntimeError('Extracted MAC failed')
if __name__=='__main__':
 import argparse
 p=argparse.ArgumentParser();p.add_argument('--resume',action='store_true',help='Reuse completed runs only when their exact SPICE deck matches; re-evaluate saved waveforms.');a=p.parse_args();logic.REUSE_VALIDATED=a.resume;main()
