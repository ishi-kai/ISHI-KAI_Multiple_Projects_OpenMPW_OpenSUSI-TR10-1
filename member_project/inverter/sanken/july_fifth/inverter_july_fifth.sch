v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 70 100 90 100 {lab=vin}
N 70 100 70 230 {lab=vin}
N 70 230 90 230 {lab=vin}
N 130 280 140 280 {lab=VSS}
N 140 230 140 280 {lab=VSS}
N 130 230 140 230 {lab=VSS}
N 130 100 140 100 {lab=VDD}
N 140 60 140 100 {lab=VDD}
N 130 60 140 60 {lab=VDD}
N 130 130 180 130 {lab=vout}
N 180 130 180 200 {lab=vout}
N 130 200 180 200 {lab=vout}
N 10 160 70 160 {lab=vin}
N 180 160 240 160 {lab=vout}
N 130 260 130 320 {lab=VSS}
N 130 30 130 70 {lab=VDD}
C {TR-1umLIB/MP.sym} 90 100 0 0 {name=XM1
model=PMOS
w=9u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MN.sym} 90 230 0 0 {name=XM2
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
C {devices/opin.sym} 240 160 0 0 {name=p1 lab=vout}
C {devices/ipin.sym} 10 160 0 0 {name=p2 lab=vin}
C {devices/iopin.sym} 130 320 0 0 {name=p5 lab=VSS}
C {devices/iopin.sym} 130 30 0 0 {name=p3 lab=VDD}
