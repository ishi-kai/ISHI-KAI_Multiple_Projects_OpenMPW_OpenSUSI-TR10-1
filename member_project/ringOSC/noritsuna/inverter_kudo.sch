v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 430 -510 470 -510 {
lab=Q}
N 470 -510 470 -410 {
lab=Q}
N 430 -410 470 -410 {
lab=Q}
N 360 -380 390 -380 {
lab=A}
N 360 -540 360 -380 {
lab=A}
N 360 -540 390 -540 {
lab=A}
N 290 -460 360 -460 {
lab=A}
N 470 -460 540 -460 {
lab=Q}
N 430 -630 430 -570 {
lab=VDD}
N 430 -350 430 -300 {
lab=VSS}
N 430 -380 440 -380 {
lab=VSS}
N 440 -380 440 -340 {
lab=VSS}
N 430 -340 440 -340 {
lab=VSS}
N 430 -580 440 -580 {
lab=VDD}
N 440 -580 440 -540 {
lab=VDD}
N 430 -540 440 -540 {
lab=VDD}
C {devices/ipin.sym} 290 -460 0 0 {name=p1 lab=A}
C {devices/opin.sym} 540 -460 0 0 {name=p2 lab=Q}
C {devices/iopin.sym} 430 -630 0 1 {name=p3 lab=VDD}
C {devices/iopin.sym} 430 -300 0 0 {name=p4 lab=VSS}
C {MP.sym} 390 -540 0 0 {name=M1 model=PMOS w=3.4u l=1u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 390 -380 0 0 {name=M2 model=NMOS w=3.4u l=1u nrd=0 nrs=0 m=1 spiceprefix=X}
