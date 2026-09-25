v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {BALANCED TERNARY HALF ADDER / SUM + CARRY} 40 -180 0 0 0.4 0.4 {}
T {a + b = sum + 3*carry / NANY x5 + INV x2 / shared T and carry} 40 -125 0 0 0.25 0.25 {}
T {27 C / +/-5 V supplies / VMID = GND / 10 fF on EACH output} 40 -80 0 0 0.25 0.25 {}
C {/home/ishi-kai/balanced-ternary-logic/half_adder.sym} 400 160 0 0 {name=xdut}
N 200 140 310 140 {lab=a}
C {devices/lab_pin.sym} 200 140 0 0 {name=l101 lab=a}
N 200 180 310 180 {lab=b}
C {devices/lab_pin.sym} 200 180 0 0 {name=l102 lab=b}
C {devices/lab_pin.sym} 400 80 0 0 {name=l103 lab=VDD}
C {devices/lab_pin.sym} 400 240 0 0 {name=l104 lab=VSS}
N 430 260 430 340 {lab=VMID}
C {devices/lab_pin.sym} 430 340 0 0 {name=midlabel lab=VMID}
N 490 140 720 140 {lab=sum}
C {devices/lab_pin.sym} 720 140 0 0 {name=l105 lab=sum}
N 720 140 720 290 {lab=sum}
C {devices/capa.sym} 720 320 0 0 {name=Csum value=10f m=1}
C {devices/gnd.sym} 720 350 0 0 {name=gsum lab=GND}
N 490 180 960 180 {lab=carry}
C {devices/lab_pin.sym} 960 180 0 0 {name=l106 lab=carry}
N 960 180 960 290 {lab=carry}
C {devices/capa.sym} 960 320 0 0 {name=Ccarry value=10f m=1}
C {devices/gnd.sym} 960 350 0 0 {name=gcarry lab=GND}
T {CARRY drives two internal NANY inputs AND the external load.} 40 415 0 0 0.25 0.25 {}
C {devices/vsource.sym} 120 540 0 0 {name=VDD value="5" savecurrent=false hide_texts=true}
C {devices/lab_pin.sym} 120 510 0 0 {name=l107 lab=VDD}
C {devices/gnd.sym} 120 570 0 0 {name=gVDD lab=GND}
T {VDD} 95 615 0 0 0.25 0.25 {}
C {devices/vsource.sym} 340 540 0 0 {name=VSS value="-5" savecurrent=false hide_texts=true}
C {devices/lab_pin.sym} 340 510 0 0 {name=l108 lab=VSS}
C {devices/gnd.sym} 340 570 0 0 {name=gVSS lab=GND}
T {VSS} 315 615 0 0 0.25 0.25 {}
C {devices/vsource.sym} 560 540 0 0 {name=VA value="PWL(0 -5 200n -5 201n -5 400n -5 401n -5 600n -5 601n 0 800n 0 801n 0 1000n 0 1001n 0 1200n 0 1201n 5 1400n 5 1401n 5 1600n 5 1601n 5 1800n 5 1801n -5 2000n -5)" savecurrent=false hide_texts=true}
C {devices/lab_pin.sym} 560 510 0 0 {name=l109 lab=a}
C {devices/gnd.sym} 560 570 0 0 {name=gVA lab=GND}
T {VA} 535 615 0 0 0.25 0.25 {}
C {devices/vsource.sym} 780 540 0 0 {name=VB value="PWL(0 -5 200n -5 201n 0 400n 0 401n 5 600n 5 601n -5 800n -5 801n 0 1000n 0 1001n 5 1200n 5 1201n -5 1400n -5 1401n 0 1600n 0 1601n 5 1800n 5 1801n -5 2000n -5)" savecurrent=false hide_texts=true}
C {devices/lab_pin.sym} 780 510 0 0 {name=l110 lab=b}
C {devices/gnd.sym} 780 570 0 0 {name=gVB lab=GND}
T {VB} 755 615 0 0 0.25 0.25 {}
T {SEQUENCE / ns and volts / 200 ns slots / 1 ns edges} 1220 -170 0 0 0.3 0.3 {}
T {Interval           A     B      SUM   CARRY       Sample} 1220 -120 0 0 0.25 0.25 {}
T {   0- 200       -5    -5       +5      -5              199} 1220 -70 0 0 0.24 0.24 {}
T { 201- 400       -5    +0       -5      +0              399} 1220 -30 0 0 0.24 0.24 {}
T { 401- 600       -5    +5       +0      +0              599} 1220 10 0 0 0.24 0.24 {}
T { 601- 800       +0    -5       -5      +0              799} 1220 50 0 0 0.24 0.24 {}
T { 801-1000       +0    +0       +0      +0              999} 1220 90 0 0 0.24 0.24 {}
T {1001-1200       +0    +5       +5      +0              1199} 1220 130 0 0 0.24 0.24 {}
T {1201-1400       +5    -5       +0      +0              1399} 1220 170 0 0 0.24 0.24 {}
T {1401-1600       +5    +0       +5      +0              1599} 1220 210 0 0 0.24 0.24 {}
T {1601-1800       +5    +5       -5      +5              1799} 1220 250 0 0 0.24 0.24 {}
T {1801-2000       -5    -5       +5      -5              1999} 1220 290 0 0 0.24 0.24 {}
T {Nine pairs, then return to (-5,-5).} 1220 410 0 0 0.25 0.25 {}
T {Check T/U/NA/CARRY/D/ND/SUM against ideal logic, +/-0.5 V.} 1220 455 0 0 0.25 0.25 {}
T {Internal nodes: xdut.t / xdut.u / xdut.na / xdut.d / xdut.nd} 40 705 0 0 0.25 0.25 {}
T {DC: sweep A -5..+5 V; B = -5/0/+5 V.} 40 750 0 0 0.25 0.25 {}
T {RUN: disable LVS -> Netlist -> Simulate; native voltage plots.} 40 805 0 0 0.27 0.27 {}
T {Edit VA/VB for sequence; Csum/Ccarry for loads; SIMULATION for tests.} 40 855 0 0 0.25 0.25 {}
C {devices/code.sym} 1220 870 0 0 {name=MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"}
C {devices/code.sym} 1530 870 0 0 {name=SIMULATION
only_toplevel=true
value=".temp 27
.options rshunt=1e12
.param ha_cseed=-5 ha_sseed=5
.nodeset v(xdut.t)=5 v(xdut.u)=0 v(xdut.na)=5 v(carry)=\{ha_cseed\} v(xdut.d)=0 v(xdut.nd)=0 v(sum)=\{ha_sseed\}
.nodeset v(xdut.x_t.net1)=5 v(xdut.x_t.net2)=5 v(xdut.x_t.net3)=-5 v(xdut.x_t.net4)=-5 v(xdut.x_t.net5)=0 v(xdut.x_t.net6)=0
.nodeset v(xdut.x_u.net1)=5 v(xdut.x_u.net2)=5 v(xdut.x_u.net3)=-5 v(xdut.x_u.net4)=-5 v(xdut.x_u.net5)=0 v(xdut.x_u.net6)=0
.nodeset v(xdut.x_c.net1)=5 v(xdut.x_c.net2)=5 v(xdut.x_c.net3)=-5 v(xdut.x_c.net4)=-5 v(xdut.x_c.net5)=0 v(xdut.x_c.net6)=0
.nodeset v(xdut.x_d.net1)=5 v(xdut.x_d.net2)=5 v(xdut.x_d.net3)=-5 v(xdut.x_d.net4)=-5 v(xdut.x_d.net5)=0 v(xdut.x_d.net6)=0
.nodeset v(xdut.x_s.net1)=5 v(xdut.x_s.net2)=5 v(xdut.x_s.net3)=-5 v(xdut.x_s.net4)=-5 v(xdut.x_s.net5)=0 v(xdut.x_s.net6)=0
.nodeset v(xdut.x_na.net1)=5 v(xdut.x_na.net2)=-5
.nodeset v(xdut.x_nd.net1)=5 v(xdut.x_nd.net2)=-5
.control
save all
set wr_singlescale
set wr_vecnames
setplot const
let failures=0
alterparam ha_cseed=-5
alterparam ha_sseed=5
reset
alter VB -5
dc VA -5 5 0.015625
meas dc dc_0_0_xdut_t find v(xdut.t) at=-5
if abs(dc_0_0_xdut_t-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_0_0_xdut_t expected 5 V
end
meas dc dc_0_0_xdut_u find v(xdut.u) at=-5
if abs(dc_0_0_xdut_u-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_0_0_xdut_u expected 0 V
end
meas dc dc_0_0_xdut_na find v(xdut.na) at=-5
if abs(dc_0_0_xdut_na-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_0_0_xdut_na expected 5 V
end
meas dc dc_0_0_carry find v(carry) at=-5
if abs(dc_0_0_carry-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_0_0_carry expected -5 V
end
meas dc dc_0_0_xdut_d find v(xdut.d) at=-5
if abs(dc_0_0_xdut_d-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_0_0_xdut_d expected 0 V
end
meas dc dc_0_0_xdut_nd find v(xdut.nd) at=-5
if abs(dc_0_0_xdut_nd-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_0_0_xdut_nd expected 0 V
end
meas dc dc_0_0_sum find v(sum) at=-5
if abs(dc_0_0_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_0_0_sum expected 5 V
end
meas dc dc_0_1_xdut_t find v(xdut.t) at=0
if abs(dc_0_1_xdut_t-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_0_1_xdut_t expected 5 V
end
meas dc dc_0_1_xdut_u find v(xdut.u) at=0
if abs(dc_0_1_xdut_u-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_0_1_xdut_u expected 0 V
end
meas dc dc_0_1_xdut_na find v(xdut.na) at=0
if abs(dc_0_1_xdut_na-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_0_1_xdut_na expected 0 V
end
meas dc dc_0_1_carry find v(carry) at=0
if abs(dc_0_1_carry-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_0_1_carry expected 0 V
end
meas dc dc_0_1_xdut_d find v(xdut.d) at=0
if abs(dc_0_1_xdut_d-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_0_1_xdut_d expected -5 V
end
meas dc dc_0_1_xdut_nd find v(xdut.nd) at=0
if abs(dc_0_1_xdut_nd-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_0_1_xdut_nd expected 5 V
end
meas dc dc_0_1_sum find v(sum) at=0
if abs(dc_0_1_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_0_1_sum expected -5 V
end
meas dc dc_0_2_xdut_t find v(xdut.t) at=5
if abs(dc_0_2_xdut_t-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_0_2_xdut_t expected 0 V
end
meas dc dc_0_2_xdut_u find v(xdut.u) at=5
if abs(dc_0_2_xdut_u-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_0_2_xdut_u expected 5 V
end
meas dc dc_0_2_xdut_na find v(xdut.na) at=5
if abs(dc_0_2_xdut_na-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_0_2_xdut_na expected -5 V
end
meas dc dc_0_2_carry find v(carry) at=5
if abs(dc_0_2_carry-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_0_2_carry expected 0 V
end
meas dc dc_0_2_xdut_d find v(xdut.d) at=5
if abs(dc_0_2_xdut_d-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_0_2_xdut_d expected 0 V
end
meas dc dc_0_2_xdut_nd find v(xdut.nd) at=5
if abs(dc_0_2_xdut_nd-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_0_2_xdut_nd expected 0 V
end
meas dc dc_0_2_sum find v(sum) at=5
if abs(dc_0_2_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_0_2_sum expected 0 V
end
plot v(a) v(sum) v(carry) ylimit -5.5 5.5 title 'Half Adder DC: B=-5 V'
wrdata half_adder_dc_b0.txt v(a) v(b) v(xdut.t) v(xdut.u) v(xdut.na) v(carry) v(xdut.d) v(xdut.nd) v(sum)
alterparam ha_cseed=0
alterparam ha_sseed=0
reset
alter VB 0
dc VA -5 5 0.015625
meas dc dc_1_0_xdut_t find v(xdut.t) at=-5
if abs(dc_1_0_xdut_t-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_1_0_xdut_t expected 5 V
end
meas dc dc_1_0_xdut_u find v(xdut.u) at=-5
if abs(dc_1_0_xdut_u-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_1_0_xdut_u expected -5 V
end
meas dc dc_1_0_xdut_na find v(xdut.na) at=-5
if abs(dc_1_0_xdut_na-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_1_0_xdut_na expected 5 V
end
meas dc dc_1_0_carry find v(carry) at=-5
if abs(dc_1_0_carry-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_1_0_carry expected 0 V
end
meas dc dc_1_0_xdut_d find v(xdut.d) at=-5
if abs(dc_1_0_xdut_d-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_1_0_xdut_d expected -5 V
end
meas dc dc_1_0_xdut_nd find v(xdut.nd) at=-5
if abs(dc_1_0_xdut_nd-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_1_0_xdut_nd expected 5 V
end
meas dc dc_1_0_sum find v(sum) at=-5
if abs(dc_1_0_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_1_0_sum expected -5 V
end
meas dc dc_1_1_xdut_t find v(xdut.t) at=0
if abs(dc_1_1_xdut_t-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_1_1_xdut_t expected 0 V
end
meas dc dc_1_1_xdut_u find v(xdut.u) at=0
if abs(dc_1_1_xdut_u-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_1_1_xdut_u expected 0 V
end
meas dc dc_1_1_xdut_na find v(xdut.na) at=0
if abs(dc_1_1_xdut_na-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_1_1_xdut_na expected 0 V
end
meas dc dc_1_1_carry find v(carry) at=0
if abs(dc_1_1_carry-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_1_1_carry expected 0 V
end
meas dc dc_1_1_xdut_d find v(xdut.d) at=0
if abs(dc_1_1_xdut_d-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_1_1_xdut_d expected 0 V
end
meas dc dc_1_1_xdut_nd find v(xdut.nd) at=0
if abs(dc_1_1_xdut_nd-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_1_1_xdut_nd expected 0 V
end
meas dc dc_1_1_sum find v(sum) at=0
if abs(dc_1_1_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_1_1_sum expected 0 V
end
meas dc dc_1_2_xdut_t find v(xdut.t) at=5
if abs(dc_1_2_xdut_t-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_1_2_xdut_t expected -5 V
end
meas dc dc_1_2_xdut_u find v(xdut.u) at=5
if abs(dc_1_2_xdut_u-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_1_2_xdut_u expected 5 V
end
meas dc dc_1_2_xdut_na find v(xdut.na) at=5
if abs(dc_1_2_xdut_na-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_1_2_xdut_na expected -5 V
end
meas dc dc_1_2_carry find v(carry) at=5
if abs(dc_1_2_carry-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_1_2_carry expected 0 V
end
meas dc dc_1_2_xdut_d find v(xdut.d) at=5
if abs(dc_1_2_xdut_d-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_1_2_xdut_d expected 5 V
end
meas dc dc_1_2_xdut_nd find v(xdut.nd) at=5
if abs(dc_1_2_xdut_nd-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_1_2_xdut_nd expected -5 V
end
meas dc dc_1_2_sum find v(sum) at=5
if abs(dc_1_2_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_1_2_sum expected 5 V
end
plot v(a) v(sum) v(carry) ylimit -5.5 5.5 title 'Half Adder DC: B=0 V'
wrdata half_adder_dc_b1.txt v(a) v(b) v(xdut.t) v(xdut.u) v(xdut.na) v(carry) v(xdut.d) v(xdut.nd) v(sum)
alterparam ha_cseed=-5
alterparam ha_sseed=5
reset
alter VB 5
dc VA -5 5 0.015625
meas dc dc_2_0_xdut_t find v(xdut.t) at=-5
if abs(dc_2_0_xdut_t-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_2_0_xdut_t expected 0 V
end
meas dc dc_2_0_xdut_u find v(xdut.u) at=-5
if abs(dc_2_0_xdut_u-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_2_0_xdut_u expected -5 V
end
meas dc dc_2_0_xdut_na find v(xdut.na) at=-5
if abs(dc_2_0_xdut_na-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_2_0_xdut_na expected 5 V
end
meas dc dc_2_0_carry find v(carry) at=-5
if abs(dc_2_0_carry-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_2_0_carry expected 0 V
end
meas dc dc_2_0_xdut_d find v(xdut.d) at=-5
if abs(dc_2_0_xdut_d-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_2_0_xdut_d expected 0 V
end
meas dc dc_2_0_xdut_nd find v(xdut.nd) at=-5
if abs(dc_2_0_xdut_nd-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_2_0_xdut_nd expected 0 V
end
meas dc dc_2_0_sum find v(sum) at=-5
if abs(dc_2_0_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_2_0_sum expected 0 V
end
meas dc dc_2_1_xdut_t find v(xdut.t) at=0
if abs(dc_2_1_xdut_t-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_2_1_xdut_t expected -5 V
end
meas dc dc_2_1_xdut_u find v(xdut.u) at=0
if abs(dc_2_1_xdut_u-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_2_1_xdut_u expected 0 V
end
meas dc dc_2_1_xdut_na find v(xdut.na) at=0
if abs(dc_2_1_xdut_na-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_2_1_xdut_na expected 0 V
end
meas dc dc_2_1_carry find v(carry) at=0
if abs(dc_2_1_carry-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_2_1_carry expected 0 V
end
meas dc dc_2_1_xdut_d find v(xdut.d) at=0
if abs(dc_2_1_xdut_d-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_2_1_xdut_d expected 5 V
end
meas dc dc_2_1_xdut_nd find v(xdut.nd) at=0
if abs(dc_2_1_xdut_nd-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_2_1_xdut_nd expected -5 V
end
meas dc dc_2_1_sum find v(sum) at=0
if abs(dc_2_1_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_2_1_sum expected 5 V
end
meas dc dc_2_2_xdut_t find v(xdut.t) at=5
if abs(dc_2_2_xdut_t-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_2_2_xdut_t expected -5 V
end
meas dc dc_2_2_xdut_u find v(xdut.u) at=5
if abs(dc_2_2_xdut_u-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_2_2_xdut_u expected 0 V
end
meas dc dc_2_2_xdut_na find v(xdut.na) at=5
if abs(dc_2_2_xdut_na-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_2_2_xdut_na expected -5 V
end
meas dc dc_2_2_carry find v(carry) at=5
if abs(dc_2_2_carry-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_2_2_carry expected 5 V
end
meas dc dc_2_2_xdut_d find v(xdut.d) at=5
if abs(dc_2_2_xdut_d-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_2_2_xdut_d expected 0 V
end
meas dc dc_2_2_xdut_nd find v(xdut.nd) at=5
if abs(dc_2_2_xdut_nd-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_2_2_xdut_nd expected 0 V
end
meas dc dc_2_2_sum find v(sum) at=5
if abs(dc_2_2_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_2_2_sum expected -5 V
end
plot v(a) v(sum) v(carry) ylimit -5.5 5.5 title 'Half Adder DC: B=5 V'
wrdata half_adder_dc_b2.txt v(a) v(b) v(xdut.t) v(xdut.u) v(xdut.na) v(carry) v(xdut.d) v(xdut.nd) v(sum)
alterparam ha_cseed=-5
alterparam ha_sseed=5
reset
tran 0.2n 2000n
let a_logic=5*((v(a)>2.5)-(v(a)<-2.5))
let b_logic=5*((v(b)>2.5)-(v(b)<-2.5))
let carry_expected=5*((v(a)>2.5)*(v(b)>2.5)-(v(a)<-2.5)*(v(b)<-2.5))
let sum_expected=a_logic+b_logic-3*carry_expected
plot v(a) v(b) v(sum) sum_expected title 'Half Adder: SUM'
plot v(a) v(b) v(carry) carry_expected title 'Half Adder: CARRY'
plot v(xdut.t) v(xdut.u) v(xdut.na) v(carry) title 'Half Adder: carry path'
plot v(xdut.d) v(xdut.nd) v(sum) title 'Half Adder: sum path'
wrdata half_adder_tran.txt v(a) v(b) v(xdut.t) v(xdut.u) v(xdut.na) v(carry) v(xdut.d) v(xdut.nd) v(sum)
meas tran tran_0_xdut_t find v(xdut.t) at=199n
if abs(tran_0_xdut_t-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_0_xdut_t expected 5 V
end
meas tran tran_0_xdut_u find v(xdut.u) at=199n
if abs(tran_0_xdut_u-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_0_xdut_u expected 0 V
end
meas tran tran_0_xdut_na find v(xdut.na) at=199n
if abs(tran_0_xdut_na-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_0_xdut_na expected 5 V
end
meas tran tran_0_carry find v(carry) at=199n
if abs(tran_0_carry-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_0_carry expected -5 V
end
meas tran tran_0_xdut_d find v(xdut.d) at=199n
if abs(tran_0_xdut_d-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_0_xdut_d expected 0 V
end
meas tran tran_0_xdut_nd find v(xdut.nd) at=199n
if abs(tran_0_xdut_nd-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_0_xdut_nd expected 0 V
end
meas tran tran_0_sum find v(sum) at=199n
if abs(tran_0_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_0_sum expected 5 V
end
meas tran tran_1_xdut_t find v(xdut.t) at=399n
if abs(tran_1_xdut_t-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_1_xdut_t expected 5 V
end
meas tran tran_1_xdut_u find v(xdut.u) at=399n
if abs(tran_1_xdut_u-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_1_xdut_u expected -5 V
end
meas tran tran_1_xdut_na find v(xdut.na) at=399n
if abs(tran_1_xdut_na-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_1_xdut_na expected 5 V
end
meas tran tran_1_carry find v(carry) at=399n
if abs(tran_1_carry-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_1_carry expected 0 V
end
meas tran tran_1_xdut_d find v(xdut.d) at=399n
if abs(tran_1_xdut_d-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_1_xdut_d expected -5 V
end
meas tran tran_1_xdut_nd find v(xdut.nd) at=399n
if abs(tran_1_xdut_nd-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_1_xdut_nd expected 5 V
end
meas tran tran_1_sum find v(sum) at=399n
if abs(tran_1_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_1_sum expected -5 V
end
meas tran tran_2_xdut_t find v(xdut.t) at=599n
if abs(tran_2_xdut_t-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_2_xdut_t expected 0 V
end
meas tran tran_2_xdut_u find v(xdut.u) at=599n
if abs(tran_2_xdut_u-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_2_xdut_u expected -5 V
end
meas tran tran_2_xdut_na find v(xdut.na) at=599n
if abs(tran_2_xdut_na-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_2_xdut_na expected 5 V
end
meas tran tran_2_carry find v(carry) at=599n
if abs(tran_2_carry-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_2_carry expected 0 V
end
meas tran tran_2_xdut_d find v(xdut.d) at=599n
if abs(tran_2_xdut_d-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_2_xdut_d expected 0 V
end
meas tran tran_2_xdut_nd find v(xdut.nd) at=599n
if abs(tran_2_xdut_nd-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_2_xdut_nd expected 0 V
end
meas tran tran_2_sum find v(sum) at=599n
if abs(tran_2_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_2_sum expected 0 V
end
meas tran tran_3_xdut_t find v(xdut.t) at=799n
if abs(tran_3_xdut_t-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_3_xdut_t expected 5 V
end
meas tran tran_3_xdut_u find v(xdut.u) at=799n
if abs(tran_3_xdut_u-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_3_xdut_u expected 0 V
end
meas tran tran_3_xdut_na find v(xdut.na) at=799n
if abs(tran_3_xdut_na-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_3_xdut_na expected 0 V
end
meas tran tran_3_carry find v(carry) at=799n
if abs(tran_3_carry-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_3_carry expected 0 V
end
meas tran tran_3_xdut_d find v(xdut.d) at=799n
if abs(tran_3_xdut_d-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_3_xdut_d expected -5 V
end
meas tran tran_3_xdut_nd find v(xdut.nd) at=799n
if abs(tran_3_xdut_nd-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_3_xdut_nd expected 5 V
end
meas tran tran_3_sum find v(sum) at=799n
if abs(tran_3_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_3_sum expected -5 V
end
meas tran tran_4_xdut_t find v(xdut.t) at=999n
if abs(tran_4_xdut_t-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_4_xdut_t expected 0 V
end
meas tran tran_4_xdut_u find v(xdut.u) at=999n
if abs(tran_4_xdut_u-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_4_xdut_u expected 0 V
end
meas tran tran_4_xdut_na find v(xdut.na) at=999n
if abs(tran_4_xdut_na-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_4_xdut_na expected 0 V
end
meas tran tran_4_carry find v(carry) at=999n
if abs(tran_4_carry-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_4_carry expected 0 V
end
meas tran tran_4_xdut_d find v(xdut.d) at=999n
if abs(tran_4_xdut_d-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_4_xdut_d expected 0 V
end
meas tran tran_4_xdut_nd find v(xdut.nd) at=999n
if abs(tran_4_xdut_nd-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_4_xdut_nd expected 0 V
end
meas tran tran_4_sum find v(sum) at=999n
if abs(tran_4_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_4_sum expected 0 V
end
meas tran tran_5_xdut_t find v(xdut.t) at=1199n
if abs(tran_5_xdut_t-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_5_xdut_t expected -5 V
end
meas tran tran_5_xdut_u find v(xdut.u) at=1199n
if abs(tran_5_xdut_u-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_5_xdut_u expected 0 V
end
meas tran tran_5_xdut_na find v(xdut.na) at=1199n
if abs(tran_5_xdut_na-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_5_xdut_na expected 0 V
end
meas tran tran_5_carry find v(carry) at=1199n
if abs(tran_5_carry-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_5_carry expected 0 V
end
meas tran tran_5_xdut_d find v(xdut.d) at=1199n
if abs(tran_5_xdut_d-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_5_xdut_d expected 5 V
end
meas tran tran_5_xdut_nd find v(xdut.nd) at=1199n
if abs(tran_5_xdut_nd-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_5_xdut_nd expected -5 V
end
meas tran tran_5_sum find v(sum) at=1199n
if abs(tran_5_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_5_sum expected 5 V
end
meas tran tran_6_xdut_t find v(xdut.t) at=1399n
if abs(tran_6_xdut_t-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_6_xdut_t expected 0 V
end
meas tran tran_6_xdut_u find v(xdut.u) at=1399n
if abs(tran_6_xdut_u-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_6_xdut_u expected 5 V
end
meas tran tran_6_xdut_na find v(xdut.na) at=1399n
if abs(tran_6_xdut_na-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_6_xdut_na expected -5 V
end
meas tran tran_6_carry find v(carry) at=1399n
if abs(tran_6_carry-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_6_carry expected 0 V
end
meas tran tran_6_xdut_d find v(xdut.d) at=1399n
if abs(tran_6_xdut_d-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_6_xdut_d expected 0 V
end
meas tran tran_6_xdut_nd find v(xdut.nd) at=1399n
if abs(tran_6_xdut_nd-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_6_xdut_nd expected 0 V
end
meas tran tran_6_sum find v(sum) at=1399n
if abs(tran_6_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_6_sum expected 0 V
end
meas tran tran_7_xdut_t find v(xdut.t) at=1599n
if abs(tran_7_xdut_t-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_7_xdut_t expected -5 V
end
meas tran tran_7_xdut_u find v(xdut.u) at=1599n
if abs(tran_7_xdut_u-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_7_xdut_u expected 5 V
end
meas tran tran_7_xdut_na find v(xdut.na) at=1599n
if abs(tran_7_xdut_na-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_7_xdut_na expected -5 V
end
meas tran tran_7_carry find v(carry) at=1599n
if abs(tran_7_carry-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_7_carry expected 0 V
end
meas tran tran_7_xdut_d find v(xdut.d) at=1599n
if abs(tran_7_xdut_d-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_7_xdut_d expected 5 V
end
meas tran tran_7_xdut_nd find v(xdut.nd) at=1599n
if abs(tran_7_xdut_nd-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_7_xdut_nd expected -5 V
end
meas tran tran_7_sum find v(sum) at=1599n
if abs(tran_7_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_7_sum expected 5 V
end
meas tran tran_8_xdut_t find v(xdut.t) at=1799n
if abs(tran_8_xdut_t-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_8_xdut_t expected -5 V
end
meas tran tran_8_xdut_u find v(xdut.u) at=1799n
if abs(tran_8_xdut_u-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_8_xdut_u expected 0 V
end
meas tran tran_8_xdut_na find v(xdut.na) at=1799n
if abs(tran_8_xdut_na-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_8_xdut_na expected -5 V
end
meas tran tran_8_carry find v(carry) at=1799n
if abs(tran_8_carry-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_8_carry expected 5 V
end
meas tran tran_8_xdut_d find v(xdut.d) at=1799n
if abs(tran_8_xdut_d-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_8_xdut_d expected 0 V
end
meas tran tran_8_xdut_nd find v(xdut.nd) at=1799n
if abs(tran_8_xdut_nd-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_8_xdut_nd expected 0 V
end
meas tran tran_8_sum find v(sum) at=1799n
if abs(tran_8_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_8_sum expected -5 V
end
meas tran tran_9_xdut_t find v(xdut.t) at=1999n
if abs(tran_9_xdut_t-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_9_xdut_t expected 5 V
end
meas tran tran_9_xdut_u find v(xdut.u) at=1999n
if abs(tran_9_xdut_u-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_9_xdut_u expected 0 V
end
meas tran tran_9_xdut_na find v(xdut.na) at=1999n
if abs(tran_9_xdut_na-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_9_xdut_na expected 5 V
end
meas tran tran_9_carry find v(carry) at=1999n
if abs(tran_9_carry-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_9_carry expected -5 V
end
meas tran tran_9_xdut_d find v(xdut.d) at=1999n
if abs(tran_9_xdut_d-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_9_xdut_d expected 0 V
end
meas tran tran_9_xdut_nd find v(xdut.nd) at=1999n
if abs(tran_9_xdut_nd-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_9_xdut_nd expected 0 V
end
meas tran tran_9_sum find v(sum) at=1999n
if abs(tran_9_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_9_sum expected 5 V
end
if const.failures = 0
echo PASS: Half Adder DC/transient outputs and internal nodes
else
echo FAIL: Half Adder samples outside +/-0.5 V
end
print const.failures
.endc"}
C {devices/netlist_options.sym} 1830 870 0 0 {name=NETLIST_OPTIONS
lvs_netlist=false
top_is_subckt=false
spiceprefix=true
hiersep=.}
C {devices/vsource.sym} 1000 540 0 0 {name=VMID value=0 savecurrent=false}
C {devices/lab_pin.sym} 1000 510 0 0 {name=midpower lab=VMID}
C {devices/gnd.sym} 1000 570 0 0 {name=gmid lab=GND}
