#!/usr/bin/env python3
"""Put the actual compact 2x2 extraction into the current serial schematic TB."""
from pathlib import Path
import hashlib,importlib.util,json,re,sys
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[1]
spec=importlib.util.spec_from_file_location('macro_serial',HERE.parent/'sram_macro_study/verify_serial.py')
shared=importlib.util.module_from_spec(spec);spec.loader.exec_module(shared)
serial=shared.serial
OUT=ROOT/'build/sram_compact/serial'


def substitute(template,variant):
    top=variant+'_probe_2x2'
    extracted=(ROOT/'build/sram_compact'/f'{top}.extracted').read_text()
    pins=re.search(r'(?im)^\.subckt\s+\S+\s+([^\n]+)',re.sub(r'\n\+\s*',' ',extracted)).group(1).split()
    wanted={'VDD','VSS','WL0','WL1','BL0','BLB0','BL1','BLB1'}|{f'{q}{r}{c}' for r in range(2) for c in range(2) for q in ('Q','QB')}
    assert set(pins)==wanted,pins
    text,n=re.subn(r'(?im)^xc[01][01]\s+[^\n]+\bsram\s*$', '',template);assert n==4,n
    text,n=re.subn(r'(?ims)^\.subckt[ \t]+sram[ \t]+.*?^\.ends[^\n]*',lambda _:extracted,text);assert n==1,n
    instance='Xmemory '+' '.join('GND' if p=='VSS' else p for p in pins)+' '+top+'\n'
    return text.replace('**** begin user architecture code',instance+'**** begin user architecture code')


def main():
    OUT.mkdir(parents=True,exist_ok=True)
    shared.WORK=OUT/'netlist';template=shared.fresh_netlist()
    checks=json.loads((HERE/'verification.json').read_text())
    for variant in ('compact',):
        match=next(r for r in checks if r['top']==variant+'_probe_2x2')
        assert match['drc']['pass'] and match['lvs']['pass']
        assert match['gds_sha256']==hashlib.sha256((HERE/(variant+'.gds')).read_bytes()).hexdigest()
    dependencies=Path(__file__).read_bytes()+Path(shared.__file__).read_bytes()
    for p in sorted((shared.PDK/'libs.tech/spice/models').rglob('*')):
        if p.is_file():dependencies+=p.read_bytes()
    for p in ['scripts/verify_serial_spice.py','scripts/serial_spice_stimulus.py','sram512/rtl/sram_serial_controller.v']:
        dependencies+=(ROOT/p).read_bytes()
    results=[]
    for variant,temp,cbl,cy in [('compact',27,'10f','100f'),('compact',85,'10f','100f'),
                              ('compact',27,'1p','1p')]:
        work=OUT/f'{variant}_{temp}_{cbl}_{cy}';work.mkdir(exist_ok=True)
        deck=substitute(template,variant).replace('.param CBL=10f CY=100f',f'.param CBL={cbl} CY={cy}\n.temp {temp}')
        assert f'CBL={cbl} CY={cy}' in deck
        key=hashlib.sha256(deck.encode()+dependencies).hexdigest();cache=work/'result.json'
        if cache.exists() and json.loads(cache.read_text()).get('input_sha256')==key:
            result=json.loads(cache.read_text())
        else:
            (work/'batch.spice').write_text(deck)
            (work/'serial_spice_waveforms.txt').unlink(missing_ok=True)
            print(f'Running {variant}, {temp} C, BL={cbl}, Y={cy}',flush=True)
            serial.run(['ngspice','-b','batch.spice'],work,'simulation.log')
            case=serial.scenario();serial.rtl_reference(work,case)
            try:counts=serial.verify(work,case);passed=True;failure=None
            except RuntimeError as error:counts={};passed=False;failure=str(error)
            result=dict(variant=variant,temperature_c=temp,vdd_v=5,clock_ns=100,cbl=cbl,cy=cy,
                        passed=passed,checks=counts,failure=failure,input_sha256=key,
                        log=str((work/'simulation.log').relative_to(ROOT)))
            cache.write_text(json.dumps(result,indent=2)+'\n')
        results.append(result);print(f'{variant}: {"PASS" if result["passed"] else "FAIL"}',flush=True)
        (HERE/'serial_results.json').write_text(json.dumps(results,indent=2)+'\n')
    assert all(r['passed'] for r in results), 'Serial tests failed'


if __name__=='__main__':main()
