v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 260 -330 260 -170 {lab=A}
N 340 -330 350 -330 {lab=VDD}
N 350 -360 350 -330 {lab=VDD}
N 340 -400 340 -360 {lab=VDD}
N 350 -370 350 -360 {lab=VDD}
N 340 -370 350 -370 {lab=VDD}
N 340 -140 340 -100 {lab=VSS}
N 340 -170 350 -170 {lab=VSS}
N 350 -170 350 -130 {lab=VSS}
N 340 -130 350 -130 {lab=VSS}
N 360 -250 400 -250 {lab=Q}
N 220 -250 260 -250 {lab=A}
N 260 -330 300 -330 {lab=A}
N 260 -170 300 -170 {lab=A}
N 360 -300 360 -200 {lab=Q}
N 340 -300 360 -300 {lab=Q}
N 340 -200 360 -200 {lab=Q}
C {MP.sym} 300 -330 0 0 {name=XM1 model=PMOS w=3.4u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MN.sym} 300 -170 0 0 {name=XM2 model=NMOS w=3.4u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {devices/ipin.sym} 220 -250 0 0 {name=p2 lab=A}
C {devices/iopin.sym} 340 -400 0 0 {name=p3 lab=VDD}
C {devices/opin.sym} 400 -250 0 0 {name=p4 lab=Q}
C {devices/iopin.sym} 340 -100 0 0 {name=p1 lab=VSS}
