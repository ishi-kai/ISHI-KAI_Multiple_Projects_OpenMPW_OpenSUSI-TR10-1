"""Verify the Xschem FA testbench and all 702 directed input transitions.

Run: python3 scripts/check_full_adder.py
Uses the installed dev PDK, fresh netlisting, and unmodified schematic devices.
Results: reports/full_adder.json; waveforms/logs: simulation/full_adder_checks/.
"""
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor
import hashlib
import itertools
import json
import re
import subprocess

import numpy as np

ROOT = Path(__file__).resolve().parents[1]
WORK = ROOT / 'simulation/full_adder_checks'
PDK = Path('/home/ishi-kai/pdk/TR-1um')
STATES = list(itertools.product((-5, 0, 5), repeat=3))
PROBES = ['a', 'b', 'cin', 'sum', 'cout', 'xdut.s1', 'xdut.c1', 'xdut.c2', 'xdut.nc']
VECTORS = ' '.join(f'v({n})' for n in PROBES)
HOLD_NS = 200


def arithmetic(a, b, cin):
    # Independent balanced-radix arithmetic oracle; no gate-level implementation.
    total = (a + b + cin) // 5
    carry = (total + 1) // 3
    return 5 * (total - 3 * carry), 5 * carry


def expected(state):
    a, b, cin = state
    s, c = arithmetic(a, b, cin)
    s1, c1 = arithmetic(a, b, 0)
    _, c2 = arithmetic(s1, cin, 0)
    return np.array([s, c, s1, c1, c2, -c])


def route():
    adj = {i: [j for j in range(27) if j != i] for i in range(27)}
    stack, out = [0], []
    while stack:
        if adj[stack[-1]]:
            stack.append(adj[stack[-1]].pop())
        else:
            out.append(stack.pop())
    out.reverse()
    assert len(out) == 703 and len(set(zip(out, out[1:]))) == 702
    return out


def netlist():
    WORK.mkdir(parents=True, exist_ok=True)
    rc = WORK / 'xschemrc'
    rc.write_text(
        f'set XSCHEM_LIBRARY_PATH {{{ROOT}:/usr/local/share/xschem/xschem_library:'
        f'{PDK}/libs.tech/xschem:{PDK}/libs.tech/xschem/TR-1umLIB}}\n'
        f'set LIB {{{PDK}/libs.tech/spice/models}}\n'
        'set lvs_netlist 0\nset top_is_subckt 0\nset spiceprefix 1\n')
    p = subprocess.run([
        'xschem', '-r', '-x', '--rcfile', str(rc), '-s', '--command',
        'set result [xschem netlist]; puts [xschem get infowindow_text]; exit $result',
        '-o', str(WORK), str(ROOT / 'full_adder_tb.sch')],
        capture_output=True, text=True, timeout=60)
    log = p.stdout + p.stderr
    (WORK / 'netlist.log').write_text(log)
    if p.returncode or re.search(r'Error:|SKIPPING|IS MISSING', log):
        raise RuntimeError('FA netlisting failed: ' + log[-2000:])
    base = re.sub(r'\n\+\s*', ' ', (WORK / 'full_adder_tb.spice').read_text())
    definitions = re.findall(r'^\.subckt\s+(\S+)', base, re.M | re.I)
    assert sorted(definitions) == ['full_adder', 'half_adder', 'inverter', 'nany']
    return base


def simulate(folder, text):
    folder.mkdir(parents=True, exist_ok=True)
    (folder / 'tb.spice').write_text(text)
    with (folder / 'run.log').open('w') as output:
        p = subprocess.run(['ngspice', '-b', 'tb.spice'], cwd=folder,
                           stdout=output, stderr=subprocess.STDOUT, timeout=1200)
    log = (folder / 'run.log').read_text()
    if p.returncode or re.search(r'Error:|FAIL:|failed|Timestep too small', log, re.I):
        raise RuntimeError(f'{folder.name} failed; see {folder}/run.log')
    return log


def evaluate(path, sequence):
    data = np.loadtxt(path, skiprows=1)
    if data.shape[1] != 10 or not np.isfinite(data).all() or np.max(abs(data[:, 1:])) > 7:
        raise RuntimeError('Missing/nonphysical waveform: ' + str(path))
    time = data[:, 0] * 1e9
    if time[-1] < len(sequence) * HOLD_NS - .01:
        raise RuntimeError('Truncated simulation: ' + str(path))
    rows = []
    for k, state in enumerate(sequence):
        start, end = k * HOLD_NS, (k + 1) * HOLD_NS - 1
        target = expected(state)
        observed = np.array([np.interp(end, time, data[:, j]) for j in range(4, 10)])
        inputs = np.array([np.interp(end, time, data[:, j]) for j in range(1, 4)])
        assert np.max(abs(inputs - state)) < 1e-5
        idx = np.flatnonzero((time >= start + 1) & (time <= end))
        bad = np.flatnonzero(np.any(abs(data[idx, 4:6] - target[:2]) > .5, axis=1))
        settling = (0.0 if not len(bad) else
                    float(time[idx[bad[-1] + 1]] - start - 1) if bad[-1] < len(idx) - 1 else None)
        rows.append(dict(old=sequence[k-1] if k else None, new=state,
                         sum_v=float(observed[0]), cout_v=float(observed[1]),
                         output_error_v=float(np.max(abs(observed[:2] - target[:2]))),
                         max_interconnect_error_v=float(np.max(abs(observed - target))),
                         settle_ns=settling))
    result = dict(samples=len(rows), transitions=len(rows)-1,
                  max_output_error_v=max(r['output_error_v'] for r in rows),
                  max_interconnect_error_v=max(r['max_interconnect_error_v'] for r in rows),
                  max_settle_ns=max((r['settle_ns'] for r in rows[1:] if r['settle_ns'] is not None), default=0),
                  unsettled=sum(r['settle_ns'] is None for r in rows),
                  rows=rows)
    result['passed'] = result['max_interconnect_error_v'] <= .5 and result['unsettled'] == 0
    return result


def exhaustive(base, cap):
    folder = WORK / f'transitions_{cap}f'
    sequence = [STATES[i] for i in route()]
    s = base
    for col, name in enumerate(('VA', 'VB', 'VCIN')):
        points = [f'0 {sequence[0][col]}']
        for k in range(1, len(sequence)):
            points.extend([f'{k * HOLD_NS}n {sequence[k-1][col]}',
                           f'{k * HOLD_NS + 1}n {sequence[k][col]}'])
        s, count = re.subn(r'^' + name + r' .*$',
                          f'{name} {PROBES[col]} 0 PWL(' + ' '.join(points) + ')', s, flags=re.M)
        assert count == 1
    for name in ('sum', 'cout'):
        s, count = re.subn(r'^C' + name + r' .*$', f'C{name} {name} 0 {cap}f', s, flags=re.M)
        assert count == 1
    control = (f'.control\nsave {VECTORS}\nset wr_singlescale\nset wr_vecnames\n'
               f'tran 2n {len(sequence) * HOLD_NS}n 0 2n\n'
               f'wrdata data.txt {VECTORS}\nquit\n.endc')
    s = re.sub(r'\.control.*?\.endc', lambda _: control, s, flags=re.S)
    simulate(folder, s)
    (folder / 'view.spice').write_text(s.replace('\nquit\n',
        "\nplot v(a) v(b) v(cin) v(sum) title 'Full Adder SUM'\n"
        "plot v(a) v(b) v(cin) v(cout) title 'Full Adder COUT'\n"))
    r = evaluate(folder / 'data.txt', sequence)
    r.update(mode=f'transitions_{cap}f', load_ff=cap, maximum_timestep_ns=2)
    (folder / 'results.json').write_text(json.dumps(r, indent=2) + '\n')
    return {k: v for k, v in r.items() if k != 'rows'}


def main():
    base = netlist()
    # Run the actual GUI TB controls, omitting only interactive plot windows.
    batch = re.sub(r'^plot .*\n', '', base, flags=re.M).replace('.endc', 'quit\n.endc')
    folder = WORK / 'tb_sequence'
    log = simulate(folder, batch)
    assert 'PASS: Full Adder' in log and 'const.failures = 0.000000e+00' in log
    assert len(re.findall(r'^tran_\d+_\w+\s+=', log, re.M)) == 28 * 6
    tb = evaluate(folder / 'full_adder_tran.txt', STATES + [STATES[0]])
    (folder / 'results.json').write_text(json.dumps(tb, indent=2) + '\n')
    rows = [dict(mode='tb_sequence', load_ff=10, maximum_timestep_ns=.5,
                 **{k: v for k, v in tb.items() if k != 'rows'})]
    print(rows[0], flush=True)
    with ThreadPoolExecutor(max_workers=2) as pool:
        for r in pool.map(lambda cap: exhaustive(base, cap), (10, 100)):
            rows.append(r)
            print(r, flush=True)
    files = [ROOT / f for f in ('full_adder.sch', 'full_adder.sym', 'full_adder_tb.sch',
                               'half_adder.sch', 'half_adder.sym', 'nany.sch', 'inverter.sch')]
    files += sorted((PDK / 'libs.tech/spice/models').rglob('*'))
    report = dict(passed=all(r['passed'] for r in rows), temperature_c=27,
                  supplies_v=dict(VDD=5, VMID=0, VSS=-5), edge_ns=1,
                  hold_ns=HOLD_NS, tolerance_v=.5, cases=rows,
                  source_sha256={str(p): hashlib.sha256(p.read_bytes()).hexdigest()
                                 for p in files if p.is_file()},
                  scope='Schematic simulation, ideal supplies; no layout parasitics, PVT or package load qualification.')
    (ROOT / 'reports/full_adder.json').write_text(json.dumps(report, indent=2) + '\n')
    if not report['passed']:
        raise RuntimeError('Full Adder verification failed')


if __name__ == '__main__':
    main()
