v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 80 -430 880 -30 {flags=graph
y2=1.4591669
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0.0002316449
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
x2=0.00096223122
autoload=1
y1=1.3525617
sim_type=tran
rawfile=$netlist_dir/tb_AM_Radio.raw
color=4
node=RFIN}
B 2 80 30 880 430 {flags=graph
y1=1.4008767
y2=2.1232966
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0.0002316449
x2=0.00096223122
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
sim_type=tran
rawfile=$netlist_dir/tb_AM_Radio.raw
color=4
node=VOUT}
T {AM Radio} -700 -465 0 0 1 1 {}
N -460 110 -460 130 {lab=GND}
N -460 10 -460 50 {lab=RFIN}
N -580 110 -580 130 {lab=GND}
N -670 110 -670 130 {lab=GND}
N -760 110 -760 130 {lab=GND}
N -760 10 -760 50 {lab=iB}
N -170 -280 -110 -280 {lab=VOUT}
N -390 -300 -320 -300 {lab=RFOUT}
N -390 -320 -360 -320 {lab=iB}
N -760 -300 -690 -300 {lab=#net1}
N -760 -160 -320 -160 {lab=#net1}
N -320 -300 -320 -220 {lab=RFOUT}
N -720 -220 -320 -220 {lab=RFOUT}
N -720 -280 -690 -280 {lab=RFOUT}
N -390 -280 -230 -280 {lab=DTOUT}
N -140 -280 -140 -220 {lab=VOUT}
N -320 -100 -140 -100 {lab=VREF}
N -140 -160 -140 -100 {lab=VREF}
N -760 -100 -320 -100 {lab=VREF}
N -760 -300 -760 -160 {lab=#net1}
N -720 -340 -690 -340 {lab=VREF}
N -720 -320 -690 -320 {lab=RFIN}
N -670 10 -670 50 {lab=VREF}
N -580 10 -580 50 {lab=VDD}
N -720 -280 -720 -220 {lab=RFOUT}
C {devices/code.sym} -360 260 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/gnd.sym} -460 130 0 0 {name=l2 lab=GND}
C {devices/lab_pin.sym} -720 -320 0 0 {name=p1 sig_type=std_logic lab=RFIN
}
C {devices/gnd.sym} -580 130 0 0 {name=l4 lab=GND}
C {devices/vsource.sym} -580 80 0 0 {name=V2 value="dc 5" savecurrent=false}
C {devices/gnd.sym} -670 130 0 0 {name=l9 lab=GND}
C {devices/vsource.sym} -670 80 0 0 {name=V3 value="dc 1.4" savecurrent=false}
C {devices/asrc.sym} -460 80 0 0 {name=B1 function="V=1.4+10m*(1+0.4*sin(2*pi*10k*time))*sin(2*pi*1000k*time)"}
C {devices/code_shown.sym} -775 240 0 0 {name=control only_toplevel=false value=".option savecurrent
.control
save all
# Transienst analysis
tran 0.1u 1m 0 0.1u
write tb_AM_Radio.raw
exit
.endc"}
C {devices/res.sym} -200 -280 1 0 {name=R2
value=10k
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} -390 -260 0 0 {name=l1 lab=GND}
C {devices/gnd.sym} -760 130 0 0 {name=l11 lab=GND}
C {devices/lab_pin.sym} -760 10 0 1 {name=l12 sig_type=std_logic lab=iB}
C {devices/isource.sym} -760 80 0 0 {name=I0 value=100u}
C {devices/capa.sym} -140 -190 0 0 {name=C1
m=1
value=100p
footprint=1206
device="ceramic capacitor"}
C {AM_Radio.sym} -540 -300 0 0 {name=x1}
C {devices/res.sym} -320 -190 0 0 {name=R1
value=1Meg
footprint=1206
device=resistor
m=1}
C {devices/lab_wire.sym} -360 -320 0 1 {name=p2 sig_type=std_logic lab=iB}
C {devices/ammeter.sym} -390 -370 0 0 {name=Vmeas savecurrent=true spice_ignore=0}
C {devices/lab_wire.sym} -390 -400 0 0 {name=p3 sig_type=std_logic lab=VDD}
C {devices/res.sym} -320 -130 0 0 {name=R3
value=1k
footprint=1206
device=resistor
m=1}
C {devices/lab_pin.sym} -760 -100 0 0 {name=p6 sig_type=std_logic lab=VREF}
C {devices/lab_wire.sym} -290 -280 0 1 {name=p4 sig_type=std_logic lab=DTOUT}
C {devices/lab_wire.sym} -110 -280 0 1 {name=p5 sig_type=std_logic lab=VOUT}
C {devices/lab_pin.sym} -720 -340 0 0 {name=p7 sig_type=std_logic lab=VREF
}
C {devices/lab_pin.sym} -670 10 0 1 {name=l3 sig_type=std_logic lab=VREF}
C {devices/lab_pin.sym} -580 10 0 1 {name=l5 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} -460 10 0 1 {name=l6 sig_type=std_logic lab=RFIN}
C {devices/lab_wire.sym} -510 -220 0 1 {name=p8 sig_type=std_logic lab=RFOUT}
