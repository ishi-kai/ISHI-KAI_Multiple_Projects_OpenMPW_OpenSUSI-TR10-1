v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 80 -160 80 -120 {lab=VDD}
N 20 -90 40 -90 {lab=A}
N 20 -90 20 20 {lab=A}
N 20 20 40 20 {lab=A}
N -10 -30 20 -30 {lab=A}
N 80 -60 80 -10 {lab=Q}
N 80 -30 150 -30 {lab=Q}
N 80 50 80 110 {lab=VSS}
N 80 20 100 20 {lab=VSS}
N 100 20 100 50 {lab=VSS}
N 80 50 100 50 {lab=VSS}
N 80 -180 80 -160 {lab=VDD}
N 80 -90 100 -90 {lab=VDD}
N 100 -120 100 -90 {lab=VDD}
N 80 -120 100 -120 {lab=VDD}
C {TR-1umLIB/MP.sym} 40 -90 0 0 {name=M1
model=PMOS
w=8u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {devices/opin.sym} 150 -30 0 0 {name=p1 lab=Q}
C {devices/ipin.sym} -10 -30 0 0 {name=p2 lab=A}
C {TR-1umLIB/MN.sym} 40 20 0 0 {name=M2
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
C {devices/iopin.sym} 80 -180 0 0 {name=p3 lab=VDD}
C {devices/iopin.sym} 80 110 0 0 {name=p4 lab=VSS}
