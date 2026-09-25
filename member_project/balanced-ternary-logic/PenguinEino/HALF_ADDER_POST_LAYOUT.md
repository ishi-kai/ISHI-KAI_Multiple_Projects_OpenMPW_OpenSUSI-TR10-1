# Half adder: extracted-netlist simulation

The simulation uses the device network extracted from `half_adder.gds`, replacing
the schematic DUT definitions in the existing `half_adder_tb.sch` testbench.
The input sequence, ideal ±5 V supplies / VMID=0 V, 27 °C, 1 ns input edges, and
external SUM/CARRY loads are retained. There are no added loads inside the HA.

## Run

From the project root:

```sh
python3 scripts/check_half_adder_extracted.py
```

The script regenerates the schematic LVS reference, runs strict LVS and extraction
against the current GDS, then creates and simulates both extracted and schematic
versions under identical conditions. It stops on a failed LVS or invalid simulation.
It creates its own Xschem configuration; no preexisting ignored simulation files
are required. Required programs: xschem, KLayout, ngspice; Python numpy and klayout.

The normalized simulation include is:
`simulation/half_adder_layout/extracted_sim/half_adder_extracted.spice`.
Anonymous extracted node/instance identifiers are renamed for ngspice probes;
the device parameters, terminal order, and connections are retained.
`node_mapping.json` records the correspondence to schematic internal signals.

For native ngspice plots:

```sh
cd simulation/half_adder_layout/extracted_sim/extracted/tran_10f
ngspice view.spice
```

Other directories are `tran_100f`, `skew_a`, and `skew_b`. Each has a batch
`tb.spice`, interactive `view.spice`, waveform `data.txt`, and `run.log`.
`view.spice` displays separate native SUM and CARRY plots with both inputs.
No `.sch` file is changed by this workflow.

## Why port order matters

The schematic interface is:

```spice
.subckt half_adder a b sum carry VDD VSS VMID
```

The current extraction has a different order:

```spice
.SUBCKT half_adder VDD VMID VSS a b carry sum
```

Consequently, the extracted simulation uses:

```spice
xdut VDD VMID VSS a b carry sum half_adder
```

The script reads that header instead of assuming the schematic symbol's order.
It removes the schematic DUT subcircuit definitions and includes the extracted
half_adder/nany/inverter definitions. The PDK `ip62_models` remains included:
extracted `XM...` instances invoke PMOS/NMOS subcircuit models, and `XR...` invokes
F_RR. An LVS reference uses native M-device records for comparison and is not itself
the simulation DUT include.

## Scope and interpretation

This PDK's LVS extraction includes transistor W/L, source/drain junction areas
and perimeters (AS/AD/PS/PD), resistor geometry, and physical connectivity. The
PDK models supply intrinsic MOS and resistor capacitance.

**It does not extract metal resistance, metal-to-substrate capacitance, or
inter-wire coupling capacitance.** Thus this checks the extracted device network;
it is not a complete interconnect-RC PEX timing result. No PVT/corner assessment
is included here.

Nine DC input states are checked. Four transient conditions each exercise all
72 directed transitions among those states, with 100 ns holding time:
10 fF and 100 fF on each output, plus A-delayed/B-delayed 2 ns cases at 10 fF.
At each transition's end, all seven logic signals T/U/NA/CARRY/D/ND/SUM must be
within ±0.5 V of their expected logic voltage. Settling time is measured after
the last input edge finishes, until both outputs enter and remain within ±0.5 V
through the checked interval. Glitch-free operation is not implied.

## DC numerical initialization

A continuous A sweep with B fixed and generic initial estimates produced an
unphysical internal voltage (approximately 5.7e10 V) in a transition region of
the RR model. Nominal points in that sweep could still look correct; the full
curve must not be interpreted as physical behavior.

The adopted DC check solves each of the nine nominal input states independently.
First, a 200 ns transient starts from (−5,−5), changes to the target pair at
20–21 ns, and settles. Its final internal node voltages become `.nodeset` guesses
for a separate DC solve at the target pair. These are Newton initial estimates;
there is no UIC, fixed output voltage source, `.ic` constraint, or model change.
The independent DC result is then checked. The 72-transition tests separately
check the other input histories.

`dc/point0` ... `dc/point8` contain these independent solves in lexicographic
(A,B) order. Each `seed` subfolder contains the initializing transient. This
validates the truth-table points, not a complete continuous VTC or noise margin.

## LVS hierarchy and reference path

The GUI's default reference is `simulation/half_adder.spice`. It contains all three
subcircuits: `half_adder`, `nany`, and `inverter`. Batch verification uses the same
content at `simulation/half_adder_layout/verify/reference/reference.spice`.
The simulator's transistor model library is separate from this LVS reference.

The official `run.lvs` selects `deep` hierarchical extraction. `05_Compare.lvs`
flattens transistor/resistor PCell circuits such as `fet_p*`, `fet_n*`, and
`res_diff*`, retaining the logic hierarchy. It reads the specified schematic,
aligns the hierarchies, combines equivalent devices where supported, then compares
connectivity and device parameters with strict top-port checking.

Circuit names such as `inverter` help align GDS-derived circuits with `.subckt`
definitions. Matching names alone do not pass LVS. Instance names (`x_na` vs
`X$6`) and anonymous internal net names may differ. The contents of all three
circuits matched in this design. KLayout does not automatically search for a
separate `inverter.spice` based on a GDS child name.

Regenerate the GUI reference after schematic changes:

```sh
python3 scripts/verify_half_adder_layout.py --prepare-gui-reference
```

## Results

Numerical results and input/source/model hashes are recorded in
`reports/half_adder_extracted.json`. Full transition records are in
`simulation/half_adder_layout/extracted_sim/results.json`.

All nine independent DC states pass; maximum SUM/CARRY error is **2.575 mV**.
All 72 transitions pass under each condition below; none remain unsettled.

| Condition | Extracted max settling (ns) | Schematic max settling (ns) | Extracted max final output error (mV) |
|---|---:|---:|---:|
| 10 fF, simultaneous inputs | 35.13 | 35.23 | 2.642 |
| 100 fF, simultaneous inputs | 35.72 | 35.83 | 2.634 |
| 10 fF, A delayed 2 ns | 34.95 | 35.05 | 2.645 |
| 10 fF, B delayed 2 ns | 33.10 | 33.30 | 2.644 |

The extracted and schematic results are close under this model. Complete routing
RC and physical chip/pad loading are outside this test. The fresh extracted file's
hash matches the existing root `half_adder.extracted`.
