v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {BALANCED TERNARY MULTIPLIER / P = A x B / NAND x2 + NOR + INV} 40 -140 0 0 0.38 0.38 {}
T {Logic -1 / 0 / +1 corresponds to -5 / 0 / +5 V. VDD=+5 V, VSS=-5 V.} 40 -80 0 0 0.24 0.24 {}
C {/home/ishi-kai/balanced-ternary-logic/mul_nand.sym} 320 160 0 0 {name=x_t1}
C {devices/lab_pin.sym} 320 100 0 0 {name=l1 lab=VDD}
C {devices/lab_pin.sym} 320 220 0 0 {name=l2 lab=VSS}
C {/home/ishi-kai/balanced-ternary-logic/mul_nor.sym} 320 480 0 0 {name=x_t2}
C {devices/lab_pin.sym} 320 420 0 0 {name=l3 lab=VDD}
C {devices/lab_pin.sym} 320 540 0 0 {name=l4 lab=VSS}
C {/home/ishi-kai/balanced-ternary-logic/mul_inv.sym} 670 480 0 0 {name=x_t3}
C {devices/lab_pin.sym} 670 420 0 0 {name=l5 lab=VDD}
C {devices/lab_pin.sym} 670 540 0 0 {name=l6 lab=VSS}
C {/home/ishi-kai/balanced-ternary-logic/mul_nand.sym} 1060 300 0 0 {name=x_p}
C {devices/lab_pin.sym} 1060 240 0 0 {name=l7 lab=VDD}
C {devices/lab_pin.sym} 1060 360 0 0 {name=l8 lab=VSS}
N 120 140 260 140 {lab=a}
C {devices/ipin.sym} 120 140 0 0 {name=l9 lab=a}
N 120 180 260 180 {lab=b}
C {devices/ipin.sym} 120 180 0 0 {name=l10 lab=b}
N 120 460 260 460 {lab=a}
C {devices/lab_pin.sym} 120 460 0 0 {name=l11 lab=a}
N 120 500 260 500 {lab=b}
C {devices/lab_pin.sym} 120 500 0 0 {name=l12 lab=b}
N 390 160 860 160 {lab=t1}
N 860 160 860 280 {lab=t1}
N 860 280 1000 280 {lab=t1}
N 390 480 610 480 {lab=t2}
N 740 480 900 480 {lab=t3}
N 900 320 900 480 {lab=t3}
N 900 320 1000 320 {lab=t3}
N 1130 300 1270 300 {lab=p}
C {devices/lab_pin.sym} 500 160 0 0 {name=l13 lab=t1}
C {devices/lab_pin.sym} 500 480 0 0 {name=l14 lab=t2}
C {devices/lab_pin.sym} 840 480 0 0 {name=l15 lab=t3}
C {devices/opin.sym} 1270 300 0 0 {name=l16 lab=p}
N 500 160 500 60 {lab=t1}
N 500 60 1270 60 {lab=t1}
C {devices/opin.sym} 1270 60 0 0 {name=l17 lab=t1}
N 840 480 840 600 {lab=t3}
N 840 600 1270 600 {lab=t3}
C {devices/opin.sym} 1270 600 0 0 {name=l18 lab=t3}
C {devices/iopin.sym} 160 680 0 0 {name=l19 lab=VDD}
C {devices/iopin.sym} 400 680 0 0 {name=l20 lab=VSS}
T {t1 = -min(a,b)} 40 770 0 0 0.24 0.24 {}
T {t2 = -max(a,b); t3 = -t2 = max(a,b)} 40 815 0 0 0.24 0.24 {}
T {p = -min(t1,t3) = a*b / 5 (voltages)} 40 860 0 0 0.24 0.24 {}
T {14 MOS + 8 RR. No internal load capacitor.} 40 905 0 0 0.24 0.24 {}
T {MUL variants are sized separately; existing NAND/NOR/INV remain unchanged.} 40 950 0 0 0.24 0.24 {}
