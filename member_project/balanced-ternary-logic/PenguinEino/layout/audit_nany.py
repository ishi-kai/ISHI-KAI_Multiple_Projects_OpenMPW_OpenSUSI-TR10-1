#!/usr/bin/env python3
"""Audit saved PCell geometry before loading the library, then restore PCells."""
from collections import Counter
import hashlib
import json
from pathlib import Path
import klayout.db as db

HERE = Path(__file__).resolve().parent


def regions(layout, cell):
    return {(layout.get_info(li).layer, layout.get_info(li).datatype):
            db.Region(cell.begin_shapes_rec(li)).merged()
            for li in layout.layer_indexes()}


def main():
    import argparse
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--gds",type=Path,default=HERE.parent/"nany.gds")
    parser.add_argument("--metadata",type=Path,default=HERE/"nany.ports.json")
    args = parser.parse_args()
    source = args.gds
    metadata = json.loads(args.metadata.read_text())
    digest = hashlib.sha256(source.read_bytes()).hexdigest()
    assert digest == metadata["gds_sha256"]
    saved = db.Layout()
    saved.read(str(source))
    assert not any(c.is_pcell_variant() for c in saved.each_cell())
    top = saved.cell("nany")
    counts = Counter(i.cell.name for i in top.each_inst())
    assert counts == Counter(v["cell"] for v in metadata["instances"]), counts
    variants = {v["cell"]: v for v in metadata["instances"]}
    geometry = {name: regions(saved, saved.cell(name)) for name in variants}
    # Parent routing must not introduce active or alter either MOS channel.
    active_keys = [(3, 1), (3, 2), (3, 3)]
    assert all(db.Region(top.shapes(saved.layer(*key))).is_empty() for key in active_keys)
    expected_gates = db.Region()
    for inst in top.each_inst():
        if variants[inst.cell.name]["pcell"] not in ("fet_p", "fet_n"):
            continue
        own = geometry[inst.cell.name]
        expected_gates += ((own[(3, 1)] + own[(3, 2)]) & own[(8, 1)]).transformed(inst.trans)
    full = regions(saved, top)
    assert (((full[(3, 1)] + full[(3, 2)]) & full[(8, 1)]) ^ expected_gates).is_empty()

    # Register only after capturing the literal GDS shapes; regenerated PCells
    # cannot hide a mismatch in stored geometry.
    from build_inverter import PDK  # also registers the unmodified PDK library
    fresh = db.Layout()
    fresh.dbu = saved.dbu
    fresh.technology_name = "TR-1um"
    rows = []
    for name, variant in variants.items():
        cell = fresh.create_cell(variant["pcell"], "TR-1um", variant["parameters"])
        reference = regions(fresh, cell)
        keys = set(geometry[name]) | set(reference)
        xor = {f"{key[0]}/{key[1]}": round((geometry[name].get(key, db.Region()) ^
               reference.get(key, db.Region())).area() * saved.dbu**2, 8) for key in keys}
        assert not any(xor.values()), (name, xor)
        rows.append({"cell": name, "declaration": variant["pcell"], "geometry_xor_um2": xor})
    restored = db.Layout()
    restored.technology_name = "TR-1um"
    restored.read(str(source))
    for name, variant in variants.items():
        cell = restored.cell(name)
        assert cell.is_pcell_variant(), name
        parameters = cell.pcell_parameters_by_name()
        assert set(parameters) == set(variant["parameters"])
        for key, value in parameters.items():
            expected = variant["parameters"][key]
            assert abs(value - expected) < 1e-9 if isinstance(value, (int, float)) else value == expected
    pdksources = sorted((PDK / "libs.tech/klayout/tech/python/cells").glob("*.py"))
    result = {"passed": True, "gds_sha256": digest,
              "saved_geometry_read_before_library_registration": True,
              "child_instance_counts": dict(counts), "parent_active_area_um2": 0,
              "parent_changes_to_mos_gate_area_um2": 0, "pcell_variants": rows,
              "live_pcell_roundtrip": True,
              "pdk_sources_sha256": {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in pdksources}}
    (HERE / "nany.pcell_audit.json").write_text(json.dumps(result, indent=2) + "\n")
    print(f"PASS: {len(rows)} PCell variants, unchanged saved geometry and MOS gates, live PCell round trip")


if __name__ == "__main__":
    main()
