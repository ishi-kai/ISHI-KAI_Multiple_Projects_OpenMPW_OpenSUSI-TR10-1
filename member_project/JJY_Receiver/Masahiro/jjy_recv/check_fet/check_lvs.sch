v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 20 -20 80 -20 {lab=t1}
N -20 10 -20 30 {lab=vss}
N -20 30 120 30 {lab=vss}
N 120 10 120 30 {lab=vss}
N -20 -80 -20 -50 {lab=t1}
N -20 -60 40 -60 {lab=t1}
N 40 -60 40 -20 {lab=t1}
N 120 -80 120 -50 {lab=t2}
N 40 30 40 50 {lab=vss}
N -40 -20 -20 -20 {lab=vss}
N -40 -20 -40 20 {lab=vss}
N -40 20 -20 20 {lab=vss}
N 120 -20 140 -20 {lab=vss}
N 140 -20 140 20 {lab=vss}
N 120 20 140 20 {lab=vss}
C {devices/iopin.sym} -20 -80 0 0 {name=p1 lab=t1}
C {devices/iopin.sym} 120 -80 0 0 {name=p2 lab=t2}
C {devices/iopin.sym} 40 50 0 0 {name=p3 lab=vss}
C {TR-1umLIB/MN.sym} 80 -20 0 0 {name=XM1
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
C {TR-1umLIB/MN.sym} 20 -20 0 1 {name=XM2
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
