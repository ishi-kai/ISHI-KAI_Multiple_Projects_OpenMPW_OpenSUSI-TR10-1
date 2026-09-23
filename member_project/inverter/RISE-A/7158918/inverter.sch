v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 90 -100 90 -70 {lab=VDD}
N 90 -10 90 40 {lab=OUT}
N 20 -40 50 -40 {lab=IN}
N 20 -40 20 70 {lab=IN}
N 20 70 50 70 {lab=IN}
N 90 100 90 130 {lab=VSS}
N 90 -40 130 -40 {lab=VDD}
N 130 -80 130 -40 {lab=VDD}
N 90 -80 130 -80 {lab=VDD}
N 90 70 140 70 {lab=VSS}
N 140 70 140 120 {lab=VSS}
N 90 120 140 120 {lab=VSS}
N -80 20 20 20 {lab=IN}
N 90 20 170 20 {lab=OUT}
N 90 -130 90 -100 {lab=VDD}
N 90 130 90 190 {lab=VSS}
C {devices/ipin.sym} 170 20 0 1 {name=p1 lab=OUT}
C {devices/ipin.sym} -80 20 0 0 {name=p7 lab=IN}
C {TR-1umLIB/MP.sym} 50 -40 0 0 {name=XM1
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
C {TR-1umLIB/MN.sym} 50 70 0 0 {name=XM2
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
C {devices/iopin.sym} 90 -130 0 0 {name=p2 lab=VDD}
C {devices/iopin.sym} 90 190 0 0 {name=p3 lab=VSS}
