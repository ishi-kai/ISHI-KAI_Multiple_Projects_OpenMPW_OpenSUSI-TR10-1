v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 400 -280 420 -280 {lab=VSS}
N 420 -280 420 -80 {lab=VSS}
N 100 -80 500 -80 {lab=VSS}
N 180 -280 180 -80 {lab=VSS}
N 280 -420 300 -420 {lab=VSS}
N 300 -420 300 -80 {lab=VSS}
N 400 -160 420 -160 {lab=VSS}
N 400 -130 400 -100 {lab=VL}
N 400 -100 480 -100 {lab=VL}
N 480 -500 480 -60 {lab=VL}
N 210 -280 360 -280 {lab=FD}
N 140 -280 150 -280 {lab=PD}
N 400 -250 400 -190 {lab=#net1}
N 100 -480 500 -480 {lab=VDD}
N 400 -480 400 -310 {lab=VDD}
N 280 -390 280 -280 {lab=FD}
N 280 -480 280 -450 {lab=VDD}
N 360 -160 360 -80 {lab=VSS}
N 240 -480 240 -420 {lab=VDD}
N 180 -480 180 -320 {lab=VDD}
C {TR-1umLIB/MN.sym} 180 -320 1 0 {name=XM1
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
C {TR-1umLIB/MN.sym} 240 -420 0 0 {name=XM2
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
C {TR-1umLIB/MN.sym} 360 -280 0 0 {name=XM3
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
C {TR-1umLIB/MN.sym} 360 -160 0 0 {name=XM4
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
C {devices/iopin.sym} 100 -480 0 1 {name=p2 lab=VDD}
C {devices/opin.sym} 480 -60 1 0 {name=p3 lab=VL}
C {devices/iopin.sym} 100 -80 0 1 {name=p4 lab=VSS}
C {devices/lab_wire.sym} 280 -280 0 0 {name=p8 sig_type=std_logic lab=FD}
C {devices/lab_wire.sym} 140 -280 0 0 {name=p6 sig_type=std_logic lab=PD}
