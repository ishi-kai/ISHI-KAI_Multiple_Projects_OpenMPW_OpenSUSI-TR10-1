v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 120 -340 120 -290 {lab=VDD}
N 120 -230 120 -150 {lab=Q}
N 60 -260 80 -260 {lab=A}
N 60 -260 60 -120 {lab=A}
N 60 -120 80 -120 {lab=A}
N 120 -260 140 -260 {lab=VDD}
N 140 -300 140 -260 {lab=VDD}
N 120 -310 140 -310 {lab=VDD}
N 140 -310 140 -300 {lab=VDD}
N 120 -120 140 -120 {lab=VSS}
N 140 -120 140 -70 {lab=VSS}
N 120 -70 140 -70 {lab=VSS}
N 30 -180 60 -180 {lab=A}
N 230 -180 240 -180 {lab=Q}
N 120 -180 230 -180 {lab=Q}
N 120 -340 140 -340 {lab=VDD}
N 120 -40 140 -40 {lab=VSS}
N 120 -90 120 -40 {lab=VSS}
C {IP62LIB/MP.sym} 80 -260 0 0 {name=M1
model=PMOS
w=11.8u
l=1u
m=17
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {IP62LIB/MN.sym} 80 -120 0 0 {name=M2
model=NMOS
w=4.7u
l=1u
m=17
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {devices/ipin.sym} 30 -180 0 0 {name=p1 lab=A}
C {devices/iopin.sym} 140 -340 0 0 {name=p2 lab=VDD}
C {devices/opin.sym} 240 -180 0 0 {name=p3 lab=Q}
C {devices/iopin.sym} 140 -40 0 0 {name=p4 lab=VSS}
