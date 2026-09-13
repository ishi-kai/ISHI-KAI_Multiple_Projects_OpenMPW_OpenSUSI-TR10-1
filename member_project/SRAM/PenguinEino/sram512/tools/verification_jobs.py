#!/usr/bin/env python3
"""Run named electrical checks independently of the desktop process.

Only explicit `start` launches work. Completed evidence is never overwritten
by a restart; interrupted directories are preserved. VM restart still stops
ngspice and requires a fresh transient analysis.
"""
import argparse
from datetime import datetime, timezone
from common import *

FOLDER = WORK / 'layout/decoder_gcwide16x32_rev3'
if not FOLDER.exists():FOLDER = WORK / 'layout/rechecked16x32'
JOBS = WORK / 'jobs'
POWER = ['--physical-gate-paths', '--power-sheet', '0.1', '--power-mesh-grid', '0.25',
         '--voltage-envelope', '--startup-ramp-ns', '1000', '--period', '5000',
         '--max-step-ns', '20', '--solver', 'klu', '--pivrel', '0.1', '--stream']
CASES = {
    'pd102_decode_coverage': ['postlayout.py', '--decode-coverage', '--solver', 'klu', '--stream'],
    'pd102_operational_hot': ['operational_tests.py', '--solver', 'klu', '--pivrel', '0.1', '--stream'],
    'pd102_power_paths_ramp': ['postlayout.py', '--rc-scale', '1'] + POWER,
    'pd102_pg_rc3_lowhot_corner': ['postlayout.py', '--rc-scale', '3', '--vdd', '4.5',
                                '--temperature', '85', '--addresses', '0'] + POWER,
}
SIGNAL_POWER = ['--physical-gate-paths','--signal-mesh','--signal-sections','4',
    '--power-sheet','0.1','--power-mesh-grid','0.25','--voltage-envelope',
    '--startup-ramp-ns','1000','--period','5000','--max-step-ns','20',
    '--solver','sparse','--stream']
SIGNAL_FIXED_CASES = {
    'signalfix_decode_coverage': ['postlayout.py','--decode-coverage','--solver','klu','--stream'],
    'signalfix_operational_hot': ['operational_tests.py','--solver','klu','--pivrel','0.1','--stream'],
    'signalfix_power_paths_ramp': ['postlayout.py','--rc-scale','1']+SIGNAL_POWER,
    'signalfix_pg_rc3_lowhot': ['postlayout.py','--rc-scale','3','--vdd','4.5','--temperature','85']+SIGNAL_POWER,
}
CASES.update(SIGNAL_FIXED_CASES)
CURRENT_CASES = {name.replace('signalfix_','decoderfix_',1):args
                 for name,args in SIGNAL_FIXED_CASES.items()}
CASES.update(CURRENT_CASES)


def now():
    return datetime.now(timezone.utc).isoformat()


def state_path(name):
    return JOBS / (name + '.json')


def save(name, state):
    temp = state_path(name).with_suffix('.tmp')
    write_json(temp, state)
    temp.replace(state_path(name))


def running(state):
    if state.get('boot_id') != Path('/proc/sys/kernel/random/boot_id').read_text().strip():
        return False
    if state.get('state') != 'RUNNING':
        return False
    try:
        cmd = Path(f'/proc/{state["pid"]}/cmdline').read_bytes().split(b'\0')
    except FileNotFoundError:
        return False
    return str(Path(__file__).resolve()).encode() in cmd and b'run' in cmd and state['name'].encode() in cmd


def status(name):
    path = state_path(name)
    if not path.exists():
        return dict(name=name, state='NOT_STARTED')
    state = json.loads(path.read_text())
    if state['state'] == 'RUNNING' and not running(state):
        state['state'] = 'INTERRUPTED'
    if state['state'] == 'RUNNING':
        work = WORK / 'analog' / name
        log = work / 'simulation.log'
        deck = work / 'test.spice'
        if log.exists() and deck.exists():
            with log.open('rb') as f:
                f.seek(max(0, log.stat().st_size - 8192))
                tail = f.read().decode(errors='replace')
            last = re.findall(r'Reference value\s*:\s*([0-9.eE+\-]+)', tail)
            stop = re.search(r'(?im)^\.?tran\s+\S+\s+([0-9.eE+\-]+)([munpf]?)\b', deck.read_text())
            if last and stop:
                unit = {'':1, 'm':1e-3, 'u':1e-6, 'n':1e-9, 'p':1e-12, 'f':1e-15}
                state['simulation_time_us'] = float(last[-1]) * 1e6
                state['simulation_stop_us'] = float(stop[1]) * unit[stop[2].lower()] * 1e6
    return state


def execute(name,folder):
    spec = CASES[name]
    folder=Path(folder).resolve()
    command = [sys.executable, str(TOOLS / spec[0]), str(folder), '--name', name] + spec[1:]
    state = dict(name=name, state='RUNNING', pid=os.getpid(), started_utc=now(),
                 boot_id=Path('/proc/sys/kernel/random/boot_id').read_text().strip(),
                 command=command, source_gds_sha256=sha(folder / 'sram512.gds'))
    save(name, state)
    code = subprocess.call(command, cwd=ROOT, env=ENV)
    report = REPORTS / (name + '.json')
    passed = code == 0 and report.exists() and json.loads(report.read_text()).get('passed') is True
    state.update(state='PASS' if passed else 'FAIL', exit_code=code, finished_utc=now())
    if report.exists():
        state['report_sha256'] = sha(report)
    save(name, state)
    return code if code else (0 if passed else 1)


def start(name,folder):
    if running(status(name)):
        print(name, 'already running')
        return
    work = WORK / 'analog' / name
    report = work / 'result.json'
    if report.exists() and json.loads(report.read_text()).get('passed'):
        from validation_summary import source_gds
        assert source_gds(json.loads(report.read_text())) == sha(folder / 'sram512.gds'), 'Passing evidence belongs to another GDS; keep it and choose a new case name.'
        print(name, 'already passed; kept unchanged')
        return
    if work.exists():
        suffix = datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%S%fZ')
        work.rename(work.with_name(name + '_interrupted_' + suffix))
    with (JOBS / (name + '.log')).open('w') as log:
        process = subprocess.Popen([sys.executable, str(Path(__file__).resolve()), 'run', name,
                                    '--folder',str(folder)],
            cwd=ROOT, env=ENV, stdin=subprocess.DEVNULL, stdout=log, stderr=subprocess.STDOUT,
            start_new_session=True)
    print(name, 'started', process.pid)


if __name__ == '__main__':
    p = argparse.ArgumentParser()
    p.add_argument('action', choices=['start', 'run', 'status'])
    p.add_argument('names', nargs='*', choices=list(CASES))
    p.add_argument('--folder',type=Path,default=FOLDER)
    args = p.parse_args()
    JOBS.mkdir(parents=True, exist_ok=True)
    names = args.names or list(CURRENT_CASES)
    if args.action == 'run':
        assert len(names) == 1
        raise SystemExit(execute(names[0],args.folder))
    for name in names:
        if args.action == 'start':
            start(name,args.folder.resolve())
        else:
            s = status(name)
            progress = (f'{s["simulation_time_us"]:.2f}/{s["simulation_stop_us"]:.2f} us'
                        if 'simulation_time_us' in s else s.get('finished_utc', ''))
            print(name, s['state'], s.get('pid'), progress)
