#!/usr/bin/env python3
"""Reproduce the shared-frame load regression without editing circuit sources.

Requires a fresh successful verify_serial_spice.py run. --section stress runs
the seven original voltage/temperature/load probes. --section comparison uses
the historical controller fixture with otherwise identical circuit/models,
then repeats the new controller with a 120 ns clock. Failures return status 1.
"""
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path
import argparse
import json
import re
import subprocess

import numpy as np

import review_sram as review
from serial_spice_stimulus import scenario, pwl

ROOT = Path(__file__).resolve().parents[1]
WORK = ROOT / 'build/shared_frame/retest_20260912'
FIXTURE = ROOT / 'reviews/fixtures/sram_serial_controller_double_bank.spice'


def compare_case(source, label, legacy=False, scale=1):
    work = WORK / 'load_comparison' / label; work.mkdir(parents=True, exist_ok=True)
    case = scenario(); timeline = [dict(e, time=e['time']*scale) for e in case['timeline']]
    deck = source.replace('.param CBL=10f CY=100f', '.param CBL=10p CY=10p\n.temp 27')
    if legacy:
        old = re.search(r'(?ims)^\.subckt sram_serial_controller .*?^\.ends[^\n]*', FIXTURE.read_text())[0]
        deck, count = re.subn(r'(?ims)^\.subckt sram_serial_controller .*?^\.ends[^\n]*', lambda _: old, deck)
        assert count == 1
    for pin in ('CLK', 'RESET', 'SDI', 'WE'):
        deck, count = re.subn(r'(?m)^V'+pin+r' [^\n]+(?:\n\+[^\n]+)*',
                             lambda _: f'V{pin} {pin} GND {pwl(pin,timeline)}', deck)
        assert count == 1
    wr = next(line for line in deck.splitlines() if line.startswith('wrdata serial_spice_waveforms.txt '))
    signals = wr.split('serial_spice_waveforms.txt ', 1)[1]
    control = f'.control\nset noaskquit\nsave {signals}\ntran 0.1n {case["stop"]*scale}n 0 0.1n\nset wr_singlescale\nset wr_vecnames\n{wr}\nquit\n.endc'
    deck = re.sub(r'(?s)\.control\n.*?\.endc', lambda _: control, deck)
    (work/'test.spice').write_text(deck)
    with (work/'simulation.log').open('w') as stream:
        p = subprocess.run(['ngspice', '-b', 'test.spice'], cwd=work, stdout=stream, stderr=subprocess.STDOUT)
    log = (work/'simulation.log').read_text()
    assert not p.returncode and not re.search(r'(?im)^error|^warning', log), work
    t, vectors = review.waveform(work/'serial_spice_waveforms.txt')
    at = lambda n, a: float(np.interp(a*scale, t, vectors[f'v({n.lower()})']))
    reads = []; known = {}; failures = []; checks = 0
    def level(n, bit, a, b):
        nonlocal checks
        checks += 1
        v = vectors[f'v({n.lower()})'][(t >= a*scale) & (t <= b*scale)]
        assert len(v) and np.isfinite(v).all()
        if v.min() < 4.5 if bit else v.max() > .5:
            failures.append(dict(net=n, expected=bit, start_ns=a*scale,
                                 end_ns=b*scale, min_v=float(v.min()), max_v=float(v.max())))
    for i, op in enumerate(case['operations']):
        a = op['e0']; bit = op['data']; row, col = op['row'], op['col']
        if op['write']: known[row, col] = bit
        else:
            for name, value in [('SOUT', bit), ('SOUTB', 1-bit)]: level(name, value, a+450, a+695)
            level('SDO', bit, a+635, a+795)
            reads.append(dict(operation=i, row=row, col=col, expected=bit,
                              signed_y_diff_before_e4_v=(1 if bit else -1)*(at('Y',a+399)-at('YB',a+399)),
                              signed_sa_diff_before_e4_v=(1 if bit else -1)*(at('SOUT',a+399)-at('SOUTB',a+399)),
                              sdo_v=at('SDO',a+780)))
        for (r,c),value in known.items():
            level(f'Q{r}{c}',value,a+750,a+790);level(f'QB{r}{c}',1-value,a+750,a+790)
    result = dict(name=label, clock_ns=100*scale, max_step_ns=.1, cbl='10p', cy='10p',
                  vdd_v=5, temperature_c=27, checks=checks, failures=failures, passed=not failures,
                  reads=reads, wrong_read_operations=[r['operation'] for r in reads if (r['sdo_v']<4.5 if r['expected'] else r['sdo_v']>.5)],
                  deck_sha256=review.sha(work/'test.spice'), legacy_controller=legacy,
                  scope='Read SA/SDO windows and all written-cell final values; legacy internal RX addresses intentionally differ.')
    (work/'result.json').write_text(json.dumps(result,indent=2)+'\n')
    print(label, 'wrong reads:', result['wrong_read_operations'], flush=True)
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--section', choices=('stress','comparison'), required=True)
    parser.add_argument('--jobs', type=int, default=2)
    args = parser.parse_args(); WORK.mkdir(parents=True, exist_ok=True)
    source = (review.BASE/'sram_tb_serial.spice').read_text()
    if args.section == 'stress':
        review.OUT = WORK / 'stress'
        cases = [('cap_1p',5,27,'1p','1p'), ('cap_5p',5,27,'5p','5p'),
                 ('cap_10p',5,27,'10p','10p'), ('hot_150',5,150,'10f','100f'),
                 ('low_hot',4.5,150,'10f','100f'), ('cap_1p_hot',5,150,'1p','1p'),
                 ('sdo_10p',5,27,'10f','100f','10p')]
        with ThreadPoolExecutor(max_workers=args.jobs) as pool:
            result = list(pool.map(lambda c: review.simulate(source,c),cases))
        passed = all(r['failure_count']==0 for r in result)
    else:
        cases = [('old_100ns',True,1), ('shared_100ns',False,1), ('shared_120ns',False,1.2)]
        with ThreadPoolExecutor(max_workers=args.jobs) as pool:
            result = list(pool.map(lambda c: compare_case(source,*c),cases))
        passed = all(r['passed'] for r in result)
    (WORK/f'{args.section}_load_results.json').write_text(json.dumps(result,indent=2)+'\n')
    raise SystemExit(0 if passed else 1)


if __name__ == '__main__':
    main()
