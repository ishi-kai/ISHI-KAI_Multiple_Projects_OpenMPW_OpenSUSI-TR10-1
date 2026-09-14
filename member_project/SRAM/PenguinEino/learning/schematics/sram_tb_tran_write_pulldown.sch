v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {6T SRAM | PRECHARGE + PULL-DOWN WRITE} -140 -360 0 0 0.5 0.5 {}
T {5 V / minimum-size cell / Q: 0 -> 1 -> 0} -140 -310 0 0 0.32 0.32 {}
T {1  PRECHARGE (PREB = 0)} -140 -240 0 0 0.35 0.35 {}
T {2  WRITE: only one NMOS ON} -140 460 0 0 0.35 0.35 {}
T {PD_BLB = 1: write Q = 1     |     PD_BL = 1: write Q = 0} -140 500 0 0 0.3 0.3 {}
T {PREB = 1 during write. Lower WL before releasing pull-down.} -140 535 0 0 0.3 0.3 {}
T {3  STIMULUS (select a source and press q to edit its PWL)} -140 620 0 0 0.35 0.35 {}
T {5 V} 25 725 0 0 0.25 0.25 {}
T {PWL} 205 725 0 0 0.25 0.25 {}
T {PWL} 385 725 0 0 0.25 0.25 {}
T {PWL} 565 725 0 0 0.25 0.25 {}
T {PWL} 745 725 0 0 0.25 0.25 {}
T {SEQUENCE / time in ns} 880 -240 0 0 0.35 0.35 {}
T {0 - 20      Precharge BL and BLB} 880 -190 0 0 0.3 0.3 {}
T {25 - 75    Pull BLB low (write 1)} 880 -155 0 0 0.3 0.3 {}
T {35 - 65    WL high} 880 -120 0 0 0.3 0.3 {}
T {90             Check Q = 5 V, QB = 0 V} 880 -85 0 0 0.3 0.3 {}
T {101 - 120  Precharge again} 880 -30 0 0 0.3 0.3 {}
T {125 - 175  Pull BL low (write 0)} 880 5 0 0 0.3 0.3 {}
T {135 - 165  WL high} 880 40 0 0 0.3 0.3 {}
T {190 / 215  Check Q = 0 V, QB = 5 V} 880 75 0 0 0.3 0.3 {}
T {All signal edges: 1 ns} 880 125 0 0 0.27 0.27 {}
T {INITIAL STATE / LOAD} 880 190 0 0 0.35 0.35 {}
T {Initial Q = 0 V, QB = 5 V (IC, no UIC).} 880 235 0 0 0.28 0.28 {}
T {CBL = 10 fF per bitline: assumed load,} 880 270 0 0 0.28 0.28 {}
T {not extracted layout capacitance.} 880 300 0 0 0.28 0.28 {}
T {Cell + write NMOS: W/L = 3.4u / 1u} 880 345 0 0 0.28 0.28 {}
T {Precharge + equalizer: 10.2u / 1u} 880 375 0 0 0.28 0.28 {}
T {RUN: netlist, then simulate in Xschem.} 880 440 0 0 0.3 0.3 {}
T {Plots: cell / bitlines / stacked controls.} 880 475 0 0 0.28 0.28 {}
T {Console: hold voltages, write delays, PASS/FAIL.} 880 510 0 0 0.28 0.28 {}
T {Edit SIMULATION for CBL and measurements.} 880 545 0 0 0.28 0.28 {}
N 0 -200 0 -150 {lab=VDD}
N 0 -120 30 -120 {lab=VDD}
N 0 -90 0 300 {lab=BL}
N 0 360 0 400 {lab=GND}
N 0 330 30 330 {lab=GND}
N 600 -200 600 -150 {lab=VDD}
N 600 -120 630 -120 {lab=VDD}
N 600 -90 600 300 {lab=BLB}
N 600 360 600 400 {lab=GND}
N 600 330 630 330 {lab=GND}
N 0 -50 270 -50 {lab=BL}
N 330 -50 600 -50 {lab=BLB}
N 300 -90 300 -50 {lab=VDD}
N 0 90 150 90 {lab=BL}
N 450 90 600 90 {lab=BLB}
N 450 110 490 110 {lab=Q}
N 450 130 490 130 {lab=QB}
N 450 150 490 150 {lab=VDD}
N 450 170 490 170 {lab=GND}
N 300 200 300 230 {lab=WL}
N 0 260 100 260 {lab=BL}
N 100 260 100 280 {lab=BL}
N 100 340 100 400 {lab=GND}
N 600 260 700 260 {lab=BLB}
N 700 260 700 280 {lab=BLB}
N 700 340 700 400 {lab=GND}
N 0 670 0 710 {lab=VDD}
N 0 770 0 800 {lab=GND}
N 180 670 180 710 {lab=PREB}
N 180 770 180 800 {lab=GND}
N 360 670 360 710 {lab=WL}
N 360 770 360 800 {lab=GND}
N 540 670 540 710 {lab=PD_BL}
N 540 770 540 800 {lab=GND}
N 720 670 720 710 {lab=PD_BLB}
N 720 770 720 800 {lab=GND}
C {TR-1umLIB/MP.sym} -40 -120 0 0 {name=XP_BL
model=PMOS
w=10.2u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {devices/lab_pin.sym} 0 -200 0 0 {name=l12 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 30 -120 2 0 {name=l14 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 0 0 0 0 {name=l17 sig_type=std_logic lab=BL}
C {TR-1umLIB/MN.sym} -40 330 0 0 {name=XW_BL
model=NMOS
w=3.4u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {devices/lab_pin.sym} -40 330 0 0 {name=l19 sig_type=std_logic lab=PD_BL}
C {devices/gnd.sym} 0 400 0 0 {name=g21 lab=GND}
C {devices/lab_pin.sym} 30 330 2 0 {name=l23 sig_type=std_logic lab=GND}
C {TR-1umLIB/MP.sym} 560 -120 0 0 {name=XP_BLB
model=PMOS
w=10.2u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {devices/lab_pin.sym} 600 -200 0 0 {name=l26 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 630 -120 2 0 {name=l28 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 560 -120 0 0 {name=l29 sig_type=std_logic lab=PREB}
C {devices/lab_pin.sym} 600 0 0 0 {name=l31 sig_type=std_logic lab=BLB}
C {TR-1umLIB/MN.sym} 560 330 0 0 {name=XW_BLB
model=NMOS
w=3.4u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {devices/lab_pin.sym} 560 330 0 0 {name=l33 sig_type=std_logic lab=PD_BLB}
C {devices/gnd.sym} 600 400 0 0 {name=g35 lab=GND}
C {devices/lab_pin.sym} 630 330 2 0 {name=l37 sig_type=std_logic lab=GND}
C {TR-1umLIB/MP.sym} 300 -10 1 1 {name=XP_EQ
model=PMOS
w=10.2u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {devices/lab_pin.sym} 300 -90 2 0 {name=l42 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 300 -10 2 0 {name=l43 sig_type=std_logic lab=PREB}
C {sram.sym} 300 120 0 0 {name=xcell}
C {devices/lab_pin.sym} 490 110 2 0 {name=l48 sig_type=std_logic lab=Q}
C {devices/lab_pin.sym} 490 130 2 0 {name=l50 sig_type=std_logic lab=QB}
C {devices/lab_pin.sym} 490 150 2 0 {name=l52 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 490 170 2 0 {name=l54 sig_type=std_logic lab=GND}
C {devices/lab_pin.sym} 300 230 2 0 {name=l56 sig_type=std_logic lab=WL}
C {devices/capa.sym} 100 310 0 0 {name=CBL
m=1
value='CBL'}
C {devices/gnd.sym} 100 400 0 0 {name=g61 lab=GND}
C {devices/capa.sym} 700 310 0 0 {name=CBLB
m=1
value='CBL'}
C {devices/gnd.sym} 700 400 0 0 {name=g66 lab=GND}
C {devices/vsource.sym} 0 740 0 0 {name=VVDD
value="5"
savecurrent=false
hide_texts=true}
C {devices/lab_pin.sym} 0 670 2 0 {name=l73 sig_type=std_logic lab=VDD}
C {devices/gnd.sym} 0 800 0 0 {name=g75 lab=GND}
C {devices/vsource.sym} 180 740 0 0 {name=VPREB
value="PWL(0 0 20n 0 21n 5 100n 5 101n 0 120n 0 121n 5 220n 5)"
savecurrent=false
hide_texts=true}
C {devices/lab_pin.sym} 180 670 2 0 {name=l79 sig_type=std_logic lab=PREB}
C {devices/gnd.sym} 180 800 0 0 {name=g81 lab=GND}
C {devices/vsource.sym} 360 740 0 0 {name=VWL
value="PWL(0 0 35n 0 36n 5 65n 5 66n 0 135n 0 136n 5 165n 5 166n 0 220n 0)"
savecurrent=false
hide_texts=true}
C {devices/lab_pin.sym} 360 670 2 0 {name=l85 sig_type=std_logic lab=WL}
C {devices/gnd.sym} 360 800 0 0 {name=g87 lab=GND}
C {devices/vsource.sym} 540 740 0 0 {name=VPD_BL
value="PWL(0 0 125n 0 126n 5 175n 5 176n 0 220n 0)"
savecurrent=false
hide_texts=true}
C {devices/lab_pin.sym} 540 670 2 0 {name=l91 sig_type=std_logic lab=PD_BL}
C {devices/gnd.sym} 540 800 0 0 {name=g93 lab=GND}
C {devices/vsource.sym} 720 740 0 0 {name=VPD_BLB
value="PWL(0 0 25n 0 26n 5 75n 5 76n 0 220n 0)"
savecurrent=false
hide_texts=true}
C {devices/lab_pin.sym} 720 670 2 0 {name=l97 sig_type=std_logic lab=PD_BLB}
C {devices/gnd.sym} 720 800 0 0 {name=g99 lab=GND}
C {devices/code.sym} 920 680 0 0 {name=TR_1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"}
C {devices/code.sym} 1210 680 0 0 {name=SIMULATION
only_toplevel=true
value=".param CBL=10f
.ic v(Q)=0 v(QB)=5
.control
save all
tran 0.05n 220n
meas tran q_initial find v(Q) at=19n
meas tran qb_initial find v(QB) at=19n
meas tran q_hold_1 find v(Q) at=90n
meas tran qb_hold_1 find v(QB) at=90n
meas tran q_hold_0 find v(Q) at=190n
meas tran qb_hold_0 find v(QB) at=190n
meas tran q_final find v(Q) at=215n
meas tran qb_final find v(QB) at=215n
meas tran t_write_1 trig v(WL) val=2.5 rise=1 targ v(Q) val=2.5 rise=1
meas tran t_write_0 trig v(WL) val=2.5 rise=2 targ v(Q) val=2.5 fall=1 td=120n
if q_initial < 0.5 and qb_initial > 4.5 and q_hold_1 > 4.5 and qb_hold_1 < 0.5 and q_hold_0 < 0.5 and qb_hold_0 > 4.5 and q_final < 0.5 and qb_final > 4.5
  echo PASS: initial state, write 1, write 0 and hold checks
else
  echo FAIL: inspect Q/QB and bitline plots
end
let PREB_trace = v(PREB)/5+6
let WL_trace = v(WL)/5+4
let PD_BL_trace = v(PD_BL)/5+2
let PD_BLB_trace = v(PD_BLB)/5
write sram_tb_tran_write_pulldown.raw
plot v(Q) v(QB) ylimit -0.5 5.5 title 'CELL: Q 0 -> 1 -> 0; hold checks at 90/190/215 ns'
plot v(BL) v(BLB) ylimit -0.5 5.5 title 'BITLINES: precharged, then only one side pulled low'
plot PREB_trace WL_trace PD_BL_trace PD_BLB_trace ylimit -0.3 7.3 title 'CONTROLS: PREB +6 / WL +4 / PD_BL +2 / PD_BLB +0 (normalized)'
.endc"}
C {devices/lab_pin.sym} -40 -120 0 0 {name=l15 sig_type=std_logic lab=PREB}
C {devices/netlist_options.sym} 930 890 0 0 {name=NETLIST_OPTIONS
lvs_netlist=false
top_is_subckt=false
spiceprefix=true
hiersep=.}
