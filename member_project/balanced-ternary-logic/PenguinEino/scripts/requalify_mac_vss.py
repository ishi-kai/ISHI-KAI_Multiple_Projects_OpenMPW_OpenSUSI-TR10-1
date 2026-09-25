"""Qualify the final M1-only return widening against the completed full run.

The only SPICE change permitted is the bijective rename of one unobserved
MAC-local net ($11 -> $10). Re-evaluate every saved transition and rerun the
native extracted TB. This is not interconnect RC extraction.
"""
from pathlib import Path
import argparse,copy,hashlib,json,re,shutil
import check_mac as c
import check_mac_extracted as ex
import verify_arithmetic_layout as verify

ROOT=c.ROOT
def sha_bytes(b):return hashlib.sha256(b).hexdigest()
def save(p,d):p.write_text(json.dumps(d,indent=2)+'\n')

def main(backup):
    backup=Path(backup);oldraw=(backup/'mac.extracted').read_bytes()
    old=json.loads((backup/'mac_extracted.json').read_text());oldlayout=json.loads((backup/'mac_layout.json').read_text())
    layout=json.loads((ROOT/'reports/mac_layout.json').read_text());raw=(ROOT/'mac.extracted').read_bytes()
    assert old['passed'] and old['extracted_sha256']==sha_bytes(oldraw)
    assert old['gds_sha256']==c.sha(backup/'mac.gds')
    assert layout['drawing_lvs_passed'] and layout['gds_sha256']==c.sha(ROOT/'mac.gds')
    assert [r['transitions'] for r in old['cases']]==[81,6480,648]
    assert all(r['passed'] and r['load_fF']==10000 for r in old['cases'])
    a=raw.index(b'.SUBCKT mac ');b=raw.index(b'.ENDS mac',a)
    top=raw[a:b];oldtop=oldraw[oldraw.index(b'.SUBCKT mac '):oldraw.index(b'.ENDS mac')]
    assert b'\\$11' not in top and b'\\$10' not in oldtop
    assert b'\\$10' not in top.splitlines()[0] and top.count(b'\\$10')==2
    normalized=raw[:a]+top.replace(b'\\$10',b'\\$11')+raw[b:]
    assert normalized==oldraw,'More than the permitted internal net rename changed'
    assert old['reference_sha256']==layout['reference_sha256']==c.sha(verify.reference('mac'))
    assert oldlayout['rules_sha256']==layout['rules_sha256']
    models={str(p.relative_to(c.PDK)):c.sha(p) for p in (c.PDK/'libs.tech/spice/models').rglob('*') if p.is_file()}
    assert models==old['model_sha256']
    old_include=sha_bytes((ex.normalized(oldraw.decode())+'\n').encode())
    sequence=c.route();checked=[];metrics=[]
    for i in range(16):
        lo=6480*i//16;hi=6480*(i+1)//16
        checked.append((ex.WORK/f'all_6480_10000f/chunk_{i}',[c.STATES[0]]+sequence[lo:hi+1]))
    checked.append((ex.WORK/'single_input_648_10000f',c.route(True)))
    for folder,seq in checked:
        deps=json.loads((folder/'input_dependencies.json').read_text())
        assert deps[str(ex.WORK/'mac_extracted.spice')]==old_include
        assert all(c.sha(Path(p))==h for p,h in deps.items() if Path(p)!=ex.WORK/'mac_extracted.spice')
        r=c.evaluate(folder/'data.txt',seq,1000);assert r['passed']
        previous=json.loads((folder/'results.json').read_text());assert previous['passed']
        reference=old['cases'][1]['chunks'][int(folder.name.split('_')[-1])] if folder.name.startswith('chunk_') else old['cases'][2]
        for key in ('samples','transitions','max_output_error_V','max_product_error_V','max_settle_ns','unsettled'):
            assert r[key]==previous[key]==reference[key],(folder,key)
        metrics.append(dict(case=folder.name,passed=True,wave_sha256=c.sha(folder/'data.txt'),max_error_V=r['max_output_error_V'],max_settle_ns=r['max_settle_ns']))
    # Retain compact, independently hashable baseline evidence in Git.
    out=ROOT/'reports/mac_improvements'
    shutil.copy2(backup/'mac.extracted',out/'vss_before.extracted')
    shutil.copy2(backup/'mac_extracted.json',out/'vss_before_report.json')
    base,_,_=ex.prepare();c.REUSE_VALIDATED=True
    native=c.native(base,ex.WORK);assert native['passed'];print('Fresh native:',native,flush=True)
    proof=dict(baseline_gds_sha256=old['gds_sha256'],new_gds_sha256=c.sha(ROOT/'mac.gds'),
        baseline_extracted_sha256=sha_bytes(oldraw),new_extracted_sha256=sha_bytes(raw),
        baseline_report_sha256=c.sha(out/'vss_before_report.json'),
        allowed_change='MAC-local internal net $11 renamed $10; all other SPICE bytes identical.',
        cache_note='An automatic restart rewrote four progress logs/decks before cancellation. The completed old data arrays, dependency records and per-transition results were preserved, re-evaluated, and their aggregates checked exactly against the saved completed baseline report.',
        identical_device_network=True,identical_models=True,identical_reference=True,identical_rules=True,
        rechecked_waveforms=metrics,rerun='Native 81 inputs plus return, 10 pF || 1 Mohm, 1 us.',
        limitation='Metal widened only. No wire RC in this extraction, therefore no simulated RC benefit is claimed.')
    rows=[native]+copy.deepcopy(old['cases'][1:])
    for r in rows[1:]:r['requalified_by']='reports/mac_improvements/vss_equivalence.json'
    report={**old,'gds_sha256':c.sha(ROOT/'mac.gds'),'extracted_sha256':sha_bytes(raw),'cases':rows,'power_join_equivalence':proof}
    save(out/'vss_equivalence.json',proof);save(ROOT/'reports/mac_extracted.json',report)
    print('PASS: widened return, exact circuit equivalence under a single net rename, all saved transitions re-evaluated',flush=True)

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('backup');main(p.parse_args().backup)
