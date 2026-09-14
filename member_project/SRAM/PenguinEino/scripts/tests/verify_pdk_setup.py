#!/usr/bin/env python3
"""Verify real profile rollback, legacy verifier selection and baseline integrity."""
from pathlib import Path
import json,os,subprocess,sys
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'scripts'))
from pdk_profiles import locked,pdk_path,tree_digest,environment,sha256,STATE

def command(*args,env=None):
    return subprocess.check_output([str(ROOT/'scripts/pdk'),*args],cwd=ROOT,env=env,text=True)

def main():
    env=dict(os.environ);env.pop('SRAM_PDK_PROFILE',None)
    start=(STATE/'active').read_text()
    observed=[]
    try:
        for profile in ('original','dev'):
            command('use',profile,env=env)
            status=json.loads(command('status',env=env));assert status['active_profile']==profile
            # Simulate the user's login shell retaining its old PDK variables.
            shell={**env,'PDK_ROOT':'/home/ishi-kai/pdk','PDK':'TR-1um'}
            code="""
import sys
sys.path.insert(0,'klayout/dense_sram')
import verify
print(verify.PDK)
"""
            actual=subprocess.check_output([sys.executable,'-c',code],cwd=ROOT,env=shell,text=True).strip()
            assert Path(actual)==pdk_path(profile),actual
            code="""
import sys
sys.path.insert(0,'klayout/sram_pcell')
import verify
print(verify.PDK)
"""
            actual=subprocess.check_output([sys.executable,'-c',code],cwd=ROOT,env=shell,text=True).strip()
            assert Path(actual)==pdk_path(profile),actual
            other='dev' if profile=='original' else 'original'
            override=json.loads(command('--profile',other,'status',env=env))
            assert override['active_profile']==other
            assert json.loads(command('status',env=env))['active_profile']==profile
            observed.append(dict(profile=profile,passed=True,batch_verifier_directory=actual))
    finally:
        (STATE/'active').write_text(start)
    baseline=json.loads((STATE/'original_environment_hashes.json').read_text())
    assert all(sha256(p)==digest for p,digest in baseline.items())
    lock=locked()
    for name,info in lock['profiles'].items():assert tree_digest(pdk_path(name))==info['tree_sha256']
    assert tree_digest(Path(lock['profiles']['original']['source']))==lock['profiles']['original']['tree_sha256']
    assert environment('dev')['KLAYOUT_HOME']!=environment('original')['KLAYOUT_HOME']
    assert 'KLAYOUT_PATH' not in environment('dev')
    result=dict(passed=True,switch_and_restore=observed,final_profile=start.strip(),
                original_pdk_unchanged=True,original_environment_unchanged=True,
                original_environment_sha256=baseline,profiles_match_locked_trees=True)
    (ROOT/'pdk/setup_validation.json').write_text(json.dumps(result,indent=2)+'\n')
    print('PASS: actual original/dev switching, explicit override, both verifier imports, original files and locked trees.')

if __name__=='__main__':main()
