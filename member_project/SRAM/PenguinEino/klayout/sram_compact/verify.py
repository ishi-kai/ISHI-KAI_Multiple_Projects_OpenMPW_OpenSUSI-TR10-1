#!/usr/bin/env python3
"""Run unchanged strict PDK DRC/LVS on saved Compact candidates."""
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor
import importlib.util,sys,json,hashlib,argparse
import klayout.rdb as rdb
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[1]
sys.path.insert(0,str(HERE.parent/'dense_sram'))
spec=importlib.util.spec_from_file_location('dense_verify',HERE.parent/'dense_sram/verify.py')
base=importlib.util.module_from_spec(spec);spec.loader.exec_module(base)


def verify(top):
    variant='compact'
    source=HERE/(variant+'.gds');out=ROOT/'build/sram_compact';out.mkdir(parents=True,exist_ok=True)
    def one(kind):
        ok,detail=base.check(source,top,kind,out,out/(top+'.spice'))
        return kind,{'pass':ok,**detail}
    with ThreadPoolExecutor(max_workers=2) as pool:checks=dict(pool.map(one,['drc','lvs']))
    report=dict(top=top,gds_sha256=hashlib.sha256(source.read_bytes()).hexdigest(),**checks)
    (out/(top+'.result.json')).write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report,indent=2),flush=True)
    reportdb=rdb.ReportDatabase();reportdb.load(str(out/(top+'.drcdb')))
    for item in list(reportdb.each_item())[:70]:
        print(reportdb.category_by_id(item.category_id()).name(),[v.to_s() for v in item.each_value()])
    return report


def record_inputs():
    root=base.PDK/'libs.tech/klayout/tech'
    rules={str(p):hashlib.sha256(p.read_bytes()).hexdigest()
           for kind in ('drc','lvs') for p in sorted((root/kind).rglob('*')) if p.is_file()}
    refs={p.name:hashlib.sha256(p.read_bytes()).hexdigest()
          for p in sorted((ROOT/'build/sram_compact').glob('*.spice'))}
    (HERE/'verification_inputs.json').write_text(json.dumps(
        dict(pdk_rule_sha256=rules,reference_sha256=refs),indent=2)+'\n')


def main():
    parser=argparse.ArgumentParser();parser.add_argument('--top');args=parser.parse_args()
    if args.top:
        reports=[verify(args.top)]
    else:
        tops=[]
        for filename in ('dimensions.json',):
            dims=json.loads((HERE/filename).read_text())
            tops.extend(dims['arrays'])
        tops.append('compact_probe_2x2')
        reports=[verify(top) for top in tops]
        (HERE/'verification.json').write_text(json.dumps(reports,indent=2)+'\n')
    if not all(r['drc']['pass'] and r['lvs']['pass'] for r in reports):
        raise SystemExit('Compact verification failed; inspect DRC/LVS reports.')
    record_inputs()


if __name__=='__main__':main()
