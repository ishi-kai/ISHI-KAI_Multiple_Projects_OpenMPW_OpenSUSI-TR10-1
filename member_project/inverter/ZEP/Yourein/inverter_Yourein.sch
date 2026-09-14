v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 20 -200 20 -40 {lab=A}
N 60 -170 60 -70 {lab=Q}
N 60 -10 60 50 {lab=VSS}
N 60 20 130 20 {lab=VSS}
N 130 -40 130 20 {lab=VSS}
N 60 -40 130 -40 {lab=VSS}
N -30 -120 20 -120 {lab=A}
N 60 -120 140 -120 {lab=Q}
N 60 -290 60 -230 {lab=VDD}
N 60 -200 120 -200 {lab=VDD}
N 120 -260 120 -200 {lab=VDD}
N 60 -260 120 -260 {lab=VDD}
C {MP.sym} 20 -200 0 0 {name=XM1 model=PMOS w=3.4u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MN.sym} 20 -40 0 0 {name=XM2 model=NMOS w=3.4u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {devices/ipin.sym} -30 -120 0 0 {name=p1 lab=A}
C {devices/iopin.sym} 60 50 0 0 {name=p2 lab=VSS}
C {devices/opin.sym} 140 -120 0 0 {name=p3 lab=Q}
C {devices/iopin.sym} 60 -290 0 1 {name=p4 lab=VDD}
