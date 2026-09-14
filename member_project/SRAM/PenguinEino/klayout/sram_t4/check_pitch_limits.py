#!/usr/bin/env python3
"""Reject a 0.1-um reduction on each tight dimension of the fixed T4 route.

These are local geometry controls, not a proof of a global area lower bound.
The failed GDS/logs stay under build/; the accepted layouts are not modified.
"""
from pathlib import Path
import importlib.util,json
import klayout.db as db
import build as candidate
spec=importlib.util.spec_from_file_location('t4_verify',Path(__file__).with_name('verify.py'))
verifier=importlib.util.module_from_spec(spec);spec.loader.exec_module(verifier)
HERE=candidate.HERE;OUT=candidate.ROOT/'build/sram_t4/pitch_limits'


def main():
    OUT.mkdir(parents=True,exist_ok=True);results=[]
    for name,x,s,p in [('reference_0p05_grid',52.6,21.4,32.6),
                        ('column_minus_0p1',52.5,21.4,32.6),
                        ('mirror_translation_minus_0p1',52.6,21.3,32.6),
                        ('row_pair_minus_0p1',52.6,21.4,32.5)]:
        work=OUT/name;work.mkdir(exist_ok=True);candidate.X=x
        l=db.Layout();l.dbu=.05;c=candidate.single_core(l);shared=candidate.single_core(l,True)
        top=candidate.single_array(l,c,4,4,shared=shared,S=s,P=p)
        source=work/'rejected.gds';l.write(str(source))
        ref=work/(top.name+'.spice');ref.write_text(candidate.reference(top.name,4,4))
        checks={}
        for kind in ('drc','lvs'):
            ok,detail=verifier.base.check(source,top.name,kind,work,ref)
            checks[kind]={'pass':ok,**detail}
        result=dict(case=name,x_um=x,mirror_y_um=s,pair_y_um=p,**checks)
        results.append(result);print(json.dumps(result),flush=True)
    (HERE/'pitch_limits.json').write_text(json.dumps(results,indent=2)+'\n')
    assert results[0]['drc']['pass'] and results[0]['lvs']['pass']
    assert all(not r['drc']['pass'] for r in results[1:]), 'A smaller pitch is legal; investigate it'


if __name__=='__main__':main()
