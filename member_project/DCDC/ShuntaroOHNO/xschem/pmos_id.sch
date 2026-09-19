v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 280 150 280 180 {lab=GND}
N 220 100 220 120 {lab=#net1}
N 220 120 240 120 {lab=#net1}
N 280 20 280 90 {lab=#net2}
N 220 20 220 40 {lab=#net2}
N 220 20 280 20 {lab=#net2}
N 280 120 290 120 {lab=#net2}
N 280 80 290 80 {lab=#net2}
N 290 80 290 120 {lab=#net2}
N 360 20 360 40 {lab=#net2}
N 280 20 360 20 {lab=#net2}
N 360 100 360 180 {lab=GND}
N 280 180 360 180 {lab=GND}
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
dc vgs 0 3.5 0.01
plot -i(vds)
.endc"}
C {MP.sym} 240 120 0 0 {name=M3 model=PMOS w=20u l=1u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/vsource.sym} 220 70 0 0 {name=Vgs value=3.5 savecurrent=false}
C {devices/gnd.sym} 280 180 0 0 {name=l3 lab=GND}
C {devices/vsource.sym} 360 70 0 0 {name=Vds value=0.5 savecurrent=false}
