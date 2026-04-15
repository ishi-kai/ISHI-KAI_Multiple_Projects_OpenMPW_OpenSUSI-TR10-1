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
L 4 520 -1060 2280 -1060 {}
L 4 520 -1500 2280 -1500 {}
L 4 520 -620 2280 -620 {}
L 4 2280 -1500 2280 -620 {}
L 4 520 -1500 520 -620 {}
L 4 1120 -920 1120 -820 {}
L 4 1120 -820 1320 -820 {}
L 4 1320 -920 1320 -820 {}
L 4 1120 -920 1320 -920 {}
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
node=out_ideal
color=4
dataset=-1
unitx=1
logx=1
logy=1
rawfile=$netlist_dir/tb_lpf_ac.raw
sim_type=ac
x1=3
x2=7
y2=0
rainbow=1
y1=-2}
B 2 1460 -1040 2260 -640 {flags=graph
ypos1=0
ypos2=2
divy=5
subdivy=8
unity=1
divx=5
subdivx=8
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=1
logy=1
rawfile=$netlist_dir/tb_lpf_ac.raw
sim_type=ac
y1=-2
y2=0
rainbow=1
color=4
node=out_real
x1=3
x2=7}
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
T {Buffer:TBD} 1140 -895 0 0 0.5 0.5 {}
N 970 -470 970 -450 {lab=GND}
N 970 -570 970 -530 {lab=in}
N 880 -550 880 -530 {lab=VDD}
N 880 -470 880 -450 {lab=GND}
N 950 -1410 950 -1390 {lab=VDD}
N 950 -1330 1020 -1330 {lab=#net1}
N 1080 -1280 1080 -1260 {lab=#net2}
N 1080 -1260 1080 -1240 {lab=#net2}
N 1080 -1260 1120 -1260 {lab=#net2}
N 880 -1340 880 -1310 {lab=#net2}
N 1020 -1360 1020 -1330 {lab=#net1}
N 1020 -1360 1080 -1360 {lab=#net1}
N 880 -1310 880 -1280 {lab=#net2}
N 1080 -1360 1080 -1340 {lab=#net1}
N 860 -1380 910 -1380 {lab=in}
N 880 -1340 910 -1340 {lab=#net2}
N 880 -1260 1080 -1260 {lab=#net2}
N 880 -1280 880 -1260 {lab=#net2}
N 1080 -1180 1080 -1160 {lab=#net3}
N 1160 -1220 1180 -1220 {lab=GND}
N 1160 -1220 1160 -1160 {lab=GND}
N 1120 -1260 1180 -1260 {lab=#net2}
N 1290 -1240 1340 -1240 {lab=out_ideal}
N 1220 -1210 1220 -1160 {lab=GND}
N 1290 -1270 1290 -1240 {lab=out_ideal}
N 1220 -1270 1290 -1270 {lab=out_ideal}
N 760 -760 760 -740 {lab=GND}
N 760 -840 780 -840 {lab=#net4}
N 760 -840 760 -820 {lab=#net4}
N 840 -800 840 -740 {lab=GND}
N 760 -900 760 -880 {lab=out_real}
N 760 -880 780 -880 {lab=out_real}
N 840 -940 840 -930 {lab=VDD}
N 840 -930 840 -920 {lab=VDD}
N 760 -940 760 -900 {lab=out_real}
N 740 -860 780 -860 {lab=in}
N 920 -860 940 -860 {lab=#net5}
N 1000 -860 1020 -860 {lab=out_real}
N 1020 -860 1020 -820 {lab=out_real}
N 1020 -760 1020 -740 {lab=VREF}
N 800 -550 800 -530 {lab=VREF}
N 800 -470 800 -450 {lab=GND}
N 760 -1010 760 -940 {lab=out_real}
N 760 -1010 1020 -1010 {lab=out_real}
N 1020 -1010 1020 -860 {lab=out_real}
C {devices/code_shown.sym} 565 -560 0 0 {name=control only_toplevel=false value=".option savecurrent
.control
save all
# AC analysis
ac dec 20 10 10Meg
write tb_lpf_ac.raw
.endc"}
C {devices/gnd.sym} 970 -450 0 0 {name=l2 lab=GND}
C {devices/lab_pin.sym} 970 -570 0 1 {name=p1 sig_type=std_logic lab=in}
C {devices/vdd.sym} 880 -550 0 0 {name=l3 lab=VDD}
C {devices/gnd.sym} 880 -450 0 0 {name=l4 lab=GND}
C {devices/vsource.sym} 880 -500 0 0 {name=V2 value="dc 5" savecurrent=false}
C {devices/launcher.sym} 1590 -1520 0 0 {name=h5
descr="load waves (CTRL + LEFT BUTTON CLICK)" 
tclcommand="xschem raw_read $netlist_dir/tb_lpf_ac.raw ac"
}
C {devices/vsource.sym} 970 -500 0 0 {name=V1 value="dc 2.5 ac 0.5" savecurrent=false}
C {devices/vccs.sym} 950 -1360 0 0 {name=G1 value=1.113e-6}
C {devices/ammeter.sym} 1080 -1310 0 0 {name=Vmeas savecurrent=true spice_ignore=0}
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
C {devices/isource.sym} 760 -790 0 0 {name=I2 value=80u}
C {devices/gnd.sym} 760 -740 0 0 {name=l10 lab=GND}
C {devices/gnd.sym} 840 -740 0 0 {name=l5 lab=GND}
C {devices/lab_pin.sym} 740 -860 0 0 {name=p5 sig_type=std_logic lab=in}
C {devices/ammeter.sym} 970 -860 3 0 {name=Vmeas1 savecurrent=true spice_ignore=0}
C {devices/gnd.sym} 1020 -740 0 0 {name=l17 lab=VREF}
C {devices/capa.sym} 1020 -790 0 0 {name=C2
m=1
value=8.856p
footprint=1206
device="ceramic capacitor"}
C {devices/lab_pin.sym} 1020 -860 0 1 {name=p4 sig_type=std_logic lab=out_real}
C {devices/vdd.sym} 800 -550 0 0 {name=l9 lab=VREF}
C {devices/gnd.sym} 800 -450 0 0 {name=l11 lab=GND}
C {devices/vsource.sym} 800 -500 0 0 {name=V3 value="dc 5" savecurrent=false}
C {devices/code.sym} 1085 -550 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/gnd.sym} 1080 -1160 0 0 {name=l1 lab=VREF}
