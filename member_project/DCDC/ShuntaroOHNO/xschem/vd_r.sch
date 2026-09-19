v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 450 130 490 130 {lab=Vd1}
N 570 130 610 130 {lab=Vd4}
N 570 200 570 220 {lab=#net1}
N 570 120 570 140 {lab=Vd4}
N 450 120 450 220 {lab=Vd1}
N 570 0 570 60 {lab=#net2}
N 360 0 360 220 {lab=#net2}
N 360 -0 570 -0 {lab=#net2}
C {devices/code.sym} -10 0 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/code_shown.sym} 0 160 0 0 {name=s1 only_toplevel=false value=".option savecurrents
.control
op
show m
save all
dc ib1 10u 80u 1u
plot v(vd1) v(vd4)
.endc"}
C {DP.sym} 450 280 2 0 {name=D1 model=DP m=1}
C {devices/gnd.sym} 450 280 0 0 {name=l1 lab=GND}
C {devices/isource.sym} 450 90 0 0 {name=Ib1 value=40u}
C {devices/lab_pin.sym} 490 130 0 1 {name=p1 sig_type=std_logic lab=Vd1}
C {devices/vsource.sym} 450 30 0 0 {name=Vib value=0 savecurrent=false}
C {DP.sym} 570 280 2 0 {name=D2 model=DP m=4}
C {devices/gnd.sym} 570 280 0 0 {name=l4 lab=GND}
C {devices/lab_pin.sym} 610 130 0 1 {name=p3 sig_type=std_logic lab=Vd4}
C {devices/cccs.sym} 570 90 0 0 {name=F1 vnam=Vib value=1}
C {RS.sym} 570 140 0 0 {name=R1
w=4e-6
R=1
l=40.0e-6
model=F_RS
spiceprefix=X
tc1=0
tc2=0}
C {devices/vsource.sym} 360 250 0 0 {name=Vdd value=3 savecurrent=false}
C {devices/gnd.sym} 360 280 0 0 {name=l2 lab=GND}
