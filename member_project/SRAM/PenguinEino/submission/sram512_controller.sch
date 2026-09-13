v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
E {}
T {512-bit SERIAL CONTROLLER | 10 receive clocks + 8 access clocks} -800 -800 0 0 0.45 0.45 {}
C {TR-1um_5_stdcell/BUF_X4.sym} -800 -450 0 0 {name=xclock}
C {TR-1um_5_stdcell/BUF_X4.sym} -800 -220 0 0 {name=xreset}
C {sram512_phase.sym} -250 0 0 0 {name=xphase}
C {sram512_frame.sym} 750 0 0 0 {name=xframe}
C {sram512_control.sym} -250 1100 0 0 {name=xcontrol}
C {TR-1um_5_stdcell/BUF_X4.sym} 500 950 0 0 {name=xpreb_drive}
C {TR-1um_5_stdcell/BUF_X4.sym} 500 1210 0 0 {name=xsae_drive}
C {TR-1um_5_stdcell/BUF_X4.sym} 500 1470 0 0 {name=xsdo_drive}
N -90 -240 250 -240 {lab=RX}
N 250 -240 250 30 {lab=RX}
N 250 30 590 30 {lab=RX}
C {devices/lab_wire.sym} 250 -240 0 0 {name=l18 lab=RX}
N -90 980 200 980 {lab=PREB_I}
N 200 980 200 950 {lab=PREB_I}
N 200 950 480 950 {lab=PREB_I}
C {devices/lab_wire.sym} 200 980 0 0 {name=l22 lab=PREB_I}
N -90 1160 200 1160 {lab=SAE_I}
N 200 1160 200 1210 {lab=SAE_I}
N 200 1210 480 1210 {lab=SAE_I}
C {devices/lab_wire.sym} 200 1160 0 0 {name=l26 lab=SAE_I}
N -90 1220 200 1220 {lab=READ_DATA}
N 200 1220 200 1470 {lab=READ_DATA}
N 200 1470 480 1470 {lab=READ_DATA}
C {devices/lab_wire.sym} 200 1220 0 0 {name=l30 lab=READ_DATA}
C {devices/ipin.sym} -1100 300 0 0 {name=pCLK lab=CLK}
N -1100 300 -1040 300 {lab=CLK}
C {devices/lab_pin.sym} -1040 300 0 0 {name=l33 lab=CLK hide_texts=true}
C {devices/ipin.sym} -1100 450 0 0 {name=pRESET lab=RESET}
N -1100 450 -1040 450 {lab=RESET}
C {devices/lab_pin.sym} -1040 450 0 0 {name=l36 lab=RESET hide_texts=true}
C {devices/ipin.sym} -1100 600 0 0 {name=pSDI lab=SDI}
N -1100 600 -1040 600 {lab=SDI}
C {devices/lab_pin.sym} -1040 600 0 0 {name=l39 lab=SDI hide_texts=true}
C {devices/ipin.sym} -1100 750 0 0 {name=pWE lab=WE}
N -1100 750 -1040 750 {lab=WE}
C {devices/lab_pin.sym} -1040 750 0 0 {name=l42 lab=WE hide_texts=true}
C {devices/ipin.sym} -1100 900 0 0 {name=pSOUT lab=SOUT}
N -1100 900 -1040 900 {lab=SOUT}
C {devices/lab_pin.sym} -1040 900 0 0 {name=l45 lab=SOUT hide_texts=true}
C {devices/opin.sym} 1450 -450 0 0 {name=pDIN lab=DIN}
N 1450 -450 1510 -450 {lab=DIN}
C {devices/lab_pin.sym} 1510 -450 0 0 {name=l48 lab=DIN hide_texts=true}
C {devices/opin.sym} 1450 -370 0 0 {name=pDINB lab=DINB}
N 1450 -370 1510 -370 {lab=DINB}
C {devices/lab_pin.sym} 1510 -370 0 0 {name=l51 lab=DINB hide_texts=true}
C {devices/opin.sym} 1450 -290 0 0 {name=pCA0 lab=CA0}
N 1450 -290 1510 -290 {lab=CA0}
C {devices/lab_pin.sym} 1510 -290 0 0 {name=l54 lab=CA0 hide_texts=true}
C {devices/opin.sym} 1450 -210 0 0 {name=pCA0B lab=CA0B}
N 1450 -210 1510 -210 {lab=CA0B}
C {devices/lab_pin.sym} 1510 -210 0 0 {name=l57 lab=CA0B hide_texts=true}
C {devices/opin.sym} 1450 -130 0 0 {name=pCA1 lab=CA1}
N 1450 -130 1510 -130 {lab=CA1}
C {devices/lab_pin.sym} 1510 -130 0 0 {name=l60 lab=CA1 hide_texts=true}
C {devices/opin.sym} 1450 -50 0 0 {name=pCA1B lab=CA1B}
N 1450 -50 1510 -50 {lab=CA1B}
C {devices/lab_pin.sym} 1510 -50 0 0 {name=l63 lab=CA1B hide_texts=true}
C {devices/opin.sym} 1450 30 0 0 {name=pCA2 lab=CA2}
N 1450 30 1510 30 {lab=CA2}
C {devices/lab_pin.sym} 1510 30 0 0 {name=l66 lab=CA2 hide_texts=true}
C {devices/opin.sym} 1450 110 0 0 {name=pCA2B lab=CA2B}
N 1450 110 1510 110 {lab=CA2B}
C {devices/lab_pin.sym} 1510 110 0 0 {name=l69 lab=CA2B hide_texts=true}
C {devices/opin.sym} 1450 190 0 0 {name=pCA3 lab=CA3}
N 1450 190 1510 190 {lab=CA3}
C {devices/lab_pin.sym} 1510 190 0 0 {name=l72 lab=CA3 hide_texts=true}
C {devices/opin.sym} 1450 270 0 0 {name=pCA3B lab=CA3B}
N 1450 270 1510 270 {lab=CA3B}
C {devices/lab_pin.sym} 1510 270 0 0 {name=l75 lab=CA3B hide_texts=true}
C {devices/opin.sym} 1450 350 0 0 {name=pCA4 lab=CA4}
N 1450 350 1510 350 {lab=CA4}
C {devices/lab_pin.sym} 1510 350 0 0 {name=l78 lab=CA4 hide_texts=true}
C {devices/opin.sym} 1450 430 0 0 {name=pCA4B lab=CA4B}
N 1450 430 1510 430 {lab=CA4B}
C {devices/lab_pin.sym} 1510 430 0 0 {name=l81 lab=CA4B hide_texts=true}
C {devices/opin.sym} 1450 510 0 0 {name=pRA0 lab=RA0}
N 1450 510 1510 510 {lab=RA0}
C {devices/lab_pin.sym} 1510 510 0 0 {name=l84 lab=RA0 hide_texts=true}
C {devices/opin.sym} 1450 590 0 0 {name=pRA0B lab=RA0B}
N 1450 590 1510 590 {lab=RA0B}
C {devices/lab_pin.sym} 1510 590 0 0 {name=l87 lab=RA0B hide_texts=true}
C {devices/opin.sym} 1450 670 0 0 {name=pRA1 lab=RA1}
N 1450 670 1510 670 {lab=RA1}
C {devices/lab_pin.sym} 1510 670 0 0 {name=l90 lab=RA1 hide_texts=true}
C {devices/opin.sym} 1450 750 0 0 {name=pRA1B lab=RA1B}
N 1450 750 1510 750 {lab=RA1B}
C {devices/lab_pin.sym} 1510 750 0 0 {name=l93 lab=RA1B hide_texts=true}
C {devices/opin.sym} 1450 830 0 0 {name=pRA2 lab=RA2}
N 1450 830 1510 830 {lab=RA2}
C {devices/lab_pin.sym} 1510 830 0 0 {name=l96 lab=RA2 hide_texts=true}
C {devices/opin.sym} 1450 910 0 0 {name=pRA2B lab=RA2B}
N 1450 910 1510 910 {lab=RA2B}
C {devices/lab_pin.sym} 1510 910 0 0 {name=l99 lab=RA2B hide_texts=true}
C {devices/opin.sym} 1450 990 0 0 {name=pRA3 lab=RA3}
N 1450 990 1510 990 {lab=RA3}
C {devices/lab_pin.sym} 1510 990 0 0 {name=l102 lab=RA3 hide_texts=true}
C {devices/opin.sym} 1450 1070 0 0 {name=pRA3B lab=RA3B}
N 1450 1070 1510 1070 {lab=RA3B}
C {devices/lab_pin.sym} 1510 1070 0 0 {name=l105 lab=RA3B hide_texts=true}
C {devices/opin.sym} 1450 1150 0 0 {name=pPREB lab=PREB}
N 1450 1150 1510 1150 {lab=PREB}
C {devices/lab_pin.sym} 1510 1150 0 0 {name=l108 lab=PREB hide_texts=true}
C {devices/opin.sym} 1450 1230 0 0 {name=pSAE lab=SAE}
N 1450 1230 1510 1230 {lab=SAE}
C {devices/lab_pin.sym} 1510 1230 0 0 {name=l111 lab=SAE hide_texts=true}
C {devices/opin.sym} 1450 1310 0 0 {name=pWL_EN lab=WL_EN}
N 1450 1310 1510 1310 {lab=WL_EN}
C {devices/lab_pin.sym} 1510 1310 0 0 {name=l114 lab=WL_EN hide_texts=true}
C {devices/opin.sym} 1450 1390 0 0 {name=pWRITE_EN lab=WRITE_EN}
N 1450 1390 1510 1390 {lab=WRITE_EN}
C {devices/lab_pin.sym} 1510 1390 0 0 {name=l117 lab=WRITE_EN hide_texts=true}
C {devices/opin.sym} 1450 1470 0 0 {name=pSDO lab=SDO}
N 1450 1470 1510 1470 {lab=SDO}
C {devices/lab_pin.sym} 1510 1470 0 0 {name=l120 lab=SDO hide_texts=true}
C {devices/iopin.sym} -800 -690 0 0 {name=pVDD lab=VDD}
N -800 -690 -740 -690 {lab=VDD}
C {devices/lab_pin.sym} -740 -690 0 0 {name=l123 lab=VDD hide_texts=true}
C {devices/iopin.sym} -500 -690 0 0 {name=pVSS lab=VSS}
N -500 -690 -440 -690 {lab=VSS}
C {devices/lab_pin.sym} -440 -690 0 0 {name=l126 lab=VSS hide_texts=true}
C {devices/lab_pin.sym} -770 -490 0 0 {name=l127 lab=VDD}
C {devices/lab_pin.sym} -820 -450 0 0 {name=l128 lab=CLK}
C {devices/lab_pin.sym} -700 -450 2 0 {name=l129 lab=CKI}
C {devices/lab_pin.sym} -770 -410 0 0 {name=l130 lab=VSS}
C {devices/lab_pin.sym} -770 -260 0 0 {name=l131 lab=VDD}
C {devices/lab_pin.sym} -820 -220 0 0 {name=l132 lab=RESET}
C {devices/lab_pin.sym} -700 -220 2 0 {name=l133 lab=RSTI}
C {devices/lab_pin.sym} -770 -180 0 0 {name=l134 lab=VSS}
C {devices/lab_pin.sym} -410 -30 0 0 {name=l135 lab=CKI}
C {devices/lab_pin.sym} -410 30 0 0 {name=l136 lab=RSTI}
C {devices/lab_pin.sym} -90 -180 2 0 {name=l137 lab=E0}
C {devices/lab_pin.sym} -90 -120 2 0 {name=l138 lab=E1}
C {devices/lab_pin.sym} -90 -60 2 0 {name=l139 lab=E2}
C {devices/lab_pin.sym} -90 0 2 0 {name=l140 lab=E3}
C {devices/lab_pin.sym} -90 60 2 0 {name=l141 lab=E4}
C {devices/lab_pin.sym} -90 120 2 0 {name=l142 lab=E5}
C {devices/lab_pin.sym} -90 180 2 0 {name=l143 lab=E6}
C {devices/lab_pin.sym} -90 240 2 0 {name=l144 lab=E7}
C {devices/noconn.sym} -90 240 0 0 {name=nc145}
C {devices/lab_pin.sym} -250 -340 0 0 {name=l146 lab=VDD}
C {devices/lab_pin.sym} -250 340 0 0 {name=l147 lab=VSS}
C {devices/lab_pin.sym} 590 -90 0 0 {name=l148 lab=CKI}
C {devices/lab_pin.sym} 590 -30 0 0 {name=l149 lab=RSTI}
C {devices/lab_pin.sym} 590 90 0 0 {name=l150 lab=SDI}
C {devices/lab_pin.sym} 910 -570 2 0 {name=l151 lab=DIN}
C {devices/lab_pin.sym} 910 -510 2 0 {name=l152 lab=DINB}
C {devices/lab_pin.sym} 910 -450 2 0 {name=l153 lab=CA0}
C {devices/lab_pin.sym} 910 -390 2 0 {name=l154 lab=CA0B}
C {devices/lab_pin.sym} 910 -330 2 0 {name=l155 lab=CA1}
C {devices/lab_pin.sym} 910 -270 2 0 {name=l156 lab=CA1B}
C {devices/lab_pin.sym} 910 -210 2 0 {name=l157 lab=CA2}
C {devices/lab_pin.sym} 910 -150 2 0 {name=l158 lab=CA2B}
C {devices/lab_pin.sym} 910 -90 2 0 {name=l159 lab=CA3}
C {devices/lab_pin.sym} 910 -30 2 0 {name=l160 lab=CA3B}
C {devices/lab_pin.sym} 910 30 2 0 {name=l161 lab=CA4}
C {devices/lab_pin.sym} 910 90 2 0 {name=l162 lab=CA4B}
C {devices/lab_pin.sym} 910 150 2 0 {name=l163 lab=RA0}
C {devices/lab_pin.sym} 910 210 2 0 {name=l164 lab=RA0B}
C {devices/lab_pin.sym} 910 270 2 0 {name=l165 lab=RA1}
C {devices/lab_pin.sym} 910 330 2 0 {name=l166 lab=RA1B}
C {devices/lab_pin.sym} 910 390 2 0 {name=l167 lab=RA2}
C {devices/lab_pin.sym} 910 450 2 0 {name=l168 lab=RA2B}
C {devices/lab_pin.sym} 910 510 2 0 {name=l169 lab=RA3}
C {devices/lab_pin.sym} 910 570 2 0 {name=l170 lab=RA3B}
C {devices/lab_pin.sym} 750 -670 0 0 {name=l171 lab=VDD}
C {devices/lab_pin.sym} 750 670 0 0 {name=l172 lab=VSS}
C {devices/lab_pin.sym} -410 800 0 0 {name=l173 lab=CKI}
C {devices/lab_pin.sym} -410 860 0 0 {name=l174 lab=RSTI}
C {devices/lab_pin.sym} -410 920 0 0 {name=l175 lab=WE}
C {devices/lab_pin.sym} -410 980 0 0 {name=l176 lab=SOUT}
C {devices/lab_pin.sym} -410 1040 0 0 {name=l177 lab=E0}
C {devices/lab_pin.sym} -410 1100 0 0 {name=l178 lab=E1}
C {devices/lab_pin.sym} -410 1160 0 0 {name=l179 lab=E2}
C {devices/lab_pin.sym} -410 1220 0 0 {name=l180 lab=E3}
C {devices/lab_pin.sym} -410 1280 0 0 {name=l181 lab=E4}
C {devices/lab_pin.sym} -410 1340 0 0 {name=l182 lab=E5}
C {devices/lab_pin.sym} -410 1400 0 0 {name=l183 lab=E6}
C {devices/lab_pin.sym} -90 1040 2 0 {name=l184 lab=WL_EN}
C {devices/lab_pin.sym} -90 1100 2 0 {name=l185 lab=WRITE_EN}
C {devices/lab_pin.sym} -250 700 0 0 {name=l186 lab=VDD}
C {devices/lab_pin.sym} -250 1500 0 0 {name=l187 lab=VSS}
C {devices/lab_pin.sym} 530 910 0 0 {name=l188 lab=VDD}
C {devices/lab_pin.sym} 600 950 2 0 {name=l189 lab=PREB}
C {devices/lab_pin.sym} 530 990 0 0 {name=l190 lab=VSS}
C {devices/lab_pin.sym} 530 1170 0 0 {name=l191 lab=VDD}
C {devices/lab_pin.sym} 600 1210 2 0 {name=l192 lab=SAE}
C {devices/lab_pin.sym} 530 1250 0 0 {name=l193 lab=VSS}
C {devices/lab_pin.sym} 530 1430 0 0 {name=l194 lab=VDD}
C {devices/lab_pin.sym} 600 1470 2 0 {name=l195 lab=SDO}
C {devices/lab_pin.sym} 530 1510 0 0 {name=l196 lab=VSS}
