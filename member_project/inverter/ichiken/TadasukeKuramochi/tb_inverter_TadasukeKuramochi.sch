v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 20 -30 20 110 {lab=A}
N 60 -0 60 80 {lab=Q}
N 60 40 160 40 {lab=Q}
N -60 40 20 40 {lab=A}
N 60 110 70 110 {lab=GND}
N 70 110 70 150 {lab=GND}
N 60 150 70 150 {lab=GND}
N 60 -30 70 -30 {lab=#net1}
N 70 -70 70 -30 {lab=#net1}
N 60 -70 70 -70 {lab=#net1}
N -190 140 -190 220 {lab=GND}
N -290 140 -290 220 {lab=GND}
N -190 0 -190 80 {lab=A}
N -290 0 -290 80 {lab=VDD}
N 60 -200 60 -160 {lab=VDD}
N 60 -100 60 -60 {lab=#net1}
N 60 140 60 220 {lab=GND}
C {IP62LIB/MP.sym} 20 -30 0 0 {name=XM1
model=PMOS
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
C {IP62LIB/MN.sym} 20 110 0 0 {name=XM2
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
C {devices/code.sym} -280 -190 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/ipin.sym} -60 40 0 0 {name=p1 lab=A}
C {devices/opin.sym} 160 40 0 0 {name=p2 lab=Q}
C {devices/iopin.sym} 60 -200 0 0 {name=p3 lab=VDD}
C {devices/code_shown.sym} 220 -120 0 0 {name=spice only_toplevel=false value=".option savecurrent
.control
save all

* DC analysis (I/O curve)
dc vin 0 5.0 0.01
plot Q A
plot i(vd)
wrdata ~/projects/inverter/tb_inverter.txt v(Q)
write tb_inverter.raw
.endc"}
C {devices/code_shown.sym} 220 150 0 0 {name=measure only_toplevel=false value=".measure dc Vinv when v(Q)=2.5"}
C {devices/gnd.sym} -190 220 0 0 {name=l1 lab=GND}
C {devices/vsource.sym} -190 110 0 0 {name=vin value=5 savecurrent=false}
C {devices/gnd.sym} -290 220 0 0 {name=l2 lab=GND}
C {devices/vsource.sym} -290 110 0 0 {name=vdd value=5 savecurrent=false}
C {devices/lab_wire.sym} -190 0 0 0 {name=p5 sig_type=std_logic lab=A}
C {devices/lab_wire.sym} -290 0 0 0 {name=p6 sig_type=std_logic lab=VDD}
C {devices/gnd.sym} 60 220 0 0 {name=l3 lab=GND}
C {devices/ammeter.sym} 60 -130 0 0 {name=Vd savecurrent=true spice_ignore=0}
