v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -80 -140 -80 -120 {lab=VDD}
N -80 -140 80 -140 {lab=VDD}
N 80 -140 80 -120 {lab=VDD}
N -140 -90 -120 -90 {lab=A}
N -140 -90 -140 -40 {lab=A}
N -140 -40 20 -40 {lab=A}
N 20 -90 20 -40 {lab=A}
N 20 -90 40 -90 {lab=A}
N -80 -90 -50 -90 {lab=VDD}
N -50 -140 -50 -90 {lab=VDD}
N 80 -90 110 -90 {lab=VDD}
N 110 -140 110 -90 {lab=VDD}
N 80 -140 110 -140 {lab=VDD}
N -80 -60 -80 -20 {lab=Q}
N -80 -20 80 -20 {lab=Q}
N 80 -60 80 -20 {lab=Q}
N -80 20 -80 60 {lab=Q}
N -80 20 80 20 {lab=Q}
N 80 20 80 60 {lab=Q}
N -140 90 -120 90 {lab=A}
N -140 40 -140 90 {lab=A}
N -140 40 20 40 {lab=A}
N 20 40 20 90 {lab=A}
N 20 90 40 90 {lab=A}
N -80 120 -80 140 {lab=VSS}
N -80 140 80 140 {lab=VSS}
N 80 120 80 140 {lab=VSS}
N -80 90 -50 90 {lab=VSS}
N -50 90 -50 140 {lab=VSS}
N 80 90 110 90 {lab=VSS}
N 110 90 110 140 {lab=VSS}
N 80 140 110 140 {lab=VSS}
N 0 140 0 180 {lab=VSS}
N 0 -180 -0 -140 {lab=VDD}
N -0 -20 0 20 {lab=Q}
N 0 -0 150 0 {lab=Q}
N -160 60 -140 60 {lab=A}
N -160 -60 -160 60 {lab=A}
N -160 -60 -140 -60 {lab=A}
N -200 -0 -160 0 {lab=A}
C {TR-1umLIB/MP.sym} 40 -90 0 0 {name=XM1
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
C {TR-1umLIB/MN.sym} 40 90 0 0 {name=XM2
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
C {devices/ipin.sym} -200 0 0 0 {name=p2 lab=A}
C {devices/opin.sym} 150 0 0 0 {name=p1 lab=Q}
C {devices/iopin.sym} 0 180 0 0 {name=p3 lab=VSS}
C {devices/iopin.sym} 0 -180 0 0 {name=p4 lab=VDD}
C {TR-1umLIB/MP.sym} -120 -90 0 0 {name=XM3
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
C {TR-1umLIB/MN.sym} -120 90 0 0 {name=XM4
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
