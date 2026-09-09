v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 190 -220 190 -60 {lab=A}
N 230 -30 230 -0 {lab=VSS}
N 230 -290 230 -250 {lab=VDD}
N 260 -140 320 -140 {lab=Q}
N 120 -140 190 -140 {lab=A}
N 230 -190 250 -190 {lab=Q}
N 250 -190 260 -190 {lab=Q}
N 260 -190 260 -180 {lab=Q}
N 260 -180 260 -170 {lab=Q}
N 260 -170 260 -160 {lab=Q}
N 260 -160 260 -150 {lab=Q}
N 260 -150 260 -140 {lab=Q}
N 260 -140 260 -130 {lab=Q}
N 260 -130 260 -120 {lab=Q}
N 260 -120 260 -110 {lab=Q}
N 260 -110 260 -100 {lab=Q}
N 260 -100 260 -90 {lab=Q}
N 250 -90 260 -90 {lab=Q}
N 240 -90 250 -90 {lab=Q}
N 230 -90 240 -90 {lab=Q}
N 230 -60 240 -60 {lab=VSS}
N 240 -60 250 -60 {lab=VSS}
N 250 -60 250 -50 {lab=VSS}
N 250 -50 250 -40 {lab=VSS}
N 250 -40 250 -30 {lab=VSS}
N 250 -30 250 -20 {lab=VSS}
N 240 -20 250 -20 {lab=VSS}
N 230 -20 240 -20 {lab=VSS}
N 230 -220 240 -220 {lab=VDD}
N 240 -220 250 -220 {lab=VDD}
N 250 -230 250 -220 {lab=VDD}
N 250 -240 250 -230 {lab=VDD}
N 250 -250 250 -240 {lab=VDD}
N 250 -260 250 -250 {lab=VDD}
N 240 -260 250 -260 {lab=VDD}
N 230 -260 240 -260 {lab=VDD}
C {MP.sym} 190 -220 0 0 {name=XM2 model=PMOS w=3.4u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MN.sym} 190 -60 0 0 {name=XM3 model=NMOS w=3.4u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {devices/ipin.sym} 120 -140 0 0 {name=p1 lab=A}
C {devices/iopin.sym} 230 0 0 0 {name=p2 lab=VSS}
C {devices/opin.sym} 320 -140 0 0 {name=p3 lab=Q}
C {devices/iopin.sym} 230 -290 0 0 {name=p4 lab=VDD}
