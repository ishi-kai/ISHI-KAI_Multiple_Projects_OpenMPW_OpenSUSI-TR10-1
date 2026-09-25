v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {BALANCED TERNARY HALF ADDER / NANY x5 + INV x2} 40 -200 0 0 0.4 0.4 {}
T {a + b = sum + 3*carry.  T and carry are shared internally.} 40 -145 0 0 0.25 0.25 {}
T {Logic -1 / 0 / +1 corresponds to -5 / 0 / +5 V.} 40 -105 0 0 0.25 0.25 {}
T {T = NANY(a,b)} 230 230 0 0 0.25 0.25 {}
T {U = NANY(b,T)} 600 230 0 0 0.25 0.25 {}
T {NA = INV(a)} 230 520 0 0 0.25 0.25 {}
T {C = NANY(NA,U)} 940 520 0 0 0.25 0.25 {}
T {Power/reference ports: VDD = +5 V; VSS = -5 V; VMID = 0 V.} 40 1160 0 0 0.25 0.25 {}
T {No internal load capacitor. Add load in the parent testbench.} 40 1205 0 0 0.25 0.25 {}
T {SUM GENERATION / reuse T and CARRY} 40 650 0 0 0.3 0.3 {}
T {D = NANY(T,C)} 220 950 0 0 0.25 0.25 {}
T {ND = INV(D)} 580 950 0 0 0.25 0.25 {}
T {S = NANY(ND,C)} 940 950 0 0 0.25 0.25 {}
N 80 80 240 80 {lab=a}
N 80 120 240 120 {lab=b}
N 370 100 490 100 {lab=t}
N 490 100 490 140 {lab=t}
N 490 140 590 140 {lab=t}
N 520 100 590 100 {lab=b}
N 180 400 240 400 {lab=a}
N 370 400 490 400 {lab=na}
N 490 360 490 400 {lab=na}
N 490 360 990 360 {lab=na}
N 720 120 860 120 {lab=u}
N 860 120 860 400 {lab=u}
N 860 400 990 400 {lab=u}
N 1120 380 1240 380 {lab=carry}
N 160 780 240 780 {lab=t}
N 160 820 240 820 {lab=carry}
N 370 800 590 800 {lab=d}
N 720 800 990 800 {lab=nd}
N 920 840 990 840 {lab=carry}
N 1120 820 1240 820 {lab=sum}
C {/home/ishi-kai/balanced-ternary-logic/nany.sym} 300 100 0 0 {name=x_t}
C {devices/lab_pin.sym} 300 40 0 0 {name=l1 lab=VDD}
C {devices/lab_pin.sym} 300 160 0 0 {name=l2 lab=VSS}
C {devices/lab_pin.sym} 330 180 0 0 {name=l3 lab=VMID}
C {/home/ishi-kai/balanced-ternary-logic/nany.sym} 650 120 0 0 {name=x_u}
C {devices/lab_pin.sym} 650 60 0 0 {name=l4 lab=VDD}
C {devices/lab_pin.sym} 650 180 0 0 {name=l5 lab=VSS}
C {devices/lab_pin.sym} 680 200 0 0 {name=l6 lab=VMID}
C {/home/ishi-kai/balanced-ternary-logic/inverter.sym} 300 400 0 0 {name=x_na}
C {devices/lab_pin.sym} 300 340 0 0 {name=l7 lab=VDD}
C {devices/lab_pin.sym} 300 460 0 0 {name=l8 lab=VSS}
C {/home/ishi-kai/balanced-ternary-logic/nany.sym} 1050 380 0 0 {name=x_c}
C {devices/lab_pin.sym} 1050 320 0 0 {name=l9 lab=VDD}
C {devices/lab_pin.sym} 1050 440 0 0 {name=l10 lab=VSS}
C {devices/lab_pin.sym} 1080 460 0 0 {name=l11 lab=VMID}
C {devices/ipin.sym} 80 80 0 0 {name=l12 lab=a}
C {devices/ipin.sym} 80 120 0 0 {name=l13 lab=b}
C {devices/lab_pin.sym} 490 140 0 0 {name=l14 lab=t}
C {devices/lab_pin.sym} 520 100 0 0 {name=l15 lab=b}
C {devices/lab_pin.sym} 180 400 0 0 {name=l16 lab=a}
C {devices/lab_pin.sym} 620 360 0 0 {name=l17 lab=na}
C {devices/lab_pin.sym} 860 200 0 0 {name=l18 lab=u}
C {devices/opin.sym} 1240 380 0 0 {name=l19 lab=carry}
C {devices/iopin.sym} 180 1080 0 0 {name=l20 lab=VDD}
C {devices/iopin.sym} 420 1080 0 0 {name=l21 lab=VSS}
C {devices/iopin.sym} 660 1080 0 0 {name=l22 lab=VMID}
C {/home/ishi-kai/balanced-ternary-logic/nany.sym} 300 800 0 0 {name=x_d}
C {devices/lab_pin.sym} 300 740 0 0 {name=l101 lab=VDD}
C {devices/lab_pin.sym} 300 860 0 0 {name=l102 lab=VSS}
C {devices/lab_pin.sym} 330 880 0 0 {name=l103 lab=VMID}
C {/home/ishi-kai/balanced-ternary-logic/inverter.sym} 650 800 0 0 {name=x_nd}
C {devices/lab_pin.sym} 650 740 0 0 {name=l104 lab=VDD}
C {devices/lab_pin.sym} 650 860 0 0 {name=l105 lab=VSS}
C {/home/ishi-kai/balanced-ternary-logic/nany.sym} 1050 820 0 0 {name=x_s}
C {devices/lab_pin.sym} 1050 760 0 0 {name=l106 lab=VDD}
C {devices/lab_pin.sym} 1050 880 0 0 {name=l107 lab=VSS}
C {devices/lab_pin.sym} 1080 900 0 0 {name=l108 lab=VMID}
C {devices/lab_pin.sym} 160 780 0 0 {name=l109 lab=t}
C {devices/lab_pin.sym} 160 820 0 0 {name=l110 lab=carry}
C {devices/lab_pin.sym} 490 800 0 0 {name=l111 lab=d}
C {devices/lab_pin.sym} 850 800 0 0 {name=l112 lab=nd}
C {devices/lab_pin.sym} 920 840 0 0 {name=l113 lab=carry}
C {devices/opin.sym} 1240 820 0 0 {name=l114 lab=sum}
