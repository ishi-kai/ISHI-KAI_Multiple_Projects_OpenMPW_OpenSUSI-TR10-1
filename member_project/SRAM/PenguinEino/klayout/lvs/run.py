#!/usr/bin/env python3
"""Run strict cell/array LVS and an independent unmodified-PDK array check."""
import argparse
import os
from pathlib import Path
import subprocess
import sys

import klayout.db as db

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'scripts'))
from pdk_profiles import pdk_path
PDK_LVS = pdk_path()/'libs.tech/klayout/tech/lvs/run.lvs'


def run(layout, output):
    output.mkdir(parents=True, exist_ok=True)
    cases = [
        ('sram', ROOT / 'klayout/lvs/sram.lvs', 'sram', ROOT / 'learning/simulation/sram.spice'),
        ('sram_array', ROOT / 'klayout/lvs/sram.lvs', 'sram_array', ROOT / 'learning/simulation/sram_array.spice'),
        ('sram_array_official', PDK_LVS, 'sram_array', ROOT / 'learning/simulation/sram_array.spice'),
    ]
    passed = True
    for name, deck, top, schematic in cases:
        report = output / f'{name}.lvsdb'
        # Avoid accepting a stale report after a failed invocation.
        report.unlink(missing_ok=True)
        result = subprocess.run([
            'klayout', '-b', '-r', str(deck),
            '-rd', f'input={layout}', '-rd', f'top_cell={top}',
            '-rd', f'circuit={schematic}', '-rd', f'report={report}',
            '-rd', f'extracted={output / (name + ".extracted")}',
        ], env={**os.environ, 'QT_QPA_PLATFORM': 'offscreen'},
            stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
        (output / f'{name}.log').write_text(result.stdout)
        # The PDK prints failure but can still exit with status 0.
        ok = result.returncode == 0 and 'INFO : Congratulations! Netlists match.' in result.stdout
        if ok and report.exists():
            lvs = db.LayoutVsSchematic()
            lvs.read(str(report))
            errors = [e for e in lvs.each_error() if not (
                name == 'sram' and e.category_name == 'must-connect'
                and e.cell_name == 'sram' and e.severity == db.LogEntryData.Warning
                and e.message == 'Must-connect nets VSS and Vss must be connected further up in the hierarchy - this is an error at chip top level'
            )]
            ok = not errors and all(
                pair.status() == db.NetlistCrossReference.Match
                for pair in lvs.xref().each_circuit_pair())
        else:
            ok = False
        print(f'{name}: {"PASS" if ok else "FAIL"} ({report})', flush=True)
        if not ok:
            print(result.stdout, flush=True)
        passed &= ok
    return passed


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--layout', type=Path, default=ROOT / 'learning/layout/sram.gds')
    parser.add_argument('--output', type=Path, default=ROOT / 'build/lvs')
    args = parser.parse_args()
    raise SystemExit(0 if run(args.layout.resolve(), args.output.resolve()) else 1)
