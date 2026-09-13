#!/usr/bin/env python3
"""Compile/run the serial controller's digital tests using Icarus Verilog.

    python3 scripts/verify_rtl.py              # all five array shapes
    python3 scripts/verify_rtl.py --waves      # also save the 2x2 VCD
    python3 scripts/verify_rtl.py --row-bits 1 --col-bits 1 --waves

No synthesis, transistor simulation, or schematic generation is performed.
Generated executables, logs and optional VCDs go to build/rtl/ (Git ignored).
"""
from pathlib import Path
import argparse
import os
import shutil
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]
LOCAL_ICARUS = Path.home() / '.local/share/sram-tools/iverilog/usr'


def tool(name):
    supplied = os.environ.get(name.upper())
    found = shutil.which(supplied or name)
    if found:
        return Path(found)
    fallback = LOCAL_ICARUS / 'bin' / name
    if not supplied and fallback.is_file():
        return fallback
    raise RuntimeError(f'{name} not found. Install Icarus Verilog or set {name.upper()} to its executable.')


def run(command, work, log_name):
    result = subprocess.run([str(x) for x in command], cwd=work,
                            stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
    (work / log_name).write_text(result.stdout)
    if result.returncode:
        raise RuntimeError(f'{log_name} failed:\n{result.stdout}\nLog: {work / log_name}')
    return result.stdout


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument('--row-bits', type=int)
    parser.add_argument('--col-bits', type=int)
    parser.add_argument('--waves', action='store_true')
    parser.add_argument('--exhaustive', action='store_true', help='also exhaust all legal 2x2 command pairs and memory backgrounds')
    args = parser.parse_args()
    if (args.row_bits is None) != (args.col_bits is None):
        parser.error('specify both --row-bits and --col-bits')
    if args.row_bits is not None and (args.row_bits < 1 or args.col_bits < 1):
        parser.error('address widths must be >= 1')
    shapes = [(args.row_bits, args.col_bits)] if args.row_bits is not None else [
        (1, 1), (4, 4), (5, 5), (2, 3), (3, 4)]

    compiler, simulator = tool('iverilog'), tool('vvp')
    compile_prefix, sim_prefix = [compiler], [simulator]
    # Support an unpacked Ubuntu package in the user's directory, without sudo.
    if compiler == LOCAL_ICARUS / 'bin/iverilog':
        ivl_dirs = list((LOCAL_ICARUS / 'lib').glob('*/ivl'))
        if len(ivl_dirs) != 1:
            raise RuntimeError('Cannot locate the local Icarus ivl support directory')
        compile_prefix += ['-B', ivl_dirs[0]]
        sim_prefix += ['-M', ivl_dirs[0]]

    sources = [ROOT / 'sram512/rtl/sram_serial_controller.v',
               ROOT / 'learning/tb/sram_functional_model.v',
               ROOT / 'learning/tb/tb_sram_serial_controller.sv']
    for row_bits, col_bits in shapes:
        name = f'{1 << row_bits}x{1 << col_bits}'
        work = ROOT / 'build/rtl' / name
        work.mkdir(parents=True, exist_ok=True)
        executable = work / 'controller.vvp'
        output = run(compile_prefix + ['-g2012', '-Wall', '-s', 'tb_sram_serial_controller',
                     f'-Ptb_sram_serial_controller.ROW_BITS={row_bits}',
                     f'-Ptb_sram_serial_controller.COL_BITS={col_bits}',
                     '-o', executable] + sources, work, 'compile.log')
        if output.strip():
            print(output, end='')
        waves = args.waves and (len(shapes) == 1 or (row_bits, col_bits) == (1, 1))
        extra = ['+exhaustive'] if args.exhaustive and (row_bits, col_bits) == (1, 1) else []
        output = run(sim_prefix + [executable] + (['+waves'] if waves else []) + extra, work, 'simulation.log')
        passes = [line for line in output.splitlines() if line.startswith('PASS ')]
        if len(passes) != 1:
            raise RuntimeError(f'Missing PASS result: {work / "simulation.log"}\n{output}')
        print(passes[0], flush=True)
        for line in output.splitlines():
            if line.startswith('COVERAGE:'):print(line, flush=True)
        if waves:
            print(f'Waveform: {work / "serial_controller.vcd"}', flush=True)
    print('Digital RTL verification complete. Logs: build/rtl/')


if __name__ == '__main__':
    try:
        main()
    except (RuntimeError, OSError) as error:
        print(f'ERROR: {error}', file=sys.stderr)
        sys.exit(1)
