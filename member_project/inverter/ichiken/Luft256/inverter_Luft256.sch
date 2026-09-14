v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -10 -130 20 -130 {lab=Q}
N 20 -130 20 -60 {lab=Q}
N -10 -60 20 -60 {lab=Q}
N -70 -160 -50 -160 {lab=A}
N -70 -160 -70 -30 {lab=A}
N -70 -30 -50 -30 {lab=A}
N 20 -90 40 -90 {lab=Q}
N -90 -90 -70 -90 {lab=A}
N -10 -250 -10 -190 {lab=VDD}
N -10 0 -10 40 {lab=xxx}
N -10 -210 10 -210 {lab=VDD}
N 10 -210 10 -160 {lab=VDD}
N -10 -160 10 -160 {lab=VDD}
N -10 -30 20 -30 {lab=xxx}
N 20 -30 20 10 {lab=xxx}
N -10 10 20 10 {lab=xxx}
C {MP.sym} -50 -160 0 0 {name=XM1 model=PMOS w=3.4u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MN.sym} -50 -30 0 0 {name=XM2 model=NMOS w=3.4u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {devices/ipin.sym} -90 -90 0 0 {name=p1 lab=A}
C {devices/iopin.sym} -10 -250 0 0 {name=p2 lab=VDD}
C {devices/iopin.sym} -10 40 0 0 {name=p3 lab=VSS}
C {devices/opin.sym} 40 -90 0 0 {name=p4 lab=Q}
