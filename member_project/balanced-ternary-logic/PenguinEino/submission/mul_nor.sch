v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {MUL VARIANT / BALANCED TERNARY NOR / y = -max(a, b)} 100 -100 0 0 0.4 0.4 {}
T {V+ = +5 V  |  V- = -5 V  |  levels: -5 / 0 / +5 V} 100 -45 0 0 0.25 0.25 {}
T {DEVICE SIZES} 950 100 0 0 0.3 0.3 {}
T {PMOS: W = 37 um / L = 1 um} 950 150 0 0 0.25 0.25 {}
T {NMOS: W = 6.5 um / L = 1 um} 950 195 0 0 0.25 0.25 {}
T {RR1 / RR2: W = 2.8 um / L = 15 um} 950 250 0 0 0.25 0.25 {}
T {RR SUB -> V+} 950 315 0 0 0.25 0.25 {}
T {Load capacitor belongs in the testbench.} 950 355 0 0 0.25 0.25 {}
C {TR-1umLIB/MP.sym} 420 200 0 0 {name=XM4
model=PMOS
w=37u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MP.sym} 420 380 0 0 {name=XM3
model=PMOS
w=37u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
N 460 60 460 170 {lab=V+}
C {devices/iopin.sym} 460 60 0 0 {name=l1 lab=V+}
N 460 230 460 350 {lab=#net3}
N 460 410 460 500 {lab=#net2}
N 460 120 580 120 {lab=V+}
N 580 120 580 380 {lab=V+}
N 460 200 580 200 {lab=V+}
N 460 380 580 380 {lab=V+}
N 220 200 420 200 {lab=a}
C {devices/ipin.sym} 220 200 0 0 {name=lab1 lab=a}
N 220 380 420 380 {lab=b}
C {devices/ipin.sym} 220 380 0 0 {name=lab2 lab=b}
C {TR-1umLIB/RR.sym} 460 500 0 0 {name=R2
w=2.8e-06
R=1
l=30e-06
model=F_RR
spiceprefix=X
tc1=0
tc2=0
m=1}
C {TR-1umLIB/RR.sym} 460 660 0 0 {name=R1
w=2.8e-06
R=1
l=30e-06
model=F_RR
spiceprefix=X
tc1=0
tc2=0
m=1}
N 460 560 460 660 {lab=vout}
N 460 600 840 600 {lab=vout}
C {devices/opin.sym} 840 600 0 0 {name=lab3 lab=vout}
N 480 530 620 530 {lab=V+}
C {devices/lab_pin.sym} 620 530 0 1 {name=lab4 lab=V+}
N 480 690 620 690 {lab=V+}
C {devices/lab_pin.sym} 620 690 0 1 {name=lab5 lab=V+}
N 460 720 460 800 {lab=#net1}
N 320 800 660 800 {lab=#net1}
N 320 800 320 870 {lab=#net1}
N 660 800 660 870 {lab=#net1}
C {TR-1umLIB/MN.sym} 280 900 0 0 {name=XM2
model=NMOS
w=6.5u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MN.sym} 620 900 0 0 {name=XM1
model=NMOS
w=6.5u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
N 200 900 280 900 {lab=a}
C {devices/lab_pin.sym} 200 900 0 0 {name=lab6 lab=a}
N 540 900 620 900 {lab=b}
C {devices/lab_pin.sym} 540 900 0 0 {name=lab7 lab=b}
N 320 930 320 1020 {lab=V-}
N 660 930 660 1020 {lab=V-}
N 320 1020 740 1020 {lab=V-}
N 460 1020 460 1080 {lab=V-}
C {devices/iopin.sym} 460 1080 2 0 {name=l4 lab=V-}
N 320 900 400 900 {lab=V-}
N 400 900 400 1020 {lab=V-}
N 660 900 740 900 {lab=V-}
N 740 900 740 1020 {lab=V-}
