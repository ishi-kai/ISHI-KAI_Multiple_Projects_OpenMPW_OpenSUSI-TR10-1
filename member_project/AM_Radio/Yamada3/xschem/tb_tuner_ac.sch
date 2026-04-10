v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
L 4 790 -1360 810 -1340 {}
L 4 790 -1360 795 -1360 {}
L 4 790 -1360 790 -1355 {}
L 4 590 -1390 770 -1390 {}
L 4 770 -1390 770 -1270 {}
L 4 590 -1270 770 -1270 {}
L 4 590 -1390 590 -1270 {}
L 4 640 -1460 640 -1420 {}
L 4 640 -1460 650 -1470 {}
L 4 630 -1470 640 -1460 {}
L 4 630 -1470 650 -1470 {}
L 4 810 -1330 860 -1110 {}
L 4 530 -1110 600 -1270 {}
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
sim_type=ac
y1=-3
rawfile=$netlist_dir/tb_tuner_ac.raw
autoload=1
y2=1
x2=7
x1=4
hilight_wave=0}
T {Tuner - AC analysis} 430 -1615 0 0 0.8 0.8 {}
T {Bar antenna:
L6:10turn
L5:100turn} 630 -1105 0 1 0.5 0.5 {}
T {Variable capacitor:
C1:Range 25-160pF} 1030 -1105 0 1 0.5 0.5 {}
T {AM Radio frequency : 500KHz - 1Meg
Frequency turing -> Adjust C1,C2,L5
Resonace Filter Q turning -> Adjust R2
Sensivity turing -> Adjust turn ratio between L6 and L5} 1800 -1045 0 1 0.5 0.5 {}
T {Rod antenna} 820 -1475 0 1 0.5 0.5 {}
N 480 -1260 480 -1240 {lab=GND}
N 480 -1360 480 -1320 {lab=in}
N 720 -1300 720 -1240 {lab=#net1}
N 720 -1320 720 -1300 {lab=#net1}
N 800 -1320 800 -1300 {lab=#net1}
N 720 -1300 780 -1300 {lab=#net1}
N 640 -1420 640 -1380 {lab=in}
N 720 -1400 720 -1380 {lab=out}
N 800 -1400 800 -1380 {lab=out}
N 720 -1400 780 -1400 {lab=out}
N 640 -1320 640 -1300 {lab=GND}
N 780 -1400 800 -1400 {lab=out}
N 640 -1300 640 -1240 {lab=GND}
N 870 -1400 910 -1400 {lab=out}
N 960 -1400 960 -1360 {lab=out}
N 960 -1300 960 -1240 {lab=VREF}
N 780 -1300 800 -1300 {lab=#net1}
N 800 -1400 870 -1400 {lab=out}
N 910 -1400 940 -1400 {lab=out}
N 940 -1400 980 -1400 {lab=out}
N 800 -1300 860 -1300 {lab=#net1}
N 860 -1320 860 -1300 {lab=#net1}
N 860 -1400 860 -1380 {lab=out}
N 400 -1260 400 -1240 {lab=GND}
N 400 -1340 400 -1320 {lab=VREF}
N 720 -1180 720 -1160 {lab=VREF}
C {devices/code_shown.sym} 425 -1530 0 0 {name=control only_toplevel=false value=".option savecurrent
.control
save all
# AC analysis
ac dec 1k 10 10Meg
write tb_tuner_ac.raw
.endc"}
C {devices/gnd.sym} 480 -1240 0 0 {name=l2 lab=GND}
C {devices/lab_pin.sym} 480 -1360 0 1 {name=p1 sig_type=std_logic lab=in}
C {devices/launcher.sym} 1170 -1520 0 0 {name=h5
descr="load waves (CTRL + LEFT BUTTON CLICK)" 
tclcommand="xschem raw_read $netlist_dir/tb_tuner.raw ac"
}
C {devices/vsource.sym} 480 -1290 0 0 {name=V1 value="dc 0 ac 1m" savecurrent=false}
C {devices/capa.sym} 800 -1350 0 0 {name=C1
m=1
value=160p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 720 -1160 0 1 {name=l1 lab=VREF}
C {devices/lab_pin.sym} 640 -1420 0 0 {name=p4 sig_type=std_logic lab=in}
C {devices/ind.sym} 640 -1350 0 1 {name=L6
m=1
value=36u
footprint=1206
device=inductor}
C {devices/k.sym} 680 -1350 0 1 {name=K1 K=0.9 L1=L5 L2=L6}
C {devices/ind.sym} 720 -1350 0 0 {name=L5
m=1
value=360u
footprint=1206
device=inductor}
C {devices/res.sym} 960 -1330 0 1 {name=R1
value=470k
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 960 -1240 0 1 {name=l8 lab=VREF}
C {devices/lab_pin.sym} 980 -1400 0 1 {name=p2 sig_type=std_logic lab=out}
C {devices/res.sym} 720 -1210 0 1 {name=R2
value=470k
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 640 -1240 0 1 {name=l7 lab=GND}
C {devices/capa.sym} 860 -1350 0 0 {name=C2
m=1
value=680p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 400 -1240 0 0 {name=l3 lab=GND}
C {devices/vsource.sym} 400 -1290 0 0 {name=V2 value="dc 2.5" savecurrent=false}
C {devices/vdd.sym} 400 -1340 0 0 {name=l4 lab=VREF}
