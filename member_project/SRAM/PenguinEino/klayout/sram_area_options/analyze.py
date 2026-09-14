#!/usr/bin/env python3
"""Audit 16x64 peripheral reduction candidates without changing the design.

Areas use the same measured abutted standard-cell widths as the macro study.
Boolean equivalence is exhaustive; this is not timing, SPICE or layout signoff.
"""
from collections import Counter
from pathlib import Path
import hashlib
import json
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(HERE.parent / 'sram_macro_study'))
import estimate_capacity as area_model
from macro_model import digital


class Network:
    def __init__(self):
        self.parts = []

    def gate(self, kind, *inputs, out=None):
        out = out or f'n{len(self.parts)}'
        self.parts.append(dict(kind=kind, inputs=list(inputs), output=out))
        return out

    @property
    def bom(self):
        return Counter(p['kind'] for p in self.parts)

    def evaluate(self, inputs):
        values = dict(inputs)
        for p in self.parts:
            values[p['output']] = gate_value(p['kind'], [values[n] for n in p['inputs']])
        return values


def gate_value(kind, v):
    if kind == 'INV_X1': return not v[0]
    if kind == 'XOR2': return bool(v[0]) != bool(v[1])
    if kind.startswith('NAND'): return not all(v)
    if kind.startswith('NOR'): return not any(v)
    if kind.startswith('AND'): return all(v)
    if kind.startswith('OR'): return any(v)
    raise ValueError(kind)


def compact_control():
    """Exact count=0..31 behavior for N=11, including invalid-count recovery.

    The existing 33 DFFR and 24 MUX2 remain. All four control output FFs remain.
    C/QB and W/QB are outputs of existing FFs, not free added inverters.
    """
    n = Network(); g = n.gate
    carry2 = g('AND2_X1', 'C0', 'C1')
    carry3 = g('AND3_X1', 'C0', 'C1', 'C2')
    carry4 = g('AND4_X1', 'C0', 'C1', 'C2', 'C3')
    low_upper_zero = g('NOR3', 'C3', 'C2', 'C1')
    run = g('OR2', 'C4B', low_upper_zero)  # count < 18
    toggles = ['C0B'] + [g('XOR2', f'C{i}', carry)
                            for i, carry in enumerate(['C0', carry2, carry3, carry4], 1)]
    outputs = {f'next{i}': g('AND2_X1', t, run) for i, t in enumerate(toggles)}
    reject_low = g('AND2_X1', 'C3', g('OR2', 'C2', carry2))
    outputs['rx'] = g('NOR2', 'C4', reject_low)  # count < 11
    high8 = g('NOR2', 'C4', 'C3B')  # 8..15
    high12 = g('AND2_X1', high8, 'C2')  # 12..15
    high16 = g('AND2_X1', 'C4', low_upper_zero)  # 16..17
    e0 = g('AND4_X1', high8, 'C2B', 'C1', 'C0')  # 11
    outputs['e0'] = outputs['pc_d'] = e0
    outputs['wl_d'] = g('AND2_X1', high12, 'C1')  # 14..15
    low_nonzero = g('NAND2', 'C0B', 'C1B')
    write13_15_b = g('NAND2', high12, low_nonzero)
    write16_b = g('NAND2', high16, 'C0B')
    write_window = g('NAND2', write13_15_b, write16_b)  # 13..16
    outputs['write_d'] = g('AND2_X1', write_window, 'W')
    not_low3 = g('NAND2', 'C0', 'C1')
    track_later_b = g('NAND3', high12, not_low3, 'WB')  # !W & count=12..14
    we_b = g('INV_X1', 'WE')
    track0_b = g('NAND2', e0, we_b)
    outputs['track_d'] = g('NAND2', track0_b, track_later_b)
    outputs['capture'] = g('AND3_X1', high16, 'C0', 'WB')  # 17 & !W
    return n, outputs


def baseline_control_values(circuit, inputs):
    values = dict(inputs)
    for p in circuit.parts:
        if p['kind'] == 'DFFR':
            q, qb = p['nets']['Q'], p['nets']['QB']
            values.setdefault(q, False)
            values.setdefault(qb, not values[q])
    for p in circuit.parts:
        k, m = p['kind'], p['nets']
        if k == 'DFFR': continue
        if k == 'MUX2': values[m['Y']] = values[m['B']] if values[m['S']] else values[m['A']]
        else: values[m['Y']] = gate_value(k, [values[m[a]] for a in 'ABCD' if a in m])
    ff = {p['nets']['Q']: p['nets'] for p in circuit.parts if p['kind'] == 'DFFR'}
    mux = {p['nets']['Y']: p['nets'] for p in circuit.parts if p['kind'] == 'MUX2'}
    result = {f'next{i}': values[ff[f'C{i}']['D']] for i in range(5)}
    result.update(rx=values[mux[ff['SR0']['D']]['S']],
                  e0=values[mux[ff['W']['D']]['S']],
                  pc_d=values[ff['PC_ON']['D']], wl_d=values[ff['WL_EN']['D']],
                  write_d=values[ff['WRITE_EN']['D']], track_d=values[ff['TRACK']['D']],
                  capture=values[mux[ff['SDO']['D']]['S']])
    return result


def verify_control(circuit, n, outputs):
    cases = comparisons = 0
    for count in range(32):
        for w in (False, True):
            for we in (False, True):
                inputs = dict(W=w, WB=not w, WE=we, SDI=False, SOUT=False)
                for i in range(5):
                    inputs[f'C{i}'] = bool(count >> i & 1)
                    inputs[f'C{i}B'] = not inputs[f'C{i}']
                expected = baseline_control_values(circuit, inputs)
                actual = n.evaluate(inputs)
                for signal, net in outputs.items():
                    assert actual[net] == expected[signal], (count, w, we, signal)
                    comparisons += 1
                cases += 1
    return dict(cases=cases, signal_comparisons=comparisons,
                scope='All 32 count codes x W x WE; exact next-count bits and FF/MUX controls. Zero delay.')


def negative_decoder(bits, row=False):
    n = Network(); g = n.gate
    size = bits // 2
    pre = []
    for group in range(2):
        terms = []
        for value in range(2**size):
            pins = [f'A{i+group*size}' + ('' if value >> i & 1 else 'B') for i in range(size)]
            terms.append(g(f'NAND{size}', *pins))
        pre.append(terms)
    out = []
    for value in range(2**bits):
        pins = [pre[0][value % (2**size)], pre[1][value // (2**size)]]
        if row: pins += ['ENB']  # Existing WL_EN FF's QB; requires a new internal route/port.
        out.append(g('NOR3' if row else 'NOR2', *pins))
    cases = 0
    for address in range(2**bits):
        for en in (False, True) if row else (True,):
            inputs = {'ENB': not en}
            for i in range(bits):
                inputs[f'A{i}'] = bool(address >> i & 1)
                inputs[f'A{i}B'] = not inputs[f'A{i}']
            actual = n.evaluate(inputs)
            assert [actual[x] for x in out] == [en and i == address for i in range(2**bits)]
            cases += 1
    return n, cases


def main():
    # Keep the pre-change baseline so the historical savings remain reproducible.
    circuit, meta, groups = digital(4, 6, share_frame=False)
    # Restrict reference evaluation to controller, without addressing/data outputs.
    controller_parts = sum(groups['controller'].values())
    circuit.parts = circuit.parts[:controller_parts]
    ctrl = Counter(groups['controller'])
    combined_baseline = area_model.area(ctrl)
    n, outputs = compact_control()
    checks = verify_control(circuit, n, outputs)
    optimized_ctrl = n.bom + Counter(DFFR=33, MUX2=24)
    row, row_cases = negative_decoder(4, row=True)
    col, col_cases = negative_decoder(6)
    def option(before, after):
        a, b = area_model.area(before), area_model.area(after)
        return dict(before_bom=dict(before), after_bom=dict(after), before_um2=a, after_um2=b, saved_um2=a-b)
    control = option(ctrl, optimized_ctrl)
    row_result = option(groups['row_decoder'], row.bom)
    col_result = option(groups['col_decoder'], col.bom)
    # 8 groups of 8 columns. Two differential first-stage pass FETs per column;
    # two second-stage pass FETs per group. High/low 3-bit decoding retained.
    for address in range(64):
        connected = [c for c in range(64) if c % 8 == address % 8 and c // 8 == address // 8]
        assert connected == [address]
    hierarchical = option(groups['col_decoder'], Counter(AND3_X1=16))
    hierarchical.update(first_stage_nmos=128, second_stage_nmos=16, added_nmos=16,
                        optional_intermediate_precharge_pmos=16,
                        low_select_gate_fanout_before=2, low_select_gate_fanout_after=16,
                        switch_path_checks=64,
                        scope='Gross digital saving only. Added analog area, larger drivers, intermediate-line PC/RC and write margin NOT evaluated.')
    register_saving = 11 * area_model.area(dict(DFFR=1, MUX2=1))
    array_area = 1514.6 * 473.6
    baseline_digital = 451027.5
    sharing_and_logic = register_saving + control['saved_um2'] + row_result['saved_um2'] + col_result['saved_um2']
    paths = [Path(__file__), Path(area_model.__file__), HERE.parent/'sram_macro_study/macro_model.py',
             ROOT/'build/sram_macro_study/serial/sram_tb_serial.spice',
             area_model.PDK/'libs.tech/klayout/libraries/TR-1um_STDCELL.gds']
    report = dict(configuration='16 rows x 64 columns, N=11, K=5, 19 clocks per operation',
                  scope='Candidate search only; no production RTL/schematic edits, new SPICE runs, or physical layout.',
                  area_scope='55 um abutted-row area; excludes routing/analog additions. Existing 12 BUF_X4 budget retained.',
                  baseline_controller_um2=combined_baseline,
                  baseline_ff_um2=area_model.area({'DFFR':33}),
                  baseline_mux_um2=area_model.area({'MUX2':24}),
                  baseline_other_controller_um2=area_model.area(ctrl-Counter(DFFR=33,MUX2=24)),
                  compact_control=control, control_equivalence=checks,
                  control_network=n.parts, control_outputs=outputs,
                  negative_row_decoder=row_result, negative_column_decoder=col_result,
                  decoder_checks=dict(row_cases=row_cases,column_cases=col_cases),
                  hierarchical_column_mux=hierarchical,
                  previously_discussed_register_sharing_saved_um2=register_saving,
                  register_sharing_plus_both_negative_decoders_plus_compact_control=dict(
                      saved_um2=sharing_and_logic,
                      array_plus_digital_um2=round(array_area+baseline_digital-sharing_and_logic,2),
                      residual_area_um2=round(1080000-array_area-baseline_digital+sharing_and_logic,2),
                      scope='Arithmetic candidate combination, not implemented together; residual must cover analog, routing and any upsizing.'),
                  caveats=['Negative row NOR3 has a stacked PMOS pullup; 128 access-gate WL load may need upsizing.',
                           'Negative decode alternatives and hierarchical column mux are mutually exclusive at the column final stage.',
                           'Counter decode optimization preserves logic, not propagation delays or setup/hold margins.',
                           'Further FF/MUX custom-cell estimates cannot be inferred from transistor counts alone.'],
                  source_sha256={str(p.relative_to(ROOT)) if p.is_relative_to(ROOT) else str(p):hashlib.sha256(p.read_bytes()).hexdigest() for p in paths})
    (HERE/'results.json').write_text(json.dumps(report,indent=2)+'\n')
    print(json.dumps({k:v for k,v in report.items() if k not in ('control_network','source_sha256')},indent=2))


if __name__ == '__main__':
    main()
