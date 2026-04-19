v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
L 4 680 -810 800 -740 {}
L 4 680 -670 800 -740 {}
L 4 680 -810 680 -670 {}
B 2 900 -1560 1700 -1160 {flags=graph
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=-0.018485893
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node="i(vmeas_real)
i(vmeas_ideal)"
color="4 7"
dataset=-1
unitx=1
logx=0
logy=0
hilight_wave=0
sim_type=dc
autoload=1
rainbow=0
mode=Line
x2=4.9815153
rawfile=$netlist_dir/tb_ota_dc.raw
y1=0
y2=10u}
B 2 900 -1120 1700 -720 {flags=graph
y1=0
y2=2u
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=-0.018485893
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
x2=4.9815153
rawfile=$netlist_dir/tb_ota_dc.raw
color="4 7"
node="i(gm_real)
i(gm_ideal)"}
A 4 805 -740 11.18033988749895 116.565051177078 360 {}
A 4 815 -740 11.18033988749895 116.565051177078 360 {}
T {OTA - DC analysis} 430 -1615 0 0 0.8 0.8 {}
T {OTA} 760 -795 0 0 0.5 0.5 {}
T {1st order LPF
fc = gm / (2*Pi*C)
gm = 2*Pi*fc*C
gm = 2*3.14*20k*8.856p 
   = 1.113e-6} 290 -815 0 0 0.5 0.5 {}
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
N 710 -790 710 -770 {lab=VDD}
N 710 -710 780 -710 {lab=#net4}
N 840 -660 840 -640 {lab=#net4}
N 840 -640 840 -620 {lab=#net4}
N 640 -720 640 -690 {lab=#net4}
N 780 -740 780 -710 {lab=#net4}
N 780 -740 840 -740 {lab=#net4}
N 640 -690 640 -660 {lab=#net4}
N 840 -740 840 -720 {lab=#net4}
N 620 -760 670 -760 {lab=in}
N 640 -720 670 -720 {lab=#net4}
N 640 -640 840 -640 {lab=#net4}
N 640 -660 640 -640 {lab=#net4}
N 840 -720 840 -660 {lab=#net4}
N 840 -460 840 -440 {lab=GND}
N 840 -560 840 -520 {lab=#net5}
C {devices/code_shown.sym} 425 -1530 0 0 {name=control only_toplevel=false value=".option savecurrent
.control
save all
# DC analysis
dc v1  0  5 0.1
let gm_real=deriv(i(vmeas_real))
let gm_ideal=deriv(i(vmeas_ideal))
meas dc result FIND gm_real AT=2.5
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
C {devices/ammeter.sym} 690 -1020 3 0 {name=Vmeas_real savecurrent=true spice_ignore=0}
C {devices/res.sym} 740 -950 0 0 {name=R1
value=0.1
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 740 -900 0 0 {name=l17 lab=GND}
C {devices/vdd.sym} 630 -1300 0 0 {name=l9 lab=VREF}
C {devices/gnd.sym} 630 -1200 0 0 {name=l11 lab=GND}
C {devices/vsource.sym} 630 -1250 0 0 {name=V3 value="dc 2.5" savecurrent=false}
C {devices/vccs.sym} 710 -740 0 0 {name=G1 value=1.113e-6}
C {devices/vdd.sym} 710 -790 0 0 {name=l1 lab=VDD}
C {devices/lab_pin.sym} 620 -760 0 0 {name=p3 sig_type=std_logic lab=in}
C {devices/res.sym} 840 -490 0 0 {name=R2
value=0.1
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 840 -440 0 0 {name=l5 lab=GND}
C {devices/ammeter.sym} 840 -590 0 0 {name=Vmeas_ideal savecurrent=true spice_ignore=0}
