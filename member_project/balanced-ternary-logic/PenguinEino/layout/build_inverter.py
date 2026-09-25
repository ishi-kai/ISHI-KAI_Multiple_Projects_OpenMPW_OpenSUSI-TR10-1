#!/usr/bin/env python3
"""Build the reusable balanced ternary INV from unmodified TR-1um PCells.

By default the GDS is written to the project root for the standard GUI DRC/LVS
workflow; metadata stays in layout/. --out selects an alternative output dir.
All distances and parameters below are micrometres.
"""
from __future__ import annotations

import argparse
import hashlib
import json
import os
from pathlib import Path
import sys

import klayout.db as db
from gds_units import GDS_DBU, write_gds

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent
PDK = Path(os.environ.get("TR1UM_PDK", "/home/ishi-kai/pdk/TR-1um")).resolve()
sys.path.insert(0, str(PDK / "libs.tech/klayout/tech/python"))
from cells import tr_1um  # noqa: E402

LIBRARY = tr_1um("TR-1um")
LAYERS = {"WN": (140, 0), "AP": (3, 1), "AN": (3, 2), "AR": (3, 3),
          "GC": (8, 1), "CO": (11, 0), "M1": (13, 0), "V1": (19, 0),
          "M2": (20, 0), "M1_LBL": (48, 0), "M2_LBL": (49, 0)}


class Drawing:
    def __init__(self, layout, cell):
        self.layout, self.cell = layout, cell
        self.instances = []

    def coord(self, value):
        integer = round(value / self.layout.dbu)
        assert abs(integer * self.layout.dbu - value) < 1e-8, value
        return integer

    def box(self, layer, x0, y0, x1, y1):
        self.cell.shapes(self.layout.layer(*LAYERS[layer])).insert(
            db.Box(*(self.coord(v) for v in (x0, y0, x1, y1))))

    def wire(self, layer, points, width):
        # Square-ended orthogonal segments, so junction dimensions are explicit.
        half = width / 2
        for (x0, y0), (x1, y1) in zip(points, points[1:]):
            assert x0 == x1 or y0 == y1
            self.box(layer, min(x0, x1)-half, min(y0, y1)-half,
                     max(x0, x1)+half, max(y0, y1)+half)

    def pcell(self, role, name, x, y, parameters=None):
        cell = self.layout.create_cell(name, "TR-1um", parameters or {})
        assert cell is not None and cell.is_pcell_variant(), name
        inst = self.cell.insert(db.CellInstArray(
            cell.cell_index(), db.Trans(self.coord(x), self.coord(y))))
        inst.set_property("role", role)
        self.instances.append({"role": role, "cell": cell.name,
                               "pcell": name, "origin_um": [x, y],
                               "rotation_deg": 0,
                               "parameters": cell.pcell_parameters_by_name()})
        return cell

    def label(self, layer, name, x, y):
        label = db.Text(name, db.Trans(self.coord(x), self.coord(y)))
        self.cell.shapes(self.layout.layer(*LAYERS[layer + "_LBL"])).insert(label)


def build(out: Path):
    out.mkdir(parents=True, exist_ok=True)
    layout = db.Layout()
    layout.dbu = GDS_DBU
    layout.technology_name = "TR-1um"
    top = layout.create_cell("inverter")
    d = Drawing(layout, top)

    # Fixed schematic devices, without modifying the PCell implementations.
    d.pcell("XM1", "fet_p", 13.2, 44, {"w": 13.5, "l": 1., "n": 1,
                                       "cont_between_gates": True, "y0": "c"})
    d.pcell("XM2", "fet_n", 13.2, 14, {"w": 5., "l": 1., "n": 1,
                                       "cont_between_gates": True, "y0": "c"})
    d.pcell("R1", "res_diff", 64, 45, {"w": 2.8, "l": 30.})
    d.pcell("R2", "res_diff", 64, 32, {"w": 2.8, "l": 30.})

    # Distinct PMOS and RR wells: the PDK prohibits PMOS active in an RR well.
    d.box("WN", 2.9, 30.25, 23.5, 61.3)
    # The mask deck requires 10 um around an RR-well tap, while the drawing
    # deck's generic N+ tap rule is only 5 um. Honor the stronger mask rule.
    d.box("WN", 36.5, 20.6, 91.5, 65.3)
    d.pcell("PMOS well tap", "cont_n", 13.2, 55)
    d.pcell("RR well tap", "cont_n", 64, 54)
    d.pcell("NMOS bulk tap", "cont_p", 5.8, 14)

    # Parent-accessible power rails and their physically connected taps.
    d.box("M1", 0, 62.6, 96, 66)
    d.box("M1", 0, 0, 96, 3.4)
    d.wire("M1", [(11.2, 44), (11.2, 64.3)], 2.6)
    d.wire("M1", [(11.2, 55), (13.2, 55)], 2.6)
    d.wire("M1", [(11.2, 14), (11.2, 1.7)], 2.6)
    d.wire("M1", [(5.8, 14), (5.8, 1.7)], 2.6)
    d.wire("M1", [(64, 54), (64, 64.3)], 2.6)

    # Both resistor GC guard rings are tied to their common VDD well.
    for y in (32, 45):
        # dev GC.R3 forbids contacts in the RR recognition region.
        d.wire("GC", [(84.5, y), (86.5, y)], 2.6)
        d.pcell(f"RR GC tie at y={y}", "cont_g", 86.5, y)
    d.wire("M1", [(86.5, 32), (86.5, 54), (64, 54)], 2.6)

    # Shared gate input. Only the two intended active crossings form MOS gates.
    d.wire("GC", [(13.2, 14), (13.2, 44)], 1.)
    d.pcell("vin gate contact", "cont_g", 13.2, 25)
    d.box("M1", 0, 23.7, 13.2, 26.3)

    # XM1.D -> R1.A and XM2.D -> R2.A; right RR terminals form vout.
    d.wire("M1", [(15.2, 44), (30, 44), (30, 45), (48.5, 45)], 2.6)
    d.wire("M1", [(15.2, 14), (30, 14), (30, 32), (48.5, 32)], 2.6)
    d.wire("M1", [(79.5, 32), (79.5, 45)], 2.6)
    # M2 crosses the RR guard supply without a short. Via is between GC rings.
    d.pcell("vout M1-M2 access", "via_1", 79.5, 38.5)
    d.box("M2", 79.5, 36.8, 96, 40.2)

    ports = {
        "vin": {"layer": [13, 0], "label_layer": [48, 0],
                "position_um": [2, 25], "access_box_um": [0, 23.7, 4, 26.3],
                "edge": "left", "direction": "input"},
        "vout": {"layer": [20, 0], "label_layer": [49, 0],
                 "position_um": [94, 38.5], "access_box_um": [92, 36.8, 96, 40.2],
                 "edge": "right", "direction": "output"},
        "VDD": {"layer": [13, 0], "label_layer": [48, 0],
                "position_um": [48, 64.3], "access_box_um": [0, 62.6, 96, 66],
                "edge": "top", "direction": "power", "voltage_V": 5},
        "VSS": {"layer": [13, 0], "label_layer": [48, 0],
                "position_um": [48, 1.7], "access_box_um": [0, 0, 96, 3.4],
                "edge": "bottom", "direction": "power", "voltage_V": -5},
    }
    for name, port in ports.items():
        layer = "M1" if port["layer"] == [13, 0] else "M2"
        d.label(layer, name, *port["position_um"])

    assert top.dbbox() == db.DBox(0, 0, 96, 66), top.dbbox()
    target = (ROOT if out == HERE else out) / "inverter.gds"
    # Use a single canonical top-level macro; child PCells retain their names.
    write_gds(layout, target)
    metadata = {
        "top_cell": "inverter", "gds": os.path.relpath(target, out),
        "gds_sha256": hashlib.sha256(target.read_bytes()).hexdigest(),
        "generator": "build_inverter.py", "pdk": str(PDK),
        "database_unit_um": GDS_DBU, "placement_grid_um": 0.05,
        "static_pcell_variants": [],
        "bbox_um": [0, 0, 96, 66], "width_um": 96, "height_um": 66,
        "area_um2": 6336, "ports": ports,
        "source_schematic": "../inverter.sch",
        "supply_contract": {"VDD": "former V+; +5 V; PMOS body and RR SUB",
                            "VSS": "former V-; -5 V; NMOS body and global bulk",
                            "VMID": "not used by INV"},
        "instances": d.instances,
        "device_counts": {"PMOS": 1, "NMOS": 1, "F_RR": 2},
        "reuse": {"minimum_gap_um": 12,
                  "gap_status": "12 um R0/MX/MY/R180 geometry checked; see qualification reports",
                  "zero_gap_abutment": False, "share_wells": False,
                  "common_bulk_net": "VSS", "orientations": ["R0", "MX", "MY", "R180"],
                  "orientation_note": "Transform all port coordinates with the instance; MX/R180 exchange top and bottom supply positions."},
        "qualification_reports": ["../reports/inverter_layout.json",
                                  "../reports/inverter_placement.json",
                                  "../reports/inverter_driver.json"],
        "standalone_mask_warning": {
            "category": "WAR06: Floating SG Detected", "net": "vin",
            "explanation": "An unconnected external MOS-gate input has no active discharge path. The official warning is retained, without waiver or extra devices.",
            "integration_evidence": "The unchanged 2-INV driven fixture has zero drawing/mask markers and strict LVS match."},
    }
    (out / "inverter.ports.json").write_text(json.dumps(metadata, indent=2) + "\n")
    print(json.dumps({"gds": str(target), "top": top.name, "bbox_um": metadata["bbox_um"],
                      "device_counts": metadata["device_counts"]}, indent=2))


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--out", type=Path, default=HERE)
    build(parser.parse_args().out.resolve())
