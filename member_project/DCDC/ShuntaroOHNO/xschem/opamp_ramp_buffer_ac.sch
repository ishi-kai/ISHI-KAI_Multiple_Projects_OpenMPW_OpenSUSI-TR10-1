v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 360 100 360 140 {lab=#net1}
N 360 100 520 100 {lab=#net1}
N 240 60 240 140 {lab=#net2}
N 570 60 570 70 {lab=#net2}
N 570 170 570 200 {lab=GND}
N 240 60 570 60 {lab=#net2}
N 660 120 660 140 {lab=out}
N 300 80 520 80 {lab=#net3}
N 300 80 300 140 {lab=#net3}
N 640 120 640 180 {lab=out}
N 520 140 520 180 {lab=out}
N 520 180 640 180 {lab=out}
N 640 120 680 120 {lab=out}
N 240 200 660 200 {lab=GND}
C {devices/vsource.sym} 360 170 0 0 {name=Vinp value="DC 1.0 AC 1" savecurrent=false}
C {devices/vsource.sym} 240 170 0 0 {name=Vdd value=3.5 savecurrent=false}
C {devices/gnd.sym} 240 200 0 0 {name=l1 lab=GND}
C {devices/lab_pin.sym} 680 120 0 1 {name=p1 sig_type=std_logic lab=out}
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
ac dec 100 1 100Meg
plot vdb(out)
plot vp(out)
.endc"}
C {devices/capa.sym} 660 170 0 0 {name=C1
m=1
value=30p
footprint=1206
device="ceramic capacitor"}
C {devices/isource.sym} 300 170 0 0 {name=I0 value=72u}
C {opamp_ramp.sym} 540 120 0 0 {name=x1}
