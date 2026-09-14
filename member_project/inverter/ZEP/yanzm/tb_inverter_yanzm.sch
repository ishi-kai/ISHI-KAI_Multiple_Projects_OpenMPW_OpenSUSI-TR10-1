v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -40 -300 -40 -140 {lab=A}
N -0 -270 0 -170 {lab=Q}
N -70 -220 -40 -220 {lab=A}
N 0 -220 60 -220 {lab=Q}
N 0 -300 20 -300 {lab=#net1}
N 20 -330 20 -300 {lab=#net1}
N 0 -340 20 -340 {lab=#net1}
N -0 -360 -0 -330 {lab=#net1}
N 20 -340 20 -330 {lab=#net1}
N 0 -110 0 -60 {lab=0}
N 0 -140 20 -140 {lab=0}
N 20 -140 20 -90 {lab=0}
N 0 -90 20 -90 {lab=0}
N -190 -120 -190 -100 {lab=0}
N -190 -100 -190 -70 {lab=0}
N -260 -120 -260 -90 {lab=0}
N -260 -90 -190 -90 {lab=0}
N -260 -210 -260 -180 {lab=VDD}
N -190 -210 -190 -180 {lab=A}
N 0 -450 0 -420 {lab=VDD}
C {MP.sym} -40 -300 0 0 {name=XM1 model=PMOS w=3.4u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {devices/code.sym} -60 20 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {MN.sym} -40 -140 0 0 {name=XM2 model=NMOS w=3.4u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {devices/ipin.sym} -70 -220 0 0 {name=p1 lab=A}
C {devices/iopin.sym} 0 -450 0 0 {name=p2 lab=VDD}
C {devices/opin.sym} 60 -220 0 0 {name=p3 lab=Q}
C {devices/code_shown.sym} 220 -340 0 0 {name=spice only_toplevel=false value=".option savecurrent
.control
save all

* DC analysis (I/O curve)
dc vin 0 5.0 0.01
plot Q A
plot i(vd)
wrdata ~/tb_inv.txt v(Q)
write tb_inv.raw
.endc"}
C {devices/code_shown.sym} 210 -60 0 0 {name=measure only_toplevel=false value=".measure dc Vinv when v(Q)=2.5"}
C {devices/vsource.sym} -260 -150 0 0 {name=vdd value=5.0 savecurrent=false}
C {devices/gnd.sym} -190 -70 0 0 {name=l1 lab=0}
C {devices/vsource.sym} -190 -150 0 0 {name=vin value=5.0 savecurrent=false}
C {devices/lab_wire.sym} -260 -210 0 0 {name=p5 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} -190 -210 0 0 {name=p6 sig_type=std_logic lab=A}
C {devices/gnd.sym} 0 -60 0 0 {name=l2 lab=0}
C {devices/ammeter.sym} 0 -390 0 0 {name=vd savecurrent=true spice_ignore=0}
