v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
L 4 60 -180 60 -120 {}
L 4 60 -120 860 -120 {}
L 4 860 -180 860 -120 {}
B 2 1500 -1080 2210 -540 {flags=graph
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
B 2 1500 -540 2210 0 {flags=graph
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
B 2 2240 -1080 2950 -540 {flags=graph
y1=30
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
y2=70
x2=6}
B 2 2240 -540 2950 0 {flags=graph
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
B 2 2980 -1080 3690 -540 {flags=graph
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
B 2 2980 -540 3690 0 {flags=graph
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
T {Telescopic cascode two stage opamp} 130 -610 0 0 1 1 {}
T {Test circuit - 60db AMP} 310 -100 0 0 0.4 0.4 {}
T {DC analysis} 1750 -1150 0 0 0.8 0.8 {}
T {AC analysis} 2490 -1150 0 0 0.8 0.8 {}
T {TRAN analysis} 3220 -1150 0 0 0.8 0.8 {}
N 240 -320 240 -300 {lab=GND}
N 320 -320 320 -300 {lab=GND}
N 240 -400 240 -380 {lab=VDD}
N 420 -400 460 -400 {lab=VIN_N}
N 420 -400 420 -300 {lab=VIN_N}
N 420 -300 500 -300 {lab=VIN_N}
N 620 -420 640 -420 {lab=VOUT}
N 640 -420 640 -300 {lab=VOUT}
N 560 -300 640 -300 {lab=VOUT}
N 340 -440 460 -440 {lab=VIN_P}
N 320 -440 320 -380 {lab=VIN_P}
N 160 -320 160 -300 {lab=GND}
N 160 -400 160 -380 {lab=VREF}
N 640 -420 680 -420 {lab=VOUT}
N 680 -420 680 -370 {lab=VOUT}
N 680 -310 680 -290 {lab=GND}
N 320 -440 340 -440 {lab=VIN_P}
N 680 -420 700 -420 {lab=VOUT}
N 700 -420 760 -420 {lab=VOUT}
N 760 -420 780 -420 {lab=VOUT}
N 760 -310 760 -290 {lab=GND}
N 760 -420 760 -370 {lab=VOUT}
N 420 -300 420 -280 {lab=VIN_N}
N 420 -220 420 -190 {lab=VREF}
N 540 -360 540 -340 {lab=GND}
N 540 -500 540 -480 {lab=VDD}
N 580 -360 580 -330 {lab=iB}
N 80 -320 80 -300 {lab=GND}
N 80 -400 80 -380 {lab=iB}
C {devices/code.sym} 1330 -450 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/code_shown.sym} 920 -430 0 0 {name=NGSPICE only_toplevel=true
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
C {devices/launcher.sym} 1565 -1205 0 0 {name=h1
descr="Click left mouse button here with CTRL key
to reload waveforms in graph."
tclcommand="
xschem raw_read $netlist_dir/tb_cascode_opamp_dc.raw
xschem raw_read $netlist_dir/tb_cascode_opamp_ac.raw
xschem raw_read $netlist_dir/tb_cascode_opamp_tran.raw
"
}
C {devices/vdd.sym} 240 -400 0 0 {name=l2 lab=VDD}
C {devices/gnd.sym} 240 -300 0 0 {name=l3 lab=GND}
C {devices/vsource.sym} 240 -350 0 0 {name=V1 value=5 savecurrent=false}
C {devices/res.sym} 530 -300 1 0 {name=R2
value=1Meg
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 320 -300 0 0 {name=l21 lab=GND}
C {devices/vsource.sym} 320 -350 0 0 {name=V2 value="dc 1.4 ac 1 sin(1.4 1m 500k 0 0 0)" savecurrent=false}
C {devices/vdd.sym} 160 -400 0 0 {name=l22 lab=VREF}
C {devices/gnd.sym} 160 -300 0 0 {name=l23 lab=GND}
C {devices/vsource.sym} 160 -350 0 0 {name=V4 value=1.4 savecurrent=false}
C {devices/res.sym} 680 -340 0 0 {name=RLOAD
value=100k
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 680 -290 0 0 {name=l7 lab=GND}
C {devices/gnd.sym} 540 -340 0 0 {name=l17 lab=GND}
C {devices/vdd.sym} 540 -500 0 0 {name=l4 lab=VDD}
C {devices/lab_pin.sym} 780 -420 0 1 {name=l6 sig_type=std_logic lab=VOUT}
C {devices/lab_pin.sym} 320 -440 0 0 {name=l8 sig_type=std_logic lab=VIN_P}
C {devices/lab_pin.sym} 420 -400 0 0 {name=l9 sig_type=std_logic lab=VIN_N}
C {devices/capa.sym} 760 -340 0 0 {name=C1
m=1
value=24p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 760 -290 0 0 {name=l1 lab=GND}
C {devices/gnd.sym} 420 -190 0 0 {name=l5 lab=VREF}
C {devices/res.sym} 420 -250 2 0 {name=R1
value=1k
footprint=1206
device=resistor
m=1}
C {cascode_opamp.sym} 540 -420 0 0 {name=x1}
C {devices/lab_pin.sym} 580 -330 0 1 {name=l10 sig_type=std_logic lab=iB}
C {devices/gnd.sym} 80 -300 0 0 {name=l11 lab=GND}
C {devices/lab_pin.sym} 80 -400 0 1 {name=l12 sig_type=std_logic lab=iB}
C {devices/isource.sym} 80 -350 0 0 {name=I0 value=100u}
