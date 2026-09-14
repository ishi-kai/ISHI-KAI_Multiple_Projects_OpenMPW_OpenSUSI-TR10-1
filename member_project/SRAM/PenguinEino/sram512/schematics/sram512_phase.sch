v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
E {}
T {MODULO-18 COUNTER: count before CLK names the action ON that edge} -300 -400 0 0 0.3 0.3 {}
T {RX0..RX9 receive RA[3:0], CA[4:0], DIN (MSB first); E0..E7 perform one access} -300 -330 0 0 0.3 0.3 {}
T {FULL 5-BIT PHASE COMPARISONS (no asynchronous control outputs)} 1850 -300 0 0 0.3 0.3 {}
T {COUNT_RUN = count < 17; states 17..31 go to 0} -180 1810 0 0 0.3 0.3 {}
T {01010 = 10 : E0} 2620 85 0 0 0.3 0.3 {}
T {01011 = 11 : E1} 2620 325 0 0 0.3 0.3 {}
T {01100 = 12 : E2} 2620 565 0 0 0.3 0.3 {}
T {01101 = 13 : E3} 2620 805 0 0 0.3 0.3 {}
T {01110 = 14 : E4} 2620 1045 0 0 0.3 0.3 {}
T {01111 = 15 : E5} 2620 1285 0 0 0.3 0.3 {}
T {10000 = 16 : E6} 2620 1525 0 0 0.3 0.3 {}
T {10001 = 17 : E7} 2620 1765 0 0 0.3 0.3 {}
T {RX = count < 10} 2320 2290 0 0 0.3 0.3 {}
C {TR-1um_5_stdcell/AND4_X1.sym} 0 1650 0 0 {name=xcount_low_zero}
C {TR-1um_5_stdcell/OR2.sym} 450 1650 0 0 {name=xcount_run}
C {TR-1um_5_stdcell/AND2_X1.sym} 480 0 0 0 {name=xnext0}
C {TR-1um_5_stdcell/DFFR.sym} 850 30 0 0 {name=xcounter0}
C {TR-1um_5_stdcell/XOR2.sym} 160 300 0 0 {name=xtoggle1}
C {TR-1um_5_stdcell/AND2_X1.sym} 480 300 0 0 {name=xnext1}
C {TR-1um_5_stdcell/DFFR.sym} 850 330 0 0 {name=xcounter1}
C {TR-1um_5_stdcell/AND2_X1.sym} -160 720 0 0 {name=xcarry2}
C {TR-1um_5_stdcell/XOR2.sym} 160 600 0 0 {name=xtoggle2}
C {TR-1um_5_stdcell/AND2_X1.sym} 480 600 0 0 {name=xnext2}
C {TR-1um_5_stdcell/DFFR.sym} 850 630 0 0 {name=xcounter2}
C {TR-1um_5_stdcell/AND3_X1.sym} -160 1020 0 0 {name=xcarry3}
C {TR-1um_5_stdcell/XOR2.sym} 160 900 0 0 {name=xtoggle3}
C {TR-1um_5_stdcell/AND2_X1.sym} 480 900 0 0 {name=xnext3}
C {TR-1um_5_stdcell/DFFR.sym} 850 930 0 0 {name=xcounter3}
C {TR-1um_5_stdcell/AND4_X1.sym} -160 1320 0 0 {name=xcarry4}
C {TR-1um_5_stdcell/XOR2.sym} 160 1200 0 0 {name=xtoggle4}
C {TR-1um_5_stdcell/AND2_X1.sym} 480 1200 0 0 {name=xnext4}
C {TR-1um_5_stdcell/DFFR.sym} 850 1230 0 0 {name=xcounter4}
C {TR-1um_5_stdcell/AND4_X1.sym} 2140 0 0 0 {name=xphase0_low}
C {TR-1um_5_stdcell/AND2_X1.sym} 2470 0 0 0 {name=xphase0}
C {TR-1um_5_stdcell/AND4_X1.sym} 2140 240 0 0 {name=xphase1_low}
C {TR-1um_5_stdcell/AND2_X1.sym} 2470 240 0 0 {name=xphase1}
C {TR-1um_5_stdcell/AND4_X1.sym} 2140 480 0 0 {name=xphase2_low}
C {TR-1um_5_stdcell/AND2_X1.sym} 2470 480 0 0 {name=xphase2}
C {TR-1um_5_stdcell/AND4_X1.sym} 2140 720 0 0 {name=xphase3_low}
C {TR-1um_5_stdcell/AND2_X1.sym} 2470 720 0 0 {name=xphase3}
C {TR-1um_5_stdcell/AND4_X1.sym} 2140 960 0 0 {name=xphase4_low}
C {TR-1um_5_stdcell/AND2_X1.sym} 2470 960 0 0 {name=xphase4}
C {TR-1um_5_stdcell/AND4_X1.sym} 2140 1200 0 0 {name=xphase5_low}
C {TR-1um_5_stdcell/AND2_X1.sym} 2470 1200 0 0 {name=xphase5}
C {TR-1um_5_stdcell/AND4_X1.sym} 2140 1440 0 0 {name=xphase6_low}
C {TR-1um_5_stdcell/AND2_X1.sym} 2470 1440 0 0 {name=xphase6}
C {TR-1um_5_stdcell/AND4_X1.sym} 2140 1680 0 0 {name=xphase7_low}
C {TR-1um_5_stdcell/AND2_X1.sym} 2470 1680 0 0 {name=xphase7}
C {TR-1um_5_stdcell/AND2_X1.sym} 1560 2160 0 0 {name=xrx_low}
C {TR-1um_5_stdcell/OR2.sym} 1890 2160 0 0 {name=xrx_upper}
C {TR-1um_5_stdcell/AND2_X1.sym} 2230 2160 0 0 {name=xrx}
N 110 1650 270 1650 {lab=LOW_ZERO}
N 270 1650 270 1670 {lab=LOW_ZERO}
N 270 1670 430 1670 {lab=LOW_ZERO}
C {devices/lab_wire.sym} 270 1650 0 0 {name=l60 lab=LOW_ZERO}
N 590 0 700 0 {lab=NEXT0}
N 700 0 820 0 {lab=NEXT0}
C {devices/lab_wire.sym} 700 0 0 0 {name=l63 lab=NEXT0}
N 270 300 360 300 {lab=TOGGLE1}
N 360 300 360 280 {lab=TOGGLE1}
N 360 280 460 280 {lab=TOGGLE1}
C {devices/lab_wire.sym} 360 300 0 0 {name=l67 lab=TOGGLE1}
N 590 300 700 300 {lab=NEXT1}
N 700 300 820 300 {lab=NEXT1}
C {devices/lab_wire.sym} 700 300 0 0 {name=l70 lab=NEXT1}
N -50 720 40 720 {lab=CARRY2}
N 40 720 40 620 {lab=CARRY2}
N 40 620 140 620 {lab=CARRY2}
C {devices/lab_wire.sym} 40 720 0 0 {name=l74 lab=CARRY2}
N 270 600 360 600 {lab=TOGGLE2}
N 360 600 360 580 {lab=TOGGLE2}
N 360 580 460 580 {lab=TOGGLE2}
C {devices/lab_wire.sym} 360 600 0 0 {name=l78 lab=TOGGLE2}
N 590 600 700 600 {lab=NEXT2}
N 700 600 820 600 {lab=NEXT2}
C {devices/lab_wire.sym} 700 600 0 0 {name=l81 lab=NEXT2}
N -50 1020 40 1020 {lab=CARRY3}
N 40 1020 40 920 {lab=CARRY3}
N 40 920 140 920 {lab=CARRY3}
C {devices/lab_wire.sym} 40 1020 0 0 {name=l85 lab=CARRY3}
N 270 900 360 900 {lab=TOGGLE3}
N 360 900 360 880 {lab=TOGGLE3}
N 360 880 460 880 {lab=TOGGLE3}
C {devices/lab_wire.sym} 360 900 0 0 {name=l89 lab=TOGGLE3}
N 590 900 700 900 {lab=NEXT3}
N 700 900 820 900 {lab=NEXT3}
C {devices/lab_wire.sym} 700 900 0 0 {name=l92 lab=NEXT3}
N -50 1320 40 1320 {lab=CARRY4}
N 40 1320 40 1220 {lab=CARRY4}
N 40 1220 140 1220 {lab=CARRY4}
C {devices/lab_wire.sym} 40 1320 0 0 {name=l96 lab=CARRY4}
N 270 1200 360 1200 {lab=TOGGLE4}
N 360 1200 360 1180 {lab=TOGGLE4}
N 360 1180 460 1180 {lab=TOGGLE4}
C {devices/lab_wire.sym} 360 1200 0 0 {name=l100 lab=TOGGLE4}
N 590 1200 700 1200 {lab=NEXT4}
N 700 1200 820 1200 {lab=NEXT4}
C {devices/lab_wire.sym} 700 1200 0 0 {name=l103 lab=NEXT4}
N 2250 0 2350 0 {lab=E0_LOW}
N 2350 0 2350 -20 {lab=E0_LOW}
N 2350 -20 2450 -20 {lab=E0_LOW}
C {devices/lab_wire.sym} 2350 0 0 0 {name=l107 lab=E0_LOW}
N 2250 240 2350 240 {lab=E1_LOW}
N 2350 240 2350 220 {lab=E1_LOW}
N 2350 220 2450 220 {lab=E1_LOW}
C {devices/lab_wire.sym} 2350 240 0 0 {name=l111 lab=E1_LOW}
N 2250 480 2350 480 {lab=E2_LOW}
N 2350 480 2350 460 {lab=E2_LOW}
N 2350 460 2450 460 {lab=E2_LOW}
C {devices/lab_wire.sym} 2350 480 0 0 {name=l115 lab=E2_LOW}
N 2250 720 2350 720 {lab=E3_LOW}
N 2350 720 2350 700 {lab=E3_LOW}
N 2350 700 2450 700 {lab=E3_LOW}
C {devices/lab_wire.sym} 2350 720 0 0 {name=l119 lab=E3_LOW}
N 2250 960 2350 960 {lab=E4_LOW}
N 2350 960 2350 940 {lab=E4_LOW}
N 2350 940 2450 940 {lab=E4_LOW}
C {devices/lab_wire.sym} 2350 960 0 0 {name=l123 lab=E4_LOW}
N 2250 1200 2350 1200 {lab=E5_LOW}
N 2350 1200 2350 1180 {lab=E5_LOW}
N 2350 1180 2450 1180 {lab=E5_LOW}
C {devices/lab_wire.sym} 2350 1200 0 0 {name=l127 lab=E5_LOW}
N 2250 1440 2350 1440 {lab=E6_LOW}
N 2350 1440 2350 1420 {lab=E6_LOW}
N 2350 1420 2450 1420 {lab=E6_LOW}
C {devices/lab_wire.sym} 2350 1440 0 0 {name=l131 lab=E6_LOW}
N 2250 1680 2350 1680 {lab=E7_LOW}
N 2350 1680 2350 1660 {lab=E7_LOW}
N 2350 1660 2450 1660 {lab=E7_LOW}
C {devices/lab_wire.sym} 2350 1680 0 0 {name=l135 lab=E7_LOW}
N 1670 2160 1770 2160 {lab=RX_LOW}
N 1770 2160 1770 2180 {lab=RX_LOW}
N 1770 2180 1870 2180 {lab=RX_LOW}
C {devices/lab_wire.sym} 1770 2160 0 0 {name=l139 lab=RX_LOW}
N 2000 2160 2100 2160 {lab=RX_UPPER}
N 2100 2160 2100 2180 {lab=RX_UPPER}
N 2100 2180 2210 2180 {lab=RX_UPPER}
C {devices/lab_wire.sym} 2100 2160 0 0 {name=l143 lab=RX_UPPER}
N 1350 -140 1350 1800 {lab=C0}
C {devices/lab_wire.sym} 1350 -140 0 0 {name=l145 lab=C0}
N 1390 -140 1390 1800 {lab=C0B}
C {devices/lab_wire.sym} 1390 -140 0 0 {name=l147 lab=C0B}
N 1430 -140 1430 1800 {lab=C1}
C {devices/lab_wire.sym} 1430 -140 0 0 {name=l149 lab=C1}
N 1470 -140 1470 1800 {lab=C1B}
C {devices/lab_wire.sym} 1470 -140 0 0 {name=l151 lab=C1B}
N 1510 -140 1510 1800 {lab=C2}
C {devices/lab_wire.sym} 1510 -140 0 0 {name=l153 lab=C2}
N 1550 -140 1550 1800 {lab=C2B}
C {devices/lab_wire.sym} 1550 -140 0 0 {name=l155 lab=C2B}
N 1590 -140 1590 1800 {lab=C3}
C {devices/lab_wire.sym} 1590 -140 0 0 {name=l157 lab=C3}
N 1630 -140 1630 1800 {lab=C3B}
C {devices/lab_wire.sym} 1630 -140 0 0 {name=l159 lab=C3B}
N 1670 -140 1670 1800 {lab=C4}
C {devices/lab_wire.sym} 1670 -140 0 0 {name=l161 lab=C4}
N 1710 -140 1710 1800 {lab=C4B}
C {devices/lab_wire.sym} 1710 -140 0 0 {name=l163 lab=C4B}
N 2120 -30 1390 -30 {lab=C0B}
N 2120 -10 1430 -10 {lab=C1}
N 2120 10 1550 10 {lab=C2B}
N 2120 30 1590 30 {lab=C3}
N 2450 20 2410 20 {lab=C4B}
N 2410 20 2410 110 {lab=C4B}
N 2410 110 1710 110 {lab=C4B}
N 2120 210 1350 210 {lab=C0}
N 2120 230 1430 230 {lab=C1}
N 2120 250 1550 250 {lab=C2B}
N 2120 270 1590 270 {lab=C3}
N 2450 260 2410 260 {lab=C4B}
N 2410 260 2410 350 {lab=C4B}
N 2410 350 1710 350 {lab=C4B}
N 2120 450 1390 450 {lab=C0B}
N 2120 470 1470 470 {lab=C1B}
N 2120 490 1510 490 {lab=C2}
N 2120 510 1590 510 {lab=C3}
N 2450 500 2410 500 {lab=C4B}
N 2410 500 2410 590 {lab=C4B}
N 2410 590 1710 590 {lab=C4B}
N 2120 690 1350 690 {lab=C0}
N 2120 710 1470 710 {lab=C1B}
N 2120 730 1510 730 {lab=C2}
N 2120 750 1590 750 {lab=C3}
N 2450 740 2410 740 {lab=C4B}
N 2410 740 2410 830 {lab=C4B}
N 2410 830 1710 830 {lab=C4B}
N 2120 930 1390 930 {lab=C0B}
N 2120 950 1430 950 {lab=C1}
N 2120 970 1510 970 {lab=C2}
N 2120 990 1590 990 {lab=C3}
N 2450 980 2410 980 {lab=C4B}
N 2410 980 2410 1070 {lab=C4B}
N 2410 1070 1710 1070 {lab=C4B}
N 2120 1170 1350 1170 {lab=C0}
N 2120 1190 1430 1190 {lab=C1}
N 2120 1210 1510 1210 {lab=C2}
N 2120 1230 1590 1230 {lab=C3}
N 2450 1220 2410 1220 {lab=C4B}
N 2410 1220 2410 1310 {lab=C4B}
N 2410 1310 1710 1310 {lab=C4B}
N 2120 1410 1390 1410 {lab=C0B}
N 2120 1430 1470 1430 {lab=C1B}
N 2120 1450 1550 1450 {lab=C2B}
N 2120 1470 1630 1470 {lab=C3B}
N 2450 1460 2410 1460 {lab=C4}
N 2410 1460 2410 1550 {lab=C4}
N 2410 1550 1670 1550 {lab=C4}
N 2120 1650 1350 1650 {lab=C0}
N 2120 1670 1470 1670 {lab=C1B}
N 2120 1690 1550 1690 {lab=C2B}
N 2120 1710 1630 1710 {lab=C3B}
N 2450 1700 2410 1700 {lab=C4}
N 2410 1700 2410 1790 {lab=C4}
N 2410 1790 1670 1790 {lab=C4}
N 820 40 710 40 {lab=CLK}
N 820 340 710 340 {lab=CLK}
N 820 640 710 640 {lab=CLK}
N 820 940 710 940 {lab=CLK}
N 820 1240 710 1240 {lab=CLK}
N 710 -10 710 1270 {lab=CLK}
C {devices/lab_wire.sym} 710 -10 0 0 {name=l226 lab=CLK}
N 850 70 850 110 {lab=RESET}
N 850 110 770 110 {lab=RESET}
N 850 370 850 410 {lab=RESET}
N 850 410 770 410 {lab=RESET}
N 850 670 850 710 {lab=RESET}
N 850 710 770 710 {lab=RESET}
N 850 970 850 1010 {lab=RESET}
N 850 1010 770 1010 {lab=RESET}
N 850 1270 850 1310 {lab=RESET}
N 850 1310 770 1310 {lab=RESET}
N 770 60 770 1340 {lab=RESET}
C {devices/lab_wire.sym} 770 60 0 0 {name=l238 lab=RESET}
C {devices/ipin.sym} -520 10 0 0 {name=pCLK lab=CLK}
N -520 10 -460 10 {lab=CLK}
C {devices/lab_pin.sym} -460 10 0 0 {name=l241 lab=CLK hide_texts=true}
C {devices/ipin.sym} -520 100 0 0 {name=pRESET lab=RESET}
N -520 100 -460 100 {lab=RESET}
C {devices/lab_pin.sym} -460 100 0 0 {name=l244 lab=RESET hide_texts=true}
N 2340 2160 2540 2160 {lab=RX}
C {devices/opin.sym} 2540 2160 0 0 {name=pRX lab=RX}
N 2580 0 2780 0 {lab=E0}
C {devices/opin.sym} 2780 0 0 0 {name=pE0 lab=E0}
N 2580 240 2780 240 {lab=E1}
C {devices/opin.sym} 2780 240 0 0 {name=pE1 lab=E1}
N 2580 480 2780 480 {lab=E2}
C {devices/opin.sym} 2780 480 0 0 {name=pE2 lab=E2}
N 2580 720 2780 720 {lab=E3}
C {devices/opin.sym} 2780 720 0 0 {name=pE3 lab=E3}
N 2580 960 2780 960 {lab=E4}
C {devices/opin.sym} 2780 960 0 0 {name=pE4 lab=E4}
N 2580 1200 2780 1200 {lab=E5}
C {devices/opin.sym} 2780 1200 0 0 {name=pE5 lab=E5}
N 2580 1440 2780 1440 {lab=E6}
C {devices/opin.sym} 2780 1440 0 0 {name=pE6 lab=E6}
N 2580 1680 2780 1680 {lab=E7}
C {devices/opin.sym} 2780 1680 0 0 {name=pE7 lab=E7}
C {devices/iopin.sym} -520 -200 0 0 {name=pVDD lab=VDD}
N -520 -200 -460 -200 {lab=VDD}
C {devices/lab_pin.sym} -460 -200 0 0 {name=l265 lab=VDD hide_texts=true}
C {devices/iopin.sym} -520 -130 0 0 {name=pVSS lab=VSS}
N -520 -130 -460 -130 {lab=VSS}
C {devices/lab_pin.sym} -460 -130 0 0 {name=l268 lab=VSS hide_texts=true}
C {devices/lab_pin.sym} -20 1680 0 0 {name=l269 lab=C3B}
C {devices/lab_pin.sym} -20 1660 0 0 {name=l270 lab=C2B}
C {devices/lab_pin.sym} 30 1590 0 0 {name=l271 lab=VDD}
C {devices/lab_pin.sym} -20 1620 0 0 {name=l272 lab=C0B}
C {devices/lab_pin.sym} -20 1640 0 0 {name=l273 lab=C1B}
C {devices/lab_pin.sym} 30 1710 0 0 {name=l274 lab=VSS}
C {devices/lab_pin.sym} 480 1590 0 0 {name=l275 lab=VDD}
C {devices/lab_pin.sym} 560 1650 2 0 {name=l276 lab=COUNT_RUN}
C {devices/lab_pin.sym} 430 1630 0 0 {name=l277 lab=C4B}
C {devices/lab_pin.sym} 480 1710 0 0 {name=l278 lab=VSS}
C {devices/lab_pin.sym} 510 -60 0 0 {name=l279 lab=VDD}
C {devices/lab_pin.sym} 460 -20 0 0 {name=l280 lab=C0B}
C {devices/lab_pin.sym} 460 20 0 0 {name=l281 lab=COUNT_RUN}
C {devices/lab_pin.sym} 510 60 0 0 {name=l282 lab=VSS}
C {devices/lab_pin.sym} 820 -30 0 0 {name=l283 lab=VDD}
C {devices/lab_pin.sym} 880 40 2 0 {name=l284 lab=C0B}
C {devices/lab_pin.sym} 880 0 2 0 {name=l285 lab=C0}
C {devices/lab_pin.sym} 820 90 0 0 {name=l286 lab=VSS}
C {devices/lab_pin.sym} 190 240 0 0 {name=l287 lab=VDD}
C {devices/lab_pin.sym} 140 280 0 0 {name=l288 lab=C1}
C {devices/lab_pin.sym} 140 320 0 0 {name=l289 lab=C0}
C {devices/lab_pin.sym} 190 360 0 0 {name=l290 lab=VSS}
C {devices/lab_pin.sym} 510 240 0 0 {name=l291 lab=VDD}
C {devices/lab_pin.sym} 460 320 0 0 {name=l292 lab=COUNT_RUN}
C {devices/lab_pin.sym} 510 360 0 0 {name=l293 lab=VSS}
C {devices/lab_pin.sym} 820 270 0 0 {name=l294 lab=VDD}
C {devices/lab_pin.sym} 880 340 2 0 {name=l295 lab=C1B}
C {devices/lab_pin.sym} 880 300 2 0 {name=l296 lab=C1}
C {devices/lab_pin.sym} 820 390 0 0 {name=l297 lab=VSS}
C {devices/lab_pin.sym} -130 660 0 0 {name=l298 lab=VDD}
C {devices/lab_pin.sym} -180 700 0 0 {name=l299 lab=C0}
C {devices/lab_pin.sym} -180 740 0 0 {name=l300 lab=C1}
C {devices/lab_pin.sym} -130 780 0 0 {name=l301 lab=VSS}
C {devices/lab_pin.sym} 190 540 0 0 {name=l302 lab=VDD}
C {devices/lab_pin.sym} 140 580 0 0 {name=l303 lab=C2}
C {devices/lab_pin.sym} 190 660 0 0 {name=l304 lab=VSS}
C {devices/lab_pin.sym} 510 540 0 0 {name=l305 lab=VDD}
C {devices/lab_pin.sym} 460 620 0 0 {name=l306 lab=COUNT_RUN}
C {devices/lab_pin.sym} 510 660 0 0 {name=l307 lab=VSS}
C {devices/lab_pin.sym} 820 570 0 0 {name=l308 lab=VDD}
C {devices/lab_pin.sym} 880 640 2 0 {name=l309 lab=C2B}
C {devices/lab_pin.sym} 880 600 2 0 {name=l310 lab=C2}
C {devices/lab_pin.sym} 820 690 0 0 {name=l311 lab=VSS}
C {devices/lab_pin.sym} -180 1040 0 0 {name=l312 lab=C2}
C {devices/lab_pin.sym} -130 960 0 0 {name=l313 lab=VDD}
C {devices/lab_pin.sym} -180 1000 0 0 {name=l314 lab=C0}
C {devices/lab_pin.sym} -180 1020 0 0 {name=l315 lab=C1}
C {devices/lab_pin.sym} -130 1080 0 0 {name=l316 lab=VSS}
C {devices/lab_pin.sym} 190 840 0 0 {name=l317 lab=VDD}
C {devices/lab_pin.sym} 140 880 0 0 {name=l318 lab=C3}
C {devices/lab_pin.sym} 190 960 0 0 {name=l319 lab=VSS}
C {devices/lab_pin.sym} 510 840 0 0 {name=l320 lab=VDD}
C {devices/lab_pin.sym} 460 920 0 0 {name=l321 lab=COUNT_RUN}
C {devices/lab_pin.sym} 510 960 0 0 {name=l322 lab=VSS}
C {devices/lab_pin.sym} 820 870 0 0 {name=l323 lab=VDD}
C {devices/lab_pin.sym} 880 940 2 0 {name=l324 lab=C3B}
C {devices/lab_pin.sym} 880 900 2 0 {name=l325 lab=C3}
C {devices/lab_pin.sym} 820 990 0 0 {name=l326 lab=VSS}
C {devices/lab_pin.sym} -180 1350 0 0 {name=l327 lab=C3}
C {devices/lab_pin.sym} -180 1330 0 0 {name=l328 lab=C2}
C {devices/lab_pin.sym} -130 1260 0 0 {name=l329 lab=VDD}
C {devices/lab_pin.sym} -180 1290 0 0 {name=l330 lab=C0}
C {devices/lab_pin.sym} -180 1310 0 0 {name=l331 lab=C1}
C {devices/lab_pin.sym} -130 1380 0 0 {name=l332 lab=VSS}
C {devices/lab_pin.sym} 190 1140 0 0 {name=l333 lab=VDD}
C {devices/lab_pin.sym} 140 1180 0 0 {name=l334 lab=C4}
C {devices/lab_pin.sym} 190 1260 0 0 {name=l335 lab=VSS}
C {devices/lab_pin.sym} 510 1140 0 0 {name=l336 lab=VDD}
C {devices/lab_pin.sym} 460 1220 0 0 {name=l337 lab=COUNT_RUN}
C {devices/lab_pin.sym} 510 1260 0 0 {name=l338 lab=VSS}
C {devices/lab_pin.sym} 820 1170 0 0 {name=l339 lab=VDD}
C {devices/lab_pin.sym} 880 1240 2 0 {name=l340 lab=C4B}
C {devices/lab_pin.sym} 880 1200 2 0 {name=l341 lab=C4}
C {devices/lab_pin.sym} 820 1290 0 0 {name=l342 lab=VSS}
C {devices/lab_pin.sym} 2170 -60 0 0 {name=l343 lab=VDD}
C {devices/lab_pin.sym} 2170 60 0 0 {name=l344 lab=VSS}
C {devices/lab_pin.sym} 2500 -60 0 0 {name=l345 lab=VDD}
C {devices/lab_pin.sym} 2500 60 0 0 {name=l346 lab=VSS}
C {devices/lab_pin.sym} 2170 180 0 0 {name=l347 lab=VDD}
C {devices/lab_pin.sym} 2170 300 0 0 {name=l348 lab=VSS}
C {devices/lab_pin.sym} 2500 180 0 0 {name=l349 lab=VDD}
C {devices/lab_pin.sym} 2500 300 0 0 {name=l350 lab=VSS}
C {devices/lab_pin.sym} 2170 420 0 0 {name=l351 lab=VDD}
C {devices/lab_pin.sym} 2170 540 0 0 {name=l352 lab=VSS}
C {devices/lab_pin.sym} 2500 420 0 0 {name=l353 lab=VDD}
C {devices/lab_pin.sym} 2500 540 0 0 {name=l354 lab=VSS}
C {devices/lab_pin.sym} 2170 660 0 0 {name=l355 lab=VDD}
C {devices/lab_pin.sym} 2170 780 0 0 {name=l356 lab=VSS}
C {devices/lab_pin.sym} 2500 660 0 0 {name=l357 lab=VDD}
C {devices/lab_pin.sym} 2500 780 0 0 {name=l358 lab=VSS}
C {devices/lab_pin.sym} 2170 900 0 0 {name=l359 lab=VDD}
C {devices/lab_pin.sym} 2170 1020 0 0 {name=l360 lab=VSS}
C {devices/lab_pin.sym} 2500 900 0 0 {name=l361 lab=VDD}
C {devices/lab_pin.sym} 2500 1020 0 0 {name=l362 lab=VSS}
C {devices/lab_pin.sym} 2170 1140 0 0 {name=l363 lab=VDD}
C {devices/lab_pin.sym} 2170 1260 0 0 {name=l364 lab=VSS}
C {devices/lab_pin.sym} 2500 1140 0 0 {name=l365 lab=VDD}
C {devices/lab_pin.sym} 2500 1260 0 0 {name=l366 lab=VSS}
C {devices/lab_pin.sym} 2170 1380 0 0 {name=l367 lab=VDD}
C {devices/lab_pin.sym} 2170 1500 0 0 {name=l368 lab=VSS}
C {devices/lab_pin.sym} 2500 1380 0 0 {name=l369 lab=VDD}
C {devices/lab_pin.sym} 2500 1500 0 0 {name=l370 lab=VSS}
C {devices/lab_pin.sym} 2170 1620 0 0 {name=l371 lab=VDD}
C {devices/lab_pin.sym} 2170 1740 0 0 {name=l372 lab=VSS}
C {devices/lab_pin.sym} 2500 1620 0 0 {name=l373 lab=VDD}
C {devices/lab_pin.sym} 2500 1740 0 0 {name=l374 lab=VSS}
C {devices/lab_pin.sym} 1590 2100 0 0 {name=l375 lab=VDD}
C {devices/lab_pin.sym} 1540 2140 0 0 {name=l376 lab=C2B}
C {devices/lab_pin.sym} 1540 2180 0 0 {name=l377 lab=C1B}
C {devices/lab_pin.sym} 1590 2220 0 0 {name=l378 lab=VSS}
C {devices/lab_pin.sym} 1920 2100 0 0 {name=l379 lab=VDD}
C {devices/lab_pin.sym} 1870 2140 0 0 {name=l380 lab=C3B}
C {devices/lab_pin.sym} 1920 2220 0 0 {name=l381 lab=VSS}
C {devices/lab_pin.sym} 2260 2100 0 0 {name=l382 lab=VDD}
C {devices/lab_pin.sym} 2210 2140 0 0 {name=l383 lab=C4B}
C {devices/lab_pin.sym} 2260 2220 0 0 {name=l384 lab=VSS}
