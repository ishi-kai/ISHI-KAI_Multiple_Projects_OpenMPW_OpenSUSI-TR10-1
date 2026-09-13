v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
E {}
T {REGISTERED ACCESS CONTROL: six DFFR, including W and read-result storage} -150 -330 0 0 0.3 0.3 {}
T {E0 PC | E1 release | E2 write drive | E3 WL | E4 sense | E5 WL off | E6 capture / PD off} -150 -260 0 0 0.3 0.3 {}
T {W samples WE only at E0. SDO storage updates only on read E6.} -150 2530 0 0 0.3 0.3 {}
C {TR-1um_5_stdcell/DFFR.sym} 1800 30 0 0 {name=xpc}
C {TR-1um_5_stdcell/OR2.sym} 850 310 0 0 {name=xwl_window}
C {TR-1um_5_stdcell/DFFR.sym} 1800 340 0 0 {name=xwl}
C {TR-1um_5_stdcell/OR4.sym} 300 610 0 0 {name=xwrite_window}
C {TR-1um_5_stdcell/AND2_X1.sym} 850 610 0 0 {name=xwrite_data}
C {TR-1um_5_stdcell/DFFR.sym} 1800 640 0 0 {name=xwrite}
C {TR-1um_5_stdcell/INV_X1.sym} -100 910 0 0 {name=xwe_b}
C {TR-1um_5_stdcell/AND2_X1.sym} 300 930 0 0 {name=xtrack_first}
C {TR-1um_5_stdcell/OR3.sym} -100 1230 0 0 {name=xtrack_later_window}
C {TR-1um_5_stdcell/AND2_X1.sym} 300 1250 0 0 {name=xtrack_later}
C {TR-1um_5_stdcell/OR2.sym} 850 1090 0 0 {name=xtrack_data}
C {TR-1um_5_stdcell/DFFR.sym} 1800 1120 0 0 {name=xtrack}
C {TR-1um_5_stdcell/MUX2.sym} 600 1580 0 0 {name=xmode_hold}
C {TR-1um_5_stdcell/DFFR.sym} 900 1610 0 0 {name=xmode}
C {TR-1um_5_stdcell/AND2_X1.sym} 300 1910 0 0 {name=xread_capture}
C {TR-1um_5_stdcell/MUX2.sym} 600 2240 0 0 {name=xresult_hold}
C {TR-1um_5_stdcell/DFFR.sym} 900 2270 0 0 {name=xresult}
N 930 1580 1010 1580 {lab=W}
N 1010 1580 1010 1460 {lab=W}
N 1010 1460 530 1460 {lab=W}
N 530 1460 530 1560 {lab=W}
N 530 1560 580 1560 {lab=W}
C {devices/lab_wire.sym} 1010 1460 0 0 {name=l31 lab=W}
N 670 1580 870 1580 {lab=W_D}
N 930 2240 1010 2240 {lab=READ_DATA}
N 1010 2240 1010 2120 {lab=READ_DATA}
N 1010 2120 530 2120 {lab=READ_DATA}
N 530 2120 530 2220 {lab=READ_DATA}
N 530 2220 580 2220 {lab=READ_DATA}
C {devices/lab_wire.sym} 1010 2120 0 0 {name=l38 lab=READ_DATA}
N 670 2240 870 2240 {lab=READ_DATA_D}
N 960 310 1360 310 {lab=WL_D}
N 1360 310 1770 310 {lab=WL_D}
C {devices/lab_wire.sym} 1360 310 0 0 {name=l42 lab=WL_D}
N 410 610 620 610 {lab=WRITE_WINDOW}
N 620 610 620 590 {lab=WRITE_WINDOW}
N 620 590 830 590 {lab=WRITE_WINDOW}
C {devices/lab_wire.sym} 620 610 0 0 {name=l46 lab=WRITE_WINDOW}
N 960 610 1360 610 {lab=WRITE_D}
N 1360 610 1770 610 {lab=WRITE_D}
C {devices/lab_wire.sym} 1360 610 0 0 {name=l49 lab=WRITE_D}
N 0 910 140 910 {lab=WE_B}
N 140 910 280 910 {lab=WE_B}
C {devices/lab_wire.sym} 140 910 0 0 {name=l52 lab=WE_B}
N 410 930 620 930 {lab=TRACK_FIRST}
N 620 930 620 1070 {lab=TRACK_FIRST}
N 620 1070 830 1070 {lab=TRACK_FIRST}
C {devices/lab_wire.sym} 620 930 0 0 {name=l56 lab=TRACK_FIRST}
N 10 1230 140 1230 {lab=TRACK_WINDOW}
N 140 1230 280 1230 {lab=TRACK_WINDOW}
C {devices/lab_wire.sym} 140 1230 0 0 {name=l59 lab=TRACK_WINDOW}
N 410 1250 620 1250 {lab=TRACK_LATER}
N 620 1250 620 1110 {lab=TRACK_LATER}
N 620 1110 830 1110 {lab=TRACK_LATER}
C {devices/lab_wire.sym} 620 1250 0 0 {name=l63 lab=TRACK_LATER}
N 960 1090 1360 1090 {lab=TRACK_D}
N 1360 1090 1770 1090 {lab=TRACK_D}
C {devices/lab_wire.sym} 1360 1090 0 0 {name=l66 lab=TRACK_D}
N 410 1910 520 1910 {lab=READ_CAPTURE}
N 520 1910 520 2280 {lab=READ_CAPTURE}
N 520 2280 620 2280 {lab=READ_CAPTURE}
C {devices/lab_wire.sym} 520 1910 0 0 {name=l70 lab=READ_CAPTURE}
N 1770 40 1660 40 {lab=CLK}
N 1770 350 1660 350 {lab=CLK}
N 1770 650 1660 650 {lab=CLK}
N 1770 1130 1660 1130 {lab=CLK}
N 1660 -10 1660 1160 {lab=CLK}
C {devices/lab_wire.sym} 1660 -10 0 0 {name=l76 lab=CLK}
N 1800 70 1800 110 {lab=RESET}
N 1800 110 1720 110 {lab=RESET}
N 1800 380 1800 420 {lab=RESET}
N 1800 420 1720 420 {lab=RESET}
N 1800 680 1800 720 {lab=RESET}
N 1800 720 1720 720 {lab=RESET}
N 1800 1160 1800 1200 {lab=RESET}
N 1800 1200 1720 1200 {lab=RESET}
N 1720 60 1720 1230 {lab=RESET}
C {devices/lab_wire.sym} 1720 60 0 0 {name=l86 lab=RESET}
N 870 1620 760 1620 {lab=CLK}
N 870 2280 760 2280 {lab=CLK}
N 760 1570 760 2310 {lab=CLK}
C {devices/lab_wire.sym} 760 1570 0 0 {name=l90 lab=CLK}
N 900 1650 900 1690 {lab=RESET}
N 900 1690 820 1690 {lab=RESET}
N 900 2310 900 2350 {lab=RESET}
N 900 2350 820 2350 {lab=RESET}
N 820 1640 820 2380 {lab=RESET}
C {devices/lab_wire.sym} 820 1640 0 0 {name=l96 lab=RESET}
C {devices/ipin.sym} -520 10 0 0 {name=pCLK lab=CLK}
N -520 10 -460 10 {lab=CLK}
C {devices/lab_pin.sym} -460 10 0 0 {name=l99 lab=CLK hide_texts=true}
C {devices/ipin.sym} -520 100 0 0 {name=pRESET lab=RESET}
N -520 100 -460 100 {lab=RESET}
C {devices/lab_pin.sym} -460 100 0 0 {name=l102 lab=RESET hide_texts=true}
C {devices/ipin.sym} -520 190 0 0 {name=pWE lab=WE}
N -520 190 -460 190 {lab=WE}
C {devices/lab_pin.sym} -460 190 0 0 {name=l105 lab=WE hide_texts=true}
C {devices/ipin.sym} -520 280 0 0 {name=pSOUT lab=SOUT}
N -520 280 -460 280 {lab=SOUT}
C {devices/lab_pin.sym} -460 280 0 0 {name=l108 lab=SOUT hide_texts=true}
C {devices/ipin.sym} -520 370 0 0 {name=pE0 lab=E0}
N -520 370 -460 370 {lab=E0}
C {devices/lab_pin.sym} -460 370 0 0 {name=l111 lab=E0 hide_texts=true}
C {devices/ipin.sym} -520 460 0 0 {name=pE1 lab=E1}
N -520 460 -460 460 {lab=E1}
C {devices/lab_pin.sym} -460 460 0 0 {name=l114 lab=E1 hide_texts=true}
C {devices/ipin.sym} -520 550 0 0 {name=pE2 lab=E2}
N -520 550 -460 550 {lab=E2}
C {devices/lab_pin.sym} -460 550 0 0 {name=l117 lab=E2 hide_texts=true}
C {devices/ipin.sym} -520 640 0 0 {name=pE3 lab=E3}
N -520 640 -460 640 {lab=E3}
C {devices/lab_pin.sym} -460 640 0 0 {name=l120 lab=E3 hide_texts=true}
C {devices/ipin.sym} -520 730 0 0 {name=pE4 lab=E4}
N -520 730 -460 730 {lab=E4}
C {devices/lab_pin.sym} -460 730 0 0 {name=l123 lab=E4 hide_texts=true}
C {devices/ipin.sym} -520 820 0 0 {name=pE5 lab=E5}
N -520 820 -460 820 {lab=E5}
C {devices/lab_pin.sym} -460 820 0 0 {name=l126 lab=E5 hide_texts=true}
C {devices/ipin.sym} -520 910 0 0 {name=pE6 lab=E6}
N -520 910 -460 910 {lab=E6}
C {devices/lab_pin.sym} -460 910 0 0 {name=l129 lab=E6 hide_texts=true}
N 1830 40 2030 40 {lab=PREB}
C {devices/opin.sym} 2030 40 0 0 {name=pPREB lab=PREB}
N 1830 310 2030 310 {lab=WL_EN}
C {devices/opin.sym} 2030 310 0 0 {name=pWL_EN lab=WL_EN}
N 1830 610 2030 610 {lab=WRITE_EN}
C {devices/opin.sym} 2030 610 0 0 {name=pWRITE_EN lab=WRITE_EN}
N 1830 1130 2030 1130 {lab=SAE}
C {devices/opin.sym} 2030 1130 0 0 {name=pSAE lab=SAE}
N 930 2240 1130 2240 {lab=READ_DATA}
C {devices/opin.sym} 1130 2240 0 0 {name=pREAD_DATA lab=READ_DATA}
C {devices/iopin.sym} -520 -200 0 0 {name=pVDD lab=VDD}
N -520 -200 -460 -200 {lab=VDD}
C {devices/lab_pin.sym} -460 -200 0 0 {name=l142 lab=VDD hide_texts=true}
C {devices/iopin.sym} -520 -130 0 0 {name=pVSS lab=VSS}
N -520 -130 -460 -130 {lab=VSS}
C {devices/lab_pin.sym} -460 -130 0 0 {name=l145 lab=VSS hide_texts=true}
C {devices/lab_pin.sym} 1770 -30 0 0 {name=l146 lab=VDD}
C {devices/lab_pin.sym} 1770 0 0 0 {name=l147 lab=E0}
C {devices/lab_pin.sym} 1830 0 2 0 {name=l148 lab=PC_ON}
C {devices/noconn.sym} 1830 0 0 0 {name=nc149}
C {devices/lab_pin.sym} 1770 90 0 0 {name=l150 lab=VSS}
C {devices/lab_pin.sym} 880 250 0 0 {name=l151 lab=VDD}
C {devices/lab_pin.sym} 830 290 0 0 {name=l152 lab=E3}
C {devices/lab_pin.sym} 830 330 0 0 {name=l153 lab=E4}
C {devices/lab_pin.sym} 880 370 0 0 {name=l154 lab=VSS}
C {devices/lab_pin.sym} 1770 280 0 0 {name=l155 lab=VDD}
C {devices/lab_pin.sym} 1830 350 2 0 {name=l156 lab=WL_ENB}
C {devices/noconn.sym} 1830 350 0 0 {name=nc157}
C {devices/lab_pin.sym} 1770 400 0 0 {name=l158 lab=VSS}
C {devices/lab_pin.sym} 290 580 0 0 {name=l159 lab=E2}
C {devices/lab_pin.sym} 290 600 0 0 {name=l160 lab=E3}
C {devices/lab_pin.sym} 290 620 0 0 {name=l161 lab=E4}
C {devices/lab_pin.sym} 290 640 0 0 {name=l162 lab=E5}
C {devices/lab_pin.sym} 330 550 0 0 {name=l163 lab=VDD}
C {devices/lab_pin.sym} 330 670 0 0 {name=l164 lab=VSS}
C {devices/lab_pin.sym} 880 550 0 0 {name=l165 lab=VDD}
C {devices/lab_pin.sym} 830 630 0 0 {name=l166 lab=W}
C {devices/lab_pin.sym} 880 670 0 0 {name=l167 lab=VSS}
C {devices/lab_pin.sym} 1770 580 0 0 {name=l168 lab=VDD}
C {devices/lab_pin.sym} 1830 650 2 0 {name=l169 lab=WRITE_ENB}
C {devices/noconn.sym} 1830 650 0 0 {name=nc170}
C {devices/lab_pin.sym} 1770 700 0 0 {name=l171 lab=VSS}
C {devices/lab_pin.sym} -70 870 0 0 {name=l172 lab=VDD}
C {devices/lab_pin.sym} -120 910 0 0 {name=l173 lab=WE}
C {devices/lab_pin.sym} -70 950 0 0 {name=l174 lab=VSS}
C {devices/lab_pin.sym} 330 870 0 0 {name=l175 lab=VDD}
C {devices/lab_pin.sym} 280 950 0 0 {name=l176 lab=E0}
C {devices/lab_pin.sym} 330 990 0 0 {name=l177 lab=VSS}
C {devices/lab_pin.sym} -120 1250 0 0 {name=l178 lab=E3}
C {devices/lab_pin.sym} -70 1170 0 0 {name=l179 lab=VDD}
C {devices/lab_pin.sym} -120 1210 0 0 {name=l180 lab=E1}
C {devices/lab_pin.sym} -120 1230 0 0 {name=l181 lab=E2}
C {devices/lab_pin.sym} -70 1290 0 0 {name=l182 lab=VSS}
C {devices/lab_pin.sym} 330 1190 0 0 {name=l183 lab=VDD}
C {devices/lab_pin.sym} 280 1270 0 0 {name=l184 lab=WB}
C {devices/lab_pin.sym} 330 1310 0 0 {name=l185 lab=VSS}
C {devices/lab_pin.sym} 880 1030 0 0 {name=l186 lab=VDD}
C {devices/lab_pin.sym} 880 1150 0 0 {name=l187 lab=VSS}
C {devices/lab_pin.sym} 1770 1060 0 0 {name=l188 lab=VDD}
C {devices/lab_pin.sym} 1830 1090 2 0 {name=l189 lab=TRACK}
C {devices/noconn.sym} 1830 1090 0 0 {name=nc190}
C {devices/lab_pin.sym} 1770 1180 0 0 {name=l191 lab=VSS}
C {devices/lab_pin.sym} 580 1600 0 0 {name=l192 lab=WE}
C {devices/lab_pin.sym} 620 1620 0 0 {name=l193 lab=E0}
C {devices/lab_pin.sym} 640 1540 0 0 {name=l194 lab=VDD}
C {devices/lab_pin.sym} 640 1620 0 0 {name=l195 lab=VSS}
C {devices/lab_pin.sym} 870 1550 0 0 {name=l196 lab=VDD}
C {devices/lab_pin.sym} 930 1620 2 0 {name=l197 lab=WB}
C {devices/lab_pin.sym} 870 1670 0 0 {name=l198 lab=VSS}
C {devices/lab_pin.sym} 330 1850 0 0 {name=l199 lab=VDD}
C {devices/lab_pin.sym} 280 1890 0 0 {name=l200 lab=E6}
C {devices/lab_pin.sym} 280 1930 0 0 {name=l201 lab=WB}
C {devices/lab_pin.sym} 330 1970 0 0 {name=l202 lab=VSS}
C {devices/lab_pin.sym} 580 2260 0 0 {name=l203 lab=SOUT}
C {devices/lab_pin.sym} 640 2200 0 0 {name=l204 lab=VDD}
C {devices/lab_pin.sym} 640 2280 0 0 {name=l205 lab=VSS}
C {devices/lab_pin.sym} 870 2210 0 0 {name=l206 lab=VDD}
C {devices/lab_pin.sym} 930 2280 2 0 {name=l207 lab=READ_DATAB}
C {devices/noconn.sym} 930 2280 0 0 {name=nc208}
C {devices/lab_pin.sym} 870 2330 0 0 {name=l209 lab=VSS}
