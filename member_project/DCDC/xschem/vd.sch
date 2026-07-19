v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 320 140 320 200 {lab=#net1}
N 420 200 460 200 {lab=Vd1}
N 560 200 600 200 {lab=Vd2}
N 560 80 560 140 {lab=#net1}
N 320 80 560 80 {lab=#net1}
N 320 80 320 140 {lab=#net1}
N 700 200 740 200 {lab=Vd4}
N 700 80 700 140 {lab=#net1}
N 560 80 700 80 {lab=#net1}
N 840 200 880 200 {lab=Vd8}
N 840 80 840 140 {lab=#net1}
N 700 80 840 80 {lab=#net1}
C {devices/code.sym} -10 0 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {DP.sym} 420 260 2 0 {name=D1 model=DP m=1}
C {devices/gnd.sym} 420 260 0 0 {name=l1 lab=GND}
C {devices/isource.sym} 420 170 0 0 {name=Ib1 value=0}
C {devices/vsource.sym} 320 230 0 0 {name=Vdd value=5 savecurrent=false}
C {devices/gnd.sym} 320 260 0 0 {name=l2 lab=GND}
C {devices/code_shown.sym} 0 160 0 0 {name=s1 only_toplevel=false value=".option savecurrents
.control
op
show m
save all
dc ib1 1u 80u 1u
plot v(vd1) v(vd2) v(vd4) v(vd8)
plot v(vd1)-v(vd2) v(vd1)-v(vd4) v(vd1)-v(vd8)
.endc"}
C {devices/lab_pin.sym} 460 200 0 1 {name=p1 sig_type=std_logic lab=Vd1}
C {DP.sym} 560 260 2 0 {name=D2 model=DP m=2}
C {devices/gnd.sym} 560 260 0 0 {name=l3 lab=GND}
C {devices/lab_pin.sym} 600 200 0 1 {name=p2 sig_type=std_logic lab=Vd2}
C {devices/vsource.sym} 420 110 0 0 {name=Vib value=0 savecurrent=false}
C {devices/cccs.sym} 560 170 0 0 {name=F1 vnam=Vib value=1}
C {DP.sym} 700 260 2 0 {name=D3 model=DP m=4}
C {devices/gnd.sym} 700 260 0 0 {name=l4 lab=GND}
C {devices/lab_pin.sym} 740 200 0 1 {name=p3 sig_type=std_logic lab=Vd4}
C {devices/cccs.sym} 700 170 0 0 {name=F2 vnam=Vib value=1}
C {DP.sym} 840 260 2 0 {name=D4 model=DP m=8}
C {devices/gnd.sym} 840 260 0 0 {name=l5 lab=GND}
C {devices/lab_pin.sym} 880 200 0 1 {name=p4 sig_type=std_logic lab=Vd8}
C {devices/cccs.sym} 840 170 0 0 {name=F3 vnam=Vib value=1}
