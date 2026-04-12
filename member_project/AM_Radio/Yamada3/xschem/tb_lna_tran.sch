v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
L 4 630 -1180 750 -1110 {}
L 4 630 -1040 750 -1110 {}
L 4 630 -1180 630 -1040 {}
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
rawfile=$netlist_dir/tb_lna_tran.raw
sim_type=tran
hilight_wave=-1
x1=0
autoload=1
y1=2.495
y2=2.505
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
x2=5m
rawfile=$netlist_dir/tb_lna_tran.raw}
T {LNA - Transient analysis} 430 -1725 0 0 0.8 0.8 {}
T {LNA} 710 -1165 0 0 0.5 0.5 {}
N 830 -1280 830 -1260 {lab=GND}
N 830 -1380 830 -1340 {lab=in}
N 740 -1360 740 -1340 {lab=VDD}
N 740 -1280 740 -1260 {lab=GND}
N 660 -1360 660 -1340 {lab=VREF}
N 660 -1280 660 -1260 {lab=GND}
N 660 -1160 660 -1140 {lab=out}
N 570 -1130 620 -1130 {lab=in}
N 590 -1090 620 -1090 {lab=VREF}
N 660 -1080 660 -1040 {lab=VREF}
N 660 -1160 700 -1160 {lab=out}
N 700 -1160 700 -1110 {lab=out}
N 700 -1110 790 -1110 {lab=out}
N 570 -1090 590 -1090 {lab=VREF}
C {devices/code_shown.sym} 425 -1640 0 0 {name=control only_toplevel=false value=".option savecurrent
.control
save all
# Transienst analysis
tran 0.1u 5m 0 0.1u
write tb_lna_tran.raw
.endc"}
C {devices/gnd.sym} 830 -1260 0 0 {name=l2 lab=GND}
C {devices/lab_pin.sym} 830 -1380 0 1 {name=p1 sig_type=std_logic lab=in}
C {devices/vdd.sym} 740 -1360 0 0 {name=l3 lab=VDD}
C {devices/gnd.sym} 740 -1260 0 0 {name=l4 lab=GND}
C {devices/vsource.sym} 740 -1310 0 0 {name=V2 value="dc 5" savecurrent=false}
C {devices/vdd.sym} 660 -1360 0 0 {name=l8 lab=VREF}
C {devices/gnd.sym} 660 -1260 0 0 {name=l9 lab=GND}
C {devices/vsource.sym} 660 -1310 0 0 {name=V3 value="dc 2.5" savecurrent=false}
C {devices/asrc.sym} 830 -1310 0 0 {name=B1 function="V=2.5+0.5m*(1+0.5*sin(2*pi*1k*time))*sin(2*pi*500k*time)"}
C {devices/launcher.sym} 1300 -1750 0 0 {name=h5
descr="load waves (CTRL + LEFT BUTTON CLICK)" 
tclcommand="xschem raw_read $netlist_dir/tb_lna_tran.raw tran"
}
C {devices/code.sym} 450 -1400 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/lab_pin.sym} 790 -1110 0 1 {name=p2 sig_type=std_logic lab=out}
C {devices/lab_pin.sym} 570 -1130 0 0 {name=p3 sig_type=std_logic lab=in}
C {devices/vcvs.sym} 660 -1110 0 0 {name=E1 value=1000}
C {devices/lab_pin.sym} 570 -1090 0 0 {name=p9 sig_type=std_logic lab=VREF}
C {devices/gnd.sym} 660 -1040 0 0 {name=l5 lab=VREF}
