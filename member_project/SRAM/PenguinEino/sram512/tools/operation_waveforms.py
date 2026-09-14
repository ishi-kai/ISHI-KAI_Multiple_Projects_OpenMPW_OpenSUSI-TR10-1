#!/usr/bin/env python3
"""Show complete, independently checked extracted read/write operations."""
import argparse
import os
import tempfile
os.environ.setdefault('MPLCONFIGDIR', os.path.join(tempfile.gettempdir(), 'sram512-matplotlib'))
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from common import *
from analog import load_raw


def render(case):
    case = Path(case).resolve()
    result = json.loads((case / 'result.json').read_text())
    assert result['passed'] and result['operations'] == 16
    assert result['signal_mesh'] and result['physical_gate_paths']
    assert result['deck_sha256'] == sha(case / 'test.spice')
    spec = json.loads((case / 'scenario.json').read_text())
    t, w = load_raw(case / 'sram512_tb.raw')
    assert abs(t[-1] - spec['stop_ns']) < 1e-6
    vdd = result['voltage_v']
    x = t / 1000
    fig, axes = plt.subplots(4, 1, figsize=(14, 10), sharex=True,
                             gridspec_kw={'height_ratios': [1.3, 1.7, 2.3, 1.3]})
    for i, op in enumerate(spec['operations']):
        first = op['first'] / 1000
        last = (op['e0'] + 8 * spec['period_ns']) / 1000
        center = (first + last) / 2
        axes[0].axvspan(first, last, color='#e9eef2' if i % 2 else '#f5f7f8')
        operation = f'W={op["data"]}' if op['write'] else 'R'
        axes[0].text(center, .65, operation, ha='center', fontsize=10)
        axes[0].text(center, .22, f'({op["row"]},{op["col"]})', ha='center', fontsize=9)
        for ax in axes[1:]:
            ax.axvline(first, color='#adb5bd', lw=.5, alpha=.5)
    axes[0].set_ylim(0, 1)
    axes[0].set_yticks([])
    axes[0].set_ylabel('Operation\n(row,col)')
    for signal, offset, label in [('preb', 4, 'PC on'), ('wl_en', 2, 'WL enabled'), ('write_en', 0, 'Write drive')]:
        y = w['v(' + signal + ')'] / vdd
        if signal == 'preb': y = 1 - y
        axes[1].plot(x, y + offset, lw=1.1, label=label)
    axes[1].set_yticks([.5, 2.5, 4.5], ['Write', 'WL', 'PC'])
    axes[1].set_ylim(-.3, 5.5)
    axes[1].set_ylabel('Controls\n(normalized, offset)')
    axes[1].legend(loc='upper right', fontsize=9, ncol=3)
    for i, (row, col) in enumerate(((0, 0), (0, 31), (15, 0), (15, 31))):
        offset = 3 - i
        q = w[f'v(xarray.xr{row}c{col}.q)'] / vdd
        axes[2].plot(x, q * .7 + offset, lw=1.2, label=f'Q({row},{col})')
    axes[2].set_yticks([.35, 1.35, 2.35, 3.35], ['Q(15,31)', 'Q(15,0)', 'Q(0,31)', 'Q(0,0)'])
    axes[2].set_ylim(-.2, 4)
    axes[2].set_ylabel('Stored bits\n(normalized, offset)')
    axes[3].plot(x, w['v(sdo)'], color='#087f8c', lw=1.4, label='SDO: actual output voltage')
    expected = {}
    reads = []
    for op in spec['operations']:
        address = (op['row'], op['col'])
        if op['write']:
            expected[address] = op['data']
            continue
        when = op['e0'] + 6.8 * spec['period_ns']
        value = float(np.interp(when, t, w['v(sdo)']))
        bit = expected[address]
        assert value >= .9 * vdd if bit else value <= .1 * vdd
        axes[3].plot(when / 1000, value, 'o', color='#b25327', ms=4)
        axes[3].annotate(str(bit), (when / 1000, value), xytext=(0, 7), textcoords='offset points', ha='center', fontsize=10)
        reads.append(dict(row=address[0], col=address[1], expected=bit, time_ns=when, sdo_v=value))
    axes[3].set_ylabel('SDO [V]')
    axes[3].set_ylim(-.5, vdd + 1)
    axes[3].set_xlabel('Time [us]')
    axes[3].legend(loc='upper left', fontsize=9)
    for ax in axes[1:]: ax.grid(axis='y', alpha=.2)
    axes[-1].set_xlim(0, spec['stop_ns'] / 1000)
    fig.suptitle(f'16 complete SRAM operations: {vdd:g} V, {result["temperature_c"]:g} C, CLK period {spec["period_ns"] / 1000:g} us', fontsize=14)
    fig.text(.1, .015, 'Initial contents are unspecified; traces show this simulated power-up. Full voltage, retention and current checks are in the source report.', fontsize=9)
    fig.tight_layout(rect=(0, .04, 1, .96))
    target = REPORTS / (case.name + '_operations.png')
    fig.savefig(target, dpi=150)
    plt.close(fig)
    report = dict(passed=True, source_gds_sha256=result['physical_extraction']['gds_sha256'],
        source_case=case.name, source_report_sha256=sha(case / 'result.json'),
        source_deck_sha256=sha(case / 'test.spice'), image_sha256=sha(target),
        operations=16, read_samples=reads,
        scope='Presentation of an already complete and passing extracted test; it does not replace the source report.')
    write_json(REPORTS / (case.name + '_operations.json'), report)
    print(target, flush=True)
    return report


if __name__ == '__main__':
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('case', type=Path)
    render(p.parse_args().case)
