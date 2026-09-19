v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 220 120 240 120 {lab=GND}
N 280 120 290 120 {lab=#net1}
N 280 80 290 80 {lab=#net1}
N 290 80 290 120 {lab=#net1}
N 220 150 280 150 {lab=GND}
N 220 120 220 150 {lab=GND}
N 220 60 280 60 {lab=#net1}
N 280 60 280 90 {lab=#net1}
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
C {MP.sym} 240 120 0 0 {name=M3 model=PMOS w=20u l=2u nrd=0 nrs=0 m=7 spiceprefix=X}
C {devices/vsource.sym} 220 90 0 1 {name=Vgs value=1.0 savecurrent=false}
C {devices/gnd.sym} 280 150 0 1 {name=l3 lab=GND}
