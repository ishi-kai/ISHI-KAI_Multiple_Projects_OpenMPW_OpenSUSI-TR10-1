v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 300 80 300 90 {lab=#net1}
N 300 80 380 80 {lab=#net1}
N 380 80 380 90 {lab=#net1}
N 300 120 350 120 {lab=#net1}
N 350 80 350 120 {lab=#net1}
N 300 150 300 180 {lab=#net2}
N 380 150 380 270 {lab=#net3}
N 300 270 380 270 {lab=#net3}
N 260 120 260 240 {lab=#net3}
N 260 270 300 270 {lab=#net3}
N 300 240 300 270 {lab=#net3}
N 260 240 260 270 {lab=#net3}
N 300 210 360 210 {lab=#net1}
N 360 80 360 210 {lab=#net1}
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
dc v1 0 2 0.1
plot -i(v1)
.endc"}
C {MP.sym} 260 120 0 0 {name=M1 model=PMOS w=55u l=3u nrd=0 nrs=0 m=8 spiceprefix=X}
C {devices/vsource.sym} 380 120 0 0 {name=V1 value=1.3 savecurrent=false}
C {MP.sym} 260 210 0 0 {name=M2 model=PMOS w=55u l=3u nrd=0 nrs=0 m=8 spiceprefix=X}
