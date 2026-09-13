#!/usr/bin/env python3
"""Generate and verify the selected six-single-MOS-PCell design."""
from pathlib import Path
import hashlib,json,shutil
from build import make,HERE,ROOT,PDK
from verify import verify,PDK as CHECK_PDK

def main():
    out=ROOT/'build/sram_pcell/final'
    dimensions=make(out,family='six_single',shapes=((1,1),(2,2),(4,4),(4,17),(8,8),(16,16),(16,32),(16,64),(20,76)),probe=True)
    shutil.copy2(out/'pcell.gds',HERE/'pcell.gds')
    (HERE/'dimensions.json').write_text(json.dumps(dimensions,indent=2)+'\n')
    reports=[]
    for top in list(dimensions['arrays'])+['pcell_probe_2x2']:
        result=verify(out,top,verbose=False);reports.append(result)
        print(f'{top}: DRC={result["drc"]["items"]}, LVS={result["lvs"]["passed"]}',flush=True)
        (HERE/'verification.json').write_text(json.dumps(reports,indent=2)+'\n')
    assert all(r[k]['passed'] for r in reports for k in ('drc','lvs'))
    paths=[]
    for folder in ('drc','lvs','python/cells'):
        tech=(PDK if folder=='python/cells' else CHECK_PDK)/'libs.tech/klayout/tech'
        paths.extend(p for p in (tech/folder).rglob('*') if p.is_file() and '__pycache__' not in p.parts)
    paths.extend(out.glob('*.spice'))
    (HERE/'verification_inputs.json').write_text(json.dumps({str(p):hashlib.sha256(p.read_bytes()).hexdigest() for p in paths},indent=2)+'\n')

if __name__=='__main__':main()
