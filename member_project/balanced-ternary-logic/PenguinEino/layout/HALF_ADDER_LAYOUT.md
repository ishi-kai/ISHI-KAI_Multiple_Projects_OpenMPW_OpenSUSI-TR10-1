# Half adder layout

Update: the current MAC revision uses 30 µm RR and wider power rails. Its bounds are (0, −12.6)–(660, 323.6) µm.
The older placement figures/results below are historical. Current ports are in `half_adder.ports.json`; see [MAC_IMPROVEMENTS.md](../MAC_IMPROVEMENTS.md) for requalification.

`half_adder.gds` implements the unchanged `half_adder.sch` using five NANY and
two INV instances. The child transistor/resistor dimensions and all child-layer
geometry match `nany.gds` and `inverter.gds`. The GDS contains the complete cell
hierarchy; `klayout.lib` is not needed to read the geometry.

- Top cell: `half_adder`; DBU: 0.001 µm; placement grid: 0.05 µm.
- Bounding box: (0, 0)–(660, 315) µm; area: 207900 µm² = 0.2079 mm².
- 44 MOS (22 PMOS, 22 NMOS), 14 diffusion resistors.
- All seven primitive instances use R0, magnification 1, with BT library links.
  BT registration uses `layout/klayout/bt_library_context.lym` to retain the
  TR-1um technology context and live nested PCells.
- Two rows, with a central horizontal M1 signal channel and M2 vertical access.
- VDD/VSS use M1 row rails and separate M2 spines. VMID has its own channel track.
- No internal load capacitors, no DRC waiver layers, no changed PDK rules.

The deliberately reserved routing channel preserves the existing primitives and
makes the macro easy to inspect. This is not a minimum-area packed layout.

## Instances

| Role | Cell | Origin (µm) | Function |
|---|---|---|---|
| x_na | inverter | (40, 200) | NA = INV(a) |
| x_t | nany | (160, 200) | T = NANY(a,b) |
| x_u | nany | (328, 200) | U = NANY(b,T) |
| x_c | nany | (496, 200) | carry = NANY(NA,U) |
| x_d | nany | (184, 0) | D = NANY(T,carry) |
| x_nd | inverter | (352, 0) | ND = INV(D) |
| x_s | nany | (508, 0) | sum = NANY(ND,carry) |

## Parent access

All top-level labels are TXM1 (48/0), on M1 (13/0). Coordinates are in µm.
`layout/half_adder.ports.json` records ports, placements, routes, and source hashes.

| Pin | Position | Function |
|---|---|---|
| a | (20, 128) | input |
| b | (20, 134) | input |
| sum | (656, 176) | output |
| carry | (656, 158) | output |
| VMID | (20, 182) | 0 V reference |
| VDD | (656, 313.3) | +5 V, upper full-width M1 rail |
| VSS | (656, 1.7) | −5 V, lower full-width M1 rail |

Transform these coordinates with the instance in an FA. Only R0 is qualified for
this complete macro so far; do not assume zero-gap abutment is qualified. Supply
routing/current capacity and extracted interconnect RC need assessment at FA/TOP
integration; this work validates geometry and connectivity, not post-route timing.

## Verification

- Official dev Drawing DRC: **0**.
- Strict LVS vs regenerated current Xschem reference: **Match**, including ports
  and both primitive circuits.
- Standard GUI DRC/LVS macros with default paths: **0 / Match**.
- Manufacturing mask DRC: **0 errors**, **10 WAR06 floating SG warnings** for the
  standalone external inputs. The strict all-markers-zero `passed` field remains
  false; warnings have not been suppressed.
- Separate fixture tying external a and b to VDD: Drawing DRC **0**, strict LVS
  **Match**, mask DRC **0**, including zero warnings. The functional HA GDS is not
  modified by this fixture.
- Reload with no libraries registered: both children and all their geometry remain
  present. Primitive XOR comparisons are empty, DBU is 0.001, and every placement
  is on the 0.05 µm grid with magnification 1.

Reports: `reports/half_adder_layout.json`, `half_adder_gui.json`,
`half_adder_driver.json`, `half_adder_hierarchy.json`.

Rebuild and verify from the project root:

```sh
QT_QPA_PLATFORM=offscreen klayout -z -t -r layout/build_half_adder.py
python3 scripts/verify_half_adder_layout.py
python3 scripts/check_half_adder_driver.py
QT_QPA_PLATFORM=offscreen klayout -z -t -r scripts/check_half_adder_gui.py
QT_QPA_PLATFORM=offscreen klayout -z -t -r layout/render_half_adder.py
```

The standalone verifier returns exit 1 for the retained WAR06 warnings. Inspect
its separate Drawing/LVS/mask results. Verification regenerates the default GUI
reference `simulation/half_adder.spice`; this ignored file must be regenerated
in a fresh checkout before using the GUI LVS macro.

Extracted SPICE: `half_adder.extracted` from GUI LVS, or
`simulation/half_adder_layout/verify/lvs/half_adder.extracted` from batch LVS.
Extraction retains device geometry/junction parameters, but does not constitute
interconnect RC extraction.

Git was initialized at the user's request. Initial state is commit `ee85147`;
the routed HA checkpoint is `302fc08`. Existing project files are committed;
simulation outputs, caches, and configuration backups are ignored.

## Extracted-netlist simulation

`python3 scripts/check_half_adder_extracted.py` re-extracts the current GDS and
checks nine DC states and all 72 transitions at 10/100 fF and ±2 ns input skew,
with a schematic baseline. See `HALF_ADDER_POST_LAYOUT.md`. This includes device
geometry/intrinsic capacitances but no metal interconnect RC.
