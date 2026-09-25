v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {TERNARY MUL / 9 INPUT STATES + DC TRANSFER / native ngspice plots} 40 -140 0 0 0.38 0.38 {}
T {27 C; +/-5 V supply; output Cload=10 fF. Expected p=a*b/5 in volts.} 40 -80 0 0 0.24 0.24 {}
C {/home/ishi-kai/balanced-ternary-logic/mul.sym} 420 180 0 0 {name=xdut}
C {devices/lab_pin.sym} 360 160 0 0 {name=l1 lab=a}
C {devices/lab_pin.sym} 360 200 0 0 {name=l2 lab=b}
C {devices/lab_pin.sym} 420 120 0 0 {name=l3 lab=VDD}
C {devices/lab_pin.sym} 420 240 0 0 {name=l4 lab=VSS}
C {devices/lab_pin.sym} 490 180 0 0 {name=l5 lab=p}
C {devices/lab_pin.sym} 490 160 0 0 {name=l6 lab=t1}
C {devices/lab_pin.sym} 490 200 0 0 {name=l7 lab=t3}
N 490 180 720 180 {lab=p}
N 720 180 720 250 {lab=p}
C {devices/capa.sym} 720 280 0 0 {name=Cload value=10f m=1}
C {devices/gnd.sym} 720 310 0 0 {name=l8 lab=GND}
C {devices/vsource.sym} 120 520 0 0 {name=VDD
value="5"
savecurrent=false
hide_texts=true}
C {devices/lab_pin.sym} 120 490 0 0 {name=l9 lab=VDD}
C {devices/gnd.sym} 120 550 0 0 {name=l10 lab=GND}
T {VDD} 150 510 0 0 0.24 0.24 {}
C {devices/vsource.sym} 340 520 0 0 {name=VSS
value="-5"
savecurrent=false
hide_texts=true}
C {devices/lab_pin.sym} 340 490 0 0 {name=l11 lab=VSS}
C {devices/gnd.sym} 340 550 0 0 {name=l12 lab=GND}
T {VSS} 370 510 0 0 0.24 0.24 {}
C {devices/vsource.sym} 560 520 0 0 {name=VA
value="PWL(0 -5 200n -5 201n -5 400n -5 401n -5 600n -5 601n 0 800n 0 801n 0 1000n 0 1001n 0 1200n 0 1201n 5 1400n 5 1401n 5 1600n 5 1601n 5 1800n 5 1801n -5 2000n -5)"
savecurrent=false
hide_texts=true}
C {devices/lab_pin.sym} 560 490 0 0 {name=l13 lab=a}
C {devices/gnd.sym} 560 550 0 0 {name=l14 lab=GND}
T {VA} 590 510 0 0 0.24 0.24 {}
C {devices/vsource.sym} 780 520 0 0 {name=VB
value="PWL(0 -5 200n -5 201n 0 400n 0 401n 5 600n 5 601n -5 800n -5 801n 0 1000n 0 1001n 5 1200n 5 1201n -5 1400n -5 1401n 0 1600n 0 1601n 5 1800n 5 1801n -5 2000n -5)"
savecurrent=false
hide_texts=true}
C {devices/lab_pin.sym} 780 490 0 0 {name=l15 lab=b}
C {devices/gnd.sym} 780 550 0 0 {name=l16 lab=GND}
T {VB} 810 510 0 0 0.24 0.24 {}
T {Edit VA / VB for stimuli; Cload for output load; SIMULATION for analyses.} 40 640 0 0 0.24 0.24 {}
T {RUN: disable LVS -> Netlist -> Simulate. All devices are in child cells.} 40 690 0 0 0.24 0.24 {}
T {SEQUENCE / ns / expected settled voltage} 1110 -100 0 0 0.3 0.3 {}
T {Interval           A        B        P       Sample} 1110 -50 0 0 0.24 0.24 {}
T {   0- 200        -5       -5       +5        199} 1110 0 0 0 0.24 0.24 {}
T { 200- 400        -5       +0       +0        399} 1110 40 0 0 0.24 0.24 {}
T { 400- 600        -5       +5       -5        599} 1110 80 0 0 0.24 0.24 {}
T { 600- 800        +0       -5       +0        799} 1110 120 0 0 0.24 0.24 {}
T { 800-1000        +0       +0       +0        999} 1110 160 0 0 0.24 0.24 {}
T {1000-1200        +0       +5       +0        1199} 1110 200 0 0 0.24 0.24 {}
T {1200-1400        +5       -5       -5        1399} 1110 240 0 0 0.24 0.24 {}
T {1400-1600        +5       +0       +0        1599} 1110 280 0 0 0.24 0.24 {}
T {1600-1800        +5       +5       +5        1799} 1110 320 0 0 0.24 0.24 {}
T {1800-2000        -5       -5       +5        1999} 1110 360 0 0 0.24 0.24 {}
T {1 ns edges. Samples must be within +/-0.5 V of expected.} 1110 450 0 0 0.24 0.24 {}
T {DC: sweep A -5..+5 V for B=-5, 0, +5 V.} 1110 490 0 0 0.24 0.24 {}
T {72 directed transitions, load, skew and margins: scripts/check_mul.py} 1110 530 0 0 0.24 0.24 {}
C {devices/code.sym} 1110 650 0 0 {name=TR_1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"}
C {devices/code.sym} 1410 650 0 0 {name=SIMULATION
only_toplevel=true
value=".temp 27
.options rshunt=1e12
.nodeset v(p)=5 v(t1)=5 v(xdut.t2)=5 v(t3)=-5
.control
save all
set wr_singlescale
set wr_vecnames
setplot const
let failures=0
alter VB dc=-5
dc VA -5 5 0.03125
meas dc dc_0_0 find v(p) at=-5
if abs(dc_0_0-(5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_0_0 expected 5.0 V
end
meas dc dc_0_1 find v(p) at=0
if abs(dc_0_1-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_0_1 expected 0.0 V
end
meas dc dc_0_2 find v(p) at=5
if abs(dc_0_2-(-5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_0_2 expected -5.0 V
end
plot v(a) v(p) ylimit -5.5 5.5 title 'MUL DC: B=-5 V'
wrdata mul_dc_0.txt v(a) v(p) v(t1) v(xdut.t2) v(t3)
alter VB dc=0
dc VA -5 5 0.03125
meas dc dc_1_0 find v(p) at=-5
if abs(dc_1_0-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_1_0 expected 0.0 V
end
meas dc dc_1_1 find v(p) at=0
if abs(dc_1_1-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_1_1 expected 0.0 V
end
meas dc dc_1_2 find v(p) at=5
if abs(dc_1_2-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_1_2 expected 0.0 V
end
plot v(a) v(p) ylimit -5.5 5.5 title 'MUL DC: B=0 V'
wrdata mul_dc_1.txt v(a) v(p) v(t1) v(xdut.t2) v(t3)
alter VB dc=5
dc VA -5 5 0.03125
meas dc dc_2_0 find v(p) at=-5
if abs(dc_2_0-(-5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_2_0 expected -5.0 V
end
meas dc dc_2_1 find v(p) at=0
if abs(dc_2_1-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_2_1 expected 0.0 V
end
meas dc dc_2_2 find v(p) at=5
if abs(dc_2_2-(5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_2_2 expected 5.0 V
end
plot v(a) v(p) ylimit -5.5 5.5 title 'MUL DC: B=5 V'
wrdata mul_dc_2.txt v(a) v(p) v(t1) v(xdut.t2) v(t3)
reset
save all
tran 0.2n 2000n 0 0.5n
meas tran p_0 find v(p) at=199n
if abs(p_0-(5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: p_0 expected 5.0 V
end
meas tran p_1 find v(p) at=399n
if abs(p_1-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: p_1 expected 0.0 V
end
meas tran p_2 find v(p) at=599n
if abs(p_2-(-5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: p_2 expected -5.0 V
end
meas tran p_3 find v(p) at=799n
if abs(p_3-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: p_3 expected 0.0 V
end
meas tran p_4 find v(p) at=999n
if abs(p_4-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: p_4 expected 0.0 V
end
meas tran p_5 find v(p) at=1199n
if abs(p_5-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: p_5 expected 0.0 V
end
meas tran p_6 find v(p) at=1399n
if abs(p_6-(-5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: p_6 expected -5.0 V
end
meas tran p_7 find v(p) at=1599n
if abs(p_7-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: p_7 expected 0.0 V
end
meas tran p_8 find v(p) at=1799n
if abs(p_8-(5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: p_8 expected 5.0 V
end
meas tran p_9 find v(p) at=1999n
if abs(p_9-(5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: p_9 expected 5.0 V
end
plot v(a) v(b) v(p) ylimit -5.5 5.5 title 'MUL: all nine input states'
plot v(t1) v(xdut.t2) v(t3) title 'MUL internal nodes'
wrdata mul_tran.txt v(a) v(b) v(p) v(t1) v(xdut.t2) v(t3)
if const.failures = 0
echo PASS: MUL truth table and transient sequence
else
echo FAIL: MUL truth table and transient sequence
end
print const.failures
.endc"}
C {devices/netlist_options.sym} 1710 650 0 0 {name=NETLIST_OPTIONS
lvs_netlist=false
top_is_subckt=false
spiceprefix=true
hiersep=.}
