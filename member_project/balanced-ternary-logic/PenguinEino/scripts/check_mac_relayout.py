"""Requalify a placement-only revision against a committed, exhaustively tested extraction.

Only byte-identical non-comment SPICE and unchanged model/reference hashes permit
reuse of exhaustive results. Always rerun the 81-state native extracted TB.
"""
import argparse,copy,hashlib,json,subprocess
import check_mac as logic
import check_mac_extracted as extracted
import verify_arithmetic_layout as verify
ROOT=logic.ROOT

def at(commit,path):return subprocess.check_output(['git','show',f'{commit}:{path}'],cwd=ROOT)
def digest(data):return hashlib.sha256(data).hexdigest()
def electrical(raw):return '\n'.join(l for l in raw.decode().splitlines() if l.strip() and not l.lstrip().startswith('*')).encode()
def main(commit):
 oldraw=at(commit,'mac.extracted');oldreport_bytes=at(commit,'reports/mac_extracted.json');old=json.loads(oldreport_bytes)
 oldlayout=json.loads(at(commit,'reports/mac_layout.json'))
 currentraw=(ROOT/'mac.extracted').read_bytes();layout=json.loads((ROOT/'reports/mac_layout.json').read_text())
 assert old['passed'] and layout['drawing_lvs_passed']
 assert digest(oldraw)==old['extracted_sha256']
 assert electrical(oldraw)==electrical(currentraw),'Electrical extraction changed: run full check_mac_extracted.py instead'
 assert old['reference_sha256']==layout['reference_sha256']==logic.sha(verify.reference('mac'))
 assert oldlayout['rules_sha256']==layout['rules_sha256']
 models={str(p.relative_to(verify.PDK)):logic.sha(p) for p in (verify.PDK/'libs.tech/spice/models').rglob('*') if p.is_file()}
 assert models==old['model_sha256'],'PDK simulation models changed'
 for n,h in layout['rules_sha256'].items():assert logic.sha(verify.PDK/n)==h
 base,_,_=extracted.prepare();logic.REUSE_VALIDATED=False
 native=logic.native(base,extracted.WORK);assert native['passed'];print(native,flush=True)
 proof=dict(baseline_commit=commit,baseline_report_sha256=digest(oldreport_bytes),baseline_gds_sha256=old['gds_sha256'],new_gds_sha256=layout['gds_sha256'],
  baseline_extracted_sha256=digest(oldraw),new_extracted_sha256=digest(currentraw),noncomment_spice_sha256=digest(electrical(currentraw)),
  identical_noncomment_spice=True,identical_pdk_models=True,identical_lvs_rules=True,identical_schematic_reference=True,
  rerun='81-state native extracted TB',reused='6480 directed transitions at 10 fF and 648 one-input transitions at 100 fF',
  limitation='Extraction contains no interconnect RC; rerouting has no electrical effect in this model.')
 rows=[native]+copy.deepcopy(old['cases'][1:])
 for r in rows[1:]:r['reused_from_equivalent_extraction']=commit
 result=dict(passed=True,scope=old['scope'],gds_sha256=layout['gds_sha256'],extracted_sha256=digest(currentraw),reference_sha256=layout['reference_sha256'],temperature_C=27,supplies_V=[-5,0,5],tolerance_V=.5,cases=rows,model_sha256=models,relayout_equivalence=proof)
 assert logic.sha(ROOT/'mac.gds')==layout['gds_sha256']
 (ROOT/'reports/mac_relayout_equivalence.json').write_text(json.dumps(proof,indent=2)+'\n')
 (ROOT/'reports/mac_extracted.json').write_text(json.dumps(result,indent=2)+'\n')
 print('PASS: new 81-state run and exact electrical equivalence to exhaustive baseline',flush=True)
if __name__=='__main__':
 p=argparse.ArgumentParser();p.add_argument('--baseline',default='f4a704d');main(p.parse_args().baseline)
