v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {TERNARY LATCH / 3 STATES + FINITE DISTURBANCE / standalone stability TB} 40 -140 0 0 0.38 0.38 {}
T {27 C; VDD=+5 V; VSS=-5 V; 10 fF per storage node (TB only).} 40 -80 0 0 0.24 0.24 {}
C {/home/ishi-kai/balanced-ternary-logic/ternary_latch.sym} 240 140 0 0 {name=x0}
N 120 140 80 140 {lab=q0}
C {devices/lab_pin.sym} 80 140 0 0 {name=l1 lab=q0}
N 360 140 400 140 {lab=qb0}
C {devices/lab_pin.sym} 400 140 0 1 {name=l2 lab=qb0}
N 240 20 240 0 {lab=VDD}
C {devices/lab_pin.sym} 240 0 0 0 {name=l3 lab=VDD}
N 240 240 240 260 {lab=VSS}
C {devices/lab_pin.sym} 240 260 0 0 {name=l4 lab=VSS}
C {devices/capa.sym} 140 340 0 0 {name=CQ0 value=10f m=1}
C {devices/lab_pin.sym} 140 310 0 0 {name=l5 lab=q0}
C {devices/gnd.sym} 140 370 0 0 {name=l6 lab=GND}
C {devices/capa.sym} 340 340 0 0 {name=CQB0 value=10f m=1}
C {devices/lab_pin.sym} 340 310 0 0 {name=l7 lab=qb0}
C {devices/gnd.sym} 340 370 0 0 {name=l8 lab=GND}
C {devices/isource.sym} 140 530 0 0 {name=IK0
value="PWL(0 0 200n 0 201n 5u 211n 5u 212n 0 500n 0 501n -5u 511n -5u 512n 0 1u 0)"
savecurrent=false
hide_texts=true}
C {devices/lab_pin.sym} 140 500 0 0 {name=l9 lab=q0}
C {devices/lab_pin.sym} 140 560 0 0 {name=l10 lab=qb0}
T {IK0} 170 520 0 0 0.24 0.24 {}
T {IK0: Q -> QB, +/-5 uA} 95 600 0 0 0.24 0.24 {}
C {/home/ishi-kai/balanced-ternary-logic/ternary_latch.sym} 660 140 0 0 {name=x1}
N 540 140 500 140 {lab=q1}
C {devices/lab_pin.sym} 500 140 0 0 {name=l11 lab=q1}
N 780 140 820 140 {lab=qb1}
C {devices/lab_pin.sym} 820 140 0 1 {name=l12 lab=qb1}
N 660 20 660 0 {lab=VDD}
C {devices/lab_pin.sym} 660 0 0 0 {name=l13 lab=VDD}
N 660 240 660 260 {lab=VSS}
C {devices/lab_pin.sym} 660 260 0 0 {name=l14 lab=VSS}
C {devices/capa.sym} 560 340 0 0 {name=CQ1 value=10f m=1}
C {devices/lab_pin.sym} 560 310 0 0 {name=l15 lab=q1}
C {devices/gnd.sym} 560 370 0 0 {name=l16 lab=GND}
C {devices/capa.sym} 760 340 0 0 {name=CQB1 value=10f m=1}
C {devices/lab_pin.sym} 760 310 0 0 {name=l17 lab=qb1}
C {devices/gnd.sym} 760 370 0 0 {name=l18 lab=GND}
C {devices/isource.sym} 560 530 0 0 {name=IK1
value="PWL(0 0 200n 0 201n 5u 211n 5u 212n 0 500n 0 501n -5u 511n -5u 512n 0 1u 0)"
savecurrent=false
hide_texts=true}
C {devices/lab_pin.sym} 560 500 0 0 {name=l19 lab=q1}
C {devices/lab_pin.sym} 560 560 0 0 {name=l20 lab=qb1}
T {IK1} 590 520 0 0 0.24 0.24 {}
T {IK1: Q -> QB, +/-5 uA} 515 600 0 0 0.24 0.24 {}
C {/home/ishi-kai/balanced-ternary-logic/ternary_latch.sym} 1080 140 0 0 {name=x2}
N 960 140 920 140 {lab=q2}
C {devices/lab_pin.sym} 920 140 0 0 {name=l21 lab=q2}
N 1200 140 1240 140 {lab=qb2}
C {devices/lab_pin.sym} 1240 140 0 1 {name=l22 lab=qb2}
N 1080 20 1080 0 {lab=VDD}
C {devices/lab_pin.sym} 1080 0 0 0 {name=l23 lab=VDD}
N 1080 240 1080 260 {lab=VSS}
C {devices/lab_pin.sym} 1080 260 0 0 {name=l24 lab=VSS}
C {devices/capa.sym} 980 340 0 0 {name=CQ2 value=10f m=1}
C {devices/lab_pin.sym} 980 310 0 0 {name=l25 lab=q2}
C {devices/gnd.sym} 980 370 0 0 {name=l26 lab=GND}
C {devices/capa.sym} 1180 340 0 0 {name=CQB2 value=10f m=1}
C {devices/lab_pin.sym} 1180 310 0 0 {name=l27 lab=qb2}
C {devices/gnd.sym} 1180 370 0 0 {name=l28 lab=GND}
C {devices/isource.sym} 980 530 0 0 {name=IK2
value="PWL(0 0 200n 0 201n 5u 211n 5u 212n 0 500n 0 501n -5u 511n -5u 512n 0 1u 0)"
savecurrent=false
hide_texts=true}
C {devices/lab_pin.sym} 980 500 0 0 {name=l29 lab=q2}
C {devices/lab_pin.sym} 980 560 0 0 {name=l30 lab=qb2}
T {IK2} 1010 520 0 0 0.24 0.24 {}
T {IK2: Q -> QB, +/-5 uA} 935 600 0 0 0.24 0.24 {}
C {devices/vsource.sym} 120 770 0 0 {name=VDD
value="5"
savecurrent=false
hide_texts=true}
C {devices/lab_pin.sym} 120 740 0 0 {name=l31 lab=VDD}
C {devices/gnd.sym} 120 800 0 0 {name=l32 lab=GND}
T {VDD} 150 760 0 0 0.24 0.24 {}
C {devices/vsource.sym} 360 770 0 0 {name=VSS
value="-5"
savecurrent=false
hide_texts=true}
C {devices/lab_pin.sym} 360 740 0 0 {name=l33 lab=VSS}
C {devices/gnd.sym} 360 800 0 0 {name=l34 lab=GND}
T {VSS} 390 760 0 0 0.24 0.24 {}
T {SEQUENCE / ns} 1510 -80 0 0 0.3 0.3 {}
T {Initial Q/QB: -4.5/+4.5, +0.5/-0.5, +4.5/-4.5 V} 1510 -30 0 0 0.24 0.24 {}
T {0-199: release perturbed initial state; settle} 1510 18 0 0 0.24 0.24 {}
T {200-212: +5 uA Q-to-QB disturbance (1 ns edges)} 1510 66 0 0 0.24 0.24 {}
T {212-499: recover and retain} 1510 114 0 0 0.24 0.24 {}
T {500-512: -5 uA Q-to-QB disturbance (1 ns edges)} 1510 162 0 0 0.24 0.24 {}
T {512-1000: recover and retain} 1510 210 0 0 0.24 0.24 {}
T {Samples: 199 / 499 / 999 ns; tolerance +/-0.5 V} 1510 258 0 0 0.24 0.24 {}
T {Expect Q/QB = -5/+5, 0/0, +5/-5 V.} 1510 306 0 0 0.24 0.24 {}
T {.ic sets only startup; no source clamps the stored voltage.} 1510 354 0 0 0.24 0.24 {}
T {RUN: Netlist -> Simulate. Native ngspice plots.} 1510 402 0 0 0.24 0.24 {}
C {devices/code.sym} 1510 590 0 0 {name=TR_1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"}
C {devices/code.sym} 1810 590 0 0 {name=SIMULATION
only_toplevel=true
value=".temp 27
.ic v(q0)=-4.5 v(qb0)=4.5 v(q1)=0.5 v(qb1)=-0.5 v(q2)=4.5 v(qb2)=-4.5
.control
save all
set wr_singlescale
set wr_vecnames
setplot const
let failures=0
tran 0.2n 1000n 0 0.5n
meas tran q0_199 find v(q0) at=199n
if abs(q0_199-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: q0_199 expected -5 V
end
meas tran qb0_199 find v(qb0) at=199n
if abs(qb0_199-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: qb0_199 expected 5 V
end
meas tran q0_499 find v(q0) at=499n
if abs(q0_499-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: q0_499 expected -5 V
end
meas tran qb0_499 find v(qb0) at=499n
if abs(qb0_499-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: qb0_499 expected 5 V
end
meas tran q0_999 find v(q0) at=999n
if abs(q0_999-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: q0_999 expected -5 V
end
meas tran qb0_999 find v(qb0) at=999n
if abs(qb0_999-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: qb0_999 expected 5 V
end
plot v(q0) v(qb0) ylimit -5.5 5.5 title 'Latch: stored Q=-5 V, perturb and recover'
meas tran q1_199 find v(q1) at=199n
if abs(q1_199-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: q1_199 expected 0 V
end
meas tran qb1_199 find v(qb1) at=199n
if abs(qb1_199-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: qb1_199 expected 0 V
end
meas tran q1_499 find v(q1) at=499n
if abs(q1_499-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: q1_499 expected 0 V
end
meas tran qb1_499 find v(qb1) at=499n
if abs(qb1_499-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: qb1_499 expected 0 V
end
meas tran q1_999 find v(q1) at=999n
if abs(q1_999-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: q1_999 expected 0 V
end
meas tran qb1_999 find v(qb1) at=999n
if abs(qb1_999-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: qb1_999 expected 0 V
end
plot v(q1) v(qb1) ylimit -5.5 5.5 title 'Latch: stored Q=0 V, perturb and recover'
meas tran q2_199 find v(q2) at=199n
if abs(q2_199-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: q2_199 expected 5 V
end
meas tran qb2_199 find v(qb2) at=199n
if abs(qb2_199-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: qb2_199 expected -5 V
end
meas tran q2_499 find v(q2) at=499n
if abs(q2_499-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: q2_499 expected 5 V
end
meas tran qb2_499 find v(qb2) at=499n
if abs(qb2_499-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: qb2_499 expected -5 V
end
meas tran q2_999 find v(q2) at=999n
if abs(q2_999-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: q2_999 expected 5 V
end
meas tran qb2_999 find v(qb2) at=999n
if abs(qb2_999-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: qb2_999 expected -5 V
end
plot v(q2) v(qb2) ylimit -5.5 5.5 title 'Latch: stored Q=5 V, perturb and recover'
wrdata ternary_latch_hold.txt v(q0) v(qb0) v(q1) v(qb1) v(q2) v(qb2)
if const.failures = 0
echo PASS: three-state hold and disturbance recovery
else
echo FAIL: three-state hold and disturbance recovery
end
print const.failures
.endc"}
C {devices/netlist_options.sym} 2110 590 0 0 {name=NETLIST_OPTIONS
lvs_netlist=false
top_is_subckt=false
spiceprefix=true
hiersep=.}
