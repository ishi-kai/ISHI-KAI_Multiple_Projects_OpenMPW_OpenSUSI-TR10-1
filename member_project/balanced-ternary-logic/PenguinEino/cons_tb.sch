v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {CONS / CARRY / DC + TRANSIENT} 40 -160 0 0 0.4 0.4 {}
T {DUT: cons.sym -> cons.sch -> nsign/inverter cells} 40 -105 0 0 0.25 0.25 {}
T {27 C / +/-5 V supplies / V0 = GND / external load = 10 fF} 40 -60 0 0 0.25 0.25 {}
C {/home/ishi-kai/balanced-ternary-logic/cons.sym} 400 140 0 0 {name=xdut}
N 240 120 340 120 {lab=a}
C {devices/lab_pin.sym} 240 120 0 0 {name=l1 lab=a}
N 240 160 340 160 {lab=b}
C {devices/lab_pin.sym} 240 160 0 0 {name=l2 lab=b}
C {devices/lab_pin.sym} 400 80 0 0 {name=l3 lab=V+}
C {devices/lab_pin.sym} 400 200 0 0 {name=l4 lab=V-}
N 430 220 430 270 {lab=GND}
C {devices/gnd.sym} 430 270 0 0 {name=gref lab=GND}
N 470 140 680 140 {lab=vout}
C {devices/lab_pin.sym} 680 140 0 0 {name=l5 lab=vout}
N 680 140 680 190 {lab=vout}
C {devices/capa.sym} 680 220 0 0 {name=Cload value=10f m=1}
C {devices/gnd.sym} 680 250 0 0 {name=gout lab=GND}
T {Internal signals: xdut.t / xdut.u / xdut.na} 40 325 0 0 0.25 0.25 {}
C {devices/vsource.sym} 120 460 0 0 {name=VDD value="5" savecurrent=false hide_texts=true}
C {devices/lab_pin.sym} 120 430 0 0 {name=l6 lab=V+}
C {devices/gnd.sym} 120 490 0 0 {name=gVDD lab=GND}
T {VDD} 95 535 0 0 0.25 0.25 {}
C {devices/vsource.sym} 340 460 0 0 {name=VSS value="-5" savecurrent=false hide_texts=true}
C {devices/lab_pin.sym} 340 430 0 0 {name=l7 lab=V-}
C {devices/gnd.sym} 340 490 0 0 {name=gVSS lab=GND}
T {VSS} 315 535 0 0 0.25 0.25 {}
C {devices/vsource.sym} 560 460 0 0 {name=VA value="PWL(0 -5 200n -5 201n -5 400n -5 401n -5 600n -5 601n 0 800n 0 801n 0 1000n 0 1001n 0 1200n 0 1201n 5 1400n 5 1401n 5 1600n 5 1601n 5 1800n 5 1801n -5 2000n -5)" savecurrent=false hide_texts=true}
C {devices/lab_pin.sym} 560 430 0 0 {name=l8 lab=a}
C {devices/gnd.sym} 560 490 0 0 {name=gVA lab=GND}
T {VA} 535 535 0 0 0.25 0.25 {}
C {devices/vsource.sym} 780 460 0 0 {name=VB value="PWL(0 -5 200n -5 201n 0 400n 0 401n 5 600n 5 601n -5 800n -5 801n 0 1000n 0 1001n 5 1200n 5 1201n -5 1400n -5 1401n 0 1600n 0 1601n 5 1800n 5 1801n -5 2000n -5)" savecurrent=false hide_texts=true}
C {devices/lab_pin.sym} 780 430 0 0 {name=l9 lab=b}
C {devices/gnd.sym} 780 490 0 0 {name=gVB lab=GND}
T {VB} 755 535 0 0 0.25 0.25 {}
T {SEQUENCE / ns and volts / 200 ns slots / 1 ns edges} 1120 -150 0 0 0.3 0.3 {}
T {Interval        A    B       T    U    NA     Y        Sample} 1120 -100 0 0 0.25 0.25 {}
T {   0- 200     -5   -5      +5   +0   +5     -5          199} 1120 -55 0 0 0.23 0.23 {}
T { 201- 400     -5   +0      +5   -5   +5     +0          399} 1120 -15 0 0 0.23 0.23 {}
T { 401- 600     -5   +5      +0   -5   +5     +0          599} 1120 25 0 0 0.23 0.23 {}
T { 601- 800     +0   -5      +5   +0   +0     +0          799} 1120 65 0 0 0.23 0.23 {}
T { 801-1000     +0   +0      +0   +0   +0     +0          999} 1120 105 0 0 0.23 0.23 {}
T {1001-1200     +0   +5      -5   +0   +0     +0          1199} 1120 145 0 0 0.23 0.23 {}
T {1201-1400     +5   -5      +0   +5   -5     +0          1399} 1120 185 0 0 0.23 0.23 {}
T {1401-1600     +5   +0      -5   +5   -5     +0          1599} 1120 225 0 0 0.23 0.23 {}
T {1601-1800     +5   +5      -5   +0   -5     +5          1799} 1120 265 0 0 0.23 0.23 {}
T {1801-2000     -5   -5      +5   +0   +5     -5          1999} 1120 305 0 0 0.23 0.23 {}
T {Nine input pairs, then return to (-5,-5).} 1120 420 0 0 0.25 0.25 {}
T {Sample all internal signals and Y; expected logic tolerance +/-0.5 V.} 1120 465 0 0 0.25 0.25 {}
T {DC: sweep A -5..+5 V, with B fixed at -5/0/+5 V.} 40 620 0 0 0.25 0.25 {}
T {Plot 1: A/B/Y/expected. Plot 2: internal T/U/NA and Y.} 40 665 0 0 0.25 0.25 {}
T {RUN: disable LVS -> Netlist -> Simulate; native voltage plots.} 40 725 0 0 0.27 0.27 {}
T {Edit source properties for sequence, Cload for load, SIMULATION for tests.} 40 775 0 0 0.25 0.25 {}
C {devices/code.sym} 1120 850 0 0 {name=MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"}
C {devices/code.sym} 1430 850 0 0 {name=SIMULATION
only_toplevel=true
value=".temp 27
.options rshunt=1e12
.nodeset v(xdut.t)=5 v(xdut.u)=0 v(xdut.na)=5 v(vout)=-5
.nodeset v(xdut.x_t.net1)=5 v(xdut.x_t.net2)=5 v(xdut.x_t.net3)=-5 v(xdut.x_t.net4)=-5 v(xdut.x_t.net5)=0 v(xdut.x_t.net6)=0
.nodeset v(xdut.x_u.net1)=5 v(xdut.x_u.net2)=5 v(xdut.x_u.net3)=-5 v(xdut.x_u.net4)=-5 v(xdut.x_u.net5)=0 v(xdut.x_u.net6)=0
.nodeset v(xdut.x_y.net1)=5 v(xdut.x_y.net2)=5 v(xdut.x_y.net3)=-5 v(xdut.x_y.net4)=-5 v(xdut.x_y.net5)=0 v(xdut.x_y.net6)=0
.nodeset v(xdut.x_na.net1)=5 v(xdut.x_na.net2)=-5
.control
save all
set wr_singlescale
set wr_vecnames
setplot const
let failures=0
reset
alter VB -5
dc VA -5 5 0.125
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
meas dc dc_0_0_vout find v(vout) at=-5
if abs(dc_0_0_vout-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_0_0_vout expected -5 V
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
meas dc dc_0_1_vout find v(vout) at=0
if abs(dc_0_1_vout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_0_1_vout expected 0 V
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
meas dc dc_0_2_vout find v(vout) at=5
if abs(dc_0_2_vout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_0_2_vout expected 0 V
end
plot v(a) v(vout) ylimit -5.5 5.5 title 'CONS DC: B=-5 V'
wrdata cons_dc_b0.txt v(a) v(b) v(xdut.t) v(xdut.u) v(xdut.na) v(vout)
reset
alter VB 0
dc VA -5 5 0.125
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
meas dc dc_1_0_vout find v(vout) at=-5
if abs(dc_1_0_vout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_1_0_vout expected 0 V
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
meas dc dc_1_1_vout find v(vout) at=0
if abs(dc_1_1_vout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_1_1_vout expected 0 V
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
meas dc dc_1_2_vout find v(vout) at=5
if abs(dc_1_2_vout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_1_2_vout expected 0 V
end
plot v(a) v(vout) ylimit -5.5 5.5 title 'CONS DC: B=0 V'
wrdata cons_dc_b1.txt v(a) v(b) v(xdut.t) v(xdut.u) v(xdut.na) v(vout)
reset
alter VB 5
dc VA -5 5 0.125
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
meas dc dc_2_0_vout find v(vout) at=-5
if abs(dc_2_0_vout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_2_0_vout expected 0 V
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
meas dc dc_2_1_vout find v(vout) at=0
if abs(dc_2_1_vout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_2_1_vout expected 0 V
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
meas dc dc_2_2_vout find v(vout) at=5
if abs(dc_2_2_vout-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_2_2_vout expected 5 V
end
plot v(a) v(vout) ylimit -5.5 5.5 title 'CONS DC: B=5 V'
wrdata cons_dc_b2.txt v(a) v(b) v(xdut.t) v(xdut.u) v(xdut.na) v(vout)
reset
tran 0.2n 2000n
let expected=5*((v(a)>2.5)*(v(b)>2.5)-(v(a)<-2.5)*(v(b)<-2.5))
plot v(a) v(b) v(vout) expected title 'CONS: inputs, output and expected logic'
plot v(xdut.t) v(xdut.u) v(xdut.na) v(vout) title 'CONS: internal T / U / NA / Y'
wrdata cons_tran.txt v(a) v(b) v(xdut.t) v(xdut.u) v(xdut.na) v(vout)
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
meas tran tran_0_vout find v(vout) at=199n
if abs(tran_0_vout-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_0_vout expected -5 V
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
meas tran tran_1_vout find v(vout) at=399n
if abs(tran_1_vout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_1_vout expected 0 V
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
meas tran tran_2_vout find v(vout) at=599n
if abs(tran_2_vout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_2_vout expected 0 V
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
meas tran tran_3_vout find v(vout) at=799n
if abs(tran_3_vout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_3_vout expected 0 V
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
meas tran tran_4_vout find v(vout) at=999n
if abs(tran_4_vout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_4_vout expected 0 V
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
meas tran tran_5_vout find v(vout) at=1199n
if abs(tran_5_vout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_5_vout expected 0 V
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
meas tran tran_6_vout find v(vout) at=1399n
if abs(tran_6_vout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_6_vout expected 0 V
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
meas tran tran_7_vout find v(vout) at=1599n
if abs(tran_7_vout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_7_vout expected 0 V
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
meas tran tran_8_vout find v(vout) at=1799n
if abs(tran_8_vout-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_8_vout expected 5 V
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
meas tran tran_9_vout find v(vout) at=1999n
if abs(tran_9_vout-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_9_vout expected -5 V
end
if const.failures = 0
echo PASS: CONS DC and transient internal/output samples
else
echo FAIL: CONS samples outside +/-0.5 V
end
print const.failures
.endc"}
C {devices/netlist_options.sym} 1730 850 0 0 {name=NETLIST_OPTIONS
lvs_netlist=false
top_is_subckt=false
spiceprefix=true
hiersep=.}
