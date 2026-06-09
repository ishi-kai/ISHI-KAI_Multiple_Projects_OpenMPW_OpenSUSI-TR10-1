v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 410 -240 410 -170 {lab=xxx}
N 410 -140 440 -140 {lab=VSS}
N 440 -140 440 -70 {lab=VSS}
N 410 -70 440 -70 {lab=VSS}
N 410 -270 440 -270 {lab=VDD}
N 440 -330 440 -270 {lab=VDD}
N 410 -330 440 -330 {lab=VDD}
N 410 -360 410 -300 {lab=VDD}
N 300 -270 370 -270 {lab=VIN}
N 300 -270 300 -140 {lab=VIN}
N 300 -140 370 -140 {lab=VIN}
N 410 -110 410 -30 {lab=VSS}
N 270 -200 300 -200 {lab=VIN}
N 410 -200 460 -200 {lab=xxx}
C {MN.sym} 370 -140 0 0 {name=M1 model=NMOS w=6.8u l=10u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 370 -270 0 0 {name=M2 model=PMOS w=20u l=10u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/ipin.sym} 270 -200 0 0 {name=p3 lab=VIN}
C {devices/opin.sym} 460 -200 0 0 {name=p4 lab=VOUT}
C {devices/iopin.sym} 410 -30 0 1 {name=p5 lab=VSS}
C {devices/iopin.sym} 410 -360 0 1 {name=p6 lab=VDD}
C {devices/code.sym} 40 -150 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
