#!/usr/bin/env python3
"""Physical spacing sweep of the fixed route; no global-optimum claim."""
from pathlib import Path
import importlib.util,json
import klayout.db as db
import build as candidate
spec=importlib.util.spec_from_file_location('compact_verify',Path(__file__).with_name('verify.py'))
verifier=importlib.util.module_from_spec(spec);spec.loader.exec_module(verifier)
HERE=candidate.HERE;OUT=candidate.ROOT/'build/sram_compact/scan'


def main():
    OUT.mkdir(parents=True,exist_ok=True);results=[]
    cases=[(t,29.6) for t in (0,.1,.2,.25,.3)]+[(.2,29.5),(.2,28.5)]
    for t,h in cases:
        name=f't{t:g}_h{h:g}'.replace('.','p');work=OUT/name;work.mkdir(exist_ok=True)
        candidate.T=t;candidate.H=h
        l=db.Layout();l.dbu=.05;c=candidate.euler(l)
        top=candidate.euler_array(l,c,4,4)
        source=work/'candidate.gds';l.write(str(source))
        ref=work/(top.name+'.spice');ref.write_text(candidate.reference(top.name,4,4))
        checks={}
        for kind in ('drc','lvs'):
            ok,detail=verifier.base.check(source,top.name,kind,work,ref)
            checks[kind]={'pass':ok,**detail}
        valid=checks['drc']['pass'] and checks['lvs']['pass']
        result=dict(case=name,shift_um=t,pitch_um=[22.4-2*t,h],core_um2=(22.4-2*t)*h,
                    valid=valid,gds=str(source.relative_to(candidate.ROOT)),**checks)
        results.append(result);print(json.dumps(result),flush=True)
        assert valid==(h==29.6 and t<=.2), 'Unexpected sweep result; investigate before finalizing'
    (HERE/'scan.json').write_text(json.dumps(results,indent=2)+'\n')


if __name__=='__main__':main()
