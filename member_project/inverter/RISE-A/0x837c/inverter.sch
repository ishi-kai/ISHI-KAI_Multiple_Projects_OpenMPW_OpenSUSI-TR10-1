v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 200 -30 200 30 {lab=Q}
N 100 -60 160 -60 {lab=A}
N 100 -60 100 60 {lab=A}
N 100 60 160 60 {lab=A}
N 40 -0 100 -0 {lab=A}
N 200 -0 300 0 {lab=Q}
N 200 -140 200 -90 {lab=VDD}
N 200 90 200 140 {lab=VSS}
N 200 -100 220 -100 {lab=VDD}
N 220 -100 220 -60 {lab=VDD}
N 200 -60 220 -60 {lab=VDD}
N 200 100 220 100 {lab=VSS}
N 220 60 220 100 {lab=VSS}
N 200 60 220 60 {lab=VSS}
C {TR-1umLIB/MP.sym} 160 -60 0 0 {name=XM1
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
C {TR-1umLIB/MN.sym} 160 60 0 0 {name=XM2
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
C {devices/ipin.sym} 40 0 0 0 {name=p1 lab=A}
C {devices/opin.sym} 300 0 0 0 {name=p2 lab=Q}
C {devices/iopin.sym} 200 -140 0 0 {name=p3 lab=VDD}
C {devices/iopin.sym} 200 140 0 0 {name=p4 lab=VSS}
