v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 70 -120 70 -80 {lab=VDD}
N 70 70 70 100 {lab=VSS}
N 70 -50 120 -50 {lab=VDD}
N 120 -120 120 -50 {lab=VDD}
N 70 0 70 10 {lab=xxx}
N 30 0 30 40 {lab=VIN}
N 0 0 30 0 {lab=VIN}
N 70 0 160 0 {lab=xxx}
N 70 40 120 40 {lab=VSS}
N 70 -120 120 -120 {lab=VDD}
N 30 -50 30 0 {lab=VIN}
N 70 -20 70 0 {lab=xxx}
N 120 40 120 100 {lab=VSS}
N 70 100 120 100 {lab=VSS}
C {devices/ipin.sym} 70 100 0 0 {name=p1 lab=VSS}
C {devices/ipin.sym} 70 -120 0 0 {name=p4 lab=VDD}
C {MP.sym} 30 -50 0 0 {name=M1 model=PMOS w=12u l=10u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 30 40 0 0 {name=M2 model=NMOS w=4u l=10u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/ipin.sym} 0 0 0 0 {name=p2 lab=VIN}
C {devices/opin.sym} 160 0 0 0 {name=p3 lab=VOUT}
