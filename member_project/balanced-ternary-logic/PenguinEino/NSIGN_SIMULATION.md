> 寸法調整後の最新値は [NSIGN_TUNING.md](NSIGN_TUNING.md) を参照してください。以下は調整前の回路の履歴です。

> 最新版では重複PMOSは除去済みです。現在の(0,0)出力は約−71.6 mV、全72遷移の最悪整定時間は約19.4 ns（27℃、10 fF）。以下は過去の回路の記録です。現在の評価は [CIRCUIT_REVIEW.md](CIRCUIT_REVIEW.md) を参照してください。

# NSIGN simulation — added zero clamp

The latest `nsign.sch` adds two series PMOS/NMOS branches from the output to GND, enabled by opposite input polarities. The existing testbench was rerun unchanged at 27 C, +/-5 V supplies, 10 fF load and 1 ns input edges.

**All 17 transient samples pass the +/-0.5 V criterion**, including all four mixed-input history tests. DC results for opposite rails are approximately 0 V (17–50 nV in this model), and (0,0) is +30.7 mV. The other six input pairs yield their expected +/-5 V levels. Polarity remains `-sign(a+b)`.

For the four mixed-input transitions, time to enter and remain within +/-0.5 V after completion of the input edge was approximately 2.81, 2.35, 5.68 and 3.04 ns, respectively. These are sampled settling times at a maximum 0.2 ns simulation step, not propagation delays or exhaustive timing results.

With +/-1 nA applied to the output at either mixed-input state, the output changes by about +/-1.02 uV: finite-difference output resistance is about 1.02 kohm. The former floating state is now actively connected to 0 V.

**Schematic observation:** XM5 overlaps XM4 and has the same four connections, so they are electrically parallel. Xschem reports the overlap. This run preserves that user schematic exactly; it includes the extra PMOS, which also changes the (0,0) offset. No device sizes or circuit wiring were edited.

Latest netlist, saved source snapshot, data and log: `simulation/nsign_added/`. Earlier results below apply to the original circuit only.

---

# NSIGN simulation — original circuit

`nsign_tb.sch` uses `nsign.sym` / the existing `nsign.sch` without changing device sizes or wiring.
The circuit polarity is **y = -sign(a+b)**, with logic voltages -5/0/+5 V.
Temperature: 27 C. Output load: 10 fF. Input edge: 1 ns.

## DC

| A (V) | B (V) | Vout (V) | Interpretation |
|---:|---:|---:|---|
| -5 | -5 | +5.000 | Driven |
| -5 | 0 | +5.000 | Driven |
| -5 | +5 | +0.826 | Floating equilibrium; not a valid driven zero |
| 0 | -5 | +5.000 | Driven |
| 0 | 0 | -0.0716 | Driven zero |
| 0 | +5 | -5.000 | Driven |
| +5 | -5 | +0.497 | Floating equilibrium; not a valid driven zero |
| +5 | 0 | -5.000 | Driven |
| +5 | +5 | -5.000 | Driven |

For each B=-5/0/+5 V, A is swept from -5 to +5 V in 25 mV increments.
The apparently intermediate DC values for opposite rails depend on leakage and solver conductances, and should not be interpreted as logic restoration.

## Output-current sensitivity

The normally zero ITEST source is separately changed to +1 nA (sink) / -1 nA (inject) for all nine input pairs.
Driven states move only a few microvolts, corresponding to a finite-difference output resistance of about 2.81–5.25 kohm.
Opposite-rail inputs instead move to about -5.21 V / +5.15 V. The full-swing secant `r_apparent` is **not** a small-signal output resistance in those floating cases.
The current source is reset to zero before the main transient test.

## Transient history

All nine pairs are held for 200 ns each, followed by four history tests.
Each history test precharges with equal inputs for 200 ns, then holds opposite inputs for 1 us.
Samples are taken 1 ns before each interval ends.

| A,B during mixed hold (V) | Precharge output | Vout after approximately 1 us |
|---|---:|---:|
| -5, +5 | +5 V | +5.299 V |
| -5, +5 | -5 V | -5.321 V |
| +5, -5 | +5 V | +5.255 V |
| +5, -5 | -5 V | -2.447 V |

All 11 sampled driven states are within 0.5 V of their expected levels.
All 6 sampled opposite-rail states fail the zero-level tolerance.
The two mixed input orders are not dynamically identical because the input transistors occupy different positions in the series stacks.
This is a capacitive, history-dependent output rather than a driven zero; the exact drift/overshoot is model- and load-dependent.

## Running and numerical details

Open `nsign_tb.sch`, disable LVS, then Netlist → Simulate. The schematic contains the complete sequence and expected values.
Plots use native ngspice voltage plots only: three DC plots, the complete transient, and a history-test close-up.
Data files are `nsign_dc_b_{neg,zero,pos}.txt` and `nsign_tran.txt` in the simulation working directory.
The verified batch run and log are under `simulation/nsign/`.

`.options rshunt=1e12` supplies numerical shunts. `.nodeset` provides initial guesses for the output and internal stack nodes to avoid nonphysical remote DC roots in the nonlinear model. These are solver aids, not added circuit components or transient forced initial conditions. In floating states they can affect the DC equilibrium, which is why history and load sensitivity are reported separately.
