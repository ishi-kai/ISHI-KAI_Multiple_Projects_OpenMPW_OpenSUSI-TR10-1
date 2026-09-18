v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 460 -450 460 -410 {
lab=Y}
N 260 -450 260 -430 {
lab=Y}
N 160 -430 460 -430 {
lab=Y}
N 360 -450 360 -430 {
lab=Y}
N 460 -350 460 -310 {
lab=#net1}
N 460 -250 460 -210 {
lab=#net2}
N 400 -480 400 -380 {
lab=D}
N 410 -380 420 -380 {
lab=D}
N 300 -480 300 -280 {
lab=C}
N 310 -280 420 -280 {
lab=C}
N 200 -480 200 -180 {
lab=B}
N 210 -180 420 -180 {
lab=B}
N 260 -540 260 -510 {
lab=VDD}
N 80 -540 480 -540 {
lab=VDD}
N 260 -480 280 -480 {
lab=VDD}
N 280 -540 280 -480 {
lab=VDD}
N 360 -540 360 -510 {
lab=VDD}
N 360 -480 380 -480 {
lab=VDD}
N 380 -540 380 -480 {
lab=VDD}
N 460 -540 460 -510 {
lab=VDD}
N 460 -480 480 -480 {
lab=VDD}
N 480 -540 480 -480 {
lab=VDD}
N 60 -20 480 -20 {
lab=GND}
N 480 -380 480 -20 {
lab=GND}
N 460 -380 480 -380 {
lab=GND}
N 460 -280 480 -280 {
lab=GND}
N 460 -180 480 -180 {
lab=GND}
N 460 -430 520 -430 {
lab=Y}
N 60 -280 310 -280 {
lab=C}
N 60 -180 210 -180 {
lab=B}
N 60 -380 410 -380 {
lab=D}
N 400 -480 420 -480 {lab=D}
N 300 -480 320 -480 {lab=C}
N 200 -480 220 -480 {lab=B}
N 160 -450 160 -430 {
lab=Y}
N 160 -540 160 -510 {
lab=VDD}
N 160 -480 180 -480 {
lab=VDD}
N 180 -540 180 -480 {
lab=VDD}
N 100 -480 120 -480 {lab=A}
N 210 -80 420 -80 {
lab=A}
N 460 -80 480 -80 {
lab=GND}
N 60 -80 210 -80 {
lab=A}
N 460 -50 460 -20 {lab=GND}
N 460 -150 460 -110 {lab=#net3}
N 100 -480 100 -80 {lab=A}
C {devices/ipin.sym} 60 -180 0 0 {name=p1 lab=B}
C {devices/ipin.sym} 60 -80 0 0 {name=p2 lab=A}
C {devices/opin.sym} 520 -430 0 0 {name=p3 lab=Y}
C {devices/iopin.sym} 60 -20 0 1 {name=p4 lab=VSS
}
C {devices/iopin.sym} 80 -540 0 1 {name=p5 lab=VDD
}
C {devices/ipin.sym} 60 -280 0 0 {name=p6 lab=C}
C {MP.sym} 220 -480 0 0 {name=M1 model=PMOS w=10.2u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0 spiceprefix=X}
C {MP.sym} 320 -480 0 0 {name=M4 model=PMOS w=10.2u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0 spiceprefix=X}
C {MP.sym} 420 -480 0 0 {name=M6 model=PMOS w=10.2u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0 spiceprefix=X}
C {MN.sym} 420 -380 0 0 {name=M7 model=NMOS w=3.4u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0 spiceprefix=X}
C {MN.sym} 420 -280 0 0 {name=M2 model=NMOS w=3.4u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0 spiceprefix=X}
C {MN.sym} 420 -180 0 0 {name=M3 model=NMOS w=3.4u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0 spiceprefix=X}
C {MP.sym} 120 -480 0 0 {name=M5 model=PMOS w=10.2u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0 spiceprefix=X}
C {MN.sym} 420 -80 0 0 {name=M8 model=NMOS w=3.4u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0 spiceprefix=X}
C {devices/ipin.sym} 60 -380 0 0 {name=p7 lab=D}
