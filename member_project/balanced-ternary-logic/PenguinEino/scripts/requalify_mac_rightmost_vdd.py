"""Qualify rightmost lower VDD connections without claiming interconnect-RC timing."""
import copy,json,subprocess
import klayout.db as db
from networkx.algorithms.isomorphism import GraphMatcher,categorical_node_match
from requalify_mac_alignment import graph,digest
from check_half_adder_extracted import subckts
from check_full_adder_extracted import normalized
import check_mac as logic
ROOT=logic.ROOT;BASE='fb6db90'
def prior(name):return subprocess.check_output(['git','show',f'{BASE}:{name}'],cwd=ROOT)
def main():
 old=json.loads(prior('reports/mac_extracted.json'));r=json.loads((ROOT/'reports/mac_layout.json').read_text());oldlayout=json.loads(prior('reports/mac_layout.json'))
 assert r['drawing_lvs_passed'] and r['gds_sha256']==logic.sha(ROOT/'mac.gds')
 assert r['reference_sha256']==old['reference_sha256'] and r['rules_sha256']==oldlayout['rules_sha256']
 for name,h in old['model_sha256'].items():assert logic.sha(logic.PDK/name)==h
 raw=(ROOT/'mac.extracted').read_bytes();a=subckts(normalized(prior('mac.extracted').decode()));b=subckts(normalized(raw.decode()));assert set(a)==set(b)
 for name in a:
  assert set(a[name]['pins'])==set(b[name]['pins'])
  assert GraphMatcher(graph(a,name),graph(b,name),node_match=categorical_node_match('signature',None)).is_isomorphic(),name
 # All geometry changes must stay in the two VDD connection corridors and old C1 via.
 folder=ROOT/'simulation/arithmetic_layout/last_cell';folder.mkdir(exist_ok=True)
 p=folder/'before.gds';p.write_bytes(prior('full_adder.gds'))
 la=db.Layout();la.read(str(p));lb=db.Layout();lb.read(str(ROOT/'full_adder.gds'));assert la.dbu==lb.dbu==.001
 ca=la.cell('full_adder');cb=lb.cell('full_adder')
 def box(coords):return db.Region(db.Box(*(round(v/.001) for v in coords)))
 allowed=box([1260.9,13.35,1320,25.35])+box([1458.3,-35.65,1478.15,16.75])
 changes={}
 for info in set(la.layer_infos()+lb.layer_infos()):
  before=db.Region(ca.begin_shapes_rec(la.layer(info)));after=db.Region(cb.begin_shapes_rec(lb.layer(info)));delta=before^after
  if (info.layer,info.datatype) in [(13,0),(19,0),(20,0)]:assert (delta-allowed).is_empty(),info
  else:assert delta.is_empty(),info
  if not delta.is_empty():changes[str(info)]=delta.area()*.001**2
 m1=db.Region(cb.begin_shapes_rec(lb.layer(13,0)));vias=db.Region(cb.begin_shapes_rec(lb.layer(19,0)))
 assert (box([1260.9,13.35,1320,25.35])-m1).is_empty()
 for bounds in [[1458.3,13.35,1466.1,16.75],[1462.7,-35.65,1466.1,16.75],[1462.7,-35.65,1478.15,-32.25]]:assert (box(bounds)-m1).is_empty()
 assert (vias&box([1307.75,21.65,1309.15,23.05])).is_empty()
 proof=dict(passed=True,baseline_commit=BASE,baseline_gds_sha256=digest(prior('mac.gds')),new_gds_sha256=r['gds_sha256'],baseline_extracted_sha256=digest(prior('mac.extracted')),new_extracted_sha256=digest(raw),parameter_and_pin_exact_isomorphic_cells=sorted(a),changed_area_um2=changes,changes='Bridge HA2 VDD to merge NANY; connect NANY VDD to output INV; remove redundant C1 via at FA (1308.45,22.35) and continue M2',models_reference_rules_identical=True,transients='All existing cases inherited by exact electrical equivalence; no new transient run for these VDD connections.',scope='No interconnect R/C is extracted; lower resistance and current redistribution are not quantified.')
 (ROOT/'reports/mac_alignment/rightmost_vdd.json').write_text(json.dumps(proof,indent=2)+'\n')
 report=copy.deepcopy(old);report.update(gds_sha256=r['gds_sha256'],extracted_sha256=digest(raw),rightmost_vdd_equivalence=proof)
 for case in report['cases']:case['requalified_by']='reports/mac_alignment/rightmost_vdd.json'
 (ROOT/'reports/mac_extracted.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS: rightmost VDD connections and removed C1 via, all nine circuits electrically identical')
if __name__=='__main__':main()
