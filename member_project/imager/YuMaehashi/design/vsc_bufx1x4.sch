v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 160 -170 160 -110 {lab=#net1}
N 240 -200 240 -80 {lab=#net1}
N 280 -170 280 -110 {lab=#net2}
N 120 -200 120 -80 {lab=IN}
N 160 -140 240 -140 {lab=#net1}
N 80 -20 300 -20 {lab=VSS}
N 300 -80 300 -20 {lab=VSS}
N 280 -80 300 -80 {lab=VSS}
N 280 -50 280 -20 {lab=VSS}
N 160 -80 180 -80 {lab=VSS}
N 180 -80 180 -20 {lab=VSS}
N 160 -50 160 -20 {lab=VSS}
N 80 -140 120 -140 {lab=IN}
N 80 -260 300 -260 {lab=VDD}
N 160 -200 180 -200 {lab=VDD}
N 180 -260 180 -200 {lab=VDD}
N 160 -260 160 -230 {lab=VDD}
N 280 -200 300 -200 {lab=VDD}
N 300 -260 300 -200 {lab=VDD}
N 280 -260 280 -230 {lab=VDD}
N 280 -140 340 -140 {lab=#net2}
C {TR-1umLIB/MN.sym} 120 -80 0 0 {name=XM1
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
C {TR-1umLIB/MN.sym} 240 -80 0 0 {name=XM2
model=NMOS
w=3.4u
l=1u
m=4
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MP.sym} 120 -200 0 0 {name=XM3
model=PMOS
w=10.2u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MP.sym} 240 -200 0 0 {name=XM4
model=PMOS
w=10.2u
l=1u
m=4
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {devices/ipin.sym} 80 -140 0 0 {name=p1 lab=IN}
C {devices/iopin.sym} 80 -260 0 1 {name=p2 lab=VDD}
C {devices/iopin.sym} 80 -20 0 1 {name=p3 lab=VSS}
C {devices/opin.sym} 340 -140 0 0 {name=p4 lab=OUT}
