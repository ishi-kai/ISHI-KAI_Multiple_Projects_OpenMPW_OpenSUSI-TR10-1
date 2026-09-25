v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {NOT / y = -vin / DC + TRANSIENT} 40 -160 0 0 0.4 0.4 {}
T {DUT: inverter.sym -> inverter.sch / dimensions and wiring live in the cell} 40 -100 0 0 0.25 0.25 {}
T {27 C / V+ = +5 V / V- = -5 V / external Cload = 10 fF} 40 -55 0 0 0.25 0.25 {}
C {/home/ishi-kai/balanced-ternary-logic/inverter.sym} 400 140 0 0 {name=x1}
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
C {devices/vsource.sym} 560 460 0 0 {name=VIN value="PWL(0 -5 20n -5 21n 0 40n 0 41n 5 60n 5 61n 0 80n 0 81n -5 100n -5 101n 5 120n 5 121n -5 140n -5)" savecurrent=false hide_texts=true}
C {devices/lab_pin.sym} 560 430 0 0 {name=lab7 lab=vin}
C {devices/gnd.sym} 560 490 0 0 {name=gVIN lab=GND}
T {VIN / PWL} 525 530 0 0 0.25 0.25 {}
T {SEQUENCE / time in ns; voltages in V; 1 ns input edges} 1150 -150 0 0 0.3 0.3 {}
T {Interval          Input(s)        Expected Y       Sample} 1150 -100 0 0 0.25 0.25 {}
T {   0 -   20          -5                    +5                19} 1150 -55 0 0 0.23 0.23 {}
T {  21 -   40          0                     +0                39} 1150 -17 0 0 0.23 0.23 {}
T {  41 -   60          5                     -5                59} 1150 21 0 0 0.23 0.23 {}
T {  61 -   80          0                     +0                79} 1150 59 0 0 0.23 0.23 {}
T {  81 -  100          -5                    +5                99} 1150 97 0 0 0.23 0.23 {}
T { 101 -  120          5                     -5                119} 1150 135 0 0 0.23 0.23 {}
T { 121 -  140          -5                    +5                139} 1150 173 0 0 0.23 0.23 {}
T {DC: VIN sweep -5 to +5 V; measurements at -5, -1, 0, +1, +5 V.} 40 620 0 0 0.25 0.25 {}
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
.nodeset v(vout)=5 v(x1.net1)=5 v(x1.net2)=-5
.options rshunt=1e12
.control
save all
dc VIN -5 5 0.015625
meas dc OUT_NEG find v(vout) at=-5
meas dc OUT_ZERO find v(vout) at=0
meas dc OUT_POS find v(vout) at=5
meas dc OUT_MID_LOW find v(vout) at=-1
meas dc OUT_MID_HIGH find v(vout) at=1
plot v(vin) v(vout) ylimit -5.5 5.5 title 'DC transfer: input and output'
reset
tran 0.05n 140n
meas tran OUT_NEG_1 find v(vout) at=19n
meas tran OUT_ZERO_UP find v(vout) at=39n
meas tran OUT_POS_1 find v(vout) at=59n
meas tran OUT_ZERO_DOWN find v(vout) at=79n
meas tran OUT_NEG_2 find v(vout) at=99n
meas tran OUT_POS_2 find v(vout) at=119n
meas tran OUT_NEG_3 find v(vout) at=139n
plot v(vin) v(vout) ylimit -5.5 5.5 title 'Ternary inverter: input and output'
.endc"}
C {devices/netlist_options.sym} 1750 850 0 0 {name=NETLIST_OPTIONS
lvs_netlist=false
top_is_subckt=false
spiceprefix=true
hiersep=.}
