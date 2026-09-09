v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 60 -170 60 -100 {lab=xxx}
N 60 -40 60 40 {lab=Q}
N 60 100 60 170 {lab=VSS}
N 20 -70 20 70 {lab=A}
N 60 -70 90 -70 {lab=xxx}
N 90 -130 90 -70 {lab=xxx}
N 60 -130 90 -130 {lab=xxx}
N 60 70 90 70 {lab=VSS}
N 90 70 90 130 {lab=VSS}
N 60 130 90 130 {lab=VSS}
N -30 0 20 0 {lab=A}
N 60 -0 130 0 {lab=Q}
C {TR-1umLIB/MP.sym} 20 -70 0 0 {name=M1
model=PMOS
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
C {TR-1umLIB/MN.sym} 20 70 0 0 {name=M2
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
C {devices/ipin.sym} -20 0 0 0 {name=p1 lab=A}
C {devices/opin.sym} 130 0 0 0 {name=p2 lab=Q}
C {devices/iopin.sym} 60 170 0 0 {name=p4 lab=VSS}
C {devices/iopin.sym} 60 -170 0 0 {name=p3 lab=VDD}
