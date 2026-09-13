v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {2 x 2 SRAM | ROW + COLUMN DECODERS / WRITE CONTROL / MUX / SENSE} -180 -270 0 0 0.45 0.45 {}
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
T {SHARED PRECHARGE / WRITE} 850 1080 0 0 0.3 0.3 {}
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
T {IDEAL CONTROLS: edit PWL sources with q (RA / CA / DIN and enables drive logic; PRE / SAE remain ideal)} -120 1830 0 0 0.3 0.3 {}
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
C {devices/vsource.sym} 1560 1970 0 0 {name=VWL_EN
value="PWL(0n 0 70n 0 71n 5 140n 5 141n 0 270n 0 271n 5 340n 5 341n 0 470n 0 471n 5 540n 5 541n 0 670n 0 671n 5 740n 5 741n 0 870n 0 871n 5 940n 5 941n 0 1070n 0 1071n 5 1140n 5 1141n 0 1270n 0 1271n 5 1340n 5 1341n 0 1470n 0 1471n 5 1540n 5 1541n 0 1670n 0 1671n 5 1740n 5 1741n 0 1870n 0 1871n 5 1940n 5 1941n 0 2070n 0 2071n 5 2140n 5 2141n 0 2270n 0 2271n 5 2340n 5 2341n 0 2470n 0 2471n 5 2540n 5 2541n 0 2670n 0 2671n 5 2740n 5 2741n 0 2870n 0 2871n 5 2940n 5 2941n 0 3070n 0 3071n 5 3140n 5 3141n 0 3200n 0)"
savecurrent=false
hide_texts=true}
C {devices/lab_pin.sym} 1560 1940 2 0 {name=l199 lab=WL_EN}
C {devices/gnd.sym} 1560 2000 0 0 {name=gs3 lab=GND}
T {PWL} 1610 1970 0 0 0.25 0.25 {}
C {devices/vsource.sym} 2080 1970 0 0 {name=VRA
value="PWL(0n 0 5n 0 6n 5 15n 5 16n 0 205n 0 206n 5 215n 5 216n 0 405n 0 406n 0 415n 0 416n 5 605n 5 606n 0 615n 0 616n 5 805n 5 806n 5 815n 5 816n 0 1005n 0 1006n 5 1015n 5 1016n 0 1205n 0 1206n 0 1215n 0 1216n 5 1405n 5 1406n 0 1415n 0 1416n 5 1605n 5 1606n 5 1615n 5 1616n 0 1805n 0 1806n 5 1815n 5 1816n 0 2005n 0 2006n 0 2015n 0 2016n 5 2205n 5 2206n 0 2215n 0 2216n 5 2405n 5 2406n 5 2415n 5 2416n 0 2605n 0 2606n 5 2615n 5 2616n 0 2805n 0 2806n 0 2815n 0 2816n 5 3005n 5 3006n 0 3015n 0 3016n 5 3200n 5)"
savecurrent=false
hide_texts=true}
C {devices/lab_pin.sym} 2080 1940 2 0 {name=l203 lab=RA}
C {devices/gnd.sym} 2080 2000 0 0 {name=gs4 lab=GND}
T {PWL} 2130 1970 0 0 0.25 0.25 {}
C {devices/vsource.sym} 520 2200 0 0 {name=VCA
value="PWL(0n 0 5n 0 6n 5 15n 5 16n 0 205n 0 206n 0 215n 0 216n 5 405n 5 406n 5 415n 5 416n 0 605n 0 606n 0 615n 0 616n 5 805n 5 806n 5 815n 5 816n 0 1005n 0 1006n 0 1015n 0 1016n 5 1205n 5 1206n 5 1215n 5 1216n 0 1405n 0 1406n 0 1415n 0 1416n 5 1605n 5 1606n 5 1615n 5 1616n 0 1805n 0 1806n 0 1815n 0 1816n 5 2005n 5 2006n 5 2015n 5 2016n 0 2205n 0 2206n 0 2215n 0 2216n 5 2405n 5 2406n 5 2415n 5 2416n 0 2605n 0 2606n 0 2615n 0 2616n 5 2805n 5 2806n 5 2815n 5 2816n 0 3005n 0 3006n 0 3015n 0 3016n 5 3200n 5)"
savecurrent=false
hide_texts=true}
C {devices/lab_pin.sym} 520 2170 2 0 {name=l211 lab=CA}
C {devices/gnd.sym} 520 2230 0 0 {name=gs6 lab=GND}
T {PWL} 570 2200 0 0 0.25 0.25 {}
C {devices/vsource.sym} 1040 2200 0 0 {name=VWRITE_EN
value="PWL(0n 0 50n 0 51n 5 155n 5 156n 0 250n 0 251n 5 355n 5 356n 0 450n 0 451n 5 555n 5 556n 0 650n 0 651n 5 755n 5 756n 0 1650n 0 1651n 5 1755n 5 1756n 0 1850n 0 1851n 5 1955n 5 1956n 0 2050n 0 2051n 5 2155n 5 2156n 0 2250n 0 2251n 5 2355n 5 2356n 0 3200n 0)"
savecurrent=false
hide_texts=true}
C {devices/lab_pin.sym} 1040 2170 2 0 {name=l215 lab=WRITE_EN}
C {devices/gnd.sym} 1040 2230 0 0 {name=gs7 lab=GND}
T {PWL} 1090 2200 0 0 0.25 0.25 {}
C {devices/vsource.sym} 1560 2200 0 0 {name=VDIN
value="PWL(0n 0 5n 0 6n 5 15n 5 16n 0 205n 0 206n 0 215n 0 216n 5 405n 5 406n 0 415n 0 416n 5 605n 5 606n 5 615n 5 616n 0 805n 0 806n 5 815n 5 816n 0 1005n 0 1006n 0 1015n 0 1016n 5 1205n 5 1206n 0 1215n 0 1216n 5 1405n 5 1406n 5 1415n 5 1416n 0 1605n 0 1606n 0 1615n 0 1616n 5 1805n 5 1806n 5 1815n 5 1816n 0 2005n 0 2006n 5 2015n 5 2016n 0 2205n 0 2206n 0 2215n 0 2216n 5 2405n 5 2406n 0 2415n 0 2416n 5 2605n 5 2606n 5 2615n 5 2616n 0 2805n 0 2806n 5 2815n 5 2816n 0 3005n 0 3006n 0 3015n 0 3016n 5 3200n 5)"
savecurrent=false
hide_texts=true}
C {devices/lab_pin.sym} 1560 2170 2 0 {name=l219 lab=DIN}
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
T {0 - 40: local/common precharge; all WL LOW} 2200 484 0 0 0.27 0.27 {}
T {Y/YB precharge every cycle; SAE LOW only on read} 2200 520 0 0 0.27 0.27 {}
T {40 - 41: precharge OFF} 2200 556 0 0 0.27 0.27 {}
T {5 - 16: CA switches; settle before precharge ends} 2200 592 0 0 0.27 0.27 {}
T {Write: 50 - 51 WRITE_EN rises; PD follows} 2200 628 0 0 0.27 0.27 {}
T {70 - 71: WL_EN rises; WL follows after gate delay} 2200 664 0 0 0.27 0.27 {}
T {Read: 90 - 91 SAE rises} 2200 700 0 0 0.27 0.27 {}
T {140 - 141: WL_EN falls; WL follows after gate delay} 2200 736 0 0 0.27 0.27 {}
T {Read: 150 check SOUT / SOUTB} 2200 772 0 0 0.27 0.27 {}
T {Write: 155 - 156 WRITE_EN falls; PD follows} 2200 808 0 0 0.27 0.27 {}
T {Column remains selected until CA changes} 2200 844 0 0 0.27 0.27 {}
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
meas tran off_0_0 max v(WL0) from=2n to=69n
if off_0_0 > 0.5
 let failures = failures + 1
end
meas tran release_0_0 max v(WL0) from=150n to=199n
if release_0_0 > 0.5
 let failures = failures + 1
end
meas tran active_0_0 min v(WL0) from=80n to=139n
if active_0_0 < 4.5
 let failures = failures + 1
end
meas tran off_0_1 max v(WL1) from=2n to=69n
if off_0_1 > 0.5
 let failures = failures + 1
end
meas tran release_0_1 max v(WL1) from=150n to=199n
if release_0_1 > 0.5
 let failures = failures + 1
end
meas tran active_0_1 max v(WL1) from=80n to=139n
if active_0_1 > 0.5
 let failures = failures + 1
end
meas tran rise_delay_0 trig v(WL_EN) val=2.5 rise=1 td=69n targ v(WL0) val=2.5 rise=1 td=69n
meas tran fall_delay_0 trig v(WL_EN) val=2.5 fall=1 td=139n targ v(WL0) val=2.5 fall=1 td=139n
meas tran off_1_0 max v(WL0) from=202n to=269n
if off_1_0 > 0.5
 let failures = failures + 1
end
meas tran release_1_0 max v(WL0) from=350n to=399n
if release_1_0 > 0.5
 let failures = failures + 1
end
meas tran active_1_0 min v(WL0) from=280n to=339n
if active_1_0 < 4.5
 let failures = failures + 1
end
meas tran off_1_1 max v(WL1) from=202n to=269n
if off_1_1 > 0.5
 let failures = failures + 1
end
meas tran release_1_1 max v(WL1) from=350n to=399n
if release_1_1 > 0.5
 let failures = failures + 1
end
meas tran active_1_1 max v(WL1) from=280n to=339n
if active_1_1 > 0.5
 let failures = failures + 1
end
meas tran rise_delay_1 trig v(WL_EN) val=2.5 rise=1 td=269n targ v(WL0) val=2.5 rise=1 td=269n
meas tran fall_delay_1 trig v(WL_EN) val=2.5 fall=1 td=339n targ v(WL0) val=2.5 fall=1 td=339n
meas tran off_2_0 max v(WL0) from=402n to=469n
if off_2_0 > 0.5
 let failures = failures + 1
end
meas tran release_2_0 max v(WL0) from=550n to=599n
if release_2_0 > 0.5
 let failures = failures + 1
end
meas tran active_2_0 max v(WL0) from=480n to=539n
if active_2_0 > 0.5
 let failures = failures + 1
end
meas tran off_2_1 max v(WL1) from=402n to=469n
if off_2_1 > 0.5
 let failures = failures + 1
end
meas tran release_2_1 max v(WL1) from=550n to=599n
if release_2_1 > 0.5
 let failures = failures + 1
end
meas tran active_2_1 min v(WL1) from=480n to=539n
if active_2_1 < 4.5
 let failures = failures + 1
end
meas tran rise_delay_2 trig v(WL_EN) val=2.5 rise=1 td=469n targ v(WL1) val=2.5 rise=1 td=469n
meas tran fall_delay_2 trig v(WL_EN) val=2.5 fall=1 td=539n targ v(WL1) val=2.5 fall=1 td=539n
meas tran off_3_0 max v(WL0) from=602n to=669n
if off_3_0 > 0.5
 let failures = failures + 1
end
meas tran release_3_0 max v(WL0) from=750n to=799n
if release_3_0 > 0.5
 let failures = failures + 1
end
meas tran active_3_0 max v(WL0) from=680n to=739n
if active_3_0 > 0.5
 let failures = failures + 1
end
meas tran off_3_1 max v(WL1) from=602n to=669n
if off_3_1 > 0.5
 let failures = failures + 1
end
meas tran release_3_1 max v(WL1) from=750n to=799n
if release_3_1 > 0.5
 let failures = failures + 1
end
meas tran active_3_1 min v(WL1) from=680n to=739n
if active_3_1 < 4.5
 let failures = failures + 1
end
meas tran rise_delay_3 trig v(WL_EN) val=2.5 rise=1 td=669n targ v(WL1) val=2.5 rise=1 td=669n
meas tran fall_delay_3 trig v(WL_EN) val=2.5 fall=1 td=739n targ v(WL1) val=2.5 fall=1 td=739n
meas tran off_4_0 max v(WL0) from=802n to=869n
if off_4_0 > 0.5
 let failures = failures + 1
end
meas tran release_4_0 max v(WL0) from=950n to=999n
if release_4_0 > 0.5
 let failures = failures + 1
end
meas tran active_4_0 min v(WL0) from=880n to=939n
if active_4_0 < 4.5
 let failures = failures + 1
end
meas tran off_4_1 max v(WL1) from=802n to=869n
if off_4_1 > 0.5
 let failures = failures + 1
end
meas tran release_4_1 max v(WL1) from=950n to=999n
if release_4_1 > 0.5
 let failures = failures + 1
end
meas tran active_4_1 max v(WL1) from=880n to=939n
if active_4_1 > 0.5
 let failures = failures + 1
end
meas tran rise_delay_4 trig v(WL_EN) val=2.5 rise=1 td=869n targ v(WL0) val=2.5 rise=1 td=869n
meas tran fall_delay_4 trig v(WL_EN) val=2.5 fall=1 td=939n targ v(WL0) val=2.5 fall=1 td=939n
meas tran off_5_0 max v(WL0) from=1002n to=1069n
if off_5_0 > 0.5
 let failures = failures + 1
end
meas tran release_5_0 max v(WL0) from=1150n to=1199n
if release_5_0 > 0.5
 let failures = failures + 1
end
meas tran active_5_0 min v(WL0) from=1080n to=1139n
if active_5_0 < 4.5
 let failures = failures + 1
end
meas tran off_5_1 max v(WL1) from=1002n to=1069n
if off_5_1 > 0.5
 let failures = failures + 1
end
meas tran release_5_1 max v(WL1) from=1150n to=1199n
if release_5_1 > 0.5
 let failures = failures + 1
end
meas tran active_5_1 max v(WL1) from=1080n to=1139n
if active_5_1 > 0.5
 let failures = failures + 1
end
meas tran rise_delay_5 trig v(WL_EN) val=2.5 rise=1 td=1069n targ v(WL0) val=2.5 rise=1 td=1069n
meas tran fall_delay_5 trig v(WL_EN) val=2.5 fall=1 td=1139n targ v(WL0) val=2.5 fall=1 td=1139n
meas tran off_6_0 max v(WL0) from=1202n to=1269n
if off_6_0 > 0.5
 let failures = failures + 1
end
meas tran release_6_0 max v(WL0) from=1350n to=1399n
if release_6_0 > 0.5
 let failures = failures + 1
end
meas tran active_6_0 max v(WL0) from=1280n to=1339n
if active_6_0 > 0.5
 let failures = failures + 1
end
meas tran off_6_1 max v(WL1) from=1202n to=1269n
if off_6_1 > 0.5
 let failures = failures + 1
end
meas tran release_6_1 max v(WL1) from=1350n to=1399n
if release_6_1 > 0.5
 let failures = failures + 1
end
meas tran active_6_1 min v(WL1) from=1280n to=1339n
if active_6_1 < 4.5
 let failures = failures + 1
end
meas tran rise_delay_6 trig v(WL_EN) val=2.5 rise=1 td=1269n targ v(WL1) val=2.5 rise=1 td=1269n
meas tran fall_delay_6 trig v(WL_EN) val=2.5 fall=1 td=1339n targ v(WL1) val=2.5 fall=1 td=1339n
meas tran off_7_0 max v(WL0) from=1402n to=1469n
if off_7_0 > 0.5
 let failures = failures + 1
end
meas tran release_7_0 max v(WL0) from=1550n to=1599n
if release_7_0 > 0.5
 let failures = failures + 1
end
meas tran active_7_0 max v(WL0) from=1480n to=1539n
if active_7_0 > 0.5
 let failures = failures + 1
end
meas tran off_7_1 max v(WL1) from=1402n to=1469n
if off_7_1 > 0.5
 let failures = failures + 1
end
meas tran release_7_1 max v(WL1) from=1550n to=1599n
if release_7_1 > 0.5
 let failures = failures + 1
end
meas tran active_7_1 min v(WL1) from=1480n to=1539n
if active_7_1 < 4.5
 let failures = failures + 1
end
meas tran rise_delay_7 trig v(WL_EN) val=2.5 rise=1 td=1469n targ v(WL1) val=2.5 rise=1 td=1469n
meas tran fall_delay_7 trig v(WL_EN) val=2.5 fall=1 td=1539n targ v(WL1) val=2.5 fall=1 td=1539n
meas tran off_8_0 max v(WL0) from=1602n to=1669n
if off_8_0 > 0.5
 let failures = failures + 1
end
meas tran release_8_0 max v(WL0) from=1750n to=1799n
if release_8_0 > 0.5
 let failures = failures + 1
end
meas tran active_8_0 min v(WL0) from=1680n to=1739n
if active_8_0 < 4.5
 let failures = failures + 1
end
meas tran off_8_1 max v(WL1) from=1602n to=1669n
if off_8_1 > 0.5
 let failures = failures + 1
end
meas tran release_8_1 max v(WL1) from=1750n to=1799n
if release_8_1 > 0.5
 let failures = failures + 1
end
meas tran active_8_1 max v(WL1) from=1680n to=1739n
if active_8_1 > 0.5
 let failures = failures + 1
end
meas tran rise_delay_8 trig v(WL_EN) val=2.5 rise=1 td=1669n targ v(WL0) val=2.5 rise=1 td=1669n
meas tran fall_delay_8 trig v(WL_EN) val=2.5 fall=1 td=1739n targ v(WL0) val=2.5 fall=1 td=1739n
meas tran off_9_0 max v(WL0) from=1802n to=1869n
if off_9_0 > 0.5
 let failures = failures + 1
end
meas tran release_9_0 max v(WL0) from=1950n to=1999n
if release_9_0 > 0.5
 let failures = failures + 1
end
meas tran active_9_0 min v(WL0) from=1880n to=1939n
if active_9_0 < 4.5
 let failures = failures + 1
end
meas tran off_9_1 max v(WL1) from=1802n to=1869n
if off_9_1 > 0.5
 let failures = failures + 1
end
meas tran release_9_1 max v(WL1) from=1950n to=1999n
if release_9_1 > 0.5
 let failures = failures + 1
end
meas tran active_9_1 max v(WL1) from=1880n to=1939n
if active_9_1 > 0.5
 let failures = failures + 1
end
meas tran rise_delay_9 trig v(WL_EN) val=2.5 rise=1 td=1869n targ v(WL0) val=2.5 rise=1 td=1869n
meas tran fall_delay_9 trig v(WL_EN) val=2.5 fall=1 td=1939n targ v(WL0) val=2.5 fall=1 td=1939n
meas tran off_10_0 max v(WL0) from=2002n to=2069n
if off_10_0 > 0.5
 let failures = failures + 1
end
meas tran release_10_0 max v(WL0) from=2150n to=2199n
if release_10_0 > 0.5
 let failures = failures + 1
end
meas tran active_10_0 max v(WL0) from=2080n to=2139n
if active_10_0 > 0.5
 let failures = failures + 1
end
meas tran off_10_1 max v(WL1) from=2002n to=2069n
if off_10_1 > 0.5
 let failures = failures + 1
end
meas tran release_10_1 max v(WL1) from=2150n to=2199n
if release_10_1 > 0.5
 let failures = failures + 1
end
meas tran active_10_1 min v(WL1) from=2080n to=2139n
if active_10_1 < 4.5
 let failures = failures + 1
end
meas tran rise_delay_10 trig v(WL_EN) val=2.5 rise=1 td=2069n targ v(WL1) val=2.5 rise=1 td=2069n
meas tran fall_delay_10 trig v(WL_EN) val=2.5 fall=1 td=2139n targ v(WL1) val=2.5 fall=1 td=2139n
meas tran off_11_0 max v(WL0) from=2202n to=2269n
if off_11_0 > 0.5
 let failures = failures + 1
end
meas tran release_11_0 max v(WL0) from=2350n to=2399n
if release_11_0 > 0.5
 let failures = failures + 1
end
meas tran active_11_0 max v(WL0) from=2280n to=2339n
if active_11_0 > 0.5
 let failures = failures + 1
end
meas tran off_11_1 max v(WL1) from=2202n to=2269n
if off_11_1 > 0.5
 let failures = failures + 1
end
meas tran release_11_1 max v(WL1) from=2350n to=2399n
if release_11_1 > 0.5
 let failures = failures + 1
end
meas tran active_11_1 min v(WL1) from=2280n to=2339n
if active_11_1 < 4.5
 let failures = failures + 1
end
meas tran rise_delay_11 trig v(WL_EN) val=2.5 rise=1 td=2269n targ v(WL1) val=2.5 rise=1 td=2269n
meas tran fall_delay_11 trig v(WL_EN) val=2.5 fall=1 td=2339n targ v(WL1) val=2.5 fall=1 td=2339n
meas tran off_12_0 max v(WL0) from=2402n to=2469n
if off_12_0 > 0.5
 let failures = failures + 1
end
meas tran release_12_0 max v(WL0) from=2550n to=2599n
if release_12_0 > 0.5
 let failures = failures + 1
end
meas tran active_12_0 min v(WL0) from=2480n to=2539n
if active_12_0 < 4.5
 let failures = failures + 1
end
meas tran off_12_1 max v(WL1) from=2402n to=2469n
if off_12_1 > 0.5
 let failures = failures + 1
end
meas tran release_12_1 max v(WL1) from=2550n to=2599n
if release_12_1 > 0.5
 let failures = failures + 1
end
meas tran active_12_1 max v(WL1) from=2480n to=2539n
if active_12_1 > 0.5
 let failures = failures + 1
end
meas tran rise_delay_12 trig v(WL_EN) val=2.5 rise=1 td=2469n targ v(WL0) val=2.5 rise=1 td=2469n
meas tran fall_delay_12 trig v(WL_EN) val=2.5 fall=1 td=2539n targ v(WL0) val=2.5 fall=1 td=2539n
meas tran off_13_0 max v(WL0) from=2602n to=2669n
if off_13_0 > 0.5
 let failures = failures + 1
end
meas tran release_13_0 max v(WL0) from=2750n to=2799n
if release_13_0 > 0.5
 let failures = failures + 1
end
meas tran active_13_0 min v(WL0) from=2680n to=2739n
if active_13_0 < 4.5
 let failures = failures + 1
end
meas tran off_13_1 max v(WL1) from=2602n to=2669n
if off_13_1 > 0.5
 let failures = failures + 1
end
meas tran release_13_1 max v(WL1) from=2750n to=2799n
if release_13_1 > 0.5
 let failures = failures + 1
end
meas tran active_13_1 max v(WL1) from=2680n to=2739n
if active_13_1 > 0.5
 let failures = failures + 1
end
meas tran rise_delay_13 trig v(WL_EN) val=2.5 rise=1 td=2669n targ v(WL0) val=2.5 rise=1 td=2669n
meas tran fall_delay_13 trig v(WL_EN) val=2.5 fall=1 td=2739n targ v(WL0) val=2.5 fall=1 td=2739n
meas tran off_14_0 max v(WL0) from=2802n to=2869n
if off_14_0 > 0.5
 let failures = failures + 1
end
meas tran release_14_0 max v(WL0) from=2950n to=2999n
if release_14_0 > 0.5
 let failures = failures + 1
end
meas tran active_14_0 max v(WL0) from=2880n to=2939n
if active_14_0 > 0.5
 let failures = failures + 1
end
meas tran off_14_1 max v(WL1) from=2802n to=2869n
if off_14_1 > 0.5
 let failures = failures + 1
end
meas tran release_14_1 max v(WL1) from=2950n to=2999n
if release_14_1 > 0.5
 let failures = failures + 1
end
meas tran active_14_1 min v(WL1) from=2880n to=2939n
if active_14_1 < 4.5
 let failures = failures + 1
end
meas tran rise_delay_14 trig v(WL_EN) val=2.5 rise=1 td=2869n targ v(WL1) val=2.5 rise=1 td=2869n
meas tran fall_delay_14 trig v(WL_EN) val=2.5 fall=1 td=2939n targ v(WL1) val=2.5 fall=1 td=2939n
meas tran off_15_0 max v(WL0) from=3002n to=3069n
if off_15_0 > 0.5
 let failures = failures + 1
end
meas tran release_15_0 max v(WL0) from=3150n to=3199n
if release_15_0 > 0.5
 let failures = failures + 1
end
meas tran active_15_0 max v(WL0) from=3080n to=3139n
if active_15_0 > 0.5
 let failures = failures + 1
end
meas tran off_15_1 max v(WL1) from=3002n to=3069n
if off_15_1 > 0.5
 let failures = failures + 1
end
meas tran release_15_1 max v(WL1) from=3150n to=3199n
if release_15_1 > 0.5
 let failures = failures + 1
end
meas tran active_15_1 min v(WL1) from=3080n to=3139n
if active_15_1 < 4.5
 let failures = failures + 1
end
meas tran rise_delay_15 trig v(WL_EN) val=2.5 rise=1 td=3069n targ v(WL1) val=2.5 rise=1 td=3069n
meas tran fall_delay_15 trig v(WL_EN) val=2.5 fall=1 td=3139n targ v(WL1) val=2.5 fall=1 td=3139n
meas tran col_stable_0_0 min v(COL0) from=25n to=199n
if col_stable_0_0 < 4.5
 let failures = failures + 1
end
meas tran col_stable_0_1 max v(COL1) from=25n to=199n
if col_stable_0_1 > 0.5
 let failures = failures + 1
end
meas tran pre_0_BL0 find v(BL0) at=39n
if pre_0_BL0 < 4.5
 let failures = failures + 1
end
meas tran pre_0_BLB0 find v(BLB0) at=39n
if pre_0_BLB0 < 4.5
 let failures = failures + 1
end
meas tran pre_0_BL1 find v(BL1) at=39n
if pre_0_BL1 < 4.5
 let failures = failures + 1
end
meas tran pre_0_BLB1 find v(BLB1) at=39n
if pre_0_BLB1 < 4.5
 let failures = failures + 1
end
meas tran pre_0_Y find v(Y) at=39n
if pre_0_Y < 4.5
 let failures = failures + 1
end
meas tran pre_0_YB find v(YB) at=39n
if pre_0_YB < 4.5
 let failures = failures + 1
end
meas tran col_stable_1_0 max v(COL0) from=225n to=399n
if col_stable_1_0 > 0.5
 let failures = failures + 1
end
meas tran col_stable_1_1 min v(COL1) from=225n to=399n
if col_stable_1_1 < 4.5
 let failures = failures + 1
end
meas tran pre_1_BL0 find v(BL0) at=239n
if pre_1_BL0 < 4.5
 let failures = failures + 1
end
meas tran pre_1_BLB0 find v(BLB0) at=239n
if pre_1_BLB0 < 4.5
 let failures = failures + 1
end
meas tran pre_1_BL1 find v(BL1) at=239n
if pre_1_BL1 < 4.5
 let failures = failures + 1
end
meas tran pre_1_BLB1 find v(BLB1) at=239n
if pre_1_BLB1 < 4.5
 let failures = failures + 1
end
meas tran pre_1_Y find v(Y) at=239n
if pre_1_Y < 4.5
 let failures = failures + 1
end
meas tran pre_1_YB find v(YB) at=239n
if pre_1_YB < 4.5
 let failures = failures + 1
end
meas tran col_stable_2_0 min v(COL0) from=425n to=599n
if col_stable_2_0 < 4.5
 let failures = failures + 1
end
meas tran col_stable_2_1 max v(COL1) from=425n to=599n
if col_stable_2_1 > 0.5
 let failures = failures + 1
end
meas tran pre_2_BL0 find v(BL0) at=439n
if pre_2_BL0 < 4.5
 let failures = failures + 1
end
meas tran pre_2_BLB0 find v(BLB0) at=439n
if pre_2_BLB0 < 4.5
 let failures = failures + 1
end
meas tran pre_2_BL1 find v(BL1) at=439n
if pre_2_BL1 < 4.5
 let failures = failures + 1
end
meas tran pre_2_BLB1 find v(BLB1) at=439n
if pre_2_BLB1 < 4.5
 let failures = failures + 1
end
meas tran pre_2_Y find v(Y) at=439n
if pre_2_Y < 4.5
 let failures = failures + 1
end
meas tran pre_2_YB find v(YB) at=439n
if pre_2_YB < 4.5
 let failures = failures + 1
end
meas tran col_stable_3_0 max v(COL0) from=625n to=799n
if col_stable_3_0 > 0.5
 let failures = failures + 1
end
meas tran col_stable_3_1 min v(COL1) from=625n to=799n
if col_stable_3_1 < 4.5
 let failures = failures + 1
end
meas tran pre_3_BL0 find v(BL0) at=639n
if pre_3_BL0 < 4.5
 let failures = failures + 1
end
meas tran pre_3_BLB0 find v(BLB0) at=639n
if pre_3_BLB0 < 4.5
 let failures = failures + 1
end
meas tran pre_3_BL1 find v(BL1) at=639n
if pre_3_BL1 < 4.5
 let failures = failures + 1
end
meas tran pre_3_BLB1 find v(BLB1) at=639n
if pre_3_BLB1 < 4.5
 let failures = failures + 1
end
meas tran pre_3_Y find v(Y) at=639n
if pre_3_Y < 4.5
 let failures = failures + 1
end
meas tran pre_3_YB find v(YB) at=639n
if pre_3_YB < 4.5
 let failures = failures + 1
end
meas tran col_stable_4_0 min v(COL0) from=825n to=999n
if col_stable_4_0 < 4.5
 let failures = failures + 1
end
meas tran col_stable_4_1 max v(COL1) from=825n to=999n
if col_stable_4_1 > 0.5
 let failures = failures + 1
end
meas tran pre_4_BL0 find v(BL0) at=839n
if pre_4_BL0 < 4.5
 let failures = failures + 1
end
meas tran pre_4_BLB0 find v(BLB0) at=839n
if pre_4_BLB0 < 4.5
 let failures = failures + 1
end
meas tran pre_4_BL1 find v(BL1) at=839n
if pre_4_BL1 < 4.5
 let failures = failures + 1
end
meas tran pre_4_BLB1 find v(BLB1) at=839n
if pre_4_BLB1 < 4.5
 let failures = failures + 1
end
meas tran pre_4_Y find v(Y) at=839n
if pre_4_Y < 4.5
 let failures = failures + 1
end
meas tran pre_4_YB find v(YB) at=839n
if pre_4_YB < 4.5
 let failures = failures + 1
end
meas tran col_stable_5_0 max v(COL0) from=1025n to=1199n
if col_stable_5_0 > 0.5
 let failures = failures + 1
end
meas tran col_stable_5_1 min v(COL1) from=1025n to=1199n
if col_stable_5_1 < 4.5
 let failures = failures + 1
end
meas tran pre_5_BL0 find v(BL0) at=1039n
if pre_5_BL0 < 4.5
 let failures = failures + 1
end
meas tran pre_5_BLB0 find v(BLB0) at=1039n
if pre_5_BLB0 < 4.5
 let failures = failures + 1
end
meas tran pre_5_BL1 find v(BL1) at=1039n
if pre_5_BL1 < 4.5
 let failures = failures + 1
end
meas tran pre_5_BLB1 find v(BLB1) at=1039n
if pre_5_BLB1 < 4.5
 let failures = failures + 1
end
meas tran pre_5_Y find v(Y) at=1039n
if pre_5_Y < 4.5
 let failures = failures + 1
end
meas tran pre_5_YB find v(YB) at=1039n
if pre_5_YB < 4.5
 let failures = failures + 1
end
meas tran col_stable_6_0 min v(COL0) from=1225n to=1399n
if col_stable_6_0 < 4.5
 let failures = failures + 1
end
meas tran col_stable_6_1 max v(COL1) from=1225n to=1399n
if col_stable_6_1 > 0.5
 let failures = failures + 1
end
meas tran pre_6_BL0 find v(BL0) at=1239n
if pre_6_BL0 < 4.5
 let failures = failures + 1
end
meas tran pre_6_BLB0 find v(BLB0) at=1239n
if pre_6_BLB0 < 4.5
 let failures = failures + 1
end
meas tran pre_6_BL1 find v(BL1) at=1239n
if pre_6_BL1 < 4.5
 let failures = failures + 1
end
meas tran pre_6_BLB1 find v(BLB1) at=1239n
if pre_6_BLB1 < 4.5
 let failures = failures + 1
end
meas tran pre_6_Y find v(Y) at=1239n
if pre_6_Y < 4.5
 let failures = failures + 1
end
meas tran pre_6_YB find v(YB) at=1239n
if pre_6_YB < 4.5
 let failures = failures + 1
end
meas tran col_stable_7_0 max v(COL0) from=1425n to=1599n
if col_stable_7_0 > 0.5
 let failures = failures + 1
end
meas tran col_stable_7_1 min v(COL1) from=1425n to=1599n
if col_stable_7_1 < 4.5
 let failures = failures + 1
end
meas tran pre_7_BL0 find v(BL0) at=1439n
if pre_7_BL0 < 4.5
 let failures = failures + 1
end
meas tran pre_7_BLB0 find v(BLB0) at=1439n
if pre_7_BLB0 < 4.5
 let failures = failures + 1
end
meas tran pre_7_BL1 find v(BL1) at=1439n
if pre_7_BL1 < 4.5
 let failures = failures + 1
end
meas tran pre_7_BLB1 find v(BLB1) at=1439n
if pre_7_BLB1 < 4.5
 let failures = failures + 1
end
meas tran pre_7_Y find v(Y) at=1439n
if pre_7_Y < 4.5
 let failures = failures + 1
end
meas tran pre_7_YB find v(YB) at=1439n
if pre_7_YB < 4.5
 let failures = failures + 1
end
meas tran col_stable_8_0 min v(COL0) from=1625n to=1799n
if col_stable_8_0 < 4.5
 let failures = failures + 1
end
meas tran col_stable_8_1 max v(COL1) from=1625n to=1799n
if col_stable_8_1 > 0.5
 let failures = failures + 1
end
meas tran pre_8_BL0 find v(BL0) at=1639n
if pre_8_BL0 < 4.5
 let failures = failures + 1
end
meas tran pre_8_BLB0 find v(BLB0) at=1639n
if pre_8_BLB0 < 4.5
 let failures = failures + 1
end
meas tran pre_8_BL1 find v(BL1) at=1639n
if pre_8_BL1 < 4.5
 let failures = failures + 1
end
meas tran pre_8_BLB1 find v(BLB1) at=1639n
if pre_8_BLB1 < 4.5
 let failures = failures + 1
end
meas tran pre_8_Y find v(Y) at=1639n
if pre_8_Y < 4.5
 let failures = failures + 1
end
meas tran pre_8_YB find v(YB) at=1639n
if pre_8_YB < 4.5
 let failures = failures + 1
end
meas tran col_stable_9_0 max v(COL0) from=1825n to=1999n
if col_stable_9_0 > 0.5
 let failures = failures + 1
end
meas tran col_stable_9_1 min v(COL1) from=1825n to=1999n
if col_stable_9_1 < 4.5
 let failures = failures + 1
end
meas tran pre_9_BL0 find v(BL0) at=1839n
if pre_9_BL0 < 4.5
 let failures = failures + 1
end
meas tran pre_9_BLB0 find v(BLB0) at=1839n
if pre_9_BLB0 < 4.5
 let failures = failures + 1
end
meas tran pre_9_BL1 find v(BL1) at=1839n
if pre_9_BL1 < 4.5
 let failures = failures + 1
end
meas tran pre_9_BLB1 find v(BLB1) at=1839n
if pre_9_BLB1 < 4.5
 let failures = failures + 1
end
meas tran pre_9_Y find v(Y) at=1839n
if pre_9_Y < 4.5
 let failures = failures + 1
end
meas tran pre_9_YB find v(YB) at=1839n
if pre_9_YB < 4.5
 let failures = failures + 1
end
meas tran col_stable_10_0 min v(COL0) from=2025n to=2199n
if col_stable_10_0 < 4.5
 let failures = failures + 1
end
meas tran col_stable_10_1 max v(COL1) from=2025n to=2199n
if col_stable_10_1 > 0.5
 let failures = failures + 1
end
meas tran pre_10_BL0 find v(BL0) at=2039n
if pre_10_BL0 < 4.5
 let failures = failures + 1
end
meas tran pre_10_BLB0 find v(BLB0) at=2039n
if pre_10_BLB0 < 4.5
 let failures = failures + 1
end
meas tran pre_10_BL1 find v(BL1) at=2039n
if pre_10_BL1 < 4.5
 let failures = failures + 1
end
meas tran pre_10_BLB1 find v(BLB1) at=2039n
if pre_10_BLB1 < 4.5
 let failures = failures + 1
end
meas tran pre_10_Y find v(Y) at=2039n
if pre_10_Y < 4.5
 let failures = failures + 1
end
meas tran pre_10_YB find v(YB) at=2039n
if pre_10_YB < 4.5
 let failures = failures + 1
end
meas tran col_stable_11_0 max v(COL0) from=2225n to=2399n
if col_stable_11_0 > 0.5
 let failures = failures + 1
end
meas tran col_stable_11_1 min v(COL1) from=2225n to=2399n
if col_stable_11_1 < 4.5
 let failures = failures + 1
end
meas tran pre_11_BL0 find v(BL0) at=2239n
if pre_11_BL0 < 4.5
 let failures = failures + 1
end
meas tran pre_11_BLB0 find v(BLB0) at=2239n
if pre_11_BLB0 < 4.5
 let failures = failures + 1
end
meas tran pre_11_BL1 find v(BL1) at=2239n
if pre_11_BL1 < 4.5
 let failures = failures + 1
end
meas tran pre_11_BLB1 find v(BLB1) at=2239n
if pre_11_BLB1 < 4.5
 let failures = failures + 1
end
meas tran pre_11_Y find v(Y) at=2239n
if pre_11_Y < 4.5
 let failures = failures + 1
end
meas tran pre_11_YB find v(YB) at=2239n
if pre_11_YB < 4.5
 let failures = failures + 1
end
meas tran col_stable_12_0 min v(COL0) from=2425n to=2599n
if col_stable_12_0 < 4.5
 let failures = failures + 1
end
meas tran col_stable_12_1 max v(COL1) from=2425n to=2599n
if col_stable_12_1 > 0.5
 let failures = failures + 1
end
meas tran pre_12_BL0 find v(BL0) at=2439n
if pre_12_BL0 < 4.5
 let failures = failures + 1
end
meas tran pre_12_BLB0 find v(BLB0) at=2439n
if pre_12_BLB0 < 4.5
 let failures = failures + 1
end
meas tran pre_12_BL1 find v(BL1) at=2439n
if pre_12_BL1 < 4.5
 let failures = failures + 1
end
meas tran pre_12_BLB1 find v(BLB1) at=2439n
if pre_12_BLB1 < 4.5
 let failures = failures + 1
end
meas tran pre_12_Y find v(Y) at=2439n
if pre_12_Y < 4.5
 let failures = failures + 1
end
meas tran pre_12_YB find v(YB) at=2439n
if pre_12_YB < 4.5
 let failures = failures + 1
end
meas tran col_stable_13_0 max v(COL0) from=2625n to=2799n
if col_stable_13_0 > 0.5
 let failures = failures + 1
end
meas tran col_stable_13_1 min v(COL1) from=2625n to=2799n
if col_stable_13_1 < 4.5
 let failures = failures + 1
end
meas tran pre_13_BL0 find v(BL0) at=2639n
if pre_13_BL0 < 4.5
 let failures = failures + 1
end
meas tran pre_13_BLB0 find v(BLB0) at=2639n
if pre_13_BLB0 < 4.5
 let failures = failures + 1
end
meas tran pre_13_BL1 find v(BL1) at=2639n
if pre_13_BL1 < 4.5
 let failures = failures + 1
end
meas tran pre_13_BLB1 find v(BLB1) at=2639n
if pre_13_BLB1 < 4.5
 let failures = failures + 1
end
meas tran pre_13_Y find v(Y) at=2639n
if pre_13_Y < 4.5
 let failures = failures + 1
end
meas tran pre_13_YB find v(YB) at=2639n
if pre_13_YB < 4.5
 let failures = failures + 1
end
meas tran col_stable_14_0 min v(COL0) from=2825n to=2999n
if col_stable_14_0 < 4.5
 let failures = failures + 1
end
meas tran col_stable_14_1 max v(COL1) from=2825n to=2999n
if col_stable_14_1 > 0.5
 let failures = failures + 1
end
meas tran pre_14_BL0 find v(BL0) at=2839n
if pre_14_BL0 < 4.5
 let failures = failures + 1
end
meas tran pre_14_BLB0 find v(BLB0) at=2839n
if pre_14_BLB0 < 4.5
 let failures = failures + 1
end
meas tran pre_14_BL1 find v(BL1) at=2839n
if pre_14_BL1 < 4.5
 let failures = failures + 1
end
meas tran pre_14_BLB1 find v(BLB1) at=2839n
if pre_14_BLB1 < 4.5
 let failures = failures + 1
end
meas tran pre_14_Y find v(Y) at=2839n
if pre_14_Y < 4.5
 let failures = failures + 1
end
meas tran pre_14_YB find v(YB) at=2839n
if pre_14_YB < 4.5
 let failures = failures + 1
end
meas tran col_stable_15_0 max v(COL0) from=3025n to=3199n
if col_stable_15_0 > 0.5
 let failures = failures + 1
end
meas tran col_stable_15_1 min v(COL1) from=3025n to=3199n
if col_stable_15_1 < 4.5
 let failures = failures + 1
end
meas tran pre_15_BL0 find v(BL0) at=3039n
if pre_15_BL0 < 4.5
 let failures = failures + 1
end
meas tran pre_15_BLB0 find v(BLB0) at=3039n
if pre_15_BLB0 < 4.5
 let failures = failures + 1
end
meas tran pre_15_BL1 find v(BL1) at=3039n
if pre_15_BL1 < 4.5
 let failures = failures + 1
end
meas tran pre_15_BLB1 find v(BLB1) at=3039n
if pre_15_BLB1 < 4.5
 let failures = failures + 1
end
meas tran pre_15_Y find v(Y) at=3039n
if pre_15_Y < 4.5
 let failures = failures + 1
end
meas tran pre_15_YB find v(YB) at=3039n
if pre_15_YB < 4.5
 let failures = failures + 1
end
meas tran write_disabled_0_PD_Y max v(PD_Y) from=2n to=49n
if write_disabled_0_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_released_0_PD_Y max v(PD_Y) from=165n to=199n
if write_released_0_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_active_0_PD_Y min v(PD_Y) from=60n to=154n
if write_active_0_PD_Y < 4.5
 let failures = failures + 1
end
meas tran write_disabled_0_PD_YB max v(PD_YB) from=2n to=49n
if write_disabled_0_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_released_0_PD_YB max v(PD_YB) from=165n to=199n
if write_released_0_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_active_0_PD_YB max v(PD_YB) from=60n to=154n
if write_active_0_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_never_0_PD_YB max v(PD_YB) from=2n to=199n
if write_never_0_PD_YB > 0.5
 let failures = failures + 1
end
meas tran pd_rise_delay_0 trig v(WRITE_EN) val=2.5 rise=1 td=49n targ v(PD_Y) val=2.5 rise=1 td=49n
meas tran pd_fall_delay_0 trig v(WRITE_EN) val=2.5 fall=1 td=154n targ v(PD_Y) val=2.5 fall=1 td=154n
meas tran write_disabled_1_PD_Y max v(PD_Y) from=202n to=249n
if write_disabled_1_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_released_1_PD_Y max v(PD_Y) from=365n to=399n
if write_released_1_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_active_1_PD_Y max v(PD_Y) from=260n to=354n
if write_active_1_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_never_1_PD_Y max v(PD_Y) from=202n to=399n
if write_never_1_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_disabled_1_PD_YB max v(PD_YB) from=202n to=249n
if write_disabled_1_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_released_1_PD_YB max v(PD_YB) from=365n to=399n
if write_released_1_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_active_1_PD_YB min v(PD_YB) from=260n to=354n
if write_active_1_PD_YB < 4.5
 let failures = failures + 1
end
meas tran pd_rise_delay_1 trig v(WRITE_EN) val=2.5 rise=1 td=249n targ v(PD_YB) val=2.5 rise=1 td=249n
meas tran pd_fall_delay_1 trig v(WRITE_EN) val=2.5 fall=1 td=354n targ v(PD_YB) val=2.5 fall=1 td=354n
meas tran write_disabled_2_PD_Y max v(PD_Y) from=402n to=449n
if write_disabled_2_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_released_2_PD_Y max v(PD_Y) from=565n to=599n
if write_released_2_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_active_2_PD_Y max v(PD_Y) from=460n to=554n
if write_active_2_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_never_2_PD_Y max v(PD_Y) from=402n to=599n
if write_never_2_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_disabled_2_PD_YB max v(PD_YB) from=402n to=449n
if write_disabled_2_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_released_2_PD_YB max v(PD_YB) from=565n to=599n
if write_released_2_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_active_2_PD_YB min v(PD_YB) from=460n to=554n
if write_active_2_PD_YB < 4.5
 let failures = failures + 1
end
meas tran pd_rise_delay_2 trig v(WRITE_EN) val=2.5 rise=1 td=449n targ v(PD_YB) val=2.5 rise=1 td=449n
meas tran pd_fall_delay_2 trig v(WRITE_EN) val=2.5 fall=1 td=554n targ v(PD_YB) val=2.5 fall=1 td=554n
meas tran write_disabled_3_PD_Y max v(PD_Y) from=602n to=649n
if write_disabled_3_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_released_3_PD_Y max v(PD_Y) from=765n to=799n
if write_released_3_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_active_3_PD_Y min v(PD_Y) from=660n to=754n
if write_active_3_PD_Y < 4.5
 let failures = failures + 1
end
meas tran write_disabled_3_PD_YB max v(PD_YB) from=602n to=649n
if write_disabled_3_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_released_3_PD_YB max v(PD_YB) from=765n to=799n
if write_released_3_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_active_3_PD_YB max v(PD_YB) from=660n to=754n
if write_active_3_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_never_3_PD_YB max v(PD_YB) from=602n to=799n
if write_never_3_PD_YB > 0.5
 let failures = failures + 1
end
meas tran pd_rise_delay_3 trig v(WRITE_EN) val=2.5 rise=1 td=649n targ v(PD_Y) val=2.5 rise=1 td=649n
meas tran pd_fall_delay_3 trig v(WRITE_EN) val=2.5 fall=1 td=754n targ v(PD_Y) val=2.5 fall=1 td=754n
meas tran write_disabled_4_PD_Y max v(PD_Y) from=802n to=849n
if write_disabled_4_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_released_4_PD_Y max v(PD_Y) from=965n to=999n
if write_released_4_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_active_4_PD_Y max v(PD_Y) from=860n to=954n
if write_active_4_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_never_4_PD_Y max v(PD_Y) from=802n to=999n
if write_never_4_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_disabled_4_PD_YB max v(PD_YB) from=802n to=849n
if write_disabled_4_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_released_4_PD_YB max v(PD_YB) from=965n to=999n
if write_released_4_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_active_4_PD_YB max v(PD_YB) from=860n to=954n
if write_active_4_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_never_4_PD_YB max v(PD_YB) from=802n to=999n
if write_never_4_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_disabled_5_PD_Y max v(PD_Y) from=1002n to=1049n
if write_disabled_5_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_released_5_PD_Y max v(PD_Y) from=1165n to=1199n
if write_released_5_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_active_5_PD_Y max v(PD_Y) from=1060n to=1154n
if write_active_5_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_never_5_PD_Y max v(PD_Y) from=1002n to=1199n
if write_never_5_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_disabled_5_PD_YB max v(PD_YB) from=1002n to=1049n
if write_disabled_5_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_released_5_PD_YB max v(PD_YB) from=1165n to=1199n
if write_released_5_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_active_5_PD_YB max v(PD_YB) from=1060n to=1154n
if write_active_5_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_never_5_PD_YB max v(PD_YB) from=1002n to=1199n
if write_never_5_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_disabled_6_PD_Y max v(PD_Y) from=1202n to=1249n
if write_disabled_6_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_released_6_PD_Y max v(PD_Y) from=1365n to=1399n
if write_released_6_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_active_6_PD_Y max v(PD_Y) from=1260n to=1354n
if write_active_6_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_never_6_PD_Y max v(PD_Y) from=1202n to=1399n
if write_never_6_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_disabled_6_PD_YB max v(PD_YB) from=1202n to=1249n
if write_disabled_6_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_released_6_PD_YB max v(PD_YB) from=1365n to=1399n
if write_released_6_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_active_6_PD_YB max v(PD_YB) from=1260n to=1354n
if write_active_6_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_never_6_PD_YB max v(PD_YB) from=1202n to=1399n
if write_never_6_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_disabled_7_PD_Y max v(PD_Y) from=1402n to=1449n
if write_disabled_7_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_released_7_PD_Y max v(PD_Y) from=1565n to=1599n
if write_released_7_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_active_7_PD_Y max v(PD_Y) from=1460n to=1554n
if write_active_7_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_never_7_PD_Y max v(PD_Y) from=1402n to=1599n
if write_never_7_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_disabled_7_PD_YB max v(PD_YB) from=1402n to=1449n
if write_disabled_7_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_released_7_PD_YB max v(PD_YB) from=1565n to=1599n
if write_released_7_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_active_7_PD_YB max v(PD_YB) from=1460n to=1554n
if write_active_7_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_never_7_PD_YB max v(PD_YB) from=1402n to=1599n
if write_never_7_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_disabled_8_PD_Y max v(PD_Y) from=1602n to=1649n
if write_disabled_8_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_released_8_PD_Y max v(PD_Y) from=1765n to=1799n
if write_released_8_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_active_8_PD_Y max v(PD_Y) from=1660n to=1754n
if write_active_8_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_never_8_PD_Y max v(PD_Y) from=1602n to=1799n
if write_never_8_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_disabled_8_PD_YB max v(PD_YB) from=1602n to=1649n
if write_disabled_8_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_released_8_PD_YB max v(PD_YB) from=1765n to=1799n
if write_released_8_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_active_8_PD_YB min v(PD_YB) from=1660n to=1754n
if write_active_8_PD_YB < 4.5
 let failures = failures + 1
end
meas tran pd_rise_delay_8 trig v(WRITE_EN) val=2.5 rise=1 td=1649n targ v(PD_YB) val=2.5 rise=1 td=1649n
meas tran pd_fall_delay_8 trig v(WRITE_EN) val=2.5 fall=1 td=1754n targ v(PD_YB) val=2.5 fall=1 td=1754n
meas tran write_disabled_9_PD_Y max v(PD_Y) from=1802n to=1849n
if write_disabled_9_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_released_9_PD_Y max v(PD_Y) from=1965n to=1999n
if write_released_9_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_active_9_PD_Y min v(PD_Y) from=1860n to=1954n
if write_active_9_PD_Y < 4.5
 let failures = failures + 1
end
meas tran write_disabled_9_PD_YB max v(PD_YB) from=1802n to=1849n
if write_disabled_9_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_released_9_PD_YB max v(PD_YB) from=1965n to=1999n
if write_released_9_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_active_9_PD_YB max v(PD_YB) from=1860n to=1954n
if write_active_9_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_never_9_PD_YB max v(PD_YB) from=1802n to=1999n
if write_never_9_PD_YB > 0.5
 let failures = failures + 1
end
meas tran pd_rise_delay_9 trig v(WRITE_EN) val=2.5 rise=1 td=1849n targ v(PD_Y) val=2.5 rise=1 td=1849n
meas tran pd_fall_delay_9 trig v(WRITE_EN) val=2.5 fall=1 td=1954n targ v(PD_Y) val=2.5 fall=1 td=1954n
meas tran write_disabled_10_PD_Y max v(PD_Y) from=2002n to=2049n
if write_disabled_10_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_released_10_PD_Y max v(PD_Y) from=2165n to=2199n
if write_released_10_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_active_10_PD_Y min v(PD_Y) from=2060n to=2154n
if write_active_10_PD_Y < 4.5
 let failures = failures + 1
end
meas tran write_disabled_10_PD_YB max v(PD_YB) from=2002n to=2049n
if write_disabled_10_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_released_10_PD_YB max v(PD_YB) from=2165n to=2199n
if write_released_10_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_active_10_PD_YB max v(PD_YB) from=2060n to=2154n
if write_active_10_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_never_10_PD_YB max v(PD_YB) from=2002n to=2199n
if write_never_10_PD_YB > 0.5
 let failures = failures + 1
end
meas tran pd_rise_delay_10 trig v(WRITE_EN) val=2.5 rise=1 td=2049n targ v(PD_Y) val=2.5 rise=1 td=2049n
meas tran pd_fall_delay_10 trig v(WRITE_EN) val=2.5 fall=1 td=2154n targ v(PD_Y) val=2.5 fall=1 td=2154n
meas tran write_disabled_11_PD_Y max v(PD_Y) from=2202n to=2249n
if write_disabled_11_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_released_11_PD_Y max v(PD_Y) from=2365n to=2399n
if write_released_11_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_active_11_PD_Y max v(PD_Y) from=2260n to=2354n
if write_active_11_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_never_11_PD_Y max v(PD_Y) from=2202n to=2399n
if write_never_11_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_disabled_11_PD_YB max v(PD_YB) from=2202n to=2249n
if write_disabled_11_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_released_11_PD_YB max v(PD_YB) from=2365n to=2399n
if write_released_11_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_active_11_PD_YB min v(PD_YB) from=2260n to=2354n
if write_active_11_PD_YB < 4.5
 let failures = failures + 1
end
meas tran pd_rise_delay_11 trig v(WRITE_EN) val=2.5 rise=1 td=2249n targ v(PD_YB) val=2.5 rise=1 td=2249n
meas tran pd_fall_delay_11 trig v(WRITE_EN) val=2.5 fall=1 td=2354n targ v(PD_YB) val=2.5 fall=1 td=2354n
meas tran write_disabled_12_PD_Y max v(PD_Y) from=2402n to=2449n
if write_disabled_12_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_released_12_PD_Y max v(PD_Y) from=2565n to=2599n
if write_released_12_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_active_12_PD_Y max v(PD_Y) from=2460n to=2554n
if write_active_12_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_never_12_PD_Y max v(PD_Y) from=2402n to=2599n
if write_never_12_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_disabled_12_PD_YB max v(PD_YB) from=2402n to=2449n
if write_disabled_12_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_released_12_PD_YB max v(PD_YB) from=2565n to=2599n
if write_released_12_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_active_12_PD_YB max v(PD_YB) from=2460n to=2554n
if write_active_12_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_never_12_PD_YB max v(PD_YB) from=2402n to=2599n
if write_never_12_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_disabled_13_PD_Y max v(PD_Y) from=2602n to=2649n
if write_disabled_13_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_released_13_PD_Y max v(PD_Y) from=2765n to=2799n
if write_released_13_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_active_13_PD_Y max v(PD_Y) from=2660n to=2754n
if write_active_13_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_never_13_PD_Y max v(PD_Y) from=2602n to=2799n
if write_never_13_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_disabled_13_PD_YB max v(PD_YB) from=2602n to=2649n
if write_disabled_13_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_released_13_PD_YB max v(PD_YB) from=2765n to=2799n
if write_released_13_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_active_13_PD_YB max v(PD_YB) from=2660n to=2754n
if write_active_13_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_never_13_PD_YB max v(PD_YB) from=2602n to=2799n
if write_never_13_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_disabled_14_PD_Y max v(PD_Y) from=2802n to=2849n
if write_disabled_14_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_released_14_PD_Y max v(PD_Y) from=2965n to=2999n
if write_released_14_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_active_14_PD_Y max v(PD_Y) from=2860n to=2954n
if write_active_14_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_never_14_PD_Y max v(PD_Y) from=2802n to=2999n
if write_never_14_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_disabled_14_PD_YB max v(PD_YB) from=2802n to=2849n
if write_disabled_14_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_released_14_PD_YB max v(PD_YB) from=2965n to=2999n
if write_released_14_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_active_14_PD_YB max v(PD_YB) from=2860n to=2954n
if write_active_14_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_never_14_PD_YB max v(PD_YB) from=2802n to=2999n
if write_never_14_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_disabled_15_PD_Y max v(PD_Y) from=3002n to=3049n
if write_disabled_15_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_released_15_PD_Y max v(PD_Y) from=3165n to=3199n
if write_released_15_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_active_15_PD_Y max v(PD_Y) from=3060n to=3154n
if write_active_15_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_never_15_PD_Y max v(PD_Y) from=3002n to=3199n
if write_never_15_PD_Y > 0.5
 let failures = failures + 1
end
meas tran write_disabled_15_PD_YB max v(PD_YB) from=3002n to=3049n
if write_disabled_15_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_released_15_PD_YB max v(PD_YB) from=3165n to=3199n
if write_released_15_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_active_15_PD_YB max v(PD_YB) from=3060n to=3154n
if write_active_15_PD_YB > 0.5
 let failures = failures + 1
end
meas tran write_never_15_PD_YB max v(PD_YB) from=3002n to=3199n
if write_never_15_PD_YB > 0.5
 let failures = failures + 1
end
if failures = 0
 echo PASS: write control, row and column decoder selection, mux writes, sensed reads, reset and retention
else
 echo FAIL: inspect measurements
 print failures
end
write sram_tb_array_write_control.raw
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
plot v(RA) v(WL_EN) v(WL0) v(WL1) xlimit 0 400n title 'ROW DECODER: disabled address changes then one selected WL'
plot v(WL_EN) v(xrow.WL0_B) v(WL0) xlimit 65n 85n title 'ROW DRIVER: NAND output and actual WL'
plot v(CA) v(COL0) v(COL1) xlimit 0 400n title 'COLUMN DECODER: always one selected after CA settles'
plot v(CA) v(COL0) v(COL1) v(Y) v(YB) xlimit 200n 245n title 'ADDRESS CHANGE: all WL LOW; bitlines recharged before access'
plot v(DIN) v(WRITE_EN) v(PD_Y) v(PD_YB) xlimit 0 400n title 'WRITE CONTROL: DIN changes while disabled; one pull-down selected'
plot v(WRITE_EN) v(xwrite.PD_Y_B) v(PD_Y) v(WL0) xlimit 45n 85n title 'WRITE TIMING: pull-down settles before actual WL rises'
.endc"}
C {devices/netlist_options.sym} 2250 1900 0 0 {name=NETLIST_OPTIONS
lvs_netlist=false
top_is_subckt=false
spiceprefix=true
hiersep=. }

C {row_decoder_1to2.sym} -500 470 0 0 {name=xrow}
N -320 340 -180 340 {lab=WL0}
N -320 610 -180 610 {lab=WL1}
C {devices/lab_pin.sym} -680 430 2 0 {name=l3 lab=RA}
C {devices/lab_pin.sym} -680 510 2 0 {name=l4 lab=WL_EN}
C {devices/lab_pin.sym} -500 270 2 0 {name=l5 lab=VDD}
C {devices/lab_pin.sym} -500 670 2 0 {name=l6 lab=GND}
T {ROW SELECT | RA changes only with WL_EN LOW} -780 180 0 0 0.3 0.3 {}

C {col_decoder_1to2.sym} -500 980 0 0 {name=xcol}
C {devices/lab_pin.sym} -680 940 0 0 {name=col_ca lab=CA}
C {devices/lab_pin.sym} -500 780 0 0 {name=col_vdd lab=VDD}
C {devices/gnd.sym} -500 1180 0 0 {name=col_gnd lab=GND}
N -320 850 -200 850 {lab=COL0}
N -200 770 -200 850 {lab=COL0}
N -200 770 -100 770 {lab=COL0}
N -320 1120 -150 1120 {lab=COL1}
N -150 900 -150 1120 {lab=COL1}
N -150 900 680 900 {lab=COL1}
N 680 770 680 900 {lab=COL1}
N 680 770 700 770 {lab=COL1}
T {COLUMN SELECT | switch CA with WL LOW and PD OFF} -800 1250 0 0 0.27 0.27 {}
C {devices/lab_pin.sym} -200 850 2 0 {name=col0_label lab=COL0}
C {devices/lab_pin.sym} -150 1120 2 0 {name=col1_label lab=COL1}

C {write_control.sym} -500 1510 0 0 {name=xwrite}
C {devices/lab_pin.sym} -680 1470 0 0 {name=write_din lab=DIN}
C {devices/lab_pin.sym} -680 1550 0 0 {name=write_en lab=WRITE_EN}
C {devices/lab_pin.sym} -500 1310 0 0 {name=write_vdd lab=VDD}
C {devices/gnd.sym} -500 1710 0 0 {name=write_gnd lab=GND}
N -320 1380 -80 1380 {lab=PD_Y}
N -80 1380 -80 1510 {lab=PD_Y}
N -80 1510 110 1510 {lab=PD_Y}
N -320 1650 -220 1650 {lab=PD_YB}
N -220 1430 -220 1650 {lab=PD_YB}
N -220 1430 500 1430 {lab=PD_YB}
N 500 1430 500 1510 {lab=PD_YB}
N 500 1510 610 1510 {lab=PD_YB}
T {WRITE CONTROL | DIN stable while WRITE_EN HIGH} -800 1780 0 0 0.27 0.27 {}
