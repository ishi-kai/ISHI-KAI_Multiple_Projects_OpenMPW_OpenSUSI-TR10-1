v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 140 -260 140 -230 {lab=VDD}
N 100 -200 100 -80 {lab=IN}
N 140 -170 140 -110 {lab=#net1}
N 140 -50 140 -20 {lab=VSS}
N 140 -80 160 -80 {lab=VSS}
N 160 -80 160 -20 {lab=VSS}
N 140 -200 160 -200 {lab=VDD}
N 160 -260 160 -200 {lab=VDD}
N 60 -140 100 -140 {lab=IN}
N 240 -260 240 -230 {lab=VDD}
N 200 -200 200 -80 {lab=#net1}
N 240 -170 240 -110 {lab=OUT}
N 240 -50 240 -20 {lab=VSS}
N 240 -80 260 -80 {lab=VSS}
N 260 -80 260 -20 {lab=VSS}
N 240 -200 260 -200 {lab=VDD}
N 260 -260 260 -200 {lab=VDD}
N 140 -140 200 -140 {lab=#net1}
N 340 -260 340 -230 {lab=VDD}
N 300 -200 300 -80 {lab=OUT}
N 340 -170 340 -110 {lab=OUTB}
N 340 -50 340 -20 {lab=VSS}
N 340 -80 360 -80 {lab=VSS}
N 360 -80 360 -20 {lab=VSS}
N 340 -200 360 -200 {lab=VDD}
N 360 -260 360 -200 {lab=VDD}
N 240 -140 300 -140 {lab=OUT}
N 60 -20 360 -20 {lab=VSS}
N 60 -260 360 -260 {lab=VDD}
N 300 -160 420 -160 {lab=OUT}
N 340 -120 420 -120 {lab=OUTB}
C {TR-1umLIB/MN.sym} 100 -80 0 0 {name=XM1
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
C {TR-1umLIB/MP.sym} 100 -200 0 0 {name=XM2
model=PMOS
w=10.2u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {devices/iopin.sym} 60 -20 0 1 {name=p1 lab=VSS}
C {devices/ipin.sym} 60 -140 0 0 {name=p2 lab=IN}
C {devices/opin.sym} 420 -160 0 0 {name=p3 lab=OUT}
C {devices/iopin.sym} 60 -260 0 1 {name=p4 lab=VDD}
C {devices/opin.sym} 420 -120 0 0 {name=p5 lab=OUTB}
C {TR-1umLIB/MN.sym} 200 -80 0 0 {name=XM3
model=NMOS
w=3.4u
l=1u
m=4
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MP.sym} 200 -200 0 0 {name=XM4
model=PMOS
w=10.2u
l=1u
m=4
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MN.sym} 300 -80 0 0 {name=XM5
model=NMOS
w=3.4u
l=1u
m=4
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MP.sym} 300 -200 0 0 {name=XM6
model=PMOS
w=10.2u
l=1u
m=4
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
