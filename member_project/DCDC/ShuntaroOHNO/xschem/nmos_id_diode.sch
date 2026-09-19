v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 300 60 350 60 {lab=GND}
N 300 90 300 120 {lab=GND}
N 240 60 260 60 {lab=#net1}
N 240 60 240 80 {lab=#net1}
N 350 60 360 60 {lab=GND}
N 300 120 300 140 {lab=GND}
N 360 60 360 140 {lab=GND}
N 300 20 300 30 {lab=#net1}
N 240 140 360 140 {lab=GND}
N 240 20 300 20 {lab=#net1}
N 240 20 240 60 {lab=#net1}
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
dc vgs 0 1.2 0.01
plot -i(vgs)
.endc"}
C {devices/vsource.sym} 240 110 0 0 {name=Vgs value=1.0 savecurrent=false}
C {MN.sym} 260 60 0 0 {name=M1 model=NMOS w=10u l=2u nrd=0 nrs=0 m=7 spiceprefix=X}
C {devices/gnd.sym} 360 140 0 0 {name=l1 lab=GND}
