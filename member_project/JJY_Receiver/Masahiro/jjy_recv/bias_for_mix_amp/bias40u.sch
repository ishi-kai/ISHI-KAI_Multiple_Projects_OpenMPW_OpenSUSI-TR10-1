v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 80 100 80 140 {lab=ib40u}
N 80 120 130 120 {lab=ib40u}
N 130 120 130 160 {lab=ib40u}
N 130 160 130 170 {lab=ib40u}
N 120 170 130 170 {lab=ib40u}
N 80 200 80 220 {lab=vss}
N 60 210 80 210 {lab=vss}
N 60 170 60 210 {lab=vss}
N 60 170 80 170 {lab=vss}
N 130 170 140 170 {lab=ib40u}
N 140 170 180 170 {lab=ib40u}
N 80 220 80 250 {lab=vss}
N 80 230 220 230 {lab=vss}
N 220 200 220 230 {lab=vss}
N 220 90 220 140 {lab=#net1}
N 260 60 290 60 {lab=#net1}
N 220 10 220 30 {lab=vdd}
N 220 10 330 10 {lab=vdd}
N 330 10 330 30 {lab=vdd}
N 270 -10 270 10 {lab=vdd}
N 190 60 220 60 {lab=vdd}
N 190 10 190 60 {lab=vdd}
N 190 10 220 10 {lab=vdd}
N 330 10 370 10 {lab=vdd}
N 370 10 370 60 {lab=vdd}
N 330 60 370 60 {lab=vdd}
N 220 170 250 170 {lab=vss}
N 250 170 250 210 {lab=vss}
N 220 210 250 210 {lab=vss}
N 330 140 340 140 {lab=is40u}
N 330 90 330 140 {lab=is40u}
N 270 60 270 110 {lab=#net1}
N 220 110 270 110 {lab=#net1}
C {TR-1umLIB/MN.sym} 120 170 0 1 {name=XM1
model=NMOS
w=10u
l=2u
m=2
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {devices/iopin.sym} 80 250 0 0 {name=p2 lab=vss}
C {devices/iopin.sym} 80 100 0 0 {name=p1 lab=ib40u}
C {TR-1umLIB/MN.sym} 180 170 0 0 {name=XM2
model=NMOS
w=10u
l=2u
m=2
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MP.sym} 260 60 0 1 {name=XM3
model=PMOS
w=45u
l=2u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MP.sym} 290 60 0 0 {name=XM4
model=PMOS
w=45u
l=2u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {devices/iopin.sym} 270 -10 0 0 {name=p3 lab=vdd}
C {devices/opin.sym} 340 140 0 0 {name=p4 lab=is40u}
