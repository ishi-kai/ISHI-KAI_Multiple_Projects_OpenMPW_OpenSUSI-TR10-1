v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 70 -10 70 -0 {lab=Q}
N 70 0 70 10 {lab=Q}
N 70 10 70 20 {lab=Q}
N 70 20 70 40 {lab=Q}
N 70 40 70 50 {lab=Q}
N 70 50 70 60 {lab=Q}
N 20 -40 30 -40 {lab=A}
N 10 -40 20 -40 {lab=A}
N 0 -40 10 -40 {lab=A}
N -10 -40 -0 -40 {lab=A}
N -10 -40 -10 90 {lab=A}
N -10 90 30 90 {lab=A}
N -20 20 -10 20 {lab=A}
N -30 20 -20 20 {lab=A}
N -100 20 -30 20 {lab=A}
N 70 20 80 20 {lab=Q}
N 80 20 90 20 {lab=Q}
N 90 20 100 20 {lab=Q}
N 100 20 110 20 {lab=Q}
N 110 20 120 20 {lab=Q}
N 120 20 130 20 {lab=Q}
N 130 20 140 20 {lab=Q}
N 140 20 150 20 {lab=Q}
N 150 20 160 20 {lab=Q}
N 70 -80 70 -70 {lab=VDD}
N 70 -90 70 -80 {lab=VDD}
N 70 -100 70 -90 {lab=VDD}
N 70 -110 70 -100 {lab=VDD}
N 70 -120 70 -110 {lab=VDD}
N 70 120 70 130 {lab=VSS}
N 70 130 70 140 {lab=VSS}
N 70 140 70 150 {lab=VSS}
N 70 150 70 160 {lab=VSS}
N 70 160 70 190 {lab=VSS}
N 70 -140 70 -120 {lab=VDD}
N 70 -40 90 -40 {lab=VDD}
N 90 -90 90 -40 {lab=VDD}
N 70 -90 90 -90 {lab=VDD}
N 70 90 90 90 {lab=VSS}
N 90 90 90 140 {lab=VSS}
N 70 140 90 140 {lab=VSS}
C {TR-1umLIB/MP.sym} 30 -40 0 0 {name=XM1
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
C {TR-1umLIB/MN.sym} 30 90 0 0 {name=XM2
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
C {devices/ipin.sym} -100 20 0 0 {name=p1 lab=A}
C {devices/opin.sym} 160 20 0 0 {name=p2 lab=Q}
C {devices/iopin.sym} 70 -140 0 0 {name=p3 lab=VDD}
C {devices/iopin.sym} 70 190 0 0 {name=p4 lab=VSS}
