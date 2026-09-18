v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 60 -180 220 -180 {lab=A}
N 60 -80 220 -80 {lab=B}
N 260 -270 260 -210 {lab=#net1}
N 140 -270 140 -240 {lab=#net1}
N 140 -240 260 -240 {lab=#net1}
N 260 -150 260 -110 {lab=#net2}
N 260 -180 280 -180 {lab=GND}
N 280 -180 280 -20 {lab=GND}
N 260 -80 280 -80 {lab=GND}
N 260 -50 260 -20 {lab=GND}
N 260 -300 280 -300 {lab=VDD}
N 280 -360 280 -300 {lab=VDD}
N 260 -360 260 -330 {lab=VDD}
N 140 -300 160 -300 {lab=VDD}
N 160 -360 160 -300 {lab=VDD}
N 140 -360 140 -330 {lab=VDD}
N 80 -300 100 -300 {lab=A}
N 80 -300 80 -180 {lab=A}
N 200 -300 220 -300 {lab=B}
N 200 -300 200 -80 {lab=B}
N 380 -80 400 -80 {lab=GND}
N 380 -50 380 -20 {lab=GND}
N 380 -300 400 -300 {lab=VDD}
N 400 -360 400 -300 {lab=VDD}
N 380 -360 380 -330 {lab=VDD}
N 400 -80 400 -20 {lab=GND}
N 60 -20 400 -20 {lab=GND}
N 60 -360 400 -360 {lab=VDD}
N 340 -300 340 -80 {lab=#net1}
N 260 -240 340 -240 {lab=#net1}
N 380 -270 380 -110 {lab=#net3}
N 380 -180 440 -180 {lab=#net3}
C {MP.sym} 100 -300 0 0 {name=M7 model=PMOS w=10.2u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0 spiceprefix=X}
C {MP.sym} 220 -300 0 0 {name=M2 model=PMOS w=10.2u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0 spiceprefix=X}
C {MN.sym} 220 -80 0 0 {name=M3 model=NMOS w=3.4u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0 spiceprefix=X}
C {MN.sym} 220 -180 0 0 {name=M5 model=NMOS w=3.4u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0 spiceprefix=X}
C {MP.sym} 340 -300 0 0 {name=M1 model=PMOS w=10.2u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0 spiceprefix=X}
C {MN.sym} 340 -80 0 0 {name=M4 model=NMOS w=3.4u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0 spiceprefix=X}
C {devices/ipin.sym} 60 -180 0 0 {name=p2 lab=A}
C {devices/ipin.sym} 60 -80 0 0 {name=p3 lab=B}
C {devices/iopin.sym} 60 -360 0 1 {name=p4 lab=VDD}
C {devices/iopin.sym} 60 -20 0 1 {name=p5 lab=VSS}
C {devices/opin.sym} 440 -180 0 0 {name=p1 lab=Y}
