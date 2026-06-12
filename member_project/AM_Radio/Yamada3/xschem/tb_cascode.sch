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
node=out
color=4
dataset=-1
unitx=1
logx=0
logy=0
hilight_wave=0
sim_type=dc
autoload=1
rainbow=1
mode=Line
rawfile=$netlist_dir/tb_cascode_dc.raw
y2=5
x2=5}
B 2 640 -1320 1440 -920 {flags=graph
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
unitx=1
logx=0
logy=0
hilight_wave=-1
sim_type=dc
autoload=1
rainbow=1
mode=Line
x2=5
rawfile=$netlist_dir/tb_cascode_dc.raw
color=4
node=i(vmeas_cas)
y2=300u
dataset=-1
y1=0}
B 2 640 -880 1440 -480 {flags=graph
ypos1=0
ypos2=2
divy=5
subdivy=4
unity=1
x1=0
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
unitx=1
logx=0
logy=0
hilight_wave=-1
sim_type=dc
autoload=1
rainbow=1
mode=Line
x2=5
rawfile=$netlist_dir/tb_cascode_dc.raw
color=4
node=i(gm_cas)
dataset=-1
y1=0
y2=500u}
B 2 640 -440 1440 -40 {flags=graph
ypos1=0
ypos2=2
divy=5
subdivy=4
unity=1
x1=0
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
unitx=1
logx=0
logy=0
hilight_wave=-1
sim_type=dc
autoload=1
rainbow=1
mode=Line
x2=5
rawfile=$netlist_dir/tb_cascode_dc.raw
color=4
node=vgain
dataset=-1
y1=-100
y2=0.1}
T {Cascode - DC analysis} 90 -1805 0 0 0.8 0.8 {}
N 370 -1580 370 -1560 {lab=GND}
N 370 -1680 370 -1640 {lab=in}
N 140 -1660 140 -1640 {lab=VDD}
N 140 -1580 140 -1560 {lab=GND}
N 290 -1390 290 -1350 {lab=out}
N 290 -1320 330 -1320 {lab=GND}
N 290 -1290 290 -1250 {lab=#net1}
N 90 -1220 140 -1220 {lab=GND}
N 140 -1220 290 -1220 {lab=GND}
N 180 -1220 180 -1190 {lab=GND}
N 330 -1220 370 -1220 {lab=in}
N 290 -1190 290 -1130 {lab=#net2}
N 290 -1370 390 -1370 {lab=out}
N 290 -1070 290 -1050 {lab=GND}
N 290 -1470 290 -1450 {lab=VDD}
N 260 -1660 260 -1640 {lab=vb}
N 260 -1580 260 -1560 {lab=GND}
N 260 -1680 260 -1660 {lab=vb}
N 210 -1320 250 -1320 {lab=vb}
C {devices/code_shown.sym} 35 -970 0 0 {name=control only_toplevel=false value=".option savecurrent
.param nmos_w = 10u
.control
save all
save current
# DC analysis
dc v1  0  5 1m v2  1  1.7 0.1
let gm_cas=deriv(i(vmeas_cas))
let vgain=deriv(out)
show
write tb_cascode_dc.raw all
.endc"}
C {devices/gnd.sym} 370 -1560 0 0 {name=l2 lab=GND}
C {devices/lab_pin.sym} 370 -1680 0 1 {name=p1 sig_type=std_logic lab=in}
C {devices/vdd.sym} 140 -1660 0 0 {name=l3 lab=VDD}
C {devices/gnd.sym} 140 -1560 0 0 {name=l4 lab=GND}
C {devices/vsource.sym} 140 -1610 0 0 {name=V3 value="dc 5" savecurrent=false}
C {devices/launcher.sym} 760 -1800 0 0 {name=h5
descr="load waves (CTRL + LEFT BUTTON CLICK)" 
tclcommand="xschem raw_read $netlist_dir/tb_cascode_dc.raw dc"
}
C {devices/vsource.sym} 370 -1610 0 0 {name=V1 value="dc 2.5" savecurrent=false}
C {devices/code.sym} 430 -1140 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {MN.sym} 250 -1320 0 0 {name=MM4 model=NMOS w=10u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MN.sym} 330 -1220 0 1 {name=MM20 model=NMOS w=30u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {devices/lab_pin.sym} 330 -1320 0 1 {name=p20 sig_type=std_logic lab=GND}
C {devices/lab_pin.sym} 210 -1320 0 0 {name=p23 sig_type=std_logic lab=vb}
C {devices/lab_pin.sym} 390 -1370 0 1 {name=p12 sig_type=std_logic lab=out}
C {devices/lab_pin.sym} 370 -1220 0 1 {name=p36 sig_type=std_logic lab=in}
C {devices/lab_pin.sym} 180 -1190 0 1 {name=p7 sig_type=std_logic lab=GND}
C {devices/vdd.sym} 290 -1470 0 0 {name=l8 lab=VDD}
C {devices/gnd.sym} 290 -1050 0 0 {name=l9 lab=GND}
C {devices/ammeter.sym} 290 -1100 0 0 {name=Vmeas_cas savecurrent=true spice_ignore=0}
C {devices/res.sym} 290 -1420 0 0 {name=R1
value=30k
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 260 -1560 0 0 {name=l5 lab=GND}
C {devices/vsource.sym} 260 -1610 0 0 {name=V2 value="dc 5" savecurrent=false}
C {devices/lab_pin.sym} 260 -1680 0 1 {name=p2 sig_type=std_logic lab=vb}
