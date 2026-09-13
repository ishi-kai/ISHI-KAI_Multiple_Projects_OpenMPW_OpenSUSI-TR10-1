#!/usr/bin/env python3
"""Power ramp with every physical MOS terminal and power via observed.

The SRAM initial contents are unspecified. No .ic, UIC, artificial mismatch,
or model edits are used. RESET follows VDD while the other inputs stay low.
"""
import argparse
import time
import numpy as np
from common import *
from analog import load_raw, spice_time, vectors
from postlayout import devices, device_lines, rc_summary
from wire_rc import add_rc
from power_mesh import add_power_mesh, verify_via_currents
from electrical_limits import nodes, verify as verify_limits


def functional_checks(path, ramp_ns, stop_ns, vdd, wordline_gate_nodes=()):
    t, w = load_raw(path)
    assert t[0] == 0 and abs(t[-1] - stop_ns) < 1e-6
    start = ramp_ns + (stop_ns - ramp_ns) / 2
    mask = (t >= start) & (t <= stop_ns)
    assert mask.sum() >= 10
    checks = 0
    failures = []
    def level(net, expected):
        nonlocal checks
        checks += 1
        a = w[f'v({net.lower()})'][mask]
        if (a.min() < .9 * vdd if expected else a.max() > .1 * vdd):
            failures.append(dict(net=net, expected=expected,
                                 min_v=float(a.min()), max_v=float(a.max())))
    for net, value in [('VDD', 1), ('RESET', 1), ('PREB', 1), ('SAE', 1),
                       ('WL_EN', 0), ('WRITE_EN', 0), ('SDO', 0),
                       ('PD_Y', 0), ('PD_YB', 0), ('DIN', 0),
                       ('CLK', 0), ('SDI', 0), ('WE', 0)]:
        level(net, value)
    for prefix, count in [('WL', 16), ('RA', 4), ('CA', 5), ('xctrl.xphase.C', 5)]:
        for i in range(count):
            level(prefix + str(i), 0)
    for col in range(32):
        level(f'COL{col}', int(col == 0))
    for net in sorted(set(wordline_gate_nodes)):
        level(net,0)
    resolved = []
    for row in range(16):
        for col in range(32):
            checks += 1
            q = w[f'v(xarray.xr{row}c{col}.q)'][mask]
            qb = w[f'v(xarray.xr{row}c{col}.qb)'][mask]
            high = q.min() > .9 * vdd and qb.max() < .1 * vdd
            low = qb.min() > .9 * vdd and q.max() < .1 * vdd
            if not (high or low):
                failures.append(dict(cell=[row, col], q_range_v=[float(q.min()), float(q.max())],
                                     qb_range_v=[float(qb.min()), float(qb.max())]))
            resolved.append(int(high) if high or low else None)
    current = -w['i(vvdd)']
    return dict(passed=not failures, checks=checks, failure_count=len(failures),
                failures=failures[:40], check_interval_ns=[start, stop_ns],
                resolved_cells=sum(x is not None for x in resolved),
                initial_content_specification='Unspecified; either complementary rail state is accepted.',
                supply_current_a=dict(maximum=float(current.max()), final=float(current[-1])),
                waveform_points=len(t))


def simulate(folder, name='pd102_startup', max_step_ns=5, recheck=False, solver='sparse', pivrel=None, stream=False, signal_mesh=False):
    work = WORK / 'analog' / name
    work.mkdir(parents=True, exist_ok=True)
    ramp_ns, stop_ns, vdd = 1000, 2000, 5
    records, source = devices(folder)
    records, rc_lines, wire_nodes, rc_info = add_rc(folder, records, 1, physical_gate_paths=True,
                                                  signal_mesh=signal_mesh)
    records, power_lines, power_nodes, power_info = add_power_mesh(folder, records, .1, step_um=.25)
    write_json(work / 'physical_devices.json', records)
    write_json(work / 'wire_rc.json', rc_info)
    write_json(work / 'power_rc.json', power_info)
    observed = sorted(set(nodes(records) + wire_nodes + power_nodes + vectors(dict(operations=[]))))
    saves = ['i(VVDD)'] + [f'v({n})' for n in observed]
    lines = device_lines(records) + rc_lines + power_lines + [
        f'VVDD vdd 0 PWL(0 0 {spice_time(ramp_ns)} {vdd})',
        'Breset reset 0 v=v(vdd)', 'VCLK clk 0 0', 'VSDI sdi 0 0', 'VWE we 0 0',
        'Cout SDO 0 10p', '.temp 27', '.options method=gear maxord=2',
        '.control', 'set num_threads=1']
    assert solver in ('sparse', 'klu')
    if solver == 'klu':
        lines.insert(lines.index('.control'), '.options klu')
    if pivrel is not None:
        assert 0 < pivrel <= 1
        lines.insert(lines.index('.control'), f'.options pivrel={pivrel:.12g}')
    lines += ['save ' + ' '.join(saves[i:i+100]) for i in range(0, len(saves), 100)]
    lines += [f'tran 1n {spice_time(stop_ns)} 0 {spice_time(max_step_ns)}',
              'write startup.raw', 'rusage all', 'quit', '.endc', '.end']
    path = work / 'test.spice'
    deck = '\n'.join(lines) + '\n'
    if stream:
        block = re.search(r'(?s)\.control\n(.*?)\.endc', deck)
        batch = '\n'.join('.'+line for line in block[1].splitlines() if line.startswith(('save ', 'tran ')))
        deck = deck[:block.start()] + batch + deck[block.end():]
        local_init = work / '.spiceinit'
        if recheck:
            assert local_init.read_text() == 'set num_threads=1\n'
        else:
            local_init.write_text('set num_threads=1\n')
    start = time.monotonic()
    if recheck:
        assert path.read_text() == deck
        log = (work / 'simulation.log').read_text()
    else:
        path.write_text(deck)
        print('ngspice', name, solver, 'maximum step', max_step_ns, 'ns; pivrel', pivrel, flush=True)
        _, log = run(['ngspice', '-b'] + (['-r', 'startup.raw'] if stream else []) + [path], work, 'simulation.log')
    notices = simulation_diagnostics(log)
    raw = work / 'startup.raw'
    wl_gates = [m['node'] for name,net in rc_info.get('signal_mesh',{}).get('nets',{}).items()
                if re.fullmatch(r'wl\d+',name) for m in net['terminals'] if m['pin']=='G']
    functional = functional_checks(raw, ramp_ns, stop_ns, vdd, wl_gates)
    limits = verify_limits(raw, records)
    currents = verify_via_currents(raw, power_info)
    parts = [functional, limits, currents]
    result = dict(passed=all(p['passed'] for p in parts),
        checks=sum(p['checks'] for p in parts), failure_count=sum(p['failure_count'] for p in parts),
        physical_extraction=source, deck_sha256=sha(path), model_notices=notices,
        functional_checks=functional, voltage_limits=limits, via_currents=currents,
        maximum_timestep_ns=max_step_ns, supply_ramp_ns=ramp_ns, stop_ns=stop_ns,
        voltage_v=vdd, temperature_c=27, solver=solver, numerical_pivrel=pivrel, integration_method='gear2', simulator_threads=1,
        signal_mesh=signal_mesh, signal_sections=4 if signal_mesh else None,
        waveform_storage='streamed binary file' if stream else 'control memory then write',
        local_init_sha256=sha(work / '.spiceinit') if stream else None,
        interconnect=rc_summary(rc_info, work / 'wire_rc.json'),
        power_model_sha256=sha(work / 'power_rc.json'),
        power_model={k:power_info[k] for k in ('sheet_ohm', 'via_ohm', 'grid_um', 'scope')},
        elapsed_seconds=round(time.monotonic() - start, 2), reused_waveform=recheck,
        scope='Full extracted 16x32 circuit, signal RC x1, actual gate paths and width-aware supply mesh. RESET follows the 1 us supply ramp and stays asserted; no clocks or memory operations. No initial conditions are imposed.')
    write_json(work / 'result.json', result)
    write_json(REPORTS / (name + '.json'), result)
    print(name, result['passed'], result['checks'], result['failure_count'], flush=True)
    return result


if __name__ == '__main__':
    p = argparse.ArgumentParser()
    p.add_argument('folder', type=Path)
    p.add_argument('--name', default='pd102_startup')
    p.add_argument('--max-step-ns', type=float, default=5)
    p.add_argument('--recheck', action='store_true')
    p.add_argument('--solver', choices=['sparse', 'klu'], default='sparse')
    p.add_argument('--pivrel', type=float)
    p.add_argument('--stream', action='store_true')
    p.add_argument('--signal-mesh', action='store_true')
    args = p.parse_args()
    assert 0 < args.max_step_ns <= 5
    raise SystemExit(0 if simulate(args.folder.resolve(), args.name, args.max_step_ns, args.recheck, args.solver, args.pivrel, args.stream, args.signal_mesh)['passed'] else 1)
