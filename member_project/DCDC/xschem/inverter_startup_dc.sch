v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 300 60 340 60 {lab=#net1}
N 240 0 390 0 {lab=#net2}
N 240 120 390 120 {lab=GND}
N 390 110 390 120 {lab=GND}
N 390 0 390 10 {lab=#net2}
N 240 0 240 60 {lab=#net2}
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
dc vin 0 6 0.01
plot v(out)
.endc"}
C {devices/vsource.sym} 240 90 0 0 {name=Vdd value=6 savecurrent=false}
C {devices/vsource.sym} 300 90 0 0 {name=Vin value=3 savecurrent=false}
C {devices/gnd.sym} 240 120 0 0 {name=l1 lab=GND}
C {devices/lab_pin.sym} 460 60 0 1 {name=p1 sig_type=std_logic lab=out}
C {inverter_startup.sym} 360 60 0 0 {name=x1}
