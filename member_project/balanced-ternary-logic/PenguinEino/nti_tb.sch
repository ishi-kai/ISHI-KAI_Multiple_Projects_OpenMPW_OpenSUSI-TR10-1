v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {NTI / 2-MOS / DC + ALL SIX TRANSITIONS} 40 -160 0 0 0.4 0.4 {}
T {DUT: nti.sym -> nti.sch / dimensions and wiring live in the cell} 40 -100 0 0 0.25 0.25 {}
T {27 C / V+ = +5 V / V- = -5 V / external Cload = 10 fF} 40 -55 0 0 0.25 0.25 {}
C {/home/ishi-kai/balanced-ternary-logic/nti.sym} 400 140 0 0 {name=x1}
N 240 140 340 140 {lab=vin}
C {devices/lab_pin.sym} 240 140 0 0 {name=lab1 lab=vin}
N 470 140 660 140 {lab=vout}
C {devices/lab_pin.sym} 660 140 0 0 {name=lab2 lab=vout}
C {devices/lab_pin.sym} 400 80 0 0 {name=lab3 lab=V+}
C {devices/lab_pin.sym} 400 200 0 0 {name=lab4 lab=V-}
C {devices/capa.sym} 660 220 0 0 {name=Cload value=10f m=1}
N 660 140 660 190 {lab=vout}
C {devices/gnd.sym} 660 250 0 0 {name=gload lab=GND}
T {No load capacitor inside the cell. Edit Cload here.} 40 320 0 0 0.25 0.25 {}
C {devices/vsource.sym} 120 460 0 0 {name=VDD value="5" savecurrent=false hide_texts=true}
C {devices/lab_pin.sym} 120 430 0 0 {name=lab5 lab=V+}
C {devices/gnd.sym} 120 490 0 0 {name=gVDD lab=GND}
T {VDD = 5 V} 85 530 0 0 0.25 0.25 {}
C {devices/vsource.sym} 340 460 0 0 {name=VSS value="-5" savecurrent=false hide_texts=true}
C {devices/lab_pin.sym} 340 430 0 0 {name=lab6 lab=V-}
C {devices/gnd.sym} 340 490 0 0 {name=gVSS lab=GND}
T {VSS = -5 V} 305 530 0 0 0.25 0.25 {}
C {devices/vsource.sym} 560 460 0 0 {name=VIN value="PWL(0 -5 200n -5 201n 0 400n 0 401n 5 600n 5 601n 0 800n 0 801n -5 1000n -5 1001n 5 1200n 5 1201n -5 1400n -5)" savecurrent=false hide_texts=true}
C {devices/lab_pin.sym} 560 430 0 0 {name=lab7 lab=vin}
C {devices/gnd.sym} 560 490 0 0 {name=gVIN lab=GND}
T {VIN / PWL} 525 530 0 0 0.25 0.25 {}
T {Transient: use the explicit sequence and sample times at right.} 40 660 0 0 0.25 0.25 {}
T {RUN: disable LVS -> Netlist -> Simulate; native voltage plots.} 40 720 0 0 0.27 0.27 {}
T {Edit source properties for stimulus; SIMULATION for measurements.} 40 770 0 0 0.25 0.25 {}
C {devices/code.sym} 1150 850 0 0 {name=TR_1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"}
C {devices/code.sym} 1450 850 0 0 {name=SIMULATION
only_toplevel=true
value=".temp 27
.options rshunt=1e12
.control
save all
set wr_singlescale
set wr_vecnames
setplot const
let failures=0
dc VIN -5 5 0.015625
meas dc dc_0 find v(vout) at=-5
if abs(dc_0-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_0 expected 5 V
end
meas dc dc_1 find v(vout) at=-4.5
if abs(dc_1-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_1 expected 5 V
end
meas dc dc_2 find v(vout) at=-0.5
if abs(dc_2-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_2 expected -5 V
end
meas dc dc_3 find v(vout) at=0
if abs(dc_3-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_3 expected -5 V
end
meas dc dc_4 find v(vout) at=0.5
if abs(dc_4-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_4 expected -5 V
end
meas dc dc_5 find v(vout) at=4.5
if abs(dc_5-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_5 expected -5 V
end
meas dc dc_6 find v(vout) at=5
if abs(dc_6-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: dc_6 expected -5 V
end
plot v(vin) v(vout) title 'NTI: DC transfer'
wrdata nti_dc.txt v(vin) v(vout)
reset
tran 0.05n 1400n
let expected=5-10*(v(vin)>-2.5)
plot v(vin) v(vout) expected title 'NTI: all six input transitions'
wrdata nti_tran.txt v(vin) v(vout)
meas tran tran_0 find v(vout) at=199n
if abs(tran_0-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_0 expected 5 V
end
meas tran tran_1 find v(vout) at=399n
if abs(tran_1-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_1 expected -5 V
end
meas tran tran_2 find v(vout) at=599n
if abs(tran_2-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_2 expected -5 V
end
meas tran tran_3 find v(vout) at=799n
if abs(tran_3-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_3 expected -5 V
end
meas tran tran_4 find v(vout) at=999n
if abs(tran_4-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_4 expected 5 V
end
meas tran tran_5 find v(vout) at=1199n
if abs(tran_5-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_5 expected -5 V
end
meas tran tran_6 find v(vout) at=1399n
if abs(tran_6-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_6 expected 5 V
end
if const.failures = 0
echo PASS: NTI DC bands and transient samples
else
echo FAIL: NTI samples outside +/-0.5 V
end
print const.failures
.endc"}
C {devices/netlist_options.sym} 1750 850 0 0 {name=NETLIST_OPTIONS
lvs_netlist=false
top_is_subckt=false
spiceprefix=true
hiersep=.}
T {SEQUENCE / ns and volts / 200 ns slots / 1 ns edges} 1030 -140 0 0 0.28 0.28 {}
T {Interval          Vin       Expected Vout      Sample} 1030 -90 0 0 0.24 0.24 {}
T {   0- 200       -5               +5                   199} 1030 -40 0 0 0.24 0.24 {}
T { 201- 400       +0               -5                   399} 1030 0 0 0 0.24 0.24 {}
T { 401- 600       +5               -5                   599} 1030 40 0 0 0.24 0.24 {}
T { 601- 800       +0               -5                   799} 1030 80 0 0 0.24 0.24 {}
T { 801-1000       -5               +5                   999} 1030 120 0 0 0.24 0.24 {}
T {1001-1200       +5               -5                   1199} 1030 160 0 0 0.24 0.24 {}
T {1201-1400       -5               +5                   1399} 1030 200 0 0 0.24 0.24 {}
T {All six directed input transitions. +/-0.5 V output tolerance.} 1030 300 0 0 0.24 0.24 {}
T {DC: Vin -5..+5 V; test nominal inputs and +/-0.5 V bands.} 40 630 0 0 0.24 0.24 {}
