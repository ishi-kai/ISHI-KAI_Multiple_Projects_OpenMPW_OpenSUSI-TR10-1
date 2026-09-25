v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {BALANCED TERNARY FULL ADDER / SUM + COUT} 40 -180 0 0 0.4 0.4 {}
T {a + b + cin = sum + 3*cout / HA x2 + NANY + INV} 40 -125 0 0 0.25 0.25 {}
T {27 C / VDD=+5 V, VSS=-5 V, VMID=0 V / 10 fF per output} 40 -80 0 0 0.25 0.25 {}
C {/home/ishi-kai/balanced-ternary-logic/full_adder.sym} 400 200 0 0 {name=xdut}
N 200 160 310 160 {lab=a}
C {devices/lab_pin.sym} 200 160 0 0 {name=l_a lab=a}
N 200 200 310 200 {lab=b}
C {devices/lab_pin.sym} 200 200 0 0 {name=l_b lab=b}
N 200 240 310 240 {lab=cin}
C {devices/lab_pin.sym} 200 240 0 0 {name=l_cin lab=cin}
C {devices/lab_pin.sym} 400 110 0 0 {name=l_VDD lab=VDD}
C {devices/lab_pin.sym} 400 290 0 0 {name=l_VSS lab=VSS}
N 430 310 430 390 {lab=VMID}
C {devices/lab_pin.sym} 430 390 0 0 {name=l_VMID lab=VMID}
N 490 180 760 180 {lab=sum}
C {devices/lab_pin.sym} 760 180 0 0 {name=l_sum lab=sum}
N 760 180 760 330 {lab=sum}
C {devices/capa.sym} 760 360 0 0 {name=Csum value=10f m=1}
C {devices/gnd.sym} 760 390 0 0 {name=g_sum lab=GND}
N 490 220 1040 220 {lab=cout}
C {devices/lab_pin.sym} 1040 220 0 0 {name=l_cout lab=cout}
N 1040 220 1040 330 {lab=cout}
C {devices/capa.sym} 1040 360 0 0 {name=Ccout value=10f m=1}
C {devices/gnd.sym} 1040 390 0 0 {name=g_cout lab=GND}
T {Internal carry and sum nodes only see the next gate inputs.} 40 460 0 0 0.25 0.25 {}
C {devices/vsource.sym} 100 580 0 0 {name=VDD value="5" savecurrent=false hide_texts=true}
C {devices/lab_pin.sym} 100 550 0 0 {name=src_VDD lab=VDD}
C {devices/gnd.sym} 100 610 0 0 {name=g_VDD lab=GND}
T {VDD} 75 650 0 0 0.25 0.25 {}
C {devices/vsource.sym} 300 580 0 0 {name=VSS value="-5" savecurrent=false hide_texts=true}
C {devices/lab_pin.sym} 300 550 0 0 {name=src_VSS lab=VSS}
C {devices/gnd.sym} 300 610 0 0 {name=g_VSS lab=GND}
T {VSS} 275 650 0 0 0.25 0.25 {}
C {devices/vsource.sym} 500 580 0 0 {name=VMID value="0" savecurrent=false hide_texts=true}
C {devices/lab_pin.sym} 500 550 0 0 {name=src_VMID lab=VMID}
C {devices/gnd.sym} 500 610 0 0 {name=g_VMID lab=GND}
T {VMID} 475 650 0 0 0.25 0.25 {}
C {devices/vsource.sym} 700 580 0 0 {name=VA value="PWL(0 -5 200n -5 201n -5 400n -5 401n -5 600n -5 601n -5 800n -5 801n -5 1000n -5 1001n -5 1200n -5 1201n -5 1400n -5 1401n -5 1600n -5 1601n -5 1800n -5 1801n 0 2000n 0 2001n 0 2200n 0 2201n 0 2400n 0 2401n 0 2600n 0 2601n 0 2800n 0 2801n 0 3000n 0 3001n 0 3200n 0 3201n 0 3400n 0 3401n 0 3600n 0 3601n 5 3800n 5 3801n 5 4000n 5 4001n 5 4200n 5 4201n 5 4400n 5 4401n 5 4600n 5 4601n 5 4800n 5 4801n 5 5000n 5 5001n 5 5200n 5 5201n 5 5400n 5 5401n -5 5600n -5)" savecurrent=false hide_texts=true}
C {devices/lab_pin.sym} 700 550 0 0 {name=src_VA lab=a}
C {devices/gnd.sym} 700 610 0 0 {name=g_VA lab=GND}
T {VA} 675 650 0 0 0.25 0.25 {}
C {devices/vsource.sym} 900 580 0 0 {name=VB value="PWL(0 -5 200n -5 201n -5 400n -5 401n -5 600n -5 601n 0 800n 0 801n 0 1000n 0 1001n 0 1200n 0 1201n 5 1400n 5 1401n 5 1600n 5 1601n 5 1800n 5 1801n -5 2000n -5 2001n -5 2200n -5 2201n -5 2400n -5 2401n 0 2600n 0 2601n 0 2800n 0 2801n 0 3000n 0 3001n 5 3200n 5 3201n 5 3400n 5 3401n 5 3600n 5 3601n -5 3800n -5 3801n -5 4000n -5 4001n -5 4200n -5 4201n 0 4400n 0 4401n 0 4600n 0 4601n 0 4800n 0 4801n 5 5000n 5 5001n 5 5200n 5 5201n 5 5400n 5 5401n -5 5600n -5)" savecurrent=false hide_texts=true}
C {devices/lab_pin.sym} 900 550 0 0 {name=src_VB lab=b}
C {devices/gnd.sym} 900 610 0 0 {name=g_VB lab=GND}
T {VB} 875 650 0 0 0.25 0.25 {}
C {devices/vsource.sym} 1100 580 0 0 {name=VCIN value="PWL(0 -5 200n -5 201n 0 400n 0 401n 5 600n 5 601n -5 800n -5 801n 0 1000n 0 1001n 5 1200n 5 1201n -5 1400n -5 1401n 0 1600n 0 1601n 5 1800n 5 1801n -5 2000n -5 2001n 0 2200n 0 2201n 5 2400n 5 2401n -5 2600n -5 2601n 0 2800n 0 2801n 5 3000n 5 3001n -5 3200n -5 3201n 0 3400n 0 3401n 5 3600n 5 3601n -5 3800n -5 3801n 0 4000n 0 4001n 5 4200n 5 4201n -5 4400n -5 4401n 0 4600n 0 4601n 5 4800n 5 4801n -5 5000n -5 5001n 0 5200n 0 5201n 5 5400n 5 5401n -5 5600n -5)" savecurrent=false hide_texts=true}
C {devices/lab_pin.sym} 1100 550 0 0 {name=src_VCIN lab=cin}
C {devices/gnd.sym} 1100 610 0 0 {name=g_VCIN lab=GND}
T {VCIN} 1075 650 0 0 0.25 0.25 {}
T {SEQUENCE / ns and volts / 200 ns slots / 1 ns edges} 1280 -170 0 0 0.3 0.3 {}
T {Interval          A     B    Cin    SUM  Cout   Sample} 1280 -120 0 0 0.25 0.25 {}
T {   0- 200     -5    -5    -5      +0    -5       199} 1280 -65 0 0 0.23 0.23 {}
T { 201- 400     -5    -5    +0      +5    -5       399} 1280 -29 0 0 0.23 0.23 {}
T { 401- 600     -5    -5    +5      -5    +0       599} 1280 7 0 0 0.23 0.23 {}
T { 601- 800     -5    +0    -5      +5    -5       799} 1280 43 0 0 0.23 0.23 {}
T { 801-1000     -5    +0    +0      -5    +0       999} 1280 79 0 0 0.23 0.23 {}
T {1001-1200     -5    +0    +5      +0    +0       1199} 1280 115 0 0 0.23 0.23 {}
T {1201-1400     -5    +5    -5      -5    +0       1399} 1280 151 0 0 0.23 0.23 {}
T {1401-1600     -5    +5    +0      +0    +0       1599} 1280 187 0 0 0.23 0.23 {}
T {1601-1800     -5    +5    +5      +5    +0       1799} 1280 223 0 0 0.23 0.23 {}
T {1801-2000     +0    -5    -5      +5    -5       1999} 1280 259 0 0 0.23 0.23 {}
T {2001-2200     +0    -5    +0      -5    +0       2199} 1280 295 0 0 0.23 0.23 {}
T {2201-2400     +0    -5    +5      +0    +0       2399} 1280 331 0 0 0.23 0.23 {}
T {2401-2600     +0    +0    -5      -5    +0       2599} 1280 367 0 0 0.23 0.23 {}
T {2601-2800     +0    +0    +0      +0    +0       2799} 1280 403 0 0 0.23 0.23 {}
T {2801-3000     +0    +0    +5      +5    +0       2999} 1280 439 0 0 0.23 0.23 {}
T {3001-3200     +0    +5    -5      +0    +0       3199} 1280 475 0 0 0.23 0.23 {}
T {3201-3400     +0    +5    +0      +5    +0       3399} 1280 511 0 0 0.23 0.23 {}
T {3401-3600     +0    +5    +5      -5    +5       3599} 1280 547 0 0 0.23 0.23 {}
T {3601-3800     +5    -5    -5      -5    +0       3799} 1280 583 0 0 0.23 0.23 {}
T {3801-4000     +5    -5    +0      +0    +0       3999} 1280 619 0 0 0.23 0.23 {}
T {4001-4200     +5    -5    +5      +5    +0       4199} 1280 655 0 0 0.23 0.23 {}
T {4201-4400     +5    +0    -5      +0    +0       4399} 1280 691 0 0 0.23 0.23 {}
T {4401-4600     +5    +0    +0      +5    +0       4599} 1280 727 0 0 0.23 0.23 {}
T {4601-4800     +5    +0    +5      -5    +5       4799} 1280 763 0 0 0.23 0.23 {}
T {4801-5000     +5    +5    -5      +5    +0       4999} 1280 799 0 0 0.23 0.23 {}
T {5001-5200     +5    +5    +0      -5    +5       5199} 1280 835 0 0 0.23 0.23 {}
T {5201-5400     +5    +5    +5      +0    +5       5399} 1280 871 0 0 0.23 0.23 {}
T {5401-5600     -5    -5    -5      +0    -5       5599} 1280 907 0 0 0.23 0.23 {}
T {All 27 input triples, then return to (-5,-5,-5).} 1280 1000 0 0 0.25 0.25 {}
T {Sample tolerance: +/-0.5 V. Check outputs and HA interconnects.} 1280 1045 0 0 0.25 0.25 {}
T {RUN: Netlist -> Simulate; ngspice native voltage plots.} 40 745 0 0 0.27 0.27 {}
T {VA / VB / VCIN: input PWL sequence. Csum / Ccout: external load.} 40 795 0 0 0.25 0.25 {}
T {SIMULATION: transient analysis and expected-value checks.} 40 840 0 0 0.25 0.25 {}
T {Internal nodes: xdut.s1 / xdut.c1 / xdut.c2 / xdut.nc} 40 885 0 0 0.25 0.25 {}
T {NODESET supplies initial solver guesses for (-5,-5,-5).} 40 930 0 0 0.25 0.25 {}
C {devices/code.sym} 40 1080 0 0 {name=MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"}
C {devices/code.sym} 370 1080 0 0 {name=SIMULATION
only_toplevel=true
value=".temp 27
.options rshunt=1e12
.nodeset v(xdut.s1)=5 v(xdut.c1)=-5 v(xdut.c2)=0 v(xdut.nc)=5 v(sum)=0 v(cout)=-5
.nodeset v(xdut.x_ha1.t)=5 v(xdut.x_ha1.u)=0 v(xdut.x_ha1.na)=5 v(xdut.x_ha1.d)=0 v(xdut.x_ha1.nd)=0
.nodeset v(xdut.x_ha1.x_t.net1)=5 v(xdut.x_ha1.x_t.net2)=5 v(xdut.x_ha1.x_t.net3)=-5 v(xdut.x_ha1.x_t.net4)=-5 v(xdut.x_ha1.x_t.net5)=0 v(xdut.x_ha1.x_t.net6)=0
.nodeset v(xdut.x_ha1.x_u.net1)=5 v(xdut.x_ha1.x_u.net2)=5 v(xdut.x_ha1.x_u.net3)=-5 v(xdut.x_ha1.x_u.net4)=-5 v(xdut.x_ha1.x_u.net5)=0 v(xdut.x_ha1.x_u.net6)=0
.nodeset v(xdut.x_ha1.x_c.net1)=5 v(xdut.x_ha1.x_c.net2)=5 v(xdut.x_ha1.x_c.net3)=-5 v(xdut.x_ha1.x_c.net4)=-5 v(xdut.x_ha1.x_c.net5)=0 v(xdut.x_ha1.x_c.net6)=0
.nodeset v(xdut.x_ha1.x_d.net1)=5 v(xdut.x_ha1.x_d.net2)=5 v(xdut.x_ha1.x_d.net3)=-5 v(xdut.x_ha1.x_d.net4)=-5 v(xdut.x_ha1.x_d.net5)=0 v(xdut.x_ha1.x_d.net6)=0
.nodeset v(xdut.x_ha1.x_s.net1)=5 v(xdut.x_ha1.x_s.net2)=5 v(xdut.x_ha1.x_s.net3)=-5 v(xdut.x_ha1.x_s.net4)=-5 v(xdut.x_ha1.x_s.net5)=0 v(xdut.x_ha1.x_s.net6)=0
.nodeset v(xdut.x_ha1.x_na.net1)=5 v(xdut.x_ha1.x_na.net2)=-5
.nodeset v(xdut.x_ha1.x_nd.net1)=5 v(xdut.x_ha1.x_nd.net2)=-5
.nodeset v(xdut.x_ha2.t)=0 v(xdut.x_ha2.u)=5 v(xdut.x_ha2.na)=-5 v(xdut.x_ha2.d)=0 v(xdut.x_ha2.nd)=0
.nodeset v(xdut.x_ha2.x_t.net1)=5 v(xdut.x_ha2.x_t.net2)=5 v(xdut.x_ha2.x_t.net3)=-5 v(xdut.x_ha2.x_t.net4)=-5 v(xdut.x_ha2.x_t.net5)=0 v(xdut.x_ha2.x_t.net6)=0
.nodeset v(xdut.x_ha2.x_u.net1)=5 v(xdut.x_ha2.x_u.net2)=5 v(xdut.x_ha2.x_u.net3)=-5 v(xdut.x_ha2.x_u.net4)=-5 v(xdut.x_ha2.x_u.net5)=0 v(xdut.x_ha2.x_u.net6)=0
.nodeset v(xdut.x_ha2.x_c.net1)=5 v(xdut.x_ha2.x_c.net2)=5 v(xdut.x_ha2.x_c.net3)=-5 v(xdut.x_ha2.x_c.net4)=-5 v(xdut.x_ha2.x_c.net5)=0 v(xdut.x_ha2.x_c.net6)=0
.nodeset v(xdut.x_ha2.x_d.net1)=5 v(xdut.x_ha2.x_d.net2)=5 v(xdut.x_ha2.x_d.net3)=-5 v(xdut.x_ha2.x_d.net4)=-5 v(xdut.x_ha2.x_d.net5)=0 v(xdut.x_ha2.x_d.net6)=0
.nodeset v(xdut.x_ha2.x_s.net1)=5 v(xdut.x_ha2.x_s.net2)=5 v(xdut.x_ha2.x_s.net3)=-5 v(xdut.x_ha2.x_s.net4)=-5 v(xdut.x_ha2.x_s.net5)=0 v(xdut.x_ha2.x_s.net6)=0
.nodeset v(xdut.x_ha2.x_na.net1)=5 v(xdut.x_ha2.x_na.net2)=-5
.nodeset v(xdut.x_ha2.x_nd.net1)=5 v(xdut.x_ha2.x_nd.net2)=-5
.nodeset v(xdut.x_cmerge.net1)=5 v(xdut.x_cmerge.net2)=5 v(xdut.x_cmerge.net3)=-5 v(xdut.x_cmerge.net4)=-5 v(xdut.x_cmerge.net5)=0 v(xdut.x_cmerge.net6)=0
.nodeset v(xdut.x_cout.net1)=5 v(xdut.x_cout.net2)=-5
.control
save all
set wr_singlescale
set wr_vecnames
setplot const
let failures=0
tran 0.5n 5600n 0 0.5n
plot v(a) v(b) v(cin) v(sum) ylimit -5.5 5.5 title 'Full Adder SUM'
plot v(a) v(b) v(cin) v(cout) ylimit -5.5 5.5 title 'Full Adder COUT'
wrdata full_adder_tran.txt v(a) v(b) v(cin) v(sum) v(cout) v(xdut.s1) v(xdut.c1) v(xdut.c2) v(xdut.nc)
meas tran tran_00_sum find v(sum) at=199n
if abs(tran_00_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_00_sum expected 0 V
end
meas tran tran_00_cout find v(cout) at=199n
if abs(tran_00_cout-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_00_cout expected -5 V
end
meas tran tran_00_xdut_s1 find v(xdut.s1) at=199n
if abs(tran_00_xdut_s1-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_00_xdut_s1 expected 5 V
end
meas tran tran_00_xdut_c1 find v(xdut.c1) at=199n
if abs(tran_00_xdut_c1-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_00_xdut_c1 expected -5 V
end
meas tran tran_00_xdut_c2 find v(xdut.c2) at=199n
if abs(tran_00_xdut_c2-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_00_xdut_c2 expected 0 V
end
meas tran tran_00_xdut_nc find v(xdut.nc) at=199n
if abs(tran_00_xdut_nc-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_00_xdut_nc expected 5 V
end
meas tran tran_01_sum find v(sum) at=399n
if abs(tran_01_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_01_sum expected 5 V
end
meas tran tran_01_cout find v(cout) at=399n
if abs(tran_01_cout-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_01_cout expected -5 V
end
meas tran tran_01_xdut_s1 find v(xdut.s1) at=399n
if abs(tran_01_xdut_s1-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_01_xdut_s1 expected 5 V
end
meas tran tran_01_xdut_c1 find v(xdut.c1) at=399n
if abs(tran_01_xdut_c1-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_01_xdut_c1 expected -5 V
end
meas tran tran_01_xdut_c2 find v(xdut.c2) at=399n
if abs(tran_01_xdut_c2-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_01_xdut_c2 expected 0 V
end
meas tran tran_01_xdut_nc find v(xdut.nc) at=399n
if abs(tran_01_xdut_nc-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_01_xdut_nc expected 5 V
end
meas tran tran_02_sum find v(sum) at=599n
if abs(tran_02_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_02_sum expected -5 V
end
meas tran tran_02_cout find v(cout) at=599n
if abs(tran_02_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_02_cout expected 0 V
end
meas tran tran_02_xdut_s1 find v(xdut.s1) at=599n
if abs(tran_02_xdut_s1-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_02_xdut_s1 expected 5 V
end
meas tran tran_02_xdut_c1 find v(xdut.c1) at=599n
if abs(tran_02_xdut_c1-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_02_xdut_c1 expected -5 V
end
meas tran tran_02_xdut_c2 find v(xdut.c2) at=599n
if abs(tran_02_xdut_c2-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_02_xdut_c2 expected 5 V
end
meas tran tran_02_xdut_nc find v(xdut.nc) at=599n
if abs(tran_02_xdut_nc-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_02_xdut_nc expected 0 V
end
meas tran tran_03_sum find v(sum) at=799n
if abs(tran_03_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_03_sum expected 5 V
end
meas tran tran_03_cout find v(cout) at=799n
if abs(tran_03_cout-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_03_cout expected -5 V
end
meas tran tran_03_xdut_s1 find v(xdut.s1) at=799n
if abs(tran_03_xdut_s1-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_03_xdut_s1 expected -5 V
end
meas tran tran_03_xdut_c1 find v(xdut.c1) at=799n
if abs(tran_03_xdut_c1-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_03_xdut_c1 expected 0 V
end
meas tran tran_03_xdut_c2 find v(xdut.c2) at=799n
if abs(tran_03_xdut_c2-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_03_xdut_c2 expected -5 V
end
meas tran tran_03_xdut_nc find v(xdut.nc) at=799n
if abs(tran_03_xdut_nc-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_03_xdut_nc expected 5 V
end
meas tran tran_04_sum find v(sum) at=999n
if abs(tran_04_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_04_sum expected -5 V
end
meas tran tran_04_cout find v(cout) at=999n
if abs(tran_04_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_04_cout expected 0 V
end
meas tran tran_04_xdut_s1 find v(xdut.s1) at=999n
if abs(tran_04_xdut_s1-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_04_xdut_s1 expected -5 V
end
meas tran tran_04_xdut_c1 find v(xdut.c1) at=999n
if abs(tran_04_xdut_c1-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_04_xdut_c1 expected 0 V
end
meas tran tran_04_xdut_c2 find v(xdut.c2) at=999n
if abs(tran_04_xdut_c2-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_04_xdut_c2 expected 0 V
end
meas tran tran_04_xdut_nc find v(xdut.nc) at=999n
if abs(tran_04_xdut_nc-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_04_xdut_nc expected 0 V
end
meas tran tran_05_sum find v(sum) at=1199n
if abs(tran_05_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_05_sum expected 0 V
end
meas tran tran_05_cout find v(cout) at=1199n
if abs(tran_05_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_05_cout expected 0 V
end
meas tran tran_05_xdut_s1 find v(xdut.s1) at=1199n
if abs(tran_05_xdut_s1-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_05_xdut_s1 expected -5 V
end
meas tran tran_05_xdut_c1 find v(xdut.c1) at=1199n
if abs(tran_05_xdut_c1-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_05_xdut_c1 expected 0 V
end
meas tran tran_05_xdut_c2 find v(xdut.c2) at=1199n
if abs(tran_05_xdut_c2-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_05_xdut_c2 expected 0 V
end
meas tran tran_05_xdut_nc find v(xdut.nc) at=1199n
if abs(tran_05_xdut_nc-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_05_xdut_nc expected 0 V
end
meas tran tran_06_sum find v(sum) at=1399n
if abs(tran_06_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_06_sum expected -5 V
end
meas tran tran_06_cout find v(cout) at=1399n
if abs(tran_06_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_06_cout expected 0 V
end
meas tran tran_06_xdut_s1 find v(xdut.s1) at=1399n
if abs(tran_06_xdut_s1-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_06_xdut_s1 expected 0 V
end
meas tran tran_06_xdut_c1 find v(xdut.c1) at=1399n
if abs(tran_06_xdut_c1-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_06_xdut_c1 expected 0 V
end
meas tran tran_06_xdut_c2 find v(xdut.c2) at=1399n
if abs(tran_06_xdut_c2-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_06_xdut_c2 expected 0 V
end
meas tran tran_06_xdut_nc find v(xdut.nc) at=1399n
if abs(tran_06_xdut_nc-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_06_xdut_nc expected 0 V
end
meas tran tran_07_sum find v(sum) at=1599n
if abs(tran_07_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_07_sum expected 0 V
end
meas tran tran_07_cout find v(cout) at=1599n
if abs(tran_07_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_07_cout expected 0 V
end
meas tran tran_07_xdut_s1 find v(xdut.s1) at=1599n
if abs(tran_07_xdut_s1-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_07_xdut_s1 expected 0 V
end
meas tran tran_07_xdut_c1 find v(xdut.c1) at=1599n
if abs(tran_07_xdut_c1-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_07_xdut_c1 expected 0 V
end
meas tran tran_07_xdut_c2 find v(xdut.c2) at=1599n
if abs(tran_07_xdut_c2-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_07_xdut_c2 expected 0 V
end
meas tran tran_07_xdut_nc find v(xdut.nc) at=1599n
if abs(tran_07_xdut_nc-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_07_xdut_nc expected 0 V
end
meas tran tran_08_sum find v(sum) at=1799n
if abs(tran_08_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_08_sum expected 5 V
end
meas tran tran_08_cout find v(cout) at=1799n
if abs(tran_08_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_08_cout expected 0 V
end
meas tran tran_08_xdut_s1 find v(xdut.s1) at=1799n
if abs(tran_08_xdut_s1-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_08_xdut_s1 expected 0 V
end
meas tran tran_08_xdut_c1 find v(xdut.c1) at=1799n
if abs(tran_08_xdut_c1-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_08_xdut_c1 expected 0 V
end
meas tran tran_08_xdut_c2 find v(xdut.c2) at=1799n
if abs(tran_08_xdut_c2-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_08_xdut_c2 expected 0 V
end
meas tran tran_08_xdut_nc find v(xdut.nc) at=1799n
if abs(tran_08_xdut_nc-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_08_xdut_nc expected 0 V
end
meas tran tran_09_sum find v(sum) at=1999n
if abs(tran_09_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_09_sum expected 5 V
end
meas tran tran_09_cout find v(cout) at=1999n
if abs(tran_09_cout-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_09_cout expected -5 V
end
meas tran tran_09_xdut_s1 find v(xdut.s1) at=1999n
if abs(tran_09_xdut_s1-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_09_xdut_s1 expected -5 V
end
meas tran tran_09_xdut_c1 find v(xdut.c1) at=1999n
if abs(tran_09_xdut_c1-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_09_xdut_c1 expected 0 V
end
meas tran tran_09_xdut_c2 find v(xdut.c2) at=1999n
if abs(tran_09_xdut_c2-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_09_xdut_c2 expected -5 V
end
meas tran tran_09_xdut_nc find v(xdut.nc) at=1999n
if abs(tran_09_xdut_nc-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_09_xdut_nc expected 5 V
end
meas tran tran_10_sum find v(sum) at=2199n
if abs(tran_10_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_10_sum expected -5 V
end
meas tran tran_10_cout find v(cout) at=2199n
if abs(tran_10_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_10_cout expected 0 V
end
meas tran tran_10_xdut_s1 find v(xdut.s1) at=2199n
if abs(tran_10_xdut_s1-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_10_xdut_s1 expected -5 V
end
meas tran tran_10_xdut_c1 find v(xdut.c1) at=2199n
if abs(tran_10_xdut_c1-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_10_xdut_c1 expected 0 V
end
meas tran tran_10_xdut_c2 find v(xdut.c2) at=2199n
if abs(tran_10_xdut_c2-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_10_xdut_c2 expected 0 V
end
meas tran tran_10_xdut_nc find v(xdut.nc) at=2199n
if abs(tran_10_xdut_nc-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_10_xdut_nc expected 0 V
end
meas tran tran_11_sum find v(sum) at=2399n
if abs(tran_11_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_11_sum expected 0 V
end
meas tran tran_11_cout find v(cout) at=2399n
if abs(tran_11_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_11_cout expected 0 V
end
meas tran tran_11_xdut_s1 find v(xdut.s1) at=2399n
if abs(tran_11_xdut_s1-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_11_xdut_s1 expected -5 V
end
meas tran tran_11_xdut_c1 find v(xdut.c1) at=2399n
if abs(tran_11_xdut_c1-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_11_xdut_c1 expected 0 V
end
meas tran tran_11_xdut_c2 find v(xdut.c2) at=2399n
if abs(tran_11_xdut_c2-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_11_xdut_c2 expected 0 V
end
meas tran tran_11_xdut_nc find v(xdut.nc) at=2399n
if abs(tran_11_xdut_nc-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_11_xdut_nc expected 0 V
end
meas tran tran_12_sum find v(sum) at=2599n
if abs(tran_12_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_12_sum expected -5 V
end
meas tran tran_12_cout find v(cout) at=2599n
if abs(tran_12_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_12_cout expected 0 V
end
meas tran tran_12_xdut_s1 find v(xdut.s1) at=2599n
if abs(tran_12_xdut_s1-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_12_xdut_s1 expected 0 V
end
meas tran tran_12_xdut_c1 find v(xdut.c1) at=2599n
if abs(tran_12_xdut_c1-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_12_xdut_c1 expected 0 V
end
meas tran tran_12_xdut_c2 find v(xdut.c2) at=2599n
if abs(tran_12_xdut_c2-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_12_xdut_c2 expected 0 V
end
meas tran tran_12_xdut_nc find v(xdut.nc) at=2599n
if abs(tran_12_xdut_nc-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_12_xdut_nc expected 0 V
end
meas tran tran_13_sum find v(sum) at=2799n
if abs(tran_13_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_13_sum expected 0 V
end
meas tran tran_13_cout find v(cout) at=2799n
if abs(tran_13_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_13_cout expected 0 V
end
meas tran tran_13_xdut_s1 find v(xdut.s1) at=2799n
if abs(tran_13_xdut_s1-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_13_xdut_s1 expected 0 V
end
meas tran tran_13_xdut_c1 find v(xdut.c1) at=2799n
if abs(tran_13_xdut_c1-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_13_xdut_c1 expected 0 V
end
meas tran tran_13_xdut_c2 find v(xdut.c2) at=2799n
if abs(tran_13_xdut_c2-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_13_xdut_c2 expected 0 V
end
meas tran tran_13_xdut_nc find v(xdut.nc) at=2799n
if abs(tran_13_xdut_nc-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_13_xdut_nc expected 0 V
end
meas tran tran_14_sum find v(sum) at=2999n
if abs(tran_14_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_14_sum expected 5 V
end
meas tran tran_14_cout find v(cout) at=2999n
if abs(tran_14_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_14_cout expected 0 V
end
meas tran tran_14_xdut_s1 find v(xdut.s1) at=2999n
if abs(tran_14_xdut_s1-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_14_xdut_s1 expected 0 V
end
meas tran tran_14_xdut_c1 find v(xdut.c1) at=2999n
if abs(tran_14_xdut_c1-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_14_xdut_c1 expected 0 V
end
meas tran tran_14_xdut_c2 find v(xdut.c2) at=2999n
if abs(tran_14_xdut_c2-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_14_xdut_c2 expected 0 V
end
meas tran tran_14_xdut_nc find v(xdut.nc) at=2999n
if abs(tran_14_xdut_nc-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_14_xdut_nc expected 0 V
end
meas tran tran_15_sum find v(sum) at=3199n
if abs(tran_15_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_15_sum expected 0 V
end
meas tran tran_15_cout find v(cout) at=3199n
if abs(tran_15_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_15_cout expected 0 V
end
meas tran tran_15_xdut_s1 find v(xdut.s1) at=3199n
if abs(tran_15_xdut_s1-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_15_xdut_s1 expected 5 V
end
meas tran tran_15_xdut_c1 find v(xdut.c1) at=3199n
if abs(tran_15_xdut_c1-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_15_xdut_c1 expected 0 V
end
meas tran tran_15_xdut_c2 find v(xdut.c2) at=3199n
if abs(tran_15_xdut_c2-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_15_xdut_c2 expected 0 V
end
meas tran tran_15_xdut_nc find v(xdut.nc) at=3199n
if abs(tran_15_xdut_nc-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_15_xdut_nc expected 0 V
end
meas tran tran_16_sum find v(sum) at=3399n
if abs(tran_16_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_16_sum expected 5 V
end
meas tran tran_16_cout find v(cout) at=3399n
if abs(tran_16_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_16_cout expected 0 V
end
meas tran tran_16_xdut_s1 find v(xdut.s1) at=3399n
if abs(tran_16_xdut_s1-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_16_xdut_s1 expected 5 V
end
meas tran tran_16_xdut_c1 find v(xdut.c1) at=3399n
if abs(tran_16_xdut_c1-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_16_xdut_c1 expected 0 V
end
meas tran tran_16_xdut_c2 find v(xdut.c2) at=3399n
if abs(tran_16_xdut_c2-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_16_xdut_c2 expected 0 V
end
meas tran tran_16_xdut_nc find v(xdut.nc) at=3399n
if abs(tran_16_xdut_nc-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_16_xdut_nc expected 0 V
end
meas tran tran_17_sum find v(sum) at=3599n
if abs(tran_17_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_17_sum expected -5 V
end
meas tran tran_17_cout find v(cout) at=3599n
if abs(tran_17_cout-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_17_cout expected 5 V
end
meas tran tran_17_xdut_s1 find v(xdut.s1) at=3599n
if abs(tran_17_xdut_s1-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_17_xdut_s1 expected 5 V
end
meas tran tran_17_xdut_c1 find v(xdut.c1) at=3599n
if abs(tran_17_xdut_c1-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_17_xdut_c1 expected 0 V
end
meas tran tran_17_xdut_c2 find v(xdut.c2) at=3599n
if abs(tran_17_xdut_c2-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_17_xdut_c2 expected 5 V
end
meas tran tran_17_xdut_nc find v(xdut.nc) at=3599n
if abs(tran_17_xdut_nc-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_17_xdut_nc expected -5 V
end
meas tran tran_18_sum find v(sum) at=3799n
if abs(tran_18_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_18_sum expected -5 V
end
meas tran tran_18_cout find v(cout) at=3799n
if abs(tran_18_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_18_cout expected 0 V
end
meas tran tran_18_xdut_s1 find v(xdut.s1) at=3799n
if abs(tran_18_xdut_s1-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_18_xdut_s1 expected 0 V
end
meas tran tran_18_xdut_c1 find v(xdut.c1) at=3799n
if abs(tran_18_xdut_c1-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_18_xdut_c1 expected 0 V
end
meas tran tran_18_xdut_c2 find v(xdut.c2) at=3799n
if abs(tran_18_xdut_c2-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_18_xdut_c2 expected 0 V
end
meas tran tran_18_xdut_nc find v(xdut.nc) at=3799n
if abs(tran_18_xdut_nc-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_18_xdut_nc expected 0 V
end
meas tran tran_19_sum find v(sum) at=3999n
if abs(tran_19_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_19_sum expected 0 V
end
meas tran tran_19_cout find v(cout) at=3999n
if abs(tran_19_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_19_cout expected 0 V
end
meas tran tran_19_xdut_s1 find v(xdut.s1) at=3999n
if abs(tran_19_xdut_s1-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_19_xdut_s1 expected 0 V
end
meas tran tran_19_xdut_c1 find v(xdut.c1) at=3999n
if abs(tran_19_xdut_c1-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_19_xdut_c1 expected 0 V
end
meas tran tran_19_xdut_c2 find v(xdut.c2) at=3999n
if abs(tran_19_xdut_c2-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_19_xdut_c2 expected 0 V
end
meas tran tran_19_xdut_nc find v(xdut.nc) at=3999n
if abs(tran_19_xdut_nc-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_19_xdut_nc expected 0 V
end
meas tran tran_20_sum find v(sum) at=4199n
if abs(tran_20_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_20_sum expected 5 V
end
meas tran tran_20_cout find v(cout) at=4199n
if abs(tran_20_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_20_cout expected 0 V
end
meas tran tran_20_xdut_s1 find v(xdut.s1) at=4199n
if abs(tran_20_xdut_s1-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_20_xdut_s1 expected 0 V
end
meas tran tran_20_xdut_c1 find v(xdut.c1) at=4199n
if abs(tran_20_xdut_c1-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_20_xdut_c1 expected 0 V
end
meas tran tran_20_xdut_c2 find v(xdut.c2) at=4199n
if abs(tran_20_xdut_c2-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_20_xdut_c2 expected 0 V
end
meas tran tran_20_xdut_nc find v(xdut.nc) at=4199n
if abs(tran_20_xdut_nc-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_20_xdut_nc expected 0 V
end
meas tran tran_21_sum find v(sum) at=4399n
if abs(tran_21_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_21_sum expected 0 V
end
meas tran tran_21_cout find v(cout) at=4399n
if abs(tran_21_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_21_cout expected 0 V
end
meas tran tran_21_xdut_s1 find v(xdut.s1) at=4399n
if abs(tran_21_xdut_s1-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_21_xdut_s1 expected 5 V
end
meas tran tran_21_xdut_c1 find v(xdut.c1) at=4399n
if abs(tran_21_xdut_c1-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_21_xdut_c1 expected 0 V
end
meas tran tran_21_xdut_c2 find v(xdut.c2) at=4399n
if abs(tran_21_xdut_c2-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_21_xdut_c2 expected 0 V
end
meas tran tran_21_xdut_nc find v(xdut.nc) at=4399n
if abs(tran_21_xdut_nc-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_21_xdut_nc expected 0 V
end
meas tran tran_22_sum find v(sum) at=4599n
if abs(tran_22_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_22_sum expected 5 V
end
meas tran tran_22_cout find v(cout) at=4599n
if abs(tran_22_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_22_cout expected 0 V
end
meas tran tran_22_xdut_s1 find v(xdut.s1) at=4599n
if abs(tran_22_xdut_s1-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_22_xdut_s1 expected 5 V
end
meas tran tran_22_xdut_c1 find v(xdut.c1) at=4599n
if abs(tran_22_xdut_c1-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_22_xdut_c1 expected 0 V
end
meas tran tran_22_xdut_c2 find v(xdut.c2) at=4599n
if abs(tran_22_xdut_c2-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_22_xdut_c2 expected 0 V
end
meas tran tran_22_xdut_nc find v(xdut.nc) at=4599n
if abs(tran_22_xdut_nc-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_22_xdut_nc expected 0 V
end
meas tran tran_23_sum find v(sum) at=4799n
if abs(tran_23_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_23_sum expected -5 V
end
meas tran tran_23_cout find v(cout) at=4799n
if abs(tran_23_cout-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_23_cout expected 5 V
end
meas tran tran_23_xdut_s1 find v(xdut.s1) at=4799n
if abs(tran_23_xdut_s1-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_23_xdut_s1 expected 5 V
end
meas tran tran_23_xdut_c1 find v(xdut.c1) at=4799n
if abs(tran_23_xdut_c1-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_23_xdut_c1 expected 0 V
end
meas tran tran_23_xdut_c2 find v(xdut.c2) at=4799n
if abs(tran_23_xdut_c2-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_23_xdut_c2 expected 5 V
end
meas tran tran_23_xdut_nc find v(xdut.nc) at=4799n
if abs(tran_23_xdut_nc-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_23_xdut_nc expected -5 V
end
meas tran tran_24_sum find v(sum) at=4999n
if abs(tran_24_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_24_sum expected 5 V
end
meas tran tran_24_cout find v(cout) at=4999n
if abs(tran_24_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_24_cout expected 0 V
end
meas tran tran_24_xdut_s1 find v(xdut.s1) at=4999n
if abs(tran_24_xdut_s1-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_24_xdut_s1 expected -5 V
end
meas tran tran_24_xdut_c1 find v(xdut.c1) at=4999n
if abs(tran_24_xdut_c1-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_24_xdut_c1 expected 5 V
end
meas tran tran_24_xdut_c2 find v(xdut.c2) at=4999n
if abs(tran_24_xdut_c2-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_24_xdut_c2 expected -5 V
end
meas tran tran_24_xdut_nc find v(xdut.nc) at=4999n
if abs(tran_24_xdut_nc-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_24_xdut_nc expected 0 V
end
meas tran tran_25_sum find v(sum) at=5199n
if abs(tran_25_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_25_sum expected -5 V
end
meas tran tran_25_cout find v(cout) at=5199n
if abs(tran_25_cout-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_25_cout expected 5 V
end
meas tran tran_25_xdut_s1 find v(xdut.s1) at=5199n
if abs(tran_25_xdut_s1-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_25_xdut_s1 expected -5 V
end
meas tran tran_25_xdut_c1 find v(xdut.c1) at=5199n
if abs(tran_25_xdut_c1-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_25_xdut_c1 expected 5 V
end
meas tran tran_25_xdut_c2 find v(xdut.c2) at=5199n
if abs(tran_25_xdut_c2-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_25_xdut_c2 expected 0 V
end
meas tran tran_25_xdut_nc find v(xdut.nc) at=5199n
if abs(tran_25_xdut_nc-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_25_xdut_nc expected -5 V
end
meas tran tran_26_sum find v(sum) at=5399n
if abs(tran_26_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_26_sum expected 0 V
end
meas tran tran_26_cout find v(cout) at=5399n
if abs(tran_26_cout-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_26_cout expected 5 V
end
meas tran tran_26_xdut_s1 find v(xdut.s1) at=5399n
if abs(tran_26_xdut_s1-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_26_xdut_s1 expected -5 V
end
meas tran tran_26_xdut_c1 find v(xdut.c1) at=5399n
if abs(tran_26_xdut_c1-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_26_xdut_c1 expected 5 V
end
meas tran tran_26_xdut_c2 find v(xdut.c2) at=5399n
if abs(tran_26_xdut_c2-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_26_xdut_c2 expected 0 V
end
meas tran tran_26_xdut_nc find v(xdut.nc) at=5399n
if abs(tran_26_xdut_nc-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_26_xdut_nc expected -5 V
end
meas tran tran_27_sum find v(sum) at=5599n
if abs(tran_27_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_27_sum expected 0 V
end
meas tran tran_27_cout find v(cout) at=5599n
if abs(tran_27_cout-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_27_cout expected -5 V
end
meas tran tran_27_xdut_s1 find v(xdut.s1) at=5599n
if abs(tran_27_xdut_s1-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_27_xdut_s1 expected 5 V
end
meas tran tran_27_xdut_c1 find v(xdut.c1) at=5599n
if abs(tran_27_xdut_c1-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_27_xdut_c1 expected -5 V
end
meas tran tran_27_xdut_c2 find v(xdut.c2) at=5599n
if abs(tran_27_xdut_c2-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_27_xdut_c2 expected 0 V
end
meas tran tran_27_xdut_nc find v(xdut.nc) at=5599n
if abs(tran_27_xdut_nc-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_27_xdut_nc expected 5 V
end
if const.failures = 0
echo PASS: Full Adder 27 triples plus return; SUM/COUT and internal interconnects
else
echo FAIL: Full Adder samples outside +/-0.5 V
end
print const.failures
.endc"}
C {devices/netlist_options.sym} 700 1080 0 0 {name=NETLIST_OPTIONS
lvs_netlist=false
top_is_subckt=false
spiceprefix=true
hiersep=.}
