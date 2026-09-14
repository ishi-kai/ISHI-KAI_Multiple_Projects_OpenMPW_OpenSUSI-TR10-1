"""Check the injected flattener's top-level boundary and legacy behavior."""
from pathlib import Path
import subprocess
import unittest

AWK = Path(__file__).resolve().parents[1] / 'flatten.awk'
STOCK = Path('/usr/local/share/xschem/flatten.awk')
CIRCUIT = '''.subckt top A B
+ VSS
X1 A B VSS child
.ends top
.subckt child A B VSS
M1 A B VSS VSS NMOS W=3.4u L=1u
.ends child
'''


def flatten(source, script=AWK):
    return subprocess.run(['awk', '-f', str(script)], input=source,
                          text=True, capture_output=True, check=True).stdout


class FlatTopTest(unittest.TestCase):
    def test_top_pins_and_continuation_preserved(self):
        output = flatten(CIRCUIT)
        self.assertEqual(output.splitlines()[1].split(), ['.SUBCKT', 'TOP', 'A', 'B', 'VSS'])
        self.assertIn('M1_X1 A B VSS VSS NMOS W=3.4U L=1U', output)
        self.assertTrue(output.endswith('.ENDS TOP\n'))
        self.assertEqual(output.count('.SUBCKT'), 1)

    def test_normal_flat_testbench_is_unchanged(self):
        source = CIRCUIT.replace('.subckt top', '**.subckt top').replace('.ends top', '**.ends top')
        self.assertEqual(flatten(source), flatten(source, STOCK))

    def test_device_body_is_unchanged(self):
        fixed = flatten(CIRCUIT).splitlines()
        stock = flatten(CIRCUIT, STOCK).splitlines()
        self.assertEqual(fixed[2:-1], stock[1:-1])


if __name__ == '__main__':
    unittest.main()
