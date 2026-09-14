v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
E {}
T {SHARED RECEIVE / ACCESS STORAGE: 10 DFFR + 10 feedback MUX2} -250 -300 0 0 0.3 0.3 {}
T {RX=1 shifts; RX=0 holds the complete frame. All FFs use the same ungated CLK.} -250 -230 0 0 0.3 0.3 {}
T {bit 0: DIN} 170 -100 0 0 0.3 0.3 {}
T {bit 1: CA0} 930 -100 0 0 0.3 0.3 {}
T {bit 2: CA1} 1690 -100 0 0 0.3 0.3 {}
T {bit 3: CA2} 2450 -100 0 0 0.3 0.3 {}
T {bit 4: CA3} 3210 -100 0 0 0.3 0.3 {}
T {bit 5: CA4} 170 680 0 0 0.3 0.3 {}
T {bit 6: RA0} 930 680 0 0 0.3 0.3 {}
T {bit 7: RA1} 1690 680 0 0 0.3 0.3 {}
T {bit 8: RA2} 2450 680 0 0 0.3 0.3 {}
T {bit 9: RA3} 3210 680 0 0 0.3 0.3 {}
C {TR-1um_5_stdcell/MUX2.sym} 0 0 0 0 {name=xframe_DIN_hold}
C {TR-1um_5_stdcell/DFFR.sym} 300 30 0 0 {name=xframe_DIN}
C {TR-1um_5_stdcell/MUX2.sym} 760 0 0 0 {name=xframe_CA0_hold}
C {TR-1um_5_stdcell/DFFR.sym} 1060 30 0 0 {name=xframe_CA0}
C {TR-1um_5_stdcell/MUX2.sym} 1520 0 0 0 {name=xframe_CA1_hold}
C {TR-1um_5_stdcell/DFFR.sym} 1820 30 0 0 {name=xframe_CA1}
C {TR-1um_5_stdcell/MUX2.sym} 2280 0 0 0 {name=xframe_CA2_hold}
C {TR-1um_5_stdcell/DFFR.sym} 2580 30 0 0 {name=xframe_CA2}
C {TR-1um_5_stdcell/MUX2.sym} 3040 0 0 0 {name=xframe_CA3_hold}
C {TR-1um_5_stdcell/DFFR.sym} 3340 30 0 0 {name=xframe_CA3}
C {TR-1um_5_stdcell/MUX2.sym} 0 780 0 0 {name=xframe_CA4_hold}
C {TR-1um_5_stdcell/DFFR.sym} 300 810 0 0 {name=xframe_CA4}
C {TR-1um_5_stdcell/MUX2.sym} 760 780 0 0 {name=xframe_RA0_hold}
C {TR-1um_5_stdcell/DFFR.sym} 1060 810 0 0 {name=xframe_RA0}
C {TR-1um_5_stdcell/MUX2.sym} 1520 780 0 0 {name=xframe_RA1_hold}
C {TR-1um_5_stdcell/DFFR.sym} 1820 810 0 0 {name=xframe_RA1}
C {TR-1um_5_stdcell/MUX2.sym} 2280 780 0 0 {name=xframe_RA2_hold}
C {TR-1um_5_stdcell/DFFR.sym} 2580 810 0 0 {name=xframe_RA2}
C {TR-1um_5_stdcell/MUX2.sym} 3040 780 0 0 {name=xframe_RA3_hold}
C {TR-1um_5_stdcell/DFFR.sym} 3340 810 0 0 {name=xframe_RA3}
N 330 0 410 0 {lab=DIN}
N 410 0 410 -120 {lab=DIN}
N 410 -120 -70 -120 {lab=DIN}
N -70 -120 -70 -20 {lab=DIN}
N -70 -20 -20 -20 {lab=DIN}
C {devices/lab_wire.sym} 410 -120 0 0 {name=l43 lab=DIN}
N 70 0 270 0 {lab=DIN_D}
N 1090 0 1170 0 {lab=CA0}
N 1170 0 1170 -120 {lab=CA0}
N 1170 -120 690 -120 {lab=CA0}
N 690 -120 690 -20 {lab=CA0}
N 690 -20 740 -20 {lab=CA0}
C {devices/lab_wire.sym} 1170 -120 0 0 {name=l50 lab=CA0}
N 830 0 1030 0 {lab=CA0_D}
N 1850 0 1930 0 {lab=CA1}
N 1930 0 1930 -120 {lab=CA1}
N 1930 -120 1450 -120 {lab=CA1}
N 1450 -120 1450 -20 {lab=CA1}
N 1450 -20 1500 -20 {lab=CA1}
C {devices/lab_wire.sym} 1930 -120 0 0 {name=l57 lab=CA1}
N 1590 0 1790 0 {lab=CA1_D}
N 2610 0 2690 0 {lab=CA2}
N 2690 0 2690 -120 {lab=CA2}
N 2690 -120 2210 -120 {lab=CA2}
N 2210 -120 2210 -20 {lab=CA2}
N 2210 -20 2260 -20 {lab=CA2}
C {devices/lab_wire.sym} 2690 -120 0 0 {name=l64 lab=CA2}
N 2350 0 2550 0 {lab=CA2_D}
N 3370 0 3450 0 {lab=CA3}
N 3450 0 3450 -120 {lab=CA3}
N 3450 -120 2970 -120 {lab=CA3}
N 2970 -120 2970 -20 {lab=CA3}
N 2970 -20 3020 -20 {lab=CA3}
C {devices/lab_wire.sym} 3450 -120 0 0 {name=l71 lab=CA3}
N 3110 0 3310 0 {lab=CA3_D}
N 330 780 410 780 {lab=CA4}
N 410 780 410 660 {lab=CA4}
N 410 660 -70 660 {lab=CA4}
N -70 660 -70 760 {lab=CA4}
N -70 760 -20 760 {lab=CA4}
C {devices/lab_wire.sym} 410 660 0 0 {name=l78 lab=CA4}
N 70 780 270 780 {lab=CA4_D}
N 1090 780 1170 780 {lab=RA0}
N 1170 780 1170 660 {lab=RA0}
N 1170 660 690 660 {lab=RA0}
N 690 660 690 760 {lab=RA0}
N 690 760 740 760 {lab=RA0}
C {devices/lab_wire.sym} 1170 660 0 0 {name=l85 lab=RA0}
N 830 780 1030 780 {lab=RA0_D}
N 1850 780 1930 780 {lab=RA1}
N 1930 780 1930 660 {lab=RA1}
N 1930 660 1450 660 {lab=RA1}
N 1450 660 1450 760 {lab=RA1}
N 1450 760 1500 760 {lab=RA1}
C {devices/lab_wire.sym} 1930 660 0 0 {name=l92 lab=RA1}
N 1590 780 1790 780 {lab=RA1_D}
N 2610 780 2690 780 {lab=RA2}
N 2690 780 2690 660 {lab=RA2}
N 2690 660 2210 660 {lab=RA2}
N 2210 660 2210 760 {lab=RA2}
N 2210 760 2260 760 {lab=RA2}
C {devices/lab_wire.sym} 2690 660 0 0 {name=l99 lab=RA2}
N 2350 780 2550 780 {lab=RA2_D}
N 3370 780 3450 780 {lab=RA3}
N 3450 780 3450 660 {lab=RA3}
N 3450 660 2970 660 {lab=RA3}
N 2970 660 2970 760 {lab=RA3}
N 2970 760 3020 760 {lab=RA3}
C {devices/lab_wire.sym} 3450 660 0 0 {name=l106 lab=RA3}
N 3110 780 3310 780 {lab=RA3_D}
N 270 40 160 40 {lab=CLK}
N 270 820 160 820 {lab=CLK}
N 160 -10 160 850 {lab=CLK}
C {devices/lab_wire.sym} 160 -10 0 0 {name=l111 lab=CLK}
N 300 70 300 110 {lab=RESET}
N 300 110 220 110 {lab=RESET}
N 300 850 300 890 {lab=RESET}
N 300 890 220 890 {lab=RESET}
N 220 60 220 920 {lab=RESET}
C {devices/lab_wire.sym} 220 60 0 0 {name=l117 lab=RESET}
N 1030 40 920 40 {lab=CLK}
N 1030 820 920 820 {lab=CLK}
N 920 -10 920 850 {lab=CLK}
C {devices/lab_wire.sym} 920 -10 0 0 {name=l121 lab=CLK}
N 1060 70 1060 110 {lab=RESET}
N 1060 110 980 110 {lab=RESET}
N 1060 850 1060 890 {lab=RESET}
N 1060 890 980 890 {lab=RESET}
N 980 60 980 920 {lab=RESET}
C {devices/lab_wire.sym} 980 60 0 0 {name=l127 lab=RESET}
N 1790 40 1680 40 {lab=CLK}
N 1790 820 1680 820 {lab=CLK}
N 1680 -10 1680 850 {lab=CLK}
C {devices/lab_wire.sym} 1680 -10 0 0 {name=l131 lab=CLK}
N 1820 70 1820 110 {lab=RESET}
N 1820 110 1740 110 {lab=RESET}
N 1820 850 1820 890 {lab=RESET}
N 1820 890 1740 890 {lab=RESET}
N 1740 60 1740 920 {lab=RESET}
C {devices/lab_wire.sym} 1740 60 0 0 {name=l137 lab=RESET}
N 2550 40 2440 40 {lab=CLK}
N 2550 820 2440 820 {lab=CLK}
N 2440 -10 2440 850 {lab=CLK}
C {devices/lab_wire.sym} 2440 -10 0 0 {name=l141 lab=CLK}
N 2580 70 2580 110 {lab=RESET}
N 2580 110 2500 110 {lab=RESET}
N 2580 850 2580 890 {lab=RESET}
N 2580 890 2500 890 {lab=RESET}
N 2500 60 2500 920 {lab=RESET}
C {devices/lab_wire.sym} 2500 60 0 0 {name=l147 lab=RESET}
N 3310 40 3200 40 {lab=CLK}
N 3310 820 3200 820 {lab=CLK}
N 3200 -10 3200 850 {lab=CLK}
C {devices/lab_wire.sym} 3200 -10 0 0 {name=l151 lab=CLK}
N 3340 70 3340 110 {lab=RESET}
N 3340 110 3260 110 {lab=RESET}
N 3340 850 3340 890 {lab=RESET}
N 3340 890 3260 890 {lab=RESET}
N 3260 60 3260 920 {lab=RESET}
C {devices/lab_wire.sym} 3260 60 0 0 {name=l157 lab=RESET}
C {devices/ipin.sym} -520 10 0 0 {name=pCLK lab=CLK}
N -520 10 -460 10 {lab=CLK}
C {devices/lab_pin.sym} -460 10 0 0 {name=l160 lab=CLK hide_texts=true}
C {devices/ipin.sym} -520 100 0 0 {name=pRESET lab=RESET}
N -520 100 -460 100 {lab=RESET}
C {devices/lab_pin.sym} -460 100 0 0 {name=l163 lab=RESET hide_texts=true}
C {devices/ipin.sym} -520 190 0 0 {name=pRX lab=RX}
N -520 190 -460 190 {lab=RX}
C {devices/lab_pin.sym} -460 190 0 0 {name=l166 lab=RX hide_texts=true}
C {devices/ipin.sym} -520 280 0 0 {name=pSDI lab=SDI}
N -520 280 -460 280 {lab=SDI}
C {devices/lab_pin.sym} -460 280 0 0 {name=l169 lab=SDI hide_texts=true}
N 330 0 530 0 {lab=DIN}
C {devices/opin.sym} 530 0 0 0 {name=pDIN lab=DIN}
N 330 40 530 40 {lab=DINB}
C {devices/opin.sym} 530 40 0 0 {name=pDINB lab=DINB}
N 1090 0 1290 0 {lab=CA0}
C {devices/opin.sym} 1290 0 0 0 {name=pCA0 lab=CA0}
N 1090 40 1290 40 {lab=CA0B}
C {devices/opin.sym} 1290 40 0 0 {name=pCA0B lab=CA0B}
N 1850 0 2050 0 {lab=CA1}
C {devices/opin.sym} 2050 0 0 0 {name=pCA1 lab=CA1}
N 1850 40 2050 40 {lab=CA1B}
C {devices/opin.sym} 2050 40 0 0 {name=pCA1B lab=CA1B}
N 2610 0 2810 0 {lab=CA2}
C {devices/opin.sym} 2810 0 0 0 {name=pCA2 lab=CA2}
N 2610 40 2810 40 {lab=CA2B}
C {devices/opin.sym} 2810 40 0 0 {name=pCA2B lab=CA2B}
N 3370 0 3570 0 {lab=CA3}
C {devices/opin.sym} 3570 0 0 0 {name=pCA3 lab=CA3}
N 3370 40 3570 40 {lab=CA3B}
C {devices/opin.sym} 3570 40 0 0 {name=pCA3B lab=CA3B}
N 330 780 530 780 {lab=CA4}
C {devices/opin.sym} 530 780 0 0 {name=pCA4 lab=CA4}
N 330 820 530 820 {lab=CA4B}
C {devices/opin.sym} 530 820 0 0 {name=pCA4B lab=CA4B}
N 1090 780 1290 780 {lab=RA0}
C {devices/opin.sym} 1290 780 0 0 {name=pRA0 lab=RA0}
N 1090 820 1290 820 {lab=RA0B}
C {devices/opin.sym} 1290 820 0 0 {name=pRA0B lab=RA0B}
N 1850 780 2050 780 {lab=RA1}
C {devices/opin.sym} 2050 780 0 0 {name=pRA1 lab=RA1}
N 1850 820 2050 820 {lab=RA1B}
C {devices/opin.sym} 2050 820 0 0 {name=pRA1B lab=RA1B}
N 2610 780 2810 780 {lab=RA2}
C {devices/opin.sym} 2810 780 0 0 {name=pRA2 lab=RA2}
N 2610 820 2810 820 {lab=RA2B}
C {devices/opin.sym} 2810 820 0 0 {name=pRA2B lab=RA2B}
N 3370 780 3570 780 {lab=RA3}
C {devices/opin.sym} 3570 780 0 0 {name=pRA3 lab=RA3}
N 3370 820 3570 820 {lab=RA3B}
C {devices/opin.sym} 3570 820 0 0 {name=pRA3B lab=RA3B}
C {devices/iopin.sym} -520 -200 0 0 {name=pVDD lab=VDD}
N -520 -200 -460 -200 {lab=VDD}
C {devices/lab_pin.sym} -460 -200 0 0 {name=l212 lab=VDD hide_texts=true}
C {devices/iopin.sym} -520 -130 0 0 {name=pVSS lab=VSS}
N -520 -130 -460 -130 {lab=VSS}
C {devices/lab_pin.sym} -460 -130 0 0 {name=l215 lab=VSS hide_texts=true}
C {devices/lab_pin.sym} -20 20 0 0 {name=l216 lab=SDI}
C {devices/lab_pin.sym} 20 40 0 0 {name=l217 lab=RX}
C {devices/lab_pin.sym} 40 -40 0 0 {name=l218 lab=VDD}
C {devices/lab_pin.sym} 40 40 0 0 {name=l219 lab=VSS}
C {devices/lab_pin.sym} 270 -30 0 0 {name=l220 lab=VDD}
C {devices/lab_pin.sym} 270 90 0 0 {name=l221 lab=VSS}
C {devices/lab_pin.sym} 740 20 0 0 {name=l222 lab=DIN}
C {devices/lab_pin.sym} 780 40 0 0 {name=l223 lab=RX}
C {devices/lab_pin.sym} 800 -40 0 0 {name=l224 lab=VDD}
C {devices/lab_pin.sym} 800 40 0 0 {name=l225 lab=VSS}
C {devices/lab_pin.sym} 1030 -30 0 0 {name=l226 lab=VDD}
C {devices/lab_pin.sym} 1030 90 0 0 {name=l227 lab=VSS}
C {devices/lab_pin.sym} 1500 20 0 0 {name=l228 lab=CA0}
C {devices/lab_pin.sym} 1540 40 0 0 {name=l229 lab=RX}
C {devices/lab_pin.sym} 1560 -40 0 0 {name=l230 lab=VDD}
C {devices/lab_pin.sym} 1560 40 0 0 {name=l231 lab=VSS}
C {devices/lab_pin.sym} 1790 -30 0 0 {name=l232 lab=VDD}
C {devices/lab_pin.sym} 1790 90 0 0 {name=l233 lab=VSS}
C {devices/lab_pin.sym} 2260 20 0 0 {name=l234 lab=CA1}
C {devices/lab_pin.sym} 2300 40 0 0 {name=l235 lab=RX}
C {devices/lab_pin.sym} 2320 -40 0 0 {name=l236 lab=VDD}
C {devices/lab_pin.sym} 2320 40 0 0 {name=l237 lab=VSS}
C {devices/lab_pin.sym} 2550 -30 0 0 {name=l238 lab=VDD}
C {devices/lab_pin.sym} 2550 90 0 0 {name=l239 lab=VSS}
C {devices/lab_pin.sym} 3020 20 0 0 {name=l240 lab=CA2}
C {devices/lab_pin.sym} 3060 40 0 0 {name=l241 lab=RX}
C {devices/lab_pin.sym} 3080 -40 0 0 {name=l242 lab=VDD}
C {devices/lab_pin.sym} 3080 40 0 0 {name=l243 lab=VSS}
C {devices/lab_pin.sym} 3310 -30 0 0 {name=l244 lab=VDD}
C {devices/lab_pin.sym} 3310 90 0 0 {name=l245 lab=VSS}
C {devices/lab_pin.sym} -20 800 0 0 {name=l246 lab=CA3}
C {devices/lab_pin.sym} 20 820 0 0 {name=l247 lab=RX}
C {devices/lab_pin.sym} 40 740 0 0 {name=l248 lab=VDD}
C {devices/lab_pin.sym} 40 820 0 0 {name=l249 lab=VSS}
C {devices/lab_pin.sym} 270 750 0 0 {name=l250 lab=VDD}
C {devices/lab_pin.sym} 270 870 0 0 {name=l251 lab=VSS}
C {devices/lab_pin.sym} 740 800 0 0 {name=l252 lab=CA4}
C {devices/lab_pin.sym} 780 820 0 0 {name=l253 lab=RX}
C {devices/lab_pin.sym} 800 740 0 0 {name=l254 lab=VDD}
C {devices/lab_pin.sym} 800 820 0 0 {name=l255 lab=VSS}
C {devices/lab_pin.sym} 1030 750 0 0 {name=l256 lab=VDD}
C {devices/lab_pin.sym} 1030 870 0 0 {name=l257 lab=VSS}
C {devices/lab_pin.sym} 1500 800 0 0 {name=l258 lab=RA0}
C {devices/lab_pin.sym} 1540 820 0 0 {name=l259 lab=RX}
C {devices/lab_pin.sym} 1560 740 0 0 {name=l260 lab=VDD}
C {devices/lab_pin.sym} 1560 820 0 0 {name=l261 lab=VSS}
C {devices/lab_pin.sym} 1790 750 0 0 {name=l262 lab=VDD}
C {devices/lab_pin.sym} 1790 870 0 0 {name=l263 lab=VSS}
C {devices/lab_pin.sym} 2260 800 0 0 {name=l264 lab=RA1}
C {devices/lab_pin.sym} 2300 820 0 0 {name=l265 lab=RX}
C {devices/lab_pin.sym} 2320 740 0 0 {name=l266 lab=VDD}
C {devices/lab_pin.sym} 2320 820 0 0 {name=l267 lab=VSS}
C {devices/lab_pin.sym} 2550 750 0 0 {name=l268 lab=VDD}
C {devices/lab_pin.sym} 2550 870 0 0 {name=l269 lab=VSS}
C {devices/lab_pin.sym} 3020 800 0 0 {name=l270 lab=RA2}
C {devices/lab_pin.sym} 3060 820 0 0 {name=l271 lab=RX}
C {devices/lab_pin.sym} 3080 740 0 0 {name=l272 lab=VDD}
C {devices/lab_pin.sym} 3080 820 0 0 {name=l273 lab=VSS}
C {devices/lab_pin.sym} 3310 750 0 0 {name=l274 lab=VDD}
C {devices/lab_pin.sym} 3310 870 0 0 {name=l275 lab=VSS}
