#!/usr/bin/env python3
"""Additional shared receive/access register regression.

First run verify_serial_spice.py to obtain a fresh netlist of the saved .sch.
This program never regenerates schematics. Generated tests, logs and waveforms
stay in build/shared_frame/retest_20260912. Run --section logic or analog.
"""
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path
import argparse
import hashlib
import json
import re
import subprocess
import sys

import numpy as np

from review_sram import subcircuits, controller_truth
from serial_spice_stimulus import pwl
from verify_rtl import tool, LOCAL_ICARUS, run
from verify_serial_spice import rtl_reference, verify

ROOT = Path(__file__).resolve().parents[1]
BASE = ROOT / 'build/serial_spice'
WORK = ROOT / 'build/shared_frame/retest_20260912'


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def icarus(source, work):
    cc, vv = [tool('iverilog')], [tool('vvp')]
    if cc[0] == LOCAL_ICARUS / 'bin/iverilog':
        ivl = next((LOCAL_ICARUS / 'lib').glob('*/ivl'))
        cc += ['-B', ivl]; vv += ['-M', ivl]
    run(cc + ['-g2012', '-Wall', '-s', 'test', '-o', 'sim',
              ROOT / 'sram512/rtl/sram_serial_controller.v', source], work, 'compile.log')
    return run(vv + ['sim'], work, 'simulation.log')


def exhaustive_rtl(netlist):
    """Compare every ideal gate next-state vector to actual compiled RTL.

    Every 13-bit storage assignment and SDI/WE/SOUT is included, even unreachable
    count/control combinations. Also reset every storage assignment with CLK
    held LOW and HIGH. No transistor timing is implied by the Boolean model.
    """
    work = WORK / 'exhaustive_logic'; work.mkdir(parents=True, exist_ok=True)
    subs = subcircuits(netlist); parts = []
    for line in subs['sram_serial_controller'][1].splitlines():
        if line.lower().startswith('x'):
            words = line.lower().split(); kind = words[-1]
            assert len(words[1:-1]) == len(subs[kind][0])
            parts.append((kind, dict(zip(subs[kind][0], words[1:-1]))))
    ffs = [p for k, p in parts if k == 'dffr']
    assert len(ffs) == 13
    mapping = {**{f'c{i}': f'dut.count[{i}]' for i in range(4)},
               'din': 'dut.shift_reg[0]', 'ca': 'dut.shift_reg[1]',
               'ra': 'dut.shift_reg[2]', 'w': 'dut.W', 'pc_on': 'dut.PC_ON',
               'track': 'dut.TRACK', 'wl_en': 'dut.WL_EN',
               'write_en': 'dut.WRITE_EN', 'sdo': 'dut.READ_DATA'}
    assert {p['q'] for p in ffs} == set(mapping)
    a = np.arange(1 << 16, dtype=np.uint32)
    values = {'vdd': np.ones(len(a), bool), 'vss': np.zeros(len(a), bool)}
    for i, p in enumerate(ffs):
        values[p['q']] = (a >> i & 1).astype(bool)
        values[p['qb']] = ~values[p['q']]
        assert p['rst'] == 'reset' and p['ck'] == 'clk'
    for i, name in enumerate(('sdi', 'we', 'sout'), 13):
        values[name] = (a >> i & 1).astype(bool)
    pending = [(k, p) for k, p in parts if k != 'dffr']
    while pending:
        remaining = []
        for kind, p in pending:
            ins = ['a'] if kind == 'inv_x1' else ['a', 'b', 's'] if kind == 'mux2' else [x for x in 'abcd' if x in p]
            if any(p[x] not in values for x in ins):
                remaining.append((kind, p)); continue
            v = [values[p[x]] for x in ins]
            if kind == 'inv_x1': y = ~v[0]
            elif kind == 'mux2': y = np.where(v[2], v[1], v[0])
            elif kind == 'xor2': y = v[0] ^ v[1]
            elif kind.startswith(('and', 'nand')):
                y = np.logical_and.reduce(v)
                if kind.startswith('nand'): y = ~y
            elif kind.startswith(('or', 'nor')):
                y = np.logical_or.reduce(v)
                if kind.startswith('nor'): y = ~y
            else: raise ValueError(kind)
            values[p['y']] = y
        assert len(remaining) < len(pending), 'Unresolved gate network'
        pending = remaining
    expected = sum(values[p['d']].astype(np.uint32) << i for i, p in enumerate(ffs))
    (work / 'expected.hex').write_text(''.join(f'{v:04x}\n' for v in expected))
    state = '{' + ','.join(mapping[p['q']] for p in reversed(ffs)) + '}'
    assign = '\n'.join(f"{mapping[p['q']]} = vector[{i}];" for i, p in enumerate(ffs))
    source = f'''`timescale 1ns/1ps
module test;
reg CLK=0, RESET=0, SDI=0, WE=0, SOUT=0;
wire RA, CA, DIN, SDO, PREB, YPREB, WRITE_EN, WL_EN, SAE;
sram_serial_controller dut(.CLK(CLK),.RESET(RESET),.SDI(SDI),.WE(WE),.SOUT(SOUT),
 .RA(RA),.CA(CA),.DIN(DIN),.SDO(SDO),.PREB(PREB),.YPREB(YPREB),
 .WRITE_EN(WRITE_EN),.WL_EN(WL_EN),.SAE(SAE));
reg [12:0] expected [0:65535];
integer vector, polarity;
initial begin
 $readmemh("expected.hex", expected);
 for (vector=0; vector<65536; vector=vector+1) begin
  CLK=0; RESET=0; #1;
  {assign}
  SDI=vector[13]; WE=vector[14]; SOUT=vector[15]; #1;
  if ({{RA,CA,DIN}} !== dut.shift_reg) $fatal(1,"frame output mapping");
  if ({{PREB,YPREB,SAE,SDO}} !== {{~dut.PC_ON,~dut.PC_ON,~dut.TRACK,dut.READ_DATA}})
   $fatal(1,"inverted/held outputs");
  CLK=1; #1;
  if ({state} !== expected[vector]) $fatal(1,"next-state mismatch vector %0d",vector);
 end
 for (polarity=0; polarity<2; polarity=polarity+1) begin
  CLK=polarity; #1;
  for (vector=0; vector<8192; vector=vector+1) begin
   RESET=0; #1; {assign}
   #1; RESET=1; #1;
   if ({state} !== 13'b0) $fatal(1,"async reset vector %0d clock %0d",vector,polarity);
   if ({{PREB,YPREB,SAE}} !== 3'b111) $fatal(1,"async reset inverse outputs");
  end
 end
 $display("PASS 65536 next-state vectors, 16384 asynchronous reset vectors");
 $finish;
end
endmodule
'''
    (work / 'test.sv').write_text(source)
    log = icarus(work / 'test.sv', work); assert 'PASS ' in log
    return dict(next_state_vectors=65536, next_state_bits=851968,
                async_reset_vectors=16384, async_reset_bits=212992,
                passed=True, gate_specification_check=controller_truth(netlist))


def logic(netlist):
    truth = exhaustive_rtl(netlist)
    print('Exhaustive schematic gate vs compiled RTL: PASS', flush=True)
    # Exercise every row/column width supported by the expanded decoder study.
    sys.path.insert(0, str(ROOT / 'klayout/sram_macro_study'))
    import verify_scaling as scaling
    scaling.WORK = WORK / 'scaling'; scaling.WORK.mkdir(exist_ok=True)
    scaling.source_text = lambda: netlist
    shapes = [(r, c) for r in range(1, 7) for c in range(1, 7)]
    gates = [scaling.logic_test(*s) for s in shapes]
    rtl = []
    for r, c in shapes:
        extra = ['--exhaustive'] if (r, c) == (1, 1) else []
        output = run([sys.executable, ROOT / 'scripts/verify_rtl.py',
                      '--row-bits', r, '--col-bits', c] + extra,
                     WORK, f'rtl_{r}_{c}.log')
        match = re.search(r'PASS (\d+x\d+): (\d+) operations, (\d+) checks, (\d+) async resets', output)
        assert match, output
        rtl.append(dict(shape=match[1], operations=int(match[2]), checks=int(match[3]), resets=int(match[4])))
    return dict(exhaustive=truth, generated_gates=gates, functional_rtl=rtl,
                command_pairs=2304, initial_memory_backgrounds=16)


class Stimulus:
    def __init__(self):
        self.events = {0: dict(CLK=0, RESET=1, SDI=0, WE=0), 120: dict(RESET=0)}
        self.next = 250; self.operations = []; self.edges = []
        self.memory = {}; self.resets = [(0, 245)]; self.forget = False

    def put(self, t, **values):
        self.events.setdefault(t, {}).update(values)

    def pulse(self, bit, we):
        t = self.next; self.next += 100
        self.put(t-40, SDI=bit, WE=we)
        self.put(t, CLK=1); self.put(t+50, CLK=0); self.edges.append(t)
        return t

    def frame(self, address, data, pause=False):
        first = self.next
        for i, bit in enumerate((address >> 1, address & 1, data)):
            self.pulse(bit, i % 2)
            if pause and i < 2:
                # External pins change while the clock remains stopped LOW.
                self.put(self.next+50, SDI=1-bit, WE=1)
                self.put(self.next+350, SDI=bit, WE=0)
                self.next += 1000
        return first

    def access(self, address, wr, value=0, pause=False):
        data = value if wr else self.memory[address]
        first = self.frame(address, value if wr else 0, pause)
        e0 = self.next
        for e in range(8): self.pulse(e % 2, wr if e == 0 else 1-wr)
        self.operations.append(dict(first=first, e0=e0, row=address >> 1,
                                    col=address & 1, write=wr, data=data,
                                    forget_memory_before=self.forget))
        self.forget = False
        if wr: self.memory[address] = value

    def initialize(self, pattern):
        for a in range(4): self.access(a, 1, pattern >> a & 1)

    def reset(self, active_access=False, high=False):
        # Last pulse starts at next-100; assert at +20 HIGH or +70 LOW.
        t = self.next - (80 if high else 30)
        self.put(t, RESET=1)
        self.put(t+130, RESET=0)
        self.resets.append((t, t+245)); self.next = t+250
        if active_access:
            # All memory is unspecified by the interrupted-access contract.
            self.memory.clear(); self.forget = True

    def finish(self):
        state = dict(CLK=0, RESET=1, SDI=0, WE=0); timeline = []
        for t, changes in sorted(self.events.items()):
            state.update(changes); timeline.append(dict(time=t, **state))
        timeline.append(dict(time=self.next+100, **state))
        return dict(timeline=timeline, operations=self.operations, edges=self.edges,
                    reset_windows=self.resets, stop=self.next+100)


def analog_cases():
    cases = []
    for pattern in range(16):
        s = Stimulus(); s.initialize(pattern)
        for a in (3, 0, 2, 1): s.access(a, 0, pause=pattern == 6 and a == 3)
        cases.append((f'pattern_{pattern:02d}', s.finish()))
    # Euler tour of the complete directed command graph, including self edges.
    remaining = {i: list(range(12)) for i in range(12)}
    stack = [0]; tour = []
    while stack:
        v = stack[-1]
        if remaining[v]: stack.append(remaining[v].pop())
        else: tour.append(stack.pop())
    tour.reverse()
    assert len(set(zip(tour, tour[1:]))) == 144
    for start in range(0, 144, 32):
        s = Stimulus(); s.initialize(6)
        commands = tour[start:min(start+32, 144)+1]
        for code in commands: s.access(code // 3, int(code % 3 != 0), int(code % 3 == 2))
        case = s.finish(); case['command_pairs'] = list(zip(commands, commands[1:]))
        cases.append((f'pairs_{start:03d}', case))
    for phase in range(3):
        for high in (False, True):
            s = Stimulus(); s.initialize(6)
            for _ in range(phase+1): s.pulse(1, 1)
            s.reset(high=high)
            for a in range(4): s.access(a, 0)
            cases.append((f'reset_rx{phase}_{int(high)}', s.finish()))
    for phase in range(8):
        for wr in (0, 1):
            # All access phases LOW, plus two active-WL assertions while HIGH.
            for high in ([False, True] if (phase, wr) in ((3, 1), (4, 0)) else [False]):
                s = Stimulus(); s.initialize(6); s.frame(3, wr)
                for _ in range(phase+1): s.pulse(1, wr)
                s.reset(active_access=True, high=high)
                s.initialize(9)
                for a in range(4): s.access(a, 0)
                cases.append((f'reset_e{phase}_w{wr}_{int(high)}', s.finish()))
    return cases


def analog_case(netlist, name, case):
    work = WORK / 'analog' / name; work.mkdir(parents=True, exist_ok=True)
    deck = netlist
    for pin in ('CLK', 'RESET', 'SDI', 'WE'):
        pattern = rf'(?m)^V{pin} [^\n]+(?:\n\+[^\n]+)*'
        deck, count = re.subn(pattern, lambda _: f'V{pin} {pin} GND {pwl(pin, case["timeline"])}', deck)
        assert count == 1
    wr = next(line for line in deck.splitlines() if line.startswith('wrdata serial_spice_waveforms.txt '))
    signals = wr.split('serial_spice_waveforms.txt ', 1)[1]
    control = f'.control\nset noaskquit\nsave {signals}\ntran 0.5n {case["stop"]}n\nset wr_singlescale\nset wr_vecnames\n{wr}\nquit\n.endc'
    deck = re.sub(r'(?s)\.control\n.*?\.endc', lambda _: control, deck)
    (work / 'test.spice').write_text(deck)
    (work / 'scenario.json').write_text(json.dumps(case, indent=2)+'\n')
    with (work / 'simulation.log').open('w') as stream:
        p = subprocess.run(['ngspice', '-b', 'test.spice'], cwd=work, stdout=stream, stderr=subprocess.STDOUT)
    log = (work / 'simulation.log').read_text()
    assert not p.returncode and not re.search(r'(?im)^error|^warning', log), work
    rtl_reference(work, case)
    try:
        result = verify(work, case)
        result['passed'] = True
    except RuntimeError as error:
        result = dict(passed=False, error=str(error))
    result.update(name=name, deck_sha256=sha(work/'test.spice'),
                  reset_tests=len(case['reset_windows'])-1,
                  command_pairs=case.get('command_pairs', []))
    (work / 'result.json').write_text(json.dumps(result, indent=2)+'\n')
    print(name, 'PASS' if result['passed'] else 'FAIL', flush=True)
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--section', choices=('logic', 'analog'), required=True)
    parser.add_argument('--jobs', type=int, default=2)
    args = parser.parse_args(); WORK.mkdir(parents=True, exist_ok=True)
    netlist = (BASE / 'sram_tb_serial.spice').read_text()
    files = [BASE/'sram_tb_serial.spice', ROOT/'sram512/rtl/sram_serial_controller.v',
             ROOT/'learning/schematics/sram_serial_controller.sch', ROOT/'learning/schematics/sram_tb_serial.sch',
             ROOT/'scripts/verify_serial_spice.py', Path(__file__)]
    hashes = {str(p.relative_to(ROOT)): sha(p) for p in files}
    if args.section == 'logic': result = logic(netlist)
    else:
        with ThreadPoolExecutor(max_workers=args.jobs) as pool:
            cases = list(pool.map(lambda x: analog_case(netlist, *x), analog_cases()))
        result = dict(cases=cases, passed=all(c['passed'] for c in cases),
                      initial_memory_patterns=16,
                      command_pairs=len({tuple(p) for c in cases for p in c['command_pairs']}))
    assert hashes == {str(p.relative_to(ROOT)): sha(p) for p in files}, 'Sources changed during verification'
    result['files_sha256'] = hashes
    path = WORK / f'{args.section}_results.json'
    path.write_text(json.dumps(result, indent=2)+'\n'); print('Results:', path, flush=True)
    if not result.get('passed', True): sys.exit(1)


if __name__ == '__main__':
    main()
