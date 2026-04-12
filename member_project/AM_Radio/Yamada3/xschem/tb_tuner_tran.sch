v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
L 4 950 -1400 970 -1380 {}
L 4 950 -1400 955 -1400 {}
L 4 950 -1400 950 -1395 {}
L 4 750 -1430 930 -1430 {}
L 4 930 -1430 930 -1310 {}
L 4 750 -1310 930 -1310 {}
L 4 750 -1430 750 -1310 {}
L 4 800 -1500 800 -1460 {}
L 4 800 -1500 810 -1510 {}
L 4 790 -1510 800 -1500 {}
L 4 970 -1370 1020 -1150 {}
L 4 690 -1150 760 -1310 {}
B 2 1240 -1720 2040 -1320 {flags=graph
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node=in
color=4
dataset=-1
unitx=1
logx=0
logy=0
rawfile=$netlist_dir/tb_tuner_tran.raw
sim_type=tran
hilight_wave=-1
autoload=1
y1=-3m
y2=3m
x2=5m
x1=0}
B 2 1240 -1280 2040 -880 {flags=graph
y1=2.4
y2=2.6
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node=out1
color=4
dataset=-1
unitx=1
logx=0
logy=0
sim_type=tran
hilight_wave=-1
autoload=1
rawfile=$netlist_dir/tb_tuner_tran.raw
x2=5m
x1=0}
T {Tuner - Transient analysis} 430 -1725 0 0 0.8 0.8 {}
T {Bar antenna:
L6:10turn
L5:100turn} 790 -1145 0 1 0.5 0.5 {}
T {Variable capacitor:
C1:Range 25-160pF} 1190 -1145 0 1 0.5 0.5 {}
T {AM Radio frequency : 500KHz - 1Meg
Frequency tuning -> Adjust C1,C2,L5
Resonace Filter Q tuning -> Adjust R2
Sensitivity tuning -> Adjust turn ratio between L6 and L5} 2010 -865 0 1 0.5 0.5 {}
T {Rod antenna} 980 -1515 0 1 0.5 0.5 {}
T {Mix 3 wave -> Extract 1 wave

Mix:
Carrier,Audio
500KHz,1KHz
800KHz,3KHz
663.74KHz,5KHz

Extract:
663.74KHz,5KHz} 730 -1495 0 1 0.4 0.4 {}
N 880 -700 880 -680 {lab=GND}
N 880 -800 880 -760 {lab=in}
N 790 -780 790 -760 {lab=VDD}
N 790 -700 790 -680 {lab=GND}
N 710 -780 710 -760 {lab=VREF}
N 710 -700 710 -680 {lab=GND}
N 880 -1340 880 -1280 {lab=#net1}
N 880 -1360 880 -1340 {lab=#net1}
N 960 -1360 960 -1340 {lab=#net1}
N 880 -1340 940 -1340 {lab=#net1}
N 800 -1460 800 -1420 {lab=in}
N 880 -1440 880 -1420 {lab=out1}
N 960 -1440 960 -1420 {lab=out1}
N 880 -1440 940 -1440 {lab=out1}
N 800 -1360 800 -1340 {lab=GND}
N 940 -1440 960 -1440 {lab=out1}
N 800 -1340 800 -1280 {lab=GND}
N 1030 -1440 1070 -1440 {lab=out1}
N 1120 -1440 1120 -1400 {lab=out1}
N 1120 -1340 1120 -1280 {lab=VREF}
N 940 -1340 960 -1340 {lab=#net1}
N 960 -1440 1030 -1440 {lab=out1}
N 1070 -1440 1100 -1440 {lab=out1}
N 1100 -1440 1140 -1440 {lab=out1}
N 960 -1340 1020 -1340 {lab=#net1}
N 1020 -1360 1020 -1340 {lab=#net1}
N 1020 -1440 1020 -1420 {lab=out1}
N 880 -1220 880 -1200 {lab=VREF}
C {devices/code_shown.sym} 425 -1640 0 0 {name=control only_toplevel=false value=".option savecurrent
.control
save all
# Transienst analysis
tran 0.1u 5m 0 0.1u
write tb_tuner_tran.raw
.endc"}
C {devices/gnd.sym} 880 -680 0 0 {name=l2 lab=GND}
C {devices/lab_pin.sym} 880 -800 0 1 {name=p1 sig_type=std_logic lab=in}
C {devices/vdd.sym} 790 -780 0 0 {name=l3 lab=VDD}
C {devices/gnd.sym} 790 -680 0 0 {name=l4 lab=GND}
C {devices/vsource.sym} 790 -730 0 0 {name=V2 value="dc 5" savecurrent=false}
C {devices/vdd.sym} 710 -780 0 0 {name=l8 lab=VREF}
C {devices/gnd.sym} 710 -680 0 0 {name=l9 lab=GND}
C {devices/vsource.sym} 710 -730 0 0 {name=V3 value="dc 2.5" savecurrent=false}
C {devices/asrc.sym} 880 -730 0 0 {name=B1 function="V=0.5m*(1+0.5*sin(2*pi*1k*time))*sin(2*pi*500k*time)+0.5m*(1+0.5*sin(2*pi*3k*time))*sin(2*pi*800k*time)+0.5m*(1+0.5*sin(2*pi*5k*time))*sin(2*pi*663.74k*time)"}
C {devices/launcher.sym} 1300 -1750 0 0 {name=h5
descr="load waves (CTRL + LEFT BUTTON CLICK)" 
tclcommand="xschem raw_read $netlist_dir/tb_tuner_tran.raw tran"
}
C {devices/code.sym} 500 -790 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/capa.sym} 960 -1390 0 0 {name=C1
m=1
value=160p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 880 -1200 0 1 {name=l12 lab=VREF}
C {devices/lab_pin.sym} 800 -1460 0 0 {name=p6 sig_type=std_logic lab=in}
C {devices/ind.sym} 800 -1390 0 1 {name=L14
m=1
value=36u
footprint=1206
device=inductor}
C {devices/k.sym} 840 -1390 0 1 {name=K1 K=0.9 L1=L17 L2=L14}
C {devices/ind.sym} 880 -1390 0 0 {name=L17
m=1
value=360u
footprint=1206
device=inductor}
C {devices/res.sym} 1120 -1370 0 1 {name=R1
value=470k
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 1120 -1280 0 1 {name=l18 lab=VREF}
C {devices/lab_pin.sym} 1140 -1440 0 1 {name=p7 sig_type=std_logic lab=out1}
C {devices/res.sym} 880 -1250 0 1 {name=R2
value=470k
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 800 -1280 0 1 {name=l19 lab=GND}
C {devices/capa.sym} 1020 -1390 0 0 {name=C2
m=1
value=680p
footprint=1206
device="ceramic capacitor"}
