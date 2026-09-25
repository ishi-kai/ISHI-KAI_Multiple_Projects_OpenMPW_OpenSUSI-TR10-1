v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {TERNARY SRAM / IDEAL-DRIVE WRITE + WL-OFF HOLD / all six state transitions} 40 -140 0 0 0.38 0.38 {}
T {27 C; +/-5 V supply; access NMOS W/L=3.4u/1u; Q/QB load=10 fF each.} 40 -80 0 0 0.24 0.24 {}
C {/home/ishi-kai/balanced-ternary-logic/ternary_sram.sym} 440 180 0 0 {name=xdut}
N 300 140 260 140 {lab=BL}
C {devices/lab_pin.sym} 260 140 0 0 {name=l1 lab=BL}
N 300 220 260 220 {lab=BLB}
C {devices/lab_pin.sym} 260 220 0 0 {name=l2 lab=BLB}
N 300 280 260 280 {lab=WL}
C {devices/lab_pin.sym} 260 280 0 0 {name=l3 lab=WL}
N 580 140 620 140 {lab=Q}
C {devices/lab_pin.sym} 620 140 0 1 {name=l4 lab=Q}
N 580 220 620 220 {lab=QB}
C {devices/lab_pin.sym} 620 220 0 1 {name=l5 lab=QB}
N 440 60 440 40 {lab=VDD}
C {devices/lab_pin.sym} 440 40 0 0 {name=l6 lab=VDD}
N 440 340 440 360 {lab=VSS}
C {devices/lab_pin.sym} 440 360 0 0 {name=l7 lab=VSS}
C {devices/capa.sym} 800 200 0 0 {name=CQ value=10f m=1}
C {devices/lab_pin.sym} 800 170 0 0 {name=l8 lab=Q}
C {devices/gnd.sym} 800 230 0 0 {name=l9 lab=GND}
C {devices/capa.sym} 1020 200 0 0 {name=CQB value=10f m=1}
C {devices/lab_pin.sym} 1020 170 0 0 {name=l10 lab=QB}
C {devices/gnd.sym} 1020 230 0 0 {name=l11 lab=GND}
C {devices/vsource.sym} 120 570 0 0 {name=VDD
value="5"
savecurrent=false
hide_texts=true}
C {devices/lab_pin.sym} 120 540 0 0 {name=l12 lab=VDD}
C {devices/gnd.sym} 120 600 0 0 {name=l13 lab=GND}
T {VDD} 150 560 0 0 0.24 0.24 {}
C {devices/vsource.sym} 360 570 0 0 {name=VSS
value="-5"
savecurrent=false
hide_texts=true}
C {devices/lab_pin.sym} 360 540 0 0 {name=l14 lab=VSS}
C {devices/gnd.sym} 360 600 0 0 {name=l15 lab=GND}
T {VSS} 390 560 0 0 0.24 0.24 {}
C {devices/vsource.sym} 600 570 0 0 {name=VBL
value="PWL(0n -5 420n -5 421n 0 820n 0 821n 5 1220n 5 1221n 0 1620n 0 1621n -5 2020n -5 2021n 5 2420n 5 2421n -5 2800n -5)"
savecurrent=false
hide_texts=true}
C {devices/lab_pin.sym} 600 540 0 0 {name=l16 lab=BL}
C {devices/gnd.sym} 600 600 0 0 {name=l17 lab=GND}
T {VBL} 630 560 0 0 0.24 0.24 {}
C {devices/vsource.sym} 840 570 0 0 {name=VBLB
value="PWL(0n 5 420n 5 421n 0 820n 0 821n -5 1220n -5 1221n 0 1620n 0 1621n 5 2020n 5 2021n -5 2420n -5 2421n 5 2800n 5)"
savecurrent=false
hide_texts=true}
C {devices/lab_pin.sym} 840 540 0 0 {name=l18 lab=BLB}
C {devices/gnd.sym} 840 600 0 0 {name=l19 lab=GND}
T {VBLB} 870 560 0 0 0.24 0.24 {}
C {devices/vsource.sym} 1080 570 0 0 {name=VWL
value="PWL(0n -5 50n -5 51n 5 150n 5 151n -5 450n -5 451n 5 550n 5 551n -5 850n -5 851n 5 950n 5 951n -5 1250n -5 1251n 5 1350n 5 1351n -5 1650n -5 1651n 5 1750n 5 1751n -5 2050n -5 2051n 5 2150n 5 2151n -5 2450n -5 2451n 5 2550n 5 2551n -5 2800n -5)"
savecurrent=false
hide_texts=true}
C {devices/lab_pin.sym} 1080 540 0 0 {name=l20 lab=WL}
C {devices/gnd.sym} 1080 600 0 0 {name=l21 lab=GND}
T {VWL} 1110 560 0 0 0.24 0.24 {}
T {Ideal complementary BL/BLB drivers model external write equipment.} 40 690 0 0 0.24 0.24 {}
T {WL goes LOW before judging rail restoration. Q=0 V is a stored data state.} 40 730 0 0 0.24 0.24 {}
T {SEQUENCE / ns / nominal hold voltages} 1260 -80 0 0 0.3 0.3 {}
T {Slot             BL / BLB       WL ON             Hold sample} 1260 -30 0 0 0.24 0.24 {}
T {   0- 400        -5 / +5 V          51- 150           399} 1260 20 0 0 0.24 0.24 {}
T { 400- 800        +0 / +0 V         451- 550           799} 1260 64 0 0 0.24 0.24 {}
T { 800-1200        +5 / -5 V         851- 950          1199} 1260 108 0 0 0.24 0.24 {}
T {1200-1600        +0 / +0 V        1251-1350          1599} 1260 152 0 0 0.24 0.24 {}
T {1600-2000        -5 / +5 V        1651-1750          1999} 1260 196 0 0 0.24 0.24 {}
T {2000-2400        +5 / -5 V        2051-2150          2399} 1260 240 0 0 0.24 0.24 {}
T {2400-2800        -5 / +5 V        2451-2550          2799} 1260 284 0 0 0.24 0.24 {}
T {BL changes at slot+20..21 ns; WL edges are 1 ns.} 1260 360 0 0 0.24 0.24 {}
T {Measure write @+149 ns, hold @+299 and +399 ns.} 1260 402 0 0 0.24 0.24 {}
T {Hold assertions: Q=BL, QB=BLB within +/-0.5 V.} 1260 444 0 0 0.24 0.24 {}
T {High level during WL ON can have NMOS pass loss.} 1260 486 0 0 0.24 0.24 {}
T {No precharge or sense amplifier. Read TB is separate.} 1260 528 0 0 0.24 0.24 {}
T {RUN: Netlist -> Simulate; native voltage plots.} 1260 570 0 0 0.24 0.24 {}
C {devices/code.sym} 1260 680 0 0 {name=TR_1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"}
C {devices/code.sym} 1560 680 0 0 {name=SIMULATION
only_toplevel=true
value=".temp 27
.ic v(Q)=-5 v(QB)=5
.control
save all
set wr_singlescale
set wr_vecnames
setplot const
let failures=0
tran 0.2n 2800n 0 0.5n
meas tran write_q_0 find v(Q) at=149n
meas tran write_qb_0 find v(QB) at=149n
meas tran hold_q_299 find v(Q) at=299n
if abs(hold_q_299-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: hold_q_299 expected -5 V
end
meas tran hold_qb_299 find v(QB) at=299n
if abs(hold_qb_299-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: hold_qb_299 expected 5 V
end
meas tran hold_q_399 find v(Q) at=399n
if abs(hold_q_399-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: hold_q_399 expected -5 V
end
meas tran hold_qb_399 find v(QB) at=399n
if abs(hold_qb_399-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: hold_qb_399 expected 5 V
end
meas tran write_q_1 find v(Q) at=549n
meas tran write_qb_1 find v(QB) at=549n
meas tran hold_q_699 find v(Q) at=699n
if abs(hold_q_699-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: hold_q_699 expected 0 V
end
meas tran hold_qb_699 find v(QB) at=699n
if abs(hold_qb_699-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: hold_qb_699 expected 0 V
end
meas tran hold_q_799 find v(Q) at=799n
if abs(hold_q_799-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: hold_q_799 expected 0 V
end
meas tran hold_qb_799 find v(QB) at=799n
if abs(hold_qb_799-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: hold_qb_799 expected 0 V
end
meas tran write_q_2 find v(Q) at=949n
meas tran write_qb_2 find v(QB) at=949n
meas tran hold_q_1099 find v(Q) at=1099n
if abs(hold_q_1099-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: hold_q_1099 expected 5 V
end
meas tran hold_qb_1099 find v(QB) at=1099n
if abs(hold_qb_1099-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: hold_qb_1099 expected -5 V
end
meas tran hold_q_1199 find v(Q) at=1199n
if abs(hold_q_1199-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: hold_q_1199 expected 5 V
end
meas tran hold_qb_1199 find v(QB) at=1199n
if abs(hold_qb_1199-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: hold_qb_1199 expected -5 V
end
meas tran write_q_3 find v(Q) at=1349n
meas tran write_qb_3 find v(QB) at=1349n
meas tran hold_q_1499 find v(Q) at=1499n
if abs(hold_q_1499-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: hold_q_1499 expected 0 V
end
meas tran hold_qb_1499 find v(QB) at=1499n
if abs(hold_qb_1499-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: hold_qb_1499 expected 0 V
end
meas tran hold_q_1599 find v(Q) at=1599n
if abs(hold_q_1599-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: hold_q_1599 expected 0 V
end
meas tran hold_qb_1599 find v(QB) at=1599n
if abs(hold_qb_1599-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: hold_qb_1599 expected 0 V
end
meas tran write_q_4 find v(Q) at=1749n
meas tran write_qb_4 find v(QB) at=1749n
meas tran hold_q_1899 find v(Q) at=1899n
if abs(hold_q_1899-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: hold_q_1899 expected -5 V
end
meas tran hold_qb_1899 find v(QB) at=1899n
if abs(hold_qb_1899-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: hold_qb_1899 expected 5 V
end
meas tran hold_q_1999 find v(Q) at=1999n
if abs(hold_q_1999-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: hold_q_1999 expected -5 V
end
meas tran hold_qb_1999 find v(QB) at=1999n
if abs(hold_qb_1999-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: hold_qb_1999 expected 5 V
end
meas tran write_q_5 find v(Q) at=2149n
meas tran write_qb_5 find v(QB) at=2149n
meas tran hold_q_2299 find v(Q) at=2299n
if abs(hold_q_2299-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: hold_q_2299 expected 5 V
end
meas tran hold_qb_2299 find v(QB) at=2299n
if abs(hold_qb_2299-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: hold_qb_2299 expected -5 V
end
meas tran hold_q_2399 find v(Q) at=2399n
if abs(hold_q_2399-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: hold_q_2399 expected 5 V
end
meas tran hold_qb_2399 find v(QB) at=2399n
if abs(hold_qb_2399-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: hold_qb_2399 expected -5 V
end
meas tran write_q_6 find v(Q) at=2549n
meas tran write_qb_6 find v(QB) at=2549n
meas tran hold_q_2699 find v(Q) at=2699n
if abs(hold_q_2699-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: hold_q_2699 expected -5 V
end
meas tran hold_qb_2699 find v(QB) at=2699n
if abs(hold_qb_2699-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: hold_qb_2699 expected 5 V
end
meas tran hold_q_2799 find v(Q) at=2799n
if abs(hold_q_2799-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: hold_q_2799 expected -5 V
end
meas tran hold_qb_2799 find v(QB) at=2799n
if abs(hold_qb_2799-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: hold_qb_2799 expected 5 V
end
plot v(Q) v(QB) ylimit -5.5 5.5 title 'SRAM storage: write and hold'
plot v(BL) v(BLB) v(WL) ylimit -5.5 5.5 title 'SRAM ideal bitline drivers and WL'
wrdata ternary_sram_write.txt v(Q) v(QB) v(BL) v(BLB) v(WL)
if const.failures = 0
echo PASS: all six writes and WL-off hold
else
echo FAIL: all six writes and WL-off hold
end
print const.failures
.endc"}
C {devices/netlist_options.sym} 1860 680 0 0 {name=NETLIST_OPTIONS
lvs_netlist=false
top_is_subckt=false
spiceprefix=true
hiersep=.}
