v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 200 -30 200 30 {lab=vout}
N 100 -60 160 -60 {lab=vin}
N 100 -60 100 60 {lab=vin}
N 100 60 160 60 {lab=vin}
N 40 -0 100 -0 {lab=vin}
N 200 -0 300 0 {lab=vout}
N 200 -140 200 -90 {lab=#net1}
N 200 90 200 140 {lab=GND}
N 200 -100 220 -100 {lab=#net1}
N 220 -100 220 -60 {lab=#net1}
N 200 -60 220 -60 {lab=#net1}
N 200 100 220 100 {lab=GND}
N 220 60 220 100 {lab=GND}
N 200 60 220 60 {lab=GND}
N -180 20 -180 80 {lab=VDD}
N -180 140 -180 220 {lab=GND}
N -100 140 -100 220 {lab=GND}
N -100 20 -100 80 {lab=vin}
N 200 -240 200 -200 {lab=VDD}
N 300 120 300 140 {lab=GND}
N 300 0 300 60 {lab=vout}
C {TR-1umLIB/MP.sym} 160 -60 0 0 {name=XM1
model=PMOS
w=8u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MN.sym} 160 60 0 0 {name=XM2
model=NMOS
w=3.4u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {devices/code.sym} -200 -220 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/vsource.sym} -180 110 0 0 {name=Vdd value=5.0 savecurrent=false}
C {devices/vsource.sym} -100 110 0 0 {name=vin value=5.0 savecurrent=false}
C {devices/vdd.sym} -180 20 0 0 {name=l1 lab=VDD}
C {devices/lab_pin.sym} -100 20 0 0 {name=p5 sig_type=std_logic lab=vin}
C {devices/gnd.sym} -180 220 0 0 {name=l2 lab=GND}
C {devices/gnd.sym} -100 220 0 0 {name=l3 lab=GND}
C {devices/vdd.sym} 200 -240 0 0 {name=l4 lab=VDD}
C {devices/ammeter.sym} 200 -170 0 0 {name=Vd savecurrent=true spice_ignore=0}
C {devices/gnd.sym} 200 140 0 0 {name=l5 lab=GND}
C {devices/lab_pin.sym} 40 0 0 0 {name=p1 sig_type=std_logic lab=vin}
C {devices/lab_pin.sym} 300 0 0 0 {name=p2 sig_type=std_logic lab=vout}
C {devices/capa.sym} 300 90 0 0 {name=C1
m=1
value=10f
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 300 140 0 0 {name=l6 lab=GND}
C {devices/code_shown.sym} 460 -220 0 0 {name=spice only_toplevel=false value=".option savecurrent
.control
save all

* DC analysis (I/O curve)
dc vin 0 5.0 0.01
plot vout vin
plot i(vd)
.endc"}
C {devices/code_shown.sym} 460 40 0 0 {name=measure only_toplevel=false value=".measure dc Vinv when v(vout)=2.5"}
