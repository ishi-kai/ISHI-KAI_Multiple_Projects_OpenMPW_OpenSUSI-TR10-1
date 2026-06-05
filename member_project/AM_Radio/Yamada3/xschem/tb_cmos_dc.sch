v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 640 -1760 1440 -1360 {flags=graph
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
y2=30m}
B 2 640 -1320 1440 -920 {flags=graph
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
node=i(gm_nmos)
y2=10m}
B 2 1480 -1760 2280 -1360 {flags=graph
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
y2=30m}
B 2 1480 -1320 2280 -920 {flags=graph
y1=-10m
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
B 2 640 -880 1440 -480 {flags=graph
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
node=gmid_nmos
y2=25}
B 2 1480 -880 2280 -480 {flags=graph
y1=-25
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
node=gmid_pmos
y2=0}
B 2 640 -440 1440 -40 {flags=graph
ypos1=0
ypos2=2
divy=5
subdivy=8
unity=1
x1=0
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=1
hilight_wave=-1
sim_type=dc
autoload=1
rainbow=0
mode=Line
x2=5
rawfile=$netlist_dir/tb_cmos_dc.raw
color=4
node=ft_nmos
y2=10
y1=6}
B 2 1480 -440 2280 -40 {flags=graph
ypos1=0
ypos2=2
divy=5
subdivy=8
unity=1
x1=0
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=1
hilight_wave=-1
sim_type=dc
autoload=1
rainbow=0
mode=Line
x2=5
rawfile=$netlist_dir/tb_cmos_dc.raw
color=4
node=ft_pmos
y2=10
y1=6}
T {CMOS - DC analysis} 90 -1805 0 0 0.8 0.8 {}
N 430 -1180 430 -1160 {lab=GND}
N 430 -1280 430 -1240 {lab=in}
N 340 -1260 340 -1240 {lab=VDD}
N 340 -1180 340 -1160 {lab=GND}
N 400 -920 460 -920 {lab=GND}
N 460 -920 460 -860 {lab=GND}
N 400 -860 460 -860 {lab=GND}
N 400 -860 400 -850 {lab=GND}
N 400 -890 400 -850 {lab=GND}
N 320 -920 360 -920 {lab=in}
N 400 -1050 400 -1030 {lab=VDD}
N 400 -970 400 -950 {lab=#net1}
N 200 -920 260 -920 {lab=VDD}
N 200 -860 200 -850 {lab=GND}
N 200 -890 200 -850 {lab=GND}
N 120 -920 160 -920 {lab=in}
N 200 -1050 200 -1030 {lab=VDD}
N 200 -970 200 -950 {lab=#net2}
N 200 -1040 260 -1040 {lab=VDD}
N 260 -1040 260 -920 {lab=VDD}
C {devices/code_shown.sym} 85 -1720 0 0 {name=control only_toplevel=false value=".option savecurrent
.control
save all
# DC analysis
dc v1  0  5 1m
let gm_nmos= deriv(i(vmeas_nmos))
let gm_pmos= deriv(i(vmeas_pmos))
let gmid_nmos= gm_nmos/i(vmeas_nmos)
let gmid_pmos= gm_pmos/i(vmeas_pmos)
let ft_nmos=abs(gm_nmos/(2*pi*@m.xm1.m1[cgg]))
let ft_pmos=abs(gm_pmos/(2*pi*@m.xm2.m1[cgg]))

print pi
show
write tb_cmos_dc.raw
.endc"}
C {devices/gnd.sym} 430 -1160 0 0 {name=l2 lab=GND}
C {devices/lab_pin.sym} 430 -1280 0 1 {name=p1 sig_type=std_logic lab=in}
C {devices/vdd.sym} 340 -1260 0 0 {name=l3 lab=VDD}
C {devices/gnd.sym} 340 -1160 0 0 {name=l4 lab=GND}
C {devices/vsource.sym} 340 -1210 0 0 {name=V2 value="dc 5" savecurrent=false}
C {devices/launcher.sym} 760 -1800 0 0 {name=h5
descr="load waves (CTRL + LEFT BUTTON CLICK)" 
tclcommand="xschem raw_read $netlist_dir/tb_cmos_dc.raw dc"
}
C {devices/vsource.sym} 430 -1210 0 0 {name=V1 value="dc 2.5" savecurrent=false}
C {devices/code.sym} 120 -720 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {MN.sym} 360 -920 0 0 {name=M1 model=NMOS w=80u l=1u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/gnd.sym} 400 -850 0 0 {name=l1 lab=GND}
C {devices/ammeter.sym} 400 -1000 0 0 {name=Vmeas_nmos savecurrent=true spice_ignore=0}
C {devices/vdd.sym} 400 -1050 0 0 {name=l5 lab=VDD}
C {devices/lab_pin.sym} 320 -920 0 0 {name=p2 sig_type=std_logic lab=in}
C {devices/gnd.sym} 200 -850 0 0 {name=l6 lab=GND}
C {devices/ammeter.sym} 200 -1000 0 0 {name=Vmeas_pmos savecurrent=true spice_ignore=0}
C {devices/vdd.sym} 200 -1050 0 0 {name=l7 lab=VDD}
C {devices/lab_pin.sym} 120 -920 0 0 {name=p3 sig_type=std_logic lab=in}
C {MP.sym} 160 -920 0 0 {name=M2 model=PMOS w=80u l=1u nrd=0 nrs=0 m=1 spiceprefix=X}
