v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {NAND / y = -min(a,b) / DC + TRANSIENT} 40 -160 0 0 0.4 0.4 {}
T {DUT: nand.sym -> nand.sch / dimensions and wiring live in the cell} 40 -100 0 0 0.25 0.25 {}
T {27 C / V+ = +5 V / V- = -5 V / external Cload = 10 fF} 40 -55 0 0 0.25 0.25 {}
C {/home/ishi-kai/balanced-ternary-logic/nand.sym} 400 140 0 0 {name=x1}
N 240 120 340 120 {lab=a}
C {devices/lab_pin.sym} 240 120 0 0 {name=lab1 lab=a}
N 240 160 340 160 {lab=b}
C {devices/lab_pin.sym} 240 160 0 0 {name=lab2 lab=b}
N 470 140 660 140 {lab=vout}
C {devices/lab_pin.sym} 660 140 0 0 {name=lab3 lab=vout}
C {devices/lab_pin.sym} 400 80 0 0 {name=lab4 lab=V+}
C {devices/lab_pin.sym} 400 200 0 0 {name=lab5 lab=V-}
C {devices/capa.sym} 660 220 0 0 {name=Cload value=10f m=1}
N 660 140 660 190 {lab=vout}
C {devices/gnd.sym} 660 250 0 0 {name=gload lab=GND}
T {No load capacitor inside the cell. Edit Cload here.} 40 320 0 0 0.25 0.25 {}
C {devices/vsource.sym} 120 460 0 0 {name=VDD value="5" savecurrent=false hide_texts=true}
C {devices/lab_pin.sym} 120 430 0 0 {name=lab6 lab=V+}
C {devices/gnd.sym} 120 490 0 0 {name=gVDD lab=GND}
T {VDD = 5 V} 85 530 0 0 0.25 0.25 {}
C {devices/vsource.sym} 340 460 0 0 {name=VSS value="-5" savecurrent=false hide_texts=true}
C {devices/lab_pin.sym} 340 430 0 0 {name=lab7 lab=V-}
C {devices/gnd.sym} 340 490 0 0 {name=gVSS lab=GND}
T {VSS = -5 V} 305 530 0 0 0.25 0.25 {}
C {devices/vsource.sym} 560 460 0 0 {name=VA value="PWL(0 -5 20n -5 21n 0 40n 0 41n 5 60n 5 61n 5 80n 5 81n 0 100n 0 101n -5 120n -5 121n -5 140n -5 141n 0 160n 0 161n 5 180n 5 181n -5 200n -5)" savecurrent=false hide_texts=true}
C {devices/lab_pin.sym} 560 430 0 0 {name=lab8 lab=a}
C {devices/gnd.sym} 560 490 0 0 {name=gVA lab=GND}
T {VA / PWL} 525 530 0 0 0.25 0.25 {}
C {devices/vsource.sym} 780 460 0 0 {name=VB value="PWL(0 -5 20n -5 21n -5 40n -5 41n -5 60n -5 61n 0 80n 0 81n 0 100n 0 101n 0 120n 0 121n 5 140n 5 141n 5 160n 5 161n 5 180n 5 181n -5 200n -5)" savecurrent=false hide_texts=true}
C {devices/lab_pin.sym} 780 430 0 0 {name=lab9 lab=b}
C {devices/gnd.sym} 780 490 0 0 {name=gVB lab=GND}
T {VB / PWL} 745 530 0 0 0.25 0.25 {}
T {SEQUENCE / time in ns; voltages in V; 1 ns input edges} 1150 -150 0 0 0.3 0.3 {}
T {Interval          Input(s)        Expected Y       Sample} 1150 -100 0 0 0.25 0.25 {}
T {   0 -   20          (-5, -5)              +5                19} 1150 -55 0 0 0.23 0.23 {}
T {  21 -   40          (0, -5)               +5                39} 1150 -17 0 0 0.23 0.23 {}
T {  41 -   60          (5, -5)               +5                59} 1150 21 0 0 0.23 0.23 {}
T {  61 -   80          (5, 0)                +0                79} 1150 59 0 0 0.23 0.23 {}
T {  81 -  100          (0, 0)                +0                99} 1150 97 0 0 0.23 0.23 {}
T { 101 -  120          (-5, 0)               +5                119} 1150 135 0 0 0.23 0.23 {}
T { 121 -  140          (-5, 5)               +5                139} 1150 173 0 0 0.23 0.23 {}
T { 141 -  160          (0, 5)                +0                159} 1150 211 0 0 0.23 0.23 {}
T { 161 -  180          (5, 5)                -5                179} 1150 249 0 0 0.23 0.23 {}
T { 181 -  200          (-5, -5)              +5                199} 1150 287 0 0 0.23 0.23 {}
T {DC: input sweep -5 to +5 V; two-input gates hold B at -5/0/+5 V.} 40 620 0 0 0.25 0.25 {}
T {Transient: use the explicit sequence and sample times at right.} 40 660 0 0 0.25 0.25 {}
T {RUN: disable LVS -> Netlist -> Simulate; native voltage plots.} 40 720 0 0 0.27 0.27 {}
T {Edit source properties for stimulus; SIMULATION for measurements.} 40 770 0 0 0.25 0.25 {}
T {All nine input pairs, then return to (-5,-5).} 1150 400 0 0 0.25 0.25 {}
C {devices/code.sym} 1150 850 0 0 {name=TR_1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"}
C {devices/code.sym} 1450 850 0 0 {name=SIMULATION
only_toplevel=true
value=".temp 27
BEXPECTED expected 0 V=-min(v(a),v(b))
BERROR output_error 0 V=v(vout)-v(expected)
.nodeset v(vout)=5 v(x1.net1)=5 v(x1.net2)=-5 v(x1.net3)=-5
.options rshunt=1e12
.control
save all
setplot const
let failures=0
reset
alter VB -5
dc VA -5 5 0.015625
meas dc DC_A_NEG_B_NEG find v(vout) at=-5
meas dc ERR_DC_A_NEG_B_NEG find v(output_error) at=-5
if abs(ERR_DC_A_NEG_B_NEG) > 0.5
let const.failures=const.failures+1
echo FAIL: DC_A_NEG_B_NEG outside expected +/-0.5V
end
meas dc DC_A_ZERO_B_NEG find v(vout) at=0
meas dc ERR_DC_A_ZERO_B_NEG find v(output_error) at=0
if abs(ERR_DC_A_ZERO_B_NEG) > 0.5
let const.failures=const.failures+1
echo FAIL: DC_A_ZERO_B_NEG outside expected +/-0.5V
end
meas dc DC_A_POS_B_NEG find v(vout) at=5
meas dc ERR_DC_A_POS_B_NEG find v(output_error) at=5
if abs(ERR_DC_A_POS_B_NEG) > 0.5
let const.failures=const.failures+1
echo FAIL: DC_A_POS_B_NEG outside expected +/-0.5V
end
plot v(a) v(vout) v(expected) ylimit -5.5 5.5 title 'NAND DC: sweep A, B = -5 V'
reset
alter VB 0
dc VA -5 5 0.015625
meas dc DC_A_NEG_B_ZERO find v(vout) at=-5
meas dc ERR_DC_A_NEG_B_ZERO find v(output_error) at=-5
if abs(ERR_DC_A_NEG_B_ZERO) > 0.5
let const.failures=const.failures+1
echo FAIL: DC_A_NEG_B_ZERO outside expected +/-0.5V
end
meas dc DC_A_ZERO_B_ZERO find v(vout) at=0
meas dc ERR_DC_A_ZERO_B_ZERO find v(output_error) at=0
if abs(ERR_DC_A_ZERO_B_ZERO) > 0.5
let const.failures=const.failures+1
echo FAIL: DC_A_ZERO_B_ZERO outside expected +/-0.5V
end
meas dc DC_A_POS_B_ZERO find v(vout) at=5
meas dc ERR_DC_A_POS_B_ZERO find v(output_error) at=5
if abs(ERR_DC_A_POS_B_ZERO) > 0.5
let const.failures=const.failures+1
echo FAIL: DC_A_POS_B_ZERO outside expected +/-0.5V
end
plot v(a) v(vout) v(expected) ylimit -5.5 5.5 title 'NAND DC: sweep A, B = 0 V'
reset
alter VB 5
dc VA -5 5 0.015625
meas dc DC_A_NEG_B_POS find v(vout) at=-5
meas dc ERR_DC_A_NEG_B_POS find v(output_error) at=-5
if abs(ERR_DC_A_NEG_B_POS) > 0.5
let const.failures=const.failures+1
echo FAIL: DC_A_NEG_B_POS outside expected +/-0.5V
end
meas dc DC_A_ZERO_B_POS find v(vout) at=0
meas dc ERR_DC_A_ZERO_B_POS find v(output_error) at=0
if abs(ERR_DC_A_ZERO_B_POS) > 0.5
let const.failures=const.failures+1
echo FAIL: DC_A_ZERO_B_POS outside expected +/-0.5V
end
meas dc DC_A_POS_B_POS find v(vout) at=5
meas dc ERR_DC_A_POS_B_POS find v(output_error) at=5
if abs(ERR_DC_A_POS_B_POS) > 0.5
let const.failures=const.failures+1
echo FAIL: DC_A_POS_B_POS outside expected +/-0.5V
end
plot v(a) v(vout) v(expected) ylimit -5.5 5.5 title 'NAND DC: sweep A, B = 5 V'
reset
tran 0.05n 200n
meas tran OUT_01 find v(vout) at=19n
meas tran ERR_OUT_01 find v(output_error) at=19n
if abs(ERR_OUT_01) > 0.5
let const.failures=const.failures+1
echo FAIL: OUT_01 outside expected +/-0.5V
end
meas tran OUT_02 find v(vout) at=39n
meas tran ERR_OUT_02 find v(output_error) at=39n
if abs(ERR_OUT_02) > 0.5
let const.failures=const.failures+1
echo FAIL: OUT_02 outside expected +/-0.5V
end
meas tran OUT_03 find v(vout) at=59n
meas tran ERR_OUT_03 find v(output_error) at=59n
if abs(ERR_OUT_03) > 0.5
let const.failures=const.failures+1
echo FAIL: OUT_03 outside expected +/-0.5V
end
meas tran OUT_04 find v(vout) at=79n
meas tran ERR_OUT_04 find v(output_error) at=79n
if abs(ERR_OUT_04) > 0.5
let const.failures=const.failures+1
echo FAIL: OUT_04 outside expected +/-0.5V
end
meas tran OUT_05 find v(vout) at=99n
meas tran ERR_OUT_05 find v(output_error) at=99n
if abs(ERR_OUT_05) > 0.5
let const.failures=const.failures+1
echo FAIL: OUT_05 outside expected +/-0.5V
end
meas tran OUT_06 find v(vout) at=119n
meas tran ERR_OUT_06 find v(output_error) at=119n
if abs(ERR_OUT_06) > 0.5
let const.failures=const.failures+1
echo FAIL: OUT_06 outside expected +/-0.5V
end
meas tran OUT_07 find v(vout) at=139n
meas tran ERR_OUT_07 find v(output_error) at=139n
if abs(ERR_OUT_07) > 0.5
let const.failures=const.failures+1
echo FAIL: OUT_07 outside expected +/-0.5V
end
meas tran OUT_08 find v(vout) at=159n
meas tran ERR_OUT_08 find v(output_error) at=159n
if abs(ERR_OUT_08) > 0.5
let const.failures=const.failures+1
echo FAIL: OUT_08 outside expected +/-0.5V
end
meas tran OUT_09 find v(vout) at=179n
meas tran ERR_OUT_09 find v(output_error) at=179n
if abs(ERR_OUT_09) > 0.5
let const.failures=const.failures+1
echo FAIL: OUT_09 outside expected +/-0.5V
end
meas tran OUT_10 find v(vout) at=199n
meas tran ERR_OUT_10 find v(output_error) at=199n
if abs(ERR_OUT_10) > 0.5
let const.failures=const.failures+1
echo FAIL: OUT_10 outside expected +/-0.5V
end
plot v(a) v(b) v(vout) v(expected) ylimit -5.5 5.5 title 'NAND: A, B and output / all nine input pairs'
if const.failures = 0
echo PASS: all DC and transient samples within expected +/-0.5V
else
echo FAIL: NAND truth-table samples outside tolerance
print const.failures
end
.endc"}
C {devices/netlist_options.sym} 1750 850 0 0 {name=NETLIST_OPTIONS
lvs_netlist=false
top_is_subckt=false
spiceprefix=true
hiersep=.}
