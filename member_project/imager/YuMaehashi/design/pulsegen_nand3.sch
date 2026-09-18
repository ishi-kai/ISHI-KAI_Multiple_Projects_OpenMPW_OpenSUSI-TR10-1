v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 360 -350 360 -310 {
lab=Y}
N 160 -350 160 -330 {
lab=Y}
N 160 -330 360 -330 {
lab=Y}
N 260 -350 260 -330 {
lab=Y}
N 360 -250 360 -210 {
lab=#net1}
N 360 -150 360 -110 {
lab=#net2}
N 300 -380 300 -280 {
lab=C}
N 310 -280 320 -280 {
lab=C}
N 200 -380 200 -180 {
lab=B}
N 210 -180 320 -180 {
lab=B}
N 100 -380 100 -80 {
lab=A}
N 110 -80 320 -80 {
lab=A}
N 160 -440 160 -410 {
lab=VDD}
N 80 -440 380 -440 {
lab=VDD}
N 160 -380 180 -380 {
lab=VDD}
N 180 -440 180 -380 {
lab=VDD}
N 260 -440 260 -410 {
lab=VDD}
N 260 -380 280 -380 {
lab=VDD}
N 280 -440 280 -380 {
lab=VDD}
N 360 -440 360 -410 {
lab=VDD}
N 360 -380 380 -380 {
lab=VDD}
N 380 -440 380 -380 {
lab=VDD}
N 360 -50 360 -20 {
lab=GND}
N 60 -20 380 -20 {
lab=GND}
N 380 -280 380 -20 {
lab=GND}
N 360 -280 380 -280 {
lab=GND}
N 360 -180 380 -180 {
lab=GND}
N 360 -80 380 -80 {
lab=GND}
N 360 -330 420 -330 {
lab=Y}
N 60 -180 210 -180 {
lab=B}
N 60 -80 110 -80 {
lab=A}
N 60 -280 310 -280 {
lab=C}
N 300 -380 320 -380 {lab=C}
N 200 -380 220 -380 {lab=B}
N 100 -380 120 -380 {lab=A}
C {devices/ipin.sym} 60 -180 0 0 {name=p1 lab=B}
C {devices/ipin.sym} 60 -80 0 0 {name=p2 lab=A}
C {devices/opin.sym} 420 -330 0 0 {name=p3 lab=Y}
C {devices/iopin.sym} 60 -20 0 1 {name=p4 lab=VSS
}
C {devices/iopin.sym} 80 -440 0 1 {name=p5 lab=VDD
}
C {devices/ipin.sym} 60 -280 0 0 {name=p6 lab=C}
C {MP.sym} 120 -380 0 0 {name=M1 model=PMOS w=10.2u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0 spiceprefix=X}
C {MP.sym} 220 -380 0 0 {name=M4 model=PMOS w=10.2u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0 spiceprefix=X}
C {MP.sym} 320 -380 0 0 {name=M6 model=PMOS w=10.2u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0 spiceprefix=X}
C {MN.sym} 320 -280 0 0 {name=M7 model=NMOS w=3.4u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0 spiceprefix=X}
C {MN.sym} 320 -180 0 0 {name=M2 model=NMOS w=3.4u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0 spiceprefix=X}
C {MN.sym} 320 -80 0 0 {name=M3 model=NMOS w=3.4u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0 spiceprefix=X}
