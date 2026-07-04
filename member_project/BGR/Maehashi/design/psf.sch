v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
P 4 5 380 -150 380 -10 500 -10 500 -150 380 -150 {}
P 4 5 380 -390 380 -270 500 -270 500 -390 380 -390 {}
T {Dummy} 410 -170 0 0 0.3 0.3 {}
T {Dummy} 410 -410 0 0 0.3 0.3 {}
N 300 -50 300 -20 {lab=VSS}
N 60 -20 440 -20 {lab=VSS}
N 300 -290 300 -110 {lab=VO}
N 200 -320 220 -320 {lab=IIN}
N 220 -320 220 -260 {lab=IIN}
N 160 -260 220 -260 {lab=IIN}
N 160 -380 160 -350 {lab=VDD}
N 60 -380 460 -380 {lab=VDD}
N 140 -320 160 -320 {lab=VDD}
N 140 -380 140 -320 {lab=VDD}
N 300 -220 340 -220 {lab=VO}
N 220 -320 260 -320 {lab=IIN}
N 160 -290 160 -220 {lab=IIN}
N 300 -380 300 -350 {lab=VDD}
N 300 -320 320 -320 {lab=VDD}
N 320 -380 320 -320 {lab=VDD}
N 300 -80 320 -80 {lab=VO}
N 320 -140 320 -80 {lab=VO}
N 300 -140 460 -140 {lab=VO}
N 220 -80 260 -80 {lab=VI}
N 460 -140 460 -80 {lab=VO}
N 440 -80 460 -80 {lab=VO}
N 440 -50 440 -20 {lab=VSS}
N 400 -110 400 -20 {lab=VSS}
N 440 -380 440 -350 {lab=VDD}
N 440 -320 460 -320 {lab=VDD}
N 460 -380 460 -290 {lab=VDD}
N 400 -380 400 -320 {lab=VDD}
N 440 -290 460 -290 {lab=VDD}
N 400 -110 440 -110 {lab=VSS}
C {MP.sym} 200 -320 0 1 {name=XMPIB
model=PMOS
w=20u
l=4u
m=2
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {devices/ipin.sym} 160 -220 3 0 {name=p1 lab=IIN}
C {devices/iopin.sym} 60 -20 0 1 {name=p2 lab=VSS}
C {devices/iopin.sym} 60 -380 0 1 {name=p3 lab=VDD}
C {devices/opin.sym} 340 -220 0 0 {name=p6 lab=VO}
C {MP.sym} 260 -320 0 0 {name=XMP2
model=PMOS
w=20u
l=4u
m=8
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {MP.sym} 260 -80 0 0 {name=XMP1
model=PMOS
w=20u
l=1u
m=20
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {devices/ipin.sym} 220 -80 0 0 {name=p4 lab=VI}
C {MP.sym} 400 -80 0 0 {name=XMP3
model=PMOS
w=20u
l=1u
m=2
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {MP.sym} 400 -320 0 0 {name=XMPIB1
model=PMOS
w=20u
l=4u
m=2
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
