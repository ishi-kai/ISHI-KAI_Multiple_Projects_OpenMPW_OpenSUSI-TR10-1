"""Bind a verified result to its inputs; aggregation never creates receipts."""
import argparse
import ast
from functools import lru_cache
from datetime import datetime, timezone
from common import *
from pdk_profiles import tree_digest, locked

RECEIPTS = REPORTS/'evidence'


def entry_point(name):
    if name == 'saved_layout_recheck': return 'verify_saved_layout.py'
    if name == 'pcell_preservation': return 'pcell_preservation.py'
    if name == 'digital': return 'verify_digital.py'
    if name.startswith('analog_'): return 'analog.py'
    if name.endswith('_power_wires'): return 'power_wire_audit.py'
    if 'reset_write' in name: return 'reset_address_test.py'
    if 'operational' in name: return 'operational_tests.py'
    if 'startup_comparison' in name: return 'startup_summary.py'
    if 'startup' in name: return 'startup_tests.py'
    if 'signal_resolution' in name: return 'signal_resolution.py'
    return 'postlayout.py'


def code_dependencies(entry):
    pending = [TOOLS/entry]; found = set()
    while pending:
        path = pending.pop().resolve()
        if path in found: continue
        found.add(path)
        for node in ast.walk(ast.parse(path.read_text())):
            names = ([node.module] if isinstance(node, ast.ImportFrom) and node.module
                     else [x.name for x in node.names] if isinstance(node, ast.Import) else [])
            for name in names:
                for base in (path.parent, TOOLS, ROOT/'scripts'):
                    target = base/(name+'.py')
                    if target.is_file():
                        pending.append(target); break
    return sorted(found)


def design_inputs():
    paths = set(SCHEMATICS.glob('*.sch')) | set(SCHEMATICS.glob('*.sym'))
    paths |= set((HERE/'rtl').glob('*.v')) | set((HERE/'tb').glob('*.sv'))
    paths |= {HERE/'layout/sram512.gds', HERE/'layout/sram512_mask.gds',
              HERE/'design.json', HERE/'analog_scenario.json',
              ROOT/'pdk/profiles.lock.json', ROOT/'klayout/sram_pcell/build.py',
              ROOT/'klayout/dense_sram/build.py'}
    return sorted(paths)


def hashes(paths):
    return {str(p.relative_to(ROOT)): sha(p) for p in paths}


def file_digest(path):
    h=hashlib.sha256()
    with Path(path).open('rb') as f:
        for block in iter(lambda:f.read(1024*1024),b''):h.update(block)
    return h.hexdigest()


def simulation_artifacts(name):
    folder=WORK/'analog'/name.removeprefix('analog_')
    names=('test.spice','scenario.json','physical_devices.json','wire_rc.json','power_rc.json',
           'simulation.log','sram512_tb.raw','startup.raw')
    return {str((folder/n).relative_to(ROOT)):file_digest(folder/n)
            for n in names if (folder/n).is_file()}


@lru_cache(maxsize=1)
def pdk_identity():
    revision = subprocess.check_output(['git','-C',PDK,'rev-parse','HEAD'],text=True).strip()
    digest = tree_digest(PDK)
    lock = locked()['profiles']['dev']
    if revision != lock['revision'] or digest != lock['tree_sha256']:
        raise RuntimeError('PDK differs from the pinned, unmodified dev profile.')
    return dict(revision=revision, tree_sha256=digest)


def snapshot(name):
    return dict(design=hashes(design_inputs()),
                test_code=hashes(code_dependencies(entry_point(name))), pdk=pdk_identity())


def record(name, before, origin, artifacts=None):
    # Do not reuse the pre-run PDK hash when checking for concurrent changes.
    pdk_identity.cache_clear()
    if snapshot(name) != before:
        raise RuntimeError('Verification inputs changed during execution: '+name)
    path = REPORTS/(name+'.json')
    result = json.loads(path.read_text())
    if result.get('passed') is not True:
        raise RuntimeError('Cannot record a passing receipt for a failed test: '+name)
    receipt = dict(format_version=1, recorded_utc=datetime.now(timezone.utc).isoformat(),
                   test=name, report_sha256=sha(path), inputs=before,
                   origin=origin, artifacts=artifacts or {})
    write_json(RECEIPTS/(name+'.json'),receipt)
    return receipt


def check(name):
    path = RECEIPTS/(name+'.json')
    if not path.exists(): return False, ['Missing verification receipt'], None
    receipt = json.loads(path.read_text()); errors = []
    if sha(REPORTS/(name+'.json')) != receipt['report_sha256']:
        errors.append('Result changed after verification')
    actual = snapshot(name)
    for group in ('design','test_code'):
        expected = receipt['inputs'][group]
        for name in sorted(set(expected)|set(actual[group])):
            if expected.get(name) != actual[group].get(name): errors.append('Changed '+name)
    if receipt['inputs']['pdk'] != actual['pdk']: errors.append('Changed PDK/models')
    for name,digest in receipt.get('origin',{}).get('assessment_code',{}).items():
        if not (ROOT/name).is_file() or sha(ROOT/name)!=digest:
            errors.append('Changed reassessment code '+name)
    for name,digest in receipt.get('artifacts',{}).items():
        # Small secondary test results are part of acceptance. Large raw files
        # are checked when reused and are deliberately absent from archives.
        if name.startswith('sram512/reports/') and (
                not (ROOT/name).is_file() or sha(ROOT/name)!=digest):
            errors.append('Changed supporting result '+name)
    return not errors, errors, dict(path=str(path.relative_to(ROOT)),sha256=sha(path))


def run_verified(names, command):
    """Run actual verification first, then bind only its successful reports."""
    before = {name:snapshot(name) for name in names}
    started = datetime.now(timezone.utc).isoformat()
    # A stale passing report cannot stand in for a command that writes nothing.
    prior = {name:(REPORTS/(name+'.json')).stat().st_mtime_ns
             if (REPORTS/(name+'.json')).exists() else None for name in names}
    code = subprocess.call(command,cwd=ROOT,env=ENV)
    if code: return code
    for name in names:
        path = REPORTS/(name+'.json')
        if not path.exists() or path.stat().st_mtime_ns == prior[name]:
            raise RuntimeError('Command did not produce the required report: '+name)
        record(name,before[name],dict(kind='verification_command',started_utc=started,command=command),
               artifacts=simulation_artifacts(name))
    return 0


if __name__ == '__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--report',action='append',required=True)
    parser.add_argument('command',nargs=argparse.REMAINDER)
    args=parser.parse_args();command=args.command
    if command and command[0]=='--': command=command[1:]
    if not command: parser.error('A verification command is required.')
    raise SystemExit(run_verified(args.report,command))
