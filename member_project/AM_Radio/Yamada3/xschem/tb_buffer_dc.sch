v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 900 -1560 1700 -1160 {flags=graph
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
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
rawfile=$netlist_dir/tb_buffer_dc.raw
y1=0
y2=5
x2=5
x1=0}
T {Buffer - DC analysis} 430 -1615 0 0 0.8 0.8 {}
N 460 -1200 460 -1180 {lab=GND}
N 460 -1300 460 -1260 {lab=in}
N 370 -1280 370 -1260 {lab=VDD}
N 370 -1200 370 -1180 {lab=GND}
N 800 -1280 820 -1280 {lab=out}
N 820 -1280 820 -1260 {lab=out}
N 820 -1200 820 -1180 {lab=GND}
N 820 -1280 840 -1280 {lab=out}
N 720 -1220 720 -1200 {lab=GND}
N 720 -1360 720 -1340 {lab=VDD}
N 660 -1260 660 -1230 {lab=out}
N 780 -1280 780 -1230 {lab=out}
N 660 -1230 780 -1230 {lab=out}
N 640 -1320 660 -1320 {lab=#net1}
N 560 -1200 560 -1180 {lab=GND}
N 580 -1320 640 -1320 {lab=#net1}
N 620 -1300 660 -1300 {lab=in}
N 560 -1320 580 -1320 {lab=#net1}
N 560 -1320 560 -1260 {lab=#net1}
N 780 -1280 800 -1280 {lab=out}
N 720 -1200 720 -1180 {lab=GND}
C {devices/code_shown.sym} 425 -1530 0 0 {name=control only_toplevel=false value=".option savecurrent
.control
save all
# DC analysis
dc v1  -5  5 0.1
write tb_buffer_dc.raw
.endc"}
C {devices/gnd.sym} 460 -1180 0 0 {name=l2 lab=GND}
C {devices/lab_pin.sym} 460 -1300 0 1 {name=p1 sig_type=std_logic lab=in}
C {devices/vdd.sym} 370 -1280 0 0 {name=l3 lab=VDD}
C {devices/gnd.sym} 370 -1180 0 0 {name=l4 lab=GND}
C {devices/vsource.sym} 370 -1230 0 0 {name=V2 value="dc 5" savecurrent=false}
C {devices/launcher.sym} 1010 -1600 0 0 {name=h5
descr="load waves (CTRL + LEFT BUTTON CLICK)" 
tclcommand="xschem raw_read $netlist_dir/tb_buffer_dc.raw dc"
}
C {devices/vsource.sym} 460 -1230 0 0 {name=V1 value="dc 2.5" savecurrent=false}
C {devices/code.sym} 690 -1520 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/isource.sym} 560 -1230 0 0 {name=I2 value=50u}
C {devices/gnd.sym} 720 -1180 0 0 {name=l1 lab=GND}
C {devices/lab_pin.sym} 620 -1300 0 0 {name=p2 sig_type=std_logic lab=in}
C {devices/res.sym} 820 -1230 0 0 {name=R2
value=10k
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 820 -1180 0 0 {name=l13 lab=GND}
C {devices/lab_pin.sym} 840 -1280 0 1 {name=p3 sig_type=std_logic lab=out}
C {opamp.sym} 680 -1280 0 0 {name=X2}
C {devices/vdd.sym} 720 -1360 0 0 {name=l6 lab=VDD}
C {devices/gnd.sym} 560 -1180 0 0 {name=l8 lab=GND}
