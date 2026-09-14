v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {6T SRAM | IDEAL-DRIVE WRITE: 0 -> 1 -> 0} -100 -340 0 0 0.42 0.42 {}
T {5 V / cell W/L = 3.4u / 1u / sram_tb_tran_write.sch} -100 -290 0 0 0.27 0.27 {}
T {1  CELL / LABELED CONNECTIONS} -100 -220 0 0 0.34 0.34 {}
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
T {BL and BLB are driven by ideal voltage sources.} -100 310 0 0 0.28 0.28 {}
T {Named labels connect the cell to the sources below.} -100 350 0 0 0.28 0.28 {}
T {2  STIMULUS / select a source and press q to edit} -100 440 0 0 0.34 0.34 {}
C {devices/vsource.sym} 0 580 0 0 {name=Vdd
value=5.0
savecurrent=false
hide_texts=true}
N 0 510 0 550 {lab=VDD}
C {devices/lab_pin.sym} 0 510 2 0 {name=l30 lab=VDD}
N 0 610 0 650 {lab=GND}
C {devices/gnd.sym} 0 650 0 0 {name=g32 lab=GND}
T {5.0 V} 28 570 0 0 0.26 0.26 {}
C {devices/vsource.sym} 210 580 0 0 {name=VBL
value="PWL(0 5 20n 5 20.1n 0 50n 0)"
savecurrent=false
hide_texts=true}
N 210 510 210 550 {lab=BL}
C {devices/lab_pin.sym} 210 510 2 0 {name=l36 lab=BL}
N 210 610 210 650 {lab=GND}
C {devices/gnd.sym} 210 650 0 0 {name=g38 lab=GND}
T {PWL} 238 570 0 0 0.26 0.26 {}
C {devices/vsource.sym} 420 580 0 0 {name=VBLB
value="PWL(0 0 20n 0 20.1n 5 50n 5)"
savecurrent=false
hide_texts=true}
N 420 510 420 550 {lab=BLB}
C {devices/lab_pin.sym} 420 510 2 0 {name=l42 lab=BLB}
N 420 610 420 650 {lab=GND}
C {devices/gnd.sym} 420 650 0 0 {name=g44 lab=GND}
T {PWL} 448 570 0 0 0.26 0.26 {}
C {devices/vsource.sym} 630 580 0 0 {name=VWL
value="PULSE(0 5 5n 0.1n 0.1n 10n 20n)"
savecurrent=false
hide_texts=true}
N 630 510 630 550 {lab=WL}
C {devices/lab_pin.sym} 630 510 2 0 {name=l48 lab=WL}
N 630 610 630 650 {lab=GND}
C {devices/gnd.sym} 630 650 0 0 {name=g50 lab=GND}
T {PULSE} 658 570 0 0 0.26 0.26 {}
T {SEQUENCE / time in ns} 930 -220 0 0 0.32 0.32 {}
T {Initial Q = 0 V, QB = 5 V} 930 -180 0 0 0.27 0.27 {}
T {0 - 20      BL = 5 V, BLB = 0 V} 930 -140 0 0 0.27 0.27 {}
T {5 - 15      WL high: write Q = 1} 930 -100 0 0 0.27 0.27 {}
T {19             Measure hold after write 1} 930 -60 0 0 0.27 0.27 {}
T {20 - 20.1  Reverse BL / BLB} 930 -20 0 0 0.27 0.27 {}
T {25 - 35    WL high: write Q = 0} 930 20 0 0 0.27 0.27 {}
T {45             Measure Q / QB} 930 60 0 0 0.27 0.27 {}
T {45 - 50    Third WL pulse: same data} 930 100 0 0 0.27 0.27 {}
T {Original PWL / PULSE timings retained.} 930 180 0 0 0.27 0.27 {}
T {RUN / netlist, then simulate in Xschem} 930 290 0 0 0.3 0.3 {}
T {Edit SIMULATION for analysis and measurements.} 930 335 0 0 0.27 0.27 {}
T {Waveforms open after simulation.} 930 375 0 0 0.27 0.27 {}
C {devices/code.sym} 960 520 0 0 {name=TR_1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"}
C {devices/code.sym} 1270 520 0 0 {name=SIMULATION
only_toplevel=true
value=".ic v(Q) = 0 v(QB)=5

.control
save all

tran 0.05n 50n

meas tran T_write_5 trig v(WL) val=2.5 rise=1 targ v(Q) val=2.5 rise=1
meas tran Q_hold_5 find v(Q) at=19n
meas tran QB_hold_5 find v(QB) at=19n
meas tran T_write_0 trig v(WL) val=2.5 rise=2 targ v(Q) val=2.5 fall=1
meas tran Q_hold_0 find v(Q) at=45n
meas tran QB_hold_0 find v(QB) at=45n

plot v(Q) v(QB) ylimit -0.5 5.5 title 'CELL: ideal-drive write 1 then write 0'
plot v(BL) v(BLB) ylimit -0.5 5.5 title 'BITLINES: ideal voltage sources'
plot v(WL) ylimit -0.5 5.5 title 'WORD LINE'
.endc"}
C {devices/netlist_options.sym} 930 750 0 0 {name=NETLIST_OPTIONS
lvs_netlist=false
top_is_subckt=false
spiceprefix=true
hiersep=.}
