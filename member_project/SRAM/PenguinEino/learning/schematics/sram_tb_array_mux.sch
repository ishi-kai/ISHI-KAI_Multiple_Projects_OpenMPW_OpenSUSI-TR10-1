v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {2 x 2 SRAM | COLUMN MUX / SHARED WRITE / SENSE} -180 -270 0 0 0.45 0.45 {}
T {Local bitlines run downward through the selected column mux to common lines Y / YB.} -180 -220 0 0 0.3 0.3 {}
T {COLUMN 0} 160 -160 0 0 0.3 0.3 {}
T {COLUMN 1} 960 -160 0 0 0.3 0.3 {}
N 0 -100 1380 -100 {lab=VDD}
C {devices/lab_pin.sym} 0 -100 0 0 {name=wirelabel12 lab=VDD}
C {TR-1umLIB/MP.sym} -40 0 0 0 {name=XP0_0
model=PMOS
w=10.2u
l=1u
m=1
spiceprefix=X
nrd=0
nrs=0}
N 0 -100 0 -30 {lab=VDD}
N 0 0 80 0 {lab=VDD}
N 80 -100 80 0 {lab=VDD}
C {devices/lab_pin.sym} -40 0 0 0 {name=wirelabel17 lab=PREB}
N 0 30 0 790 {lab=BL0}
C {devices/lab_pin.sym} 0 100 2 0 {name=wirelabel19 lab=BL0}
N 0 670 120 670 {lab=BL0}
N 120 670 120 680 {lab=BL0}
C {devices/capa.sym} 120 710 0 0 {name=CBL0 value='CBL' m=1}
C {devices/gnd.sym} 120 740 0 0 {name=ground23 lab=GND}
C {TR-1umLIB/MN.sym} -40 820 0 0 {name=XM0_0
model=NMOS
w=3.4u
l=1u
m=1
spiceprefix=X
nrd=0
nrs=0}
N 0 820 140 820 {lab=GND}
C {devices/lab_pin.sym} 140 820 2 0 {name=wirelabel26 lab=GND}
N 0 850 0 960 {lab=Y}
N -40 770 -40 820 {lab=COL0}
C {TR-1umLIB/MP.sym} 460 0 0 0 {name=XP0_1
model=PMOS
w=10.2u
l=1u
m=1
spiceprefix=X
nrd=0
nrs=0}
N 500 -100 500 -30 {lab=VDD}
N 500 0 580 0 {lab=VDD}
N 580 -100 580 0 {lab=VDD}
C {devices/lab_pin.sym} 460 0 0 0 {name=wirelabel33 lab=PREB}
N 500 30 500 790 {lab=BLB0}
C {devices/lab_pin.sym} 500 100 2 0 {name=wirelabel35 lab=BLB0}
N 500 670 620 670 {lab=BLB0}
N 620 670 620 680 {lab=BLB0}
C {devices/capa.sym} 620 710 0 0 {name=CBLB0 value='CBL' m=1}
C {devices/gnd.sym} 620 740 0 0 {name=ground39 lab=GND}
C {TR-1umLIB/MN.sym} 460 820 0 0 {name=XM0_1
model=NMOS
w=3.4u
l=1u
m=1
spiceprefix=X
nrd=0
nrs=0}
N 500 820 640 820 {lab=GND}
C {devices/lab_pin.sym} 640 820 2 0 {name=wirelabel42 lab=GND}
N 500 850 500 1020 {lab=YB}
N 460 770 460 820 {lab=COL0}
N -100 770 460 770 {lab=COL0}
C {devices/lab_pin.sym} -100 770 0 0 {name=wirelabel46 lab=COL0}
C {sram.sym} 250 230 0 0 {name=xc00}
N 0 200 100 200 {lab=BL0}
N 400 200 500 200 {lab=BLB0}
N 400 220 430 220 {lab=Q00}
C {devices/lab_pin.sym} 430 220 2 0 {name=wirelabel51 lab=Q00}
N 400 240 430 240 {lab=QB00}
C {devices/lab_pin.sym} 430 240 2 0 {name=wirelabel53 lab=QB00}
N 400 260 430 260 {lab=VDD}
C {devices/lab_pin.sym} 430 260 2 0 {name=wirelabel55 lab=VDD}
N 400 280 430 280 {lab=GND}
C {devices/lab_pin.sym} 430 280 2 0 {name=wirelabel57 lab=GND}
N 250 310 250 340 {lab=WL0}
C {sram.sym} 250 500 0 0 {name=xc10}
N 0 470 100 470 {lab=BL0}
N 400 470 500 470 {lab=BLB0}
N 400 490 430 490 {lab=Q10}
C {devices/lab_pin.sym} 430 490 2 0 {name=wirelabel63 lab=Q10}
N 400 510 430 510 {lab=QB10}
C {devices/lab_pin.sym} 430 510 2 0 {name=wirelabel65 lab=QB10}
N 400 530 430 530 {lab=VDD}
C {devices/lab_pin.sym} 430 530 2 0 {name=wirelabel67 lab=VDD}
N 400 550 430 550 {lab=GND}
C {devices/lab_pin.sym} 430 550 2 0 {name=wirelabel69 lab=GND}
N 250 580 250 610 {lab=WL1}
C {TR-1umLIB/MP.sym} 760 0 0 0 {name=XP1_0
model=PMOS
w=10.2u
l=1u
m=1
spiceprefix=X
nrd=0
nrs=0}
N 800 -100 800 -30 {lab=VDD}
N 800 0 880 0 {lab=VDD}
N 880 -100 880 0 {lab=VDD}
C {devices/lab_pin.sym} 760 0 0 0 {name=wirelabel75 lab=PREB}
N 800 30 800 790 {lab=BL1}
C {devices/lab_pin.sym} 800 100 2 0 {name=wirelabel77 lab=BL1}
N 800 670 920 670 {lab=BL1}
N 920 670 920 680 {lab=BL1}
C {devices/capa.sym} 920 710 0 0 {name=CBL1 value='CBL' m=1}
C {devices/gnd.sym} 920 740 0 0 {name=ground81 lab=GND}
C {TR-1umLIB/MN.sym} 760 820 0 0 {name=XM1_0
model=NMOS
w=3.4u
l=1u
m=1
spiceprefix=X
nrd=0
nrs=0}
N 800 820 940 820 {lab=GND}
C {devices/lab_pin.sym} 940 820 2 0 {name=wirelabel84 lab=GND}
N 800 850 800 960 {lab=Y}
N 760 770 760 820 {lab=COL1}
C {TR-1umLIB/MP.sym} 1260 0 0 0 {name=XP1_1
model=PMOS
w=10.2u
l=1u
m=1
spiceprefix=X
nrd=0
nrs=0}
N 1300 -100 1300 -30 {lab=VDD}
N 1300 0 1380 0 {lab=VDD}
N 1380 -100 1380 0 {lab=VDD}
C {devices/lab_pin.sym} 1260 0 0 0 {name=wirelabel91 lab=PREB}
N 1300 30 1300 790 {lab=BLB1}
C {devices/lab_pin.sym} 1300 100 2 0 {name=wirelabel93 lab=BLB1}
N 1300 670 1420 670 {lab=BLB1}
N 1420 670 1420 680 {lab=BLB1}
C {devices/capa.sym} 1420 710 0 0 {name=CBLB1 value='CBL' m=1}
C {devices/gnd.sym} 1420 740 0 0 {name=ground97 lab=GND}
C {TR-1umLIB/MN.sym} 1260 820 0 0 {name=XM1_1
model=NMOS
w=3.4u
l=1u
m=1
spiceprefix=X
nrd=0
nrs=0}
N 1300 820 1440 820 {lab=GND}
C {devices/lab_pin.sym} 1440 820 2 0 {name=wirelabel100 lab=GND}
N 1300 850 1300 1020 {lab=YB}
N 1260 770 1260 820 {lab=COL1}
N 700 770 1260 770 {lab=COL1}
C {devices/lab_pin.sym} 700 770 0 0 {name=wirelabel104 lab=COL1}
C {sram.sym} 1050 230 0 0 {name=xc01}
N 800 200 900 200 {lab=BL1}
N 1200 200 1300 200 {lab=BLB1}
N 1200 220 1230 220 {lab=Q01}
C {devices/lab_pin.sym} 1230 220 2 0 {name=wirelabel109 lab=Q01}
N 1200 240 1230 240 {lab=QB01}
C {devices/lab_pin.sym} 1230 240 2 0 {name=wirelabel111 lab=QB01}
N 1200 260 1230 260 {lab=VDD}
C {devices/lab_pin.sym} 1230 260 2 0 {name=wirelabel113 lab=VDD}
N 1200 280 1230 280 {lab=GND}
C {devices/lab_pin.sym} 1230 280 2 0 {name=wirelabel115 lab=GND}
N 1050 310 1050 340 {lab=WL0}
C {sram.sym} 1050 500 0 0 {name=xc11}
N 800 470 900 470 {lab=BL1}
N 1200 470 1300 470 {lab=BLB1}
N 1200 490 1230 490 {lab=Q11}
C {devices/lab_pin.sym} 1230 490 2 0 {name=wirelabel121 lab=Q11}
N 1200 510 1230 510 {lab=QB11}
C {devices/lab_pin.sym} 1230 510 2 0 {name=wirelabel123 lab=QB11}
N 1200 530 1230 530 {lab=VDD}
C {devices/lab_pin.sym} 1230 530 2 0 {name=wirelabel125 lab=VDD}
N 1200 550 1230 550 {lab=GND}
C {devices/lab_pin.sym} 1230 550 2 0 {name=wirelabel127 lab=GND}
N 1050 580 1050 610 {lab=WL1}
N -180 340 1050 340 {lab=WL0}
C {devices/lab_pin.sym} -180 340 0 0 {name=wirelabel130 lab=WL0}
N -180 610 1050 610 {lab=WL1}
C {devices/lab_pin.sym} -180 610 0 0 {name=wirelabel132 lab=WL1}
N 0 960 1500 960 {lab=Y}
C {devices/lab_pin.sym} 1500 960 2 0 {name=wirelabel134 lab=Y}
N 500 1020 1500 1020 {lab=YB}
C {devices/lab_pin.sym} 1500 1020 2 0 {name=wirelabel136 lab=YB}
T {NMOS COLUMN MUX} 1550 790 0 0 0.3 0.3 {}
T {COMMON BITLINES} 1550 950 0 0 0.3 0.3 {}
T {SHARED PRECHARGE / WRITE} -180 1100 0 0 0.3 0.3 {}
N 50 960 50 1320 {lab=Y}
N 50 1320 150 1320 {lab=Y}
C {TR-1umLIB/MP.sym} 110 1170 0 0 {name=XPY0
model=PMOS
w=10.2u
l=1u
m=1
spiceprefix=X
nrd=0
nrs=0}
N 150 1200 150 1320 {lab=Y}
N 150 1100 150 1140 {lab=VDD}
C {devices/lab_pin.sym} 150 1100 0 0 {name=wirelabel145 lab=VDD}
N 150 1170 250 1170 {lab=VDD}
N 250 1100 250 1170 {lab=VDD}
N 150 1100 250 1100 {lab=VDD}
C {devices/lab_pin.sym} 110 1170 0 0 {name=wirelabel149 lab=YPREB}
C {TR-1umLIB/MN.sym} 110 1510 0 0 {name=XWY0
model=NMOS
w=3.4u
l=1u
m=1
spiceprefix=X
nrd=0
nrs=0}
N 150 1320 150 1480 {lab=Y}
C {devices/lab_pin.sym} 110 1510 0 0 {name=wirelabel152 lab=PD_Y}
N 150 1510 230 1510 {lab=GND}
N 230 1510 230 1620 {lab=GND}
N 150 1540 150 1620 {lab=GND}
N 150 1320 320 1320 {lab=Y}
N 320 1320 320 1480 {lab=Y}
C {devices/capa.sym} 320 1510 0 0 {name=CY value='CY' m=1}
N 320 1540 320 1620 {lab=GND}
N 320 1320 1000 1320 {lab=Y}
N 550 1020 550 1380 {lab=YB}
N 550 1380 650 1380 {lab=YB}
C {TR-1umLIB/MP.sym} 610 1170 0 0 {name=XPY1
model=PMOS
w=10.2u
l=1u
m=1
spiceprefix=X
nrd=0
nrs=0}
N 650 1200 650 1380 {lab=YB}
N 650 1100 650 1140 {lab=VDD}
C {devices/lab_pin.sym} 650 1100 0 0 {name=wirelabel166 lab=VDD}
N 650 1170 750 1170 {lab=VDD}
N 750 1100 750 1170 {lab=VDD}
N 650 1100 750 1100 {lab=VDD}
C {devices/lab_pin.sym} 610 1170 0 0 {name=wirelabel170 lab=YPREB}
C {TR-1umLIB/MN.sym} 610 1510 0 0 {name=XWY1
model=NMOS
w=3.4u
l=1u
m=1
spiceprefix=X
nrd=0
nrs=0}
N 650 1380 650 1480 {lab=YB}
C {devices/lab_pin.sym} 610 1510 0 0 {name=wirelabel173 lab=PD_YB}
N 650 1510 730 1510 {lab=GND}
N 730 1510 730 1620 {lab=GND}
N 650 1540 650 1620 {lab=GND}
N 650 1380 820 1380 {lab=YB}
N 820 1380 820 1480 {lab=YB}
C {devices/capa.sym} 820 1510 0 0 {name=CYB value='CY' m=1}
N 820 1540 820 1620 {lab=GND}
N 820 1380 1000 1380 {lab=YB}
N 150 1620 820 1620 {lab=GND}
C {devices/gnd.sym} 150 1620 0 0 {name=ground183 lab=GND}
C {sense_amp_7t.sym} 1150 1380 0 0 {name=xsa}
C {devices/lab_pin.sym} 1000 1440 0 0 {name=wirelabel185 lab=SAE}
C {devices/lab_pin.sym} 1150 1260 0 0 {name=wirelabel186 lab=VDD}
C {devices/gnd.sym} 1150 1500 0 0 {name=ground187 lab=GND}
N 1300 1320 1500 1320 {lab=SOUT}
C {devices/lab_pin.sym} 1500 1320 2 0 {name=wirelabel189 lab=SOUT}
N 1500 1320 1500 1500 {lab=SOUT}
C {devices/capa.sym} 1500 1530 0 0 {name=CSOUT value=10f m=1}
C {devices/gnd.sym} 1500 1560 0 0 {name=ground192 lab=GND}
N 1300 1380 1720 1380 {lab=SOUTB}
C {devices/lab_pin.sym} 1720 1380 2 0 {name=wirelabel194 lab=SOUTB}
N 1720 1380 1720 1500 {lab=SOUTB}
C {devices/capa.sym} 1720 1530 0 0 {name=CSOUTB value=10f m=1}
C {devices/gnd.sym} 1720 1560 0 0 {name=ground197 lab=GND}
T {7T SENSE AMPLIFIER} 1030 1160 0 0 0.3 0.3 {}
T {SAE=0: track/reset; SAE=1: isolate/regenerate} 1000 1670 0 0 0.27 0.27 {}
T {CBL=10f per local line / CY=100f per common line / outputs=10f} -180 1720 0 0 0.27 0.27 {}
T {Assumed learning loads, not extracted parasitics.} -180 1760 0 0 0.27 0.27 {}
T {IDEAL CONTROLS: edit PWL sources with q (decoder/control logic not included)} -120 1830 0 0 0.3 0.3 {}
C {devices/vsource.sym} 0 1970 0 0 {name=VVDD
value="5"
savecurrent=false
hide_texts=true}
C {devices/lab_pin.sym} 0 1940 2 0 {name=l187 lab=VDD}
C {devices/gnd.sym} 0 2000 0 0 {name=gs0 lab=GND}
T {5 V} 50 1970 0 0 0.25 0.25 {}
C {devices/vsource.sym} 520 1970 0 0 {name=VPREB
value="PWL(0n 0 40n 0 41n 5 200n 5 201n 0 240n 0 241n 5 400n 5 401n 0 440n 0 441n 5 600n 5 601n 0 640n 0 641n 5 800n 5 801n 0 840n 0 841n 5 1000n 5 1001n 0 1040n 0 1041n 5 1200n 5 1201n 0 1240n 0 1241n 5 1400n 5 1401n 0 1440n 0 1441n 5 1600n 5 1601n 0 1640n 0 1641n 5 1800n 5 1801n 0 1840n 0 1841n 5 2000n 5 2001n 0 2040n 0 2041n 5 2200n 5 2201n 0 2240n 0 2241n 5 2400n 5 2401n 0 2440n 0 2441n 5 2600n 5 2601n 0 2640n 0 2641n 5 2800n 5 2801n 0 2840n 0 2841n 5 3000n 5 3001n 0 3040n 0 3041n 5 3200n 5)"
savecurrent=false
hide_texts=true}
C {devices/lab_pin.sym} 520 1940 2 0 {name=l191 lab=PREB}
C {devices/gnd.sym} 520 2000 0 0 {name=gs1 lab=GND}
T {PWL} 570 1970 0 0 0.25 0.25 {}
C {devices/vsource.sym} 1040 1970 0 0 {name=VYPREB
value="PWL(0n 5 1n 5 2n 0 40n 0 41n 5 201n 5 202n 0 240n 0 241n 5 401n 5 402n 0 440n 0 441n 5 601n 5 602n 0 640n 0 641n 5 801n 5 802n 0 840n 0 841n 5 1001n 5 1002n 0 1040n 0 1041n 5 1201n 5 1202n 0 1240n 0 1241n 5 1401n 5 1402n 0 1440n 0 1441n 5 1601n 5 1602n 0 1640n 0 1641n 5 1801n 5 1802n 0 1840n 0 1841n 5 2001n 5 2002n 0 2040n 0 2041n 5 2201n 5 2202n 0 2240n 0 2241n 5 2401n 5 2402n 0 2440n 0 2441n 5 2601n 5 2602n 0 2640n 0 2641n 5 2801n 5 2802n 0 2840n 0 2841n 5 3001n 5 3002n 0 3040n 0 3041n 5 3200n 5)"
savecurrent=false
hide_texts=true}
C {devices/lab_pin.sym} 1040 1940 2 0 {name=l195 lab=YPREB}
C {devices/gnd.sym} 1040 2000 0 0 {name=gs2 lab=GND}
T {PWL} 1090 1970 0 0 0.25 0.25 {}
C {devices/vsource.sym} 1560 1970 0 0 {name=VWL0
value="PWL(0n 0 70n 0 71n 5 140n 5 141n 0 270n 0 271n 5 340n 5 341n 0 870n 0 871n 5 940n 5 941n 0 1070n 0 1071n 5 1140n 5 1141n 0 1670n 0 1671n 5 1740n 5 1741n 0 1870n 0 1871n 5 1940n 5 1941n 0 2470n 0 2471n 5 2540n 5 2541n 0 2670n 0 2671n 5 2740n 5 2741n 0 3200n 0)"
savecurrent=false
hide_texts=true}
C {devices/lab_pin.sym} 1560 1940 2 0 {name=l199 lab=WL0}
C {devices/gnd.sym} 1560 2000 0 0 {name=gs3 lab=GND}
T {PWL} 1610 1970 0 0 0.25 0.25 {}
C {devices/vsource.sym} 2080 1970 0 0 {name=VWL1
value="PWL(0n 0 470n 0 471n 5 540n 5 541n 0 670n 0 671n 5 740n 5 741n 0 1270n 0 1271n 5 1340n 5 1341n 0 1470n 0 1471n 5 1540n 5 1541n 0 2070n 0 2071n 5 2140n 5 2141n 0 2270n 0 2271n 5 2340n 5 2341n 0 2870n 0 2871n 5 2940n 5 2941n 0 3070n 0 3071n 5 3140n 5 3141n 0 3200n 0)"
savecurrent=false
hide_texts=true}
C {devices/lab_pin.sym} 2080 1940 2 0 {name=l203 lab=WL1}
C {devices/gnd.sym} 2080 2000 0 0 {name=gs4 lab=GND}
T {PWL} 2130 1970 0 0 0.25 0.25 {}
C {devices/vsource.sym} 0 2200 0 0 {name=VCOL0
value="PWL(0n 0 45n 0 46n 5 170n 5 171n 0 445n 0 446n 5 570n 5 571n 0 845n 0 846n 5 970n 5 971n 0 1245n 0 1246n 5 1370n 5 1371n 0 1645n 0 1646n 5 1770n 5 1771n 0 2045n 0 2046n 5 2170n 5 2171n 0 2445n 0 2446n 5 2570n 5 2571n 0 2845n 0 2846n 5 2970n 5 2971n 0 3200n 0)"
savecurrent=false
hide_texts=true}
C {devices/lab_pin.sym} 0 2170 2 0 {name=l207 lab=COL0}
C {devices/gnd.sym} 0 2230 0 0 {name=gs5 lab=GND}
T {PWL} 50 2200 0 0 0.25 0.25 {}
C {devices/vsource.sym} 520 2200 0 0 {name=VCOL1
value="PWL(0n 0 245n 0 246n 5 370n 5 371n 0 645n 0 646n 5 770n 5 771n 0 1045n 0 1046n 5 1170n 5 1171n 0 1445n 0 1446n 5 1570n 5 1571n 0 1845n 0 1846n 5 1970n 5 1971n 0 2245n 0 2246n 5 2370n 5 2371n 0 2645n 0 2646n 5 2770n 5 2771n 0 3045n 0 3046n 5 3170n 5 3171n 0 3200n 0)"
savecurrent=false
hide_texts=true}
C {devices/lab_pin.sym} 520 2170 2 0 {name=l211 lab=COL1}
C {devices/gnd.sym} 520 2230 0 0 {name=gs6 lab=GND}
T {PWL} 570 2200 0 0 0.25 0.25 {}
C {devices/vsource.sym} 1040 2200 0 0 {name=VPD_Y
value="PWL(0n 0 50n 0 51n 5 155n 5 156n 0 650n 0 651n 5 755n 5 756n 0 1850n 0 1851n 5 1955n 5 1956n 0 2050n 0 2051n 5 2155n 5 2156n 0 3200n 0)"
savecurrent=false
hide_texts=true}
C {devices/lab_pin.sym} 1040 2170 2 0 {name=l215 lab=PD_Y}
C {devices/gnd.sym} 1040 2230 0 0 {name=gs7 lab=GND}
T {PWL} 1090 2200 0 0 0.25 0.25 {}
C {devices/vsource.sym} 1560 2200 0 0 {name=VPD_YB
value="PWL(0n 0 250n 0 251n 5 355n 5 356n 0 450n 0 451n 5 555n 5 556n 0 1650n 0 1651n 5 1755n 5 1756n 0 2250n 0 2251n 5 2355n 5 2356n 0 3200n 0)"
savecurrent=false
hide_texts=true}
C {devices/lab_pin.sym} 1560 2170 2 0 {name=l219 lab=PD_YB}
C {devices/gnd.sym} 1560 2230 0 0 {name=gs8 lab=GND}
T {PWL} 1610 2200 0 0 0.25 0.25 {}
C {devices/vsource.sym} 2080 2200 0 0 {name=VSAE
value="PWL(0n 5 801n 5 802n 0 890n 0 891n 5 1001n 5 1002n 0 1090n 0 1091n 5 1201n 5 1202n 0 1290n 0 1291n 5 1401n 5 1402n 0 1490n 0 1491n 5 2401n 5 2402n 0 2490n 0 2491n 5 2601n 5 2602n 0 2690n 0 2691n 5 2801n 5 2802n 0 2890n 0 2891n 5 3001n 5 3002n 0 3090n 0 3091n 5 3200n 5)"
savecurrent=false
hide_texts=true}
C {devices/lab_pin.sym} 2080 2170 2 0 {name=l223 lab=SAE}
C {devices/gnd.sym} 2080 2230 0 0 {name=gs9 lab=GND}
T {PWL} 2130 2200 0 0 0.25 0.25 {}
T {SEQUENCE / each cycle = 200 ns} 2200 -200 0 0 0.27 0.27 {}
T {   0: W row 0, col 0 = 0} 2200 -164 0 0 0.27 0.27 {}
T { 200: W row 0, col 1 = 1} 2200 -128 0 0 0.27 0.27 {}
T { 400: W row 1, col 0 = 1} 2200 -92 0 0 0.27 0.27 {}
T { 600: W row 1, col 1 = 0} 2200 -56 0 0 0.27 0.27 {}
T { 800: R row 0, col 0 = 0} 2200 -20 0 0 0.27 0.27 {}
T {1000: R row 0, col 1 = 1} 2200 16 0 0 0.27 0.27 {}
T {1200: R row 1, col 0 = 1} 2200 52 0 0 0.27 0.27 {}
T {1400: R row 1, col 1 = 0} 2200 88 0 0 0.27 0.27 {}
T {1600: W row 0, col 0 = 1} 2200 124 0 0 0.27 0.27 {}
T {1800: W row 0, col 1 = 0} 2200 160 0 0 0.27 0.27 {}
T {2000: W row 1, col 0 = 0} 2200 196 0 0 0.27 0.27 {}
T {2200: W row 1, col 1 = 1} 2200 232 0 0 0.27 0.27 {}
T {2400: R row 0, col 0 = 1} 2200 268 0 0 0.27 0.27 {}
T {2600: R row 0, col 1 = 0} 2200 304 0 0 0.27 0.27 {}
T {2800: R row 1, col 0 = 0} 2200 340 0 0 0.27 0.27 {}
T {3000: R row 1, col 1 = 1} 2200 376 0 0 0.27 0.27 {}
T {} 2200 412 0 0 0.27 0.27 {}
T {WITHIN EACH CYCLE (relative ns)} 2200 448 0 0 0.27 0.27 {}
T {0 - 40: all local bitlines precharge; WL/COL LOW} 2200 484 0 0 0.27 0.27 {}
T {Y/YB precharge every cycle; SAE LOW only on read} 2200 520 0 0 0.27 0.27 {}
T {40 - 41: precharge OFF} 2200 556 0 0 0.27 0.27 {}
T {45 - 46: selected COL rises} 2200 592 0 0 0.27 0.27 {}
T {Write: 50 - 51 pull-down ON} 2200 628 0 0 0.27 0.27 {}
T {70 - 71: selected WL rises} 2200 664 0 0 0.27 0.27 {}
T {Read: 90 - 91 SAE rises} 2200 700 0 0 0.27 0.27 {}
T {140 - 141: WL returns LOW} 2200 736 0 0 0.27 0.27 {}
T {Read: 150 check SOUT / SOUTB} 2200 772 0 0 0.27 0.27 {}
T {Write: 155 - 156 pull-down OFF} 2200 808 0 0 0.27 0.27 {}
T {170 - 171: COL returns LOW} 2200 844 0 0 0.27 0.27 {}
T {190: verify all four Q / QB pairs} 2200 880 0 0 0.27 0.27 {}
T {} 2200 916 0 0 0.27 0.27 {}
T {Other column on selected row is half-selected.} 2200 952 0 0 0.27 0.27 {}
T {Check its retention throughout WL HIGH.} 2200 988 0 0 0.27 0.27 {}
T {SAE stays HIGH during writes.} 2200 1024 0 0 0.27 0.27 {}
C {devices/code.sym} 2250 1710 0 0 {name=TR_1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"}
C {devices/code.sym} 2620 1710 0 0 {name=SIMULATION
only_toplevel=true
value=".param CBL=10f CY=100f
.ic v(Q00)=0 v(QB00)=5 v(Q01)=0 v(QB01)=5 v(Q10)=0 v(QB10)=5 v(Q11)=0 v(QB11)=5
.control
save all
tran 0.1n 3200n
let failures = 0
let ydiff = v(Y)-v(YB)
meas tran h_0_Q00 find v(Q00) at=190n
if h_0_Q00 > 0.5
 let failures = failures + 1
end
meas tran h_0_QB00 find v(QB00) at=190n
if h_0_QB00 < 4.5
 let failures = failures + 1
end
meas tran h_0_Q01 find v(Q01) at=190n
if h_0_Q01 > 0.5
 let failures = failures + 1
end
meas tran keep_0_Q01 max v(Q01) from=69n to=142n
if keep_0_Q01 > 2.5
 let failures = failures + 1
end
meas tran h_0_QB01 find v(QB01) at=190n
if h_0_QB01 < 4.5
 let failures = failures + 1
end
meas tran keep_0_QB01 min v(QB01) from=69n to=142n
if keep_0_QB01 < 2.5
 let failures = failures + 1
end
meas tran h_0_Q10 find v(Q10) at=190n
if h_0_Q10 > 0.5
 let failures = failures + 1
end
meas tran keep_0_Q10 max v(Q10) from=69n to=142n
if keep_0_Q10 > 2.5
 let failures = failures + 1
end
meas tran h_0_QB10 find v(QB10) at=190n
if h_0_QB10 < 4.5
 let failures = failures + 1
end
meas tran keep_0_QB10 min v(QB10) from=69n to=142n
if keep_0_QB10 < 2.5
 let failures = failures + 1
end
meas tran h_0_Q11 find v(Q11) at=190n
if h_0_Q11 > 0.5
 let failures = failures + 1
end
meas tran keep_0_Q11 max v(Q11) from=69n to=142n
if keep_0_Q11 > 2.5
 let failures = failures + 1
end
meas tran h_0_QB11 find v(QB11) at=190n
if h_0_QB11 < 4.5
 let failures = failures + 1
end
meas tran keep_0_QB11 min v(QB11) from=69n to=142n
if keep_0_QB11 < 2.5
 let failures = failures + 1
end
meas tran h_1_Q00 find v(Q00) at=390n
if h_1_Q00 > 0.5
 let failures = failures + 1
end
meas tran keep_1_Q00 max v(Q00) from=269n to=342n
if keep_1_Q00 > 2.5
 let failures = failures + 1
end
meas tran h_1_QB00 find v(QB00) at=390n
if h_1_QB00 < 4.5
 let failures = failures + 1
end
meas tran keep_1_QB00 min v(QB00) from=269n to=342n
if keep_1_QB00 < 2.5
 let failures = failures + 1
end
meas tran h_1_Q01 find v(Q01) at=390n
if h_1_Q01 < 4.5
 let failures = failures + 1
end
meas tran h_1_QB01 find v(QB01) at=390n
if h_1_QB01 > 0.5
 let failures = failures + 1
end
meas tran h_1_Q10 find v(Q10) at=390n
if h_1_Q10 > 0.5
 let failures = failures + 1
end
meas tran keep_1_Q10 max v(Q10) from=269n to=342n
if keep_1_Q10 > 2.5
 let failures = failures + 1
end
meas tran h_1_QB10 find v(QB10) at=390n
if h_1_QB10 < 4.5
 let failures = failures + 1
end
meas tran keep_1_QB10 min v(QB10) from=269n to=342n
if keep_1_QB10 < 2.5
 let failures = failures + 1
end
meas tran h_1_Q11 find v(Q11) at=390n
if h_1_Q11 > 0.5
 let failures = failures + 1
end
meas tran keep_1_Q11 max v(Q11) from=269n to=342n
if keep_1_Q11 > 2.5
 let failures = failures + 1
end
meas tran h_1_QB11 find v(QB11) at=390n
if h_1_QB11 < 4.5
 let failures = failures + 1
end
meas tran keep_1_QB11 min v(QB11) from=269n to=342n
if keep_1_QB11 < 2.5
 let failures = failures + 1
end
meas tran h_2_Q00 find v(Q00) at=590n
if h_2_Q00 > 0.5
 let failures = failures + 1
end
meas tran keep_2_Q00 max v(Q00) from=469n to=542n
if keep_2_Q00 > 2.5
 let failures = failures + 1
end
meas tran h_2_QB00 find v(QB00) at=590n
if h_2_QB00 < 4.5
 let failures = failures + 1
end
meas tran keep_2_QB00 min v(QB00) from=469n to=542n
if keep_2_QB00 < 2.5
 let failures = failures + 1
end
meas tran h_2_Q01 find v(Q01) at=590n
if h_2_Q01 < 4.5
 let failures = failures + 1
end
meas tran keep_2_Q01 min v(Q01) from=469n to=542n
if keep_2_Q01 < 2.5
 let failures = failures + 1
end
meas tran h_2_QB01 find v(QB01) at=590n
if h_2_QB01 > 0.5
 let failures = failures + 1
end
meas tran keep_2_QB01 max v(QB01) from=469n to=542n
if keep_2_QB01 > 2.5
 let failures = failures + 1
end
meas tran h_2_Q10 find v(Q10) at=590n
if h_2_Q10 < 4.5
 let failures = failures + 1
end
meas tran h_2_QB10 find v(QB10) at=590n
if h_2_QB10 > 0.5
 let failures = failures + 1
end
meas tran h_2_Q11 find v(Q11) at=590n
if h_2_Q11 > 0.5
 let failures = failures + 1
end
meas tran keep_2_Q11 max v(Q11) from=469n to=542n
if keep_2_Q11 > 2.5
 let failures = failures + 1
end
meas tran h_2_QB11 find v(QB11) at=590n
if h_2_QB11 < 4.5
 let failures = failures + 1
end
meas tran keep_2_QB11 min v(QB11) from=469n to=542n
if keep_2_QB11 < 2.5
 let failures = failures + 1
end
meas tran h_3_Q00 find v(Q00) at=790n
if h_3_Q00 > 0.5
 let failures = failures + 1
end
meas tran keep_3_Q00 max v(Q00) from=669n to=742n
if keep_3_Q00 > 2.5
 let failures = failures + 1
end
meas tran h_3_QB00 find v(QB00) at=790n
if h_3_QB00 < 4.5
 let failures = failures + 1
end
meas tran keep_3_QB00 min v(QB00) from=669n to=742n
if keep_3_QB00 < 2.5
 let failures = failures + 1
end
meas tran h_3_Q01 find v(Q01) at=790n
if h_3_Q01 < 4.5
 let failures = failures + 1
end
meas tran keep_3_Q01 min v(Q01) from=669n to=742n
if keep_3_Q01 < 2.5
 let failures = failures + 1
end
meas tran h_3_QB01 find v(QB01) at=790n
if h_3_QB01 > 0.5
 let failures = failures + 1
end
meas tran keep_3_QB01 max v(QB01) from=669n to=742n
if keep_3_QB01 > 2.5
 let failures = failures + 1
end
meas tran h_3_Q10 find v(Q10) at=790n
if h_3_Q10 < 4.5
 let failures = failures + 1
end
meas tran keep_3_Q10 min v(Q10) from=669n to=742n
if keep_3_Q10 < 2.5
 let failures = failures + 1
end
meas tran h_3_QB10 find v(QB10) at=790n
if h_3_QB10 > 0.5
 let failures = failures + 1
end
meas tran keep_3_QB10 max v(QB10) from=669n to=742n
if keep_3_QB10 > 2.5
 let failures = failures + 1
end
meas tran h_3_Q11 find v(Q11) at=790n
if h_3_Q11 > 0.5
 let failures = failures + 1
end
meas tran h_3_QB11 find v(QB11) at=790n
if h_3_QB11 < 4.5
 let failures = failures + 1
end
meas tran h_4_Q00 find v(Q00) at=990n
if h_4_Q00 > 0.5
 let failures = failures + 1
end
meas tran keep_4_Q00 max v(Q00) from=869n to=942n
if keep_4_Q00 > 2.5
 let failures = failures + 1
end
meas tran h_4_QB00 find v(QB00) at=990n
if h_4_QB00 < 4.5
 let failures = failures + 1
end
meas tran keep_4_QB00 min v(QB00) from=869n to=942n
if keep_4_QB00 < 2.5
 let failures = failures + 1
end
meas tran h_4_Q01 find v(Q01) at=990n
if h_4_Q01 < 4.5
 let failures = failures + 1
end
meas tran keep_4_Q01 min v(Q01) from=869n to=942n
if keep_4_Q01 < 2.5
 let failures = failures + 1
end
meas tran h_4_QB01 find v(QB01) at=990n
if h_4_QB01 > 0.5
 let failures = failures + 1
end
meas tran keep_4_QB01 max v(QB01) from=869n to=942n
if keep_4_QB01 > 2.5
 let failures = failures + 1
end
meas tran h_4_Q10 find v(Q10) at=990n
if h_4_Q10 < 4.5
 let failures = failures + 1
end
meas tran keep_4_Q10 min v(Q10) from=869n to=942n
if keep_4_Q10 < 2.5
 let failures = failures + 1
end
meas tran h_4_QB10 find v(QB10) at=990n
if h_4_QB10 > 0.5
 let failures = failures + 1
end
meas tran keep_4_QB10 max v(QB10) from=869n to=942n
if keep_4_QB10 > 2.5
 let failures = failures + 1
end
meas tran h_4_Q11 find v(Q11) at=990n
if h_4_Q11 > 0.5
 let failures = failures + 1
end
meas tran keep_4_Q11 max v(Q11) from=869n to=942n
if keep_4_Q11 > 2.5
 let failures = failures + 1
end
meas tran h_4_QB11 find v(QB11) at=990n
if h_4_QB11 < 4.5
 let failures = failures + 1
end
meas tran keep_4_QB11 min v(QB11) from=869n to=942n
if keep_4_QB11 < 2.5
 let failures = failures + 1
end
meas tran reset_4_SOUT find v(SOUT) at=839n
if reset_4_SOUT < 4.5
 let failures = failures + 1
end
meas tran read_4_SOUT find v(SOUT) at=950n
if read_4_SOUT > 0.5
 let failures = failures + 1
end
meas tran reset_4_SOUTB find v(SOUTB) at=839n
if reset_4_SOUTB < 4.5
 let failures = failures + 1
end
meas tran read_4_SOUTB find v(SOUTB) at=950n
if read_4_SOUTB < 4.5
 let failures = failures + 1
end
meas tran diff_4 find ydiff at=890n
meas tran h_5_Q00 find v(Q00) at=1190n
if h_5_Q00 > 0.5
 let failures = failures + 1
end
meas tran keep_5_Q00 max v(Q00) from=1069n to=1142n
if keep_5_Q00 > 2.5
 let failures = failures + 1
end
meas tran h_5_QB00 find v(QB00) at=1190n
if h_5_QB00 < 4.5
 let failures = failures + 1
end
meas tran keep_5_QB00 min v(QB00) from=1069n to=1142n
if keep_5_QB00 < 2.5
 let failures = failures + 1
end
meas tran h_5_Q01 find v(Q01) at=1190n
if h_5_Q01 < 4.5
 let failures = failures + 1
end
meas tran keep_5_Q01 min v(Q01) from=1069n to=1142n
if keep_5_Q01 < 2.5
 let failures = failures + 1
end
meas tran h_5_QB01 find v(QB01) at=1190n
if h_5_QB01 > 0.5
 let failures = failures + 1
end
meas tran keep_5_QB01 max v(QB01) from=1069n to=1142n
if keep_5_QB01 > 2.5
 let failures = failures + 1
end
meas tran h_5_Q10 find v(Q10) at=1190n
if h_5_Q10 < 4.5
 let failures = failures + 1
end
meas tran keep_5_Q10 min v(Q10) from=1069n to=1142n
if keep_5_Q10 < 2.5
 let failures = failures + 1
end
meas tran h_5_QB10 find v(QB10) at=1190n
if h_5_QB10 > 0.5
 let failures = failures + 1
end
meas tran keep_5_QB10 max v(QB10) from=1069n to=1142n
if keep_5_QB10 > 2.5
 let failures = failures + 1
end
meas tran h_5_Q11 find v(Q11) at=1190n
if h_5_Q11 > 0.5
 let failures = failures + 1
end
meas tran keep_5_Q11 max v(Q11) from=1069n to=1142n
if keep_5_Q11 > 2.5
 let failures = failures + 1
end
meas tran h_5_QB11 find v(QB11) at=1190n
if h_5_QB11 < 4.5
 let failures = failures + 1
end
meas tran keep_5_QB11 min v(QB11) from=1069n to=1142n
if keep_5_QB11 < 2.5
 let failures = failures + 1
end
meas tran reset_5_SOUT find v(SOUT) at=1039n
if reset_5_SOUT < 4.5
 let failures = failures + 1
end
meas tran read_5_SOUT find v(SOUT) at=1150n
if read_5_SOUT < 4.5
 let failures = failures + 1
end
meas tran reset_5_SOUTB find v(SOUTB) at=1039n
if reset_5_SOUTB < 4.5
 let failures = failures + 1
end
meas tran read_5_SOUTB find v(SOUTB) at=1150n
if read_5_SOUTB > 0.5
 let failures = failures + 1
end
meas tran diff_5 find ydiff at=1090n
meas tran h_6_Q00 find v(Q00) at=1390n
if h_6_Q00 > 0.5
 let failures = failures + 1
end
meas tran keep_6_Q00 max v(Q00) from=1269n to=1342n
if keep_6_Q00 > 2.5
 let failures = failures + 1
end
meas tran h_6_QB00 find v(QB00) at=1390n
if h_6_QB00 < 4.5
 let failures = failures + 1
end
meas tran keep_6_QB00 min v(QB00) from=1269n to=1342n
if keep_6_QB00 < 2.5
 let failures = failures + 1
end
meas tran h_6_Q01 find v(Q01) at=1390n
if h_6_Q01 < 4.5
 let failures = failures + 1
end
meas tran keep_6_Q01 min v(Q01) from=1269n to=1342n
if keep_6_Q01 < 2.5
 let failures = failures + 1
end
meas tran h_6_QB01 find v(QB01) at=1390n
if h_6_QB01 > 0.5
 let failures = failures + 1
end
meas tran keep_6_QB01 max v(QB01) from=1269n to=1342n
if keep_6_QB01 > 2.5
 let failures = failures + 1
end
meas tran h_6_Q10 find v(Q10) at=1390n
if h_6_Q10 < 4.5
 let failures = failures + 1
end
meas tran keep_6_Q10 min v(Q10) from=1269n to=1342n
if keep_6_Q10 < 2.5
 let failures = failures + 1
end
meas tran h_6_QB10 find v(QB10) at=1390n
if h_6_QB10 > 0.5
 let failures = failures + 1
end
meas tran keep_6_QB10 max v(QB10) from=1269n to=1342n
if keep_6_QB10 > 2.5
 let failures = failures + 1
end
meas tran h_6_Q11 find v(Q11) at=1390n
if h_6_Q11 > 0.5
 let failures = failures + 1
end
meas tran keep_6_Q11 max v(Q11) from=1269n to=1342n
if keep_6_Q11 > 2.5
 let failures = failures + 1
end
meas tran h_6_QB11 find v(QB11) at=1390n
if h_6_QB11 < 4.5
 let failures = failures + 1
end
meas tran keep_6_QB11 min v(QB11) from=1269n to=1342n
if keep_6_QB11 < 2.5
 let failures = failures + 1
end
meas tran reset_6_SOUT find v(SOUT) at=1239n
if reset_6_SOUT < 4.5
 let failures = failures + 1
end
meas tran read_6_SOUT find v(SOUT) at=1350n
if read_6_SOUT < 4.5
 let failures = failures + 1
end
meas tran reset_6_SOUTB find v(SOUTB) at=1239n
if reset_6_SOUTB < 4.5
 let failures = failures + 1
end
meas tran read_6_SOUTB find v(SOUTB) at=1350n
if read_6_SOUTB > 0.5
 let failures = failures + 1
end
meas tran diff_6 find ydiff at=1290n
meas tran h_7_Q00 find v(Q00) at=1590n
if h_7_Q00 > 0.5
 let failures = failures + 1
end
meas tran keep_7_Q00 max v(Q00) from=1469n to=1542n
if keep_7_Q00 > 2.5
 let failures = failures + 1
end
meas tran h_7_QB00 find v(QB00) at=1590n
if h_7_QB00 < 4.5
 let failures = failures + 1
end
meas tran keep_7_QB00 min v(QB00) from=1469n to=1542n
if keep_7_QB00 < 2.5
 let failures = failures + 1
end
meas tran h_7_Q01 find v(Q01) at=1590n
if h_7_Q01 < 4.5
 let failures = failures + 1
end
meas tran keep_7_Q01 min v(Q01) from=1469n to=1542n
if keep_7_Q01 < 2.5
 let failures = failures + 1
end
meas tran h_7_QB01 find v(QB01) at=1590n
if h_7_QB01 > 0.5
 let failures = failures + 1
end
meas tran keep_7_QB01 max v(QB01) from=1469n to=1542n
if keep_7_QB01 > 2.5
 let failures = failures + 1
end
meas tran h_7_Q10 find v(Q10) at=1590n
if h_7_Q10 < 4.5
 let failures = failures + 1
end
meas tran keep_7_Q10 min v(Q10) from=1469n to=1542n
if keep_7_Q10 < 2.5
 let failures = failures + 1
end
meas tran h_7_QB10 find v(QB10) at=1590n
if h_7_QB10 > 0.5
 let failures = failures + 1
end
meas tran keep_7_QB10 max v(QB10) from=1469n to=1542n
if keep_7_QB10 > 2.5
 let failures = failures + 1
end
meas tran h_7_Q11 find v(Q11) at=1590n
if h_7_Q11 > 0.5
 let failures = failures + 1
end
meas tran keep_7_Q11 max v(Q11) from=1469n to=1542n
if keep_7_Q11 > 2.5
 let failures = failures + 1
end
meas tran h_7_QB11 find v(QB11) at=1590n
if h_7_QB11 < 4.5
 let failures = failures + 1
end
meas tran keep_7_QB11 min v(QB11) from=1469n to=1542n
if keep_7_QB11 < 2.5
 let failures = failures + 1
end
meas tran reset_7_SOUT find v(SOUT) at=1439n
if reset_7_SOUT < 4.5
 let failures = failures + 1
end
meas tran read_7_SOUT find v(SOUT) at=1550n
if read_7_SOUT > 0.5
 let failures = failures + 1
end
meas tran reset_7_SOUTB find v(SOUTB) at=1439n
if reset_7_SOUTB < 4.5
 let failures = failures + 1
end
meas tran read_7_SOUTB find v(SOUTB) at=1550n
if read_7_SOUTB < 4.5
 let failures = failures + 1
end
meas tran diff_7 find ydiff at=1490n
meas tran h_8_Q00 find v(Q00) at=1790n
if h_8_Q00 < 4.5
 let failures = failures + 1
end
meas tran h_8_QB00 find v(QB00) at=1790n
if h_8_QB00 > 0.5
 let failures = failures + 1
end
meas tran h_8_Q01 find v(Q01) at=1790n
if h_8_Q01 < 4.5
 let failures = failures + 1
end
meas tran keep_8_Q01 min v(Q01) from=1669n to=1742n
if keep_8_Q01 < 2.5
 let failures = failures + 1
end
meas tran h_8_QB01 find v(QB01) at=1790n
if h_8_QB01 > 0.5
 let failures = failures + 1
end
meas tran keep_8_QB01 max v(QB01) from=1669n to=1742n
if keep_8_QB01 > 2.5
 let failures = failures + 1
end
meas tran h_8_Q10 find v(Q10) at=1790n
if h_8_Q10 < 4.5
 let failures = failures + 1
end
meas tran keep_8_Q10 min v(Q10) from=1669n to=1742n
if keep_8_Q10 < 2.5
 let failures = failures + 1
end
meas tran h_8_QB10 find v(QB10) at=1790n
if h_8_QB10 > 0.5
 let failures = failures + 1
end
meas tran keep_8_QB10 max v(QB10) from=1669n to=1742n
if keep_8_QB10 > 2.5
 let failures = failures + 1
end
meas tran h_8_Q11 find v(Q11) at=1790n
if h_8_Q11 > 0.5
 let failures = failures + 1
end
meas tran keep_8_Q11 max v(Q11) from=1669n to=1742n
if keep_8_Q11 > 2.5
 let failures = failures + 1
end
meas tran h_8_QB11 find v(QB11) at=1790n
if h_8_QB11 < 4.5
 let failures = failures + 1
end
meas tran keep_8_QB11 min v(QB11) from=1669n to=1742n
if keep_8_QB11 < 2.5
 let failures = failures + 1
end
meas tran h_9_Q00 find v(Q00) at=1990n
if h_9_Q00 < 4.5
 let failures = failures + 1
end
meas tran keep_9_Q00 min v(Q00) from=1869n to=1942n
if keep_9_Q00 < 2.5
 let failures = failures + 1
end
meas tran h_9_QB00 find v(QB00) at=1990n
if h_9_QB00 > 0.5
 let failures = failures + 1
end
meas tran keep_9_QB00 max v(QB00) from=1869n to=1942n
if keep_9_QB00 > 2.5
 let failures = failures + 1
end
meas tran h_9_Q01 find v(Q01) at=1990n
if h_9_Q01 > 0.5
 let failures = failures + 1
end
meas tran h_9_QB01 find v(QB01) at=1990n
if h_9_QB01 < 4.5
 let failures = failures + 1
end
meas tran h_9_Q10 find v(Q10) at=1990n
if h_9_Q10 < 4.5
 let failures = failures + 1
end
meas tran keep_9_Q10 min v(Q10) from=1869n to=1942n
if keep_9_Q10 < 2.5
 let failures = failures + 1
end
meas tran h_9_QB10 find v(QB10) at=1990n
if h_9_QB10 > 0.5
 let failures = failures + 1
end
meas tran keep_9_QB10 max v(QB10) from=1869n to=1942n
if keep_9_QB10 > 2.5
 let failures = failures + 1
end
meas tran h_9_Q11 find v(Q11) at=1990n
if h_9_Q11 > 0.5
 let failures = failures + 1
end
meas tran keep_9_Q11 max v(Q11) from=1869n to=1942n
if keep_9_Q11 > 2.5
 let failures = failures + 1
end
meas tran h_9_QB11 find v(QB11) at=1990n
if h_9_QB11 < 4.5
 let failures = failures + 1
end
meas tran keep_9_QB11 min v(QB11) from=1869n to=1942n
if keep_9_QB11 < 2.5
 let failures = failures + 1
end
meas tran h_10_Q00 find v(Q00) at=2190n
if h_10_Q00 < 4.5
 let failures = failures + 1
end
meas tran keep_10_Q00 min v(Q00) from=2069n to=2142n
if keep_10_Q00 < 2.5
 let failures = failures + 1
end
meas tran h_10_QB00 find v(QB00) at=2190n
if h_10_QB00 > 0.5
 let failures = failures + 1
end
meas tran keep_10_QB00 max v(QB00) from=2069n to=2142n
if keep_10_QB00 > 2.5
 let failures = failures + 1
end
meas tran h_10_Q01 find v(Q01) at=2190n
if h_10_Q01 > 0.5
 let failures = failures + 1
end
meas tran keep_10_Q01 max v(Q01) from=2069n to=2142n
if keep_10_Q01 > 2.5
 let failures = failures + 1
end
meas tran h_10_QB01 find v(QB01) at=2190n
if h_10_QB01 < 4.5
 let failures = failures + 1
end
meas tran keep_10_QB01 min v(QB01) from=2069n to=2142n
if keep_10_QB01 < 2.5
 let failures = failures + 1
end
meas tran h_10_Q10 find v(Q10) at=2190n
if h_10_Q10 > 0.5
 let failures = failures + 1
end
meas tran h_10_QB10 find v(QB10) at=2190n
if h_10_QB10 < 4.5
 let failures = failures + 1
end
meas tran h_10_Q11 find v(Q11) at=2190n
if h_10_Q11 > 0.5
 let failures = failures + 1
end
meas tran keep_10_Q11 max v(Q11) from=2069n to=2142n
if keep_10_Q11 > 2.5
 let failures = failures + 1
end
meas tran h_10_QB11 find v(QB11) at=2190n
if h_10_QB11 < 4.5
 let failures = failures + 1
end
meas tran keep_10_QB11 min v(QB11) from=2069n to=2142n
if keep_10_QB11 < 2.5
 let failures = failures + 1
end
meas tran h_11_Q00 find v(Q00) at=2390n
if h_11_Q00 < 4.5
 let failures = failures + 1
end
meas tran keep_11_Q00 min v(Q00) from=2269n to=2342n
if keep_11_Q00 < 2.5
 let failures = failures + 1
end
meas tran h_11_QB00 find v(QB00) at=2390n
if h_11_QB00 > 0.5
 let failures = failures + 1
end
meas tran keep_11_QB00 max v(QB00) from=2269n to=2342n
if keep_11_QB00 > 2.5
 let failures = failures + 1
end
meas tran h_11_Q01 find v(Q01) at=2390n
if h_11_Q01 > 0.5
 let failures = failures + 1
end
meas tran keep_11_Q01 max v(Q01) from=2269n to=2342n
if keep_11_Q01 > 2.5
 let failures = failures + 1
end
meas tran h_11_QB01 find v(QB01) at=2390n
if h_11_QB01 < 4.5
 let failures = failures + 1
end
meas tran keep_11_QB01 min v(QB01) from=2269n to=2342n
if keep_11_QB01 < 2.5
 let failures = failures + 1
end
meas tran h_11_Q10 find v(Q10) at=2390n
if h_11_Q10 > 0.5
 let failures = failures + 1
end
meas tran keep_11_Q10 max v(Q10) from=2269n to=2342n
if keep_11_Q10 > 2.5
 let failures = failures + 1
end
meas tran h_11_QB10 find v(QB10) at=2390n
if h_11_QB10 < 4.5
 let failures = failures + 1
end
meas tran keep_11_QB10 min v(QB10) from=2269n to=2342n
if keep_11_QB10 < 2.5
 let failures = failures + 1
end
meas tran h_11_Q11 find v(Q11) at=2390n
if h_11_Q11 < 4.5
 let failures = failures + 1
end
meas tran h_11_QB11 find v(QB11) at=2390n
if h_11_QB11 > 0.5
 let failures = failures + 1
end
meas tran h_12_Q00 find v(Q00) at=2590n
if h_12_Q00 < 4.5
 let failures = failures + 1
end
meas tran keep_12_Q00 min v(Q00) from=2469n to=2542n
if keep_12_Q00 < 2.5
 let failures = failures + 1
end
meas tran h_12_QB00 find v(QB00) at=2590n
if h_12_QB00 > 0.5
 let failures = failures + 1
end
meas tran keep_12_QB00 max v(QB00) from=2469n to=2542n
if keep_12_QB00 > 2.5
 let failures = failures + 1
end
meas tran h_12_Q01 find v(Q01) at=2590n
if h_12_Q01 > 0.5
 let failures = failures + 1
end
meas tran keep_12_Q01 max v(Q01) from=2469n to=2542n
if keep_12_Q01 > 2.5
 let failures = failures + 1
end
meas tran h_12_QB01 find v(QB01) at=2590n
if h_12_QB01 < 4.5
 let failures = failures + 1
end
meas tran keep_12_QB01 min v(QB01) from=2469n to=2542n
if keep_12_QB01 < 2.5
 let failures = failures + 1
end
meas tran h_12_Q10 find v(Q10) at=2590n
if h_12_Q10 > 0.5
 let failures = failures + 1
end
meas tran keep_12_Q10 max v(Q10) from=2469n to=2542n
if keep_12_Q10 > 2.5
 let failures = failures + 1
end
meas tran h_12_QB10 find v(QB10) at=2590n
if h_12_QB10 < 4.5
 let failures = failures + 1
end
meas tran keep_12_QB10 min v(QB10) from=2469n to=2542n
if keep_12_QB10 < 2.5
 let failures = failures + 1
end
meas tran h_12_Q11 find v(Q11) at=2590n
if h_12_Q11 < 4.5
 let failures = failures + 1
end
meas tran keep_12_Q11 min v(Q11) from=2469n to=2542n
if keep_12_Q11 < 2.5
 let failures = failures + 1
end
meas tran h_12_QB11 find v(QB11) at=2590n
if h_12_QB11 > 0.5
 let failures = failures + 1
end
meas tran keep_12_QB11 max v(QB11) from=2469n to=2542n
if keep_12_QB11 > 2.5
 let failures = failures + 1
end
meas tran reset_12_SOUT find v(SOUT) at=2439n
if reset_12_SOUT < 4.5
 let failures = failures + 1
end
meas tran read_12_SOUT find v(SOUT) at=2550n
if read_12_SOUT < 4.5
 let failures = failures + 1
end
meas tran reset_12_SOUTB find v(SOUTB) at=2439n
if reset_12_SOUTB < 4.5
 let failures = failures + 1
end
meas tran read_12_SOUTB find v(SOUTB) at=2550n
if read_12_SOUTB > 0.5
 let failures = failures + 1
end
meas tran diff_12 find ydiff at=2490n
meas tran h_13_Q00 find v(Q00) at=2790n
if h_13_Q00 < 4.5
 let failures = failures + 1
end
meas tran keep_13_Q00 min v(Q00) from=2669n to=2742n
if keep_13_Q00 < 2.5
 let failures = failures + 1
end
meas tran h_13_QB00 find v(QB00) at=2790n
if h_13_QB00 > 0.5
 let failures = failures + 1
end
meas tran keep_13_QB00 max v(QB00) from=2669n to=2742n
if keep_13_QB00 > 2.5
 let failures = failures + 1
end
meas tran h_13_Q01 find v(Q01) at=2790n
if h_13_Q01 > 0.5
 let failures = failures + 1
end
meas tran keep_13_Q01 max v(Q01) from=2669n to=2742n
if keep_13_Q01 > 2.5
 let failures = failures + 1
end
meas tran h_13_QB01 find v(QB01) at=2790n
if h_13_QB01 < 4.5
 let failures = failures + 1
end
meas tran keep_13_QB01 min v(QB01) from=2669n to=2742n
if keep_13_QB01 < 2.5
 let failures = failures + 1
end
meas tran h_13_Q10 find v(Q10) at=2790n
if h_13_Q10 > 0.5
 let failures = failures + 1
end
meas tran keep_13_Q10 max v(Q10) from=2669n to=2742n
if keep_13_Q10 > 2.5
 let failures = failures + 1
end
meas tran h_13_QB10 find v(QB10) at=2790n
if h_13_QB10 < 4.5
 let failures = failures + 1
end
meas tran keep_13_QB10 min v(QB10) from=2669n to=2742n
if keep_13_QB10 < 2.5
 let failures = failures + 1
end
meas tran h_13_Q11 find v(Q11) at=2790n
if h_13_Q11 < 4.5
 let failures = failures + 1
end
meas tran keep_13_Q11 min v(Q11) from=2669n to=2742n
if keep_13_Q11 < 2.5
 let failures = failures + 1
end
meas tran h_13_QB11 find v(QB11) at=2790n
if h_13_QB11 > 0.5
 let failures = failures + 1
end
meas tran keep_13_QB11 max v(QB11) from=2669n to=2742n
if keep_13_QB11 > 2.5
 let failures = failures + 1
end
meas tran reset_13_SOUT find v(SOUT) at=2639n
if reset_13_SOUT < 4.5
 let failures = failures + 1
end
meas tran read_13_SOUT find v(SOUT) at=2750n
if read_13_SOUT > 0.5
 let failures = failures + 1
end
meas tran reset_13_SOUTB find v(SOUTB) at=2639n
if reset_13_SOUTB < 4.5
 let failures = failures + 1
end
meas tran read_13_SOUTB find v(SOUTB) at=2750n
if read_13_SOUTB < 4.5
 let failures = failures + 1
end
meas tran diff_13 find ydiff at=2690n
meas tran h_14_Q00 find v(Q00) at=2990n
if h_14_Q00 < 4.5
 let failures = failures + 1
end
meas tran keep_14_Q00 min v(Q00) from=2869n to=2942n
if keep_14_Q00 < 2.5
 let failures = failures + 1
end
meas tran h_14_QB00 find v(QB00) at=2990n
if h_14_QB00 > 0.5
 let failures = failures + 1
end
meas tran keep_14_QB00 max v(QB00) from=2869n to=2942n
if keep_14_QB00 > 2.5
 let failures = failures + 1
end
meas tran h_14_Q01 find v(Q01) at=2990n
if h_14_Q01 > 0.5
 let failures = failures + 1
end
meas tran keep_14_Q01 max v(Q01) from=2869n to=2942n
if keep_14_Q01 > 2.5
 let failures = failures + 1
end
meas tran h_14_QB01 find v(QB01) at=2990n
if h_14_QB01 < 4.5
 let failures = failures + 1
end
meas tran keep_14_QB01 min v(QB01) from=2869n to=2942n
if keep_14_QB01 < 2.5
 let failures = failures + 1
end
meas tran h_14_Q10 find v(Q10) at=2990n
if h_14_Q10 > 0.5
 let failures = failures + 1
end
meas tran keep_14_Q10 max v(Q10) from=2869n to=2942n
if keep_14_Q10 > 2.5
 let failures = failures + 1
end
meas tran h_14_QB10 find v(QB10) at=2990n
if h_14_QB10 < 4.5
 let failures = failures + 1
end
meas tran keep_14_QB10 min v(QB10) from=2869n to=2942n
if keep_14_QB10 < 2.5
 let failures = failures + 1
end
meas tran h_14_Q11 find v(Q11) at=2990n
if h_14_Q11 < 4.5
 let failures = failures + 1
end
meas tran keep_14_Q11 min v(Q11) from=2869n to=2942n
if keep_14_Q11 < 2.5
 let failures = failures + 1
end
meas tran h_14_QB11 find v(QB11) at=2990n
if h_14_QB11 > 0.5
 let failures = failures + 1
end
meas tran keep_14_QB11 max v(QB11) from=2869n to=2942n
if keep_14_QB11 > 2.5
 let failures = failures + 1
end
meas tran reset_14_SOUT find v(SOUT) at=2839n
if reset_14_SOUT < 4.5
 let failures = failures + 1
end
meas tran read_14_SOUT find v(SOUT) at=2950n
if read_14_SOUT > 0.5
 let failures = failures + 1
end
meas tran reset_14_SOUTB find v(SOUTB) at=2839n
if reset_14_SOUTB < 4.5
 let failures = failures + 1
end
meas tran read_14_SOUTB find v(SOUTB) at=2950n
if read_14_SOUTB < 4.5
 let failures = failures + 1
end
meas tran diff_14 find ydiff at=2890n
meas tran h_15_Q00 find v(Q00) at=3190n
if h_15_Q00 < 4.5
 let failures = failures + 1
end
meas tran keep_15_Q00 min v(Q00) from=3069n to=3142n
if keep_15_Q00 < 2.5
 let failures = failures + 1
end
meas tran h_15_QB00 find v(QB00) at=3190n
if h_15_QB00 > 0.5
 let failures = failures + 1
end
meas tran keep_15_QB00 max v(QB00) from=3069n to=3142n
if keep_15_QB00 > 2.5
 let failures = failures + 1
end
meas tran h_15_Q01 find v(Q01) at=3190n
if h_15_Q01 > 0.5
 let failures = failures + 1
end
meas tran keep_15_Q01 max v(Q01) from=3069n to=3142n
if keep_15_Q01 > 2.5
 let failures = failures + 1
end
meas tran h_15_QB01 find v(QB01) at=3190n
if h_15_QB01 < 4.5
 let failures = failures + 1
end
meas tran keep_15_QB01 min v(QB01) from=3069n to=3142n
if keep_15_QB01 < 2.5
 let failures = failures + 1
end
meas tran h_15_Q10 find v(Q10) at=3190n
if h_15_Q10 > 0.5
 let failures = failures + 1
end
meas tran keep_15_Q10 max v(Q10) from=3069n to=3142n
if keep_15_Q10 > 2.5
 let failures = failures + 1
end
meas tran h_15_QB10 find v(QB10) at=3190n
if h_15_QB10 < 4.5
 let failures = failures + 1
end
meas tran keep_15_QB10 min v(QB10) from=3069n to=3142n
if keep_15_QB10 < 2.5
 let failures = failures + 1
end
meas tran h_15_Q11 find v(Q11) at=3190n
if h_15_Q11 < 4.5
 let failures = failures + 1
end
meas tran keep_15_Q11 min v(Q11) from=3069n to=3142n
if keep_15_Q11 < 2.5
 let failures = failures + 1
end
meas tran h_15_QB11 find v(QB11) at=3190n
if h_15_QB11 > 0.5
 let failures = failures + 1
end
meas tran keep_15_QB11 max v(QB11) from=3069n to=3142n
if keep_15_QB11 > 2.5
 let failures = failures + 1
end
meas tran reset_15_SOUT find v(SOUT) at=3039n
if reset_15_SOUT < 4.5
 let failures = failures + 1
end
meas tran read_15_SOUT find v(SOUT) at=3150n
if read_15_SOUT < 4.5
 let failures = failures + 1
end
meas tran reset_15_SOUTB find v(SOUTB) at=3039n
if reset_15_SOUTB < 4.5
 let failures = failures + 1
end
meas tran read_15_SOUTB find v(SOUTB) at=3150n
if read_15_SOUTB > 0.5
 let failures = failures + 1
end
meas tran diff_15 find ydiff at=3090n
if failures = 0
 echo PASS: 2x2 mux writes, sensed reads, reset and unselected-cell retention
else
 echo FAIL: inspect measurements
 print failures
end
write sram_tb_array_mux.raw
plot v(Q00) v(Q01) v(Q10) v(Q11) title 'STORED BITS: checkerboard then inverse'
plot v(SOUT) v(SOUTB) title 'READ OUTPUTS: valid at cycle +150 ns'
plot v(BL0) v(BLB0) v(Y) v(YB) xlimit 840n 950n title 'READ row0 col0: local BL through NMOS mux to common Y'
plot v(Y) v(YB) v(SOUT) v(SOUTB) xlimit 840n 950n title 'READ row0 col0: SAE rises at 890 ns'
let PREB_T = v(PREB)/5+16
let YPREB_T = v(YPREB)/5+14
let COL0_T = v(COL0)/5+12
let COL1_T = v(COL1)/5+10
let WL0_T = v(WL0)/5+8
let WL1_T = v(WL1)/5+6
let SAE_T = v(SAE)/5+4
let PD_Y_T = v(PD_Y)/5+2
let PD_YB_T = v(PD_YB)/5+0
plot PREB_T YPREB_T WL0_T WL1_T COL0_T COL1_T PD_Y_T PD_YB_T SAE_T title 'CONTROLS: PREB16 YPREB14 COL0/1=12/10 WL0/1=8/6 SAE4 PD_Y/YB=2/0'
.endc"}
C {devices/netlist_options.sym} 2250 1900 0 0 {name=NETLIST_OPTIONS
lvs_netlist=false
top_is_subckt=false
spiceprefix=true
hiersep=. }
