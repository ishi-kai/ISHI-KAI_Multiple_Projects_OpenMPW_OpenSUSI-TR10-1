v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {TERNARY INVERTER x2 / INPUT RESTORATION} 40 -180 0 0 0.4 0.4 {}
T {V+ = +5 V / V- = -5 V; output load = 10 fF} 40 -130 0 0 0.27 0.27 {}
T {Stage 1 drives stage 2 directly; no added interstage capacitor.} 40 -90 0 0 0.25 0.25 {}
C {/home/ishi-kai/balanced-ternary-logic/inverter.sym} 300 100 0 0 {name=x1}
C {/home/ishi-kai/balanced-ternary-logic/inverter.sym} 650 100 0 0 {name=x2}
N 160 100 240 100 {lab=vin}
C {devices/lab_pin.sym} 160 100 0 0 {name=lin lab=vin}
N 370 100 590 100 {lab=vmid}
C {devices/lab_pin.sym} 470 100 0 0 {name=lmid lab=vmid}
N 720 100 850 100 {lab=vout}
C {devices/lab_pin.sym} 850 100 0 1 {name=lout lab=vout}
N 850 100 850 180 {lab=vout}
C {devices/capa.sym} 850 210 0 0 {name=Cload value=10f m=1}
N 850 240 850 280 {lab=GND}
C {devices/gnd.sym} 850 280 0 0 {name=gload lab=GND}
N 300 0 650 0 {lab=V+}
N 300 0 300 40 {lab=V+}
N 650 0 650 40 {lab=V+}
C {devices/lab_pin.sym} 300 0 0 0 {name=lp lab=V+}
N 300 200 650 200 {lab=V-}
N 300 160 300 200 {lab=V-}
N 650 160 650 200 {lab=V-}
C {devices/lab_pin.sym} 300 200 0 0 {name=ln lab=V-}
C {devices/vsource.sym} 100 430 0 0 {name=VDD value="5" savecurrent=false}
N 100 350 100 400 {lab=V+}
C {devices/lab_pin.sym} 100 350 0 0 {name=l_VDD lab=V+}
N 100 460 100 500 {lab=GND}
C {devices/gnd.sym} 100 500 0 0 {name=g_VDD lab=GND}
C {devices/vsource.sym} 320 430 0 0 {name=VSS value="-5" savecurrent=false}
N 320 350 320 400 {lab=V-}
C {devices/lab_pin.sym} 320 350 0 0 {name=l_VSS lab=V-}
N 320 460 320 500 {lab=GND}
C {devices/gnd.sym} 320 500 0 0 {name=g_VSS lab=GND}
C {devices/vsource.sym} 540 430 0 0 {name=VIN hide_texts=true value="PWL(0 -5 20n -5 21n 0 40n 0 41n 5 60n 5 61n 0 80n 0 81n -5 100n -5 101n 5 120n 5 121n -5 140n -5)" savecurrent=false}
N 540 350 540 400 {lab=vin}
C {devices/lab_pin.sym} 540 350 0 0 {name=l_VIN lab=vin}
N 540 460 540 500 {lab=GND}
C {devices/gnd.sym} 540 500 0 0 {name=g_VIN lab=GND}
C {devices/code.sym} 1040 720 0 0 {name=TR_1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"}
C {devices/code.sym} 1350 720 0 0 {name=SIMULATION
only_toplevel=true
value=".temp 27
.nodeset v(vmid)=5 v(vout)=-5
.control
save all
dc VIN -5 5 0.015625
let restore_error=v(vout)-v(vin)
meas dc OUT_NEG find v(vout) at=-5
meas dc OUT_ZERO find v(vout) at=0
meas dc OUT_POS find v(vout) at=5
plot v(vin) v(vmid) v(vout) ylimit -5.5 5.5 title 'DC transfer: two inverters'
reset
tran 0.05n 140n
let restore_error=v(vout)-v(vin)
meas tran OUT_NEG_1 find v(vout) at=19n
meas tran ERROR_NEG_1 find restore_error at=19n
meas tran OUT_ZERO_UP find v(vout) at=39n
meas tran ERROR_ZERO_UP find restore_error at=39n
meas tran OUT_POS_1 find v(vout) at=59n
meas tran ERROR_POS_1 find restore_error at=59n
meas tran OUT_ZERO_DOWN find v(vout) at=79n
meas tran ERROR_ZERO_DOWN find restore_error at=79n
meas tran OUT_NEG_2 find v(vout) at=99n
meas tran ERROR_NEG_2 find restore_error at=99n
meas tran OUT_POS_2 find v(vout) at=119n
meas tran ERROR_POS_2 find restore_error at=119n
meas tran OUT_NEG_3 find v(vout) at=139n
meas tran ERROR_NEG_3 find restore_error at=139n
plot v(vin) v(vmid) v(vout) ylimit -5.5 5.5 title 'Two inverters: input, stage 1, output'
.endc"}
C {devices/netlist_options.sym} 1040 950 0 0 {name=NETLIST_OPTIONS
lvs_netlist=false
top_is_subckt=false
spiceprefix=true
hiersep=.}

T {1  CIRCUIT / vin -> x1 -> vmid -> x2 -> vout} 40 -40 0 0 0.3 0.3 {}
T {2  STIMULUS / edit voltage-source properties} 40 300 0 0 0.3 0.3 {}
T {VIN / PWL} 575 420 0 0 0.25 0.25 {}
T {VDD = +5 V; VSS = -5 V; input levels = -5 / 0 / +5 V} 40 560 0 0 0.25 0.25 {}
T {Cload = 10 fF at vout. Stage 1 drives the actual stage 2 gates.} 40 600 0 0 0.25 0.25 {}
T {SEQUENCE / time in ns; voltage in V} 1040 -170 0 0 0.32 0.32 {}
T {Hold interval       vin       vmid*       vout*      Measure at} 1040 -120 0 0 0.25 0.25 {}
T {0 - 20                -5          +5            -5             19} 1040 -75 0 0 0.25 0.25 {}
T {21 - 40                0            0              0             39} 1040 -30 0 0 0.25 0.25 {}
T {41 - 60               +5          -5            +5             59} 1040 15 0 0 0.25 0.25 {}
T {61 - 80                0            0              0             79} 1040 60 0 0 0.25 0.25 {}
T {81 - 100              -5          +5            -5             99} 1040 105 0 0 0.25 0.25 {}
T {101 - 120            +5          -5            +5           119} 1040 150 0 0 0.25 0.25 {}
T {121 - 140             -5          +5            -5           139} 1040 195 0 0 0.25 0.25 {}
T {* Expected settled voltages; transitions have propagation delay.} 1040 285 0 0 0.24 0.24 {}
T {1 ns input edges: 20-21, 40-41, 60-61, 80-81, 100-101, 120-121.} 1040 325 0 0 0.24 0.24 {}
T {All six directed transitions between -5 / 0 / +5 V are exercised.} 1040 365 0 0 0.24 0.24 {}
T {OBSERVATIONS / DC + TRANSIENT} 1040 420 0 0 0.3 0.3 {}
T {DC: VIN -5 -> +5 V, step 0.015625 V; measure at -5 / 0 / +5 V.} 1040 465 0 0 0.24 0.24 {}
T {DC plot: vin / vmid / vout in the native ngspice plot window.} 1040 505 0 0 0.24 0.24 {}
T {Transient: observe vin / vmid / vout; sample vout and vout-vin above.} 1040 545 0 0 0.24 0.24 {}
T {RUN / disable LVS, then Netlist -> Simulate} 1040 605 0 0 0.3 0.3 {}
T {Edit VIN for the sequence; SIMULATION for analyses and measurements.} 1040 645 0 0 0.24 0.24 {}
