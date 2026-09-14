#!/usr/bin/env python3
"""Verify saved GDS with the unmodified installed PDK, including negative controls."""
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path
from datetime import datetime,timezone
import argparse
import klayout.rdb as rdb
import hashlib
import json
import sys
import klayout.db as db
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[1]
sys.path.insert(0,str(HERE.parent/'dense_sram'))
from verify import check,PDK
from build import reference
OUT=ROOT/'build/sram_research/verified'


def ref_for(top,r,c):
    text=reference(top,r,c)
    if '_probe_' in top:
        for rr in range(r):
            for cc in range(c):
                for q in ('Q','QB'):text=text.replace(f'{q}_{rr}_{cc}',f'{q}{rr}{cc}')
        lines=text.splitlines();lines[1]+=' '+' '.join(f'{q}{rr}{cc}' for rr in range(r) for cc in range(c) for q in ('Q','QB'))
        text='\n'.join(lines)+'\n'
    return text


def faults():
    results={}
    source=HERE/'euler_shared.gds'
    for name in ('cut_feedback','short_bitlines','short_wordlines'):
        out=OUT/name;out.mkdir(parents=True,exist_ok=True)
        l=db.Layout();l.read(str(source));core=l.cell('euler')
        top='euler_shared_4x4' if name=='short_wordlines' else 'euler_shared_1x1'
        r,c=(4,4) if name=='short_wordlines' else (1,1)
        if name=='cut_feedback':
            li=l.layer(8,1);reg=db.Region(core.shapes(li))-db.Region(db.Box(65,100,79,110))
            core.shapes(li).clear();core.shapes(li).insert(reg)
        elif name=='short_bitlines':
            core.shapes(l.layer(13,0)).insert(db.Box(-4,-9,196,9))
        else:
            l.cell(top).shapes(l.layer(20,0)).insert(db.Box(-113,520,-79,630))
        gds=out/'fault.gds';l.write(str(gds))
        ref=out/(top+'.spice');ref.write_text(ref_for(top,r,c))
        ok,detail=check(gds,top,'lvs',out,ref)
        results[name]={'rejected':not ok,**detail}
        if ok:raise RuntimeError(f'Intentional {name} was accepted')
        print(f'Negative control {name}: rejected',flush=True)
    return results


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--fresh",action="store_true",help="Rerun even when reports are newer than unchanged inputs")
    args=parser.parse_args()
    OUT.mkdir(parents=True,exist_ok=True)
    cases=[]
    for variant in ('euler','euler_shared'):
        shapes=((1,1),(2,2),(4,4),(4,17),(8,8),(16,64),(20,68 if variant=='euler' else 72))
        for r,c in shapes:cases.append((variant,f'{variant}_{r}x{c}',r,c,True))
    for top,r,c in (('sram_dense_1x1',1,1),('sram_dense_16x64',16,64),('sram_dense_17x78',17,78),('baseline_probe_2x2',2,2)):
        cases.append(('baseline_fit',top,r,c,True))
    cases.append(('euler_shared','euler_shared_probe_2x2',2,2,True))
    for r,c in ((1,1),(4,17),(16,64),(17,80)):
        cases.append(('baseline_shared',f'baseline_shared_{r}x{c}',r,c,True))
    cases.append(('offset_via','sram_dense_2x2',2,2,False))
    cases.sort(key=lambda case: '_probe_' not in case[1])
    input_hashes={v:hashlib.sha256((HERE/(v+'.gds')).read_bytes()).hexdigest() for v in {c[0] for c in cases}}
    def one(case):
        variant,top,r,c,should_pass=case
        out=OUT/variant;out.mkdir(exist_ok=True)
        ref=out/(top+'.spice');expected=ref_for(top,r,c)
        if not ref.exists() or ref.read_text()!=expected:ref.write_text(expected)
        checks={}
        for kind in ('drc','lvs'):
            source=HERE/(variant+'.gds')
            report=out/f'{top}.{kind}db';log=out/f'{top}.{kind}.log'
            latest_input=max(p.stat().st_mtime for p in [source,ref,*((PDK/'libs.tech/klayout/tech'/kind).glob('*'))] if p.is_file())
            cached=not args.fresh and report.exists() and log.exists() and min(report.stat().st_mtime,log.stat().st_mtime)>latest_input
            try:
                if not cached:raise ValueError('fresh run required')
                if kind=='drc':
                    result=rdb.ReportDatabase();result.load(str(report))
                    n=result.num_items();ok=n==0
                    detail={'items':n,'categories':{c.name():c.num_items() for c in result.each_category() if c.num_items()}}
                else:
                    result=db.LayoutVsSchematic();result.read(str(report))
                    pairs=list(result.xref().each_circuit_pair());errors=[e.message for e in result.each_error()]
                    ok=bool('INFO : Congratulations! Netlists match.' in log.read_text() and pairs and all(p.status()==db.NetlistCrossReference.Match for p in pairs) and not errors)
                    detail={'circuit_pairs':[str(p.status()) for p in pairs],'errors':errors}
            except Exception:
                cached=False
                ok,detail=check(source,top,kind,out,ref)
            detail['reused_existing_report']=cached
            checks[kind]={'pass':ok,**detail}
            print(f'{variant}/{top} {kind}: {ok}',flush=True)
        result={'variant':variant,'top':top,'expected_valid':should_pass,**checks}
        (out/(top+'.checks.json')).write_text(json.dumps({'gds_sha256':input_hashes[variant],**result},indent=2)+'\n')
        return result
    # Separate top-level runs avoid sharing report paths. Each process reads the saved file.
    with ThreadPoolExecutor(max_workers=2) as pool:checks=list(pool.map(one,cases))
    assert all(hashlib.sha256((HERE/(v+'.gds')).read_bytes()).hexdigest()==h for v,h in input_hashes.items()),'Input GDS changed during verification'
    report={'verified_at_utc':datetime.now(timezone.utc).isoformat(),
            'gds_sha256':{v:hashlib.sha256((HERE/(v+'.gds')).read_bytes()).hexdigest() for v in sorted({c[0] for c in cases})},
            'pdk':str(PDK),'deck_sha256':{k:hashlib.sha256((PDK/f'libs.tech/klayout/tech/{k}/run.{k}').read_bytes()).hexdigest() for k in ('drc','lvs')},
            'checks':checks}
    (HERE/'verification.json').write_text(json.dumps(report,indent=2)+'\n')
    if any(not (x['drc']['pass'] and x['lvs']['pass']) for x in checks if x['expected_valid']):
        raise RuntimeError('A candidate expected to be valid failed. See verification.json')
    report['negative_controls']=faults()
    (HERE/'verification.json').write_text(json.dumps(report,indent=2)+'\n')
    print('All expected-valid layouts passed; rejected proposal recorded separately.',flush=True)


if __name__=='__main__':main()
