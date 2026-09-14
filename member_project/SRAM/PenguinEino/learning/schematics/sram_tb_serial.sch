v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
E {}
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
C {devices/noconn.sym} 430 220 0 0 {name=nc_Q00}
N 400 240 430 240 {lab=QB00}
C {devices/lab_pin.sym} 430 240 2 0 {name=wirelabel53 lab=QB00}
C {devices/noconn.sym} 430 240 0 0 {name=nc_QB00}
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
C {devices/noconn.sym} 430 490 0 0 {name=nc_Q10}
N 400 510 430 510 {lab=QB10}
C {devices/lab_pin.sym} 430 510 2 0 {name=wirelabel65 lab=QB10}
C {devices/noconn.sym} 430 510 0 0 {name=nc_QB10}
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
C {devices/noconn.sym} 1230 220 0 0 {name=nc_Q01}
N 1200 240 1230 240 {lab=QB01}
C {devices/lab_pin.sym} 1230 240 2 0 {name=wirelabel111 lab=QB01}
C {devices/noconn.sym} 1230 240 0 0 {name=nc_QB01}
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
C {devices/noconn.sym} 1230 490 0 0 {name=nc_Q11}
N 1200 510 1230 510 {lab=QB11}
C {devices/lab_pin.sym} 1230 510 2 0 {name=wirelabel123 lab=QB11}
C {devices/noconn.sym} 1230 510 0 0 {name=nc_QB11}
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
C {row_decoder_1to2.sym} -500 470 0 0 {name=xrow}
N -320 340 -180 340 {lab=WL0}
N -320 610 -180 610 {lab=WL1}
C {devices/lab_pin.sym} -500 270 2 0 {name=l5 lab=VDD}
C {devices/lab_pin.sym} -500 670 2 0 {name=l6 lab=GND}
C {col_decoder_1to2.sym} -500 980 0 0 {name=xcol}
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
C {devices/lab_pin.sym} -200 850 2 0 {name=col0_label lab=COL0}
C {devices/lab_pin.sym} -150 1120 2 0 {name=col1_label lab=COL1}
C {write_control.sym} -500 1510 0 0 {name=xwrite}
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
T {SERIAL 2 x 2 SRAM | 7-pin interface | real standard-cell controller} -2130 -350 0 0 0.43 0.43 {}
T {SRAM cells above / column mux and common lines in the middle / shared write and sense below} -800 -250 0 0 0.27 0.27 {}
T {COLUMN 0} 100 -175 0 0 0.3 0.3 {}
T {COLUMN 1} 900 -175 0 0 0.3 0.3 {}
T {ROW DECODE} -680 180 0 0 0.3 0.3 {}
T {COLUMN DECODE} -730 1240 0 0 0.27 0.27 {}
T {COMMON PRECHARGE / WRITE / SENSE} -180 1730 0 0 0.3 0.3 {}
T {CBL=10f, CY=100f: added learning loads, not extracted capacitance} -180 1790 0 0 0.25 0.25 {}
C {sram_serial_controller.sym} -1450 2280 0 0 {name=xctrl}
C {devices/lab_pin.sym} -1450 1890 0 0 {name=l227 lab=VDD}
C {devices/lab_pin.sym} -1450 2670 0 0 {name=l228 lab=GND}
N -1150 2035 -1050 2035 {lab=RA}
N -1050 2035 -1050 430 {lab=RA}
N -1050 430 -680 430 {lab=RA}
C {devices/lab_pin.sym} -680 430 0 0 {name=l232 lab=RA}
N -1150 2105 -1010 2105 {lab=CA}
N -1010 2105 -1010 940 {lab=CA}
N -1010 940 -680 940 {lab=CA}
C {devices/lab_pin.sym} -680 940 0 0 {name=l236 lab=CA}
N -1150 2175 -970 2175 {lab=DIN}
N -970 2175 -970 1470 {lab=DIN}
N -970 1470 -680 1470 {lab=DIN}
C {devices/lab_pin.sym} -680 1470 0 0 {name=l240 lab=DIN}
N -1150 2385 -930 2385 {lab=WL_EN}
N -930 2385 -930 510 {lab=WL_EN}
N -930 510 -680 510 {lab=WL_EN}
C {devices/lab_pin.sym} -680 510 0 0 {name=l244 lab=WL_EN}
N -1150 2315 -890 2315 {lab=WRITE_EN}
N -890 2315 -890 1550 {lab=WRITE_EN}
N -890 1550 -680 1550 {lab=WRITE_EN}
C {devices/lab_pin.sym} -680 1550 0 0 {name=l248 lab=WRITE_EN}
N -1150 2245 -810 2245 {lab=PREB}
N -810 2245 -810 -40 {lab=PREB}
N -810 -40 1260 -40 {lab=PREB}
N -40 -40 -40 0 {lab=PREB}
N 460 -40 460 0 {lab=PREB}
N 760 -40 760 0 {lab=PREB}
N 1260 -40 1260 0 {lab=PREB}
N -810 1070 610 1070 {lab=PREB}
N 610 1070 610 1170 {lab=PREB}
N 110 1070 110 1170 {lab=PREB}
C {devices/lab_wire.sym} -810 -40 0 0 {name=l259 lab=PREB}
N -1150 2455 930 2455 {lab=SAE}
N 930 2455 930 1440 {lab=SAE}
N 930 1440 1000 1440 {lab=SAE}
C {devices/lab_wire.sym} 930 2455 0 0 {name=l263 lab=SAE}
N 1500 1320 1860 1320 {lab=SOUT}
N 1860 1320 1860 2750 {lab=SOUT}
N 1860 2750 -1840 2750 {lab=SOUT}
N -1840 2750 -1840 2450 {lab=SOUT}
N -1840 2450 -1750 2450 {lab=SOUT}
N -1150 2525 -540 2525 {lab=SDO}
C {devices/opin.sym} -540 2525 0 0 {name=pSDO lab=SDO}
C {devices/capa.sym} -620 2605 0 0 {name=CSDO value=10f m=1}
N -620 2525 -620 2575 {lab=SDO}
C {devices/gnd.sym} -620 2635 0 0 {name=g_sdo lab=GND}
C {devices/vsource.sym} -2070 2140 0 0 {name=VCLK
value="PWL(0n 0 250n 0 251n 5 300n 5 301n 0 350n 0 351n 5 400n 5 401n 0 450n 0 451n 5 500n 5 501n 0 550n 0 551n 5 600n 5 601n 0 650n 0 651n 5 700n 5 701n 0 750n 0 751n 5 800n 5 801n 0 850n 0 851n 5 900n 5 901n 0 950n 0 951n 5 1000n 5 1001n 0 1050n 0 1051n 5 1100n 5 1101n 0 1150n 0 1151n 5 1200n 5 1201n 0 1250n 0 1251n 5 1300n 5 1301n 0 1350n 0 1351n 5 1400n 5 1401n 0 1450n 0 1451n 5 1500n 5 1501n 0 1550n 0 1551n 5 1600n 5 1601n 0 1650n 0 1651n 5 1700n 5 1701n 0 1750n 0 1751n 5 1800n 5 1801n 0 1850n 0 1851n 5 1900n 5 1901n 0 1950n 0 1951n 5 2000n 5 2001n 0 2050n 0 2051n 5 2100n 5 2101n 0 2150n 0 2151n 5 2200n 5 2201n 0 2250n 0 2251n 5 2300n 5 2301n 0 2350n 0 2351n 5 2400n 5 2401n 0 2450n 0 2451n 5 2500n 5 2501n 0 2550n 0 2551n 5 2600n 5 2601n 0 2650n 0 2651n 5 2700n 5 2701n 0 2750n 0 2751n 5 2800n 5 2801n 0 2850n 0 2851n 5 2900n 5 2901n 0 2950n 0 2951n 5 3000n 5 3001n 0 3050n 0 3051n 5 3100n 5 3101n 0 3150n 0 3151n 5 3200n 5 3201n 0 3250n 0 3251n 5 3300n 5 3301n 0 3350n 0 3351n 5 3400n 5 3401n 0 3450n 0 3451n 5 3500n 5 3501n 0 3550n 0 3551n 5 3600n 5 3601n 0 3650n 0 3651n 5 3700n 5 3701n 0 3750n 0 3751n 5 3800n 5 3801n 0 3850n 0 3851n 5 3900n 5 3901n 0 3950n 0 3951n 5 4000n 5 4001n 0 4050n 0 4051n 5 4100n 5 4101n 0 4150n 0 4151n 5 4200n 5 4201n 0 4250n 0 4251n 5 4300n 5 4301n 0 4350n 0 4351n 5 4400n 5 4401n 0 4450n 0 4451n 5 4500n 5 4501n 0 4550n 0 4551n 5 4600n 5 4601n 0 4650n 0 4651n 5 4700n 5 4701n 0 4750n 0 4751n 5 4800n 5 4801n 0 4850n 0 4851n 5 4900n 5 4901n 0 4950n 0 4951n 5 5000n 5 5001n 0 5050n 0 5051n 5 5100n 5 5101n 0 5150n 0 5151n 5 5200n 5 5201n 0 5250n 0 5251n 5 5300n 5 5301n 0 5350n 0 5351n 5 5400n 5 5401n 0 5450n 0 5451n 5 5500n 5 5501n 0 5550n 0 5551n 5 5600n 5 5601n 0 5650n 0 5651n 5 5700n 5 5701n 0 5750n 0 5751n 5 5800n 5 5801n 0 5850n 0 5851n 5 5900n 5 5901n 0 5950n 0 5951n 5 6000n 5 6001n 0 6050n 0 6051n 5 6100n 5 6101n 0 6150n 0 6151n 5 6200n 5 6201n 0 6250n 0 6251n 5 6300n 5 6301n 0 6350n 0 6351n 5 6400n 5 6401n 0 6450n 0 6451n 5 6500n 5 6501n 0 6550n 0 6551n 5 6600n 5 6601n 0 6650n 0 6651n 5 6700n 5 6701n 0 6750n 0 6751n 5 6800n 5 6801n 0 6850n 0 6851n 5 6900n 5 6901n 0 6950n 0 6951n 5 7000n 5 7001n 0 7050n 0 7051n 5 7100n 5 7101n 0 7150n 0 7151n 5 7200n 5 7201n 0 7250n 0 7251n 5 7300n 5 7301n 0 7350n 0 7351n 5 7400n 5 7401n 0 7450n 0 7451n 5 7500n 5 7501n 0 7550n 0 7551n 5 7600n 5 7601n 0 7650n 0 7651n 5 7700n 5 7701n 0 7750n 0 7751n 5 7800n 5 7801n 0 7850n 0 7851n 5 7900n 5 7901n 0 7950n 0 7951n 5 8000n 5 8001n 0 8050n 0 8051n 5 8100n 5 8101n 0 8150n 0 8151n 5 8200n 5 8201n 0 8250n 0 8251n 5 8300n 5 8301n 0 8350n 0 8351n 5 8400n 5 8401n 0 8450n 0 8451n 5 8500n 5 8501n 0 8550n 0 8551n 5 8600n 5 8601n 0 8650n 0 8651n 5 8700n 5 8701n 0 8750n 0 8751n 5 8800n 5 8801n 0 8850n 0 8851n 5 8900n 5 8901n 0 8950n 0 8951n 5 9000n 5 9001n 0 9050n 0 9051n 5 9100n 5 9101n 0 9150n 0 9151n 5 9200n 5 9201n 0 9250n 0 9251n 5 9300n 5 9301n 0 9350n 0 9351n 5 9400n 5 9401n 0 9450n 0 9451n 5 9500n 5 9501n 0 9550n 0 9551n 5 9600n 5 9601n 0 9650n 0 9651n 5 9700n 5 9701n 0 9750n 0 9751n 5 9800n 5 9801n 0 9850n 0 9851n 5 9900n 5 9901n 0 9950n 0 9951n 5 10000n 5 10001n 0 10050n 0 10051n 5 10100n 5 10101n 0 10150n 0 10151n 5 10200n 5 10201n 0 10250n 0 10251n 5 10300n 5 10301n 0 10350n 0 10351n 5 10400n 5 10401n 0 10450n 0 10451n 5 10500n 5 10501n 0 10550n 0 10551n 5 10600n 5 10601n 0 10650n 0 10651n 5 10700n 5 10701n 0 10750n 0 10751n 5 10800n 5 10801n 0 10850n 0 10851n 5 10900n 5 10901n 0 10950n 0 10951n 5 11000n 5 11001n 0 11050n 0 11051n 5 11100n 5 11101n 0 11150n 0 11151n 5 11200n 5 11201n 0 11250n 0 11251n 5 11300n 5 11301n 0 11350n 0 11351n 5 11400n 5 11401n 0 11450n 0 11451n 5 11500n 5 11501n 0 11550n 0 11551n 5 11600n 5 11601n 0 11650n 0 11651n 5 11700n 5 11701n 0 11750n 0 11751n 5 11800n 5 11801n 0 11850n 0 11851n 5 11900n 5 11901n 0 11950n 0 11951n 5 12000n 5 12001n 0 12050n 0 12051n 5 12100n 5 12101n 0 12150n 0 12151n 5 12200n 5 12201n 0 12250n 0 12251n 5 12300n 5 12301n 0 12350n 0 12351n 5 12400n 5 12401n 0 12450n 0 12451n 5 12500n 5 12501n 0 12550n 0 12551n 5 12600n 5 12601n 0 12650n 0 12651n 5 12700n 5 12701n 0 12750n 0 12751n 5 12800n 5 12801n 0 12850n 0 12851n 5 12900n 5 12901n 0 12950n 0 12951n 5 13000n 5 13001n 0 13050n 0 13051n 5 13100n 5 13101n 0 13150n 0 13151n 5 13200n 5 13201n 0 13250n 0 13251n 5 13300n 5 13301n 0 13350n 0 13351n 5 13400n 5 13401n 0 13450n 0 13451n 5 13500n 5 13501n 0 13550n 0 13551n 5 13600n 5 13601n 0 13650n 0 13651n 5 13700n 5 13701n 0 13750n 0 13751n 5 13800n 5 13801n 0 13850n 0 13851n 5 13900n 5 13901n 0 13950n 0 13951n 5 14000n 5 14001n 0 14050n 0 14051n 5 14100n 5 14101n 0 14150n 0 14151n 5 14200n 5 14201n 0 14250n 0 14251n 5 14300n 5 14301n 0 14350n 0 14351n 5 14400n 5 14401n 0 14450n 0 14451n 5 14500n 5 14501n 0 14550n 0 14551n 5 14600n 5 14601n 0 14650n 0 14651n 5 14700n 5 14701n 0 14750n 0 14751n 5 14800n 5 14801n 0 14850n 0 14851n 5 14900n 5 14901n 0 14950n 0 14951n 5 15000n 5 15001n 0 15050n 0 15051n 5 15100n 5 15101n 0 15150n 0 15151n 5 15200n 5 15201n 0 15250n 0 15251n 5 15300n 5 15301n 0 15350n 0 15351n 5 15400n 5 15401n 0 15450n 0 15451n 5 15500n 5 15501n 0 15550n 0 15551n 5 15600n 5 15601n 0 15650n 0 15651n 5 15700n 5 15701n 0 15750n 0 15751n 5 15800n 5 15801n 0 15850n 0 15851n 5 15900n 5 15901n 0 15950n 0 15951n 5 16000n 5 16001n 0 16050n 0 16051n 5 16100n 5 16101n 0 16150n 0 16151n 5 16200n 5 16201n 0 16250n 0 16251n 5 16300n 5 16301n 0 16350n 0 16351n 5 16400n 5 16401n 0 16450n 0 16451n 5 16500n 5 16501n 0 16550n 0 16551n 5 16600n 5 16601n 0 16650n 0 16651n 5 16700n 5 16701n 0 16750n 0 16751n 5 16800n 5 16801n 0 16850n 0 16851n 5 16900n 5 16901n 0 16950n 0 16951n 5 17000n 5 17001n 0 17050n 0 17051n 5 17100n 5 17101n 0 17150n 0 17151n 5 17200n 5 17201n 0 17250n 0 17251n 5 17300n 5 17301n 0 17350n 0 17351n 5 17400n 5 17401n 0 17450n 0 17451n 5 17500n 5 17501n 0 17550n 0 17551n 5 17600n 5 17601n 0 17650n 0 17651n 5 17700n 5 17701n 0 17750n 0 17751n 5 17800n 5 17801n 0 17850n 0 17851n 5 17900n 5 17901n 0 17950n 0 17951n 5 18000n 5 18001n 0 18280n 0 18281n 5 18330n 5 18331n 0 18380n 0 18381n 5 18430n 5 18431n 0 18480n 0 18481n 5 18530n 5 18531n 0 18580n 0 18581n 5 18630n 5 18631n 0 18680n 0 18681n 5 18730n 5 18731n 0 18780n 0 18781n 5 18830n 5 18831n 0 18880n 0 18881n 5 18930n 5 18931n 0 18980n 0 18981n 5 19030n 5 19031n 0 19080n 0 19081n 5 19130n 5 19131n 0 19180n 0 19181n 5 19230n 5 19231n 0 19280n 0 19281n 5 19330n 5 19331n 0 19380n 0 19381n 5 19430n 5 19431n 0 19480n 0 19481n 5 19530n 5 19531n 0 19580n 0 19581n 5 19630n 5 19631n 0 19680n 0 19681n 5 19730n 5 19731n 0 19780n 0 19781n 5 19830n 5 19831n 0 19880n 0 19881n 5 19930n 5 19931n 0 19980n 0 19981n 5 20030n 5 20031n 0 20080n 0 20081n 5 20130n 5 20131n 0 20180n 0 20181n 5 20230n 5 20231n 0 20280n 0 20281n 5 20330n 5 20331n 0 20380n 0 20381n 5 20430n 5 20431n 0 20480n 0 20481n 5 20530n 5 20531n 0 20580n 0 20581n 5 20630n 5 20631n 0 20680n 0 20681n 5 20730n 5 20731n 0 20780n 0 20781n 5 20830n 5 20831n 0 20880n 0 20881n 5 20930n 5 20931n 0 20980n 0 20981n 5 21030n 5 21031n 0 21080n 0 21081n 5 21130n 5 21131n 0 21180n 0 21181n 5 21230n 5 21231n 0 21280n 0 21281n 5 21330n 5 21331n 0 21380n 0 21381n 5 21430n 5 21431n 0 21480n 0 21481n 5 21530n 5 21531n 0 21680n 0)"
savecurrent=false
hide_texts=true}
N -2070 2110 -1750 2110 {lab=CLK}
C {devices/lab_wire.sym} -1970 2110 0 0 {name=l276 lab=CLK}
C {devices/gnd.sym} -2070 2170 0 0 {name=g_CLK lab=GND}
C {devices/vsource.sym} -2070 2225 0 0 {name=VRESET
value="PWL(0n 5 120n 5 121n 0 18030n 0 18031n 5 18160n 5 18161n 0 21680n 0)"
savecurrent=false
hide_texts=true}
N -2070 2195 -1750 2195 {lab=RESET}
C {devices/lab_wire.sym} -1970 2195 0 0 {name=l280 lab=RESET}
C {devices/gnd.sym} -2070 2255 0 0 {name=g_RESET lab=GND}
C {devices/vsource.sym} -2070 2310 0 0 {name=VSDI
value="PWL(0n 0 610n 0 611n 5 710n 5 711n 0 810n 0 811n 5 910n 5 911n 0 1010n 0 1011n 5 1110n 5 1111n 0 1210n 0 1211n 5 1310n 5 1311n 0 1710n 0 1711n 5 1810n 5 1811n 0 1910n 0 1911n 5 2010n 5 2011n 0 2110n 0 2111n 5 2210n 5 2211n 0 2310n 0 2311n 5 2410n 5 2411n 0 2510n 0 2511n 5 2710n 5 2711n 0 2810n 0 2811n 5 2910n 5 2911n 0 3010n 0 3011n 5 3110n 5 3111n 0 3210n 0 3211n 5 3310n 5 3311n 0 3410n 0 3411n 5 3510n 5 3511n 0 3610n 0 3611n 5 3710n 5 3711n 0 3910n 0 3911n 5 4010n 5 4011n 0 4110n 0 4111n 5 4210n 5 4211n 0 4310n 0 4311n 5 4410n 5 4411n 0 4510n 0 4511n 5 4710n 5 4711n 0 4810n 0 4811n 5 4910n 5 4911n 0 5010n 0 5011n 5 5110n 5 5111n 0 5210n 0 5211n 5 5310n 5 5311n 0 5410n 0 5411n 5 5510n 5 5511n 0 5610n 0 5611n 5 5810n 5 5811n 0 6110n 0 6111n 5 6210n 5 6211n 0 6310n 0 6311n 5 6410n 5 6411n 0 6510n 0 6511n 5 6610n 5 6611n 0 6710n 0 6711n 5 7010n 5 7011n 0 7210n 0 7211n 5 7310n 5 7311n 0 7410n 0 7411n 5 7510n 5 7511n 0 7610n 0 7611n 5 7710n 5 7711n 0 7810n 0 7811n 5 8110n 5 8111n 0 8310n 0 8311n 5 8410n 5 8411n 0 8510n 0 8511n 5 8610n 5 8611n 0 8710n 0 8711n 5 8810n 5 8811n 0 8910n 0 8911n 5 9010n 5 9011n 0 9210n 0 9211n 5 9310n 5 9311n 0 9410n 0 9411n 5 9510n 5 9511n 0 9610n 0 9611n 5 9710n 5 9711n 0 9810n 0 9811n 5 9910n 5 9911n 0 10010n 0 10011n 5 10110n 5 10111n 0 10510n 0 10511n 5 10610n 5 10611n 0 10710n 0 10711n 5 10810n 5 10811n 0 10910n 0 10911n 5 11010n 5 11011n 0 11110n 0 11111n 5 11210n 5 11211n 0 11310n 0 11311n 5 11410n 5 11411n 0 11610n 0 11611n 5 11710n 5 11711n 0 11810n 0 11811n 5 11910n 5 11911n 0 12010n 0 12011n 5 12110n 5 12111n 0 12210n 0 12211n 5 12310n 5 12311n 0 12410n 0 12411n 5 12510n 5 12511n 0 12710n 0 12711n 5 12810n 5 12811n 0 12910n 0 12911n 5 13010n 5 13011n 0 13110n 0 13111n 5 13210n 5 13211n 0 13310n 0 13311n 5 13510n 5 13511n 0 13810n 0 13811n 5 13910n 5 13911n 0 14010n 0 14011n 5 14110n 5 14111n 0 14210n 0 14211n 5 14310n 5 14311n 0 14410n 0 14411n 5 14610n 5 14611n 0 14910n 0 14911n 5 15010n 5 15011n 0 15110n 0 15111n 5 15210n 5 15211n 0 15310n 0 15311n 5 15410n 5 15411n 0 15510n 0 15511n 5 15910n 5 15911n 0 16010n 0 16011n 5 16110n 5 16111n 0 16210n 0 16211n 5 16310n 5 16311n 0 16410n 0 16411n 5 16510n 5 16511n 0 16610n 0 16611n 5 16910n 5 16911n 0 17110n 0 17111n 5 17210n 5 17211n 0 17310n 0 17311n 5 17410n 5 17411n 0 17510n 0 17511n 5 17610n 5 17611n 0 17710n 0 17711n 5 18440n 5 18441n 0 18640n 0 18641n 5 18740n 5 18741n 0 18840n 0 18841n 5 18940n 5 18941n 0 19040n 0 19041n 5 19140n 5 19141n 0 19240n 0 19241n 5 19340n 5 19341n 0 19440n 0 19441n 5 19640n 5 19641n 0 19740n 0 19741n 5 19840n 5 19841n 0 19940n 0 19941n 5 20040n 5 20041n 0 20140n 0 20141n 5 20240n 5 20241n 0 20340n 0 20341n 5 20440n 5 20441n 0 20540n 0 20541n 5 20640n 5 20641n 0 20840n 0 20841n 5 20940n 5 20941n 0 21040n 0 21041n 5 21140n 5 21141n 0 21240n 0 21241n 5 21340n 5 21341n 0 21440n 0 21441n 5 21680n 5)"
savecurrent=false
hide_texts=true}
N -2070 2280 -1750 2280 {lab=SDI}
C {devices/lab_wire.sym} -1970 2280 0 0 {name=l284 lab=SDI}
C {devices/gnd.sym} -2070 2340 0 0 {name=g_SDI lab=GND}
C {devices/vsource.sym} -2070 2395 0 0 {name=VWE
value="PWL(0n 0 310n 0 311n 5 410n 5 411n 0 510n 0 511n 5 610n 5 611n 0 1410n 0 1411n 5 1510n 5 1511n 0 1710n 0 1711n 5 2410n 5 2411n 0 2510n 0 2511n 5 2610n 5 2611n 0 2710n 0 2711n 5 2810n 5 2811n 0 3610n 0 3611n 5 3710n 5 3711n 0 3910n 0 3911n 5 4610n 5 4611n 0 4710n 0 4711n 5 4810n 5 4811n 0 4910n 0 4911n 5 5010n 5 5011n 0 5810n 0 5811n 5 5910n 5 5911n 0 6110n 0 6111n 5 6810n 5 6811n 0 6910n 0 6911n 5 7010n 5 7011n 0 7110n 0 7111n 5 7210n 5 7211n 0 8010n 0 8011n 5 8110n 5 8111n 0 8310n 0 8311n 5 9010n 5 9011n 0 9110n 0 9111n 5 9210n 5 9211n 0 9310n 0 9311n 5 9410n 5 9411n 0 10210n 0 10211n 5 10310n 5 10311n 0 10510n 0 10511n 5 11210n 5 11211n 0 11310n 0 11311n 5 11410n 5 11411n 0 11510n 0 11511n 5 11610n 5 11611n 0 12410n 0 12411n 5 12510n 5 12511n 0 12710n 0 12711n 5 13410n 5 13411n 0 13510n 0 13511n 5 13610n 5 13611n 0 13710n 0 13711n 5 13810n 5 13811n 0 14610n 0 14611n 5 14710n 5 14711n 0 14910n 0 14911n 5 15610n 5 15611n 0 15710n 0 15711n 5 15810n 5 15811n 0 15910n 0 15911n 5 16010n 5 16011n 0 16810n 0 16811n 5 16910n 5 16911n 0 17110n 0 17111n 5 17810n 5 17811n 0 18340n 0 18341n 5 18440n 5 18441n 0 18640n 0 18641n 5 19340n 5 19341n 0 19440n 0 19441n 5 19540n 5 19541n 0 19640n 0 19641n 5 19740n 5 19741n 0 20540n 0 20541n 5 20640n 5 20641n 0 20840n 0 20841n 5 21680n 5)"
savecurrent=false
hide_texts=true}
N -2070 2365 -1750 2365 {lab=WE}
C {devices/lab_wire.sym} -1970 2365 0 0 {name=l288 lab=WE}
C {devices/gnd.sym} -2070 2425 0 0 {name=g_WE lab=GND}
C {devices/vsource.sym} -2070 1840 0 0 {name=VVDD value=5 savecurrent=false}
C {devices/lab_pin.sym} -2070 1810 0 0 {name=l291 lab=VDD}
C {devices/gnd.sym} -2070 1870 0 0 {name=g_vdd lab=GND}
T {EXTERNAL INPUTS ONLY} -2140 1960 0 0 0.28 0.28 {}
T {SOUT returns to result FF -> SDO} -300 2720 0 0 0.27 0.27 {}
T {ONE OPERATION = 11 rising edges / CLK=100 ns} 2230 -200 0 0 0.27 0.27 {}
T {RX0: RA / RX1: CA / RX2: DIN (read: dummy 0)} 2230 -152 0 0 0.27 0.27 {}
T {E0: frame held; latch WE; precharge; read SA reset} 2230 -104 0 0 0.27 0.27 {}
T {E1: precharge OFF} 2230 -56 0 0 0.27 0.27 {}
T {E2: write pull-down ON (write only)} 2230 -8 0 0 0.27 0.27 {}
T {E3: WL_EN HIGH} 2230 40 0 0 0.27 0.27 {}
T {E4: SAE HIGH / sense decision} 2230 88 0 0 0.27 0.27 {}
T {E5: WL_EN LOW / write pull-down stays ON} 2230 136 0 0 0.27 0.27 {}
T {E6: release write / latch SOUT into SDO} 2230 184 0 0 0.27 0.27 {}
T {E7: finish / next CLK receives next RA} 2230 232 0 0 0.27 0.27 {}
T {} 2230 280 0 0 0.27 0.27 {}
T {Startup RESET: no CLK until 250 ns.} 2230 328 0 0 0.27 0.27 {}
T {16 checkerboard writes/reads, then partial RX reset.} 2230 376 0 0 0.27 0.27 {}
T {Read old cell after reset, then another write/read.} 2230 424 0 0 0.27 0.27 {}
T {RX shifts RA/CA/DIN; E0..E7 holds. WE sampled at E0.} 2230 472 0 0 0.27 0.27 {}
T {No .ic: only written SRAM cells have expected contents.} 2230 520 0 0 0.27 0.27 {}
T {Q/QB NC markers: waveform probes, no circuit load.} 2230 568 0 0 0.27 0.27 {}
T {} 2230 616 0 0 0.27 0.27 {}
T {CONTROL INTERNALS: descend into xctrl (e).} 2230 664 0 0 0.27 0.27 {}
T {Flat sheet: DFFR + MUX feedback is directly visible.} 2230 712 0 0 0.27 0.27 {}
T {All RST pins use asynchronous RESET; no helper bit symbols.} 2230 760 0 0 0.27 0.27 {}
T {  250 ns RX: W row0 col0 = 0} 2230 860 0 0 0.25 0.25 {}
T { 1350 ns RX: R row0 col0 = 0} 2230 898 0 0 0.25 0.25 {}
T { 2450 ns RX: W row0 col1 = 1} 2230 936 0 0 0.25 0.25 {}
T { 3550 ns RX: R row0 col1 = 1} 2230 974 0 0 0.25 0.25 {}
T { 4650 ns RX: W row1 col0 = 1} 2230 1012 0 0 0.25 0.25 {}
T { 5750 ns RX: R row1 col0 = 1} 2230 1050 0 0 0.25 0.25 {}
T { 6850 ns RX: W row1 col1 = 0} 2230 1088 0 0 0.25 0.25 {}
T { 7950 ns RX: R row1 col1 = 0} 2230 1126 0 0 0.25 0.25 {}
T { 9050 ns RX: W row0 col0 = 1} 2230 1164 0 0 0.25 0.25 {}
T {10150 ns RX: R row0 col0 = 1} 2230 1202 0 0 0.25 0.25 {}
T {11250 ns RX: W row0 col1 = 0} 2230 1240 0 0 0.25 0.25 {}
T {12350 ns RX: R row0 col1 = 0} 2230 1278 0 0 0.25 0.25 {}
T {13450 ns RX: W row1 col0 = 0} 2230 1316 0 0 0.25 0.25 {}
T {14550 ns RX: R row1 col0 = 0} 2230 1354 0 0 0.25 0.25 {}
T {15650 ns RX: W row1 col1 = 1} 2230 1392 0 0 0.25 0.25 {}
T {16750 ns RX: R row1 col1 = 1} 2230 1430 0 0 0.25 0.25 {}
T {18280 ns RX: R row1 col1 = 1} 2230 1468 0 0 0.25 0.25 {}
T {19380 ns RX: W row0 col1 = 1} 2230 1506 0 0 0.25 0.25 {}
T {20480 ns RX: R row0 col1 = 1} 2230 1544 0 0 0.25 0.25 {}
C {devices/code.sym} 2230 1870 0 0 {name=TR_1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"}
C {devices/code.sym} 2590 1870 0 0 {name=SIMULATION
only_toplevel=true
value=".param CBL=10f CY=100f
.control
save v(CLK) v(RESET) v(SDI) v(WE) v(SDO) v(RA) v(CA) v(DIN) v(PREB) v(WL_EN) v(WRITE_EN) v(SAE) v(WL0) v(WL1) v(COL0) v(COL1) v(PD_Y) v(PD_YB) v(BL0) v(BLB0) v(BL1) v(BLB1) v(Y) v(YB) v(SOUT) v(SOUTB) v(Q00) v(Q01) v(Q10) v(Q11) v(QB00) v(QB01) v(QB10) v(QB11) v(xctrl.C0) v(xctrl.C1) v(xctrl.C2) v(xctrl.C3) v(xctrl.W) v(xctrl.RX) v(xctrl.E0) v(xctrl.E1) v(xctrl.E2) v(xctrl.E3) v(xctrl.E4) v(xctrl.E5) v(xctrl.E6) v(xctrl.E7)
tran 0.5n 21680n
let failures = 0
meas tran cell0 find v(Q00) at=1330n
if cell0 > 0.5
 let failures = failures + 1
end
meas tran cell1 find v(Q00) at=2430n
if cell1 > 0.5
 let failures = failures + 1
end
meas tran read1 find v(SDO) at=2330n
if read1 > 0.5
 let failures = failures + 1
end
meas tran cell2 find v(Q01) at=3530n
if cell2 < 4.5
 let failures = failures + 1
end
meas tran cell3 find v(Q01) at=4630n
if cell3 < 4.5
 let failures = failures + 1
end
meas tran read3 find v(SDO) at=4530n
if read3 < 4.5
 let failures = failures + 1
end
meas tran cell4 find v(Q10) at=5730n
if cell4 < 4.5
 let failures = failures + 1
end
meas tran cell5 find v(Q10) at=6830n
if cell5 < 4.5
 let failures = failures + 1
end
meas tran read5 find v(SDO) at=6730n
if read5 < 4.5
 let failures = failures + 1
end
meas tran cell6 find v(Q11) at=7930n
if cell6 > 0.5
 let failures = failures + 1
end
meas tran cell7 find v(Q11) at=9030n
if cell7 > 0.5
 let failures = failures + 1
end
meas tran read7 find v(SDO) at=8930n
if read7 > 0.5
 let failures = failures + 1
end
meas tran cell8 find v(Q00) at=10130n
if cell8 < 4.5
 let failures = failures + 1
end
meas tran cell9 find v(Q00) at=11230n
if cell9 < 4.5
 let failures = failures + 1
end
meas tran read9 find v(SDO) at=11130n
if read9 < 4.5
 let failures = failures + 1
end
meas tran cell10 find v(Q01) at=12330n
if cell10 > 0.5
 let failures = failures + 1
end
meas tran cell11 find v(Q01) at=13430n
if cell11 > 0.5
 let failures = failures + 1
end
meas tran read11 find v(SDO) at=13330n
if read11 > 0.5
 let failures = failures + 1
end
meas tran cell12 find v(Q10) at=14530n
if cell12 > 0.5
 let failures = failures + 1
end
meas tran cell13 find v(Q10) at=15630n
if cell13 > 0.5
 let failures = failures + 1
end
meas tran read13 find v(SDO) at=15530n
if read13 > 0.5
 let failures = failures + 1
end
meas tran cell14 find v(Q11) at=16730n
if cell14 < 4.5
 let failures = failures + 1
end
meas tran cell15 find v(Q11) at=17830n
if cell15 < 4.5
 let failures = failures + 1
end
meas tran read15 find v(SDO) at=17730n
if read15 < 4.5
 let failures = failures + 1
end
meas tran cell16 find v(Q11) at=19360n
if cell16 < 4.5
 let failures = failures + 1
end
meas tran read16 find v(SDO) at=19260n
if read16 < 4.5
 let failures = failures + 1
end
meas tran cell17 find v(Q01) at=20460n
if cell17 < 4.5
 let failures = failures + 1
end
meas tran cell18 find v(Q01) at=21560n
if cell18 < 4.5
 let failures = failures + 1
end
meas tran read18 find v(SDO) at=21460n
if read18 < 4.5
 let failures = failures + 1
end
if failures = 0
 echo PASS: serial writes and reads; run scripts/verify_serial_spice.py for RTL and timing checks
else
 echo FAIL: serial SRAM; inspect measurements
 print failures
end
let count = (v(xctrl.C0)+2*v(xctrl.C1)+4*v(xctrl.C2)+8*v(xctrl.C3))/5
set wr_singlescale
set wr_vecnames
wrdata serial_spice_waveforms.txt v(CLK) v(RESET) v(SDI) v(WE) v(SDO) v(RA) v(CA) v(DIN) v(PREB) v(WL_EN) v(WRITE_EN) v(SAE) v(WL0) v(WL1) v(COL0) v(COL1) v(PD_Y) v(PD_YB) v(BL0) v(BLB0) v(BL1) v(BLB1) v(Y) v(YB) v(SOUT) v(SOUTB) v(Q00) v(Q01) v(Q10) v(Q11) v(QB00) v(QB01) v(QB10) v(QB11) v(xctrl.C0) v(xctrl.C1) v(xctrl.C2) v(xctrl.C3) v(xctrl.W) v(xctrl.RX) v(xctrl.E0) v(xctrl.E1) v(xctrl.E2) v(xctrl.E3) v(xctrl.E4) v(xctrl.E5) v(xctrl.E6) v(xctrl.E7)
write sram_tb_serial.raw
plot v(CLK) v(SDI) v(WE) xlimit 180n 1500n title 'SERIAL INPUT: RX at 250 / 350 / 450 ns, E0 at 550 ns'
plot count xlimit 180n 2550n title 'COUNT: 0..10; pre-edge count names the action'
plot v(RA) v(CA) v(DIN) v(xctrl.W) xlimit 180n 2550n title 'FRAME: RA/CA/DIN shift during RX; hold E0..E7; W samples WE at E0'
plot v(SOUT) v(SDO) title 'READ RESULT: SDO captures SOUT at E6 and holds through writes'
plot v(Q00) v(Q01) v(Q10) v(Q11) title 'STORED CELLS: written by serial commands, no initial-value forcing'
let PREB_T = v(PREB)/5+6
let WRITE_EN_T = v(WRITE_EN)/5+4
let WL_EN_T = v(WL_EN)/5+2
let SAE_T = v(SAE)/5+0
plot PREB_T WRITE_EN_T WL_EN_T SAE_T xlimit 450n 2450n title 'CONTROLS: PREB+6 WRITE_EN+4 WL_EN+2 SAE+0'
.endc"}
C {devices/netlist_options.sym} 2230 2060 0 0 {name=NETLIST_OPTIONS
lvs_netlist=false
top_is_subckt=false
spiceprefix=true
hiersep=. }
