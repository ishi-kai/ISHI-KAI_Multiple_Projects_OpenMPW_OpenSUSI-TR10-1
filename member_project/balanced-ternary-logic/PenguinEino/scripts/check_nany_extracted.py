"""Exercise the LVS-extracted device network with the existing NANY TB checks.

Includes device diffusion parasitics; does not extract interconnect RC.
"""
import json
import re
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path
import check_nany as checks

ROOT = Path(__file__).resolve().parents[1]
WORK = ROOT/'simulation/nany_layout/extracted_sim'


def main():
    WORK.mkdir(parents=True,exist_ok=True)
    checks.WORK = WORK
    base = checks.netlist('nany_tb')
    ext = (ROOT/'simulation/nany_layout/verify/lvs/nany.extracted').read_text()
    ext = re.sub(r'\\\$(\d+)',r'extracted_\1',ext)
    ext = re.search(r'^\.SUBCKT nany .*?^\.ENDS nany',ext,re.M|re.S)[0]
    ext = re.sub(r'^\.SUBCKT nany .*$', '.subckt nany a b vout VDD VSS VMID',ext,flags=re.M)
    devices = [line.split() for line in ext.splitlines() if line.startswith('XM')]
    def other(model, width, gate, known):
        found = [d for d in devices if d[5]==model and d[2]==gate and
                 f'W={width}u' in d and known in (d[1],d[3])]
        assert len(found)==1, (model,width,gate,known)
        d=found[0]
        return d[3] if d[1]==known else d[1]
    mapping = {}
    mapping['net1']=other('PMOS',34,'a','VDD')
    mapping['net2']=other('PMOS',34,'b',mapping['net1'])
    mapping['net4']=other('NMOS',11,'b','VSS')
    mapping['net3']=other('NMOS',11,'a',mapping['net4'])
    mapping['net5']=other('PMOS',14,'a','vout')
    mapping['net6']=other('PMOS',14,'b','vout')
    for original,extracted in mapping.items():
        base=base.replace(f'x1.{original})',f'x1.{extracted})')
    base=re.sub(r'^\.subckt nany .*?^\.ends\b[^\n]*',lambda _:ext,base,flags=re.M|re.S|re.I)
    (WORK/'extracted_tb.spice').write_text(base)
    jobs=[('dc',10,0),('tran_10f',10,0),('tran_100f',100,0),('skew_a',10,-2),('skew_b',10,2)]
    with ThreadPoolExecutor(max_workers=3) as pool:
        rows=list(pool.map(lambda job:checks.run(job,base),jobs))
    passed=all(r['error']<=.5 and r.get('band_error',0)<=.5 and not r.get('unsettled',0) for r in rows)
    result=dict(passed=passed,scope='LVS extracted device network; intrinsic device parasitics, no interconnect RC',nodeset_mapping=mapping,results=rows)
    (WORK/'results.json').write_text(json.dumps(result,indent=2)+'\n')
    for row in rows:
        print({k:v for k,v in row.items() if k not in ('points','transitions')},flush=True)
    assert passed, 'Extracted network failed functional checks'


if __name__=='__main__':
    main()
