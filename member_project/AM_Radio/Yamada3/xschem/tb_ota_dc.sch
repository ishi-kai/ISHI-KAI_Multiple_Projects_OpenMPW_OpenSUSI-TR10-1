v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
L 4 550 -1500 670 -1430 {}
L 4 550 -1360 670 -1430 {}
L 4 550 -1500 550 -1360 {}
L 4 420 -1540 820 -1540 {}
L 4 820 -1540 820 -1180 {}
L 4 420 -1180 820 -1180 {}
L 4 420 -1540 420 -1180 {}
L 4 820 -1180 820 -820 {}
L 4 420 -820 820 -820 {}
L 4 420 -1180 420 -820 {}
B 2 900 -1560 1700 -1160 {flags=graph
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node="i(vmeas_real)
i(vmeas_ideal)"
color="4 7"
dataset=-1
unitx=1
logx=0
logy=0
hilight_wave=0
sim_type=dc
autoload=1
rainbow=0
mode=Line
x2=5
rawfile=$netlist_dir/tb_ota_dc.raw
y1=0
y2=6u}
B 2 900 -1120 1700 -720 {flags=graph
y1=0
y2=2u
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=-0.018485892
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
hilight_wave=-1
sim_type=dc
autoload=1
rainbow=0
mode=Line
x2=4.9815153
rawfile=$netlist_dir/tb_ota_dc.raw
color="4 7"
node="i(gm_real)
i(gm_ideal)"}
A 4 675 -1430 11.18033988749895 116.565051177078 360 {}
A 4 685 -1430 11.18033988749895 116.565051177078 360 {}
T {OTA - DC analysis} 70 -1635 0 0 0.8 0.8 {}
T {OTA} 630 -1485 0 0 0.5 0.5 {}
T {IDEAL} 440 -1525 0 0 0.6 0.6 {}
T {1st order LPF
fc = gm / (2*Pi*C)
gm = 2*Pi*fc*C
gm = 2*3.14*20k*8.856p 
   = 1.113e-6} 60 -945 0 0 0.5 0.5 {}
T {REAL} 440 -1165 0 0 0.6 0.6 {}
N 290 -1030 290 -1010 {lab=GND}
N 290 -1130 290 -1090 {lab=in}
N 200 -1110 200 -1090 {lab=VDD}
N 200 -1030 200 -1010 {lab=GND}
N 500 -880 500 -860 {lab=GND}
N 500 -960 520 -960 {lab=#net1}
N 500 -960 500 -940 {lab=#net1}
N 580 -920 580 -860 {lab=GND}
N 500 -1020 500 -1000 {lab=VREF}
N 500 -1000 520 -1000 {lab=VREF}
N 580 -1060 580 -1050 {lab=VDD}
N 580 -1050 580 -1040 {lab=VDD}
N 500 -1060 500 -1020 {lab=VREF}
N 480 -980 520 -980 {lab=in}
N 660 -980 680 -980 {lab=#net2}
N 740 -980 760 -980 {lab=#net3}
N 760 -980 760 -940 {lab=#net3}
N 760 -880 760 -860 {lab=GND}
N 100 -1110 100 -1090 {lab=VREF}
N 100 -1030 100 -1010 {lab=GND}
N 580 -1480 580 -1460 {lab=VDD}
N 580 -1400 650 -1400 {lab=#net4}
N 510 -1410 510 -1380 {lab=#net5}
N 650 -1430 650 -1400 {lab=#net4}
N 650 -1430 710 -1430 {lab=#net4}
N 510 -1380 510 -1350 {lab=#net5}
N 710 -1430 710 -1410 {lab=#net4}
N 490 -1450 540 -1450 {lab=in}
N 510 -1410 540 -1410 {lab=#net5}
N 510 -1350 510 -1330 {lab=#net5}
N 710 -1240 710 -1220 {lab=GND}
N 710 -1350 710 -1320 {lab=#net5}
N 710 -1320 710 -1300 {lab=#net5}
N 510 -1320 710 -1320 {lab=#net5}
N 510 -1330 510 -1320 {lab=#net5}
C {devices/code_shown.sym} 55 -1530 0 0 {name=control only_toplevel=false value=".option savecurrent
.control
save all
# DC analysis
dc v1  0  5 0.1
let gm_real=deriv(i(vmeas_real))
let gm_ideal=deriv(i(vmeas_ideal))
meas dc result FIND gm_real AT=2.5
print result
write tb_ota_dc.raw
.endc"}
C {devices/gnd.sym} 290 -1010 0 0 {name=l2 lab=GND}
C {devices/lab_pin.sym} 290 -1130 0 1 {name=p1 sig_type=std_logic lab=in}
C {devices/vdd.sym} 200 -1110 0 0 {name=l3 lab=VDD}
C {devices/gnd.sym} 200 -1010 0 0 {name=l4 lab=GND}
C {devices/vsource.sym} 200 -1060 0 0 {name=V2 value="dc 5" savecurrent=false}
C {devices/launcher.sym} 1010 -1600 0 0 {name=h5
descr="load waves (CTRL + LEFT BUTTON CLICK)" 
tclcommand="xschem raw_read $netlist_dir/tb_ota_dc.raw dc"
}
C {devices/vsource.sym} 290 -1060 0 0 {name=V1 value="dc 2.5" savecurrent=false}
C {devices/code.sym} 60 -1300 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/vdd.sym} 580 -1060 0 0 {name=l8 lab=VDD}
C {ota.sym} 580 -980 0 0 {name=x1}
C {devices/isource.sym} 500 -910 0 0 {name=I2 value=80u}
C {devices/gnd.sym} 500 -860 0 0 {name=l10 lab=GND}
C {devices/gnd.sym} 580 -860 0 0 {name=l12 lab=GND}
C {devices/vdd.sym} 500 -1060 0 0 {name=l14 lab=VREF}
C {devices/lab_pin.sym} 480 -980 0 0 {name=p5 sig_type=std_logic lab=in}
C {devices/ammeter.sym} 710 -980 3 0 {name=Vmeas_real savecurrent=true spice_ignore=0}
C {devices/res.sym} 760 -910 0 0 {name=R1
value=0.1
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 760 -860 0 0 {name=l17 lab=GND}
C {devices/vdd.sym} 100 -1110 0 0 {name=l9 lab=VREF}
C {devices/gnd.sym} 100 -1010 0 0 {name=l11 lab=GND}
C {devices/vsource.sym} 100 -1060 0 0 {name=V3 value="dc 2.5" savecurrent=false}
C {devices/vccs.sym} 580 -1430 0 0 {name=G1 value=1.113e-6}
C {devices/vdd.sym} 580 -1480 0 0 {name=l1 lab=VDD}
C {devices/lab_pin.sym} 490 -1450 0 0 {name=p3 sig_type=std_logic lab=in}
C {devices/res.sym} 710 -1270 0 0 {name=R2
value=0.1
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 710 -1220 0 0 {name=l5 lab=GND}
C {devices/ammeter.sym} 710 -1380 0 0 {name=Vmeas_ideal savecurrent=true spice_ignore=0}
