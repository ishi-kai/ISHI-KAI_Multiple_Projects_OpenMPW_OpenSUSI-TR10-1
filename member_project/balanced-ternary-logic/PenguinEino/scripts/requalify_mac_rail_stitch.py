"""Qualify four parent-FA rail bridges without claiming interconnect-RC timing."""
import copy,json,subprocess
import klayout.db as db
from networkx.algorithms.isomorphism import GraphMatcher,categorical_node_match
from requalify_mac_alignment import graph,digest
from check_half_adder_extracted import subckts
from check_full_adder_extracted import normalized
import check_mac as logic
ROOT=logic.ROOT;BASE='b3042dc'
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
 # Require exact additive geometry: only four M1 rectangles in the parent FA.
 folder=ROOT/'simulation/arithmetic_layout/rail_stitch';folder.mkdir(exist_ok=True)
 p=folder/'before.gds';p.write_bytes(prior('full_adder.gds'))
 la=db.Layout();la.read(str(p));lb=db.Layout();lb.read(str(ROOT/'full_adder.gds'));assert la.dbu==lb.dbu==.001
 ca=la.cell('full_adder');cb=lb.cell('full_adder')
 bridges=[('VSS',[563.95,89.15,600.9,105.15]),('VDD',[563.95,13.35,600.9,25.35]),('VSS',[563.95,-110.85,600.9,-94.85]),('VSS',[1260.9,-110.85,1312,-94.85])]
 added=db.Region()
 for _,coords in bridges:added.insert(db.Box(*(round(v/.001) for v in coords)))
 for info in set(la.layer_infos()+lb.layer_infos()):
  before=db.Region(ca.begin_shapes_rec(la.layer(info)));after=db.Region(cb.begin_shapes_rec(lb.layer(info)))
  expected=(before+added) if (info.layer,info.datatype)==(13,0) else before
  assert (expected^after).is_empty(),info
 proof=dict(passed=True,baseline_commit=BASE,baseline_gds_sha256=digest(prior('mac.gds')),new_gds_sha256=r['gds_sha256'],baseline_extracted_sha256=digest(prior('mac.extracted')),new_extracted_sha256=digest(raw),parameter_and_pin_exact_isomorphic_cells=sorted(a),only_added_geometry=True,bridges_FA_coordinates_um=[dict(net=n,box=c) for n,c in bridges],models_reference_rules_identical=True,transients='All existing cases inherited by exact electrical equivalence; no new transient run for these four bridges.',scope='No interconnect R/C is extracted; lower resistance and current redistribution are not quantified.')
 (ROOT/'reports/mac_alignment/rail_stitch.json').write_text(json.dumps(proof,indent=2)+'\n')
 report=copy.deepcopy(old);report.update(gds_sha256=r['gds_sha256'],extracted_sha256=digest(raw),rail_stitch_equivalence=proof)
 for case in report['cases']:case['requalified_by']='reports/mac_alignment/rail_stitch.json'
 (ROOT/'reports/mac_extracted.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS: four additive M1 bridges, all nine circuits electrically identical')
if __name__=='__main__':main()
