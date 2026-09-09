v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 20 90 20 140 {lab=GND}
N 20 -40 20 30 {lab=vout}
N 20 -130 20 -90 {lab=vout}
N -100 0 -60 0 {lab=vin}
N -60 -60 -60 0 {lab=vin}
N -60 -60 -20 -60 {lab=vin}
N -60 60 -20 60 {lab=vin}
N -60 0 -60 60 {lab=vin}
N 20 0 60 0 {lab=vout}
C {TR-1umLIB/MP.sym} -20 -60 0 0 {name=XM1
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
C {TR-1umLIB/MN.sym} -20 60 0 0 {name=XM2
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
C {devices/iopin.sym} 60 0 0 0 {name=p4 lab=vout}
C {devices/iopin.sym} -100 0 2 0 {name=p2 lab=vin}
C {devices/iopin.sym} 20 140 1 0 {name=p1 lab=GND}
C {devices/iopin.sym} 20 -130 3 0 {name=p3 lab=VDD}
