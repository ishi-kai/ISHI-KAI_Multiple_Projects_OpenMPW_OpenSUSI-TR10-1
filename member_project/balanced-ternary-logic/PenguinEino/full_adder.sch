v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {BALANCED TERNARY FULL ADDER / HA x2 + NANY + INV} 40 -180 0 0 0.4 0.4 {}
T {a + b + cin = sum + 3*cout.  Logic -1 / 0 / +1 = -5 / 0 / +5 V.} 40 -120 0 0 0.25 0.25 {}
T {HA1: a + b = s1 + 3*c1} 150 330 0 0 0.25 0.25 {}
T {HA2: s1 + cin = sum + 3*c2} 650 330 0 0 0.25 0.25 {}
T {CARRY MERGE: cout = ANY(c1,c2) = INV(NANY(c1,c2))} 40 450 0 0 0.28 0.28 {}
T {For valid inputs, c1 and c2 cannot both be +1 or both be -1.} 40 760 0 0 0.25 0.25 {}
T {Thus sat(c1+c2) = c1+c2 and a+b+cin = sum+3*cout.} 40 800 0 0 0.25 0.25 {}
T {VDD = +5 V; VSS = -5 V; VMID = 0 V. No internal load capacitors.} 40 980 0 0 0.25 0.25 {}
T {Hierarchy: full_adder -> half_adder -> nany / inverter. Total: NANY x11 + INV x5.} 40 1020 0 0 0.25 0.25 {}
N 80 140 210 140 {lab=a}
N 80 180 210 180 {lab=b}
N 390 140 710 140 {lab=s1}
N 630 180 710 180 {lab=cin}
N 390 180 470 180 {lab=c1}
N 470 180 470 580 {lab=c1}
N 470 580 590 580 {lab=c1}
N 890 140 1120 140 {lab=sum}
N 890 180 950 180 {lab=c2}
N 950 180 950 400 {lab=c2}
N 540 400 950 400 {lab=c2}
N 540 400 540 620 {lab=c2}
N 540 620 590 620 {lab=c2}
N 720 600 890 600 {lab=nc}
N 1020 600 1120 600 {lab=cout}
C {/home/ishi-kai/balanced-ternary-logic/half_adder.sym} 300 160 0 0 {name=x_ha1}
C {/home/ishi-kai/balanced-ternary-logic/half_adder.sym} 800 160 0 0 {name=x_ha2}
C {/home/ishi-kai/balanced-ternary-logic/nany.sym} 650 600 0 0 {name=x_cmerge}
C {/home/ishi-kai/balanced-ternary-logic/inverter.sym} 950 600 0 0 {name=x_cout}
C {devices/ipin.sym} 80 140 0 0 {name=p_a lab=a}
C {devices/ipin.sym} 80 180 0 0 {name=p_b lab=b}
C {devices/ipin.sym} 630 180 0 0 {name=p_cin lab=cin}
C {devices/opin.sym} 1120 140 0 0 {name=p_sum lab=sum}
C {devices/opin.sym} 1120 600 0 0 {name=p_cout lab=cout}
C {devices/lab_pin.sym} 550 140 0 0 {name=l_s1 lab=s1}
C {devices/lab_pin.sym} 470 280 0 0 {name=l_c1 lab=c1}
C {devices/lab_pin.sym} 950 280 0 1 {name=l_c2 lab=c2}
C {devices/lab_pin.sym} 810 600 0 0 {name=l_nc lab=nc}
C {devices/lab_pin.sym} 300 80 0 0 {name=l_vdd1 lab=VDD}
C {devices/lab_pin.sym} 300 240 0 0 {name=l_vss1 lab=VSS}
C {devices/lab_pin.sym} 330 260 0 1 {name=l_mid1 lab=VMID}
C {devices/lab_pin.sym} 800 80 0 0 {name=l_vdd2 lab=VDD}
C {devices/lab_pin.sym} 800 240 0 0 {name=l_vss2 lab=VSS}
C {devices/lab_pin.sym} 830 260 0 1 {name=l_mid2 lab=VMID}
C {devices/lab_pin.sym} 650 540 0 0 {name=l_vdd3 lab=VDD}
C {devices/lab_pin.sym} 650 660 0 0 {name=l_vss3 lab=VSS}
C {devices/lab_pin.sym} 680 680 0 1 {name=l_mid3 lab=VMID}
C {devices/lab_pin.sym} 950 540 0 0 {name=l_vdd4 lab=VDD}
C {devices/lab_pin.sym} 950 660 0 0 {name=l_vss4 lab=VSS}
C {devices/iopin.sym} 180 900 0 0 {name=p_vdd lab=VDD}
C {devices/iopin.sym} 420 900 0 0 {name=p_vss lab=VSS}
C {devices/iopin.sym} 660 900 0 0 {name=p_mid lab=VMID}
