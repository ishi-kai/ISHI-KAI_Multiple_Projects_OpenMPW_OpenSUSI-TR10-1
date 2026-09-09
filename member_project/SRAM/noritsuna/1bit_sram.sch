v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -10 -100 30 -100 {lab=#net1}
N 30 -100 30 20 {lab=#net1}
N -10 20 30 20 {lab=#net1}
N 100 -100 140 -100 {lab=#net2}
N 100 -100 100 20 {lab=#net2}
N 100 20 140 20 {lab=#net2}
N -50 -190 -50 -130 {lab=VDD}
N -50 -190 180 -190 {lab=VDD}
N 180 -190 180 -130 {lab=VDD}
N -80 -100 -50 -100 {lab=VDD}
N -80 -150 -80 -100 {lab=VDD}
N -80 -150 -50 -150 {lab=VDD}
N 180 -100 210 -100 {lab=VDD}
N 210 -150 210 -100 {lab=VDD}
N 180 -150 210 -150 {lab=VDD}
N -50 -70 -50 -10 {lab=#net2}
N 180 -70 180 -10 {lab=#net1}
N 180 50 180 110 {lab=VSS}
N -50 110 180 110 {lab=VSS}
N -50 50 -50 110 {lab=VSS}
N -80 20 -50 20 {lab=VSS}
N -80 20 -80 70 {lab=VSS}
N -80 70 -50 70 {lab=VSS}
N 180 20 220 20 {lab=VSS}
N 220 20 220 70 {lab=VSS}
N 180 70 220 70 {lab=VSS}
N 30 -60 180 -60 {lab=#net1}
N 180 -60 330 -60 {lab=#net1}
N -50 -20 100 -20 {lab=#net2}
N -190 -20 -50 -20 {lab=#net2}
N 60 -240 60 -190 {lab=VDD}
N 60 110 60 160 {lab=VSS}
N -220 -20 -220 110 {lab=VSS}
N -220 110 -50 110 {lab=VSS}
N 360 -60 360 110 {lab=VSS}
N 180 110 360 110 {lab=VSS}
N 360 -330 360 -100 {lab=WORD_L}
N -220 -330 360 -330 {lab=WORD_L}
N -220 -330 -220 -50 {lab=WORD_L}
N 390 -60 520 -60 {lab=BIT_L_BAR}
N -380 -20 -250 -20 {lab=BIT_L}
N 60 -380 60 -330 {lab=WORD_L}
C {TR-1umLIB/MP.sym} -10 -100 0 1 {name=XM1
model=PMOS
w=24u
l=4.2u
m=12
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MN.sym} -10 20 0 1 {name=XM2
model=NMOS
w=24u
l=4.2u
m=40
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MP.sym} 140 -100 0 0 {name=XM3
model=PMOS
w=24u
l=4.2u
m=12
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MN.sym} 140 20 0 0 {name=XM4
model=NMOS
w=24u
l=4.2u
m=40
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MN.sym} 360 -100 1 0 {name=XM5
model=NMOS
w=24u
l=4.2u
m=20
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MN.sym} -220 -60 3 1 {name=XM6
model=NMOS
w=24u
l=4.2u
m=20
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {devices/iopin.sym} 60 -240 0 1 {name=p1 lab=VDD}
C {devices/iopin.sym} 60 160 0 0 {name=p2 lab=VSS}
C {devices/iopin.sym} 520 -60 0 0 {name=p3 lab=BIT_L_BAR}
C {devices/iopin.sym} -380 -20 0 1 {name=p4 lab=BIT_L}
C {devices/ipin.sym} 60 -380 0 0 {name=p5 lab=WORD_L}
