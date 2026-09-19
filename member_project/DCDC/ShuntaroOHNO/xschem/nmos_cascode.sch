v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 320 240 320 260 {lab=GND}
N 460 240 460 260 {lab=GND}
N 360 210 420 210 {lab=#net1}
N 360 130 420 130 {lab=#net2}
N 320 160 320 180 {lab=#net3}
N 460 160 460 180 {lab=#net4}
N 310 130 320 130 {lab=GND}
N 310 130 310 260 {lab=GND}
N 310 210 320 210 {lab=GND}
N 460 130 470 130 {lab=GND}
N 460 210 470 210 {lab=GND}
N 470 130 470 260 {lab=GND}
N 320 80 320 100 {lab=#net1}
N 320 0 320 20 {lab=#net2}
N 460 -0 460 100 {lab=#net5}
N 320 10 380 10 {lab=#net2}
N 320 90 370 90 {lab=#net1}
N 370 90 370 210 {lab=#net1}
N 380 10 380 130 {lab=#net2}
N 320 -60 540 -60 {lab=GND}
N 540 -60 540 260 {lab=GND}
N 310 260 540 260 {lab=GND}
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
.endc"}
C {MN.sym} 360 210 0 1 {name=M1 model=NMOS w=10u l=2u nrd=0 nrs=0 m=5 spiceprefix=X}
C {devices/gnd.sym} 390 260 0 0 {name=l1 lab=GND}
C {MN.sym} 360 130 0 1 {name=M2 model=NMOS w=20u l=1u nrd=0 nrs=0 m=5 spiceprefix=X}
C {MN.sym} 420 210 0 0 {name=M5 model=NMOS w=10u l=2u nrd=0 nrs=0 m=5 spiceprefix=X}
C {MN.sym} 420 130 0 0 {name=M6 model=NMOS w=20u l=1u nrd=0 nrs=0 m=5 spiceprefix=X}
C {RS.sym} 320 20 0 0 {name=R1
w=4e-6
R=1
l=350e-6
model=F_RS
spiceprefix=X
tc1=0
tc2=0}
C {devices/isource.sym} 320 -30 0 0 {name=I0 value=40u}
C {devices/isource.sym} 460 -30 0 0 {name=I1 value=40u}
