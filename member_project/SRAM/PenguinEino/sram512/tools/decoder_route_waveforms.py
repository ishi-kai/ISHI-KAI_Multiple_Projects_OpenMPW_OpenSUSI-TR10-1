#!/usr/bin/env python3
"""Plot the three observed decoder voltage excursions and their physical fixes.

This compares complete time windows read from immutable portions of the raw
files. A running file may supply a window, but never full release evidence.
The original raw headers and simulation files are not changed.
"""
import argparse
import os
import tempfile
os.environ.setdefault('MPLCONFIGDIR', os.path.join(tempfile.gettempdir(), 'sram512-matplotlib'))
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from common import *
from live_probe import samples, remapped_devices


TARGETS = (
    ('CA2B', 'AND3_X1', (1067.6, 86.55), 231000),
    ('RA0', 'AND2_X1', (1238.1, 12.3), 311000),
    ('CL0', 'AND2_X1', (510.9, 64.7), 391000),
)


def compare(before, after):
    folders = [Path(before).resolve(), Path(after).resolve()]
    waves = [samples(p / 'sram512_tb.raw') for p in folders]
    devices = [remapped_devices(p) for p in folders]
    decks = [(p / 'test.spice').read_text() for p in folders]
    stimuli = [re.findall(r'(?m)^(?:V\S+|Breset|\.temp) .+$', s) for s in decks]
    assert stimuli[0] == stimuli[1], 'Comparison must retain the same input stimuli and temperature'
    sources = []
    for folder, (t, _) in zip(folders, waves):
        source = json.loads((folder / 'power_rc.json').read_text())
        sources.append(dict(case=folder.name, source_gds_sha256=source['source_gds_sha256'],
            deck_sha256=sha(folder / 'test.spice'), points_at_snapshot=len(t),
            simulated_ns_at_snapshot=float(t[-1])))
    limit = 5.75
    fig, axes = plt.subplots(3, 1, figsize=(10, 8), sharex=True)
    rows = []
    for ax, (net, cell, position, edge) in zip(axes, TARGETS):
        observations = []
        for label, color, records, (t, w) in zip(('Before', 'After'), ('#bb4939', '#167da1'), devices, waves):
            assert t[-1] >= edge + 400, f'{net}: the entire comparison window is not available yet'
            selected = [(i, r) for i, r in enumerate(records) if r['model'] == 'NMOS'
                        and r['cell'] == cell and np.allclose(r['position_um'], position, rtol=0, atol=1e-5)]
            assert len(selected) == 1, (net, selected)
            i, device = selected[0]
            mask = (t >= edge - 100) & (t <= edge + 400)
            def voltage(pin):
                name = device['nets'][pin].lower()
                return np.zeros(mask.sum()) if name in ('0', 'vss') else w['v(' + name + ')'][mask]
            x = t[mask] - edge
            y = np.abs(voltage('G') - voltage('B'))
            peak = int(np.argmax(y))
            observations.append(dict(device=i, peak_abs_v=float(y[peak]),
                time_ns=float(x[peak] + edge), window_ns=[edge - 100, edge + 400],
                window_sample_sha256=hashlib.sha256(np.column_stack((x, y)).astype('<f8').tobytes()).hexdigest()))
            ax.plot(x, y, color=color, lw=1.5, label=f'{label}: peak {y[peak]:.4f} V')
        ax.axhline(limit, color='#7a425c', ls='--', lw=1, label='5.75 V limit')
        ax.set_title(f'{net}: {cell} input at ({position[0]}, {position[1]}) um; edge {edge / 1000:g} us', loc='left', fontsize=10)
        ax.set_ylabel('|VGB| [V]')
        ax.grid(alpha=.2)
        ax.legend(loc='upper right', fontsize=9)
        ax.set_ylim(4.8, 5.95)
        rows.append(dict(net=net, cell=cell, position_um=list(position), before=observations[0], after=observations[1]))
    axes[-1].set_xlabel('Time from the corresponding input edge [ns]')
    fig.suptitle('Decoder input voltage: physical route reinforcement, 5 V / 27 C', fontsize=13)
    fig.text(.11, .02, 'These three windows are diagnostic evidence. Complete functional, voltage and current checks remain separate.', fontsize=9)
    fig.tight_layout(rect=(0, .045, 1, .96))
    output = REPORTS / 'decoderfix_route_waveforms.png'
    fig.savefig(output, dpi=150)
    plt.close(fig)
    result = dict(release_evidence=False, source_gds_sha256=sources[1]['source_gds_sha256'],
        source_runs=sources, observed_windows=rows,
        previous_inputs_exceeded_limit=all(r['before']['peak_abs_v'] > limit for r in rows),
        corrected_windows_within_limit=all(r['after']['peak_abs_v'] <= limit for r in rows),
        image_sha256=sha(output), limit_abs_v=limit, scope=__doc__)
    write_json(REPORTS / 'decoderfix_route_waveforms.json', result)
    print('Three corrected windows within limit:', result['corrected_windows_within_limit'], flush=True)
    return result


if __name__ == '__main__':
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('before', type=Path)
    p.add_argument('after', type=Path)
    a = p.parse_args()
    compare(a.before, a.after)
