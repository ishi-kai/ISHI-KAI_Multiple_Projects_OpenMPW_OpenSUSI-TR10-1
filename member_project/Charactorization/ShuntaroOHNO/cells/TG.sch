v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 40 80 160 20 {lab=A}
N 40 20 160 80 {lab=B}
N 0 20 40 20 {lab=B}
N 160 20 200 20 {lab=A}
N 40 50 50 50 {lab=VDD}
N 0 0 50 0 {lab=VDD}
N 50 0 50 50 {lab=VDD}
N 150 50 160 50 {lab=VSS}
N 150 50 150 100 {lab=VSS}
N 150 100 200 100 {lab=VSS}
C {TR-1umLIB/MP.sym} 0 50 0 0 {name=XM1
model=PMOS
w=13.6u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MN.sym} 200 50 0 1 {name=XM2
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
C {devices/iopin.sym} 200 20 0 0 {name=p1 lab=A}
C {devices/iopin.sym} 0 20 0 1 {name=p2 lab=B}
C {devices/iopin.sym} 0 0 0 1 {name=p5 lab=VDD}
C {devices/iopin.sym} 200 100 0 0 {name=p6 lab=VSS}
C {devices/ipin.sym} 0 50 0 0 {name=p4 lab=SP}
C {devices/ipin.sym} 200 50 0 1 {name=p3 lab=SN}
