v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 0 -490 0 -380 {lab=VDD}
N 0 -320 0 -200 {lab=#net1}
N 0 -140 0 -50 {lab=#net2}
N 0 -430 120 -430 {lab=VDD}
N 120 -430 120 -170 {lab=VDD}
N 0 -350 120 -350 {lab=VDD}
N 0 -170 120 -170 {lab=VDD}
N -240 -350 -40 -350 {lab=a}
N -240 -170 -40 -170 {lab=b}
N 0 10 0 110 {lab=vout}
N 20 -20 160 -20 {lab=VDD}
N 20 140 160 140 {lab=VDD}
N 0 170 0 250 {lab=#net3}
N 0 310 0 430 {lab=#net4}
N 0 490 0 580 {lab=VSS}
N 0 280 120 280 {lab=VSS}
N 120 280 120 540 {lab=VSS}
N 0 460 120 460 {lab=VSS}
N 0 540 120 540 {lab=VSS}
N -240 280 -40 280 {lab=a}
N -240 460 -40 460 {lab=b}
N 0 50 80 50 {lab=vout}
N 80 50 310 50 {lab=vout}
N 470 60 470 80 {lab=vout}
N 310 50 470 50 {lab=vout}
N 470 50 470 60 {lab=vout}
N 470 90 470 110 {lab=vout}
N 470 80 470 90 {lab=vout}
N 470 170 470 290 {lab=#net5}
N 470 350 470 440 {lab=VMID}
N 770 90 770 110 {lab=vout}
N 770 170 770 290 {lab=#net6}
N 770 350 770 440 {lab=VMID}
N 470 50 640 50 {lab=vout}
N 770 50 770 90 {lab=vout}
N 640 50 860 50 {lab=vout}
N 340 140 430 140 {lab=a}
N 640 140 730 140 {lab=b}
N 340 320 430 320 {lab=b}
N 640 320 730 320 {lab=a}
N 470 140 550 140 {lab=VDD}
N 770 140 850 140 {lab=VDD}
N 470 320 550 320 {lab=VSS}
N 770 320 850 320 {lab=VSS}
C {TR-1umLIB/MP.sym} -40 -170 0 0 {name=XM3
model=PMOS
w=34u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {devices/iopin.sym} 0 -490 0 0 {name=l1 lab=VDD}
C {devices/ipin.sym} -240 -350 0 0 {name=lab1 lab=a}
C {devices/ipin.sym} -240 -170 0 0 {name=lab2 lab=b}
C {TR-1umLIB/RR.sym} 0 -50 0 0 {name=R2
w=2.8e-06
R=1
l=30e-06
model=F_RR
spiceprefix=X
tc1=0
tc2=0
m=1}
C {TR-1umLIB/RR.sym} 0 110 0 0 {name=R1
w=2.8e-06
R=1
l=30e-06
model=F_RR
spiceprefix=X
tc1=0
tc2=0
m=1}
C {devices/opin.sym} 860 50 0 0 {name=lab3 lab=vout}
C {devices/lab_pin.sym} 160 -20 0 1 {name=lab4 lab=VDD}
C {devices/lab_pin.sym} 160 140 0 1 {name=lab5 lab=VDD}
C {TR-1umLIB/MN.sym} -40 280 0 0 {name=XM2
model=NMOS
w=11u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MN.sym} -40 460 0 0 {name=XM1
model=NMOS
w=11u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {devices/lab_pin.sym} -240 280 0 0 {name=label7 lab=a}
C {devices/lab_pin.sym} -240 460 0 0 {name=label8 lab=b}
C {devices/iopin.sym} 0 580 2 0 {name=l4 lab=VSS}
C {TR-1umLIB/MP.sym} -40 -350 0 0 {name=XM5
model=PMOS
w=34u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MP.sym} 430 140 0 0 {name=XM6
model=PMOS
w=14u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MN.sym} 430 320 0 0 {name=XM7
model=NMOS
w=8u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {devices/iopin.sym} 470 440 0 0 {name=gload lab=VMID}
C {TR-1umLIB/MP.sym} 730 140 0 0 {name=XM8
model=PMOS
w=14u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MN.sym} 730 320 0 0 {name=XM9
model=NMOS
w=8u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {devices/lab_pin.sym} 770 440 0 0 {name=gload1 lab=VMID}
C {devices/lab_pin.sym} 340 140 0 0 {name=label1 lab=a}
C {devices/lab_pin.sym} 640 140 0 0 {name=label2 lab=b}
C {devices/lab_pin.sym} 340 320 0 0 {name=label3 lab=b}
C {devices/lab_pin.sym} 640 320 0 0 {name=label4 lab=a}
C {devices/lab_pin.sym} 550 140 0 1 {name=lab6 lab=VDD}
C {devices/lab_pin.sym} 850 140 0 1 {name=lab7 lab=VDD}
C {devices/lab_pin.sym} 550 320 0 1 {name=lab8 lab=VSS}
C {devices/lab_pin.sym} 850 320 0 1 {name=lab9 lab=VSS}
T {NANY / y = -sat(a+b) on trits / zero clamp referenced to VMID} -240 -620 0 0 0.35 0.35 {}
T {DEVICE SIZES / all MOS L = 1 um} 1030 -370 0 0 0.28 0.28 {}
T {Main PMOS XM3/XM5: W = 34 um} 1030 -315 0 0 0.24 0.24 {}
T {Main NMOS XM1/XM2: W = 11 um} 1030 -270 0 0 0.24 0.24 {}
T {Zero-clamp PMOS XM6/XM8: W = 14 um} 1030 -205 0 0 0.24 0.24 {}
T {Zero-clamp NMOS XM7/XM9: W = 8 um} 1030 -160 0 0 0.24 0.24 {}
T {R1/R2: W = 2.8 um / L = 16 um / about 4.13 kohm each} 1030 -95 0 0 0.24 0.24 {}
T {VMID = 0 V reference. No internal load capacitor.} 1030 -25 0 0 0.24 0.24 {}
T {IC primitive v1 / 8 MOS + 2 RR / nominal supplies +5 / 0 / -5 V} -240 -560 0 0 0.25 0.25 {}
