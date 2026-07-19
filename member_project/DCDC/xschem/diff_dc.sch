v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 480 100 520 100 {lab=#net1}
N 480 100 480 140 {lab=#net1}
N 360 120 520 120 {lab=#net2}
N 240 60 240 140 {lab=#net3}
N 570 60 570 70 {lab=#net3}
N 570 170 570 200 {lab=GND}
N 240 60 570 60 {lab=#net3}
N 300 80 520 80 {lab=#net4}
N 300 80 300 140 {lab=#net4}
N 240 200 570 200 {lab=GND}
N 570 60 690 60 {lab=#net3}
N 690 60 690 70 {lab=#net3}
N 570 200 690 200 {lab=GND}
N 690 170 690 200 {lab=GND}
N 360 120 360 140 {lab=#net2}
N 520 120 520 140 {lab=#net2}
N 640 120 760 120 {lab=out}
C {devices/vsource.sym} 480 170 0 0 {name=Vinn value="DC 0.75" savecurrent=false}
C {devices/vsource.sym} 360 170 0 0 {name=Vinp value="DC 1 AC 1" savecurrent=false}
C {devices/vsource.sym} 240 170 0 0 {name=Vdd value=3.0 savecurrent=false}
C {devices/gnd.sym} 240 200 0 0 {name=l1 lab=GND}
C {devices/lab_pin.sym} 760 120 0 1 {name=p1 sig_type=std_logic lab=out}
C {devices/code.sym} -10 0 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/code_shown.sym} 0 150 0 0 {name=s1 only_toplevel=false value=".option savecurrents
.control
set units=degree
op
show m
save all
dc vinp 0 3 0.01
plot v(out)
.endc"}
C {devices/isource.sym} 300 170 0 0 {name=I0 value=5u}
C {diff.sym} 540 120 0 0 {name=x1}
