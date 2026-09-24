v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 80 -160 80 -120 {lab=VDD}
N 20 -90 40 -90 {lab=A}
N 20 -90 20 20 {lab=A}
N 20 20 40 20 {lab=A}
N -10 -30 20 -30 {lab=A}
N 80 -60 80 -10 {lab=#net1}
N 80 50 80 110 {lab=VSS}
N 80 20 100 20 {lab=VSS}
N 100 20 100 50 {lab=VSS}
N 80 50 100 50 {lab=VSS}
N 80 -180 80 -160 {lab=VDD}
N 80 -90 100 -90 {lab=VDD}
N 100 -120 100 -90 {lab=VDD}
N 80 -120 100 -120 {lab=VDD}
N 160 -90 180 -90 {lab=#net1}
N 160 -90 160 20 {lab=#net1}
N 160 20 180 20 {lab=#net1}
N 80 -30 160 -30 {lab=#net1}
N 220 -60 220 -10 {lab=Q}
N 220 20 240 20 {lab=VSS}
N 240 20 240 50 {lab=VSS}
N 220 50 240 50 {lab=VSS}
N 80 90 220 90 {lab=VSS}
N 220 50 220 90 {lab=VSS}
N 220 -150 220 -120 {lab=VDD}
N 80 -150 220 -150 {lab=VDD}
N 220 -90 240 -90 {lab=VDD}
N 240 -120 240 -90 {lab=VDD}
N 220 -120 240 -120 {lab=VDD}
N 220 -30 290 -30 {lab=Q}
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
C {devices/opin.sym} 290 -30 0 0 {name=p1 lab=Q}
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
C {TR-1umLIB/MP.sym} 180 -90 0 0 {name=M3
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
C {TR-1umLIB/MN.sym} 180 20 0 0 {name=M4
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
