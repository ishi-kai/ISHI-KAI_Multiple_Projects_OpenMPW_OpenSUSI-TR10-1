#!/usr/bin/env python3
"""Reproduce the 2026-09-13 SRAM512 review without editing the live design.

Default: negative tests of the evidence index, archive builder and waveform
checker, in copies or memory. --fresh: rerun saved-layout checks, digital and
submitted MOS TB checks. --waveforms: independently scan saved physical
simulation samples, all MOS terminal pairs and diode reverse voltages.
These are review probes, not replacement production acceptance criteria.
"""
import argparse
import hashlib
import json
from pathlib import Path
import re
import shutil
import subprocess
import sys
import tempfile
import zipfile

import numpy as np

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'sram512/tools'))
import analog


def sha(path):
    h = hashlib.sha256()
    with Path(path).open('rb') as f:
        for block in iter(lambda: f.read(1024 * 1024), b''):
            h.update(block)
    return h.hexdigest()


def write(path, result):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(result, ensure_ascii=False, indent=2) + '\n')


def fresh_checks(output):
    import common
    common.WORK = output / 'fresh'
    common.REPORTS = common.WORK / 'reports'
    import verify_saved_layout
    import pcell_preservation
    import verify_digital
    import submission_lvs

    assert verify_saved_layout.main()['passed']
    assert pcell_preservation.verify(common.HERE / 'layout/sram512.gds')['passed']
    # verify_digital writes generated Verilog; keep that output in a copy.
    scratch = common.WORK / 'digital_source'
    for name in ('rtl', 'tb'):
        shutil.copytree(common.HERE / name, scratch / 'sram512' / name, dirs_exist_ok=True)
    link = scratch / 'sram512/schematics'
    if not link.exists():
        link.symlink_to(common.SCHEMATICS, target_is_directory=True)
    verify_digital.ROOT = scratch
    verify_digital.main()
    assert sha(scratch / 'sram512/rtl/sram512_digital_gates.v') == sha(
        common.HERE / 'rtl/sram512_digital_gates.v')

    original_write = submission_lvs.write_json
    def review_write(path, result):
        if path == ROOT / 'reviews/submission_lvs.json':
            path = common.REPORTS / 'submission_lvs.json'
        original_write(path, result)
    submission_lvs.write_json = review_write
    assert submission_lvs.main()['passed']

    tb = common.WORK / 'submission_tb'
    subprocess.run([sys.executable, str(ROOT / 'sram512/tools/submission_runner.py'),
                    'simulate', '--output', str(tb)], cwd=ROOT, check=True)
    result = analog.verify(tb / 'sram512_tb.raw', analog.scenario(), 5)
    result.update(scope='Fresh submitted MOS TB and current Python checks; lumped loads.',
                  deck_sha256=sha(tb / 'test.spice'))
    assert result['passed']
    write(common.REPORTS / 'submission_tb.json', result)

    sources = {}
    for name in ('sram512', 'sram512_tb'):
        path = common.netlist(common.SCHEMATICS / (name + '.sch'),
                              common.WORK / ('equivalence_' + name), subckt=True)
        sources[name] = path.read_text()
    pattern = r'(?ims)^\.subckt\s+(\S+)[ \t]+([^\n]+)\n(.*?)^\.ends[^\n]*'
    def parts(source):
        source = re.sub(r'(?is)\.control.*?\.endc', '', re.sub(r'\n\+\s*', ' ', source))
        return {m[1].lower(): m[3] for m in re.finditer(pattern, source)}, re.sub(pattern, '', source)
    def devices(source, ground=False):
        return sorted(' '.join((re.sub(r'\bvss\b', '0', line.lower()) if ground else
            line.lower()).split()) for line in source.splitlines() if re.match(r'^[xmd]', line, re.I))
    main, _ = parts(sources['sram512'])
    children, top = parts(sources['sram512_tb'])
    left, right = devices(main.pop('sram512'), True), devices(top)
    assert left == right and all(devices(body) == devices(children[name]) for name, body in main.items())
    write(common.REPORTS / 'tb_core_equivalence.json', dict(passed=True,
        top_instances=len(left), child_subcircuits=len(main),
        scope='All MOS/subcircuit/diode connections and parameters; intentional top VSS-to-ground mapping; ideal TB sources and loads excluded.'))
    print('Fresh checks passed:', common.REPORTS, flush=True)


def negative_probes(output):
    scratch = Path(tempfile.mkdtemp(prefix='mutated_archive_source_', dir=output))
    names = subprocess.check_output(
        ['git', 'ls-files', '-z', 'sram512', 'scripts', 'klayout', 'pdk', 'reviews'],
        cwd=ROOT, text=True).split('\0')
    for name in filter(None, names):
        source = ROOT / name
        if source.is_file():
            target = scratch / name
            target.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(source, target)
    if not (scratch / '.pdk').exists():
        (scratch / '.pdk').symlink_to(ROOT / '.pdk', target_is_directory=True)
    relative = 'sram512/schematics/sram512_bitcell.sch'
    target = scratch / relative
    before = sha(target)
    original = target.read_text()
    assert original.count('w=3.4u') == 6
    target.write_text(original.replace('w=3.4u', 'w=6.8u', 1))
    with (output / 'mutated_archive.log').open('w') as log:
        process = subprocess.run([sys.executable, 'sram512/tools/package.py'],
                                 cwd=scratch, stdout=log, stderr=subprocess.STDOUT)
    summary_path = scratch / 'sram512/reports/validation_summary.json'
    summary = json.loads(summary_path.read_text())
    archives = sorted((scratch / 'build/sram512/submission').glob('*.zip'))
    manifests = []
    for path in archives:
        with zipfile.ZipFile(path) as archive:
            manifest = json.loads(archive.read('MANIFEST.json'))
            manifests.append(dict(path=str(path.relative_to(ROOT)),
                sha256=sha(path), status=manifest['status'],
                changed_schematic_in_archive=(
                    hashlib.sha256(archive.read(relative)).hexdigest() == sha(target))))
    # The current flat export has an additional independent source guard.
    with (output / 'mutated_flat_export.log').open('w') as log:
        flat = subprocess.run([sys.executable, 'sram512/tools/build_submission.py'],
                              cwd=scratch, stdout=log, stderr=subprocess.STDOUT)
    stale = dict(changed_source=relative, change='First MOS W: 3.4u -> 6.8u',
        original_sha256=before, changed_sha256=sha(target),
        summary_all_pass=summary['all_required_reports_pass'],
        summary_pass_count=sum(r['state'] == 'PASS' for r in summary['tests']),
        summary_stamps_changed_source=summary['source_snapshot'].get(relative) == sha(target),
        full_archive_exit_code=process.returncode, full_archives=manifests,
        flat_export_exit_code=flat.returncode,
        flat_export_source_guard_triggered='Verified electrical sources changed' in
            (output / 'mutated_flat_export.log').read_text())

    raw = ROOT / 'build/sram512/analog/pd102_nominal/sram512_tb.raw'
    t, waves = analog.load_raw(raw)
    case = analog.scenario()
    baseline = analog.verify_samples(t, waves, case, 5)
    changed = dict(waves)
    sdo = np.array(waves['v(sdo)'], copy=True)
    start = case['operations'][0]['first'] + 500
    stop = start + 200
    mask = (t >= start) & (t <= stop)
    assert mask.any()
    sdo[mask] = 5
    changed['v(sdo)'] = sdo
    glitch = analog.verify_samples(t, changed, case, 5)
    last = case['operations'][-1]['e0'] + 7 * case['period_ns']
    count = np.searchsorted(t, last, side='right')
    shortened = analog.verify_samples(t[:count],
        {name: data[:count] for name, data in waves.items()}, case, 5)
    trace = dict(source_waveform=str(raw.relative_to(ROOT)), source_sha256=sha(raw),
        baseline_passed=baseline['passed'], checks=baseline['checks'],
        sdo_glitch=dict(interval_ns=[start, stop], samples=int(mask.sum()),
            injected_v=5, expected_v=0, accepted_as_pass=glitch['passed']),
        truncated_trace=dict(actual_end_ns=float(t[count-1]),
            required_last_check_ns=case['operations'][-1]['e0'] + 7.8 * case['period_ns'],
            accepted_as_pass=shortened['passed']))
    result = dict(stale_evidence=stale, waveform_checker=trace,
        scope='Intentional defects are confined to scratch copies or arrays; live sources and raw files are read-only.')
    write(output / 'negative_probes.json', result)
    print(json.dumps(result, ensure_ascii=False, indent=2), flush=True)


def raw_map(path):
    with path.open('rb') as f:
        header = []
        while True:
            line = f.readline()
            assert line, 'Incomplete binary header'
            if line == b'Binary:\n':
                break
            header.append(line)
        offset = f.tell()
    text = b''.join(header).decode('ascii')
    assert 'Flags: real' in text
    nv = int(re.search(r'No. Variables:\s*(\d+)', text)[1])
    nt = int(re.search(r'No. Points:\s*(\d+)', text)[1])
    fields = [line.split() for line in text.rsplit('Variables:', 1)[1].splitlines() if line.strip()]
    assert [int(field[0]) for field in fields] == list(range(nv))
    assert path.stat().st_size == offset + nv * nt * 8
    return np.memmap(path, dtype='<f8', mode='r', offset=offset, shape=(nt, nv)), {
        field[1].lower(): int(field[0]) for field in fields}


def physical_waveform(name, output):
    folder = ROOT / 'build/sram512/analog' / name
    report_path = ROOT / 'sram512/reports' / (name + '.json')
    report = json.loads(report_path.read_text())
    deck_path = folder / 'test.spice'
    assert sha(deck_path) == report['deck_sha256']
    assert report['physical_extraction']['gds_sha256'] == sha(ROOT / 'sram512/layout/sram512.gds')
    raw_path = folder / 'sram512_tb.raw'
    raw, ids = raw_map(raw_path)
    mos, diode = [], []
    for line in deck_path.read_text().splitlines():
        f = line.lower().split()
        if f and re.fullmatch(r'xm\d+', f[0]):
            assert f[5] in ('nmos', 'pmos')
            mos.append((f[0], f[1:5], f[5]))
        elif f and f[0].startswith('dphysical'):
            diode.append((f[0], f[1:3], f[3]))
    assert len(mos) == report['physical_extraction']['mos_groups']
    # The extra column is exact SPICE ground, not the time vector.
    def index(net):
        return raw.shape[1] if net in ('0', 'vss') else ids['v(' + net + ')']
    terminals = np.array([[index(n) for n in m[1]] for m in mos])
    diode_indices = np.array([[index(n) for n in d[1]] for d in diode])
    pairs = dict(DS=(0, 2), GS=(1, 2), SB=(2, 3), DB=(0, 3), GD=(1, 0), GB=(1, 3))
    maxima = {pair: np.full(len(mos), -np.inf) for pair in pairs}
    peak_times = {pair: np.zeros(len(mos)) for pair in pairs}
    reverse = np.full(len(diode), -np.inf)
    min_time_step = np.inf
    for first in range(0, len(raw), 256):
        block = raw[first:first+256]
        assert np.isfinite(block).all()
        if first:
            assert block[0, 0] > raw[first-1, 0]
        assert (np.diff(block[:, 0]) > 0).all()
        if len(block) > 1:
            min_time_step = min(min_time_step, float(np.diff(block[:, 0]).min()))
        data = np.column_stack((block, np.zeros(len(block))))
        v = data[:, terminals]
        for pair, (a, b) in pairs.items():
            difference = np.abs(v[:, :, a] - v[:, :, b])
            which = difference.argmax(axis=0)
            values = difference[which, np.arange(len(mos))]
            newer = values > maxima[pair]
            maxima[pair][newer] = values[newer]
            peak_times[pair][newer] = block[which[newer], 0] * 1e9
        if diode:
            dv = data[:, diode_indices]
            reverse = np.maximum(reverse, (dv[:, :, 1] - dv[:, :, 0]).max(axis=0))
    found = {}
    for pair in pairs:
        i = int(maxima[pair].argmax())
        found[pair] = dict(device=mos[i][0], model=mos[i][2], nets=mos[i][1],
            peak_abs_v=float(maxima[pair][i]), time_ns=float(peak_times[pair][i]),
            reported_peak_abs_v=report['voltage_limits']['maximum_by_pair'][pair]['peak_abs_v'],
            over_5p75_groups=int((maxima[pair] > 5.75).sum()))
    case = json.loads((folder / 'scenario.json').read_text())
    # Independently count selected addresses; sample all cell states from raw.
    when = case['operations'][0]['first'] - .2 * case['period_ns']
    row = int(np.searchsorted(raw[:, 0], when * 1e-9))
    q = raw[row, [ids[f'v(xarray.xr{r}c{c}.q)'] for r in range(16) for c in range(32)]]
    qb = raw[row, [ids[f'v(xarray.xr{r}c{c}.qb)'] for r in range(16) for c in range(32)]]
    result = dict(name=name, source_report_sha256=sha(report_path), deck_sha256=sha(deck_path),
        waveform_sha256=sha(raw_path), source_gds_sha256=sha(ROOT / 'sram512/layout/sram512.gds'),
        finite_samples=True, points=len(raw), variables=raw.shape[1],
        interval_ns=[float(raw[0, 0] * 1e9), float(raw[-1, 0] * 1e9)],
        expected_stop_ns=case['stop_ns'], minimum_step_ns=min_time_step * 1e9,
        mos_groups=len(mos), maximum_by_pair=found,
        diode_maximum_reverse_v={d[0]: float(value) for d, value in zip(diode, reverse)},
        initial_ones_observed=int((q > qb).sum()),
        selected_addresses=sorted({32 * op['row'] + op['col'] for op in case['operations']}),
        scope='Independent full binary-sample scan using terminal connections parsed from the saved electrical deck; no new transient simulation.')
    write(output / (name + '_independent.json'), result)
    print(name, 'sample scan complete; max |V| =',
          max(value['peak_abs_v'] for value in found.values()), flush=True)


def main():
    p = argparse.ArgumentParser(description=__doc__)
    mode = p.add_mutually_exclusive_group()
    mode.add_argument('--waveforms', action='store_true')
    mode.add_argument('--fresh', action='store_true')
    p.add_argument('--output', type=Path, default=ROOT / 'build/sram512/review_20260913/probes')
    p.add_argument('--cases', nargs='+', default=[
        'decoderfix_power_paths_ramp', 'decoderfix_pg_rc3_lowhot',
        'decoderfix_reset_write0', 'decoderfix_reset_write1'])
    args = p.parse_args()
    args.output = args.output.resolve()
    assert args.output.is_relative_to(ROOT / 'build'), 'Review outputs belong under build/'
    args.output.mkdir(parents=True, exist_ok=True)
    if args.fresh:
        fresh_checks(args.output)
    elif args.waveforms:
        for name in args.cases:
            assert re.fullmatch(r'[a-zA-Z0-9_]+', name)
            physical_waveform(name, args.output)
    else:
        negative_probes(args.output)


if __name__ == '__main__':
    main()
