"""Verify pin-labelled, parameter-exact netlist isomorphism and rerun the native TB."""
from pathlib import Path
import copy,hashlib,json,subprocess
import networkx as nx
from networkx.algorithms.isomorphism import GraphMatcher,categorical_node_match
import klayout.db as db
import check_mac as logic
import check_mac_extracted as ex
from check_half_adder_extracted import subckts
import verify_arithmetic_layout as verify
ROOT=logic.ROOT;BASELINE='2919b60'
def prior(name):return subprocess.check_output(['git','show',f'{BASELINE}:{name}'],cwd=ROOT)
def digest(b):return hashlib.sha256(b).hexdigest()
def graph(defs,name):
 c=defs[name];g=nx.Graph();pins=set(c['pins'])
 def net(n):
  node=('net',n);g.add_node(node,signature=('net',n if n in pins else 'internal'));return node
 for n in pins:net(n)
 for i,line in enumerate(c['lines']):
  if line[-1].lower() in defs:
   kind=line[-1].lower();nodes=line[1:-1];roles=defs[kind]['pins'];sig=('subckt',kind)
  elif len(line)>5 and line[5] in ('NMOS','PMOS'):
   nodes=line[1:5];roles=['D','G','S','B'];sig=('device',line[5],tuple(sorted(line[6:])))
  elif len(line)>4 and line[4]=='F_RR':
   nodes=line[1:4];roles=['1','2','SUB'];sig=('device','F_RR',tuple(sorted(line[5:])))
  else:raise ValueError(line)
  assert len(nodes)==len(roles)
  dev=('device',i);g.add_node(dev,signature=sig)
  for j,(n,role) in enumerate(zip(nodes,roles)):
   terminal=('terminal',i,j);g.add_node(terminal,signature=('terminal',role));g.add_edge(dev,terminal);g.add_edge(terminal,net(n))
 return g

def main():
 oldraw=prior('mac.extracted');raw=(ROOT/'mac.extracted').read_bytes()
 old=json.loads(prior('reports/mac_extracted.json'));oldlayout=json.loads(prior('reports/mac_layout.json'))
 layout=json.loads((ROOT/'reports/mac_layout.json').read_text())
 assert old['passed'] and digest(oldraw)==old['extracted_sha256']
 assert layout['drawing_lvs_passed'] and layout['gds_sha256']==logic.sha(ROOT/'mac.gds')
 assert layout['reference_sha256']==old['reference_sha256']==logic.sha(verify.reference('mac'))
 assert layout['rules_sha256']==oldlayout['rules_sha256']
 models={str(p.relative_to(logic.PDK)):logic.sha(p) for p in (logic.PDK/'libs.tech/spice/models').rglob('*') if p.is_file()};assert models==old['model_sha256']
 a=subckts(ex.normalized(oldraw.decode()));b=subckts(ex.normalized(raw.decode()));assert set(a)==set(b)
 cells={}
 for name in a:
  assert set(a[name]['pins'])==set(b[name]['pins'])
  ga=graph(a,name);gb=graph(b,name);matcher=GraphMatcher(ga,gb,node_match=categorical_node_match('signature',None));assert matcher.is_isomorphic(),name
  cells[name]=dict(passed=True,graph_nodes=ga.number_of_nodes(),graph_edges=ga.number_of_edges(),ports=a[name]['pins'])
 # Also require unchanged local primitive/HA geometry: only macro routing/placement moves.
 oldg=ROOT/'layout/backups/mac_alignment/mac.gds';assert logic.sha(oldg)==digest(prior('mac.gds'))
 la=db.Layout();la.read(str(oldg));lb=db.Layout();lb.read(str(ROOT/'mac.gds'))
 unchanged=['inverter','nany','mul_inv','mul_nor','mul_nand','half_adder']
 for name in unchanged:
  for spec in {(i.layer,i.datatype) for l in (la,lb) for i in l.layer_infos()}:
   ra=db.Region(la.cell(name).begin_shapes_rec(la.layer(*spec)));rb=db.Region(lb.cell(name).begin_shapes_rec(lb.layer(*spec)));assert (ra^rb).is_empty(),(name,spec)
 proof=dict(passed=True,baseline_commit=BASELINE,baseline_gds_sha256=digest(prior('mac.gds')),new_gds_sha256=logic.sha(ROOT/'mac.gds'),baseline_extracted_sha256=digest(oldraw),new_extracted_sha256=digest(raw),baseline_report_sha256=digest(prior('reports/mac_extracted.json')),pin_labelled_parameter_exact_isomorphism=cells,unchanged_local_geometry=unchanged,models_reference_rules_identical=True,comparison='All formal port names, device terminal roles, model names and every literal parameter value match; anonymous net/instance names and instance coordinates may differ.',limitation='No interconnect RC in either extraction. No timing improvement is claimed.')
 print('PASS: all nine circuits are parameter-exact and pin-labelled isomorphic',flush=True)
 out=ROOT/'reports/mac_alignment';out.mkdir(exist_ok=True)
 (out/'electrical_equivalence.json').write_text(json.dumps(proof,indent=2)+'\n')
 # A separate folder preserves the previously qualified exhaustive run artifacts.
 ex.WORK=ROOT/'simulation/mac/alignment_extracted';base,_,_=ex.prepare();logic.REUSE_VALIDATED=False
 native=logic.native(base,ex.WORK);assert native['passed'];print(native,flush=True)
 proof['rerun']='81 inputs plus return, fresh extracted circuit, 10 pF || 1 Mohm, 1 us hold'
 proof['fresh_native']=native;proof['reused']='6480 and 648 transitions from the proven equivalent baseline circuit'
 assert logic.sha(ROOT/'mac.gds')==layout['gds_sha256']
 report=copy.deepcopy(old)
 for key in ('power_join_equivalence','power_placement_equivalence','relayout_equivalence'):report.pop(key,None)
 report.update(gds_sha256=layout['gds_sha256'],extracted_sha256=digest(raw),cases=[native]+copy.deepcopy(old['cases'][1:]),alignment_equivalence=proof)
 for case in report['cases'][1:]:case['requalified_by']='reports/mac_alignment/electrical_equivalence.json'
 (out/'electrical_equivalence.json').write_text(json.dumps(proof,indent=2)+'\n')
 (ROOT/'reports/mac_extracted.json').write_text(json.dumps(report,indent=2)+'\n')
if __name__=='__main__':main()
