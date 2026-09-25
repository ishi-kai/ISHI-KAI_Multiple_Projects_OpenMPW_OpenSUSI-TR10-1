v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {MUL VARIANT / BALANCED TERNARY INVERTER / y = -x} 100 -100 0 0 0.4 0.4 {}
T {VDD = +5 V    |    VSS = -5 V    |    levels: -5 / 0 / +5 V} 100 -45 0 0 0.25 0.25 {}
T {DEVICE SIZES} 950 100 0 0 0.3 0.3 {}
T {PMOS: W = 13.5 um / L = 1 um} 950 150 0 0 0.24 0.24 {}
T {NMOS: W = 5 um / L = 1 um} 950 195 0 0 0.24 0.24 {}
T {RR1 / RR2: W = 2.8 um / L = 15 um} 950 250 0 0 0.24 0.24 {}
T {RR SUB -> VDD} 950 315 0 0 0.24 0.24 {}
T {MOS bodies -> corresponding supply} 950 355 0 0 0.24 0.24 {}
T {No internal load; add Cload in the testbench.} 950 395 0 0 0.24 0.24 {}
N 460 60 460 170 {lab=VDD}
N 460 200 580 200 {lab=VDD}
N 580 120 580 200 {lab=VDD}
N 460 120 580 120 {lab=VDD}
N 460 230 460 340 {lab=#net1}
N 220 200 420 200 {lab=vin}
N 220 200 220 680 {lab=vin}
N 100 440 220 440 {lab=vin}
N 220 680 420 680 {lab=vin}
N 460 400 460 480 {lab=vout}
N 460 440 840 440 {lab=vout}
N 480 370 600 370 {lab=VDD}
N 480 510 600 510 {lab=VDD}
N 460 540 460 650 {lab=#net2}
N 460 710 460 820 {lab=VSS}
N 460 680 580 680 {lab=VSS}
N 580 680 580 780 {lab=VSS}
N 460 780 580 780 {lab=VSS}
C {TR-1umLIB/MP.sym} 420 200 0 0 {name=XM1
model=PMOS
w=13.5u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {devices/iopin.sym} 460 60 0 0 {name=label1 lab=VDD}
C {devices/ipin.sym} 100 440 0 0 {name=label2 lab=vin}
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
C {devices/opin.sym} 840 440 0 0 {name=label3 lab=vout}
C {devices/lab_pin.sym} 600 370 0 1 {name=label4 lab=VDD}
C {devices/lab_pin.sym} 600 510 0 1 {name=label5 lab=VDD}
C {TR-1umLIB/MN.sym} 420 680 0 0 {name=XM2
model=NMOS
w=5u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {devices/iopin.sym} 460 820 0 0 {name=label6 lab=VSS}
