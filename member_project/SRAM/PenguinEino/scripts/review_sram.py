#!/usr/bin/env python3
"""Run the bounded schematic review experiments on the current controller.

Updated for the shared receive/access FF bank on 2026-09-12. The earlier
2026-09-11 results document the previous double-bank circuit.

First run verify_serial_spice.py to netlist the current schematics. This script
reads that netlist and creates diagnostic copies; it never edits schematics or
the PDK. Load/temperature/voltage probes are NOT foundry process corners or PEX.
Outputs (including potentially large waveforms) stay under build/serial_spice/.
"""
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor
import argparse
import hashlib
import json
import re
import subprocess

import numpy as np

from serial_spice_stimulus import scenario

ROOT = Path(__file__).resolve().parents[1]
BASE = ROOT / 'build/serial_spice'
OUT = BASE / 'review_20260911'


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def subcircuits(netlist):
    flat = re.sub(r'\n\+\s*', ' ', netlist)
    return {m[1].lower(): (m[2].lower().split(), m[3]) for m in re.finditer(
        r'(?ims)^\.subckt\s+(\S+)[ \t]+([^\n]+)\n(.*?)^\.ends[^\n]*', flat)}


def controller_truth(netlist):
    """Enumerate all 13 storage bits and SDI/WE/SOUT: 65,536 assignments.

    DFFR is an ideal positive-edge FF with active-HIGH asynchronous reset;
    combinational standard cells are evaluated by their named Boolean function.
    This checks the hand-mapped netlist's logic, not analog FF characterization.
    """
    subs = subcircuits(netlist)
    cells = []
    for line in subs['sram_serial_controller'][1].splitlines():
        if line.lower().startswith('x'):
            words = line.lower().split()
            cells.append((words[0], words[-1], dict(zip(subs[words[-1]][0], words[1:-1]))))
    ffs = [c for c in cells if c[1] == 'dffr']
    assert len(ffs) == 13
    assignments = np.arange(1 << (len(ffs)+3), dtype=np.uint32)
    values = {'vdd': np.ones(len(assignments), dtype=bool),
              'vss': np.zeros(len(assignments), dtype=bool)}
    for bit, (_, _, ports) in enumerate(ffs):
        values[ports['q']] = (assignments >> bit & 1).astype(bool)
        values[ports['qb']] = ~values[ports['q']]
    for bit, name in enumerate(('sdi', 'we', 'sout'), len(ffs)):
        values[name] = (assignments >> bit & 1).astype(bool)
    pending = [c for c in cells if c[1] != 'dffr']
    while pending:
        remaining = []
        for name, kind, ports in pending:
            inputs = ['a'] if kind == 'inv_x1' else (['a', 'b', 's'] if kind == 'mux2'
                else [p for p in ('a', 'b', 'c', 'd') if p in ports])
            if any(ports[p] not in values for p in inputs):
                remaining.append((name, kind, ports))
                continue
            a = [values[ports[p]] for p in inputs]
            if kind == 'inv_x1': y = ~a[0]
            elif kind == 'mux2': y = np.where(a[2], a[1], a[0])
            elif kind == 'xor2': y = a[0] ^ a[1]
            elif kind.startswith(('and', 'nand')):
                y = np.logical_and.reduce(a)
                if kind.startswith('nand'): y = ~y
            elif kind.startswith(('or', 'nor')):
                y = np.logical_or.reduce(a)
                if kind.startswith('nor'): y = ~y
            else: raise ValueError(f'Unsupported cell {kind}')
            values[ports['y']] = y
        assert len(remaining) < len(pending), 'Unresolved combinational network'
        pending = remaining
    count = sum(values[f'c{i}'].astype(np.uint32) << i for i in range(4))
    expected_count = np.where(count < 10, count + 1, 0)
    rx, e0 = count < 3, count == 3
    expected = {f'c{i}': (expected_count >> i & 1).astype(bool) for i in range(4)}
    expected.update({
        'din': np.where(rx, values['sdi'], values['din']),
        'ca': np.where(rx, values['din'], values['ca']),
        'ra': np.where(rx, values['ca'], values['ra']),
        'w': np.where(e0, values['we'], values['w']),
        'pc_on': e0,
        'wl_en': (count == 6) | (count == 7),
        'write_en': (count >= 5) & (count <= 8) & values['w'],
        'track': (e0 & ~values['we']) | ((count >= 4) & (count <= 6) & ~values['w']),
        'sdo': np.where((count == 9) & ~values['w'], values['sout'], values['sdo']),
    })
    failures = {ports['q']: int(np.count_nonzero(values[ports['d']] != expected[ports['q']]))
                for _, _, ports in ffs}
    assert not any(failures.values()), failures
    assert all(p['rst'] == 'reset' and p['ck'] == 'clk' for _, _, p in ffs)
    assert next(p for _, _, p in ffs if p['q'] == 'pc_on')['qb'] == 'preb'
    assert next(p for _, _, p in ffs if p['q'] == 'track')['qb'] == 'sae'
    return {'assignments': len(assignments), 'next_state_bit_comparisons': len(assignments)*len(ffs),
            'failures': failures, 'reset_clock_and_inverted_output_connections': 'pass'}


def waveform(path):
    with path.open() as f:
        names = f.readline().lower().split()
    a = np.loadtxt(path, skiprows=1)
    return a[:, 0] * 1e9, {n: a[:, i] for i, n in enumerate(names)}


def analyze(path, vdd=5):
    t, vectors = waveform(path)
    val = lambda name: vectors[f'v({name.lower()})']
    at = lambda name, time: float(np.interp(time, t, val(name)))
    errors = []; checks = 0; known = {}; reads = []; writes = []; halfselect = []

    def level(name, bit, a, b=None, category='logic', rail=True):
        nonlocal checks
        checks += 1
        data = np.array([at(name, a)]) if b is None else val(name)[(t >= a) & (t <= b)]
        assert len(data)
        lo, hi = float(data.min()), float(data.max())
        limit = vdd * ((.9 if bit else .1) if rail else .5)
        if not np.isfinite(data).all() or (lo < limit if bit else hi > limit):
            errors.append(dict(category=category, net=name, bit=int(bit), start_ns=a,
                               end_ns=b, min_v=lo, max_v=hi))

    # Same independently simulated RTL as the baseline; all 13 state bits.
    for line in (BASE / 'rtl_reference.tsv').read_text().splitlines()[1:]:
        fields = line.split(); a = float(fields[0]); count = int(fields[1]); shift = int(fields[2])
        for i in range(4): level(f'xctrl.C{i}', count >> i & 1, a, category='controller')
        for i,n in enumerate(('DIN','CA','RA')): level(n, shift >> i & 1, a, category='controller')
        for n, b in zip(('RA','CA','DIN','xctrl.W','PREB','WRITE_EN','WL_EN','SAE','SDO'), fields[3:]):
            level(n, int(b), a, category='sdo' if n == 'SDO' else 'controller')
    for i, op in enumerate(scenario()['operations']):
        a = op['e0']; row = op['row']; col = op['col']; bit = op['data']
        for name in ('BL0','BLB0','BL1','BLB1','Y','YB'):
            level(name, 1, a+80, a+95, category='precharge')
        for (r,c), stored in known.items():
            if op['write'] and (r,c) == (row,col): continue
            for prefix, b in (('Q', stored), ('QB', 1-stored)):
                level(f'{prefix}{r}{c}', b, op['first']+35, a+795, category='retention', rail=False)
            if r == row and c != col:
                low = val(f'{"QB" if stored else "Q"}{r}{c}')[(t >= a+300) & (t <= a+535)]
                halfselect.append(float(low.max()))
        if op['write']:
            known[row,col] = bit
            writes.append({'operation': i, 'cell_v_before_wl_off': at(f'Q{row}{col}', a+499),
                           'driven_bitline_v_before_wl': at(f'{"BLB" if bit else "BL"}{col}', a+299)})
        else:
            for name in ('SOUT','SOUTB'):
                level(name, 1, a+80, a+95, category='sa_reset')
            level('SOUT', bit, a+450, a+695, category='sense')
            level('SOUTB', 1-bit, a+450, a+695, category='sense')
            level('SDO', bit, a+635, a+795, category='sdo')
            reads.append({'operation':i, 'expected':bit,
                          'signed_y_diff_v_before_e4': (1 if bit else -1)*(at('Y',a+399)-at('YB',a+399)),
                          'signed_sa_diff_v_before_e4': (1 if bit else -1)*(at('SOUT',a+399)-at('SOUTB',a+399)),
                          'sdo_v_at_e7_plus80':at('SDO',a+780)})
        for (r,c), stored in known.items():
            level(f'Q{r}{c}', stored, a+750, a+790, category='stored')
            level(f'QB{r}{c}', 1-stored, a+750, a+790, category='stored')
    return {'checks': checks, 'failure_count':len(errors),
            'failure_categories':{c:sum(e['category']==c for e in errors) for c in sorted({e['category'] for e in errors})},
            'first_failures':errors[:20], 'reads':reads, 'writes':writes,
            'max_halfselected_low_node_v':max(halfselect),
            'min_read_y_diff_v':min(r['signed_y_diff_v_before_e4'] for r in reads),
            'min_read_sa_diff_v':min(r['signed_sa_diff_v_before_e4'] for r in reads)}


def simulate(netlist, case):
    name, vdd, temp, cbl, cy, *output_load = case
    csdo = output_load[0] if output_load else '10f'
    work = OUT / name; work.mkdir(parents=True, exist_ok=True)
    netlist = re.sub(r'(?m)^VVDD VDD GND 5$', f'VVDD VDD GND {vdd}', netlist)
    # Input voltage amplitudes track VDD; edge times and protocol are unchanged.
    def scale_source(m):
        flat = re.sub(r'\n\+\s*', ' ', m[0])
        return re.sub(r'(?<= )5(?=[ )])', str(vdd), flat)
    netlist = re.sub(r'(?m)^V(?:CLK|RESET|SDI|WE) [^\n]+(?:\n\+[^\n]+)*', scale_source, netlist)
    netlist = netlist.replace('.param CBL=10f CY=100f', f'.param CBL={cbl} CY={cy}\n.temp {temp}')
    netlist = re.sub(r'(?m)^CSDO SDO GND 10f$', f'CSDO SDO GND {csdo}', netlist)
    controls = f'''.control
set noaskquit
tran 0.5n {scenario()['stop']}n
set wr_singlescale
set wr_vecnames
'''
    wrdata = next(s for s in netlist.splitlines() if s.startswith('wrdata serial_spice_waveforms.txt '))
    controls += wrdata + '\nquit\n.endc'
    netlist = re.sub(r'(?s)\.control\n.*?\.endc', lambda _: controls, netlist)
    deck = work / 'test.spice'; deck.write_text(netlist)
    with (work / 'ngspice.log').open('w') as stream:
        result = subprocess.run(['ngspice','-b','test.spice'], cwd=work, stdout=stream, stderr=subprocess.STDOUT)
    log = (work / 'ngspice.log').read_text()
    if result.returncode or re.search(r'(?im)^(error|warning)', log):
        raise RuntimeError(f'Simulation failed: {work}')
    report = analyze(work / 'serial_spice_waveforms.txt', vdd)
    report.update(name=name, vdd_v=vdd, temperature_c=temp, cbl=cbl, cy=cy, csdo=csdo, deck_sha256=sha(deck))
    print(name, 'failures:', report['failure_categories'], 'minimum read differential:', report['min_read_y_diff_v'], flush=True)
    (work / 'result.json').write_text(json.dumps(report, indent=2)+'\n')
    return report


def static_noise_margins(netlist):
    """DC butterfly estimates; ideal BL=BLB=VDD, no device mismatch.

    A storage node is voltage-clamped to trace the other inverter's VTC;
    both clamp directions are used. The square estimate uses the 45-degree
    rotation, as in the existing cell-layout comparison. Step is 2.5 mV.
    """
    cell = re.search(r'(?ims)^\.subckt sram .*?^\.ends[^\n]*', netlist)[0]
    include = re.search(r'(?m)^\s*\.include .*ip62_models', netlist)[0].strip()
    result = []
    for supply, temp in [(5,27), (4.5,27), (5,150), (4.5,150)]:
        for read in (False, True):
            curves = []
            for force, output in [('q','qb'), ('qb','q')]:
                work = OUT / 'dc' / f'{supply}_{temp}_{read}_{force}'
                work.mkdir(parents=True, exist_ok=True)
                deck = f'''Cell DC transfer curve (diagnostic, ideal bitlines)
{include}
.temp {temp}
VDD vdd 0 {supply}
VWL wl 0 {supply if read else 0}
Vforce {force} 0 0
Xcell wl vdd vdd q qb vdd 0 sram
{cell}
.control
set wr_singlescale
set wr_vecnames
dc Vforce 0 {supply} 0.0025
wrdata curve.txt v({force}) v({output})
quit
.endc
.end
'''
                (work/'dc.spice').write_text(deck)
                with (work/'dc.log').open('w') as stream:
                    process = subprocess.run(['ngspice','-b','dc.spice'], cwd=work,
                                             stdout=stream, stderr=subprocess.STDOUT)
                log = (work/'dc.log').read_text()
                if process.returncode or re.search(r'(?im)^(error|warning)', log):
                    raise RuntimeError(f'DC analysis failed: {work}')
                a = np.loadtxt(work/'curve.txt', skiprows=1)
                x, y = a[:,1], a[:,2]
                curves.append((x,y) if force == 'q' else (y,x))
            rotated = []
            for x, y in curves:
                u = (x-y)/np.sqrt(2); v = (x+y)/np.sqrt(2); ix = np.argsort(u)
                rotated.append((u[ix],v[ix]))
            u = np.linspace(max(a[0][0] for a in rotated), min(a[0][-1] for a in rotated), 20001)
            d = np.interp(u,*rotated[0])-np.interp(u,*rotated[1])
            snm = float(min(d.max(),-d.min())/np.sqrt(2))
            result.append(dict(vdd=supply, temp=temp, read=read, snm_v=snm, dc_step_v=.0025))
    (OUT/'dc/results.json').write_text(json.dumps(result,indent=2)+'\n')
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--skip-stress', action='store_true')
    args = parser.parse_args()
    OUT.mkdir(parents=True, exist_ok=True)
    netfile = BASE / 'sram_tb_serial.spice'
    netlist = netfile.read_text()
    model_include = Path(re.search(r'(?m)^\s*\.include (.*ip62_models)', netlist)[1])
    report = {'scope':'Schematic-only review; diagnostic loads are not extracted or foundry corners.',
              'files_sha256':{str(p.relative_to(ROOT)):sha(p) for p in
                    [netfile, ROOT/'learning/schematics/sram_tb_serial.sch', ROOT/'learning/schematics/sram_serial_controller.sch', ROOT/'learning/schematics/sram.sch',
                     ROOT/'sram512/schematics/sense_amp_7t.sch', ROOT/'sram512/rtl/sram_serial_controller.v']},
              'controller_truth':controller_truth(netlist),
              'baseline':analyze(BASE / 'serial_spice_waveforms.txt')}
    for p in (model_include, model_include.parent/'models_IP62_mos_v2.lib'):
        report['files_sha256'][str(p)] = sha(p)
    print('Controller truth table PASS:', report['controller_truth']['assignments'], 'assignments', flush=True)
    print('Baseline failures:',report['baseline']['failure_categories'], flush=True)
    report['static_noise_margins'] = static_noise_margins(netlist)
    if not args.skip_stress:
        cases = [('cap_1p',5,27,'1p','1p'), ('cap_5p',5,27,'5p','5p'),
                 ('cap_10p',5,27,'10p','10p'), ('hot_150',5,150,'10f','100f'),
                 ('low_hot',4.5,150,'10f','100f'), ('cap_1p_hot',5,150,'1p','1p'),
                 ('sdo_10p',5,27,'10f','100f','10p')]
        with ThreadPoolExecutor(max_workers=2) as pool:
            report['stress'] = list(pool.map(lambda c: simulate(netlist,c), cases))
    (OUT/'results.json').write_text(json.dumps(report,indent=2)+'\n')
    print('Results:', OUT/'results.json',flush=True)


if __name__ == '__main__':
    main()
