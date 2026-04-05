v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
L 4 500 -1370 620 -1300 {}
L 4 500 -1230 620 -1300 {}
L 4 500 -1370 500 -1230 {}
B 2 1050 -1480 1850 -1080 {flags=graph
ypos1=0
ypos2=2
divy=5
subdivy=8
unity=1
divx=5
subdivx=8
xlabmag=1.0
ylabmag=1.0
node=out
color=4
dataset=-1
unitx=1
logx=1
logy=1
rawfile=$netlist_dir/tb_lpf_ota_ac.raw
sim_type=ac
x1=1
y1=-3
x2=7
y2=0
rainbow=1}
A 4 625 -1300 11.18033988749895 116.565051177078 360 {}
A 4 635 -1300 11.18033988749895 116.565051177078 360 {}
T {Low pass filter - OTA - AC analysis} 430 -1615 0 0 0.8 0.8 {}
T {OTA} 580 -1355 0 0 0.5 0.5 {}
T {1st order LPF
fc = gm / (2*Pi*C)

gm = 2*Pi*fc*C
gm = 2*3.14*20k*8.856p 
   = 1.113e-6} 690 -1515 0 0 0.5 0.5 {}
N 890 -1120 890 -1100 {lab=GND}
N 890 -1220 890 -1180 {lab=in}
N 800 -1200 800 -1180 {lab=VDD}
N 800 -1120 800 -1100 {lab=GND}
N 530 -1350 530 -1330 {lab=VDD}
N 530 -1270 600 -1270 {lab=#net1}
N 660 -1220 660 -1200 {lab=out}
N 660 -1200 660 -1180 {lab=out}
N 660 -1200 700 -1200 {lab=out}
N 460 -1280 460 -1250 {lab=out}
N 600 -1300 600 -1270 {lab=#net1}
N 600 -1300 660 -1300 {lab=#net1}
N 460 -1250 460 -1220 {lab=out}
N 660 -1300 660 -1280 {lab=#net1}
N 440 -1320 490 -1320 {lab=in}
N 460 -1280 490 -1280 {lab=out}
N 460 -1200 660 -1200 {lab=out}
N 460 -1220 460 -1200 {lab=out}
N 660 -1120 660 -1100 {lab=GND}
C {devices/code_shown.sym} 425 -1530 0 0 {name=control only_toplevel=false value=".option savecurrent
.control
save all
# AC analysis
ac dec 20 10 10Meg
write tb_lpf_ota_ac.raw
.endc"}
C {devices/gnd.sym} 890 -1100 0 0 {name=l2 lab=GND}
C {devices/lab_pin.sym} 890 -1220 0 1 {name=p1 sig_type=std_logic lab=in}
C {devices/vdd.sym} 800 -1200 0 0 {name=l3 lab=VDD}
C {devices/gnd.sym} 800 -1100 0 0 {name=l4 lab=GND}
C {devices/vsource.sym} 800 -1150 0 0 {name=V2 value="dc 5" savecurrent=false}
C {devices/launcher.sym} 1180 -1520 0 0 {name=h5
descr="load waves (CTRL + LEFT BUTTON CLICK)" 
tclcommand="xschem raw_read $netlist_dir/tb_lpf_ota_ac.raw ac"
}
C {devices/vsource.sym} 890 -1150 0 0 {name=V1 value="dc 2.5 ac 1" savecurrent=false}
C {devices/vccs.sym} 530 -1300 0 0 {name=G1 value=1.113e-6}
C {devices/ammeter.sym} 660 -1250 0 0 {name=Vmeas savecurrent=true spice_ignore=0}
C {devices/vdd.sym} 530 -1350 0 0 {name=l12 lab=VDD}
C {devices/lab_pin.sym} 700 -1200 0 1 {name=p2 sig_type=std_logic lab=out}
C {devices/lab_pin.sym} 440 -1320 0 0 {name=p3 sig_type=std_logic lab=in}
C {devices/capa.sym} 660 -1150 0 0 {name=C1
m=1
value=8.856p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 660 -1100 0 0 {name=l1 lab=GND}
