v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
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
rawfile=$netlist_dir/tb_abs_tran.raw
sim_type=tran
hilight_wave=-1
x1=0
autoload=1
y1=0
y2=5
x2=5m}
B 2 1240 -1280 2040 -880 {flags=graph
y1=0
y2=5
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
node=out
color=4
dataset=-1
unitx=1
logx=0
logy=0
sim_type=tran
hilight_wave=-1
autoload=1
rawfile=$netlist_dir/tb_abs_tran.raw
x2=5m}
T {Absolute Function - Transient analysis} 430 -1725 0 0 0.8 0.8 {}
N 830 -1280 830 -1260 {lab=GND}
N 830 -1380 830 -1340 {lab=in}
N 740 -1360 740 -1340 {lab=VDD}
N 740 -1280 740 -1260 {lab=GND}
N 660 -1360 660 -1340 {lab=VREF}
N 660 -1280 660 -1260 {lab=GND}
N 860 -980 900 -980 {lab=in}
N 780 -1145 780 -1120 {lab=VDD}
N 720 -1090 780 -1090 {lab=VDD}
N 720 -1145 720 -1090 {lab=VDD}
N 720 -1145 780 -1145 {lab=VDD}
N 960 -1140 960 -1120 {lab=VDD}
N 840 -1090 840 -1040 {lab=#net1}
N 960 -1140 1020 -1140 {lab=VDD}
N 1020 -1140 1020 -1090 {lab=VDD}
N 960 -1090 1020 -1090 {lab=VDD}
N 960 -1020 960 -980 {lab=out}
N 960 -1020 1020 -1020 {lab=out}
N 930 -1020 930 -980 {lab=VDD}
N 540 -1160 540 -1140 {lab=VREF}
N 540 -1110 600 -1110 {lab=VDD}
N 540 -1060 540 -1020 {lab=VREF2}
N 480 -1110 500 -1110 {lab=VREF2}
N 480 -1110 480 -1060 {lab=VREF2}
N 480 -1060 540 -1060 {lab=VREF2}
N 540 -940 540 -920 {lab=GND}
N 540 -1020 620 -1020 {lab=VREF2}
N 600 -1160 600 -1110 {lab=VDD}
N 930 -940 930 -920 {lab=VREF2}
N 780 -940 780 -920 {lab=GND}
N 540 -1020 540 -1000 {lab=VREF2}
N 780 -1040 780 -1000 {lab=#net1}
N 780 -1040 840 -1040 {lab=#net1}
N 840 -1090 920 -1090 {lab=#net1}
N 780 -1160 780 -1145 {lab=VDD}
N 820 -1090 840 -1090 {lab=#net1}
N 960 -1160 960 -1140 {lab=VDD}
N 960 -1060 960 -1020 {lab=out}
N 540 -1080 540 -1060 {lab=VREF2}
N 780 -1060 780 -1040 {lab=#net1}
C {devices/code_shown.sym} 425 -1640 0 0 {name=control only_toplevel=false value=".option savecurrent
.control
save all
# Transienst analysis
tran 0.1u 5m 0 0.1u
write tb_abs_tran.raw
.endc"}
C {devices/gnd.sym} 830 -1260 0 0 {name=l2 lab=GND}
C {devices/lab_pin.sym} 830 -1380 0 1 {name=p1 sig_type=std_logic lab=in}
C {devices/vdd.sym} 740 -1360 0 0 {name=l3 lab=VDD}
C {devices/gnd.sym} 740 -1260 0 0 {name=l4 lab=GND}
C {devices/vsource.sym} 740 -1310 0 0 {name=V2 value="dc 5" savecurrent=false}
C {devices/vdd.sym} 660 -1360 0 0 {name=l8 lab=VREF}
C {devices/gnd.sym} 660 -1260 0 0 {name=l9 lab=GND}
C {devices/vsource.sym} 660 -1310 0 0 {name=V3 value="dc 2.5" savecurrent=false}
C {devices/asrc.sym} 830 -1310 0 0 {name=B1 function="V=2.5+0.5*(1+0.5*sin(2*pi*1k*time))*sin(2*pi*500k*time)"}
C {devices/launcher.sym} 1300 -1750 0 0 {name=h5
descr="load waves (CTRL + LEFT BUTTON CLICK)" 
tclcommand="xschem raw_read $netlist_dir/tb_abs_tran.raw tran"
}
C {devices/lab_pin.sym} 860 -980 0 0 {name=p2 sig_type=std_logic lab=in}
C {devices/isource.sym} 780 -970 0 0 {name=I0 value=10u}
C {devices/lab_pin.sym} 1020 -1020 0 1 {name=p3 sig_type=std_logic lab=out}
C {devices/vdd.sym} 780 -1160 0 0 {name=l13 lab=VDD}
C {devices/vdd.sym} 960 -1160 0 0 {name=l15 lab=VDD}
C {devices/gnd.sym} 780 -920 0 0 {name=l16 lab=GND}
C {devices/vdd.sym} 930 -1020 0 0 {name=l1 lab=VDD}
C {devices/gnd.sym} 930 -920 0 0 {name=l7 lab=VREF2}
C {devices/isource.sym} 540 -970 0 0 {name=I1 value=10u}
C {devices/gnd.sym} 540 -920 0 0 {name=l11 lab=GND}
C {devices/lab_pin.sym} 620 -1020 0 1 {name=p4 sig_type=std_logic lab=VREF2}
C {devices/vdd.sym} 540 -1160 0 0 {name=l5 lab=VREF}
C {devices/vdd.sym} 600 -1160 0 0 {name=l6 lab=VDD}
C {MP.sym} 500 -1110 0 0 {name=XM3 model=PMOS w=90u l=3u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MP.sym} 820 -1090 0 1 {name=XM1 model=PMOS w=90u l=3u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MP.sym} 920 -1090 0 0 {name=XM4 model=PMOS w=90u l=3u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MP.sym} 930 -940 3 0 {name=XM5 model=PMOS w=90u l=3u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {devices/code.sym} 450 -1400 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
