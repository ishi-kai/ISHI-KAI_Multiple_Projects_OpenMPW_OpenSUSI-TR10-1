v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 70 -60 70 90 {lab=vin}
N -10 20 70 20 {lab=vin}
N 110 -130 110 -90 {lab=Vdd}
N 110 20 110 60 {lab=vout}
N 110 20 160 20 {lab=vout}
N 110 120 110 170 {lab=Vss}
N 110 90 120 90 {lab=Vss}
N 120 90 120 130 {lab=Vss}
N 110 130 120 130 {lab=Vss}
N 110 -30 110 20 {lab=vout}
N 110 -60 120 -60 {lab=Vdd}
N 120 -100 120 -60 {lab=Vdd}
N 110 -100 120 -100 {lab=Vdd}
C {devices/ipin.sym} -10 20 0 0 {name=p1 lab=vin}
C {devices/iopin.sym} 110 -130 0 0 {name=p2 lab=Vdd}
C {TR-1umLIB/MP.sym} 70 -60 0 0 {name=XM1
model=PMOS
w=8.2u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MN.sym} 70 90 0 0 {name=XM2
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
C {devices/opin.sym} 160 20 0 0 {name=p3 lab=vout}
C {devices/iopin.sym} 110 170 0 0 {name=p4 lab=Vss}
