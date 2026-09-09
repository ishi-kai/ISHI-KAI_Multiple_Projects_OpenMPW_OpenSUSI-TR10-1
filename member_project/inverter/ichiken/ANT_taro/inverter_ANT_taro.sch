v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 210 -270 210 -170 {lab=vout}
N 210 -200 330 -200 {lab=vout}
N 140 -140 170 -140 {lab=vin}
N 140 -300 140 -140 {lab=vin}
N 140 -300 170 -300 {lab=vin}
N 80 -200 140 -200 {lab=vin}
N 210 -110 210 -20 {lab=GND}
N 210 -380 210 -330 {lab=VDD}
N 210 -300 240 -300 {lab=VDD}
N 240 -350 240 -300 {lab=VDD}
N 210 -350 240 -350 {lab=VDD}
N 210 -140 240 -140 {lab=GND}
N 240 -140 240 -80 {lab=GND}
N 210 -80 240 -80 {lab=GND}
C {devices/iopin.sym} 210 -380 0 0 {name=p2 lab=VDD}
C {devices/ipin.sym} 80 -200 0 0 {name=p1 lab=vin
}
C {devices/iopin.sym} 210 -20 0 0 {name=p3 lab=GND
}
C {devices/opin.sym} 330 -200 0 0 {name=p4 lab=vout
}
C {TR-1umLIB/MP.sym} 170 -300 0 0 {name=XM1
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
C {TR-1umLIB/MN.sym} 170 -140 0 0 {name=XM2
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
