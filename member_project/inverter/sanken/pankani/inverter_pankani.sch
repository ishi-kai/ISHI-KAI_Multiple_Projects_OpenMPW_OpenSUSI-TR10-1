v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -130 -320 -130 -230 {lab=VDD}
N -320 -90 -250 -90 {lab=A}
N -250 -200 -170 -200 {lab=A}
N -250 40 -170 40 {lab=A}
N -250 -200 -250 40 {lab=A}
N -130 -200 -110 -200 {lab=VDD}
N -130 -260 -110 -260 {lab=VDD}
N -110 -260 -110 -200 {lab=VDD}
N -130 -170 -30 -170 {lab=Q}
N -130 10 -30 10 {lab=Q}
N -30 -170 -30 10 {lab=Q}
N -30 -90 50 -90 {lab=Q}
N -130 70 -130 140 {lab=VSS}
N -130 90 -110 90 {lab=VSS}
N -110 40 -110 90 {lab=VSS}
N -130 40 -110 40 {lab=VSS}
N -130 -360 -130 -320 {lab=VDD}
C {TR-1umLIB/MP.sym} -170 -200 0 0 {name=M1 model=PMOS w=3.4u l=1u nrd=0 nrs=0 m=3 spiceprefix=X}
C {TR-1umLIB/MN.sym} -170 40 0 0 {name=XM2
model=NMOS
w=3.4u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {devices/iopin.sym} -130 -360 0 0 {name=p3 lab=VDD}
C {devices/iopin.sym} -130 140 0 0 {name=p4 lab=VSS}
C {devices/ipin.sym} -320 -90 0 0 {name=p1 lab=A
}
C {devices/opin.sym} 50 -90 0 0 {name=p2 lab=Q}
