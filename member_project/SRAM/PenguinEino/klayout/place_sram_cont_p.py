#!/usr/bin/env python3
"""Move the SRAM substrate tap to array level and connect the top Vss rail."""

from pathlib import Path
import os
import shutil
import sys

import klayout.db as db


TAP_CENTER = db.Vector(300, -2500)   # (30.0 um, -250.0 um), array coordinates
VIA_CENTER = db.Vector(300, -2088)   # (30.0 um, -208.8 um), on top Vss M2
M1_BRIDGE = db.Box(291, -2487, 309, -2105)  # 1.8 um wide


def main() -> int:
    gds_path = Path(sys.argv[1] if len(sys.argv) > 1 else "sram.gds").resolve()
    backup_path = gds_path.with_suffix(".before-cont-p-move.gds")
    temp_path = gds_path.with_suffix(".cont-p.tmp.gds")

    layout = db.Layout()
    layout.read(str(gds_path))
    if abs(layout.dbu - 0.1) > 1e-9:
        raise RuntimeError(f"Expected 0.1 um DBU, got {layout.dbu}")

    sram = layout.cell("sram")
    if sram is None:
        raise RuntimeError("Cell 'sram' was not found")
    array = layout.cell("sram_array")
    if array is None:
        raise RuntimeError("Cell 'sram_array' was not found")

    taps = [
        (parent, inst)
        for parent in (sram, array)
        for inst in parent.each_inst()
        if inst.cell.name.startswith("cont_p")
    ]
    if len(taps) != 1:
        raise RuntimeError(f"Expected exactly one cont_p instance, found {len(taps)}")

    tap_parent, tap = taps[0]
    via = layout.cell("via_1")
    if via is None:
        raise RuntimeError("Cell 'via_1' was not found")
    via_present = any(
        inst.cell_index == via.cell_index() and inst.trans.disp == VIA_CENTER
        for inst in array.each_inst()
    )
    bridge_present = any(
        shape.is_box() and shape.box == M1_BRIDGE
        for shape in array.shapes(layout.layer(13, 0)).each()
    )
    if tap_parent == array and tap.trans.disp == TAP_CENTER and via_present and bridge_present:
        print("cont_p and its via are already at the target position; no change")
        return 0

    if not backup_path.exists():
        shutil.copy2(gds_path, backup_path)

    old = tap.trans.disp
    tap_cell_index = tap.cell_index
    tap.delete()
    array.insert(db.CellInstArray(tap_cell_index, db.Trans(TAP_CENTER)))
    if not via_present:
        array.insert(db.CellInstArray(via.cell_index(), db.Trans(VIA_CENTER)))
    if not bridge_present:
        array.shapes(layout.layer(13, 0)).insert(M1_BRIDGE)
    layout.write(str(temp_path))
    os.replace(temp_path, gds_path)
    print(
        f"moved cont_p from ({old.x * layout.dbu:.1f}, {old.y * layout.dbu:.1f}) "
        f"to ({TAP_CENTER.x * layout.dbu:.1f}, {TAP_CENTER.y * layout.dbu:.1f}) um"
    )
    print(f"backup: {backup_path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
