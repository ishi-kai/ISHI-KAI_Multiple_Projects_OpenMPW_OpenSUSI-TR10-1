v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 430 -290 440 -290 {lab=A}
N 430 -130 440 -130 {lab=A}
N 480 -290 520 -290 {lab=VDD}
N 480 -380 480 -320 {lab=VDD}
N 520 -340 520 -290 {lab=VDD}
N 480 -340 520 -340 {lab=VDD}
N 480 -100 480 -60 {lab=VSS}
N 480 -130 520 -130 {lab=VSS}
N 520 -130 520 -80 {lab=VSS}
N 480 -80 520 -80 {lab=VSS}
N 430 -290 430 -130 {lab=A}
N 390 -210 430 -210 {lab=A}
N 480 -260 480 -160 {lab=Q}
N 480 -210 520 -210 {lab=Q}
C {MP.sym} 440 -290 0 0 {name=XM1 model=PMOS w=3.4u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MN.sym} 440 -130 0 0 {name=XM2 model=NMOS w=3.4u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {devices/ipin.sym} 390 -210 0 0 {name=p1 lab=A}
C {devices/iopin.sym} 480 -380 0 0 {name=p2 lab=VDD}
C {devices/opin.sym} 520 -210 0 0 {name=p3 lab=Q}
C {devices/iopin.sym} 480 -60 0 0 {name=p4 lab=VSS}
