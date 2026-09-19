v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 850 -20 850 -10 {lab=3v}
N 640 20 680 20 {lab=out}
N 640 20 640 120 {lab=out}
N 520 60 680 60 {lab=1v5}
N 920 40 920 150 {lab=#net1}
N 730 -20 730 -10 {lab=3v}
N 520 0 680 0 {lab=5ub}
N 520 -20 850 -20 {lab=3v}
N 730 90 730 180 {lab=vss}
N 850 90 850 180 {lab=vss}
N 870 150 880 150 {lab=vss}
N 870 150 870 180 {lab=vss}
N 570 -20 570 70 {lab=3v}
N 640 120 940 120 {lab=out}
N 520 180 880 180 {lab=vss}
N 570 170 570 180 {lab=vss}
C {diff.sym} 540 120 0 0 {name=x1}
C {diff.sym} 700 40 0 0 {name=x2}
C {inverter_15v.sym} 820 40 0 0 {name=x3}
C {IP62LIB/MN.sym} 920 150 0 1 {name=XM1
model=NMOS
w=4u
l=2u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {devices/ipin.sym} 520 140 0 0 {name=p2 lab=1v}
C {devices/ipin.sym} 520 100 0 0 {name=p3 lab=fb}
C {devices/opin.sym} 520 80 0 1 {name=p4 lab=5ua}
C {devices/opin.sym} 520 0 0 1 {name=p5 lab=5ub}
C {devices/ipin.sym} 520 60 0 0 {name=p6 lab=1v5}
C {devices/iopin.sym} 520 -20 0 1 {name=p1 lab=3v}
C {devices/iopin.sym} 520 180 0 1 {name=p9 lab=vss}
C {devices/opin.sym} 940 120 0 0 {name=p10 lab=out}
