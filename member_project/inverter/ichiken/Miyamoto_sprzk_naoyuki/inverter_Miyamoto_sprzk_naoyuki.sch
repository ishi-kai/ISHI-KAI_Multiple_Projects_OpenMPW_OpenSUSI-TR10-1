v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -60 -50 -60 110 {lab=A}
N -20 -20 -20 80 {lab=Q}
N -20 140 -20 190 {lab=VSS}
N -20 110 0 110 {lab=VSS}
N 0 110 0 170 {lab=VSS}
N -20 170 0 170 {lab=VSS}
N -20 -50 -0 -50 {lab=VDD}
N 0 -70 -0 -50 {lab=VDD}
N -0 -80 0 -70 {lab=VDD}
N -20 -110 -20 -80 {lab=VDD}
N 0 -90 -0 -80 {lab=VDD}
N -20 -90 -0 -90 {lab=VDD}
N -100 30 -60 30 {lab=A}
N -20 30 20 30 {lab=Q}
N -20 -120 -20 -110 {lab=VDD}
C {MP.sym} -60 -50 0 0 {name=XM1 model=PMOS w=3.4u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MN.sym} -60 110 0 0 {name=XM2 model=NMOS w=3.4u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {devices/ipin.sym} -100 30 0 0 {name=p1 lab=A}
C {devices/iopin.sym} -20 -120 0 0 {name=p2 lab=VDD}
C {devices/opin.sym} 20 30 0 0 {name=p3 lab=Q}
C {devices/iopin.sym} -20 190 0 0 {name=p4 lab=VSS}
