v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {PTI / 2-MOS TERNARY INVERTER} 80 -100 0 0 0.4 0.4 {}
T {Vin -5 / 0 / +5 V -> Vout +5 / +5 / -5 V} 80 -45 0 0 0.25 0.25 {}
C {TR-1umLIB/MP.sym} 420 200 0 0 {name=XM1
model=PMOS
w=20u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MN.sym} 420 480 0 0 {name=XM2
model=NMOS
w=3.4u
l=4u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
N 460 60 460 170 {lab=V+}
C {devices/iopin.sym} 460 60 0 0 {name=pvplus lab=V+}
N 460 200 580 200 {lab=V+}
N 580 120 580 200 {lab=V+}
N 460 120 580 120 {lab=V+}
N 460 230 460 450 {lab=vout}
N 460 340 740 340 {lab=vout}
C {devices/opin.sym} 740 340 0 0 {name=pout lab=vout}
N 220 200 420 200 {lab=vin}
N 220 200 220 480 {lab=vin}
N 220 480 420 480 {lab=vin}
N 80 340 220 340 {lab=vin}
C {devices/ipin.sym} 80 340 0 0 {name=pin lab=vin}
N 460 510 460 620 {lab=V-}
C {devices/iopin.sym} 460 620 0 0 {name=pvminus lab=V-}
N 460 480 580 480 {lab=V-}
N 580 480 580 580 {lab=V-}
N 460 580 580 580 {lab=V-}
T {DEVICE SIZES / um} 860 100 0 0 0.3 0.3 {}
T {PMOS W/L = 20 / 1} 860 155 0 0 0.25 0.25 {}
T {NMOS W/L = 3.4 / 4} 860 200 0 0 0.25 0.25 {}
T {No resistors. No internal load capacitor.} 860 270 0 0 0.25 0.25 {}
T {Bodies tied to their corresponding supply.} 860 315 0 0 0.25 0.25 {}
T {Vin = 0: both MOS conduct; output has a finite rail error.} 80 710 0 0 0.25 0.25 {}
