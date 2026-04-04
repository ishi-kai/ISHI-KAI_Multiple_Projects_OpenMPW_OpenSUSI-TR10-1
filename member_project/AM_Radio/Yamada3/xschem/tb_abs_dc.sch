v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 980 -1340 1780 -940 {flags=graph
y1=0
y2=5
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0.0
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
hilight_wave=0
sim_type=dc
autoload=1
rainbow=0
mode=Line
x2=5}
T {Absolute Function - DC analysis} 430 -1615 0 0 0.8 0.8 {}
N 830 -1280 830 -1260 {lab=GND}
N 830 -1380 830 -1340 {lab=in}
N 760 -980 800 -980 {lab=in}
N 740 -1360 740 -1340 {lab=VDD}
N 740 -1280 740 -1260 {lab=GND}
N 660 -1360 660 -1340 {lab=VREF}
N 660 -1280 660 -1260 {lab=GND}
N 680 -1145 680 -1120 {lab=VDD}
N 620 -1090 680 -1090 {lab=VDD}
N 620 -1145 620 -1090 {lab=VDD}
N 620 -1145 680 -1145 {lab=VDD}
N 860 -1140 860 -1120 {lab=VDD}
N 740 -1090 740 -1040 {lab=#net1}
N 860 -1140 920 -1140 {lab=VDD}
N 920 -1140 920 -1090 {lab=VDD}
N 860 -1090 920 -1090 {lab=VDD}
N 860 -1020 860 -980 {lab=out}
N 860 -1020 920 -1020 {lab=out}
N 830 -1020 830 -980 {lab=VDD}
N 440 -1160 440 -1140 {lab=VREF}
N 440 -1110 500 -1110 {lab=VDD}
N 440 -1060 440 -1020 {lab=VREF2}
N 380 -1110 400 -1110 {lab=VREF2}
N 380 -1110 380 -1060 {lab=VREF2}
N 380 -1060 440 -1060 {lab=VREF2}
N 440 -940 440 -920 {lab=GND}
N 440 -1020 520 -1020 {lab=VREF2}
N 500 -1160 500 -1110 {lab=VDD}
N 830 -940 830 -920 {lab=VREF2}
N 680 -940 680 -920 {lab=GND}
N 440 -1020 440 -1000 {lab=VREF2}
N 680 -1040 680 -1000 {lab=#net1}
N 680 -1040 740 -1040 {lab=#net1}
N 740 -1090 820 -1090 {lab=#net1}
N 680 -1160 680 -1145 {lab=VDD}
N 720 -1090 740 -1090 {lab=#net1}
N 860 -1160 860 -1140 {lab=VDD}
N 860 -1060 860 -1020 {lab=out}
N 440 -1080 440 -1060 {lab=VREF2}
N 680 -1060 680 -1040 {lab=#net1}
C {devices/code_shown.sym} 425 -1530 0 0 {name=control only_toplevel=false value=".option savecurrent
.control
save all
# DC analysis
dc v1  0  5 0.1
write tb_abs_dc.raw
.endc"}
C {devices/gnd.sym} 830 -1260 0 0 {name=l2 lab=GND}
C {devices/lab_pin.sym} 830 -1380 0 1 {name=p1 sig_type=std_logic lab=in}
C {devices/lab_pin.sym} 760 -980 0 0 {name=p2 sig_type=std_logic lab=in}
C {devices/vdd.sym} 740 -1360 0 0 {name=l3 lab=VDD}
C {devices/gnd.sym} 740 -1260 0 0 {name=l4 lab=GND}
C {devices/vsource.sym} 740 -1310 0 0 {name=V2 value="dc 5" savecurrent=false}
C {devices/isource.sym} 680 -970 0 0 {name=I0 value=10u}
C {devices/lab_pin.sym} 920 -1020 0 1 {name=p3 sig_type=std_logic lab=out}
C {devices/code.sym} 440 -1350 0 0 {name=TR10_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/../ip62_models"
spice_ignore=false}
C {devices/vdd.sym} 660 -1360 0 0 {name=l8 lab=VREF}
C {devices/gnd.sym} 660 -1260 0 0 {name=l9 lab=GND}
C {devices/vsource.sym} 660 -1310 0 0 {name=V3 value="dc 2.5" savecurrent=false}
C {devices/vdd.sym} 680 -1160 0 0 {name=l13 lab=VDD}
C {IP62LIB/MP.sym} 720 -1090 0 1 {name=XM4 model=PMOS w=90u l=3u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {IP62LIB/MP.sym} 820 -1090 0 0 {name=XM5 model=PMOS w=90u l=3u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {devices/vdd.sym} 860 -1160 0 0 {name=l15 lab=VDD}
C {devices/gnd.sym} 680 -920 0 0 {name=l16 lab=GND}
C {IP62LIB/MP.sym} 830 -940 1 1 {name=XM2 model=PMOS w=90u l=3u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {devices/vdd.sym} 830 -1020 0 0 {name=l1 lab=VDD}
C {devices/gnd.sym} 830 -920 0 0 {name=l7 lab=VREF2}
C {devices/isource.sym} 440 -970 0 0 {name=I1 value=10u}
C {devices/gnd.sym} 440 -920 0 0 {name=l11 lab=GND}
C {devices/lab_pin.sym} 520 -1020 0 1 {name=p4 sig_type=std_logic lab=VREF2}
C {devices/vdd.sym} 440 -1160 0 0 {name=l5 lab=VREF}
C {IP62LIB/MP.sym} 400 -1110 0 0 {name=XM1 model=PMOS w=90u l=3u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {devices/vdd.sym} 500 -1160 0 0 {name=l6 lab=VDD}
C {devices/launcher.sym} 1100 -1380 0 0 {name=h5
descr="load waves (CTRL + LEFT BUTTON CLICK)" 
tclcommand="xschem raw_read $netlist_dir/tb_abs_dc.raw dc"
}
C {devices/vsource.sym} 830 -1310 0 0 {name=V1 value="dc 2.5" savecurrent=false}
