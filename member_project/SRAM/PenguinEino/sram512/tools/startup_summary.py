#!/usr/bin/env python3
"""Compare startup step sizes and plot the finer extracted-circuit waveform."""
import os
import tempfile
import argparse
os.environ.setdefault("MPLCONFIGDIR", os.path.join(tempfile.gettempdir(), "sram512-matplotlib"))
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from common import *
from analog import load_raw


def compare_solvers():
    names = ['pd102_startup_5n', 'pd102_startup_klu_pivot']
    folders = [WORK / 'analog' / n for n in names]
    results = [json.loads((p / 'result.json').read_text()) for p in folders]
    assert all(r['passed'] for r in results)
    normalized = [re.sub(r'(?m)^\.options (?:klu|pivrel=\S+)\n', '',
                         (p / 'test.spice').read_text()) for p in folders]
    assert normalized[0] == normalized[1]
    waves = [load_raw(p / 'startup.raw') for p in folders]
    rows = []
    for node in waves[0][1]:
        if not node.startswith('v('):
            continue
        reference = np.interp(waves[1][0], waves[0][0], waves[0][1][node])
        difference = float(np.max(np.abs(reference - waves[1][1][node])))
        rows.append(dict(node=node, maximum_interpolated_difference_v=difference))
    tolerance = .02
    report = dict(passed=max(x['maximum_interpolated_difference_v'] for x in rows) < tolerance,
        source_gds_sha256=results[0]['physical_extraction']['gds_sha256'],
        waveform_comparison_tolerance_v=tolerance,
        scope='Identical complete startup network and stimuli; only matrix solver and numerical pivot selection differ. Both runs independently pass all original functional, voltage and current limits.',
        runs=[dict(name=n, deck_sha256=r['deck_sha256'], elapsed_seconds=r['elapsed_seconds'],
                   checks=r['checks'], peak_voltage_v=max(a['peak_abs_v'] for a in r['voltage_limits']['maximum_by_pair'].values()),
                   peak_via_a=r['via_currents']['maximum_peak_a']) for n,r in zip(names,results)],
        nodes_compared=len(rows),
        maximum_differences=sorted(rows, key=lambda x:-x['maximum_interpolated_difference_v'])[:10])
    write_json(REPORTS / 'startup_pivot_validation.json', report)
    print('Startup solver comparison:', report['passed'], report['maximum_differences'][0], flush=True)
    return report


def main(prefix='pd102',check_solver=True):
    names = [prefix+'_startup_5n', prefix+'_startup_1n']
    folders = [WORK / 'analog' / n for n in names]
    results = [json.loads((p / 'result.json').read_text()) for p in folders]
    assert all(r['passed'] for r in results)
    decks = [re.sub(r'(?m)^(\.?tran \S+ \S+ 0) \S+$', r'\1 MAXSTEP',
                    (p / 'test.spice').read_text()) for p in folders]
    assert decks[0] == decks[1]
    assert results[0]['physical_extraction']['gds_sha256']==results[1]['physical_extraction']['gds_sha256']
    volts = [max(x['peak_abs_v'] for x in r['voltage_limits']['maximum_by_pair'].values()) for r in results]
    currents = [r['via_currents']['maximum_peak_a'] for r in results]
    report = dict(passed=True, source_gds_sha256=results[0]['physical_extraction']['gds_sha256'],
        runs=[dict(name=n, deck_sha256=r['deck_sha256'], maximum_timestep_ns=r['maximum_timestep_ns'],
                   checks=r['checks']) for n, r in zip(names, results)],
        maximum_mos_terminal_voltage_v=volts, maximum_via_instantaneous_current_a=currents,
        voltage_peak_difference_v=abs(volts[1] - volts[0]),
        via_peak_difference_a=abs(currents[1] - currents[0]),
        scope='Both complete startup runs independently pass the same functional, voltage and current limits. Only maximum time step differs; peak differences are reported, not used to relax any acceptance limit.')
    t, w = load_raw(folders[1] / 'startup.raw')
    x = t / 1000
    fig, axes = plt.subplots(4, 1, figsize=(10, 9), sharex=True)
    axes[0].plot(x, w['v(vdd)'], label='VDD', lw=1.6)
    axes[0].plot(x, w['v(reset)'], '--', label='RESET follows VDD', lw=1.1)
    axes[0].set_title('Power-up: actual 16 x 32 extracted circuit, signal RC and supply mesh', loc='left')
    for signal_prefix, count, label in [('wl', 16, 'Maximum of all 16 WL'), ('pd_y', 1, 'PD_Y')]:
        values = [w[f'v({signal_prefix}{i if count > 1 else ""})'] for i in range(count)]
        axes[1].plot(x, np.maximum.reduce(values), label=label)
    records = json.loads((folders[1] / 'physical_devices.json').read_text())
    maximum = np.zeros(len(t))
    def value(net):
        return np.zeros(len(t)) if net in ('vss', '0') else w[f'v({net.lower()})']
    for r in records:
        if r['model'] not in ('NMOS', 'PMOS'):
            continue
        for pair in ('DS', 'GS', 'SB', 'DB', 'GD', 'GB'):
            np.maximum(maximum, np.abs(value(r['nets'][pair[0]]) - value(r['nets'][pair[1]])), out=maximum)
    axes[2].plot(x, maximum, label='Maximum absolute MOS terminal-pair voltage')
    axes[2].axhline(5.75, ls='--', color='#b23a31', label='5.75 V limit')
    power = json.loads((folders[1] / 'power_rc.json').read_text())
    max_via = np.zeros(len(t))
    for network in power['networks'].values():
        for branch in network['via_branches']:
            current = np.abs(w[f'v({branch["a"]})'] - w[f'v({branch["b"]})']) / branch['resistance_ohm']
            np.maximum(max_via, current, out=max_via)
    axes[3].plot(x, -w['i(vvdd)'] * 1000, label='Total supply current')
    axes[3].plot(x, max_via * 1000, label='Maximum individual via current')
    for ax in axes:
        ax.grid(alpha=.2)
        ax.legend(fontsize=9, loc='best')
    for ax in axes[:3]:
        ax.set_ylabel('Voltage [V]')
    axes[3].set_ylabel('Current [mA]')
    axes[3].set_xlabel('Time [us]')
    fig.text(.11, .015, 'No forced initial state. Power-on memory data is unspecified. Interconnect coefficients are sensitivity assumptions.', fontsize=9)
    fig.tight_layout(rect=(0, .04, 1, 1))
    stem = '' if prefix=='pd102' else prefix+'_'
    fig.savefig(REPORTS / (stem+'startup.png'), dpi=150)
    plt.close(fig)
    write_json(REPORTS / (stem+'startup_comparison.json'), report)
    print('Startup step comparison:', report['passed'], 'voltage peak difference:', report['voltage_peak_difference_v'], flush=True)
    if check_solver:
        assert prefix=='pd102', 'Historical solver comparison has fixed, independently verified run names.'
        assert compare_solvers()['passed']
    return report


if __name__ == '__main__':
    parser=argparse.ArgumentParser();parser.add_argument('--prefix',default='pd102')
    parser.add_argument('--skip-solver-comparison',action='store_true')
    args=parser.parse_args();main(args.prefix,not args.skip_solver_comparison)
