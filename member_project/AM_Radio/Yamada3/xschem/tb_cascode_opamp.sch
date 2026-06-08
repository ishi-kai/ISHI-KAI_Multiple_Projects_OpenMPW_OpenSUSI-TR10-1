v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
L 4 280 -740 280 -680 {}
L 4 280 -680 850 -680 {}
L 4 850 -740 850 -680 {}
B 2 910 -1120 1620 -580 {flags=graph
y1=0.063
y2=5
ypos1=0
ypos2=2
divy=5
subdivy=4
unity=1
x1=0
divx=5
subdivx=4

unitx=1
dataset=-1
sim_type=dc
logx=0
logy=0
legend=1
x2=5
hilight_wave=0
autoload=1
rawfile=$netlist_dir/tb_cascode_opamp_dc.raw
rainbow=1
color=11
node=VOUT}
B 2 910 -580 1620 -40 {flags=graph
y1=-1
ypos1=0
ypos2=2
divy=5
subdivy=8
unity=1
x1=0
divx=5
subdivx=4

unitx=1
dataset=-1
sim_type=dc
color=4
node=dc_gain
logx=0
logy=1
legend=1
x2=5
hilight_wave=0
autoload=1
rawfile=$netlist_dir/tb_cascode_opamp_dc.raw
rainbow=1
y2=4}
B 2 1650 -1120 2360 -580 {flags=graph
y1=40
ypos1=0
ypos2=2
divy=5
subdivy=4
unity=1
divx=5
subdivx=8

unitx=1
dataset=-1
sim_type=ac
logx=1
logy=0
legend=1
hilight_wave=0
autoload=1
rawfile=$netlist_dir/tb_cascode_opamp_ac.raw
rainbow=1
digital=0
x1=4
color=4
node=re(ac_gain_db)
y2=65
x2=6}
B 2 1650 -580 2360 -40 {flags=graph
ypos1=0
ypos2=2
divy=5
subdivy=4
unity=1
divx=5
subdivx=8

unitx=1
dataset=-1
sim_type=ac
logx=1
logy=0
legend=1
hilight_wave=0
autoload=1
rawfile=$netlist_dir/tb_cascode_opamp_ac.raw
rainbow=0
digital=0
x1=4
y1=-180
y2=180
color=4
node=ac_phase_deg
x2=6}
B 2 2390 -1120 3100 -580 {flags=graph
y1=1.35
y2=1.45
ypos1=0
ypos2=2
divy=5
subdivy=4
unity=1
x1=2.1175824e-22
divx=5
subdivx=4

unitx=1
dataset=-1
sim_type=tran
logx=0
logy=0
legend=1
x2=2e-05
hilight_wave=0
autoload=1
rawfile=$netlist_dir/tb_cascode_opamp_tran.raw
rainbow=1
color=4
node=vin_p}
B 2 2390 -580 3100 -40 {flags=graph
y1=1.2
y2=2.5
ypos1=0
ypos2=2
divy=5
subdivy=4
unity=1
x1=2.1175824e-22
divx=5
subdivx=4

unitx=1
dataset=-1
sim_type=tran
logx=0
logy=0
legend=1
x2=2e-05
hilight_wave=0
autoload=1
rawfile=$netlist_dir/tb_cascode_opamp_tran.raw
rainbow=1
color=4
node=VOUT}
T {Telescopic cascode two stage opamp} 290 -1260 0 0 1 1 {}
T {Test circuit - 60db AMP} 450 -660 0 0 0.4 0.4 {}
T {DC analysis} 1160 -1190 0 0 0.8 0.8 {}
T {AC analysis} 1900 -1190 0 0 0.8 0.8 {}
T {TRAN analysis} 2630 -1190 0 0 0.8 0.8 {}
N 760 -750 760 -730 {lab=GND}
N 310 -960 310 -940 {lab=GND}
N 760 -830 760 -810 {lab=VDD}
N 410 -1040 450 -1040 {lab=VIN_N}
N 410 -1040 410 -940 {lab=VIN_N}
N 410 -940 490 -940 {lab=VIN_N}
N 610 -1060 630 -1060 {lab=VOUT}
N 630 -1060 630 -940 {lab=VOUT}
N 550 -940 630 -940 {lab=VOUT}
N 330 -1080 450 -1080 {lab=VIN_P}
N 310 -1080 310 -1020 {lab=VIN_P}
N 680 -750 680 -730 {lab=GND}
N 680 -830 680 -810 {lab=VREF}
N 630 -1060 670 -1060 {lab=VOUT}
N 670 -1060 670 -1010 {lab=VOUT}
N 670 -950 670 -930 {lab=GND}
N 310 -1080 330 -1080 {lab=VIN_P}
N 670 -1060 690 -1060 {lab=VOUT}
N 690 -1060 750 -1060 {lab=VOUT}
N 750 -1060 770 -1060 {lab=VOUT}
N 750 -950 750 -930 {lab=GND}
N 750 -1060 750 -1010 {lab=VOUT}
N 410 -940 410 -920 {lab=VIN_N}
N 410 -860 410 -830 {lab=VREF}
N 530 -1000 530 -980 {lab=GND}
N 530 -1140 530 -1120 {lab=VDD}
N 570 -1000 570 -970 {lab=iB}
N 600 -750 600 -730 {lab=GND}
N 600 -830 600 -810 {lab=iB}
C {devices/code.sym} 690 -430 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/code_shown.sym} 310 -360 0 0 {name=NGSPICE only_toplevel=true
value=".control
save all
save currents
* DC analysis
dc v2 0 5 1m rload 10k 100k 20k
let dc_gain=deriv(VOUT)
write tb_cascode_opamp_dc.raw
* AC analysis
ac dec 10 1k 10Meg
let ac_gain = VOUT / vin_p
let ac_gain_db = db(ac_gain)
let ac_phase_deg = (180 / PI) * cph(ac_gain)
write tb_cascode_opamp_ac.raw
* TRAN analysis
tran 0.1u 20u
write tb_cascode_opamp_tran.raw
.endc
"}
C {devices/launcher.sym} 345 -555 0 0 {name=h1
descr="Click left mouse button here with CTRL key
to reload waveforms in graph."
tclcommand="
xschem raw_read $netlist_dir/tb_cascode_opamp_dc.raw
xschem raw_read $netlist_dir/tb_cascode_opamp_ac.raw
xschem raw_read $netlist_dir/tb_cascode_opamp_tran.raw
"
}
C {devices/vdd.sym} 760 -830 0 0 {name=l2 lab=VDD}
C {devices/gnd.sym} 760 -730 0 0 {name=l3 lab=GND}
C {devices/vsource.sym} 760 -780 0 0 {name=V1 value=5 savecurrent=false}
C {devices/res.sym} 520 -940 1 0 {name=R2
value=1Meg
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 310 -940 0 0 {name=l21 lab=GND}
C {devices/vsource.sym} 310 -990 0 0 {name=V2 value="dc 1.4 ac 1 sin(1.4 1m 500k 0 0 0)" savecurrent=false}
C {devices/vdd.sym} 680 -830 0 0 {name=l22 lab=VREF}
C {devices/gnd.sym} 680 -730 0 0 {name=l23 lab=GND}
C {devices/vsource.sym} 680 -780 0 0 {name=V4 value=1.4 savecurrent=false}
C {devices/res.sym} 670 -980 0 0 {name=RLOAD
value=100k
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 670 -930 0 0 {name=l7 lab=GND}
C {devices/gnd.sym} 530 -980 0 0 {name=l17 lab=GND}
C {devices/vdd.sym} 530 -1140 0 0 {name=l4 lab=VDD}
C {devices/lab_pin.sym} 770 -1060 0 1 {name=l6 sig_type=std_logic lab=VOUT}
C {devices/lab_pin.sym} 310 -1080 0 0 {name=l8 sig_type=std_logic lab=VIN_P}
C {devices/lab_pin.sym} 410 -1040 0 0 {name=l9 sig_type=std_logic lab=VIN_N}
C {devices/capa.sym} 750 -980 0 0 {name=C1
m=1
value=24p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 750 -930 0 0 {name=l1 lab=GND}
C {devices/gnd.sym} 410 -830 0 0 {name=l5 lab=VREF}
C {devices/res.sym} 410 -890 2 0 {name=R1
value=1k
footprint=1206
device=resistor
m=1}
C {cascode_opamp.sym} 530 -1060 0 0 {name=x1}
C {devices/lab_pin.sym} 570 -970 0 1 {name=l10 sig_type=std_logic lab=iB}
C {devices/gnd.sym} 600 -730 0 0 {name=l11 lab=GND}
C {devices/lab_pin.sym} 600 -830 0 1 {name=l12 sig_type=std_logic lab=iB}
C {devices/isource.sym} 600 -780 0 0 {name=I0 value=100u}
