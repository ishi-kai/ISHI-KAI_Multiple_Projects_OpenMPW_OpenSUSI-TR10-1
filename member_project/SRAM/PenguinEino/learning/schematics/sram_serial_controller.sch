v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {SERIAL SRAM CONTROLLER | 2 x 2 | 13 DFFR | asynchronous RESET} -180 -420 0 0 0.48 0.48 {}
T {CLK steps through RX0 / RX1 / RX2 / E0 ... E7. All gates below are real PDK cells.} -180 -355 0 0 0.3 0.3 {}
T {A  /  MODULO-11 COUNTER} -180 -250 0 0 0.36 0.36 {}
T {COUNT_RUN = !(C3 & (C2 | C1)): advance 0..9; wrap 10..15 to 0} -180 1600 0 0 0.24 0.24 {}
T {B  /  CURRENT-COUNT DECODE} 1510 -250 0 0 0.36 0.36 {}
T {0011  =  3  /  E0} 1930 170 0 0 0.23 0.23 {}
T {0100  =  4  /  E1} 1930 350 0 0 0.23 0.23 {}
T {0101  =  5  /  E2} 1930 530 0 0 0.23 0.23 {}
T {0110  =  6  /  E3} 1930 710 0 0 0.23 0.23 {}
T {0111  =  7  /  E4} 1930 890 0 0 0.23 0.23 {}
T {1000  =  8  /  E5} 1930 1070 0 0 0.23 0.23 {}
T {1001  =  9  /  E6} 1930 1250 0 0 0.23 0.23 {}
T {1010  =  10  /  E7} 1930 1430 0 0 0.23 0.23 {}
T {RX = count < 3. E0 = count == 3. Decode is sampled by DFFs.} 1370 1860 0 0 0.24 0.24 {}
T {C  /  REGISTERED CONTROL OUTPUTS} 2530 -250 0 0 0.36 0.36 {}
T {PC_ON.QB -> PREB (also common-line YPREB)} 3900 265 0 0 0.25 0.25 {}
T {E0 uses external WE; E1..E3 use the held W. SAE is TRACK.QB.} 2540 1600 0 0 0.25 0.25 {}
T {All MUX: S=0 -> A (feedback); S=1 -> B (new data).} -180 3430 0 0 0.28 0.28 {}
T {RST pins connect directly to RESET. Q resets LOW; QB resets HIGH. No custom bit-register symbols.} -180 3490 0 0 0.28 0.28 {}
T {NC: intentionally no circuit load; named nets remain available for waveform probes.} -180 3550 0 0 0.25 0.25 {}
N 670 60 980 60 {lab=NEXT0}
N 1040 60 1220 60 {lab=C0}
N 1040 100 1220 100 {lab=C0B}
N 900 100 980 100 {lab=CLK}
N 1010 130 1010 170 {lab=RESET}
N 950 170 1010 170 {lab=RESET}
N 490 80 540 80 {lab=COUNT_RUN}
N 670 340 980 340 {lab=NEXT1}
N 320 320 540 320 {lab=#net1}
N 1040 340 1220 340 {lab=C1}
N 1040 380 1220 380 {lab=C1B}
N 900 380 980 380 {lab=CLK}
N 1010 410 1010 450 {lab=RESET}
N 950 450 1010 450 {lab=RESET}
N 490 360 540 360 {lab=COUNT_RUN}
N 670 620 980 620 {lab=NEXT2}
N 320 600 540 600 {lab=#net2}
N 1040 620 1220 620 {lab=C2}
N 1040 660 1220 660 {lab=C2B}
N 900 660 980 660 {lab=CLK}
N 1010 690 1010 730 {lab=RESET}
N 950 730 1010 730 {lab=RESET}
N 490 640 540 640 {lab=COUNT_RUN}
N 670 900 980 900 {lab=NEXT3}
N 320 880 540 880 {lab=#net3}
N 1040 900 1220 900 {lab=C3}
N 1040 940 1220 940 {lab=C3B}
N 900 940 980 940 {lab=CLK}
N 1010 970 1010 1010 {lab=RESET}
N 950 1010 1010 1010 {lab=RESET}
N 490 920 540 920 {lab=COUNT_RUN}
N 900 -60 900 1070 {lab=CLK}
N 950 -20 950 1090 {lab=RESET}
N 490 -110 490 1020 {lab=COUNT_RUN}
N 110 1430 230 1430 {lab=#net4}
N 230 1430 230 1470 {lab=#net4}
N 230 1470 290 1470 {lab=#net4}
N 1450 -80 1450 1450 {lab=C0}
N 1475 -140 1475 1450 {lab=C0B}
N 1500 -80 1500 1450 {lab=C1}
N 1525 -140 1525 1450 {lab=C1B}
N 1550 -80 1550 1450 {lab=C2}
N 1575 -140 1575 1450 {lab=C2B}
N 1600 -80 1600 1450 {lab=C3}
N 1625 -140 1625 1450 {lab=C3B}
N 1625 70 1810 70 {lab=C3B}
N 1575 90 1810 90 {lab=C2B}
N 1500 110 1810 110 {lab=C1}
N 1450 130 1810 130 {lab=C0}
N 1940 100 2180 100 {lab=E0}
N 1625 250 1810 250 {lab=C3B}
N 1550 270 1810 270 {lab=C2}
N 1525 290 1810 290 {lab=C1B}
N 1475 310 1810 310 {lab=C0B}
N 1940 280 2180 280 {lab=E1}
N 1625 430 1810 430 {lab=C3B}
N 1550 450 1810 450 {lab=C2}
N 1525 470 1810 470 {lab=C1B}
N 1450 490 1810 490 {lab=C0}
N 1940 460 2180 460 {lab=E2}
N 1625 610 1810 610 {lab=C3B}
N 1550 630 1810 630 {lab=C2}
N 1500 650 1810 650 {lab=C1}
N 1475 670 1810 670 {lab=C0B}
N 1940 640 2180 640 {lab=E3}
N 1625 790 1810 790 {lab=C3B}
N 1550 810 1810 810 {lab=C2}
N 1500 830 1810 830 {lab=C1}
N 1450 850 1810 850 {lab=C0}
N 1940 820 2180 820 {lab=E4}
N 1600 970 1810 970 {lab=C3}
N 1575 990 1810 990 {lab=C2B}
N 1525 1010 1810 1010 {lab=C1B}
N 1475 1030 1810 1030 {lab=C0B}
N 1940 1000 2180 1000 {lab=E5}
N 1600 1150 1810 1150 {lab=C3}
N 1575 1170 1810 1170 {lab=C2B}
N 1525 1190 1810 1190 {lab=C1B}
N 1450 1210 1810 1210 {lab=C0}
N 1940 1180 2180 1180 {lab=E6}
N 1600 1330 1810 1330 {lab=C3}
N 1575 1350 1810 1350 {lab=C2B}
N 1500 1370 1810 1370 {lab=C1}
N 1475 1390 1810 1390 {lab=C0B}
N 1940 1360 2180 1360 {lab=E7}
N 1500 1690 1640 1690 {lab=#net5}
N 1640 1690 1640 1710 {lab=#net5}
N 1640 1710 1790 1710 {lab=#net5}
N 4410 100 4590 100 {lab=PC_ON}
N 4000 100 4350 100 {lab=E0}
N 4410 140 4650 140 {lab=PREB}
N 3560 440 4350 440 {lab=WL_D}
N 4410 440 4650 440 {lab=WL_EN}
N 2800 750 3430 750 {lab=WRITE_WINDOW}
N 3560 770 4350 770 {lab=WRITE_D}
N 4410 770 4650 770 {lab=WRITE_EN}
N 2800 1050 3170 1050 {lab=#net6}
N 2800 1400 3170 1400 {lab=#net7}
N 3300 1070 3540 1070 {lab=#net8}
N 3540 1070 3540 1240 {lab=#net8}
N 3540 1240 3760 1240 {lab=#net8}
N 3300 1420 3600 1420 {lab=#net9}
N 3600 1280 3600 1420 {lab=#net9}
N 3600 1280 3760 1280 {lab=#net9}
N 4410 1260 4590 1260 {lab=TRACK}
N 3890 1260 4350 1260 {lab=TRACK_D}
N 4410 1300 4650 1300 {lab=SAE}
N 4180 140 4350 140 {lab=CLK}
N 4380 170 4380 210 {lab=RESET}
N 4240 210 4380 210 {lab=RESET}
N 4180 480 4350 480 {lab=CLK}
N 4380 510 4380 550 {lab=RESET}
N 4240 550 4380 550 {lab=RESET}
N 4180 810 4350 810 {lab=CLK}
N 4380 840 4380 880 {lab=RESET}
N 4240 880 4380 880 {lab=RESET}
N 4180 1300 4350 1300 {lab=CLK}
N 4380 1330 4380 1370 {lab=RESET}
N 4240 1370 4380 1370 {lab=RESET}
N 4180 -80 4180 1490 {lab=CLK}
N 4240 -80 4240 1490 {lab=RESET}
C {TR-1um_5_stdcell/AND2_X1.sym} 560 60 0 0 {name=xnext0}
C {TR-1um_5_stdcell/DFFR.sym} 1010 90 0 0 {name=xcnt0}
C {devices/lab_wire.sym} 700 60 0 0 {name=l12 lab=NEXT0}
C {devices/lab_pin.sym} 1220 60 2 0 {name=l14 lab=C0}
C {devices/lab_pin.sym} 1220 100 2 0 {name=l16 lab=C0B}
C {TR-1um_5_stdcell/XOR2.sym} 210 320 0 0 {name=xtoggle1}
C {TR-1um_5_stdcell/AND2_X1.sym} 560 340 0 0 {name=xnext1}
C {TR-1um_5_stdcell/DFFR.sym} 1010 370 0 0 {name=xcnt1}
C {devices/lab_wire.sym} 700 340 0 0 {name=l25 lab=NEXT1}
C {devices/lab_pin.sym} 1220 340 2 0 {name=l28 lab=C1}
C {devices/lab_pin.sym} 1220 380 2 0 {name=l30 lab=C1B}
C {TR-1um_5_stdcell/XOR2.sym} 210 600 0 0 {name=xtoggle2}
C {TR-1um_5_stdcell/AND2_X1.sym} 560 620 0 0 {name=xnext2}
C {TR-1um_5_stdcell/DFFR.sym} 1010 650 0 0 {name=xcnt2}
C {devices/lab_wire.sym} 700 620 0 0 {name=l39 lab=NEXT2}
C {devices/lab_pin.sym} 1220 620 2 0 {name=l42 lab=C2}
C {devices/lab_pin.sym} 1220 660 2 0 {name=l44 lab=C2B}
C {TR-1um_5_stdcell/XOR2.sym} 210 880 0 0 {name=xtoggle3}
C {TR-1um_5_stdcell/AND2_X1.sym} 560 900 0 0 {name=xnext3}
C {TR-1um_5_stdcell/DFFR.sym} 1010 930 0 0 {name=xcnt3}
C {devices/lab_wire.sym} 700 900 0 0 {name=l53 lab=NEXT3}
C {devices/lab_pin.sym} 1220 900 2 0 {name=l56 lab=C3}
C {devices/lab_pin.sym} 1220 940 2 0 {name=l58 lab=C3B}
C {devices/lab_wire.sym} 490 -110 0 0 {name=l66 lab=COUNT_RUN}
C {devices/ipin.sym} 900 -60 0 0 {name=pCLK lab=CLK}
C {devices/ipin.sym} 950 -20 0 0 {name=pRESET lab=RESET}
C {TR-1um_5_stdcell/AND2_X1.sym} 0 1200 0 0 {name=xcarry2}
C {TR-1um_5_stdcell/AND3_X1.sym} 520 1200 0 0 {name=xcarry3}
C {TR-1um_5_stdcell/OR2.sym} 0 1430 0 0 {name=xupper}
C {TR-1um_5_stdcell/NAND2.sym} 310 1450 0 0 {name=xrun}
C {devices/lab_wire.sym} 1450 -80 0 0 {name=l79 lab=C0}
C {devices/lab_wire.sym} 1475 -140 0 0 {name=l81 lab=C0B}
C {devices/lab_wire.sym} 1500 -80 0 0 {name=l83 lab=C1}
C {devices/lab_wire.sym} 1525 -140 0 0 {name=l85 lab=C1B}
C {devices/lab_wire.sym} 1550 -80 0 0 {name=l87 lab=C2}
C {devices/lab_wire.sym} 1575 -140 0 0 {name=l89 lab=C2B}
C {devices/lab_wire.sym} 1600 -80 0 0 {name=l91 lab=C3}
C {devices/lab_wire.sym} 1625 -140 0 0 {name=l93 lab=C3B}
C {TR-1um_5_stdcell/AND4_X1.sym} 1830 100 0 0 {name=xdecode0}
C {devices/lab_pin.sym} 2180 100 2 0 {name=l100 lab=E0}
C {TR-1um_5_stdcell/AND4_X1.sym} 1830 280 0 0 {name=xdecode1}
C {devices/lab_pin.sym} 2180 280 2 0 {name=l108 lab=E1}
C {TR-1um_5_stdcell/AND4_X1.sym} 1830 460 0 0 {name=xdecode2}
C {devices/lab_pin.sym} 2180 460 2 0 {name=l116 lab=E2}
C {TR-1um_5_stdcell/AND4_X1.sym} 1830 640 0 0 {name=xdecode3}
C {devices/lab_pin.sym} 2180 640 2 0 {name=l124 lab=E3}
C {TR-1um_5_stdcell/AND4_X1.sym} 1830 820 0 0 {name=xdecode4}
C {devices/lab_pin.sym} 2180 820 2 0 {name=l132 lab=E4}
C {TR-1um_5_stdcell/AND4_X1.sym} 1830 1000 0 0 {name=xdecode5}
C {devices/lab_pin.sym} 2180 1000 2 0 {name=l140 lab=E5}
C {TR-1um_5_stdcell/AND4_X1.sym} 1830 1180 0 0 {name=xdecode6}
C {devices/lab_pin.sym} 2180 1180 2 0 {name=l148 lab=E6}
C {TR-1um_5_stdcell/AND4_X1.sym} 1830 1360 0 0 {name=xdecode7}
C {devices/lab_pin.sym} 2180 1360 2 0 {name=l156 lab=E7}
C {devices/noconn.sym} 2180 1360 0 0 {name=nc_e7}
C {TR-1um_5_stdcell/NAND2.sym} 1370 1690 0 0 {name=xrx_low}
C {TR-1um_5_stdcell/AND3_X1.sym} 1810 1690 0 0 {name=xrx}
C {TR-1um_5_stdcell/DFFR.sym} 4380 130 0 0 {name=xpc}
C {devices/lab_wire.sym} 4510 100 0 0 {name=l168 lab=PC_ON}
C {devices/noconn.sym} 4590 100 0 0 {name=nc_pc_on}
C {devices/lab_pin.sym} 4000 100 0 0 {name=l171 lab=E0}
C {devices/opin.sym} 4650 140 0 0 {name=pPREB lab=PREB}
C {TR-1um_5_stdcell/OR2.sym} 3450 440 0 0 {name=xwl_d}
C {TR-1um_5_stdcell/DFFR.sym} 4380 470 0 0 {name=xwl}
C {devices/lab_wire.sym} 3590 440 0 0 {name=l178 lab=WL_D}
C {devices/opin.sym} 4650 440 0 0 {name=pWL_EN lab=WL_EN}
C {TR-1um_5_stdcell/OR4.sym} 2690 750 0 0 {name=xwrite_window}
C {TR-1um_5_stdcell/AND2_X1.sym} 3450 770 0 0 {name=xwrite_d}
C {devices/lab_wire.sym} 2830 750 0 0 {name=l184 lab=WRITE_WINDOW}
C {TR-1um_5_stdcell/DFFR.sym} 4380 800 0 0 {name=xwrite}
C {devices/lab_wire.sym} 3590 770 0 0 {name=l187 lab=WRITE_D}
C {devices/opin.sym} 4650 770 0 0 {name=pWRITE_EN lab=WRITE_EN}
C {TR-1um_5_stdcell/INV_X1.sym} 2700 1050 0 0 {name=xwe_b}
C {TR-1um_5_stdcell/AND2_X1.sym} 3190 1070 0 0 {name=xtrack_e0}
C {TR-1um_5_stdcell/OR3.sym} 2690 1400 0 0 {name=xtrack_window}
C {TR-1um_5_stdcell/AND2_X1.sym} 3190 1420 0 0 {name=xtrack_later}
C {TR-1um_5_stdcell/OR2.sym} 3780 1260 0 0 {name=xtrack_d}
C {TR-1um_5_stdcell/DFFR.sym} 4380 1290 0 0 {name=xtrack}
C {devices/lab_wire.sym} 4510 1260 0 0 {name=l205 lab=TRACK}
C {devices/noconn.sym} 4590 1260 0 0 {name=nc_track}
C {devices/lab_wire.sym} 3920 1260 0 0 {name=l208 lab=TRACK_D}
C {devices/opin.sym} 4650 1300 0 0 {name=pSAE lab=SAE}
C {devices/lab_wire.sym} 4180 -80 0 0 {name=l225 lab=CLK}
C {devices/lab_wire.sym} 4240 -80 0 0 {name=l227 lab=RESET}
C {devices/iopin.sym} 3930 2910 0 0 {name=pVDD lab=VDD}
C {devices/iopin.sym} 3930 3050 0 0 {name=pVSS lab=VSS}
C {devices/lab_pin.sym} 590 0 0 0 {name=l413 lab=VDD}
C {devices/lab_pin.sym} 540 40 0 0 {name=l414 lab=C0B}
C {devices/lab_pin.sym} 590 120 2 0 {name=l415 lab=VSS}
C {devices/lab_pin.sym} 980 30 0 0 {name=l416 lab=VDD}
C {devices/lab_pin.sym} 980 150 2 0 {name=l417 lab=VSS}
C {devices/lab_pin.sym} 240 260 0 0 {name=l418 lab=VDD}
C {devices/lab_pin.sym} 190 300 0 0 {name=l419 lab=C1}
C {devices/lab_pin.sym} 190 340 0 0 {name=l420 lab=C0}
C {devices/lab_pin.sym} 240 380 2 0 {name=l421 lab=VSS}
C {devices/lab_pin.sym} 590 280 0 0 {name=l422 lab=VDD}
C {devices/lab_pin.sym} 590 400 2 0 {name=l423 lab=VSS}
C {devices/lab_pin.sym} 980 310 0 0 {name=l424 lab=VDD}
C {devices/lab_pin.sym} 980 430 2 0 {name=l425 lab=VSS}
C {devices/lab_pin.sym} 240 540 0 0 {name=l426 lab=VDD}
C {devices/lab_pin.sym} 190 580 0 0 {name=l427 lab=C2}
C {devices/lab_pin.sym} 190 620 0 0 {name=l428 lab=CARRY2}
C {devices/lab_pin.sym} 240 660 2 0 {name=l429 lab=VSS}
C {devices/lab_pin.sym} 590 560 0 0 {name=l430 lab=VDD}
C {devices/lab_pin.sym} 590 680 2 0 {name=l431 lab=VSS}
C {devices/lab_pin.sym} 980 590 0 0 {name=l432 lab=VDD}
C {devices/lab_pin.sym} 980 710 2 0 {name=l433 lab=VSS}
C {devices/lab_pin.sym} 240 820 0 0 {name=l434 lab=VDD}
C {devices/lab_pin.sym} 190 860 0 0 {name=l435 lab=C3}
C {devices/lab_pin.sym} 190 900 0 0 {name=l436 lab=CARRY3}
C {devices/lab_pin.sym} 240 940 2 0 {name=l437 lab=VSS}
C {devices/lab_pin.sym} 590 840 0 0 {name=l438 lab=VDD}
C {devices/lab_pin.sym} 590 960 2 0 {name=l439 lab=VSS}
C {devices/lab_pin.sym} 980 870 0 0 {name=l440 lab=VDD}
C {devices/lab_pin.sym} 980 990 2 0 {name=l441 lab=VSS}
C {devices/lab_pin.sym} 30 1140 0 0 {name=l442 lab=VDD}
C {devices/lab_pin.sym} 110 1200 2 0 {name=l443 lab=CARRY2}
C {devices/lab_pin.sym} -20 1180 0 0 {name=l444 lab=C0}
C {devices/lab_pin.sym} -20 1220 0 0 {name=l445 lab=C1}
C {devices/lab_pin.sym} 30 1260 2 0 {name=l446 lab=VSS}
C {devices/lab_pin.sym} 500 1220 0 0 {name=l447 lab=C2}
C {devices/lab_pin.sym} 550 1140 0 0 {name=l448 lab=VDD}
C {devices/lab_pin.sym} 630 1200 2 0 {name=l449 lab=CARRY3}
C {devices/lab_pin.sym} 500 1180 0 0 {name=l450 lab=C0}
C {devices/lab_pin.sym} 500 1200 0 0 {name=l451 lab=C1}
C {devices/lab_pin.sym} 550 1260 2 0 {name=l452 lab=VSS}
C {devices/lab_pin.sym} 30 1370 0 0 {name=l453 lab=VDD}
C {devices/lab_pin.sym} -20 1410 0 0 {name=l454 lab=C1}
C {devices/lab_pin.sym} -20 1450 0 0 {name=l455 lab=C2}
C {devices/lab_pin.sym} 30 1490 2 0 {name=l456 lab=VSS}
C {devices/lab_pin.sym} 340 1390 0 0 {name=l457 lab=VDD}
C {devices/lab_pin.sym} 440 1450 2 0 {name=l458 lab=COUNT_RUN}
C {devices/lab_pin.sym} 290 1430 0 0 {name=l459 lab=C3}
C {devices/lab_pin.sym} 340 1510 2 0 {name=l460 lab=VSS}
C {devices/lab_pin.sym} 1860 40 0 0 {name=l461 lab=VDD}
C {devices/lab_pin.sym} 1860 160 2 0 {name=l462 lab=VSS}
C {devices/lab_pin.sym} 1860 220 0 0 {name=l463 lab=VDD}
C {devices/lab_pin.sym} 1860 340 2 0 {name=l464 lab=VSS}
C {devices/lab_pin.sym} 1860 400 0 0 {name=l465 lab=VDD}
C {devices/lab_pin.sym} 1860 520 2 0 {name=l466 lab=VSS}
C {devices/lab_pin.sym} 1860 580 0 0 {name=l467 lab=VDD}
C {devices/lab_pin.sym} 1860 700 2 0 {name=l468 lab=VSS}
C {devices/lab_pin.sym} 1860 760 0 0 {name=l469 lab=VDD}
C {devices/lab_pin.sym} 1860 880 2 0 {name=l470 lab=VSS}
C {devices/lab_pin.sym} 1860 940 0 0 {name=l471 lab=VDD}
C {devices/lab_pin.sym} 1860 1060 2 0 {name=l472 lab=VSS}
C {devices/lab_pin.sym} 1860 1120 0 0 {name=l473 lab=VDD}
C {devices/lab_pin.sym} 1860 1240 2 0 {name=l474 lab=VSS}
C {devices/lab_pin.sym} 1860 1300 0 0 {name=l475 lab=VDD}
C {devices/lab_pin.sym} 1860 1420 2 0 {name=l476 lab=VSS}
C {devices/lab_pin.sym} 1400 1630 0 0 {name=l477 lab=VDD}
C {devices/lab_pin.sym} 1350 1670 0 0 {name=l478 lab=C0}
C {devices/lab_pin.sym} 1350 1710 0 0 {name=l479 lab=C1}
C {devices/lab_pin.sym} 1400 1750 2 0 {name=l480 lab=VSS}
C {devices/lab_pin.sym} 1840 1630 0 0 {name=l481 lab=VDD}
C {devices/lab_pin.sym} 1920 1690 2 0 {name=l482 lab=RX}
C {devices/lab_pin.sym} 1790 1670 0 0 {name=l483 lab=C3B}
C {devices/lab_pin.sym} 1790 1690 0 0 {name=l484 lab=C2B}
C {devices/lab_pin.sym} 1840 1750 2 0 {name=l485 lab=VSS}
C {devices/lab_pin.sym} 4350 70 0 0 {name=l486 lab=VDD}
C {devices/lab_pin.sym} 4350 190 2 0 {name=l487 lab=VSS}
C {devices/lab_pin.sym} 3480 380 0 0 {name=l488 lab=VDD}
C {devices/lab_pin.sym} 3430 420 0 0 {name=l489 lab=E3}
C {devices/lab_pin.sym} 3430 460 0 0 {name=l490 lab=E4}
C {devices/lab_pin.sym} 3480 500 2 0 {name=l491 lab=VSS}
C {devices/lab_pin.sym} 4350 410 0 0 {name=l492 lab=VDD}
C {devices/noconn.sym} 4410 480 0 0 {name=nc493}
C {devices/lab_pin.sym} 4350 530 2 0 {name=l494 lab=VSS}
C {devices/lab_pin.sym} 2680 720 0 0 {name=l495 lab=E2}
C {devices/lab_pin.sym} 2680 740 0 0 {name=l496 lab=E3}
C {devices/lab_pin.sym} 2680 760 0 0 {name=l497 lab=E4}
C {devices/lab_pin.sym} 2680 780 0 0 {name=l498 lab=E5}
C {devices/lab_pin.sym} 2720 690 0 0 {name=l499 lab=VDD}
C {devices/lab_pin.sym} 2720 810 2 0 {name=l500 lab=VSS}
C {devices/lab_pin.sym} 3480 710 0 0 {name=l501 lab=VDD}
C {devices/lab_pin.sym} 3430 790 0 0 {name=l502 lab=W}
C {devices/lab_pin.sym} 3480 830 2 0 {name=l503 lab=VSS}
C {devices/lab_pin.sym} 4350 740 0 0 {name=l504 lab=VDD}
C {devices/noconn.sym} 4410 810 0 0 {name=nc505}
C {devices/lab_pin.sym} 4350 860 2 0 {name=l506 lab=VSS}
C {devices/lab_pin.sym} 2730 1010 0 0 {name=l507 lab=VDD}
C {devices/lab_pin.sym} 2680 1050 0 0 {name=l508 lab=WE}
C {devices/lab_pin.sym} 2730 1090 2 0 {name=l509 lab=VSS}
C {devices/lab_pin.sym} 3220 1010 0 0 {name=l510 lab=VDD}
C {devices/lab_pin.sym} 3170 1090 0 0 {name=l511 lab=E0}
C {devices/lab_pin.sym} 3220 1130 2 0 {name=l512 lab=VSS}
C {devices/lab_pin.sym} 2670 1420 0 0 {name=l513 lab=E3}
C {devices/lab_pin.sym} 2720 1340 0 0 {name=l514 lab=VDD}
C {devices/lab_pin.sym} 2670 1380 0 0 {name=l515 lab=E1}
C {devices/lab_pin.sym} 2670 1400 0 0 {name=l516 lab=E2}
C {devices/lab_pin.sym} 2720 1460 2 0 {name=l517 lab=VSS}
C {devices/lab_pin.sym} 3220 1360 0 0 {name=l518 lab=VDD}
C {devices/lab_pin.sym} 3170 1440 0 0 {name=l519 lab=W_B}
C {devices/lab_pin.sym} 3220 1480 2 0 {name=l520 lab=VSS}
C {devices/lab_pin.sym} 3810 1200 0 0 {name=l521 lab=VDD}
C {devices/lab_pin.sym} 3810 1320 2 0 {name=l522 lab=VSS}
C {devices/lab_pin.sym} 4350 1230 0 0 {name=l523 lab=VDD}
C {devices/lab_pin.sym} 4350 1350 2 0 {name=l524 lab=VSS}
T {D  /  SHARED FRAME: SDI -> DIN -> CA -> RA  (MUX holds when RX=0)} -180 1990 0 0 0.34 0.34 {}
C {TR-1um_5_stdcell/MUX2.sym} 100 2250 0 0 {name=xshift0_mux}
C {TR-1um_5_stdcell/DFFR.sym} 400 2280 0 0 {name=xshift0_ff}
N 170 2250 370 2250 {lab=xshift0_D}
C {devices/lab_wire.sym} 200 2250 0 0 {name=frame_l232 lab=xshift0_D}
N 430 2250 550 2250 {lab=DIN}
N 550 2250 550 2130 {lab=DIN}
N 550 2130 20 2130 {lab=DIN}
N 20 2130 20 2230 {lab=DIN}
N 20 2230 80 2230 {lab=DIN}
N 430 2250 620 2250 {lab=DIN}
C {devices/opin.sym} 620 2250 0 0 {name=pDIN lab=DIN}
N 370 2290 340 2290 {lab=CLK}
N 340 2290 340 2380 {lab=CLK}
N 400 2320 400 2430 {lab=RESET}
N 120 2290 120 2480 {lab=RX}
T {After RX2: DIN} 300 2170 0 0 0.23 0.23 {}
C {TR-1um_5_stdcell/MUX2.sym} 1000 2250 0 0 {name=xshift1_mux}
C {TR-1um_5_stdcell/DFFR.sym} 1300 2280 0 0 {name=xshift1_ff}
N 1070 2250 1270 2250 {lab=xshift1_D}
C {devices/lab_wire.sym} 1100 2250 0 0 {name=frame_l248 lab=xshift1_D}
N 1330 2250 1450 2250 {lab=CA}
N 1450 2250 1450 2130 {lab=CA}
N 1450 2130 920 2130 {lab=CA}
N 920 2130 920 2230 {lab=CA}
N 920 2230 980 2230 {lab=CA}
N 1330 2250 1520 2250 {lab=CA}
C {devices/opin.sym} 1520 2250 0 0 {name=pCA lab=CA}
N 1270 2290 1240 2290 {lab=CLK}
N 1240 2290 1240 2380 {lab=CLK}
N 1300 2320 1300 2430 {lab=RESET}
N 1020 2290 1020 2480 {lab=RX}
T {After RX2: CA} 1200 2170 0 0 0.23 0.23 {}
C {TR-1um_5_stdcell/MUX2.sym} 1900 2250 0 0 {name=xshift2_mux}
C {TR-1um_5_stdcell/DFFR.sym} 2200 2280 0 0 {name=xshift2_ff}
N 1970 2250 2170 2250 {lab=xshift2_D}
C {devices/lab_wire.sym} 2000 2250 0 0 {name=frame_l264 lab=xshift2_D}
N 2230 2250 2350 2250 {lab=RA}
N 2350 2250 2350 2130 {lab=RA}
N 2350 2130 1820 2130 {lab=RA}
N 1820 2130 1820 2230 {lab=RA}
N 1820 2230 1880 2230 {lab=RA}
N 2230 2250 2420 2250 {lab=RA}
C {devices/opin.sym} 2420 2250 0 0 {name=pRA lab=RA}
N 2170 2290 2140 2290 {lab=CLK}
N 2140 2290 2140 2380 {lab=CLK}
N 2200 2320 2200 2430 {lab=RESET}
N 1920 2290 1920 2480 {lab=RX}
T {After RX2: RA} 2100 2170 0 0 0.23 0.23 {}
N 80 2270 -150 2270 {lab=SDI}
C {devices/ipin.sym} -150 2270 0 0 {name=pSDI lab=SDI}
N 430 2250 780 2250 {lab=DIN}
N 780 2250 780 2270 {lab=DIN}
N 780 2270 980 2270 {lab=DIN}
N 1330 2250 1680 2250 {lab=CA}
N 1680 2250 1680 2270 {lab=CA}
N 1680 2270 1880 2270 {lab=CA}
N -150 2380 2540 2380 {lab=CLK}
C {devices/lab_wire.sym} -150 2380 0 0 {name=frame_l286 lab=CLK}
N -150 2430 2540 2430 {lab=RESET}
C {devices/lab_wire.sym} -150 2430 0 0 {name=frame_l288 lab=RESET}
N -150 2480 2540 2480 {lab=RX}
C {devices/lab_wire.sym} -150 2480 0 0 {name=frame_l290 lab=RX}
T {During RX: RA / CA / DIN shift; WL and write are OFF; SAE=1 isolates the SA.} -180 2660 0 0 0.27 0.27 {}
T {After RX2: the complete address and data stay fixed through E0..E7.} -180 2730 0 0 0.27 0.27 {}
T {E0 samples WE and precharges bitlines. No second address/data register bank.} -180 2800 0 0 0.27 0.27 {}
T {E  /  WRITE MODE: sample WE at E0 only} 2830 2660 0 0 0.3 0.3 {}
C {TR-1um_5_stdcell/MUX2.sym} 2800 2920 0 0 {name=xcmd3_mux}
C {TR-1um_5_stdcell/DFFR.sym} 3100 2950 0 0 {name=xcmd3_ff}
N 2870 2920 3070 2920 {lab=xcmd3_D}
C {devices/lab_wire.sym} 2900 2920 0 0 {name=frame_l298 lab=xcmd3_D}
N 3130 2920 3250 2920 {lab=W}
N 3250 2920 3250 2800 {lab=W}
N 3250 2800 2720 2800 {lab=W}
N 2720 2800 2720 2900 {lab=W}
N 2720 2900 2780 2900 {lab=W}
N 3130 2920 3320 2920 {lab=W}
C {devices/lab_pin.sym} 3320 2920 2 0 {name=frame_l305 lab=W}
N 3070 2960 3040 2960 {lab=CLK}
N 3040 2960 3040 3050 {lab=CLK}
N 3100 2990 3100 3100 {lab=RESET}
N 2820 2960 2820 3150 {lab=E0}
N 2780 2940 2550 2940 {lab=WE}
C {devices/ipin.sym} 2550 2940 0 0 {name=pWE lab=WE}
T {W held during shifting and E1..E7} 2800 3280 0 0 0.24 0.24 {}
N 2550 3050 3510 3050 {lab=CLK}
C {devices/lab_wire.sym} 2550 3050 0 0 {name=frame_l314 lab=CLK}
N 2550 3100 3510 3100 {lab=RESET}
C {devices/lab_wire.sym} 2550 3100 0 0 {name=frame_l316 lab=RESET}
N 2550 3150 3510 3150 {lab=E0}
C {devices/lab_wire.sym} 2550 3150 0 0 {name=frame_l318 lab=E0}
T {F  /  READ RESULT: capture at read E6; hold through writes} 2830 1990 0 0 0.3 0.3 {}
C {TR-1um_5_stdcell/AND2_X1.sym} 2750 2130 0 0 {name=xread_capture}
C {TR-1um_5_stdcell/MUX2.sym} 3370 2250 0 0 {name=xread_mux}
C {TR-1um_5_stdcell/DFFR.sym} 3670 2280 0 0 {name=xread_ff}
N 3440 2250 3640 2250 {lab=xread_D}
C {devices/lab_wire.sym} 3470 2250 0 0 {name=frame_l324 lab=xread_D}
N 3700 2250 3820 2250 {lab=SDO}
N 3820 2250 3820 2130 {lab=SDO}
N 3820 2130 3290 2130 {lab=SDO}
N 3290 2130 3290 2230 {lab=SDO}
N 3290 2230 3350 2230 {lab=SDO}
N 3700 2250 3890 2250 {lab=SDO}
C {devices/lab_pin.sym} 3890 2250 2 0 {name=frame_l331 lab=SDO}
N 3640 2290 3610 2290 {lab=CLK}
N 3610 2290 3610 2380 {lab=CLK}
N 3670 2320 3670 2430 {lab=RESET}
N 3390 2290 3390 2480 {lab=READ_CAPTURE}
N 3350 2270 3090 2270 {lab=SOUT}
C {devices/ipin.sym} 3090 2270 0 0 {name=pSOUT lab=SOUT}
C {devices/opin.sym} 3890 2250 0 0 {name=pSDO lab=SDO}
N 3200 2380 3970 2380 {lab=CLK}
C {devices/lab_wire.sym} 3200 2380 0 0 {name=frame_l340 lab=CLK}
N 3200 2430 3970 2430 {lab=RESET}
C {devices/lab_wire.sym} 3200 2430 0 0 {name=frame_l342 lab=RESET}
N 3200 2480 3970 2480 {lab=READ_CAPTURE}
C {devices/lab_wire.sym} 3200 2480 0 0 {name=frame_l344 lab=READ_CAPTURE}
C {devices/lab_pin.sym} 140 2210 0 0 {name=frame_l462 lab=VDD}
C {devices/lab_pin.sym} 140 2290 2 0 {name=frame_l463 lab=VSS}
C {devices/lab_pin.sym} 370 2220 0 0 {name=frame_l464 lab=VDD}
C {devices/noconn.sym} 430 2290 0 0 {name=frame_nc465}
C {devices/lab_pin.sym} 370 2340 2 0 {name=frame_l466 lab=VSS}
C {devices/lab_pin.sym} 1040 2210 0 0 {name=frame_l467 lab=VDD}
C {devices/lab_pin.sym} 1040 2290 2 0 {name=frame_l468 lab=VSS}
C {devices/lab_pin.sym} 1270 2220 0 0 {name=frame_l469 lab=VDD}
C {devices/noconn.sym} 1330 2290 0 0 {name=frame_nc470}
C {devices/lab_pin.sym} 1270 2340 2 0 {name=frame_l471 lab=VSS}
C {devices/lab_pin.sym} 1940 2210 0 0 {name=frame_l472 lab=VDD}
C {devices/lab_pin.sym} 1940 2290 2 0 {name=frame_l473 lab=VSS}
C {devices/lab_pin.sym} 2170 2220 0 0 {name=frame_l474 lab=VDD}
C {devices/noconn.sym} 2230 2290 0 0 {name=frame_nc475}
C {devices/lab_pin.sym} 2170 2340 2 0 {name=frame_l476 lab=VSS}
C {devices/lab_pin.sym} 2840 2880 0 0 {name=frame_l477 lab=VDD}
C {devices/lab_pin.sym} 2840 2960 2 0 {name=frame_l478 lab=VSS}
C {devices/lab_pin.sym} 3070 2890 0 0 {name=frame_l479 lab=VDD}
C {devices/lab_pin.sym} 3130 2960 2 0 {name=frame_l480 lab=W_B}
C {devices/lab_pin.sym} 3070 3010 2 0 {name=frame_l481 lab=VSS}
C {devices/lab_pin.sym} 2780 2070 0 0 {name=frame_l482 lab=VDD}
C {devices/lab_pin.sym} 2860 2130 2 0 {name=frame_l483 lab=READ_CAPTURE}
C {devices/lab_pin.sym} 2730 2110 0 0 {name=frame_l484 lab=E6}
C {devices/lab_pin.sym} 2730 2150 0 0 {name=frame_l485 lab=W_B}
C {devices/lab_pin.sym} 2780 2190 2 0 {name=frame_l486 lab=VSS}
C {devices/lab_pin.sym} 3410 2210 0 0 {name=frame_l487 lab=VDD}
C {devices/lab_pin.sym} 3410 2290 2 0 {name=frame_l488 lab=VSS}
C {devices/lab_pin.sym} 3640 2220 0 0 {name=frame_l489 lab=VDD}
C {devices/noconn.sym} 3700 2290 0 0 {name=frame_nc490}
C {devices/lab_pin.sym} 3640 2340 2 0 {name=frame_l491 lab=VSS}
