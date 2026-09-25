v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {NANY / y = -sat(a+b) on trits / DC + TRANSIENT} 40 -160 0 0 0.4 0.4 {}
T {DUT: nany.sym -> nany.sch / dimensions and wiring live in the cell} 40 -100 0 0 0.25 0.25 {}
T {27 C / VDD = +5 V / VSS = -5 V / external Cload = 10 fF} 40 -55 0 0 0.25 0.25 {}
C {/home/ishi-kai/balanced-ternary-logic/nany.sym} 400 140 0 0 {name=x1}
N 240 120 340 120 {lab=a}
C {devices/lab_pin.sym} 240 120 0 0 {name=lab1 lab=a}
N 240 160 340 160 {lab=b}
C {devices/lab_pin.sym} 240 160 0 0 {name=lab2 lab=b}
N 470 140 660 140 {lab=vout}
C {devices/lab_pin.sym} 660 140 0 0 {name=lab3 lab=vout}
C {devices/lab_pin.sym} 400 80 0 0 {name=lab4 lab=VDD}
C {devices/lab_pin.sym} 400 200 0 0 {name=lab5 lab=VSS}
C {devices/capa.sym} 660 220 0 0 {name=Cload value=10f m=1}
N 660 140 660 190 {lab=vout}
C {devices/gnd.sym} 660 250 0 0 {name=gload lab=GND}
N 430 220 430 270 {lab=VMID}
C {devices/lab_pin.sym} 430 270 0 0 {name=midlabel lab=VMID}
C {devices/isource.sym} 900 220 0 0 {name=ITEST value=0 savecurrent=false}
N 660 140 900 140 {lab=vout}
N 900 140 900 190 {lab=vout}
C {devices/gnd.sym} 900 250 0 0 {name=gitest lab=GND}
T {VMID -> GND (0 V reference); ITEST = 0 except for DC load probes.} 40 320 0 0 0.25 0.25 {}
C {devices/vsource.sym} 120 460 0 0 {name=VDD value="5" savecurrent=false hide_texts=true}
C {devices/lab_pin.sym} 120 430 0 0 {name=lab6 lab=VDD}
C {devices/gnd.sym} 120 490 0 0 {name=gVDD lab=GND}
T {VDD = 5 V} 85 530 0 0 0.25 0.25 {}
C {devices/vsource.sym} 340 460 0 0 {name=VSS value="-5" savecurrent=false hide_texts=true}
C {devices/lab_pin.sym} 340 430 0 0 {name=lab7 lab=VSS}
C {devices/gnd.sym} 340 490 0 0 {name=gVSS lab=GND}
T {VSS = -5 V} 305 530 0 0 0.25 0.25 {}
C {devices/vsource.sym} 560 460 0 0 {name=VA value="PWL(0 -5 200n -5 201n -5 400n -5 401n -5 600n -5 601n 0 800n 0 801n 0 1000n 0 1001n 0 1200n 0 1201n 5 1400n 5 1401n 5 1600n 5 1601n 5 1800n 5 1801n -5 2000n -5 2001n -5 3000n -5 3001n 5 3200n 5 3201n -5 4200n -5 4201n -5 4400n -5 4401n 5 5400n 5 5401n 5 5600n 5 5601n 5 6600n 5)" savecurrent=false hide_texts=true}
C {devices/lab_pin.sym} 560 430 0 0 {name=lab8 lab=a}
C {devices/gnd.sym} 560 490 0 0 {name=gVA lab=GND}
T {VA / PWL} 525 530 0 0 0.25 0.25 {}
C {devices/vsource.sym} 780 460 0 0 {name=VB value="PWL(0 -5 200n -5 201n 0 400n 0 401n 5 600n 5 601n -5 800n -5 801n 0 1000n 0 1001n 5 1200n 5 1201n -5 1400n -5 1401n 0 1600n 0 1601n 5 1800n 5 1801n -5 2000n -5 2001n 5 3000n 5 3001n 5 3200n 5 3201n 5 4200n 5 4201n -5 4400n -5 4401n -5 5400n -5 5401n 5 5600n 5 5601n -5 6600n -5)" savecurrent=false hide_texts=true}
C {devices/lab_pin.sym} 780 430 0 0 {name=lab9 lab=b}
C {devices/gnd.sym} 780 490 0 0 {name=gVB lab=GND}
T {VB / PWL} 745 530 0 0 0.25 0.25 {}
T {SEQUENCE / time in ns; voltages in V; 1 ns input edges} 1150 -150 0 0 0.3 0.3 {}
T {Interval          Input(s)        Expected Y       Sample} 1150 -100 0 0 0.25 0.25 {}
T {   0 -  200          (-5, -5)              +5                199} 1150 -55 0 0 0.23 0.23 {}
T { 201 -  400          (-5, 0)               +5                399} 1150 -17 0 0 0.23 0.23 {}
T { 401 -  600          (-5, 5)               +0                599} 1150 21 0 0 0.23 0.23 {}
T { 601 -  800          (0, -5)               +5                799} 1150 59 0 0 0.23 0.23 {}
T { 801 - 1000          (0, 0)                +0                999} 1150 97 0 0 0.23 0.23 {}
T {1001 - 1200          (0, 5)                -5                1199} 1150 135 0 0 0.23 0.23 {}
T {1201 - 1400          (5, -5)               +0                1399} 1150 173 0 0 0.23 0.23 {}
T {1401 - 1600          (5, 0)                -5                1599} 1150 211 0 0 0.23 0.23 {}
T {1601 - 1800          (5, 5)                -5                1799} 1150 249 0 0 0.23 0.23 {}
T {1801 - 2000          (-5, -5)              +5                1999} 1150 287 0 0 0.23 0.23 {}
T {2001 - 3000          (-5, 5)               +0                2999} 1150 325 0 0 0.23 0.23 {}
T {3001 - 3200          (5, 5)                -5                3199} 1150 363 0 0 0.23 0.23 {}
T {3201 - 4200          (-5, 5)               +0                4199} 1150 401 0 0 0.23 0.23 {}
T {4201 - 4400          (-5, -5)              +5                4399} 1150 439 0 0 0.23 0.23 {}
T {4401 - 5400          (5, -5)               +0                5399} 1150 477 0 0 0.23 0.23 {}
T {5401 - 5600          (5, 5)                -5                5599} 1150 515 0 0 0.23 0.23 {}
T {5601 - 6600          (5, -5)               +0                6599} 1150 553 0 0 0.23 0.23 {}
T {DC: input sweep -5 to +5 V; two-input gates hold B at -5/0/+5 V.} 40 620 0 0 0.25 0.25 {}
T {Transient: use the explicit sequence and sample times at right.} 40 660 0 0 0.25 0.25 {}
T {RUN: disable LVS -> Netlist -> Simulate; native voltage plots.} 40 720 0 0 0.27 0.27 {}
T {Edit source properties for stimulus; SIMULATION for measurements.} 40 770 0 0 0.25 0.25 {}
T {Last eight slots: precharge then mixed inputs, testing zero-clamp history.} 1150 640 0 0 0.25 0.25 {}
C {devices/code.sym} 1150 850 0 0 {name=TR_1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"}
C {devices/code.sym} 1450 850 0 0 {name=SIMULATION
only_toplevel=true
value=".temp 27
.options rshunt=1e12
.nodeset v(vout)=5 v(x1.net1)=5 v(x1.net2)=5 v(x1.net3)=-5 v(x1.net4)=-5 v(x1.net5)=0 v(x1.net6)=0
.control
save all
set wr_singlescale
set wr_vecnames
setplot const
let driven_failures=0
let mixed_failures=0
reset
alter VB -5
dc VA -5 5 0.015625
plot v(a) v(vout) ylimit -5.5 5.5 title 'NANY DC: B=-5 V'
wrdata nany_dc_b_neg.txt v(a) v(vout)
meas dc out_a_neg_b_neg find v(vout) at=-5
meas dc out_a_zero_b_neg find v(vout) at=0
meas dc out_a_pos_b_neg find v(vout) at=5
reset
alter VB 0
dc VA -5 5 0.015625
plot v(a) v(vout) ylimit -5.5 5.5 title 'NANY DC: B=0 V'
wrdata nany_dc_b_zero.txt v(a) v(vout)
meas dc out_a_neg_b_zero find v(vout) at=-5
meas dc out_a_zero_b_zero find v(vout) at=0
meas dc out_a_pos_b_zero find v(vout) at=5
reset
alter VB 5
dc VA -5 5 0.015625
plot v(a) v(vout) ylimit -5.5 5.5 title 'NANY DC: B=5 V'
wrdata nany_dc_b_pos.txt v(a) v(vout)
meas dc out_a_neg_b_pos find v(vout) at=-5
meas dc out_a_zero_b_pos find v(vout) at=0
meas dc out_a_pos_b_pos find v(vout) at=5
reset
echo ---- DC load sensitivity: +1nA draws current from output; -1nA injects ----
alter VA -5
alter VB -5
alter ITEST 0
op
let const.v_unloaded=v(vout)
alter ITEST 1n
op
let const.v_sink=v(vout)
alter ITEST -1n
op
let const.v_source=v(vout)
echo INPUT_A=-5 INPUT_B=-5
print const.v_unloaded const.v_sink const.v_source
let const.r_apparent=(const.v_source-const.v_sink)/2e-9
print const.r_apparent
alter VA -5
alter VB 0
alter ITEST 0
op
let const.v_unloaded=v(vout)
alter ITEST 1n
op
let const.v_sink=v(vout)
alter ITEST -1n
op
let const.v_source=v(vout)
echo INPUT_A=-5 INPUT_B=0
print const.v_unloaded const.v_sink const.v_source
let const.r_apparent=(const.v_source-const.v_sink)/2e-9
print const.r_apparent
alter VA -5
alter VB 5
alter ITEST 0
op
let const.v_unloaded=v(vout)
alter ITEST 1n
op
let const.v_sink=v(vout)
alter ITEST -1n
op
let const.v_source=v(vout)
echo INPUT_A=-5 INPUT_B=5
print const.v_unloaded const.v_sink const.v_source
let const.r_apparent=(const.v_source-const.v_sink)/2e-9
print const.r_apparent
alter VA 0
alter VB -5
alter ITEST 0
op
let const.v_unloaded=v(vout)
alter ITEST 1n
op
let const.v_sink=v(vout)
alter ITEST -1n
op
let const.v_source=v(vout)
echo INPUT_A=0 INPUT_B=-5
print const.v_unloaded const.v_sink const.v_source
let const.r_apparent=(const.v_source-const.v_sink)/2e-9
print const.r_apparent
alter VA 0
alter VB 0
alter ITEST 0
op
let const.v_unloaded=v(vout)
alter ITEST 1n
op
let const.v_sink=v(vout)
alter ITEST -1n
op
let const.v_source=v(vout)
echo INPUT_A=0 INPUT_B=0
print const.v_unloaded const.v_sink const.v_source
let const.r_apparent=(const.v_source-const.v_sink)/2e-9
print const.r_apparent
alter VA 0
alter VB 5
alter ITEST 0
op
let const.v_unloaded=v(vout)
alter ITEST 1n
op
let const.v_sink=v(vout)
alter ITEST -1n
op
let const.v_source=v(vout)
echo INPUT_A=0 INPUT_B=5
print const.v_unloaded const.v_sink const.v_source
let const.r_apparent=(const.v_source-const.v_sink)/2e-9
print const.r_apparent
alter VA 5
alter VB -5
alter ITEST 0
op
let const.v_unloaded=v(vout)
alter ITEST 1n
op
let const.v_sink=v(vout)
alter ITEST -1n
op
let const.v_source=v(vout)
echo INPUT_A=5 INPUT_B=-5
print const.v_unloaded const.v_sink const.v_source
let const.r_apparent=(const.v_source-const.v_sink)/2e-9
print const.r_apparent
alter VA 5
alter VB 0
alter ITEST 0
op
let const.v_unloaded=v(vout)
alter ITEST 1n
op
let const.v_sink=v(vout)
alter ITEST -1n
op
let const.v_source=v(vout)
echo INPUT_A=5 INPUT_B=0
print const.v_unloaded const.v_sink const.v_source
let const.r_apparent=(const.v_source-const.v_sink)/2e-9
print const.r_apparent
alter VA 5
alter VB 5
alter ITEST 0
op
let const.v_unloaded=v(vout)
alter ITEST 1n
op
let const.v_sink=v(vout)
alter ITEST -1n
op
let const.v_source=v(vout)
echo INPUT_A=5 INPUT_B=5
print const.v_unloaded const.v_sink const.v_source
let const.r_apparent=(const.v_source-const.v_sink)/2e-9
print const.r_apparent
reset
tran 0.2n 6600n
plot v(a) v(b) v(vout) title 'NANY: nine input pairs and mixed-rail history'
plot v(a) v(b) v(vout) xlimit 1.8u 6.6u title 'NANY: same mixed inputs after opposite precharges'
wrdata nany_tran.txt v(a) v(b) v(vout)
meas tran out_01 find v(vout) at=199n
if abs(out_01-(5)) > 0.5
let const.driven_failures=const.driven_failures+1
echo OUTSIDE_0.5V: sample 1 A=-5 B=-5 ideal=5
end
meas tran out_02 find v(vout) at=399n
if abs(out_02-(5)) > 0.5
let const.driven_failures=const.driven_failures+1
echo OUTSIDE_0.5V: sample 2 A=-5 B=0 ideal=5
end
meas tran out_03 find v(vout) at=599n
if abs(out_03-(0)) > 0.5
let const.mixed_failures=const.mixed_failures+1
echo OUTSIDE_0.5V: sample 3 A=-5 B=5 ideal=0
end
meas tran out_04 find v(vout) at=799n
if abs(out_04-(5)) > 0.5
let const.driven_failures=const.driven_failures+1
echo OUTSIDE_0.5V: sample 4 A=0 B=-5 ideal=5
end
meas tran out_05 find v(vout) at=999n
if abs(out_05-(0)) > 0.5
let const.driven_failures=const.driven_failures+1
echo OUTSIDE_0.5V: sample 5 A=0 B=0 ideal=0
end
meas tran out_06 find v(vout) at=1199n
if abs(out_06-(-5)) > 0.5
let const.driven_failures=const.driven_failures+1
echo OUTSIDE_0.5V: sample 6 A=0 B=5 ideal=-5
end
meas tran out_07 find v(vout) at=1399n
if abs(out_07-(0)) > 0.5
let const.mixed_failures=const.mixed_failures+1
echo OUTSIDE_0.5V: sample 7 A=5 B=-5 ideal=0
end
meas tran out_08 find v(vout) at=1599n
if abs(out_08-(-5)) > 0.5
let const.driven_failures=const.driven_failures+1
echo OUTSIDE_0.5V: sample 8 A=5 B=0 ideal=-5
end
meas tran out_09 find v(vout) at=1799n
if abs(out_09-(-5)) > 0.5
let const.driven_failures=const.driven_failures+1
echo OUTSIDE_0.5V: sample 9 A=5 B=5 ideal=-5
end
meas tran out_10 find v(vout) at=1999n
if abs(out_10-(5)) > 0.5
let const.driven_failures=const.driven_failures+1
echo OUTSIDE_0.5V: sample 10 A=-5 B=-5 ideal=5
end
meas tran out_11 find v(vout) at=2999n
if abs(out_11-(0)) > 0.5
let const.mixed_failures=const.mixed_failures+1
echo OUTSIDE_0.5V: sample 11 A=-5 B=5 ideal=0
end
meas tran out_12 find v(vout) at=3199n
if abs(out_12-(-5)) > 0.5
let const.driven_failures=const.driven_failures+1
echo OUTSIDE_0.5V: sample 12 A=5 B=5 ideal=-5
end
meas tran out_13 find v(vout) at=4199n
if abs(out_13-(0)) > 0.5
let const.mixed_failures=const.mixed_failures+1
echo OUTSIDE_0.5V: sample 13 A=-5 B=5 ideal=0
end
meas tran out_14 find v(vout) at=4399n
if abs(out_14-(5)) > 0.5
let const.driven_failures=const.driven_failures+1
echo OUTSIDE_0.5V: sample 14 A=-5 B=-5 ideal=5
end
meas tran out_15 find v(vout) at=5399n
if abs(out_15-(0)) > 0.5
let const.mixed_failures=const.mixed_failures+1
echo OUTSIDE_0.5V: sample 15 A=5 B=-5 ideal=0
end
meas tran out_16 find v(vout) at=5599n
if abs(out_16-(-5)) > 0.5
let const.driven_failures=const.driven_failures+1
echo OUTSIDE_0.5V: sample 16 A=5 B=5 ideal=-5
end
meas tran out_17 find v(vout) at=6599n
if abs(out_17-(0)) > 0.5
let const.mixed_failures=const.mixed_failures+1
echo OUTSIDE_0.5V: sample 17 A=5 B=-5 ideal=0
end
echo ---- Error counts: driven states vs mixed-rail clamp ----
print const.driven_failures const.mixed_failures
.endc"}
C {devices/netlist_options.sym} 1750 850 0 0 {name=NETLIST_OPTIONS
lvs_netlist=false
top_is_subckt=false
spiceprefix=true
hiersep=.}
C {devices/vsource.sym} 1010 460 0 0 {name=VMID value=0 savecurrent=false}
C {devices/lab_pin.sym} 1010 430 0 0 {name=midpower lab=VMID}
C {devices/gnd.sym} 1010 490 0 0 {name=gmid lab=GND}
