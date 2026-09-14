v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -730 1280 -70 1280 {lab=WL0}
N -70 1230 -70 1280 {lab=WL0}
N -730 1240 -730 1280 {lab=WL0}
N -980 1520 -320 1520 {lab=WL1}
N -730 1470 -730 1520 {lab=WL1}
N -920 1000 -920 1360 {lab=BL0}
N -920 1360 -880 1360 {lab=BL0}
N -920 1130 -880 1130 {lab=BL0}
N -260 990 -260 1350 {lab=BL1}
N -260 1360 -220 1360 {lab=BL1}
N -260 1120 -220 1120 {lab=BL1}
N 140 990 140 1350 {lab=BLB1}
N 80 1360 120 1360 {lab=BLB1}
N 100 1120 140 1120 {lab=BLB1}
N -980 1280 -870 1280 {lab=WL0}
N -520 1000 -520 1360 {lab=BLB0}
N -560 1130 -520 1130 {lab=BLB0}
N -320 1520 -210 1520 {lab=WL1}
N -580 1130 -560 1130 {lab=BLB0}
N -540 1360 -520 1360 {lab=BLB0}
N 80 1120 100 1120 {lab=BLB1}
N -580 1360 -540 1360 {lab=BLB0}
N -920 920 -920 1000 {lab=BL0}
N -520 920 -520 1000 {lab=BLB0}
N -260 920 -260 990 {lab=BL1}
N 140 920 140 990 {lab=BLB1}
N -870 1280 -730 1280 {lab=WL0}
N -70 1470 -70 1520 {lab=WL1}
N -210 1520 -70 1520 {lab=WL1}
N -920 820 -920 860 {lab=Vdd}
N -920 820 140 820 {lab=Vdd}
N 140 820 140 860 {lab=Vdd}
N -260 820 -260 860 {lab=Vdd}
N -520 820 -520 860 {lab=Vdd}
N -920 1360 -920 1640 {lab=BL0}
N -520 1360 -520 1640 {lab=BLB0}
N -260 1370 -260 1650 {lab=BL1}
N -260 1350 -260 1370 {lab=BL1}
N 140 1350 140 1650 {lab=BLB1}
N 120 1360 140 1360 {lab=BLB1}
N -520 1640 -520 1650 {lab=BLB0}
N -920 1640 -920 1650 {lab=BL0}
N -920 1710 -920 1820 {lab=Vss}
N -920 1820 100 1820 {lab=Vss}
N 140 1710 140 1820 {lab=Vss}
N 100 1820 140 1820 {lab=Vss}
N -260 1710 -260 1820 {lab=Vss}
N -520 1710 -520 1820 {lab=Vss}
N -980 1820 -920 1820 {lab=Vss}
N -920 890 -860 890 {lab=Vdd}
N -860 820 -860 890 {lab=Vdd}
N -520 890 -460 890 {lab=Vdd}
N -460 820 -460 890 {lab=Vdd}
N -260 890 -200 890 {lab=Vdd}
N -200 820 -200 890 {lab=Vdd}
N 140 890 200 890 {lab=Vdd}
N 200 820 200 890 {lab=Vdd}
N 140 820 200 820 {lab=Vdd}
N -920 1680 -860 1680 {lab=Vss}
N -860 1680 -860 1820 {lab=Vss}
N -520 1680 -460 1680 {lab=Vss}
N -460 1680 -460 1820 {lab=Vss}
N -260 1680 -200 1680 {lab=Vss}
N -200 1680 -200 1820 {lab=Vss}
N 140 1680 200 1680 {lab=Vss}
N 200 1680 200 1820 {lab=Vss}
N 140 1820 200 1820 {lab=Vss}
N -920 970 -760 970 {lab=BL0}
N -700 970 -520 970 {lab=BLB0}
N -730 820 -730 970 {lab=Vdd}
N -260 970 -100 970 {lab=BL1}
N -40 970 140 970 {lab=BLB1}
N -70 820 -70 970 {lab=Vdd}
C {sram.sym} -730 1160 0 0 {name=x1}
C {sram.sym} -730 1390 0 0 {name=x2}
C {sram.sym} -70 1150 0 0 {name=x3}
C {sram.sym} -70 1390 0 0 {name=x4}
C {devices/iopin.sym} -920 990 2 0 {name=p9 lab=BL0}
C {devices/iopin.sym} -520 1000 2 0 {name=p3 lab=BLB0}
C {devices/iopin.sym} -260 1000 2 0 {name=p4 lab=BL1}
C {devices/iopin.sym} 140 990 2 0 {name=p5 lab=BLB1}
C {devices/ipin.sym} -980 1520 0 0 {name=p8 lab=WL1}
C {devices/ipin.sym} -980 1280 0 0 {name=p1 lab=WL0}
C {devices/ipin.sym} -580 1210 2 0 {name=p7 lab=Vss}
C {devices/ipin.sym} -580 1420 2 0 {name=p10 lab=Vdd}
C {devices/ipin.sym} -580 1440 2 0 {name=p11 lab=Vss}
C {devices/ipin.sym} 80 1420 2 0 {name=p12 lab=Vdd}
C {devices/ipin.sym} 80 1440 2 0 {name=p13 lab=Vss}
C {devices/ipin.sym} 80 1180 2 0 {name=p6 lab=Vdd}
C {devices/ipin.sym} 80 1200 2 0 {name=p14 lab=Vss}
C {TR-1umLIB/MP.sym} -960 890 0 0 {name=XM1
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
C {TR-1umLIB/MP.sym} -560 890 0 0 {name=XM2
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
C {TR-1umLIB/MP.sym} -300 890 0 0 {name=XM3
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
C {TR-1umLIB/MP.sym} 100 890 0 0 {name=XM4
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
C {devices/ipin.sym} -580 1190 2 0 {name=p2 lab=Vdd}
C {devices/ipin.sym} -920 820 0 0 {name=p15 lab=Vdd}
C {devices/ipin.sym} -960 890 0 0 {name=p16 lab=PREB}
C {devices/ipin.sym} -560 890 0 0 {name=p17 lab=PREB}
C {devices/ipin.sym} -300 890 0 0 {name=p18 lab=PREB}
C {devices/ipin.sym} 100 890 0 0 {name=p19 lab=PREB}
C {TR-1umLIB/MN.sym} -960 1680 0 0 {name=XM5
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
C {TR-1umLIB/MN.sym} -560 1680 0 0 {name=XM6
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
C {TR-1umLIB/MN.sym} -300 1680 0 0 {name=XM7
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
C {TR-1umLIB/MN.sym} 100 1680 0 0 {name=XM8
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
C {devices/ipin.sym} -980 1820 0 0 {name=p20 lab=Vss}
C {TR-1umLIB/MP.sym} -730 1010 1 1 {name=XM9
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
C {TR-1umLIB/MP.sym} -70 1010 1 1 {name=XM10
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
