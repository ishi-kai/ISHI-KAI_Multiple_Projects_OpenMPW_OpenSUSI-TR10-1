v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 900 -1560 1700 -1160 {flags=graph
y1=0
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
node=i(vmeas_nmos)
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
x2=5
rawfile=$netlist_dir/tb_cmos_dc.raw
y2=300u}
B 2 900 -1120 1700 -720 {flags=graph
y1=0
y2=200u
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
dataset=-1
unitx=1
logx=0
logy=0
hilight_wave=-1
sim_type=dc
autoload=1
rainbow=0
mode=Line
x2=5
rawfile=$netlist_dir/tb_cmos_dc.raw
color=4
node=i(gm_nmos)}
B 2 1740 -1560 2540 -1160 {flags=graph
y1=0
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
node=i(vmeas_pmos)
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
x2=5
rawfile=$netlist_dir/tb_cmos_dc.raw
y2=10e-05}
B 2 1740 -1120 2540 -720 {flags=graph
y1=-50u
y2=0
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
dataset=-1
unitx=1
logx=0
logy=0
hilight_wave=-1
sim_type=dc
autoload=1
rainbow=0
mode=Line
x2=5
rawfile=$netlist_dir/tb_cmos_dc.raw
color=4
node=i(gm_pmos)}
T {CMOS - DC analysis} 430 -1615 0 0 0.8 0.8 {}
N 750 -1220 750 -1200 {lab=GND}
N 750 -1320 750 -1280 {lab=in}
N 660 -1300 660 -1280 {lab=VDD}
N 660 -1220 660 -1200 {lab=GND}
N 720 -960 780 -960 {lab=GND}
N 780 -960 780 -900 {lab=GND}
N 720 -900 780 -900 {lab=GND}
N 720 -900 720 -890 {lab=GND}
N 720 -930 720 -890 {lab=GND}
N 640 -960 680 -960 {lab=in}
N 720 -1090 720 -1070 {lab=VDD}
N 720 -1010 720 -990 {lab=#net1}
N 520 -960 580 -960 {lab=VDD}
N 520 -900 520 -890 {lab=GND}
N 520 -930 520 -890 {lab=GND}
N 440 -960 480 -960 {lab=in}
N 520 -1090 520 -1070 {lab=VDD}
N 520 -1010 520 -990 {lab=#net2}
N 520 -1080 580 -1080 {lab=VDD}
N 580 -1080 580 -960 {lab=VDD}
C {devices/code_shown.sym} 425 -1530 0 0 {name=control only_toplevel=false value=".option savecurrent
.control
save all
# DC analysis
dc v1  0  5 0.1
let gm_nmos= deriv(i(vmeas_nmos))
let gm_pmos= deriv(i(vmeas_pmos))

write tb_cmos_dc.raw
.endc"}
C {devices/gnd.sym} 750 -1200 0 0 {name=l2 lab=GND}
C {devices/lab_pin.sym} 750 -1320 0 1 {name=p1 sig_type=std_logic lab=in}
C {devices/vdd.sym} 660 -1300 0 0 {name=l3 lab=VDD}
C {devices/gnd.sym} 660 -1200 0 0 {name=l4 lab=GND}
C {devices/vsource.sym} 660 -1250 0 0 {name=V2 value="dc 5" savecurrent=false}
C {devices/launcher.sym} 1020 -1600 0 0 {name=h5
descr="load waves (CTRL + LEFT BUTTON CLICK)" 
tclcommand="xschem raw_read $netlist_dir/tb_cmos_dc.raw dc"
}
C {devices/vsource.sym} 750 -1250 0 0 {name=V1 value="dc 2.5" savecurrent=false}
C {devices/code.sym} 430 -1310 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {MN.sym} 680 -960 0 0 {name=M1 model=NMOS w=4u l=4u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/gnd.sym} 720 -890 0 0 {name=l1 lab=GND}
C {devices/ammeter.sym} 720 -1040 0 0 {name=Vmeas_nmos savecurrent=true spice_ignore=0}
C {devices/vdd.sym} 720 -1090 0 0 {name=l5 lab=VDD}
C {devices/lab_pin.sym} 640 -960 0 0 {name=p2 sig_type=std_logic lab=in}
C {devices/gnd.sym} 520 -890 0 0 {name=l6 lab=GND}
C {devices/ammeter.sym} 520 -1040 0 0 {name=Vmeas_pmos savecurrent=true spice_ignore=0}
C {devices/vdd.sym} 520 -1090 0 0 {name=l7 lab=VDD}
C {devices/lab_pin.sym} 440 -960 0 0 {name=p3 sig_type=std_logic lab=in}
C {MP.sym} 480 -960 0 0 {name=M2 model=PMOS w=4u l=4u nrd=0 nrs=0 m=1 spiceprefix=X}
