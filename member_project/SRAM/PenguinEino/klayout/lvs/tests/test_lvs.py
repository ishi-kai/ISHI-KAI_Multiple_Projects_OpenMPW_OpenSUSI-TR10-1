"""Negative controls: connectivity faults must still fail the strict decks."""
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest

import klayout.db as db

ROOT = Path(__file__).resolve().parents[3]


class LVSRegression(unittest.TestCase):
    def check_fault(self, edit, expected_failures):
        with tempfile.TemporaryDirectory(prefix='sram-lvs-test-') as directory:
            tmp = Path(directory)
            layout = db.Layout()
            layout.read(str(ROOT / 'learning/layout/sram.gds'))
            edit(layout)
            layout.write(str(tmp / 'fault.gds'))
            result = subprocess.run([
                sys.executable, str(ROOT / 'klayout/lvs/run.py'),
                '--layout', str(tmp / 'fault.gds'), '--output', str(tmp / 'reports'),
            ], capture_output=True, text=True)
            self.assertEqual(result.returncode, 1, result.stdout + result.stderr)
            for name in expected_failures:
                self.assertIn(f'{name}: FAIL', result.stdout)

    def test_disconnected_substrate_tap(self):
        def edit(layout):
            for inst in layout.cell('sram_array').each_inst():
                if inst.cell.name == 'via_1' and inst.trans.disp == db.Vector(300, -2088):
                    inst.delete()
                    return
            self.fail('substrate via not found')
        self.check_fault(edit, ['sram_array', 'sram_array_official'])

    def test_broken_wordline(self):
        def edit(layout):
            for shape in layout.cell('sram').shapes(layout.layer(13, 0)).each():
                if shape.is_path() and list(shape.path.each_point()) == [db.Point(-211, -2472), db.Point(-211, -2481), db.Point(329, -2481)]:
                    shape.delete()
                    return
            self.fail('WL bridge not found')
        self.check_fault(edit, ['sram', 'sram_array', 'sram_array_official'])

    def test_missing_well_taps(self):
        def edit(layout):
            taps = [i for i in layout.cell('sram').each_inst() if i.cell.name.startswith('cont_n')]
            self.assertEqual(len(taps), 2)
            for inst in taps:
                inst.delete()
        self.check_fault(edit, ['sram', 'sram_array', 'sram_array_official'])


if __name__ == '__main__':
    unittest.main()
