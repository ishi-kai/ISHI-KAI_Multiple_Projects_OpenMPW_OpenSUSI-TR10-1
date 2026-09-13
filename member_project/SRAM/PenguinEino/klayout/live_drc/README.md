# TR-1um Live DRC for KLayout

This macro leaves KLayout's normal Path/Box/Polygon tools unchanged. It polls
the active edited cell every 300 ms and reruns a viewport-local in-memory DRC
when area geometry changes. Paths, boxes, polygons, PCell output, and shapes in
child cells are included. A geometry hash detects vertex edits even when the
shape count and bounding box remain unchanged. Violations are drawn as red
markers.

After the fast viewport check, the unmodified official PDK `run.drc` is run
against the current unsaved layout after 900 ms without another edit. Official
violations are rendered as red overlay markers without opening a window. The
complete report opens only when **Show official results** is selected. The
previous automatic report is replaced after a new run completes successfully.
The layout display is held during the synchronous official run so KLayout's
temporary DRC progress page does not flash. Painting is restored even on an
error; this does not change DRC results or make the check asynchronous.

The numeric values are loaded at startup from:

```text
$PDK_ROOT/$PDK/libs.tech/klayout/tech/python/cells/rules_def.py
```

If that file is unavailable, the checked-in TR-1um values are used.  No PDK
file is modified.

## Immediate checked rules

- Minimum width, same-layer spacing, and notch for WN, AP, AN, GC, CO, M1,
  M2, and PO
- AR spacing; AC minimum/maximum size, rectangular shape, and spacing
- Cross-layer spacing and prohibited overlap for WN/AP/AN, AR/AN, GC/AP/AN/AR,
  and PO/AP/AN/GC/M1/M2 combinations defined by the PDK
- WN enclosure of AP (`AP.WN`)
- M1 and lower-layer enclosure of CO, plus required lower conductor for CO
- Exact regular V1 size, V1 spacing, M1/M2 enclosure, and V1 separation from
  GC/CO
- PO containment/enclosure by M1/M2 and required pad V1 enclosure
- Manhattan or 45-degree edge restriction
- DRC waiver shapes on 63/0 are excluded

The scan covers the current viewport plus the largest applicable rule distance,
so a shape just outside the screen can still produce a spacing marker at the
screen edge.

## Official second pass

The immediate checker is deliberately limited to inexpensive Region
operations. The automatic second pass executes the PDK's original `run.drc`
without copying its rules. It therefore includes all 139 current report
categories, including device-derived regions, ESD, resistor/MOS dimensions,
wide-metal rules, and the electrical antenna check. Edits to PTECT, ESD, SCRB,
M1/M2 label, and DRC-waiver layers also trigger this pass.

The official pass runs over the active unsaved layout after 900 ms of editing
inactivity. On the current SRAM layout it typically completes in well under one
second, but a large hierarchy may take longer and briefly block the UI. It can
be disabled independently from the Tools menu. A final explicit official DRC
run is still recommended before sign-off.

## Install

Run:

```bash
./klayout/live_drc/install.sh
```

Restart KLayout, or open `pymacros/TR-1um_live_drc.lym` in Macro Development
and run it to reload the controller in the current session.
The macro starts enabled and adds `Tools > TR-1um Live DRC`
with these commands:

- **Enabled**: master switch
- **Official DRC after edits**: enable or disable the debounced full PDK pass
- **Run fast DRC now** and **Run official DRC now**
- **Show official results** and **Clear markers**

## Test

```bash
python3 -m unittest discover -s klayout/live_drc/tests -v
klayout -z -nc -rx -e -n TR-1um sram.gds \
  -r klayout/live_drc/tests/gui_smoke.py
klayout -z -nc -rx -e -n TR-1um sram.gds \
  -r klayout/live_drc/tests/full_drc_macro_smoke.py
QT_QPA_PLATFORM=offscreen klayout -z -nc -rx -e -n TR-1um sram.gds \
  -r klayout/live_drc/tests/progress_smoke.py
```
