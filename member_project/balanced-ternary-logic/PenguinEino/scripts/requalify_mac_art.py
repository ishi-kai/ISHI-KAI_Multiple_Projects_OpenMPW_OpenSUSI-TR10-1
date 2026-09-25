"""Verify artwork/routing electrical equivalence and run the native extracted TB."""
import copy,json,subprocess
import klayout.db as db
from networkx.algorithms.isomorphism import GraphMatcher,categorical_node_match
from requalify_mac_alignment import graph,digest
from check_half_adder_extracted import subckts
from check_full_adder_extracted import normalized
import check_mac as logic
import check_mac_extracted as ex
ROOT=logic.ROOT;BASE='a15d63a'
def prior(path):return subprocess.check_output(['git','show',f'{BASE}:{path}'],cwd=ROOT)
def main():
 old=json.loads(prior('reports/mac_extracted.json'));r=json.loads((ROOT/'reports/mac_layout.json').read_text());oldlayout=json.loads(prior('reports/mac_layout.json'))
 assert r['drawing_lvs_passed'] and r['gds_sha256']==logic.sha(ROOT/'mac.gds')
 assert r['reference_sha256']==old['reference_sha256'] and r['rules_sha256']==oldlayout['rules_sha256']
 assert all(logic.sha(logic.PDK/p)==h for p,h in old['model_sha256'].items())
 a=subckts(normalized(prior('mac.extracted').decode()));b=subckts(normalized((ROOT/'mac.extracted').read_text()));assert set(a)==set(b)
 for name in a:assert GraphMatcher(graph(a,name),graph(b,name),node_match=categorical_node_match('signature',None)).is_isomorphic(),name
 ly=db.Layout();ly.read(str(ROOT/'mac.gds'));top=ly.cell('mac');assert ly.dbu==.001
 bbox=top.dbbox();assert bbox.left>=0 and bbox.bottom>=0 and bbox.right<=1800 and bbox.top<=1000
 for layer in ly.layer_indexes():
  for p in db.Region(top.begin_shapes_rec(layer)).each():
   for ring in [list(p.each_point_hull())]+[list(p.each_point_hole(i)) for i in range(p.holes())]:assert all(v.x%50==0 and v.y%50==0 for v in ring)
 proof=dict(passed=True,baseline_commit=BASE,gds_sha256=logic.sha(ROOT/'mac.gds'),extracted_sha256=logic.sha(ROOT/'mac.extracted'),cells=sorted(a),dbu_um=.001,grid_um=.05,bbox_um=[bbox.left,bbox.bottom,bbox.right,bbox.top],changes='Right-edge VDD/AND/OR access; isolated M2 EINOSUKE / OKAZAKI and penguin',comparison='Exact named formal ports, device terminal roles, models and parameters; all 9 electrical cells isomorphic.',scope='Device extraction, no wire RC; exhaustive results inherited only by proved electrical equivalence.')
 print('PASS: all nine electrical cells unchanged; allocation/grid pass',flush=True)
 ex.WORK=ROOT/'simulation/mac/art_extracted';base,_,_=ex.prepare();native=logic.native(base,ex.WORK);assert native['passed']
 proof['fresh_native']=native
 (ROOT/'reports/mac_art.json').write_text(json.dumps(proof,indent=2)+'\n')
 report=copy.deepcopy(old);report.pop('final_review',None);report.update(gds_sha256=r['gds_sha256'],extracted_sha256=logic.sha(ROOT/'mac.extracted'),cases=[native]+old['cases'][1:],art_equivalence='reports/mac_art.json')
 for c in report['cases'][1:]:c['requalified_by']='reports/mac_art.json'
 (ROOT/'reports/mac_extracted.json').write_text(json.dumps(report,indent=2)+'\n');print(native,flush=True)
if __name__=='__main__':main()
