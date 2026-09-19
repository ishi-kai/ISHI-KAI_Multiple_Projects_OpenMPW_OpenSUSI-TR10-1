v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 260 100 280 100 {lab=#net1}
N 320 100 330 100 {lab=#net2}
N 320 60 330 60 {lab=#net2}
N 330 60 330 100 {lab=#net2}
N 400 40 400 60 {lab=#net2}
N 320 40 400 40 {lab=#net2}
N 260 210 400 210 {lab=GND}
N 320 130 320 150 {lab=#net3}
N 260 100 260 150 {lab=#net1}
N 320 40 320 70 {lab=#net2}
N 400 120 400 210 {lab=GND}
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
dc vds 1.5 3.0 0.01
plot -i(vds)
.endc"}
C {MP.sym} 280 100 0 0 {name=M3 model=PMOS w=15u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/gnd.sym} 320 210 0 0 {name=l3 lab=GND}
C {devices/vsource.sym} 400 90 0 0 {name=Vds value=0.7 savecurrent=false}
C {devices/vsource.sym} 260 180 0 0 {name=Vin value=0.8 savecurrent=false}
C {devices/vsource.sym} 320 180 0 0 {name=Vout value=1.5 savecurrent=false}
