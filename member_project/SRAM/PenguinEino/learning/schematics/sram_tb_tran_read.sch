v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {6T SRAM | PRECHARGED READ: BOTH STORED STATES} -100 -340 0 0 0.42 0.42 {}
T {5 V / cell W/L = 3.4u / 1u / sram_tb_tran_read.sch} -100 -290 0 0 0.27 0.27 {}
T {1  PRECHARGE + CELL} -100 -220 0 0 0.34 0.34 {}
C {sram.sym} 300 100 0 0 {name=x1}
N 450 90 510 90 {lab=Q}
C {devices/lab_pin.sym} 510 90 2 0 {name=l12 lab=Q}
N 450 110 510 110 {lab=QB}
C {devices/lab_pin.sym} 510 110 2 0 {name=l14 lab=QB}
N 450 130 510 130 {lab=VDD}
C {devices/lab_pin.sym} 510 130 2 0 {name=l16 lab=VDD}
N 450 150 510 150 {lab=GND}
C {devices/lab_pin.sym} 510 150 2 0 {name=l18 lab=GND}
N 300 180 300 220 {lab=WL}
C {devices/lab_pin.sym} 300 220 2 0 {name=l20 lab=WL}
N 100 70 150 70 {lab=BL}
C {devices/lab_pin.sym} 100 70 0 0 {name=l22 lab=BL}
N 450 70 700 70 {lab=BLB}
C {devices/lab_pin.sym} 700 70 2 0 {name=l24 lab=BLB}
C {TR-1umLIB/MP.sym} 60 -90 0 0 {name=M2
model=PMOS
w=3.4u
l=1u
nrd=0
nrs=0
m=1
spiceprefix=X}
N 100 -160 100 -120 {lab=VDD}
C {devices/lab_pin.sym} 100 -160 0 0 {name=l27 lab=VDD}
N 100 -90 200 -90 {lab=VDD}
N 200 -160 200 -90 {lab=VDD}
C {devices/lab_pin.sym} 200 -160 2 0 {name=l30 lab=VDD}
C {devices/lab_pin.sym} 60 -90 0 0 {name=l31 lab=PRECHG}
N 100 -60 100 250 {lab=BL}
C {devices/capa.sym} 100 280 0 0 {name=Cload2
m=1
value=10f}
N 100 310 100 350 {lab=GND}
C {devices/gnd.sym} 100 350 0 0 {name=g35 lab=GND}
C {TR-1umLIB/MP.sym} 660 -90 0 0 {name=M1
model=PMOS
w=3.4u
l=1u
nrd=0
nrs=0
m=1
spiceprefix=X}
N 700 -160 700 -120 {lab=VDD}
C {devices/lab_pin.sym} 700 -160 0 0 {name=l38 lab=VDD}
N 700 -90 800 -90 {lab=VDD}
N 800 -160 800 -90 {lab=VDD}
C {devices/lab_pin.sym} 800 -160 2 0 {name=l41 lab=VDD}
C {devices/lab_pin.sym} 660 -90 0 0 {name=l42 lab=PRECHG}
N 700 -60 700 250 {lab=BLB}
C {devices/capa.sym} 700 280 0 0 {name=Cload
m=1
value=10f}
N 700 310 700 350 {lab=GND}
C {devices/gnd.sym} 700 350 0 0 {name=g46 lab=GND}
T {2  STIMULUS / select a source and press q to edit} -100 440 0 0 0.34 0.34 {}
C {devices/vsource.sym} 0 580 0 0 {name=Vdd
value=5.0
savecurrent=false
hide_texts=true}
N 0 510 0 550 {lab=VDD}
C {devices/lab_pin.sym} 0 510 2 0 {name=l50 lab=VDD}
N 0 610 0 650 {lab=GND}
C {devices/gnd.sym} 0 650 0 0 {name=g52 lab=GND}
T {5.0 V} 28 570 0 0 0.26 0.26 {}
C {devices/vsource.sym} 210 580 0 0 {name=VPRECHG
value="PWL(0 0 10n 0 10.1n 5 20n 5)"
savecurrent=false
hide_texts=true}
N 210 510 210 550 {lab=PRECHG}
C {devices/lab_pin.sym} 210 510 2 0 {name=l56 lab=PRECHG}
N 210 610 210 650 {lab=GND}
C {devices/gnd.sym} 210 650 0 0 {name=g58 lab=GND}
T {PWL} 238 570 0 0 0.26 0.26 {}
C {devices/vsource.sym} 420 580 0 0 {name=VWL
value="PWL(0 0 11n 0 11.1n 5 15n 5 15.1n 0 20n 0)"
savecurrent=false
hide_texts=true}
N 420 510 420 550 {lab=WL}
C {devices/lab_pin.sym} 420 510 2 0 {name=l62 lab=WL}
N 420 610 420 650 {lab=GND}
C {devices/gnd.sym} 420 650 0 0 {name=g64 lab=GND}
T {PWL} 448 570 0 0 0.26 0.26 {}
T {SEQUENCE / time in ns} 930 -220 0 0 0.32 0.32 {}
T {0 - 10     PRECHG = 0: charge both bitlines} 930 -180 0 0 0.27 0.27 {}
T {10 - 10.1  Turn precharge OFF} 930 -140 0 0 0.27 0.27 {}
T {11 - 15    Raise WL to read the cell} 930 -100 0 0 0.27 0.27 {}
T {18             Measure retained state} 930 -60 0 0 0.27 0.27 {}
T {INITIAL STATE / LOAD} 930 20 0 0 0.27 0.27 {}
T {Q = 0 V, QB = 5 V initially} 930 60 0 0 0.27 0.27 {}
T {Then repeat Q = 5 V, QB = 0 V} 930 100 0 0 0.27 0.27 {}
T {10 fF per bitline (assumed load)} 930 140 0 0 0.27 0.27 {}
T {Precharge PMOS W/L = 3.4u / 1u} 930 180 0 0 0.27 0.27 {}
T {Low-node access / pull-down currents are compared.} 930 225 0 0 0.27 0.27 {}
T {RUN / netlist, then simulate in Xschem} 930 290 0 0 0.3 0.3 {}
T {Edit SIMULATION for analysis and measurements.} 930 335 0 0 0.27 0.27 {}
T {Waveforms open after simulation.} 930 375 0 0 0.27 0.27 {}
C {devices/code.sym} 960 520 0 0 {name=TR_1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"}
C {devices/code.sym} 1270 520 0 0 {name=SIMULATION
only_toplevel=true
value=".param QINIT=0 QBINIT=5
.ic v(Q)='QINIT' v(QB)='QBINIT'

.control
save all @m.x1.xxm7.m1[id] @m.x1.xxm6.m1[id] @m.x1.xxm1.m1[id] @m.x1.xxm3.m1[id]

tran 0.01n 20n

meas tran BL_read_Q0 find v(BL) at=14n
meas tran BLB_read_Q0 find v(BLB) at=14n
meas tran Q_read_Q0 find v(Q) at=14n
meas tran QB_read_Q0 find v(QB) at=14n
meas tran Q_disturb_Q0 max v(Q) from=11n to=15n
meas tran Q_hold_Q0 find v(Q) at=18n
meas tran QB_hold_Q0 find v(QB) at=18n

let PRECHG_T = V(PRECHG)/5+10
let WL_T = V(WL)/5+8
let BL_T = V(BL)/5+6
let BLB_T = V(BLB)/5+4
let Q_T = V(Q)/5+2
let QB_T = V(QB)/5
let I_Q_ACCESS_uA = @m.x1.xxm7.m1[id]*1e6
let I_QB_ACCESS_uA = @m.x1.xxm6.m1[id]*1e6
let I_Q_ACCESS_MAG_uA = abs(I_Q_ACCESS_uA)
let I_QB_ACCESS_MAG_uA = abs(I_QB_ACCESS_uA)
meas tran I_Q_ACCESS_PEAK_Q0 max I_Q_ACCESS_MAG_uA from=11n to=15n
meas tran I_QB_ACCESS_PEAK_Q0 max I_QB_ACCESS_MAG_uA from=11n to=15n

* Compare currents at the LOW storage node (Q for Q0, QB for Q5).
let I_LOW_ACCESS_uA = abs(@m.x1.xxm7.m1[id])*1e6
let I_LOW_PULLDOWN_uA = abs(@m.x1.xxm1.m1[id])*1e6
meas tran I_LOW_PULLDOWN_PEAK_Q0 max I_LOW_PULLDOWN_uA from=11n to=15n
plot I_LOW_ACCESS_uA I_LOW_PULLDOWN_uA ylabel 'Current magnitude (uA)' title 'READ STRENGTH: Q0, access versus cell pull-down'

plot PRECHG_T WL_T BL_T BLB_T Q_T QB_T ylimit -0.2 11.2 ydelta 1 title 'READ: Q=0, QB=5 V'
plot I_Q_ACCESS_uA I_QB_ACCESS_uA ylabel 'Access current (uA)' title 'READ current: Q=0, QB=5 V'

alterparam QINIT=5
alterparam QBINIT=0
reset
save all @m.x1.xxm7.m1[id] @m.x1.xxm6.m1[id] @m.x1.xxm1.m1[id] @m.x1.xxm3.m1[id]

tran 0.01n 20n

meas tran BL_read_Q5 find v(BL) at=14n
meas tran BLB_read_Q5 find v(BLB) at=14n
meas tran Q_read_Q5 find v(Q) at=14n
meas tran QB_read_Q5 find v(QB) at=14n
meas tran QB_disturb_Q5 max v(QB) from=11n to=15n
meas tran Q_hold_Q5 find v(Q) at=18n
meas tran QB_hold_Q5 find v(QB) at=18n

let PRECHG_T = V(PRECHG)/5+10
let WL_T = V(WL)/5+8
let BL_T = V(BL)/5+6
let BLB_T = V(BLB)/5+4
let Q_T = V(Q)/5+2
let QB_T = V(QB)/5
let I_Q_ACCESS_uA = @m.x1.xxm7.m1[id]*1e6
let I_QB_ACCESS_uA = @m.x1.xxm6.m1[id]*1e6
let I_Q_ACCESS_MAG_uA = abs(I_Q_ACCESS_uA)
let I_QB_ACCESS_MAG_uA = abs(I_QB_ACCESS_uA)
meas tran I_Q_ACCESS_PEAK_Q5 max I_Q_ACCESS_MAG_uA from=11n to=15n
meas tran I_QB_ACCESS_PEAK_Q5 max I_QB_ACCESS_MAG_uA from=11n to=15n

* Compare currents at the LOW storage node (Q for Q0, QB for Q5).
let I_LOW_ACCESS_uA = abs(@m.x1.xxm6.m1[id])*1e6
let I_LOW_PULLDOWN_uA = abs(@m.x1.xxm3.m1[id])*1e6
meas tran I_LOW_PULLDOWN_PEAK_Q5 max I_LOW_PULLDOWN_uA from=11n to=15n
plot I_LOW_ACCESS_uA I_LOW_PULLDOWN_uA ylabel 'Current magnitude (uA)' title 'READ STRENGTH: Q5, access versus cell pull-down'

plot PRECHG_T WL_T BL_T BLB_T Q_T QB_T ylimit -0.2 11.2 ydelta 1 title 'READ: Q=5 V, QB=0'
plot I_Q_ACCESS_uA I_QB_ACCESS_uA ylabel 'Access current (uA)' title 'READ current: Q=5 V, QB=0'

.endc"}
C {devices/netlist_options.sym} 930 750 0 0 {name=NETLIST_OPTIONS
lvs_netlist=false
top_is_subckt=false
spiceprefix=true
hiersep=.}
