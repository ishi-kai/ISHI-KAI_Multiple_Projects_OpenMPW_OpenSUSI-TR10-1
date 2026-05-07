v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 80 -360 880 40 {flags=graph
y1=-8.0098405
y2=29.980752
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=1.7369489
x2=8.4953491
divx=5
subdivx=8
xlabmag=1.0
ylabmag=1.0
node=gain
color=4
dataset=-1
unitx=1
logx=1
logy=0
sim_type=ac}
B 2 80 80 880 480 {flags=graph
y1=-103.35389
y2=338.91481
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=1.7369489
x2=8.4953491
divx=5
subdivx=8
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=1
logy=0
sim_type=ac
color=4
node=phase}
N -80 -310 -80 -290 {lab=VDD}
N -80 -230 -80 -210 {lab=GND}
N -160 -310 -160 -290 {lab=VREF}
N -160 -230 -160 -210 {lab=GND}
N -120 -30 -120 30 {lab=VOUT}
N -180 -60 -160 -60 {lab=VIN}
N -180 -60 -180 60 {lab=VIN}
N -180 60 -160 60 {lab=VIN}
N -120 -110 -120 -90 {lab=VDD}
N -120 90 -120 120 {lab=GND}
N -120 0 0 0 {lab=VOUT}
N -230 170 -170 170 {lab=VIN}
N -230 0 -230 170 {lab=VIN}
N -110 170 -70 170 {lab=VOUT}
N -70 0 -70 170 {lab=VOUT}
N -120 60 -100 60 {lab=GND}
N -100 60 -100 90 {lab=GND}
N -120 90 -100 90 {lab=GND}
N -120 -60 -100 -60 {lab=VDD}
N -100 -90 -100 -60 {lab=VDD}
N -120 -90 -100 -90 {lab=VDD}
N -360 0 -330 0 {lab=VIN}
N -360 0 -360 50 {lab=VIN}
N -330 0 -310 0 {lab=VIN}
N -250 0 -230 0 {lab=VIN}
N -230 0 -180 0 {lab=VIN}
N -310 0 -250 0 {lab=VIN}
C {devices/code_shown.sym} -340 250 0 0 {name=spice only_toplevel=false value=".option savecurrent
.control
set units=degree
op
show m
save all

* AC analysis
ac dec 20 1e-1 1e10
let gain = db(-v(vout)/v(vin))
let phase = vp(vout)
*plot gain
*plot phase
meas ac dc_gain find gain at=1
meas ac p_margin find phase when gain=0
meas ac g_margin find gain when phase=-180
write tb_invamp_ac.raw

.endc
.end
"
}
C {devices/lab_pin.sym} 0 0 0 1 {name=p1 sig_type=std_logic lab=VOUT}
C {devices/lab_wire.sym} -360 0 0 0 {name=p3 sig_type=std_logic lab=VIN}
C {devices/vsource.sym} -360 80 0 0 {name=VIN value="AC 1" savecurrent=false}
C {devices/gnd.sym} -360 110 0 0 {name=l3 lab=VREF}
C {devices/code.sym} -350 -310 0 0 {name=TR-1
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/vdd.sym} -80 -310 0 0 {name=l6 lab=VDD}
C {devices/gnd.sym} -80 -210 0 0 {name=l7 lab=GND}
C {devices/vsource.sym} -80 -260 0 0 {name=V1 value="dc 5" savecurrent=false}
C {devices/vdd.sym} -160 -310 0 0 {name=l8 lab=VREF}
C {devices/gnd.sym} -160 -210 0 0 {name=l10 lab=GND}
C {devices/vsource.sym} -160 -260 0 0 {name=V4 value="dc 2.5" savecurrent=false}
C {MP.sym} -160 -60 0 0 {name=M3 model=PMOS w=30u l=5u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} -160 60 0 0 {name=M4 model=NMOS w=10u l=5u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/gnd.sym} -120 120 0 1 {name=l9 lab=GND}
C {devices/vdd.sym} -120 -110 0 0 {name=l11 lab=VDD}
C {devices/res.sym} -140 170 3 1 {name=R4
value=1000k
footprint=1206
device=resistor
m=1}
