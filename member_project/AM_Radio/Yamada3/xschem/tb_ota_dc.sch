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
x1=0.0035759902
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node=i(vmeas)
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
x2=5.0035766
rawfile=$netlist_dir/tb_ota_dc.raw
y1=0
y2=2u}
B 2 900 -1120 1700 -720 {flags=graph
y1=0
y2=500n
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0.0035759902
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
x2=5.0035766
rawfile=$netlist_dir/tb_ota_dc.raw
color=4
node=i(gm)}
T {OTA - DC analysis} 430 -1615 0 0 0.8 0.8 {}
N 820 -1220 820 -1200 {lab=GND}
N 820 -1320 820 -1280 {lab=in}
N 730 -1300 730 -1280 {lab=VDD}
N 730 -1220 730 -1200 {lab=GND}
N 480 -920 480 -900 {lab=GND}
N 480 -1000 500 -1000 {lab=#net1}
N 480 -1000 480 -980 {lab=#net1}
N 560 -960 560 -900 {lab=GND}
N 480 -1060 480 -1040 {lab=VREF}
N 480 -1040 500 -1040 {lab=VREF}
N 560 -1100 560 -1090 {lab=VDD}
N 560 -1090 560 -1080 {lab=VDD}
N 480 -1100 480 -1060 {lab=VREF}
N 460 -1020 500 -1020 {lab=in}
N 640 -1020 660 -1020 {lab=#net2}
N 720 -1020 740 -1020 {lab=#net3}
N 740 -1020 740 -980 {lab=#net3}
N 740 -920 740 -900 {lab=GND}
N 630 -1300 630 -1280 {lab=VREF}
N 630 -1220 630 -1200 {lab=GND}
C {devices/code_shown.sym} 425 -1530 0 0 {name=control only_toplevel=false value=".option savecurrent
.control
save all
# DC analysis
dc v1  0  5 0.1
let gm=deriv(i(vmeas))
meas dc result FIND gm AT=2.5
print result
write tb_ota_dc.raw
.endc"}
C {devices/gnd.sym} 820 -1200 0 0 {name=l2 lab=GND}
C {devices/lab_pin.sym} 820 -1320 0 1 {name=p1 sig_type=std_logic lab=in}
C {devices/vdd.sym} 730 -1300 0 0 {name=l3 lab=VDD}
C {devices/gnd.sym} 730 -1200 0 0 {name=l4 lab=GND}
C {devices/vsource.sym} 730 -1250 0 0 {name=V2 value="dc 5" savecurrent=false}
C {devices/launcher.sym} 1010 -1600 0 0 {name=h5
descr="load waves (CTRL + LEFT BUTTON CLICK)" 
tclcommand="xschem raw_read $netlist_dir/tb_ota_dc.raw dc"
}
C {devices/vsource.sym} 820 -1250 0 0 {name=V1 value="dc 2.5" savecurrent=false}
C {devices/code.sym} 430 -1300 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/vdd.sym} 560 -1100 0 0 {name=l8 lab=VDD}
C {ota.sym} 560 -1020 0 0 {name=x1}
C {devices/isource.sym} 480 -950 0 0 {name=I2 value=80u}
C {devices/gnd.sym} 480 -900 0 0 {name=l10 lab=GND}
C {devices/gnd.sym} 560 -900 0 0 {name=l12 lab=GND}
C {devices/vdd.sym} 480 -1100 0 0 {name=l14 lab=VREF}
C {devices/lab_pin.sym} 460 -1020 0 0 {name=p5 sig_type=std_logic lab=in}
C {devices/ammeter.sym} 690 -1020 3 0 {name=Vmeas savecurrent=true spice_ignore=0}
C {devices/res.sym} 740 -950 0 0 {name=R1
value=1m
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 740 -900 0 0 {name=l17 lab=GND}
C {devices/vdd.sym} 630 -1300 0 0 {name=l9 lab=VREF}
C {devices/gnd.sym} 630 -1200 0 0 {name=l11 lab=GND}
C {devices/vsource.sym} 630 -1250 0 0 {name=V3 value="dc 2.5" savecurrent=false}
