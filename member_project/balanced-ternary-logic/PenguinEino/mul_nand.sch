v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {MUL VARIANT / BALANCED TERNARY NAND / y = -min(a, b)} 100 -100 0 0 0.4 0.4 {}
T {V+ = +5 V    |    V- = -5 V    |    levels: -5 / 0 / +5 V} 100 -45 0 0 0.25 0.25 {}
C {TR-1umLIB/MP.sym} 280 200 0 0 {name=XM1
model=PMOS
w=19u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MP.sym} 620 200 0 0 {name=XM3
model=PMOS
w=19u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
N 320 120 660 120 {lab=V+}
N 320 120 320 170 {lab=V+}
N 660 120 660 170 {lab=V+}
N 320 200 400 200 {lab=V+}
N 400 120 400 200 {lab=V+}
N 660 200 740 200 {lab=V+}
N 740 120 740 200 {lab=V+}
N 660 120 740 120 {lab=V+}
N 320 230 320 280 {lab=#net1}
N 660 230 660 280 {lab=#net1}
N 320 280 660 280 {lab=#net1}
N 460 280 460 340 {lab=#net1}
N 460 60 460 120 {lab=V+}
C {devices/iopin.sym} 460 60 0 0 {name=label1 lab=V+}
N 200 200 280 200 {lab=a}
C {devices/ipin.sym} 200 200 0 0 {name=label2 lab=a}
N 540 200 620 200 {lab=b}
C {devices/ipin.sym} 540 200 0 0 {name=label3 lab=b}
C {TR-1umLIB/RR.sym} 460 340 0 0 {name=R1
w=2.8e-06
R=1
l=30e-06
model=F_RR
spiceprefix=X
tc1=0
tc2=0
m=1}
C {TR-1umLIB/RR.sym} 460 480 0 0 {name=R2
w=2.8e-06
R=1
l=30e-06
model=F_RR
spiceprefix=X
tc1=0
tc2=0
m=1}
N 460 400 460 480 {lab=vout}
N 460 440 840 440 {lab=vout}
C {devices/opin.sym} 840 440 0 0 {name=label4 lab=vout}
N 480 370 600 370 {lab=V+}
C {devices/lab_pin.sym} 600 370 0 1 {name=label5 lab=V+}
N 480 510 600 510 {lab=V+}
C {devices/lab_pin.sym} 600 510 0 1 {name=label6 lab=V+}
N 460 540 460 650 {lab=#net3}
C {TR-1umLIB/MN.sym} 420 680 0 0 {name=XM2
model=NMOS
w=13u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MN.sym} 420 860 0 0 {name=XM4
model=NMOS
w=13u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
N 460 710 460 830 {lab=#net2}
N 460 890 460 980 {lab=V-}
N 460 680 580 680 {lab=V-}
N 580 680 580 940 {lab=V-}
N 460 860 580 860 {lab=V-}
N 460 940 580 940 {lab=V-}
N 220 680 420 680 {lab=a}
C {devices/lab_pin.sym} 220 680 0 0 {name=label7 lab=a}
N 220 860 420 860 {lab=b}
C {devices/lab_pin.sym} 220 860 0 0 {name=label8 lab=b}
C {devices/iopin.sym} 460 980 2 0 {name=label9 lab=V-}
T {DEVICE SIZES} 950 100 0 0 0.3 0.3 {}
T {PMOS: W = 19 um / L = 1 um} 950 150 0 0 0.24 0.24 {}
T {NMOS: W = 13 um / L = 1 um} 950 195 0 0 0.24 0.24 {}
T {RR1 / RR2: W = 2.8 um / L = 15 um} 950 250 0 0 0.24 0.24 {}
T {RR SUB -> V+} 950 315 0 0 0.24 0.24 {}
T {MOS bodies -> corresponding supply} 950 355 0 0 0.24 0.24 {}
T {No internal load; add Cload in the testbench.} 950 395 0 0 0.24 0.24 {}
