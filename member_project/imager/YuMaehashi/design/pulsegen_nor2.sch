v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 220 -300 240 -300 {lab=A}
N 100 -200 240 -200 {lab=#net1}
N 280 -270 280 -230 {lab=#net2}
N 160 -140 160 -110 {lab=Y}
N 160 -140 280 -140 {lab=Y}
N 280 -170 280 -110 {lab=Y}
N 220 -80 240 -80 {lab=A}
N 220 -300 220 -80 {lab=A}
N 100 -80 120 -80 {lab=#net1}
N 100 -200 100 -80 {lab=#net1}
N 280 -360 280 -330 {lab=VDD}
N 280 -200 300 -200 {lab=VDD}
N 300 -300 300 -200 {lab=VDD}
N 280 -300 300 -300 {lab=VDD}
N 160 -50 160 -20 {lab=VSS}
N 280 -50 280 -20 {lab=VSS}
N 280 -80 300 -80 {lab=VSS}
N 300 -80 300 -20 {lab=VSS}
N 160 -80 180 -80 {lab=VSS}
N 180 -80 180 -20 {lab=VSS}
N 60 -300 220 -300 {lab=A}
N 60 -200 100 -200 {lab=#net1}
N 60 -360 280 -360 {lab=VDD}
N 280 -360 300 -360 {lab=VDD}
N 300 -360 300 -300 {lab=VDD}
N 60 -20 160 -20 {lab=VSS}
N 180 -20 280 -20 {lab=VSS}
N 280 -20 300 -20 {lab=VSS}
N 160 -20 180 -20 {lab=VSS}
N 280 -140 360 -140 {lab=Y}
C {devices/ipin.sym} 60 -300 0 0 {name=p1 lab=A}
C {devices/ipin.sym} 60 -200 0 0 {name=p2 lab=B
}
C {devices/opin.sym} 360 -140 0 0 {name=p3 lab=Y}
C {devices/iopin.sym} 60 -360 0 1 {name=p4 lab=VDD}
C {devices/iopin.sym} 60 -20 0 1 {name=p5 lab=VSS}
C {MP.sym} 240 -200 0 0 {name=M7 model=PMOS w=10.2u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0 spiceprefix=X}
C {MN.sym} 120 -80 0 0 {name=M1 model=NMOS w=3.4u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0 spiceprefix=X}
C {MN.sym} 240 -80 0 0 {name=M2 model=NMOS w=3.4u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0 spiceprefix=X}
C {MP.sym} 240 -300 0 0 {name=M5 model=PMOS w=10.2u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0 spiceprefix=X}
