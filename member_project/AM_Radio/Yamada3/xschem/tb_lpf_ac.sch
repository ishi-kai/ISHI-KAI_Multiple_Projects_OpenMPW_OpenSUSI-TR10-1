v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
L 4 920 -1430 1040 -1360 {}
L 4 920 -1290 1040 -1360 {}
L 4 920 -1430 920 -1290 {}
L 4 1190 -1310 1310 -1240 {}
L 4 1190 -1170 1310 -1240 {}
L 4 1190 -1310 1190 -1170 {}
L 4 520 -1060 1440 -1060 {}
L 4 520 -1500 1440 -1500 {}
L 4 520 -620 1440 -620 {}
L 4 1440 -1500 1440 -620 {}
L 4 520 -1500 520 -620 {}
B 2 1460 -1480 2260 -1080 {flags=graph
ypos1=0
ypos2=2
divy=5
subdivy=8
unity=1
divx=5
subdivx=8
xlabmag=1.0
ylabmag=1.0
node="out_ideal
out_real"
color="7 4"
dataset=-1
unitx=1
logx=1
logy=1
rawfile=$netlist_dir/tb_lpf_ac.raw
sim_type=ac
rainbow=1
x2=7
y1=-3
y2=0
x1=1}
A 4 1045 -1360 11.18033988749895 116.565051177078 360 {}
A 4 1055 -1360 11.18033988749895 116.565051177078 360 {}
T {Low pass filter - OTA - AC analysis} 520 -1565 0 0 0.8 0.8 {}
T {OTA} 1000 -1415 0 0 0.5 0.5 {}
T {1st order LPF
fc = gm / (2*Pi*C)
gm = 2*Pi*fc*C
gm = 2*3.14*20k*8.856p 
   = 1.113e-6} 540 -1425 0 0 0.5 0.5 {}
T {Buffer} 1260 -1315 0 0 0.5 0.5 {}
T {IDEAL} 540 -1485 0 0 0.6 0.6 {}
T {REAL} 540 -1045 0 0 0.6 0.6 {}
N 1870 -910 1870 -890 {lab=GND}
N 1870 -1010 1870 -970 {lab=in}
N 1780 -990 1780 -970 {lab=VDD}
N 1780 -910 1780 -890 {lab=GND}
N 950 -1410 950 -1390 {lab=VDD}
N 950 -1330 1020 -1330 {lab=#net1}
N 1080 -1280 1080 -1260 {lab=#net1}
N 1080 -1260 1080 -1240 {lab=#net1}
N 1080 -1260 1120 -1260 {lab=#net1}
N 880 -1340 880 -1310 {lab=#net1}
N 1020 -1360 1020 -1330 {lab=#net1}
N 1020 -1360 1080 -1360 {lab=#net1}
N 880 -1310 880 -1280 {lab=#net1}
N 1080 -1360 1080 -1340 {lab=#net1}
N 860 -1380 910 -1380 {lab=in}
N 880 -1340 910 -1340 {lab=#net1}
N 880 -1260 1080 -1260 {lab=#net1}
N 880 -1280 880 -1260 {lab=#net1}
N 1080 -1180 1080 -1160 {lab=VREF}
N 1160 -1220 1180 -1220 {lab=GND}
N 1160 -1220 1160 -1160 {lab=GND}
N 1120 -1260 1180 -1260 {lab=#net1}
N 1290 -1240 1340 -1240 {lab=out_ideal}
N 1220 -1210 1220 -1160 {lab=GND}
N 1290 -1270 1290 -1240 {lab=out_ideal}
N 1220 -1270 1290 -1270 {lab=out_ideal}
N 760 -760 760 -740 {lab=GND}
N 760 -840 780 -840 {lab=#net2}
N 760 -840 760 -820 {lab=#net2}
N 840 -800 840 -740 {lab=GND}
N 760 -900 760 -880 {lab=#net3}
N 760 -880 780 -880 {lab=#net3}
N 840 -940 840 -930 {lab=VDD}
N 840 -930 840 -920 {lab=VDD}
N 760 -940 760 -900 {lab=#net3}
N 740 -860 780 -860 {lab=in}
N 940 -760 940 -740 {lab=VREF}
N 1700 -990 1700 -970 {lab=VREF}
N 1700 -910 1700 -890 {lab=GND}
N 760 -1010 760 -940 {lab=#net3}
N 760 -1010 940 -1010 {lab=#net3}
N 1080 -1340 1080 -1280 {lab=#net1}
N 1320 -1140 1320 -1120 {lab=GND}
N 1320 -1240 1320 -1200 {lab=out_ideal}
N 940 -860 940 -820 {lab=#net3}
N 1260 -840 1280 -840 {lab=out_real}
N 1280 -840 1280 -820 {lab=out_real}
N 1280 -760 1280 -740 {lab=GND}
N 1280 -840 1300 -840 {lab=out_real}
N 1180 -780 1180 -760 {lab=GND}
N 1180 -920 1180 -900 {lab=VDD}
N 1120 -820 1120 -790 {lab=out_real}
N 1240 -840 1240 -790 {lab=out_real}
N 1120 -790 1240 -790 {lab=out_real}
N 1100 -880 1120 -880 {lab=#net4}
N 1020 -760 1020 -740 {lab=GND}
N 1040 -880 1100 -880 {lab=#net4}
N 1080 -860 1120 -860 {lab=#net3}
N 1020 -880 1040 -880 {lab=#net4}
N 1020 -880 1020 -820 {lab=#net4}
N 1240 -840 1260 -840 {lab=out_real}
N 1180 -760 1180 -740 {lab=GND}
N 930 -860 1080 -860 {lab=#net3}
N 920 -860 930 -860 {lab=#net3}
N 940 -1010 940 -860 {lab=#net3}
C {devices/code_shown.sym} 1465 -1000 0 0 {name=control only_toplevel=false value=".option savecurrent
.control
save all
# AC analysis
ac dec 20 10 10Meg
write tb_lpf_ac.raw
.endc"}
C {devices/gnd.sym} 1870 -890 0 0 {name=l2 lab=GND}
C {devices/lab_pin.sym} 1870 -1010 0 1 {name=p1 sig_type=std_logic lab=in}
C {devices/vdd.sym} 1780 -990 0 0 {name=l3 lab=VDD}
C {devices/gnd.sym} 1780 -890 0 0 {name=l4 lab=GND}
C {devices/vsource.sym} 1780 -940 0 0 {name=V2 value="dc 5" savecurrent=false}
C {devices/launcher.sym} 1590 -1520 0 0 {name=h5
descr="load waves (CTRL + LEFT BUTTON CLICK)" 
tclcommand="xschem raw_read $netlist_dir/tb_lpf_ac.raw ac"
}
C {devices/vsource.sym} 1870 -940 0 0 {name=V1 value="dc 2.5 ac 0.5" savecurrent=false}
C {devices/vccs.sym} 950 -1360 0 0 {name=G1 value=1.113e-6}
C {devices/vdd.sym} 950 -1410 0 0 {name=l12 lab=VDD}
C {devices/lab_pin.sym} 1340 -1240 0 1 {name=p2 sig_type=std_logic lab=out_ideal}
C {devices/lab_pin.sym} 860 -1380 0 0 {name=p3 sig_type=std_logic lab=in}
C {devices/capa.sym} 1080 -1210 0 0 {name=C1
m=1
value=8.856p
footprint=1206
device="ceramic capacitor"}
C {devices/vcvs.sym} 1220 -1240 0 0 {name=E1 value=1}
C {devices/gnd.sym} 1160 -1160 0 0 {name=l6 lab=GND}
C {devices/gnd.sym} 1220 -1160 0 0 {name=l7 lab=GND}
C {devices/vdd.sym} 840 -940 0 0 {name=l8 lab=VDD}
C {ota.sym} 840 -860 0 0 {name=x1}
C {devices/isource.sym} 760 -790 0 0 {name=I2 value=10u}
C {devices/gnd.sym} 760 -740 0 0 {name=l10 lab=GND}
C {devices/gnd.sym} 840 -740 0 0 {name=l5 lab=GND}
C {devices/lab_pin.sym} 740 -860 0 0 {name=p5 sig_type=std_logic lab=in}
C {devices/gnd.sym} 940 -740 0 0 {name=l17 lab=VREF}
C {devices/capa.sym} 940 -790 0 0 {name=C2
m=1
value=8.856p
footprint=1206
device="ceramic capacitor"}
C {devices/vdd.sym} 1700 -990 0 0 {name=l9 lab=VREF}
C {devices/gnd.sym} 1700 -890 0 0 {name=l11 lab=GND}
C {devices/vsource.sym} 1700 -940 0 0 {name=V3 value="dc 5" savecurrent=false}
C {devices/code.sym} 1985 -990 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/gnd.sym} 1080 -1160 0 0 {name=l1 lab=VREF}
C {devices/res.sym} 1320 -1170 0 0 {name=R2
value=1Meg
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 1320 -1120 0 0 {name=l18 lab=GND}
C {devices/isource.sym} 1020 -790 0 0 {name=I3 value=50u}
C {devices/gnd.sym} 1180 -740 0 0 {name=l19 lab=GND}
C {devices/res.sym} 1280 -790 0 0 {name=R3
value=1Meg
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 1280 -740 0 0 {name=l20 lab=GND}
C {devices/lab_pin.sym} 1300 -840 0 1 {name=p7 sig_type=std_logic lab=out_real}
C {opamp.sym} 1140 -840 0 0 {name=X3}
C {devices/vdd.sym} 1180 -920 0 0 {name=l21 lab=VDD}
C {devices/gnd.sym} 1020 -740 0 0 {name=l22 lab=GND}
