v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 80 -140 110 -140 {lab=X}
N 80 -260 80 -140 {lab=X}
N 80 -260 110 -260 {lab=X}
N 170 -260 200 -260 {lab=Y}
N 200 -260 200 -140 {lab=Y}
N 170 -140 200 -140 {lab=Y}
N 40 -200 80 -200 {lab=X}
N 200 -200 240 -200 {lab=Y}
N 140 -260 140 -240 {lab=VDD}
N 100 -240 140 -240 {lab=VDD}
N 100 -320 100 -240 {lab=VDD}
N 140 -320 140 -300 {lab=GP}
N 140 -160 140 -140 {lab=VDD}
N 100 -160 140 -160 {lab=VDD}
N 100 -160 100 -80 {lab=VDD}
N 140 -100 140 -80 {lab=GN}
C {TR-1umLIB/MN.sym} 140 -100 3 0 {name=XM1
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
C {TR-1umLIB/MP.sym} 140 -300 1 0 {name=XM2
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
C {devices/iopin.sym} 240 -200 0 0 {name=p1 lab=Y}
C {devices/ipin.sym} 140 -320 1 0 {name=p2 lab=GP}
C {devices/ipin.sym} 140 -80 3 0 {name=p3 lab=GN}
C {devices/iopin.sym} 40 -200 0 1 {name=p4 lab=X}
C {devices/iopin.sym} 100 -320 1 1 {name=p5 lab=VDD}
C {devices/iopin.sym} 100 -80 3 1 {name=p6 lab=VSS}
