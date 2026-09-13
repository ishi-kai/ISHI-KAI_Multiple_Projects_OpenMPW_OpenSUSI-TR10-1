v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
E {}
T {4-to-16 ROW DECODER: 2+2 predecode, AND3_X1 per 32-cell wordline} -180 -330 0 0 0.3 0.3 {}
T {WL_EN=0 keeps every WL LOW; row address is fixed before the access window} -180 -260 0 0 0.3 0.3 {}
T {Four address complements are generated inside the row decoder.} -180 2710 0 0 0.3 0.3 {}
T {One continuous WL per row crosses both adjacent 16-column physical blocks.} -180 2780 0 0 0.3 0.3 {}
C {TR-1um_5_stdcell/INV_X1.sym} -150 0 0 0 {name=xaddress_b0}
C {TR-1um_5_stdcell/INV_X1.sym} -150 480 0 0 {name=xaddress_b1}
C {TR-1um_5_stdcell/INV_X1.sym} -150 960 0 0 {name=xaddress_b2}
C {TR-1um_5_stdcell/INV_X1.sym} -150 1440 0 0 {name=xaddress_b3}
C {TR-1um_5_stdcell/AND2_X1.sym} 350 0 0 0 {name=xpre0_0}
C {TR-1um_5_stdcell/AND2_X1.sym} 350 250 0 0 {name=xpre0_1}
C {TR-1um_5_stdcell/AND2_X1.sym} 350 500 0 0 {name=xpre0_2}
C {TR-1um_5_stdcell/AND2_X1.sym} 350 750 0 0 {name=xpre0_3}
C {TR-1um_5_stdcell/AND2_X1.sym} 350 1300 0 0 {name=xpre1_0}
C {TR-1um_5_stdcell/AND2_X1.sym} 350 1550 0 0 {name=xpre1_1}
C {TR-1um_5_stdcell/AND2_X1.sym} 350 1800 0 0 {name=xpre1_2}
C {TR-1um_5_stdcell/AND2_X1.sym} 350 2050 0 0 {name=xpre1_3}
C {TR-1um_5_stdcell/AND3_X1.sym} 1400 0 0 0 {name=xdriver0}
C {TR-1um_5_stdcell/AND3_X1.sym} 1400 300 0 0 {name=xdriver1}
C {TR-1um_5_stdcell/AND3_X1.sym} 1400 600 0 0 {name=xdriver2}
C {TR-1um_5_stdcell/AND3_X1.sym} 1400 900 0 0 {name=xdriver3}
C {TR-1um_5_stdcell/AND3_X1.sym} 1400 1200 0 0 {name=xdriver4}
C {TR-1um_5_stdcell/AND3_X1.sym} 1400 1500 0 0 {name=xdriver5}
C {TR-1um_5_stdcell/AND3_X1.sym} 1400 1800 0 0 {name=xdriver6}
C {TR-1um_5_stdcell/AND3_X1.sym} 1400 2100 0 0 {name=xdriver7}
C {TR-1um_5_stdcell/AND3_X1.sym} 2450 0 0 0 {name=xdriver8}
C {TR-1um_5_stdcell/AND3_X1.sym} 2450 300 0 0 {name=xdriver9}
C {TR-1um_5_stdcell/AND3_X1.sym} 2450 600 0 0 {name=xdriver10}
C {TR-1um_5_stdcell/AND3_X1.sym} 2450 900 0 0 {name=xdriver11}
C {TR-1um_5_stdcell/AND3_X1.sym} 2450 1200 0 0 {name=xdriver12}
C {TR-1um_5_stdcell/AND3_X1.sym} 2450 1500 0 0 {name=xdriver13}
C {TR-1um_5_stdcell/AND3_X1.sym} 2450 1800 0 0 {name=xdriver14}
C {TR-1um_5_stdcell/AND3_X1.sym} 2450 2100 0 0 {name=xdriver15}
C {devices/ipin.sym} -520 10 0 0 {name=pRA0 lab=RA0}
N -520 10 -460 10 {lab=RA0}
C {devices/lab_pin.sym} -460 10 0 0 {name=l40 lab=RA0 hide_texts=true}
C {devices/ipin.sym} -520 100 0 0 {name=pRA1 lab=RA1}
N -520 100 -460 100 {lab=RA1}
C {devices/lab_pin.sym} -460 100 0 0 {name=l43 lab=RA1 hide_texts=true}
C {devices/ipin.sym} -520 190 0 0 {name=pRA2 lab=RA2}
N -520 190 -460 190 {lab=RA2}
C {devices/lab_pin.sym} -460 190 0 0 {name=l46 lab=RA2 hide_texts=true}
C {devices/ipin.sym} -520 280 0 0 {name=pRA3 lab=RA3}
N -520 280 -460 280 {lab=RA3}
C {devices/lab_pin.sym} -460 280 0 0 {name=l49 lab=RA3 hide_texts=true}
C {devices/ipin.sym} -520 370 0 0 {name=pWL_EN lab=WL_EN}
N -520 370 -460 370 {lab=WL_EN}
C {devices/lab_pin.sym} -460 370 0 0 {name=l52 lab=WL_EN hide_texts=true}
N 1510 0 1710 0 {lab=WL0}
C {devices/opin.sym} 1710 0 0 0 {name=pWL0 lab=WL0}
N 1510 300 1710 300 {lab=WL1}
C {devices/opin.sym} 1710 300 0 0 {name=pWL1 lab=WL1}
N 1510 600 1710 600 {lab=WL2}
C {devices/opin.sym} 1710 600 0 0 {name=pWL2 lab=WL2}
N 1510 900 1710 900 {lab=WL3}
C {devices/opin.sym} 1710 900 0 0 {name=pWL3 lab=WL3}
N 1510 1200 1710 1200 {lab=WL4}
C {devices/opin.sym} 1710 1200 0 0 {name=pWL4 lab=WL4}
N 1510 1500 1710 1500 {lab=WL5}
C {devices/opin.sym} 1710 1500 0 0 {name=pWL5 lab=WL5}
N 1510 1800 1710 1800 {lab=WL6}
C {devices/opin.sym} 1710 1800 0 0 {name=pWL6 lab=WL6}
N 1510 2100 1710 2100 {lab=WL7}
C {devices/opin.sym} 1710 2100 0 0 {name=pWL7 lab=WL7}
N 2560 0 2760 0 {lab=WL8}
C {devices/opin.sym} 2760 0 0 0 {name=pWL8 lab=WL8}
N 2560 300 2760 300 {lab=WL9}
C {devices/opin.sym} 2760 300 0 0 {name=pWL9 lab=WL9}
N 2560 600 2760 600 {lab=WL10}
C {devices/opin.sym} 2760 600 0 0 {name=pWL10 lab=WL10}
N 2560 900 2760 900 {lab=WL11}
C {devices/opin.sym} 2760 900 0 0 {name=pWL11 lab=WL11}
N 2560 1200 2760 1200 {lab=WL12}
C {devices/opin.sym} 2760 1200 0 0 {name=pWL12 lab=WL12}
N 2560 1500 2760 1500 {lab=WL13}
C {devices/opin.sym} 2760 1500 0 0 {name=pWL13 lab=WL13}
N 2560 1800 2760 1800 {lab=WL14}
C {devices/opin.sym} 2760 1800 0 0 {name=pWL14 lab=WL14}
N 2560 2100 2760 2100 {lab=WL15}
C {devices/opin.sym} 2760 2100 0 0 {name=pWL15 lab=WL15}
C {devices/iopin.sym} -520 -200 0 0 {name=pVDD lab=VDD}
N -520 -200 -460 -200 {lab=VDD}
C {devices/lab_pin.sym} -460 -200 0 0 {name=l87 lab=VDD hide_texts=true}
C {devices/iopin.sym} -520 -130 0 0 {name=pVSS lab=VSS}
N -520 -130 -460 -130 {lab=VSS}
C {devices/lab_pin.sym} -460 -130 0 0 {name=l90 lab=VSS hide_texts=true}
C {devices/lab_pin.sym} -120 -40 0 0 {name=l91 lab=VDD}
C {devices/lab_pin.sym} -170 0 0 0 {name=l92 lab=RA0}
C {devices/lab_pin.sym} -50 0 2 0 {name=l93 lab=RA0B}
C {devices/lab_pin.sym} -120 40 0 0 {name=l94 lab=VSS}
C {devices/lab_pin.sym} -120 440 0 0 {name=l95 lab=VDD}
C {devices/lab_pin.sym} -170 480 0 0 {name=l96 lab=RA1}
C {devices/lab_pin.sym} -50 480 2 0 {name=l97 lab=RA1B}
C {devices/lab_pin.sym} -120 520 0 0 {name=l98 lab=VSS}
C {devices/lab_pin.sym} -120 920 0 0 {name=l99 lab=VDD}
C {devices/lab_pin.sym} -170 960 0 0 {name=l100 lab=RA2}
C {devices/lab_pin.sym} -50 960 2 0 {name=l101 lab=RA2B}
C {devices/lab_pin.sym} -120 1000 0 0 {name=l102 lab=VSS}
C {devices/lab_pin.sym} -120 1400 0 0 {name=l103 lab=VDD}
C {devices/lab_pin.sym} -170 1440 0 0 {name=l104 lab=RA3}
C {devices/lab_pin.sym} -50 1440 2 0 {name=l105 lab=RA3B}
C {devices/lab_pin.sym} -120 1480 0 0 {name=l106 lab=VSS}
C {devices/lab_pin.sym} 380 -60 0 0 {name=l107 lab=VDD}
C {devices/lab_pin.sym} 460 0 2 0 {name=l108 lab=R0_0}
C {devices/lab_pin.sym} 330 -20 0 0 {name=l109 lab=RA0B}
C {devices/lab_pin.sym} 330 20 0 0 {name=l110 lab=RA1B}
C {devices/lab_pin.sym} 380 60 0 0 {name=l111 lab=VSS}
C {devices/lab_pin.sym} 380 190 0 0 {name=l112 lab=VDD}
C {devices/lab_pin.sym} 460 250 2 0 {name=l113 lab=R0_1}
C {devices/lab_pin.sym} 330 230 0 0 {name=l114 lab=RA0}
C {devices/lab_pin.sym} 330 270 0 0 {name=l115 lab=RA1B}
C {devices/lab_pin.sym} 380 310 0 0 {name=l116 lab=VSS}
C {devices/lab_pin.sym} 380 440 0 0 {name=l117 lab=VDD}
C {devices/lab_pin.sym} 460 500 2 0 {name=l118 lab=R0_2}
C {devices/lab_pin.sym} 330 480 0 0 {name=l119 lab=RA0B}
C {devices/lab_pin.sym} 330 520 0 0 {name=l120 lab=RA1}
C {devices/lab_pin.sym} 380 560 0 0 {name=l121 lab=VSS}
C {devices/lab_pin.sym} 380 690 0 0 {name=l122 lab=VDD}
C {devices/lab_pin.sym} 460 750 2 0 {name=l123 lab=R0_3}
C {devices/lab_pin.sym} 330 730 0 0 {name=l124 lab=RA0}
C {devices/lab_pin.sym} 330 770 0 0 {name=l125 lab=RA1}
C {devices/lab_pin.sym} 380 810 0 0 {name=l126 lab=VSS}
C {devices/lab_pin.sym} 380 1240 0 0 {name=l127 lab=VDD}
C {devices/lab_pin.sym} 460 1300 2 0 {name=l128 lab=R1_0}
C {devices/lab_pin.sym} 330 1280 0 0 {name=l129 lab=RA2B}
C {devices/lab_pin.sym} 330 1320 0 0 {name=l130 lab=RA3B}
C {devices/lab_pin.sym} 380 1360 0 0 {name=l131 lab=VSS}
C {devices/lab_pin.sym} 380 1490 0 0 {name=l132 lab=VDD}
C {devices/lab_pin.sym} 460 1550 2 0 {name=l133 lab=R1_1}
C {devices/lab_pin.sym} 330 1530 0 0 {name=l134 lab=RA2}
C {devices/lab_pin.sym} 330 1570 0 0 {name=l135 lab=RA3B}
C {devices/lab_pin.sym} 380 1610 0 0 {name=l136 lab=VSS}
C {devices/lab_pin.sym} 380 1740 0 0 {name=l137 lab=VDD}
C {devices/lab_pin.sym} 460 1800 2 0 {name=l138 lab=R1_2}
C {devices/lab_pin.sym} 330 1780 0 0 {name=l139 lab=RA2B}
C {devices/lab_pin.sym} 330 1820 0 0 {name=l140 lab=RA3}
C {devices/lab_pin.sym} 380 1860 0 0 {name=l141 lab=VSS}
C {devices/lab_pin.sym} 380 1990 0 0 {name=l142 lab=VDD}
C {devices/lab_pin.sym} 460 2050 2 0 {name=l143 lab=R1_3}
C {devices/lab_pin.sym} 330 2030 0 0 {name=l144 lab=RA2}
C {devices/lab_pin.sym} 330 2070 0 0 {name=l145 lab=RA3}
C {devices/lab_pin.sym} 380 2110 0 0 {name=l146 lab=VSS}
C {devices/lab_pin.sym} 1380 20 0 0 {name=l147 lab=WL_EN}
C {devices/lab_pin.sym} 1430 -60 0 0 {name=l148 lab=VDD}
C {devices/lab_pin.sym} 1380 -20 0 0 {name=l149 lab=R0_0}
C {devices/lab_pin.sym} 1380 0 0 0 {name=l150 lab=R1_0}
C {devices/lab_pin.sym} 1430 60 0 0 {name=l151 lab=VSS}
C {devices/lab_pin.sym} 1380 320 0 0 {name=l152 lab=WL_EN}
C {devices/lab_pin.sym} 1430 240 0 0 {name=l153 lab=VDD}
C {devices/lab_pin.sym} 1380 280 0 0 {name=l154 lab=R0_1}
C {devices/lab_pin.sym} 1380 300 0 0 {name=l155 lab=R1_0}
C {devices/lab_pin.sym} 1430 360 0 0 {name=l156 lab=VSS}
C {devices/lab_pin.sym} 1380 620 0 0 {name=l157 lab=WL_EN}
C {devices/lab_pin.sym} 1430 540 0 0 {name=l158 lab=VDD}
C {devices/lab_pin.sym} 1380 580 0 0 {name=l159 lab=R0_2}
C {devices/lab_pin.sym} 1380 600 0 0 {name=l160 lab=R1_0}
C {devices/lab_pin.sym} 1430 660 0 0 {name=l161 lab=VSS}
C {devices/lab_pin.sym} 1380 920 0 0 {name=l162 lab=WL_EN}
C {devices/lab_pin.sym} 1430 840 0 0 {name=l163 lab=VDD}
C {devices/lab_pin.sym} 1380 880 0 0 {name=l164 lab=R0_3}
C {devices/lab_pin.sym} 1380 900 0 0 {name=l165 lab=R1_0}
C {devices/lab_pin.sym} 1430 960 0 0 {name=l166 lab=VSS}
C {devices/lab_pin.sym} 1380 1220 0 0 {name=l167 lab=WL_EN}
C {devices/lab_pin.sym} 1430 1140 0 0 {name=l168 lab=VDD}
C {devices/lab_pin.sym} 1380 1180 0 0 {name=l169 lab=R0_0}
C {devices/lab_pin.sym} 1380 1200 0 0 {name=l170 lab=R1_1}
C {devices/lab_pin.sym} 1430 1260 0 0 {name=l171 lab=VSS}
C {devices/lab_pin.sym} 1380 1520 0 0 {name=l172 lab=WL_EN}
C {devices/lab_pin.sym} 1430 1440 0 0 {name=l173 lab=VDD}
C {devices/lab_pin.sym} 1380 1480 0 0 {name=l174 lab=R0_1}
C {devices/lab_pin.sym} 1380 1500 0 0 {name=l175 lab=R1_1}
C {devices/lab_pin.sym} 1430 1560 0 0 {name=l176 lab=VSS}
C {devices/lab_pin.sym} 1380 1820 0 0 {name=l177 lab=WL_EN}
C {devices/lab_pin.sym} 1430 1740 0 0 {name=l178 lab=VDD}
C {devices/lab_pin.sym} 1380 1780 0 0 {name=l179 lab=R0_2}
C {devices/lab_pin.sym} 1380 1800 0 0 {name=l180 lab=R1_1}
C {devices/lab_pin.sym} 1430 1860 0 0 {name=l181 lab=VSS}
C {devices/lab_pin.sym} 1380 2120 0 0 {name=l182 lab=WL_EN}
C {devices/lab_pin.sym} 1430 2040 0 0 {name=l183 lab=VDD}
C {devices/lab_pin.sym} 1380 2080 0 0 {name=l184 lab=R0_3}
C {devices/lab_pin.sym} 1380 2100 0 0 {name=l185 lab=R1_1}
C {devices/lab_pin.sym} 1430 2160 0 0 {name=l186 lab=VSS}
C {devices/lab_pin.sym} 2430 20 0 0 {name=l187 lab=WL_EN}
C {devices/lab_pin.sym} 2480 -60 0 0 {name=l188 lab=VDD}
C {devices/lab_pin.sym} 2430 -20 0 0 {name=l189 lab=R0_0}
C {devices/lab_pin.sym} 2430 0 0 0 {name=l190 lab=R1_2}
C {devices/lab_pin.sym} 2480 60 0 0 {name=l191 lab=VSS}
C {devices/lab_pin.sym} 2430 320 0 0 {name=l192 lab=WL_EN}
C {devices/lab_pin.sym} 2480 240 0 0 {name=l193 lab=VDD}
C {devices/lab_pin.sym} 2430 280 0 0 {name=l194 lab=R0_1}
C {devices/lab_pin.sym} 2430 300 0 0 {name=l195 lab=R1_2}
C {devices/lab_pin.sym} 2480 360 0 0 {name=l196 lab=VSS}
C {devices/lab_pin.sym} 2430 620 0 0 {name=l197 lab=WL_EN}
C {devices/lab_pin.sym} 2480 540 0 0 {name=l198 lab=VDD}
C {devices/lab_pin.sym} 2430 580 0 0 {name=l199 lab=R0_2}
C {devices/lab_pin.sym} 2430 600 0 0 {name=l200 lab=R1_2}
C {devices/lab_pin.sym} 2480 660 0 0 {name=l201 lab=VSS}
C {devices/lab_pin.sym} 2430 920 0 0 {name=l202 lab=WL_EN}
C {devices/lab_pin.sym} 2480 840 0 0 {name=l203 lab=VDD}
C {devices/lab_pin.sym} 2430 880 0 0 {name=l204 lab=R0_3}
C {devices/lab_pin.sym} 2430 900 0 0 {name=l205 lab=R1_2}
C {devices/lab_pin.sym} 2480 960 0 0 {name=l206 lab=VSS}
C {devices/lab_pin.sym} 2430 1220 0 0 {name=l207 lab=WL_EN}
C {devices/lab_pin.sym} 2480 1140 0 0 {name=l208 lab=VDD}
C {devices/lab_pin.sym} 2430 1180 0 0 {name=l209 lab=R0_0}
C {devices/lab_pin.sym} 2430 1200 0 0 {name=l210 lab=R1_3}
C {devices/lab_pin.sym} 2480 1260 0 0 {name=l211 lab=VSS}
C {devices/lab_pin.sym} 2430 1520 0 0 {name=l212 lab=WL_EN}
C {devices/lab_pin.sym} 2480 1440 0 0 {name=l213 lab=VDD}
C {devices/lab_pin.sym} 2430 1480 0 0 {name=l214 lab=R0_1}
C {devices/lab_pin.sym} 2430 1500 0 0 {name=l215 lab=R1_3}
C {devices/lab_pin.sym} 2480 1560 0 0 {name=l216 lab=VSS}
C {devices/lab_pin.sym} 2430 1820 0 0 {name=l217 lab=WL_EN}
C {devices/lab_pin.sym} 2480 1740 0 0 {name=l218 lab=VDD}
C {devices/lab_pin.sym} 2430 1780 0 0 {name=l219 lab=R0_2}
C {devices/lab_pin.sym} 2430 1800 0 0 {name=l220 lab=R1_3}
C {devices/lab_pin.sym} 2480 1860 0 0 {name=l221 lab=VSS}
C {devices/lab_pin.sym} 2430 2120 0 0 {name=l222 lab=WL_EN}
C {devices/lab_pin.sym} 2480 2040 0 0 {name=l223 lab=VDD}
C {devices/lab_pin.sym} 2430 2080 0 0 {name=l224 lab=R0_3}
C {devices/lab_pin.sym} 2430 2100 0 0 {name=l225 lab=R1_3}
C {devices/lab_pin.sym} 2480 2160 0 0 {name=l226 lab=VSS}
