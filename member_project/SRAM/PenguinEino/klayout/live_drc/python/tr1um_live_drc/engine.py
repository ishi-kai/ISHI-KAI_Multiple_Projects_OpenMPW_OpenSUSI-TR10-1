"""Viewport-local in-memory DRC used after an edit in KLayout.

This is intentionally not a replacement for the official TR-1um DRC deck.  It
implements unconditional geometric rules useful while editing every input
layer and gets their numerical values from the installed PDK when possible.
"""

from __future__ import annotations

import ast
import os
from dataclasses import dataclass
from pathlib import Path
from typing import Dict, Iterable, Optional, Tuple

try:
    import pya as _pya

    if not hasattr(_pya, "Region"):
        raise ImportError
    db = _pya
except ImportError:  # Standalone unit tests use the pip ``klayout`` module.
    import klayout.db as db


@dataclass(frozen=True)
class PdkRule:
    minimum: float
    maximum: float
    layer1: str
    layer2: str
    function: str


@dataclass
class Violation:
    rule_id: str
    message: str
    geometry: object

    @property
    def count(self) -> int:
        return int(self.geometry.size())


@dataclass
class DrcResult:
    violations: list[Violation]
    pdk_rule_source: Optional[Path]

    @property
    def marker_count(self) -> int:
        return sum(v.count for v in self.violations)

    @property
    def rule_count(self) -> int:
        return len(self.violations)


# Values are copied from TR-1um/libs.tech/klayout/tech/python/cells/rules_def.py.
# They are fallbacks only: load_pdk_rules reads that file at KLayout startup.
DEFAULT_PDK_RULES: Dict[str, PdkRule] = {
    "WN.W1": PdkRule(8.0, -1.0, "WN", "", "Wmin"),
    "WN.S1": PdkRule(12.0, -1.0, "WN", "WN", "Smin"),
    "WN.AP": PdkRule(5.0, -1.0, "WN", "AP", "Smin"),
    "WN.AN": PdkRule(10.0, -1.0, "WN", "AN", "Smin"),
    "AP.W1": PdkRule(1.4, -1.0, "AP", "", "Wmin"),
    "AP.S1": PdkRule(1.4, -1.0, "AP", "AP", "Smin"),
    "AP.AN": PdkRule(2.8, -1.0, "AP", "AN", "Smin"),
    "AP.WN": PdkRule(7.0, -1.0, "AP", "WN", "Emin"),
    "AN.W1": PdkRule(1.4, -1.0, "AN", "", "Wmin"),
    "AN.S1": PdkRule(1.4, -1.0, "AN", "AN", "Smin"),
    "AR.S1": PdkRule(4.0, -1.0, "AR", "AR", "Smin"),
    "AR.AN": PdkRule(4.0, -1.0, "AR", "AN", "Smin"),
    "AC.W1": PdkRule(28.5, 120.0, "AC", "", "Rect"),
    "AC.S1": PdkRule(6.4, -1.0, "AC", "AC", "Smin"),
    "GC.W1": PdkRule(1.0, -1.0, "GC", "", "Wmin"),
    "GC.S1": PdkRule(1.2, -1.0, "GC", "GC", "Smin"),
    "GC.AP": PdkRule(0.4, -1.0, "GC", "AP", "Smin"),
    "GC.AN": PdkRule(0.4, -1.0, "GC", "AN", "Smin"),
    "AR.GC": PdkRule(1.0, -1.0, "GC", "AR", "Smin"),
    "CO.W1": PdkRule(1.0, -1.0, "CO", "", "Rect"),
    "CO.S1": PdkRule(1.0, -1.0, "CO", "CO", "Smin"),
    "CO.AP": PdkRule(0.8, -1.0, "CO", "AP", "Emin"),
    "CO.AN": PdkRule(0.8, -1.0, "CO", "AN", "Emin"),
    "CO.GC": PdkRule(0.8, -1.0, "CO", "GC+GR", "Emin"),
    "CO.GR": PdkRule(0.8, -1.0, "CO", "GR", "Emin"),
    "CR.AR": PdkRule(0.8, -1.0, "CO(RR)", "AR", "Emin"),
    "M1.W1": PdkRule(1.8, -1.0, "M1", "", "Wmin"),
    "M1.S1": PdkRule(1.4, -1.0, "M1", "M1", "Smin"),
    "M1.CO": PdkRule(0.8, -1.0, "M1", "CO", "Fmin"),
    "V1.W1": PdkRule(1.4, 1.4, "V1", "", "Wfix"),
    "V1.S1": PdkRule(1.5, -1.0, "V1", "V1", "Smin"),
    "V1.M1": PdkRule(1.0, -1.0, "V1", "M1", "Emin"),
    "V1.GC": PdkRule(1.2, -1.0, "V1", "GC", "Smin"),
    "V1.CO": PdkRule(1.0, -1.0, "V1", "CO", "Smin"),
    "M2.W1": PdkRule(3.0, -1.0, "M2", "", "Wmin"),
    "M2.S1": PdkRule(2.0, -1.0, "M2", "M2", "Smin"),
    "M2.V1": PdkRule(1.0, -1.0, "M2", "V1", "Fmin"),
    "PO.W1": PdkRule(70.0, -1.0, "PO", "", "Wmin"),
    "PO.S1": PdkRule(64.0, -1.0, "PO", "PO", "Smin"),
    "M2.PO": PdkRule(5.0, -1.0, "M2", "PO", "Fmin"),
    "M1.PO": PdkRule(5.0, -1.0, "M1", "PO", "Fmin"),
    "PO.V1": PdkRule(10.0, -1.0, "PO", "V1(P)", "Emin"),
    "PO.AP": PdkRule(14.0, -1.0, "PO", "AP", "Smin"),
    "PO.AN": PdkRule(14.0, -1.0, "PO", "AN", "Smin"),
    "PO.GC": PdkRule(14.0, -1.0, "PO", "GC", "Smin"),
    "PO.M1": PdkRule(14.0, -1.0, "PO", "M1", "Smin"),
    "PO.M2": PdkRule(14.0, -1.0, "PO", "M2", "Smin"),
}


LAYER_INFO: Dict[str, Tuple[int, int]] = {
    "WN": (140, 0),
    "AP": (3, 1),
    "AN": (3, 2),
    "AR": (3, 3),
    "AC": (3, 4),
    "GC": (8, 1),
    "GR": (8, 2),
    "CO": (11, 0),
    "M1": (13, 0),
    "V1": (19, 0),
    "M2": (20, 0),
    "PO": (14, 0),
    "MASK": (63, 0),
}


# The official deck also derives device/electrical state from these recognition
# and label layers.  They are watched for edits but are not fed into the small
# immediate Region checker above.
WATCH_LAYER_INFO: Dict[str, Tuple[int, int]] = {
    **LAYER_INFO,
    "PTECT": (63, 1),
    "ESD": (63, 2),
    "TEMP": (80, 0),
    "M1_LBL": (48, 0),
    "M2_LBL": (49, 0),
}


WIDTH_SPACE_CHECKS = (
    ("WN", "WN.W1", "WN.S1"),
    ("AP", "AP.W1", "AP.S1"),
    ("AN", "AN.W1", "AN.S1"),
    ("GC", "GC.W1", "GC.S1"),
    ("CO", "CO.W1", "CO.S1"),
    ("M1", "M1.W1", "M1.S1"),
    ("M2", "M2.W1", "M2.S1"),
    ("PO", "PO.W1", "PO.S1"),
)


# Rules that can be evaluated directly from two input-layer regions.  The last
# flag mirrors the explicit overlap prohibition in the official deck.  A false
# value is important for valid structures such as gate crossing active.
CROSS_LAYER_SPACING_CHECKS = (
    ("WN.AP", "WN", "AP", False),
    ("WN.AN", "WN", "AN", False),
    ("AP.AN", "AP", "AN", True),
    ("AR.AN", "AR", "AN", True),
    ("GC.AP", "GC", "AP", False),
    ("GC.AN", "GC", "AN", False),
    ("AR.GC", "GC", "AR", True),
    ("PO.AP", "PO", "AP", True),
    ("PO.AN", "PO", "AN", True),
    ("PO.GC", "PO", "GC", True),
    ("PO.M1", "PO", "M1", False),
    ("PO.M2", "PO", "M2", False),
)


def _number(node: ast.AST) -> float:
    value = ast.literal_eval(node)
    if not isinstance(value, (int, float)):
        raise ValueError("not a number")
    return float(value)


def _parse_rules_def(path: Path) -> Dict[str, PdkRule]:
    tree = ast.parse(path.read_text(encoding="utf-8"), filename=str(path))
    rules: Dict[str, PdkRule] = {}
    for node in tree.body:
        if not isinstance(node, ast.Assign) or len(node.targets) != 1:
            continue
        target = node.targets[0]
        value = node.value
        if not (
            isinstance(target, ast.Subscript)
            and isinstance(target.value, ast.Name)
            and target.value.id == "DR"
            and isinstance(value, ast.Call)
            and isinstance(value.func, ast.Name)
            and value.func.id == "DRule"
            and len(value.args) >= 5
        ):
            continue
        try:
            key = ast.literal_eval(target.slice)
            if not isinstance(key, str):
                continue
            rules[key] = PdkRule(
                _number(value.args[0]),
                _number(value.args[1]),
                str(ast.literal_eval(value.args[2])).strip(),
                str(ast.literal_eval(value.args[3])).strip(),
                str(ast.literal_eval(value.args[4])).strip(),
            )
        except (ValueError, TypeError, SyntaxError):
            continue
    return rules


def _candidate_rule_files(pdk_root: Optional[Path] = None) -> Iterable[Path]:
    if pdk_root is not None:
        yield pdk_root / "libs.tech/klayout/tech/python/cells/rules_def.py"

    root = os.environ.get("PDK_ROOT")
    pdk = os.environ.get("PDK")
    if root and pdk:
        yield Path(root) / pdk / "libs.tech/klayout/tech/python/cells/rules_def.py"

    # Common installation layout when KLAYOUT_HOME points at a PDK tree.
    klayout_home = os.environ.get("KLAYOUT_HOME")
    if klayout_home:
        yield Path(klayout_home) / "tech/python/cells/rules_def.py"


def load_pdk_rules(
    pdk_root: Optional[Path] = None,
) -> tuple[Dict[str, PdkRule], Optional[Path]]:
    """Load numeric rules without importing or executing PDK Python code."""

    for path in _candidate_rule_files(pdk_root):
        if not path.is_file():
            continue
        try:
            parsed = _parse_rules_def(path)
        except (OSError, SyntaxError):
            continue
        if parsed:
            merged = dict(DEFAULT_PDK_RULES)
            merged.update(parsed)
            return merged, path.resolve()
    return dict(DEFAULT_PDK_RULES), None


def _to_dbu(value_um: float, dbu: float) -> int:
    return max(1, int(round(value_um / dbu)))


def inspection_halo_dbu(layout, rules: Dict[str, PdkRule]) -> int:
    """Return the input halo needed for every rule evaluated by this checker."""

    rule_ids = {
        width_key for _, width_key, _ in WIDTH_SPACE_CHECKS
    } | {
        space_key for _, _, space_key in WIDTH_SPACE_CHECKS
    } | {
        rule_id for rule_id, _, _, _ in CROSS_LAYER_SPACING_CHECKS
    } | {
        "AR.S1",
        "AC.W1",
        "AC.S1",
        "AP.WN",
        "M1.CO",
        "V1.W1",
        "V1.S1",
        "V1.M1",
        "V1.GC",
        "V1.CO",
        "M2.V1",
        "M1.PO",
        "M2.PO",
        "PO.V1",
    }
    maximum_um = max(
        (rules[key].minimum for key in rule_ids if key in rules), default=14.0
    )
    return _to_dbu(maximum_um, float(layout.dbu))


def _layer_region(layout, cell, name: str, search_box=None):
    layer, datatype = LAYER_INFO[name]
    layer_index = layout.find_layer(layer, datatype)
    if layer_index is None:
        return db.Region()
    if search_box is None:
        iterator = cell.begin_shapes_rec(layer_index)
    else:
        iterator = cell.begin_shapes_rec_touching(layer_index, search_box)
    return db.Region(iterator)


def _visible(region, output_box):
    if output_box is None or region.is_empty():
        return region
    return region & db.Region(output_box)


def _edge_pair_region(edge_pairs, output_box):
    if edge_pairs.is_empty():
        return db.Region()
    # One DBU enlargement keeps zero-area edge-pair markers visible.
    # Keep each edge pair separate so the marker count follows the official
    # DRC report instead of merging adjacent sides into one polygon.
    return _visible(edge_pairs.polygons(1), output_box)


def _add_region(
    violations: list[Violation],
    rule_id: str,
    message: str,
    region,
    output_box,
) -> None:
    region = _visible(region, output_box)
    if not region.is_empty():
        violations.append(Violation(rule_id, message, region.merged()))


def _add_edges(
    violations: list[Violation],
    rule_id: str,
    message: str,
    edge_pairs,
    output_box,
) -> None:
    region = _edge_pair_region(edge_pairs, output_box)
    if not region.is_empty():
        violations.append(Violation(rule_id, message, region))


def _bad_angles(region):
    bad = db.Region()
    for polygon in region.each_merged():
        for edge in polygon.each_edge():
            dx = edge.p2.x - edge.p1.x
            dy = edge.p2.y - edge.p1.y
            if dx != 0 and dy != 0 and abs(dx) != abs(dy):
                bad.insert(edge.bbox().enlarged(1))
    return bad


def _not_exact_squares(region, side: int):
    bad = db.Region()
    for polygon in region.each_merged():
        box = polygon.bbox()
        if not polygon.is_box() or box.width() != side or box.height() != side:
            bad.insert(polygon)
    return bad


def _non_rectangles(region):
    bad = db.Region()
    for polygon in region.each_merged():
        if not polygon.is_box():
            bad.insert(polygon)
    return bad


def _too_large_boxes(region, maximum: int):
    bad = db.Region()
    for polygon in region.each_merged():
        box = polygon.bbox()
        if box.width() > maximum or box.height() > maximum:
            bad.insert(polygon)
    return bad


def _add_separation_check(
    violations,
    rules,
    regions,
    rule_id,
    first_name,
    second_name,
    forbid_overlap,
    dbu,
    output_box,
):
    first = regions[first_name]
    second = regions[second_name]
    if first.is_empty() or second.is_empty():
        return
    distance_um = rules[rule_id].minimum
    _add_edges(
        violations,
        rule_id,
        f"{first_name} to {second_name} spacing < {distance_um:g} um",
        first.separation_check(second, _to_dbu(distance_um, dbu)),
        output_box,
    )
    if forbid_overlap:
        _add_region(
            violations,
            rule_id + ".OVERLAP",
            f"{first_name} overlaps {second_name}",
            first & second,
            output_box,
        )


def run_fast_drc(
    layout,
    cell,
    *,
    clip_box=None,
    rules: Optional[Dict[str, PdkRule]] = None,
    pdk_rule_source: Optional[Path] = None,
) -> DrcResult:
    """Run fast geometric checks in ``cell`` and return marker geometry.

    ``clip_box`` is in integer database units.  A halo is automatically added
    while reading input geometry so checks at the viewport edge remain valid.
    Output is restricted back to ``clip_box``.
    """

    if rules is None:
        rules, detected_source = load_pdk_rules()
        if pdk_rule_source is None:
            pdk_rule_source = detected_source

    dbu = float(layout.dbu)
    search_box = None
    if clip_box is not None:
        search_box = clip_box.enlarged(inspection_halo_dbu(layout, rules))

    names = set(LAYER_INFO) - {"MASK"}
    regions = {
        name: _layer_region(layout, cell, name, search_box) for name in names
    }
    mask = _layer_region(layout, cell, "MASK", search_box)
    if not mask.is_empty():
        for name in regions:
            regions[name] -= mask

    violations: list[Violation] = []

    for layer_name, width_key, space_key in WIDTH_SPACE_CHECKS:
        region = regions[layer_name]
        if region.is_empty():
            continue
        width_um = rules[width_key].minimum
        space_um = rules[space_key].minimum
        width = _to_dbu(width_um, dbu)
        space = _to_dbu(space_um, dbu)
        _add_edges(
            violations,
            width_key,
            f"{layer_name} minimum width < {width_um:g} um",
            region.width_check(width),
            clip_box,
        )
        _add_edges(
            violations,
            space_key,
            f"{layer_name} minimum spacing < {space_um:g} um",
            region.space_check(space),
            clip_box,
        )
        _add_edges(
            violations,
            space_key + ".NOTCH",
            f"{layer_name} notch < {space_um:g} um",
            region.notch_check(space),
            clip_box,
        )
    for layer_name, region in regions.items():
        if not region.is_empty():
            _add_region(
                violations,
                "GRID.ANGLE",
                f"{layer_name} edge is neither Manhattan nor 45 degree",
                _bad_angles(region),
                clip_box,
            )

    # AR has a context-dependent resistor width rule, but its same-layer
    # spacing is unconditional.  AC has unconditional rectangular size and
    # spacing rules.
    ar = regions["AR"]
    if not ar.is_empty():
        spacing_um = rules["AR.S1"].minimum
        _add_edges(
            violations,
            "AR.S1",
            f"AR minimum spacing < {spacing_um:g} um",
            ar.space_check(_to_dbu(spacing_um, dbu)),
            clip_box,
        )

    ac = regions["AC"]
    if not ac.is_empty():
        minimum_um = rules["AC.W1"].minimum
        maximum_um = rules["AC.W1"].maximum
        spacing_um = rules["AC.S1"].minimum
        _add_edges(
            violations,
            "AC.W1",
            f"AC minimum width < {minimum_um:g} um",
            ac.width_check(_to_dbu(minimum_um, dbu)),
            clip_box,
        )
        _add_region(
            violations,
            "AC.W1.MAX",
            f"AC size > {maximum_um:g} um",
            _too_large_boxes(ac, _to_dbu(maximum_um, dbu)),
            clip_box,
        )
        _add_region(
            violations,
            "AC.W1.RECT",
            "AC must be a rectangle",
            _non_rectangles(ac),
            clip_box,
        )
        _add_edges(
            violations,
            "AC.S1",
            f"AC minimum spacing < {spacing_um:g} um",
            ac.space_check(_to_dbu(spacing_um, dbu)),
            clip_box,
        )

    co_shape = regions["CO"]
    if not co_shape.is_empty():
        _add_region(
            violations,
            "CO.W1.RECT",
            "CO must be a rectangle",
            _non_rectangles(co_shape),
            clip_box,
        )

    for rule_id, first, second, forbid_overlap in CROSS_LAYER_SPACING_CHECKS:
        _add_separation_check(
            violations,
            rules,
            regions,
            rule_id,
            first,
            second,
            forbid_overlap,
            dbu,
            clip_box,
        )

    # AP inside an N-well requires an unconditional 7 um well enclosure.  AP
    # outside WN is not an error here: it is used for substrate/body contacts.
    ap = regions["AP"]
    wn = regions["WN"]
    if not ap.is_empty() and not wn.is_empty():
        enclosure_um = rules["AP.WN"].minimum
        _add_edges(
            violations,
            "AP.WN",
            f"WN enclosure of AP < {enclosure_um:g} um",
            ap.enclosed_check(wn, _to_dbu(enclosure_um, dbu)),
            clip_box,
        )

    # Contact must land on conductor/device material and be covered by M1.
    co = regions["CO"]
    if not co.is_empty():
        lower_conductor = (
            regions["AP"]
            + regions["AN"]
            + regions["AR"]
            + regions["AC"]
            + regions["GC"]
            + regions["GR"]
        )
        _add_region(
            violations,
            "CO.Z1",
            "CO outside AP/AN/AR/AC/GC/GR",
            co - lower_conductor,
            clip_box,
        )
        _add_region(
            violations,
            "CO.Z3",
            "CO outside M1",
            co - regions["M1"],
            clip_box,
        )
        enclosure_um = rules["M1.CO"].minimum
        _add_edges(
            violations,
            "M1.CO",
            f"M1 enclosure of CO < {enclosure_um:g} um",
            co.enclosed_check(regions["M1"], _to_dbu(enclosure_um, dbu)),
            clip_box,
        )

        # Check the enclosure of a contact only against the lower material it
        # actually touches.  CO.Z1 above handles contacts on no valid material.
        for lower_names, display_name, rule_id in (
            (("AP",), "AP", "CO.AP"),
            (("AN",), "AN", "CO.AN"),
            (("AR",), "AR", "CR.AR"),
            (("GC", "GR"), "GC/GR", "CO.GC"),
            (("GR",), "GR", "CO.GR"),
        ):
            if rule_id not in rules:
                continue
            lower = db.Region()
            for lower_name in lower_names:
                lower += regions[lower_name]
            relevant_contacts = co.interacting(lower)
            if relevant_contacts.is_empty():
                continue
            lower_enclosure_um = rules[rule_id].minimum
            _add_edges(
                violations,
                rule_id,
                f"{display_name} enclosure of CO < {lower_enclosure_um:g} um",
                relevant_contacts.enclosed_check(
                    lower, _to_dbu(lower_enclosure_um, dbu)
                ),
                clip_box,
            )

    # Via checks exclude pad vias, matching V1 - V1P in the official deck.
    via1 = regions["V1"]
    if not via1.is_empty():
        pad_via = via1.interacting(regions["PO"])
        regular_via = via1 - pad_via
        side_um = rules["V1.W1"].minimum
        side = _to_dbu(side_um, dbu)
        _add_region(
            violations,
            "V1.W1",
            f"V1 must be a {side_um:g} x {side_um:g} um square",
            _not_exact_squares(regular_via, side),
            clip_box,
        )
        spacing_um = rules["V1.S1"].minimum
        _add_edges(
            violations,
            "V1.S1",
            f"V1 minimum spacing < {spacing_um:g} um",
            regular_via.space_check(_to_dbu(spacing_um, dbu)),
            clip_box,
        )
        for metal_name, rule_id in (("M1", "V1.M1"), ("M2", "M2.V1")):
            enclosure_um = rules[rule_id].minimum
            _add_region(
                violations,
                "V1.Z1" if metal_name == "M1" else "V1.Z2",
                f"V1 outside {metal_name}",
                regular_via - regions[metal_name],
                clip_box,
            )
            _add_edges(
                violations,
                rule_id,
                f"{metal_name} enclosure of V1 < {enclosure_um:g} um",
                regular_via.enclosed_check(
                    regions[metal_name], _to_dbu(enclosure_um, dbu)
                ),
                clip_box,
            )

        for other_name, rule_id in (("GC", "V1.GC"), ("CO", "V1.CO")):
            separation_um = rules[rule_id].minimum
            other = regions[other_name]
            _add_edges(
                violations,
                rule_id,
                f"V1 to {other_name} spacing < {separation_um:g} um",
                regular_via.separation_check(
                    other, _to_dbu(separation_um, dbu)
                ),
                clip_box,
            )
            _add_region(
                violations,
                rule_id + ".OVERLAP",
                f"V1 overlaps {other_name}",
                regular_via & other,
                clip_box,
            )

    # Pad checks are geometric too.  V1 interacting PO is intentionally not
    # treated as a regular via above, matching V1P in the official deck.
    po = regions["PO"]
    if not po.is_empty():
        pad_via = regions["V1"].interacting(po)
        _add_region(
            violations,
            "PO.Z3",
            "PO without pad V1",
            po.not_covering(pad_via),
            clip_box,
        )
        pad_via_enclosure_um = rules["PO.V1"].minimum
        _add_edges(
            violations,
            "PO.V1",
            f"PO enclosure of pad V1 < {pad_via_enclosure_um:g} um",
            pad_via.enclosed_check(
                po, _to_dbu(pad_via_enclosure_um, dbu)
            ),
            clip_box,
        )
        for metal_name, outside_rule, enclosure_rule in (
            ("M1", "PO.Z1", "M1.PO"),
            ("M2", "PO.Z2", "M2.PO"),
        ):
            metal = regions[metal_name]
            _add_region(
                violations,
                outside_rule,
                f"PO outside {metal_name}",
                po - metal,
                clip_box,
            )
            enclosure_um = rules[enclosure_rule].minimum
            _add_edges(
                violations,
                enclosure_rule,
                f"{metal_name} enclosure of PO < {enclosure_um:g} um",
                po.enclosed_check(metal, _to_dbu(enclosure_um, dbu)),
                clip_box,
            )

    return DrcResult(violations, pdk_rule_source)
