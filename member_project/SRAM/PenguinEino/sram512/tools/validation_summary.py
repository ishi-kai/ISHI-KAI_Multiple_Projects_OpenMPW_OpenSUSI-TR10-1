#!/usr/bin/env python3
"""Index the current candidate's evidence; missing/failed tests stay visible.

This does not run verification or certify fabrication. Run the documented
checks first. The summary records report hashes and the source snapshot.
"""
from datetime import datetime, timezone
from common import *
from evidence import check as check_evidence

REQUIRED = [
    ('saved_layout_recheck', 'Current schematic / drawing DRC / strict LVS / full mask DRC', True),
    ('pcell_preservation', 'Original PCell geometry preservation', True),
    ('digital', 'All 512 addresses, March C-, all reset phases', False),
    ('decoderfix_decode_coverage', 'Extracted MOS: every row and column, both data', True),
    ('decoderfix_startup_5n', 'Supply ramp with physical signal and power networks', True),
    ('decoderfix_startup_1n', 'Finer-step supply ramp, all MOS voltages and vias', True),
    ('decoderfix_startup_comparison', 'Startup time-step comparison on the current GDS', True),
    ('decoderfix_mesh4_prefix', 'All physical gate taps and voltages in first complete access', True),
    ('decoderfix_mesh8_prefix', 'Finer spatial RC model of first complete access', True),
    ('decoderfix_signal_resolution', 'Spatial RC resolution: both circuits PASS and peaks agree', True),
    ('decoderfix_power_paths_ramp', 'Power ramp followed by 16 accesses, signal and supply R/C', True),
    ('decoderfix_pg_rc3_lowhot', 'Combined supply and RC x3, 4.5 V / 85 C, all four corners, 16 accesses', True),
    ('decoderfix_power_paths_ramp_power_wires', 'Supply-metal mean/RMS current screen over the full nominal sequence', True),
    ('decoderfix_pg_rc3_lowhot_power_wires', 'Supply-metal mean/RMS current screen over the full RC x3 low/hot sequence', True),
    ('decoderfix_operational_hot', '20 us supply ramp, 1 ms retention and asynchronous interruptions', True),
    ('decoderfix_reset_write0', 'Abort write 0 at address 511 with actual signal/power RC; retain all 511 other cells', True),
    ('decoderfix_reset_write1', 'Abort write 1 at address 511 while CLK is high; retain all 511 other cells', True),
] + [
    ('analog_pd102_' + n, 'Schematic MOS sensitivity: ' + n, False)
    for n in ('nominal', 'low_cold', 'low_hot', 'high_cold', 'high_hot',
              'wire_3x', 'wire_1p_hot', 'vth_slow_n_fast_p', 'vth_fast_n_slow_p')
]

REQUIRED_OPERATIONS = {
    'decoderfix_decode_coverage':136,
    'decoderfix_power_paths_ramp':16,
    'decoderfix_pg_rc3_lowhot':16,
    'decoderfix_operational_hot':28,
    'decoderfix_mesh4_prefix':1,
    'decoderfix_mesh8_prefix':1,
    'decoderfix_reset_write0':4,
    'decoderfix_reset_write1':4,
    **{'analog_pd102_'+n:16 for n in ('nominal','low_cold','low_hot','high_cold','high_hot',
        'wire_3x','wire_1p_hot','vth_slow_n_fast_p','vth_fast_n_slow_p')},
}

REQUIRE_SIGNAL_MESH = {'decoderfix_power_paths_ramp', 'decoderfix_pg_rc3_lowhot',
                      'decoderfix_mesh4_prefix','decoderfix_mesh8_prefix',
                      'decoderfix_reset_write0','decoderfix_reset_write1'}
KNOWN_SIGNAL_DIAGNOSTICS = ('pd102_signal_mesh4_prefix', 'pd102_signal_mesh8_prefix',
                            'signalfix_decoder_voltage_diagnostic')
WIRE_AUDITS = {'decoderfix_'+n+'_power_wires':'decoderfix_'+n
               for n in ('power_paths_ramp','pg_rc3_lowhot')}


def wire_audit_complete(name, result):
    if name not in WIRE_AUDITS:
        return True
    source = WIRE_AUDITS[name]
    path = REPORTS / (source + '.json')
    if not path.is_file():
        return False
    case = json.loads(path.read_text())
    interval = result.get('interval_ns', [])
    # These named tests cover 16 full 18-clock operations, following the
    # initial two-clock delay and supply ramp. A prefix is insufficient.
    stop = (2 + 18 * REQUIRED_OPERATIONS[source]) * case['period_ns'] + case['startup_ramp_ns']
    return (case.get('passed') is True and result.get('source_case') == source
            and result.get('source_case_report_sha256') == sha(path)
            and len(interval) == 2 and abs(interval[0]) < 1e-6 and abs(interval[1] - stop) < 1e-3)


def source_files():
    todo = [ROOT / 'sram512/schematics/sram512_macro.sch', ROOT / 'sram512/schematics/sram512_tb.sch']
    seen, files = set(), {ROOT / 'sram512/schematics/sram512_macro.sym'}
    while todo:
        p = todo.pop()
        if p in seen:
            continue
        seen.add(p)
        files.add(p)
        for symbol in re.findall(r'^C \{([^}]+)\}', p.read_text(), re.M):
            q = SCHEMATICS / symbol
            if q.is_file():
                files.add(q)
                if q.with_suffix('.sch').is_file():
                    todo.append(q.with_suffix('.sch'))
    files.update(ROOT / n for n in ('sram512/rtl/sram_serial_controller.v', 'sram512/rtl/sram512_digital_gates.v',
        'sram512/tb/tb_sram512.sv', 'klayout/sram_pcell/build.py', 'pdk/profiles.lock.json'))
    return {str(p.relative_to(ROOT)):sha(p) for p in sorted(files)}


def source_gds(result):
    for key in ('gds_sha256', 'source_gds_sha256', 'drawing_sha256'):
        if key in result:
            return result[key]
    for key in ('physical_extraction', 'source'):
        if isinstance(result.get(key), dict):
            answer = source_gds(result[key])
            if answer:
                return answer


def main():
    digest = sha(HERE / 'layout/sram512.gds')
    rows = []
    for name, purpose, physical in REQUIRED:
        path = REPORTS / (name + '.json')
        row = dict(test=name, purpose=purpose, report=str(path.relative_to(ROOT)), state='PENDING')
        if path.is_file():
            r = json.loads(path.read_text())
            receipt_matches, receipt_errors, receipt = check_evidence(name)
            matches = receipt_matches and (not physical or source_gds(r) == digest)
            complete = (name not in REQUIRED_OPERATIONS or r.get('operations') == REQUIRED_OPERATIONS[name]) and wire_audit_complete(name, r)
            detailed = name not in REQUIRE_SIGNAL_MESH or (
                r.get('signal_mesh') is True and r.get('physical_gate_paths') is True
                and r.get('signal_sections',0)>=4)
            if name in ('decoderfix_reset_write0','decoderfix_reset_write1'):
                reset=r.get('reset_address_checks',{})
                bit=int(name[-1])
                complete = complete and (reset.get('passed') is True
                    and reset.get('interruptions')==1
                    and reset.get('unselected_cells_per_interruption')==511
                    and reset.get('targets')==[[15,31]] and reset.get('write_data')==[bit]
                    and reset.get('clock_levels')==[bit])
            row.update(state=('STALE' if not matches else
                              'PASS' if r.get('passed') and complete and detailed else 'FAIL'),
                       report_sha256=sha(path), source_matches=matches,
                       evidence_receipt=receipt, evidence_errors=receipt_errors,
                       required_operations=REQUIRED_OPERATIONS.get(name), scope_complete=complete,
                       required_signal_model_present=detailed,
                       checks=r.get('checks'), failure_count=r.get('failure_count', 0))
        rows.append(row)
    blocking = []
    for name in KNOWN_SIGNAL_DIAGNOSTICS:
        path = REPORTS/(name+'.json')
        if not path.exists():continue
        report = json.loads(path.read_text())
        if source_gds(report)==digest and not report.get('passed',False):
            blocking.append(dict(test=name,report_sha256=sha(path),
                                 failure_count=report.get('failure_count'),
                                 reason='Reproduced signal margin / terminal voltage failure on this GDS.'))
    result = dict(all_required_reports_pass=all(r['state'] == 'PASS' for r in rows) and not blocking,
        created_utc=datetime.now(timezone.utc).isoformat(), source_gds_sha256=digest,
        source_mask_sha256=sha(HERE / 'layout/sram512_mask.gds'),
        source_snapshot=source_files() if all(r['state']=='PASS' for r in rows) and not blocking else {},
        current_source_snapshot=source_files(),
        pdk=provenance('dev'), tests=rows, blocking_signal_diagnostics=blocking,
        scope='Evidence index for this source snapshot, not a replacement for fresh verification. RC coefficients and global Vth shifts are uncalibrated sensitivity tests; pad/frame integration and statistical yield qualification are outside this core verification.')
    write_json(REPORTS / 'validation_summary.json', result)
    print('\n'.join(f'{r["state"]:7} {r["test"]}' for r in rows))
    for r in blocking:print('FAIL    '+r['test']+' (release blocker)')
    print('All required reports pass:', result['all_required_reports_pass'])
    return result


if __name__ == '__main__':
    raise SystemExit(0 if main()['all_required_reports_pass'] else 1)
