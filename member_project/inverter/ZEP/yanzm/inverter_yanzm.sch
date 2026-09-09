v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -40 -300 -40 -140 {lab=A}
N -0 -270 0 -170 {lab=Q}
N -70 -220 -40 -220 {lab=A}
N 0 -220 60 -220 {lab=Q}
N 0 -300 20 -300 {lab=VDD}
N 20 -330 20 -300 {lab=VDD}
N 0 -340 20 -340 {lab=VDD}
N -0 -360 -0 -330 {lab=VDD}
N 20 -340 20 -330 {lab=VDD}
N 0 -110 0 -60 {lab=VSS}
N 0 -140 20 -140 {lab=VSS}
N 20 -140 20 -90 {lab=VSS}
N 0 -90 20 -90 {lab=VSS}
C {MP.sym} -40 -300 0 0 {name=XM1 model=PMOS w=3.4u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MN.sym} -40 -140 0 0 {name=XM2 model=NMOS w=3.4u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {devices/ipin.sym} -70 -220 0 0 {name=p1 lab=A}
C {devices/iopin.sym} 0 -360 0 0 {name=p2 lab=VDD}
C {devices/opin.sym} 60 -220 0 0 {name=p3 lab=Q}
C {devices/iopin.sym} 0 -60 0 0 {name=p4 lab=VSS}
