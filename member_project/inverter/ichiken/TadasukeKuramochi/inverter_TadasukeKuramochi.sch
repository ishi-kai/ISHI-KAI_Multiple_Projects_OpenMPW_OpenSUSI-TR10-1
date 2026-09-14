v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 60 -140 60 -60 {lab=VDD}
N 20 -30 20 110 {lab=A}
N 60 -0 60 80 {lab=Q}
N 60 140 60 220 {lab=VSS}
N 60 40 160 40 {lab=Q}
N -60 40 20 40 {lab=A}
N 60 110 70 110 {lab=VSS}
N 70 110 70 150 {lab=VSS}
N 60 150 70 150 {lab=VSS}
N 60 -30 70 -30 {lab=VDD}
N 70 -70 70 -30 {lab=VDD}
N 60 -70 70 -70 {lab=VDD}
C {IP62LIB/MP.sym} 20 -30 0 0 {name=XM1
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
C {IP62LIB/MN.sym} 20 110 0 0 {name=XM2
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
C {devices/ipin.sym} -60 40 0 0 {name=p1 lab=A}
C {devices/opin.sym} 160 40 0 0 {name=p2 lab=Q}
C {devices/iopin.sym} 60 -140 0 0 {name=p3 lab=VDD}
C {devices/iopin.sym} 60 220 0 0 {name=p4 lab=VSS}
