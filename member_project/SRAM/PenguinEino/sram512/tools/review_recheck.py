"""Reapply the corrected waveform checker to independently reviewed evidence.

This migration accepts only the exact reviewed circuits, models and SPICE
decks. AST comparison requires all stimulus/simulation functions to remain
unchanged. It neither regenerates a transient nor promotes a changed circuit.
Future changes use evidence.py with an actual verification command.
"""
import ast
from analog import scenario,verify
from common import *
import evidence
from validation_summary import REQUIRED


def unchanged_simulation_code(baseline):
    old=subprocess.check_output(['git','show',baseline+':sram512/tools/analog.py'],cwd=ROOT,text=True)
    new=(TOOLS/'analog.py').read_text()
    def simulation_ast(source):
        module=ast.parse(source)
        module.body=[n for n in module.body
            if not (isinstance(n,ast.FunctionDef) and n.name=='verify_samples')
            and not (isinstance(n,ast.ImportFrom) and n.module=='waveform')]
        return ast.dump(module,include_attributes=False)
    assert simulation_ast(old)==simulation_ast(new), 'Simulation/stimulus code changed; rerun the affected transient.'


def main():
    baseline='7dae978'
    review_path=ROOT/'reviews/sram512_review_2026-09-13_results.json'
    review=json.loads(review_path.read_text())
    reviewed={r['test']:r for r in review['stored_evidence_index']}
    unchanged_simulation_code(baseline)
    assessment=hashes_for_assessment()
    results=[]
    for name,_,_ in REQUIRED:
        path=REPORTS/(name+'.json');original=json.loads(path.read_text())
        assert sha(path)==reviewed[name]['sha256'], ('Original report changed',name)
        receipt=json.loads((evidence.RECEIPTS/(name+'.json')).read_text())
        before=evidence.snapshot(name)
        assert before['design']==receipt['inputs']['design'], 'Reviewed electrical inputs changed.'
        assert before['pdk']==receipt['inputs']['pdk']
        changed={p for p in set(before['test_code'])|set(receipt['inputs']['test_code'])
                 if before['test_code'].get(p)!=receipt['inputs']['test_code'].get(p)}
        assert changed <= {'sram512/tools/analog.py','sram512/tools/waveform.py'},(name,changed)
        previous_assessment=receipt.get('origin',{}).get('assessment_code')
        if not changed and (previous_assessment is None or previous_assessment==assessment):
            assert evidence.check(name)[0], ('Stored receipt is not current',name)
            continue
        result=dict(passed=True,test=name,base_report_sha256=sha(path),
                    reviewed_commit=baseline,simulation_code_unchanged=True)
        artifacts={}
        if original.get('operations'):
            folder=WORK/'analog'/name.removeprefix('analog_')
            deck=folder/'test.spice';raw=folder/'sram512_tb.raw'
            assert sha(deck)==original.get('deck_sha256',original.get('input_sha256')),(name,'deck identity')
            scenario_path=folder/'scenario.json'
            case=json.loads(scenario_path.read_text()) if scenario_path.exists() else scenario(
                period=original['period_ns'],edge=original['edge_ns'])
            case['invalidated_before']={int(k):v for k,v in case.get('invalidated_before',{}).items()}
            print('Rechecking saved waveform:',name,flush=True)
            checked=verify(raw,case,original['voltage_v'])
            result.update(functional_checks=checked,passed=checked['passed'],
                          raw_sha256=evidence.file_digest(raw),deck_sha256=sha(deck))
            artifacts[str(raw.relative_to(ROOT))]=result['raw_sha256']
            artifacts[str(deck.relative_to(ROOT))]=result['deck_sha256']
            if scenario_path.exists():artifacts[str(scenario_path.relative_to(ROOT))]=sha(scenario_path)
            result['scope']='Existing transient, newly checked time coverage and continuous SDO retention; unchanged voltage/current/geometry checks remain bound to the original report.'
        else:
            # These checks import analog only for unchanged raw I/O or circuit
            # generation; they never call the modified verify_samples.
            result['scope']='Dependency reassessment: no access waveform checker is used by this geometry/startup/comparison test. All original executed functions and inputs are unchanged.'
        out=REPORTS/'rechecks'/(name+'.json');write_json(out,result)
        if not result['passed']:raise RuntimeError(f'New checker failed: {out}')
        artifacts[str(out.relative_to(ROOT))]=sha(out)
        origin=dict(kind='reviewed_waveform_reassessment',review_sha256=sha(review_path),
            reviewed_commit=baseline,base_report_sha256=sha(path),
            assessment_code=assessment,scope=result['scope'])
        assert hashes_for_assessment()==assessment, 'Reassessment code changed during execution.'
        evidence.record(name,before,origin,artifacts)
        results.append(dict(test=name,passed=True,report=str(out.relative_to(ROOT))))
    checks=[dict(test=name,passed=evidence.check(name)[0]) for name,_,_ in REQUIRED]
    assert all(row['passed'] for row in checks)
    write_json(REPORTS/'review_waveform_recheck.json',dict(passed=True,checks=checks,reassessed=results,
        source_gds_sha256=sha(HERE/'layout/sram512.gds')))
    print('Updated',len(results),'verification receipts after explicit reassessment.',flush=True)


def hashes_for_assessment():
    return {str((TOOLS/n).relative_to(ROOT)):sha(TOOLS/n) for n in ('review_recheck.py','waveform.py')}


if __name__=='__main__':main()
