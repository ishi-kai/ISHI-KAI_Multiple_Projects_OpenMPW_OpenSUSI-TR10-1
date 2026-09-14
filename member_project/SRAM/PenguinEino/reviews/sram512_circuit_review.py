#!/usr/bin/env python3
"""Circuit diagnostics on devices from the current matched SRAM512 layout.

These are deliberately reduced circuits, not macro signoff. DC feedback noise
sources characterize loss of a stored state; ideal initial states select a
branch and make no claim about power-up. The PDK and design are not modified.
"""
import argparse
import copy
import json
import hashlib
import re
import sys
from pathlib import Path

import numpy as np

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'sram512/tools'))
from common import run, sha, simulation_diagnostics, write_json
from postlayout import devices, device_lines

WORK = ROOT / 'build/sram512/review_20260913/circuit'


def selected_devices(folder):
    records, source = devices(folder)
    assert source['gds_sha256'] == sha(ROOT/'sram512/layout/sram512.gds')
    mos = [r for r in records if r['model'] in ('NMOS', 'PMOS')]
    assert all(r['nets']['B'] == ('vss' if r['model'] == 'NMOS' else 'vdd') for r in mos)
    cell, peripheral, sense = [], [], []
    for i, original in enumerate(records):
        if original['model'] not in ('NMOS', 'PMOS'):
            continue
        r = copy.deepcopy(original)
        ns = r['nets']
        r['extracted_index'] = i
        if any(n.startswith('xarray.xr0c0.') for n in ns.values()):
            cell.append(r)
        elif ns['G'] in ('col0', 'pd_y', 'pd_yb') or (
                ns['G'] == 'preb' and set(ns.values()) & {'y', 'yb', 'bl0', 'blb0'}):
            peripheral.append(r)
        elif set(ns[p] for p in ('D', 'S')) & {'sout', 'soutb', 'xsense.net1'}:
            sense.append(r)
        for p, n in list(ns.items()):
            if n.startswith('xarray.xr0c0.'):
                ns[p] = n.rsplit('.', 1)[1]
    assert (len(cell), len(peripheral), len(sense)) == (6, 8, 7)
    write_json(WORK / 'selected_devices.json', dict(source=source, cell=cell,
               peripheral=peripheral, sense=sense))
    return cell, peripheral, sense, source


def simulate(name, records, circuit, analysis, outputs):
    work = WORK / name
    work.mkdir(parents=True, exist_ok=True)
    lines = device_lines(records) + circuit + [
        '.options reltol=1e-5 abstol=1e-13 vntol=1e-7', '.control',
        'set wr_vecnames', 'set wr_singlescale', 'set numdgt=12',
        analysis, 'wrdata curve.txt ' + ' '.join(outputs), 'quit', '.endc', '.end']
    deck = work / 'test.spice'
    deck.write_text('\n'.join(lines) + '\n')
    _, log = run(['ngspice', '-b', deck], work, 'simulation.log')
    notices = simulation_diagnostics(log)
    result = np.loadtxt(work / 'curve.txt', skiprows=1)
    assert result.ndim == 2 and result.shape[1] == len(outputs) + 1
    assert np.isfinite(result).all()
    return result, dict(deck_sha256=sha(deck), points=len(result),
                        model_notices=notices, directory=str(work.relative_to(ROOT)))


def feedback_noise(cell, vdd, temp, read, bit, step=.001):
    """Sweep equal adverse DC offsets in both feedback paths, until state flips."""
    rs = copy.deepcopy(cell)
    for r in rs:
        if r['nets']['G'] in ('q', 'qb'):
            r['nets']['G'] += '_gate'
    sign = 1 if bit == 0 else -1
    conditions = [f'VVDD vdd 0 {vdd}', f'VWL wl0 0 {vdd if read else 0}',
                  f'VBL bl0 0 {vdd}', f'VBLB blb0 0 {vdd}', 'VNOISE noise 0 0',
                  f'EQ q_gate q noise 0 {sign}', f'EQB qb_gate qb noise 0 {-sign}',
                  f'.nodeset v(q)={vdd*bit} v(qb)={vdd*(1-bit)}', f'.temp {temp}']
    name = f'noise_{"read" if read else "hold"}_{vdd}V_{temp}C_bit{bit}'
    data, meta = simulate(name, rs, conditions, f'dc VNOISE 0 {vdd/2:g} {step}',
                          ['v(q)', 'v(qb)'])
    delta = (data[:, 2] - data[:, 1]) * sign
    assert delta[0] > 0
    flips = np.flatnonzero(delta <= 0)
    assert len(flips) and flips[0] > 0, 'Sweep did not bracket loss of state'
    ix = int(flips[0])
    return dict(vdd_v=vdd, temperature_c=temp, read=read, initial_bit=bit,
                noise_before_flip_v=float(data[ix-1, 0]), noise_at_flip_v=float(data[ix, 0]),
                zero_noise_q_v=float(data[0, 1]), zero_noise_qb_v=float(data[0, 2]), **meta)


def write_trip(cell, vdd, temp, bit, step=.001):
    """Cell-only write trip with WL high and opposite BL tied to VDD."""
    low = 'bl0' if bit == 0 else 'blb0'
    high = 'blb0' if bit == 0 else 'bl0'
    conditions = [f'VVDD vdd 0 {vdd}', f'VWL wl0 0 {vdd}',
                  f'VLOW {low} 0 {vdd}', f'VHIGH {high} 0 {vdd}',
                  f'.nodeset v(q)={vdd*(1-bit)} v(qb)={vdd*bit}', f'.temp {temp}']
    data, meta = simulate(f'write_trip_{vdd}V_{temp}C_bit{bit}', cell, conditions,
                          f'dc VLOW {vdd} 0 {-step}', ['v(q)', 'v(qb)'])
    delta = (data[:, 1] - data[:, 2]) * (1 if bit == 0 else -1)
    assert delta[0] > 0
    flips = np.flatnonzero(delta <= 0)
    assert len(flips) and flips[0] > 0
    ix = int(flips[0])
    return dict(vdd_v=vdd, temperature_c=temp, written_bit=bit,
                bitline_before_flip_v=float(data[ix-1, 0]),
                bitline_at_flip_v=float(data[ix, 0]), **meta)


def write_path(cell, peripheral, vdd, temp, bit):
    """Write through actual access/mux/pulldown, with adverse lumped line R.

    Unlike the cell-only trip test, the other bitline has no ideal high driver.
    All precharge devices are off. Gate drive is swept slowly from zero.
    """
    rs = copy.deepcopy(cell + peripheral)
    for r in rs:
        ns = r['nets']
        if ns['G'] == 'col0':
            for p, n in list(ns.items()):
                if n in ('y', 'yb'):
                    ns[p] = 'far_' + n
        if set(ns.values()) & {'q', 'qb'}:
            for p, n in list(ns.items()):
                if n in ('bl0', 'blb0'):
                    ns[p] = 'cell_' + n
    stressed = json.loads((ROOT / 'sram512/reports/decoderfix_pg_rc3_lowhot.json').read_text())
    groups = stressed['interconnect']['wire_groups']
    rcommon = groups['common']['resistance_ohm_range']
    rbl = groups['bitline']['resistance_ohm_range'][1]
    gate = 'pd_y' if bit == 0 else 'pd_yb'
    other = 'pd_yb' if bit == 0 else 'pd_y'
    circuit = [f'VVDD vdd 0 {vdd}', f'VWL wl0 0 {vdd}', f'VCOL col0 0 {vdd}',
               f'VPRE preb 0 {vdd}', f'VDRIVE {gate} 0 0', f'VOFF {other} 0 0',
               f'RY y far_y {rcommon[0]}', f'RYB yb far_yb {rcommon[1]}',
               f'RBL bl0 cell_bl0 {rbl}', f'RBLB blb0 cell_blb0 {rbl}',
               f'.nodeset v(q)={vdd*(1-bit)} v(qb)={vdd*bit}', f'.temp {temp}']
    data, meta = simulate(f'write_path_{vdd}V_{temp}C_bit{bit}', rs, circuit,
                          f'dc VDRIVE 0 {vdd} .001',
                          ['v(q)', 'v(qb)', 'v(cell_bl0)', 'v(cell_blb0)', 'i(VVDD)'])
    delta = (data[:, 1] - data[:, 2]) * (1 if bit == 0 else -1)
    assert delta[0] > 0
    flips = np.flatnonzero(delta <= 0)
    ix = int(flips[0]) if len(flips) else None
    return dict(vdd_v=vdd, temperature_c=temp, written_bit=bit,
                common_resistance_ohm=rcommon, local_bl_resistance_ohm=rbl,
                flipped=ix is not None,
                pulldown_gate_before_flip_v=float(data[ix-1, 0]) if ix else None,
                pulldown_gate_at_flip_v=float(data[ix, 0]) if ix else None,
                final_q_v=float(data[-1, 1]), final_qb_v=float(data[-1, 2]), **meta)


def raw_reader(folder):
    """Read bounded windows; full-waveform voltage scans are in the main review."""
    path = folder / 'sram512_tb.raw'
    with path.open('rb') as stream:
        lines = []
        while (line := stream.readline()) != b'Binary:\n':
            assert line
            lines.append(line)
        offset = stream.tell()
    header = b''.join(lines).decode('ascii')
    assert 'Flags: real' in header
    nv = int(re.search(r'No. Variables:\s*(\d+)', header)[1])
    count = int(re.search(r'No. Points:\s*(\d+)', header)[1])
    names = [line.split()[1].lower() for line in header.rsplit('Variables:', 1)[1].splitlines() if line.strip()]
    assert len(names) == nv and path.stat().st_size == offset + count*nv*8
    columns = dict(zip(names, range(nv)))
    matrix = np.memmap(path, dtype='<f8', mode='r', offset=offset, shape=(count, nv))
    time = np.array(matrix[:, 0])*1e9
    assert np.isfinite(time).all() and (np.diff(time) > 0).all() and time[0] == 0

    def window(start, stop, nets):
        assert time[0] <= start < stop <= time[-1]
        a, b = np.searchsorted(time, [start, stop])
        rows = np.arange(max(0, a-1), min(count, b+1))
        assert len(rows) >= 3
        values = np.array(matrix[np.ix_(rows, [columns['v('+n+')'] for n in nets])])
        assert np.isfinite(values).all()
        t = time[rows]
        digest = hashlib.sha256(np.column_stack((t, values)).astype('<f8').tobytes()).hexdigest()
        return t, dict(zip(nets, values.T)), digest

    return window, dict(case=folder.name, deck_sha256=sha(folder/'test.spice'),
                        raw_bytes=path.stat().st_size, points=count, stop_ns=float(time[-1]))


def crossing(t, values, threshold, rising):
    candidates = np.flatnonzero((values[:-1] < threshold) & (values[1:] >= threshold)
                               if rising else (values[:-1] > threshold) & (values[1:] <= threshold))
    assert len(candidates) == 1, (threshold, rising, candidates)
    i = int(candidates[0])
    return float(t[i] + (threshold-values[i])*(t[i+1]-t[i])/(values[i+1]-values[i]))


def saved_observations(source):
    output = dict(scope='Bounded voltage windows from the four complete traces audited in the main review. '
                  '0.8 V is a timing observation threshold, not a transistor cutoff guarantee.',
                  reset=[], sense=[], decoder_peak=[])
    for name in ('decoderfix_reset_write0', 'decoderfix_reset_write1',
                 'decoderfix_power_paths_ramp', 'decoderfix_pg_rc3_lowhot'):
        folder = ROOT / 'build/sram512/analog' / name
        result = json.loads((folder/'result.json').read_text())
        assert result['physical_extraction']['gds_sha256'] == source['gds_sha256']
        window, provenance = raw_reader(folder)
        case = json.loads((folder/'scenario.json').read_text())
        vdd = result['voltage_v']
        if case.get('reset_intervals'):
            assertion = case['reset_intervals'][0]['assert_ns']
            gate_map = {}
            deck_lines = (folder/'test.spice').read_text().splitlines()
            for line in deck_lines:
                if not re.match(r'XM\d+ ', line):
                    continue
                f = line.split()
                q = next((n for n in (f[1], f[3]) if n.startswith('xarray.xr15c')), None)
                if q and (f[2].startswith('sig_wl15_') or f[2].startswith('rc_wl15_')):
                    gate_map[q] = f[2]
            assert len(gate_map) == 64
            pd = 'rc_pd_y_g1' if name.endswith('0') else 'rc_pd_yb_g1'
            nets = sorted(set(gate_map.values()) | {'rc_col0_g1', pd} |
                          {f'wl{i}' for i in range(15)})
            t, w, digest = window(assertion-30, assertion+150, nets)
            falls = {n: crossing(t, w[n], .8, False)-assertion for n in set(gate_map.values())}
            new_col = crossing(t, w['rc_col0_g1'], .8, True)-assertion
            row0_falls = {q: falls[n] for q, n in gate_map.items() if q.startswith('xarray.xr15c0.')}
            output['reset'].append(dict(**provenance, assertion_ns=assertion,
                window_sha256=digest, row15_access_gate_count=len(gate_map),
                last_row15_gate_below_0_8v_ns=max(falls.values()),
                row15_col0_gate_below_0_8v_ns=row0_falls,
                new_col0_above_0_8v_ns=new_col,
                all_row15_to_col0_threshold_gap_ns=new_col-max(falls.values()),
                write_gate_below_0_8v_ns=crossing(t, w[pd], .8, False)-assertion,
                unselected_row_driver_peak_v=max(float(w[f'wl{i}'].max()) for i in range(15)),
                initialized_row15_col0_equals_interrupted_write_data=(
                    next(op['data'] for op in case['operations'] if (op['row'], op['col']) == (15, 0))
                    == case['reset_intervals'][0]['write_data'])))
            if name.endswith('1'):
                np.savez(WORK/'reset_window.npz', time_ns=t-assertion,
                         col0=w['rc_col0_g1'], write=w[pd],
                         wl_q=w[gate_map['xarray.xr15c0.q']], wl_qb=w[gate_map['xarray.xr15c0.qb']])
                nets = ['rc_xcol_decode_cl3_g141', 'xcol_decode.cl3', 'physical_141_3',
                        'physical_141_5', 'power_vss_load_1693', 'rc_xcol_decode_ch5_g141']
                t, w, digest = window(390980, 391080, nets)
                stress = w[nets[0]]-w['power_vss_load_1693']
                i = int(stress.argmax())
                branch_r = [line.split() for line in deck_lines if line.startswith('R')
                            and set(line.split()[1:3]) == {nets[0], 'xcol_decode.cl3'}]
                branch_c = [line.split() for line in deck_lines if line.startswith('C')
                            and set(line.split()[1:3]) == {nets[0], '0'}]
                assert len(branch_r) == len(branch_c) == 1 and branch_c[0][3].endswith('f')
                output['decoder_peak'].append(dict(**provenance, window_sha256=digest,
                    time_ns=float(t[i]), vgb_v=float(stress[i]),
                    gate_global_ground_v=float(w[nets[0]][i]),
                    body_global_ground_v=float(w['power_vss_load_1693'][i]),
                    driver_global_ground_v=float(w['xcol_decode.cl3'][i]),
                    gate_branch_resistance_ohm=float(branch_r[0][3]),
                    gate_branch_shunt_capacitance_ff=float(branch_c[0][3][:-1])))
                np.savez(WORK/'decoder_window.npz', time_ns=t-391000, stress=stress,
                         driver=w['xcol_decode.cl3']-w['power_vss_load_1693'],
                         drain=w['physical_141_3']-w['power_vss_load_1693'],
                         source=w['physical_141_5']-w['power_vss_load_1693'])
        for i, op in enumerate(case['operations']):
            if op['write']:
                continue
            edge = op['e0']+4*case['period_ns']
            nets = ['rc_sae_g1', 'y', 'yb', 'sout', 'soutb', 'xsense.net1']
            t, w, digest = window(edge-10, edge+200, nets)
            transition = crossing(t, w['rc_sae_g1'], .1*vdd, True)
            assert t[0] <= transition <= t[-1]
            value = {n: float(np.interp(transition, t, w[n])) for n in nets}
            output['sense'].append(dict(**provenance, operation=i, row=op['row'], col=op['col'],
                window_sha256=digest, sae_at_10pct_ns=transition,
                input_difference_v=value['y']-value['yb'],
                latch_difference_v=value['sout']-value['soutb'],
                tail_v=value['xsense.net1']))
        print('saved_windows', name, flush=True)
    return output


def plot_results(results):
    import matplotlib
    matplotlib.use('Agg')
    import matplotlib.pyplot as plt
    has_windows = 'saved_windows' in results
    fig, axes = plt.subplots(2 if has_windows else 1, 2,
                             figsize=(11, 8 if has_windows else 4.5), squeeze=False)
    conditions = [(5, 27), (4.5, 85), (5, 85)]
    x = np.arange(3)
    for read, shift, color, label in ((False, -.18, '#8aa4bf', 'Hold'), (True, .18, '#b55539', 'Read: BL/BLB held at VDD')):
        vals = [next(r['noise_at_flip_v'] for r in results['feedback_noise']
                     if r['vdd_v'] == v and r['temperature_c'] == t and r['read'] == read and r['initial_bit'] == 0)
                for v, t in conditions]
        bars = axes[0, 0].bar(x+shift, vals, .34, color=color, label=label)
        axes[0, 0].bar_label(bars, fmt='%.3f', fontsize=9)
    axes[0, 0].set(xticks=x, xticklabels=['5 V / 27 C', '4.5 V / 85 C', '5 V / 85 C'],
                   ylabel='Equal feedback noise at loss of state [V]', ylim=(0, 1.9),
                   title='A. Actual 6T cell: DC noise injection')
    axes[0, 0].legend(fontsize=8, loc='upper right')
    for bit, shift, color in ((0, -.18, '#397b88'), (1, .18, '#ba9747')):
        vals = [next(r['pulldown_gate_at_flip_v'] for r in results['write_path']
                     if r['vdd_v'] == v and r['temperature_c'] == t and r['written_bit'] == bit)
                for v, t in conditions]
        bars = axes[0, 1].bar(x+shift, vals, .34, color=color, label=f'Write {bit}')
        axes[0, 1].bar_label(bars, fmt='%.3f', fontsize=9)
    axes[0, 1].plot(x, [5, 4.5, 5], 'k_', ms=45, label='Available ideal gate drive')
    axes[0, 1].set(xticks=x, xticklabels=['5 V / 27 C', '4.5 V / 85 C', '5 V / 85 C'],
                   ylabel='Write pulldown gate at cell flip [V]', ylim=(0, 5.6),
                   title='B. Access + column mux + write pulldown')
    axes[0, 1].legend(fontsize=8)
    if has_windows:
        r = np.load(WORK/'reset_window.npz')
        for key, label, style in [('wl_q', 'Row15/col0 WL at Q access', '-'),
                                   ('wl_qb', 'Row15/col0 WL at QB access', '--'),
                                   ('col0', 'New column 0 gate', '-'), ('write', 'Write gate', '-')]:
            axes[1, 0].plot(r['time_ns'], r[key], style, label=label, lw=1.5)
        axes[1, 0].axhline(.8, color='gray', ls=':', label='0.8 V observation threshold')
        axes[1, 0].set(xlim=(15, 45), ylim=(-.1, 5.3), xlabel='Time from RESET assertion start [ns]',
                       ylabel='Gate voltage [V]', title='C. RESET: order depends on propagation delay')
        axes[1, 0].legend(fontsize=7.5, loc='upper right')
        r = np.load(WORK/'decoder_window.npz')
        axes[1, 1].plot(r['time_ns'], r['stress'], color='#b55539', label='CL3 at COL23 NMOS gate: VGB')
        axes[1, 1].plot(r['time_ns'], r['driver'], color='#397b88', label='CL3 driver, relative to same body')
        axes[1, 1].axhline(5.75, color='gray', ls=':', label='5.75 V adopted criterion')
        axes[1, 1].set(xlim=(10, 60), ylim=(4.9, 5.81), xlabel='Time from 391 us [ns]',
                       ylabel='Voltage relative to local body [V]', title='D. Decoder input boost through high-R branch')
        axes[1, 1].legend(fontsize=7.5)
    for ax in axes.flat:
        ax.grid(axis='y', alpha=.18)
    fig.suptitle('SRAM512 circuit review: device topology and electrical margins', fontsize=14)
    footnote = 'A/B: reduced circuits with unchanged PDK. '
    if has_windows:
        footnote += 'C/D: saved nominal physical-waveform windows. '
    fig.text(.08, .018, footnote+'No statistical yield claim.', fontsize=9)
    fig.tight_layout(rect=(0, .04, 1, .96))
    path = WORK/'circuit_review.png'
    fig.savefig(path, dpi=160)
    plt.close(fig)
    return dict(path=str(path.relative_to(ROOT)), sha256=sha(path))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--layout', type=Path,
                        default=ROOT / 'build/sram512/review_20260913/probes/fresh/layout/rechecked16x32')
    parser.add_argument('--saved-waveforms', action='store_true', help='Also inspect the saved physical transient windows.')
    parser.add_argument('--reuse-dc', action='store_true', help='Use this script\'s existing DC results when inspecting waveform windows.')
    args = parser.parse_args()
    cell, peripheral, sense, source = selected_devices(args.layout.resolve())
    results = dict(scope=__doc__, source=source, feedback_noise=[], write_trip=[], write_path=[])
    if args.reuse_dc:
        results = json.loads((WORK/'result.json').read_text())
        assert results['source'] == source
    for vdd, temp in (() if args.reuse_dc else ((5, 27), (4.5, 85), (5, 85))):
        for bit in (0, 1):
            for read in (False, True):
                r = feedback_noise(cell, vdd, temp, read, bit)
                results['feedback_noise'].append(r)
                print('feedback_noise', {k: v for k, v in r.items() if k not in ('model_notices',)}, flush=True)
            r = write_trip(cell, vdd, temp, bit)
            results['write_trip'].append(r)
            print('write_trip', r, flush=True)
            r = write_path(cell, peripheral, vdd, temp, bit)
            results['write_path'].append(r)
            print('write_path', r, flush=True)
    if args.saved_waveforms:
        results['saved_windows'] = saved_observations(source)
    results['diagnostic_script_sha256'] = sha(Path(__file__))
    results['body_ties'] = dict(mos_groups_checked=source['mos_groups'],
                               all_nmos_to_vss_and_pmos_to_vdd=True)
    results['figure'] = plot_results(results)
    write_json(WORK / 'result.json', results)


if __name__ == '__main__':
    main()
