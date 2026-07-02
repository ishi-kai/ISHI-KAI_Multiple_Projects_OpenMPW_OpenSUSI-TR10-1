v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 980 -1340 1780 -940 {flags=graph
y1=0
y2=100u
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
hilight_wave=0
sim_type=dc
autoload=1
rainbow=0
mode=Line
x2=100u
color="12 7"
node="i(vmeas1)
i(vmeas2)"}
T {Current mirror - DC analysis} 430 -1615 0 0 0.8 0.8 {}
N 740 -1360 740 -1340 {lab=VDD}
N 740 -1280 740 -1260 {lab=GND}
N 540 -1030 540 -1010 {lab=GND}
N 540 -1150 540 -1130 {lab=VDD}
N 540 -1010 540 -970 {lab=GND}
N 540 -970 540 -930 {lab=GND}
N 580 -950 580 -930 {lab=GND}
N 580 -1030 580 -1010 {lab=#net1}
N 580 -1230 580 -1210 {lab=VDD}
N 580 -1150 580 -1130 {lab=#net2}
N 620 -1230 620 -1220 {lab=VDD}
N 620 -1220 620 -1210 {lab=VDD}
N 620 -1150 620 -1130 {lab=#net3}
C {devices/code_shown.sym} 425 -1530 0 0 {name=control only_toplevel=false value=".option savecurrent
.control
save all
# DC analysis
dc I0  0  100u 10u
write tb_current_mirror_dc.raw
.endc"}
C {devices/vdd.sym} 740 -1360 0 0 {name=l3 lab=VDD}
C {devices/gnd.sym} 740 -1260 0 0 {name=l4 lab=GND}
C {devices/vsource.sym} 740 -1310 0 0 {name=V2 value="dc 5" savecurrent=false}
C {devices/isource.sym} 580 -980 0 0 {name=I0 value=10u}
C {devices/gnd.sym} 540 -930 0 0 {name=l11 lab=GND}
C {devices/vdd.sym} 540 -1150 0 0 {name=l6 lab=VDD}
C {devices/launcher.sym} 1100 -1380 0 0 {name=h5
descr="load waves (CTRL + LEFT BUTTON CLICK)" 
tclcommand="xschem raw_read $netlist_dir/tb_current_mirror_dc.raw dc"
}
C {devices/code.sym} 420 -1350 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {current_mirror.sym} 580 -1090 0 0 {name=x1}
C {devices/gnd.sym} 580 -930 0 0 {name=l10 lab=GND}
C {devices/vdd.sym} 580 -1230 0 0 {name=l12 lab=VDD}
C {devices/ammeter.sym} 620 -1180 0 0 {name=Vmeas2 savecurrent=true spice_ignore=0}
C {devices/ammeter.sym} 580 -1180 0 0 {name=Vmeas1 savecurrent=true spice_ignore=0}
C {devices/vdd.sym} 620 -1230 0 0 {name=l14 lab=VDD}
