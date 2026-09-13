v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 0 -150 0 -100 {lab=VDD}
N 0 -40 0 30 {lab=Q}
N 0 90 0 140 {lab=VSS}
N 0 -110 0 -100 {lab=VDD}
N -20 -110 0 -110 {lab=VDD}
N -20 -70 0 -70 {lab=VDD}
N -20 -110 -20 -70 {lab=VDD}
N 0 -170 0 -150 {lab=VDD}
N 40 -70 50 -70 {lab=QB}
N 50 -70 50 60 {lab=QB}
N 40 60 50 60 {lab=QB}
N 150 -150 150 -100 {lab=VDD}
N 150 -40 150 30 {lab=QB}
N 150 90 150 140 {lab=VSS}
N 150 -110 150 -100 {lab=VDD}
N 150 -110 170 -110 {lab=VDD}
N 150 -70 170 -70 {lab=VDD}
N 170 -110 170 -70 {lab=VDD}
N 150 140 150 170 {lab=VSS}
N 150 -170 150 -150 {lab=VDD}
N 100 60 110 60 {lab=Q}
N 100 -70 110 -70 {lab=Q}
N 100 -70 100 60 {lab=Q}
N 50 -20 150 -20 {lab=QB}
N -0 0 100 0 {lab=Q}
N 0 -170 150 -170 {lab=VDD}
N 70 -190 70 -170 {lab=VDD}
N -80 -0 -10 -0 {lab=Q}
N -10 0 -0 0 {lab=Q}
N 150 -0 240 -0 {lab=QB}
N -110 -220 -110 -40 {lab=WL}
N 270 -220 270 -40 {lab=WL}
N -110 -220 270 -220 {lab=WL}
N 70 -240 70 -220 {lab=WL}
N 300 -0 330 0 {lab=BLB}
N -170 0 -140 0 {lab=BL}
N -110 0 -110 160 {lab=VSS}
N -110 160 -0 160 {lab=VSS}
N 150 160 270 160 {lab=VSS}
N 270 0 270 160 {lab=VSS}
N -110 60 -0 60 {lab=VSS}
N 150 60 270 60 {lab=VSS}
N 0 160 150 160 {lab=VSS}
N -0 140 -0 160 {lab=VSS}
C {TR-1umLIB/MN.sym} 40 60 0 1 {name=XM1
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
C {TR-1umLIB/MP.sym} 40 -70 0 1 {name=XM2
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
C {TR-1umLIB/MN.sym} 110 60 0 0 {name=XM3
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
C {TR-1umLIB/MP.sym} 110 -70 0 0 {name=XM4
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
C {devices/iopin.sym} 70 -190 0 0 {name=p6 lab=VDD}
C {TR-1umLIB/MN.sym} -110 -40 1 0 {name=XM7
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
C {devices/iopin.sym} 330 0 0 0 {name=p2 lab=BLB}
C {devices/iopin.sym} -170 0 2 0 {name=p3 lab=BL}
C {TR-1umLIB/MN.sym} 270 -40 3 1 {name=XM6
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
C {devices/ipin.sym} 70 -240 2 0 {name=p8 lab=WL}
C {devices/lab_pin.sym} -40 0 1 0 {name=p1 lab=Q}
C {devices/lab_pin.sym} 200 0 1 0 {name=p4 lab=QB}
C {devices/iopin.sym} 150 170 1 0 {name=p5 lab=VSS}
