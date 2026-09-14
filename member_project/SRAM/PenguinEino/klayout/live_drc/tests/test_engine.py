import sys
import unittest
import re
from pathlib import Path

import klayout.db as db

PACKAGE_ROOT = Path(__file__).resolve().parents[1] / "python"
sys.path.insert(0, str(PACKAGE_ROOT))

from tr1um_live_drc.engine import load_pdk_rules, run_fast_drc


DBU = 0.001


def um(value):
    return int(round(value / DBU))


def box(x1, y1, x2, y2):
    return db.Box(um(x1), um(y1), um(x2), um(y2))


class FastDrcTest(unittest.TestCase):
    def setUp(self):
        self.layout = db.Layout()
        self.layout.dbu = DBU
        self.cell = self.layout.create_cell("TOP")

    def insert(self, layer, datatype, shape):
        self.cell.shapes(self.layout.layer(layer, datatype)).insert(shape)

    def rules(self):
        return {v.rule_id for v in run_fast_drc(self.layout, self.cell).violations}

    def test_reads_the_installed_pdk_rule_table(self):
        pdk = Path("/home/ishi-kai/pdk/TR-1um")
        rules, source = load_pdk_rules(pdk)
        self.assertIsNotNone(source)
        self.assertEqual(rules["M1.W1"].minimum, 1.8)
        self.assertEqual(rules["M2.S1"].minimum, 2.0)
        self.assertEqual(rules["V1.W1"].maximum, 1.4)

    def test_official_runset_category_inventory(self):
        runset = Path(
            "/home/ishi-kai/pdk/TR-1um/libs.tech/klayout/tech/drc/run.drc"
        )
        text = runset.read_text(encoding="utf-8")
        categories = set(re.findall(r"\.output\(['\"]([^:]+):", text))
        self.assertEqual(len(categories), 139)
        self.assertIn("AP.WN", categories)
        self.assertIn("GC.ANT", categories)

    def test_m1_minimum_width(self):
        self.insert(13, 0, box(0, 0, 1.0, 10.0))
        self.assertIn("M1.W1", self.rules())

    def test_m1_spacing(self):
        self.insert(13, 0, box(0, 0, 1.8, 10.0))
        self.insert(13, 0, box(2.8, 0, 4.6, 10.0))
        rules = self.rules()
        self.assertNotIn("M1.W1", rules)
        self.assertIn("M1.S1", rules)

    def test_valid_m1_spacing_at_the_limit(self):
        self.insert(13, 0, box(0, 0, 1.8, 10.0))
        self.insert(13, 0, box(3.2, 0, 5.0, 10.0))
        rules = self.rules()
        self.assertNotIn("M1.W1", rules)
        self.assertNotIn("M1.S1", rules)

    def test_polygon_regions_are_checked_not_only_paths(self):
        first = db.Polygon(
            [db.Point(0, 0), db.Point(um(4), 0), db.Point(um(4), um(4)), db.Point(0, um(4))]
        )
        second = db.Polygon(
            [
                db.Point(um(5), 0),
                db.Point(um(9), 0),
                db.Point(um(9), um(4)),
                db.Point(um(5), um(4)),
            ]
        )
        self.insert(13, 0, first)
        self.insert(13, 0, second)
        self.assertIn("M1.S1", self.rules())

    def test_cross_layer_spacing(self):
        self.insert(3, 1, box(0, 0, 4, 4))
        self.insert(3, 2, box(6, 0, 10, 4))
        self.assertIn("AP.AN", self.rules())

    def test_forbidden_cross_layer_overlap(self):
        self.insert(3, 1, box(0, 0, 4, 4))
        self.insert(3, 2, box(2, 0, 6, 4))
        self.assertIn("AP.AN.OVERLAP", self.rules())

    def test_gate_may_overlap_active(self):
        self.insert(3, 1, box(0, 0, 6, 6))
        self.insert(8, 1, box(2, -2, 4, 8))
        rules = self.rules()
        self.assertNotIn("GC.AP", rules)
        self.assertNotIn("GC.AP.OVERLAP", rules)

    def test_ap_wn_enclosure(self):
        self.insert(3, 1, box(0, 0, 10, 10))
        self.insert(140, 0, box(-6, -6, 16, 16))
        result = run_fast_drc(self.layout, self.cell)
        violations = {v.rule_id: v for v in result.violations}
        self.assertIn("AP.WN", violations)
        self.assertEqual(violations["AP.WN"].count, 4)

    def test_valid_ap_wn_enclosure_at_limit(self):
        self.insert(3, 1, box(0, 0, 10, 10))
        self.insert(140, 0, box(-7, -7, 17, 17))
        self.assertNotIn("AP.WN", self.rules())

    def test_hierarchical_box_is_checked(self):
        child = self.layout.create_cell("CHILD")
        child.shapes(self.layout.layer(13, 0)).insert(box(0, 0, 1, 10))
        self.cell.insert(db.CellInstArray(child.cell_index(), db.Trans()))
        self.assertIn("M1.W1", self.rules())

    def test_via_size_and_required_metals(self):
        self.insert(19, 0, box(0, 0, 1.0, 1.0))
        rules = self.rules()
        self.assertIn("V1.W1", rules)
        self.assertIn("V1.Z1", rules)
        self.assertIn("V1.Z2", rules)

    def test_valid_via_stack(self):
        self.insert(19, 0, box(1.0, 1.0, 2.4, 2.4))
        self.insert(13, 0, box(0.0, 0.0, 3.4, 3.4))
        self.insert(20, 0, box(0.0, 0.0, 3.4, 3.4))
        rules = self.rules()
        for rule_id in ("V1.W1", "V1.Z1", "V1.Z2", "V1.M1", "M2.V1"):
            self.assertNotIn(rule_id, rules)

    def test_contact_requires_lower_conductor_and_m1(self):
        self.insert(11, 0, box(0, 0, 1.0, 1.0))
        rules = self.rules()
        self.assertIn("CO.Z1", rules)
        self.assertIn("CO.Z3", rules)

    def test_valid_contact_stack(self):
        self.insert(11, 0, box(0, 0, 1.0, 1.0))
        self.insert(8, 1, box(-0.8, -0.8, 1.8, 1.8))
        self.insert(13, 0, box(-0.8, -0.8, 1.8, 1.8))
        rules = self.rules()
        for rule_id in ("CO.Z1", "CO.Z3", "M1.CO"):
            self.assertNotIn(rule_id, rules)

    def test_lower_layer_contact_enclosure(self):
        self.insert(11, 0, box(0, 0, 1, 1))
        self.insert(3, 1, box(-0.2, -0.2, 1.2, 1.2))
        self.insert(13, 0, box(-0.8, -0.8, 1.8, 1.8))
        self.assertIn("CO.AP", self.rules())

    def test_ac_rectangle_and_spacing(self):
        polygon = db.Polygon(
            [
                db.Point(0, 0),
                db.Point(um(40), 0),
                db.Point(um(40), um(40)),
                db.Point(um(20), um(30)),
                db.Point(0, um(40)),
            ]
        )
        self.insert(3, 4, polygon)
        self.assertIn("AC.W1.RECT", self.rules())

    def test_pad_same_layer_spacing(self):
        self.insert(14, 0, box(0, 0, 70, 70))
        self.insert(14, 0, box(120, 0, 190, 70))
        self.assertIn("PO.S1", self.rules())

    def test_valid_pad_stack(self):
        self.insert(14, 0, box(0, 0, 70, 70))
        self.insert(19, 0, box(20, 20, 21.4, 21.4))
        self.insert(13, 0, box(-5, -5, 75, 75))
        self.insert(20, 0, box(-5, -5, 75, 75))
        rules = self.rules()
        for rule_id in (
            "PO.Z1",
            "PO.Z2",
            "PO.Z3",
            "PO.V1",
            "M1.PO",
            "M2.PO",
        ):
            self.assertNotIn(rule_id, rules)

    def test_non_45_degree_edge(self):
        polygon = db.Polygon(
            [db.Point(0, 0), db.Point(um(10), 0), db.Point(0, um(4))]
        )
        self.insert(13, 0, polygon)
        self.assertIn("GRID.ANGLE", self.rules())

    def test_drc_waiver_layer_is_excluded(self):
        self.insert(13, 0, box(0, 0, 1.0, 10.0))
        self.insert(63, 0, box(-1, -1, 2, 11))
        self.assertNotIn("M1.W1", self.rules())

    def test_clip_hides_remote_violations(self):
        self.insert(13, 0, box(100, 100, 101, 110))
        clip = box(0, 0, 20, 20)
        result = run_fast_drc(self.layout, self.cell, clip_box=clip)
        self.assertEqual(result.marker_count, 0)


if __name__ == "__main__":
    unittest.main()
