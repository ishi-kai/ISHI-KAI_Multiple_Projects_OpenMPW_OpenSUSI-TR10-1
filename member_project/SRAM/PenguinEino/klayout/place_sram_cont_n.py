#!/usr/bin/env python3
"""Place the minimum-size TR-1um n-well tap in the SRAM bit cell.

Coordinates are in the native 0.1 um database grid of sram.gds.  The tap is
kept in its own cell to mirror the PDK cont_n PCell after GDS streaming.
"""

from pathlib import Path
import os
import shutil
import sys

import klayout.db as db


TAP_CELL_NAME = "cont_n"
TAP_CENTER = db.Vector(29, -2287)  # (2.9 um, -228.7 um) in cell sram
TAP_HALF_SIZE = 13                 # 2.6 um AN/M1, PDK minimum
CONTACT_HALF_SIZE = 5              # 1.0 um CO, PDK fixed size
VDD_ROUTE = db.Box(42, -2296, 75, -2278)  # 1.8 um M1 to existing Vdd M1


def main() -> int:
    gds_path = Path(sys.argv[1] if len(sys.argv) > 1 else "sram.gds").resolve()
    backup_path = gds_path.with_suffix(".before-cont-n.gds")
    temp_path = gds_path.with_suffix(".cont-n.tmp.gds")

    layout = db.Layout()
    layout.read(str(gds_path))
    if abs(layout.dbu - 0.1) > 1e-9:
        raise RuntimeError(f"Expected 0.1 um DBU, got {layout.dbu}")

    sram = layout.cell("sram")
    if sram is None:
        raise RuntimeError("Cell 'sram' was not found")

    tap = layout.cell(TAP_CELL_NAME)
    if tap is None:
        tap = layout.create_cell(TAP_CELL_NAME)
        tap.shapes(layout.layer(3, 2)).insert(
            db.Box(-TAP_HALF_SIZE, -TAP_HALF_SIZE,
                   TAP_HALF_SIZE, TAP_HALF_SIZE)
        )
        tap.shapes(layout.layer(11, 0)).insert(
            db.Box(-CONTACT_HALF_SIZE, -CONTACT_HALF_SIZE,
                   CONTACT_HALF_SIZE, CONTACT_HALF_SIZE)
        )
        tap.shapes(layout.layer(13, 0)).insert(
            db.Box(-TAP_HALF_SIZE, -TAP_HALF_SIZE,
                   TAP_HALF_SIZE, TAP_HALF_SIZE)
        )

    already_placed = any(
        inst.cell_index == tap.cell_index() and inst.trans.disp == TAP_CENTER
        for inst in sram.each_inst()
    )
    if already_placed:
        print("cont_n is already placed; no change")
        return 0

    if not backup_path.exists():
        shutil.copy2(gds_path, backup_path)

    sram.insert(db.CellInstArray(tap.cell_index(), db.Trans(TAP_CENTER)))
    sram.shapes(layout.layer(13, 0)).insert(VDD_ROUTE)

    layout.write(str(temp_path))
    os.replace(temp_path, gds_path)
    print(f"placed cont_n in sram at ({TAP_CENTER.x * layout.dbu:.1f}, "
          f"{TAP_CENTER.y * layout.dbu:.1f}) um")
    print(f"backup: {backup_path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
