v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {TERNARY STORAGE CORE / two cross-coupled inverters / 4 MOS + 4 R} 40 -140 0 0 0.38 0.38 {}
T {Q / QB: (-5,+5), (0,0), (+5,-5) V. VDD=+5 V; VSS=-5 V.} 40 -80 0 0 0.24 0.24 {}
C {/home/ishi-kai/balanced-ternary-logic/inverter.sym} 300 220 0 0 {name=x_q}
C {/home/ishi-kai/balanced-ternary-logic/inverter.sym} 700 220 0 1 {name=x_qb}
N 300 120 300 160 {lab=VDD}
C {devices/lab_pin.sym} 300 120 0 0 {name=l1 lab=VDD}
N 300 280 300 320 {lab=VSS}
C {devices/lab_pin.sym} 300 320 0 0 {name=l2 lab=VSS}
N 700 120 700 160 {lab=VDD}
C {devices/lab_pin.sym} 700 120 0 0 {name=l3 lab=VDD}
N 700 280 700 320 {lab=VSS}
C {devices/lab_pin.sym} 700 320 0 0 {name=l4 lab=VSS}
N 370 220 420 220 {lab=Q}
N 420 220 420 400 {lab=Q}
N 820 220 820 400 {lab=Q}
N 760 220 820 220 {lab=Q}
N 420 400 920 400 {lab=Q}
N 580 220 630 220 {lab=QB}
N 580 80 580 220 {lab=QB}
N 180 80 580 80 {lab=QB}
N 180 80 180 220 {lab=QB}
N 180 220 240 220 {lab=QB}
N 580 80 920 80 {lab=QB}
C {devices/opin.sym} 920 400 0 0 {name=l5 lab=Q}
C {devices/opin.sym} 920 80 0 0 {name=l6 lab=QB}
C {devices/iopin.sym} 180 520 0 0 {name=l7 lab=VDD}
C {devices/iopin.sym} 460 520 0 0 {name=l8 lab=VSS}
T {INV is the existing inverter.sch; primitive dimensions remain unchanged.} 40 610 0 0 0.24 0.24 {}
T {No explicit capacitors or initialization sources inside this cell.} 40 650 0 0 0.24 0.24 {}
