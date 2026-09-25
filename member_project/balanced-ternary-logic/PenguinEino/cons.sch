v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {CONS / HALF-ADDER CARRY / NSIGN x3 + INV x1} 40 -200 0 0 0.4 0.4 {}
T {CONS(a,b) = a when a=b; otherwise 0.  NSIGN = NANY = -sat(a+b).} 40 -145 0 0 0.25 0.25 {}
T {Logic -1 / 0 / +1 corresponds to -5 / 0 / +5 V.} 40 -105 0 0 0.25 0.25 {}
C {/home/ishi-kai/balanced-ternary-logic/nsign.sym} 300 100 0 0 {name=x_t}
C {devices/lab_pin.sym} 300 40 0 0 {name=l1 lab=V+}
C {devices/lab_pin.sym} 300 160 0 0 {name=l2 lab=V-}
C {devices/lab_pin.sym} 330 180 0 0 {name=l3 lab=V0}
C {/home/ishi-kai/balanced-ternary-logic/nsign.sym} 650 120 0 0 {name=x_u}
C {devices/lab_pin.sym} 650 60 0 0 {name=l4 lab=V+}
C {devices/lab_pin.sym} 650 180 0 0 {name=l5 lab=V-}
C {devices/lab_pin.sym} 680 200 0 0 {name=l6 lab=V0}
C {/home/ishi-kai/balanced-ternary-logic/inverter.sym} 300 400 0 0 {name=x_na}
C {devices/lab_pin.sym} 300 340 0 0 {name=l7 lab=V+}
C {devices/lab_pin.sym} 300 460 0 0 {name=l8 lab=V-}
C {/home/ishi-kai/balanced-ternary-logic/nsign.sym} 1050 380 0 0 {name=x_y}
C {devices/lab_pin.sym} 1050 320 0 0 {name=l9 lab=V+}
C {devices/lab_pin.sym} 1050 440 0 0 {name=l10 lab=V-}
C {devices/lab_pin.sym} 1080 460 0 0 {name=l11 lab=V0}
C {devices/ipin.sym} 80 80 0 0 {name=l12 lab=a}
N 80 80 240 80 {lab=a}
C {devices/ipin.sym} 80 120 0 0 {name=l13 lab=b}
N 80 120 240 120 {lab=b}
N 370 100 490 100 {lab=t}
N 490 100 490 140 {lab=t}
N 490 140 590 140 {lab=t}
C {devices/lab_pin.sym} 490 140 0 0 {name=l14 lab=t}
N 520 100 590 100 {lab=b}
C {devices/lab_pin.sym} 520 100 0 0 {name=l15 lab=b}
N 180 400 240 400 {lab=a}
C {devices/lab_pin.sym} 180 400 0 0 {name=l16 lab=a}
N 370 400 490 400 {lab=na}
N 490 360 490 400 {lab=na}
N 490 360 990 360 {lab=na}
C {devices/lab_pin.sym} 620 360 0 0 {name=l17 lab=na}
N 720 120 860 120 {lab=u}
N 860 120 860 400 {lab=u}
N 860 400 990 400 {lab=u}
C {devices/lab_pin.sym} 860 200 0 0 {name=l18 lab=u}
N 1120 380 1240 380 {lab=vout}
C {devices/opin.sym} 1240 380 0 0 {name=l19 lab=vout}
C {devices/iopin.sym} 180 620 0 0 {name=l20 lab=V+}
C {devices/iopin.sym} 420 620 0 0 {name=l21 lab=V-}
C {devices/iopin.sym} 660 620 0 0 {name=l22 lab=V0}
T {T = NSIGN(a,b)} 230 230 0 0 0.25 0.25 {}
T {U = NSIGN(b,T)} 600 230 0 0 0.25 0.25 {}
T {NA = INV(a)} 230 520 0 0 0.25 0.25 {}
T {Y = NSIGN(NA,U)} 940 520 0 0 0.25 0.25 {}
T {Power/reference ports: V+ = +5 V; V- = -5 V; V0 = 0 V.} 40 700 0 0 0.25 0.25 {}
T {No internal load capacitor. Add load in the parent testbench.} 40 745 0 0 0.25 0.25 {}
