v {xschem version=3.4.7RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
B 2 80 -430 880 -30 {flags=graph
y2=4.1234158
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=-0.00037289904
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
x2=0.00037236364
autoload=1
y1=-1.1187034
sim_type=tran
color=4
node=VIN}
B 2 80 30 880 430 {flags=graph
y1=0.44776851
y2=4.9590532
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=-0.00037289904
x2=0.00037236364
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
sim_type=tran
color=4
node=VOUT}
T {IDEAL_DIODE} -410 -475 0 0 0.5 0.5 {}
N -330 30 -330 50 {lab=GND}
N -330 -70 -330 -30 {lab=VIN}
N -420 -50 -420 -30 {lab=VDD}
N -420 30 -420 50 {lab=GND}
N -510 -50 -510 -30 {lab=VREF}
N -510 30 -510 50 {lab=GND}
N -140 -280 -140 -240 {lab=VOUT}
N -140 -180 -140 -140 {lab=VREF}
N -470 -370 -470 -340 {lab=VDD}
N -390 -370 -390 -340 {lab=VREF}
N -470 -220 -470 -190 {lab=GND}
N -390 -220 -390 -190 {lab=iB}
N -560 -280 -530 -280 {lab=VIN}
N -330 -280 -140 -280 {lab=VOUT}
N -600 30 -600 50 {lab=GND}
N -600 -70 -600 -30 {lab=iB}
N -210 -280 -210 -240 {lab=VOUT}
N -210 -180 -210 -140 {lab=VREF}
C {devices/code.sym} -210 260 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/gnd.sym} -330 50 0 0 {name=l2 lab=GND}
C {devices/lab_pin.sym} -330 -70 0 1 {name=p1 sig_type=std_logic lab=VIN}
C {devices/vdd.sym} -420 -50 0 0 {name=l3 lab=VDD}
C {devices/gnd.sym} -420 50 0 0 {name=l4 lab=GND}
C {devices/vsource.sym} -420 0 0 0 {name=V2 value="dc 5" savecurrent=false}
C {devices/vdd.sym} -510 -50 0 0 {name=l8 lab=VREF}
C {devices/gnd.sym} -510 50 0 0 {name=l9 lab=GND}
C {devices/vsource.sym} -510 0 0 0 {name=V3 value="dc 1.4" savecurrent=false}
C {devices/asrc.sym} -330 0 0 0 {name=B1 function="V=1.4+0.5*(1+0.5*sin(2*pi*10k*time))*sin(2*pi*500k*time)"}
C {devices/code_shown.sym} -625 270 0 0 {name=control only_toplevel=false value=".option savecurrent
.control
save all
# Transienst analysis
tran 0.1u 1m 0 0.1u
write tb_ideal_diode.raw
.endc"}
C {devices/lab_pin.sym} -140 -280 0 1 {name=p5 sig_type=std_logic lab=VOUT}
C {devices/lab_pin.sym} -140 -140 0 0 {name=p6 sig_type=std_logic lab=VREF}
C {devices/res.sym} -140 -210 0 0 {name=R2
value=100k
footprint=1206
device=resistor
m=1}
C {ideal_diode.sym} -430 -280 0 0 {name=x1}
C {devices/gnd.sym} -470 -190 0 0 {name=l1 lab=GND}
C {devices/vdd.sym} -470 -370 0 0 {name=l6 lab=VDD}
C {devices/vdd.sym} -390 -370 0 0 {name=l7 lab=VREF}
C {devices/lab_pin.sym} -560 -280 0 0 {name=p2 sig_type=std_logic lab=VIN}
C {devices/gnd.sym} -600 50 0 0 {name=l11 lab=GND}
C {devices/lab_pin.sym} -600 -70 0 1 {name=l12 sig_type=std_logic lab=iB}
C {devices/isource.sym} -600 0 0 0 {name=I0 value=100u}
C {devices/lab_pin.sym} -390 -190 0 1 {name=l5 sig_type=std_logic lab=iB}
C {devices/capa.sym} -210 -210 0 0 {name=C1
m=1
value=100p
footprint=1206
device="ceramic capacitor"}
C {devices/lab_pin.sym} -210 -140 0 0 {name=p3 sig_type=std_logic lab=VREF}
