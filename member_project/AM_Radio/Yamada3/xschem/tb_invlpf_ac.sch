v {xschem version=3.4.7RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
B 2 80 -360 880 40 {flags=graph
y1=-7.7969619
y2=28.674007
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=2.1124095
x2=8.8708095
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
sim_type=ac
rawfile=$netlist_dir/tb_invlpf_ac.raw}
B 2 80 80 880 480 {flags=graph
y1=-9.6813892
y2=329.98097
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=2.1124095
x2=8.8708095
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
node=phase
rawfile=$netlist_dir/tb_invlpf_ac.raw}
N -80 -310 -80 -290 {lab=VDD}
N -80 -230 -80 -210 {lab=GND}
N -160 -310 -160 -290 {lab=VREF}
N -160 -230 -160 -210 {lab=GND}
N -250 -30 -250 30 {lab=VOUT}
N -310 -60 -290 -60 {lab=#net1}
N -310 -60 -310 60 {lab=#net1}
N -310 60 -290 60 {lab=#net1}
N -250 -110 -250 -90 {lab=VDD}
N -250 90 -250 120 {lab=GND}
N -250 0 -130 0 {lab=VOUT}
N -360 170 -300 170 {lab=#net1}
N -360 0 -360 170 {lab=#net1}
N -240 170 -200 170 {lab=VOUT}
N -200 0 -200 170 {lab=VOUT}
N -250 60 -230 60 {lab=GND}
N -230 60 -230 90 {lab=GND}
N -250 90 -230 90 {lab=GND}
N -250 -60 -230 -60 {lab=VDD}
N -230 -90 -230 -60 {lab=VDD}
N -250 -90 -230 -90 {lab=VDD}
N -490 0 -490 50 {lab=VIN}
N -380 0 -360 0 {lab=#net1}
N -360 0 -310 0 {lab=#net1}
N -490 0 -440 0 {lab=VIN}
N -360 230 -300 230 {lab=#net1}
N -360 170 -360 230 {lab=#net1}
N -200 170 -200 230 {lab=VOUT}
N -240 230 -200 230 {lab=VOUT}
N -70 0 -0 0 {lab=VOUT}
N -130 0 -70 0 {lab=VOUT}
C {devices/code_shown.sym} -350 370 0 0 {name=spice only_toplevel=false value=".option savecurrent
.control
set units=degree
op
show m
save all

* AC analysis
ac dec 20 1e-1 1e10
let gain = db(-v(vout)/v(vin))
let phase = vp(vout)
plot gain
plot phase
meas ac dc_gain find gain at=1
meas ac p_margin find phase when gain=0
meas ac g_margin find gain when phase=-180
write tb_invlpf_ac.raw
*exit
.endc
.end
"
}
C {devices/lab_pin.sym} 0 0 0 1 {name=p1 sig_type=std_logic lab=VOUT}
C {devices/lab_wire.sym} -490 0 0 0 {name=p3 sig_type=std_logic lab=VIN}
C {devices/vsource.sym} -490 80 0 0 {name=VIN value="AC 1" savecurrent=false}
C {devices/gnd.sym} -490 110 0 0 {name=l3 lab=VREF}
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
C {MP.sym} -290 -60 0 0 {name=M3 model=PMOS w=30u l=5u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} -290 60 0 0 {name=M4 model=NMOS w=10u l=5u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/gnd.sym} -250 120 0 1 {name=l9 lab=GND}
C {devices/vdd.sym} -250 -110 0 0 {name=l11 lab=VDD}
C {devices/res.sym} -270 170 3 1 {name=R4
value=100k
footprint=1206
device=resistor
m=1}
C {devices/res.sym} -410 0 3 1 {name=R1
value=5k
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} -270 230 3 1 {name=C4
m=1
value=8p
footprint=1206
device="ceramic capacitor"}
