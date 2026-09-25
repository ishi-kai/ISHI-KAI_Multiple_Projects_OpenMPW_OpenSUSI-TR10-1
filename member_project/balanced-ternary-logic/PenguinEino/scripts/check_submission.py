"""Qualify the standalone submitted GDS against its own hierarchical SPICE."""
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path
import json,re
import verify_arithmetic_layout as verify
from build_submission import OUT,WORK,sha,electrical

def main():
 gds=OUT/'mac.gds';ref=OUT/'simulation/mac.spice';before=sha(gds)
 with ThreadPoolExecutor(max_workers=3) as pool:
  fs=[pool.submit(verify.drc,gds,'mac',WORK/'drawing'),pool.submit(verify.lvs,'mac',gds,ref,WORK/'lvs'),pool.submit(verify.mask,gds,'mac',WORK/'manufacturing')]
  results=[f.result() for f in fs]
 report=dict(gds_sha256=before,reference_sha256=sha(ref),drawing_drc=results[0],lvs=results[1],mask_drc=results[2])
 assert sha(gds)==before
 assert results[0]['passed'] and results[1]['passed']
 source=json.loads((verify.ROOT/'reports/mac_layout.json').read_text())
 assert results[2]['items']==source['mask_drc']['items'] and results[2]['categories']==source['mask_drc']['categories']
 assert electrical(Path(results[1]['extracted']).read_text())==electrical((OUT/'mac.extracted').read_text())
 report['extracted_electrically_identical']=True
 report['passed']=True;report['scope']='Drawing and strict LVS pass; standalone mask input warnings match the source exactly.'
 for p in OUT.glob('*.md'):
  for link in re.findall(r'\]\(([^)]+)\)',p.read_text()):
   if '://' not in link:assert (OUT/link.split('#')[0]).exists(),(p.name,link)
 (verify.ROOT/'reports/submission_layout.json').write_text(json.dumps(report,indent=2)+'\n')
 print(json.dumps(report,indent=2))
if __name__=='__main__':main()
