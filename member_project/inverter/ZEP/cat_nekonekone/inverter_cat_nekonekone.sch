v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 0 -100 0 -80 {lab=Vdd}
N 0 -20 0 20 {lab=vout}
N -40 -50 -40 50 {lab=vin}
N 0 0 60 0 {lab=vout}
N -90 0 -40 0 {lab=vin}
N 0 80 0 100 {lab=Vss}
N 0 50 20 50 {lab=Vss}
N 20 50 20 90 {lab=Vss}
N 0 90 20 90 {lab=Vss}
N 0 -50 20 -50 {lab=Vdd}
N 20 -90 20 -50 {lab=Vdd}
N 0 -90 20 -90 {lab=Vdd}
N 0 -110 0 -100 {lab=Vdd}
N 0 100 0 130 {lab=Vss}
N 80 0 100 0 {lab=vout}
N 60 0 80 0 {lab=vout}
C {TR-1umLIB/MP.sym} -40 -50 0 0 {name=XM1
model=PMOS
w=10u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MN.sym} -40 50 0 0 {name=XM2
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
C {devices/ipin.sym} -90 0 0 0 {name=p1 lab=vin}
C {devices/opin.sym} 100 0 0 0 {name=p2 lab=vout}
C {devices/iopin.sym} 0 -110 0 0 {name=p3 lab=Vdd}
C {devices/iopin.sym} 0 130 0 0 {name=p4 lab=Vss}
