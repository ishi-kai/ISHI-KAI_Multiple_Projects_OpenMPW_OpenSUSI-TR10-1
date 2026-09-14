v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
E {}
T {5-to-32 COLUMN DECODER: 2+3 predecode; one column selected at a stable address} -180 -330 0 0 0.3 0.3 {}
T {No COL_EN. Address shifts only while WL / write are OFF; E0 restores precharge.} -180 -260 0 0 0.3 0.3 {}
C {TR-1um_5_stdcell/AND2_X1.sym} 350 0 0 0 {name=xlow0}
C {TR-1um_5_stdcell/AND2_X1.sym} 350 260 0 0 {name=xlow1}
C {TR-1um_5_stdcell/AND2_X1.sym} 350 520 0 0 {name=xlow2}
C {TR-1um_5_stdcell/AND2_X1.sym} 350 780 0 0 {name=xlow3}
C {TR-1um_5_stdcell/AND3_X1.sym} 350 1200 0 0 {name=xhigh0}
C {TR-1um_5_stdcell/AND3_X1.sym} 350 1460 0 0 {name=xhigh1}
C {TR-1um_5_stdcell/AND3_X1.sym} 350 1720 0 0 {name=xhigh2}
C {TR-1um_5_stdcell/AND3_X1.sym} 350 1980 0 0 {name=xhigh3}
C {TR-1um_5_stdcell/AND3_X1.sym} 350 2240 0 0 {name=xhigh4}
C {TR-1um_5_stdcell/AND3_X1.sym} 350 2500 0 0 {name=xhigh5}
C {TR-1um_5_stdcell/AND3_X1.sym} 350 2760 0 0 {name=xhigh6}
C {TR-1um_5_stdcell/AND3_X1.sym} 350 3020 0 0 {name=xhigh7}
C {TR-1um_5_stdcell/AND2_X1.sym} 1450 0 0 0 {name=xselect0}
C {TR-1um_5_stdcell/AND2_X1.sym} 1450 380 0 0 {name=xselect1}
C {TR-1um_5_stdcell/AND2_X1.sym} 1450 760 0 0 {name=xselect2}
C {TR-1um_5_stdcell/AND2_X1.sym} 1450 1140 0 0 {name=xselect3}
C {TR-1um_5_stdcell/AND2_X1.sym} 1450 1520 0 0 {name=xselect4}
C {TR-1um_5_stdcell/AND2_X1.sym} 1450 1900 0 0 {name=xselect5}
C {TR-1um_5_stdcell/AND2_X1.sym} 1450 2280 0 0 {name=xselect6}
C {TR-1um_5_stdcell/AND2_X1.sym} 1450 2660 0 0 {name=xselect7}
C {TR-1um_5_stdcell/AND2_X1.sym} 2100 0 0 0 {name=xselect8}
C {TR-1um_5_stdcell/AND2_X1.sym} 2100 380 0 0 {name=xselect9}
C {TR-1um_5_stdcell/AND2_X1.sym} 2100 760 0 0 {name=xselect10}
C {TR-1um_5_stdcell/AND2_X1.sym} 2100 1140 0 0 {name=xselect11}
C {TR-1um_5_stdcell/AND2_X1.sym} 2100 1520 0 0 {name=xselect12}
C {TR-1um_5_stdcell/AND2_X1.sym} 2100 1900 0 0 {name=xselect13}
C {TR-1um_5_stdcell/AND2_X1.sym} 2100 2280 0 0 {name=xselect14}
C {TR-1um_5_stdcell/AND2_X1.sym} 2100 2660 0 0 {name=xselect15}
C {TR-1um_5_stdcell/AND2_X1.sym} 2750 0 0 0 {name=xselect16}
C {TR-1um_5_stdcell/AND2_X1.sym} 2750 380 0 0 {name=xselect17}
C {TR-1um_5_stdcell/AND2_X1.sym} 2750 760 0 0 {name=xselect18}
C {TR-1um_5_stdcell/AND2_X1.sym} 2750 1140 0 0 {name=xselect19}
C {TR-1um_5_stdcell/AND2_X1.sym} 2750 1520 0 0 {name=xselect20}
C {TR-1um_5_stdcell/AND2_X1.sym} 2750 1900 0 0 {name=xselect21}
C {TR-1um_5_stdcell/AND2_X1.sym} 2750 2280 0 0 {name=xselect22}
C {TR-1um_5_stdcell/AND2_X1.sym} 2750 2660 0 0 {name=xselect23}
C {TR-1um_5_stdcell/AND2_X1.sym} 3400 0 0 0 {name=xselect24}
C {TR-1um_5_stdcell/AND2_X1.sym} 3400 380 0 0 {name=xselect25}
C {TR-1um_5_stdcell/AND2_X1.sym} 3400 760 0 0 {name=xselect26}
C {TR-1um_5_stdcell/AND2_X1.sym} 3400 1140 0 0 {name=xselect27}
C {TR-1um_5_stdcell/AND2_X1.sym} 3400 1520 0 0 {name=xselect28}
C {TR-1um_5_stdcell/AND2_X1.sym} 3400 1900 0 0 {name=xselect29}
C {TR-1um_5_stdcell/AND2_X1.sym} 3400 2280 0 0 {name=xselect30}
C {TR-1um_5_stdcell/AND2_X1.sym} 3400 2660 0 0 {name=xselect31}
C {devices/ipin.sym} -520 10 0 0 {name=pCA0 lab=CA0}
N -520 10 -460 10 {lab=CA0}
C {devices/lab_pin.sym} -460 10 0 0 {name=l54 lab=CA0 hide_texts=true}
C {devices/ipin.sym} -520 100 0 0 {name=pCA0B lab=CA0B}
N -520 100 -460 100 {lab=CA0B}
C {devices/lab_pin.sym} -460 100 0 0 {name=l57 lab=CA0B hide_texts=true}
C {devices/ipin.sym} -520 190 0 0 {name=pCA1 lab=CA1}
N -520 190 -460 190 {lab=CA1}
C {devices/lab_pin.sym} -460 190 0 0 {name=l60 lab=CA1 hide_texts=true}
C {devices/ipin.sym} -520 280 0 0 {name=pCA1B lab=CA1B}
N -520 280 -460 280 {lab=CA1B}
C {devices/lab_pin.sym} -460 280 0 0 {name=l63 lab=CA1B hide_texts=true}
C {devices/ipin.sym} -520 370 0 0 {name=pCA2 lab=CA2}
N -520 370 -460 370 {lab=CA2}
C {devices/lab_pin.sym} -460 370 0 0 {name=l66 lab=CA2 hide_texts=true}
C {devices/ipin.sym} -520 460 0 0 {name=pCA2B lab=CA2B}
N -520 460 -460 460 {lab=CA2B}
C {devices/lab_pin.sym} -460 460 0 0 {name=l69 lab=CA2B hide_texts=true}
C {devices/ipin.sym} -520 550 0 0 {name=pCA3 lab=CA3}
N -520 550 -460 550 {lab=CA3}
C {devices/lab_pin.sym} -460 550 0 0 {name=l72 lab=CA3 hide_texts=true}
C {devices/ipin.sym} -520 640 0 0 {name=pCA3B lab=CA3B}
N -520 640 -460 640 {lab=CA3B}
C {devices/lab_pin.sym} -460 640 0 0 {name=l75 lab=CA3B hide_texts=true}
C {devices/ipin.sym} -520 730 0 0 {name=pCA4 lab=CA4}
N -520 730 -460 730 {lab=CA4}
C {devices/lab_pin.sym} -460 730 0 0 {name=l78 lab=CA4 hide_texts=true}
C {devices/ipin.sym} -520 820 0 0 {name=pCA4B lab=CA4B}
N -520 820 -460 820 {lab=CA4B}
C {devices/lab_pin.sym} -460 820 0 0 {name=l81 lab=CA4B hide_texts=true}
N 1560 0 1760 0 {lab=COL0}
C {devices/opin.sym} 1760 0 0 0 {name=pCOL0 lab=COL0}
N 1560 380 1760 380 {lab=COL1}
C {devices/opin.sym} 1760 380 0 0 {name=pCOL1 lab=COL1}
N 1560 760 1760 760 {lab=COL2}
C {devices/opin.sym} 1760 760 0 0 {name=pCOL2 lab=COL2}
N 1560 1140 1760 1140 {lab=COL3}
C {devices/opin.sym} 1760 1140 0 0 {name=pCOL3 lab=COL3}
N 1560 1520 1760 1520 {lab=COL4}
C {devices/opin.sym} 1760 1520 0 0 {name=pCOL4 lab=COL4}
N 1560 1900 1760 1900 {lab=COL5}
C {devices/opin.sym} 1760 1900 0 0 {name=pCOL5 lab=COL5}
N 1560 2280 1760 2280 {lab=COL6}
C {devices/opin.sym} 1760 2280 0 0 {name=pCOL6 lab=COL6}
N 1560 2660 1760 2660 {lab=COL7}
C {devices/opin.sym} 1760 2660 0 0 {name=pCOL7 lab=COL7}
N 2210 0 2410 0 {lab=COL8}
C {devices/opin.sym} 2410 0 0 0 {name=pCOL8 lab=COL8}
N 2210 380 2410 380 {lab=COL9}
C {devices/opin.sym} 2410 380 0 0 {name=pCOL9 lab=COL9}
N 2210 760 2410 760 {lab=COL10}
C {devices/opin.sym} 2410 760 0 0 {name=pCOL10 lab=COL10}
N 2210 1140 2410 1140 {lab=COL11}
C {devices/opin.sym} 2410 1140 0 0 {name=pCOL11 lab=COL11}
N 2210 1520 2410 1520 {lab=COL12}
C {devices/opin.sym} 2410 1520 0 0 {name=pCOL12 lab=COL12}
N 2210 1900 2410 1900 {lab=COL13}
C {devices/opin.sym} 2410 1900 0 0 {name=pCOL13 lab=COL13}
N 2210 2280 2410 2280 {lab=COL14}
C {devices/opin.sym} 2410 2280 0 0 {name=pCOL14 lab=COL14}
N 2210 2660 2410 2660 {lab=COL15}
C {devices/opin.sym} 2410 2660 0 0 {name=pCOL15 lab=COL15}
N 2860 0 3060 0 {lab=COL16}
C {devices/opin.sym} 3060 0 0 0 {name=pCOL16 lab=COL16}
N 2860 380 3060 380 {lab=COL17}
C {devices/opin.sym} 3060 380 0 0 {name=pCOL17 lab=COL17}
N 2860 760 3060 760 {lab=COL18}
C {devices/opin.sym} 3060 760 0 0 {name=pCOL18 lab=COL18}
N 2860 1140 3060 1140 {lab=COL19}
C {devices/opin.sym} 3060 1140 0 0 {name=pCOL19 lab=COL19}
N 2860 1520 3060 1520 {lab=COL20}
C {devices/opin.sym} 3060 1520 0 0 {name=pCOL20 lab=COL20}
N 2860 1900 3060 1900 {lab=COL21}
C {devices/opin.sym} 3060 1900 0 0 {name=pCOL21 lab=COL21}
N 2860 2280 3060 2280 {lab=COL22}
C {devices/opin.sym} 3060 2280 0 0 {name=pCOL22 lab=COL22}
N 2860 2660 3060 2660 {lab=COL23}
C {devices/opin.sym} 3060 2660 0 0 {name=pCOL23 lab=COL23}
N 3510 0 3710 0 {lab=COL24}
C {devices/opin.sym} 3710 0 0 0 {name=pCOL24 lab=COL24}
N 3510 380 3710 380 {lab=COL25}
C {devices/opin.sym} 3710 380 0 0 {name=pCOL25 lab=COL25}
N 3510 760 3710 760 {lab=COL26}
C {devices/opin.sym} 3710 760 0 0 {name=pCOL26 lab=COL26}
N 3510 1140 3710 1140 {lab=COL27}
C {devices/opin.sym} 3710 1140 0 0 {name=pCOL27 lab=COL27}
N 3510 1520 3710 1520 {lab=COL28}
C {devices/opin.sym} 3710 1520 0 0 {name=pCOL28 lab=COL28}
N 3510 1900 3710 1900 {lab=COL29}
C {devices/opin.sym} 3710 1900 0 0 {name=pCOL29 lab=COL29}
N 3510 2280 3710 2280 {lab=COL30}
C {devices/opin.sym} 3710 2280 0 0 {name=pCOL30 lab=COL30}
N 3510 2660 3710 2660 {lab=COL31}
C {devices/opin.sym} 3710 2660 0 0 {name=pCOL31 lab=COL31}
C {devices/iopin.sym} -520 -200 0 0 {name=pVDD lab=VDD}
N -520 -200 -460 -200 {lab=VDD}
C {devices/lab_pin.sym} -460 -200 0 0 {name=l148 lab=VDD hide_texts=true}
C {devices/iopin.sym} -520 -130 0 0 {name=pVSS lab=VSS}
N -520 -130 -460 -130 {lab=VSS}
C {devices/lab_pin.sym} -460 -130 0 0 {name=l151 lab=VSS hide_texts=true}
C {devices/lab_pin.sym} 380 -60 0 0 {name=l152 lab=VDD}
C {devices/lab_pin.sym} 460 0 2 0 {name=l153 lab=CL0}
C {devices/lab_pin.sym} 330 -20 0 0 {name=l154 lab=CA0B}
C {devices/lab_pin.sym} 330 20 0 0 {name=l155 lab=CA1B}
C {devices/lab_pin.sym} 380 60 0 0 {name=l156 lab=VSS}
C {devices/lab_pin.sym} 380 200 0 0 {name=l157 lab=VDD}
C {devices/lab_pin.sym} 460 260 2 0 {name=l158 lab=CL1}
C {devices/lab_pin.sym} 330 240 0 0 {name=l159 lab=CA0}
C {devices/lab_pin.sym} 330 280 0 0 {name=l160 lab=CA1B}
C {devices/lab_pin.sym} 380 320 0 0 {name=l161 lab=VSS}
C {devices/lab_pin.sym} 380 460 0 0 {name=l162 lab=VDD}
C {devices/lab_pin.sym} 460 520 2 0 {name=l163 lab=CL2}
C {devices/lab_pin.sym} 330 500 0 0 {name=l164 lab=CA0B}
C {devices/lab_pin.sym} 330 540 0 0 {name=l165 lab=CA1}
C {devices/lab_pin.sym} 380 580 0 0 {name=l166 lab=VSS}
C {devices/lab_pin.sym} 380 720 0 0 {name=l167 lab=VDD}
C {devices/lab_pin.sym} 460 780 2 0 {name=l168 lab=CL3}
C {devices/lab_pin.sym} 330 760 0 0 {name=l169 lab=CA0}
C {devices/lab_pin.sym} 330 800 0 0 {name=l170 lab=CA1}
C {devices/lab_pin.sym} 380 840 0 0 {name=l171 lab=VSS}
C {devices/lab_pin.sym} 330 1220 0 0 {name=l172 lab=CA4B}
C {devices/lab_pin.sym} 380 1140 0 0 {name=l173 lab=VDD}
C {devices/lab_pin.sym} 460 1200 2 0 {name=l174 lab=CH0}
C {devices/lab_pin.sym} 330 1180 0 0 {name=l175 lab=CA2B}
C {devices/lab_pin.sym} 330 1200 0 0 {name=l176 lab=CA3B}
C {devices/lab_pin.sym} 380 1260 0 0 {name=l177 lab=VSS}
C {devices/lab_pin.sym} 330 1480 0 0 {name=l178 lab=CA4B}
C {devices/lab_pin.sym} 380 1400 0 0 {name=l179 lab=VDD}
C {devices/lab_pin.sym} 460 1460 2 0 {name=l180 lab=CH1}
C {devices/lab_pin.sym} 330 1440 0 0 {name=l181 lab=CA2}
C {devices/lab_pin.sym} 330 1460 0 0 {name=l182 lab=CA3B}
C {devices/lab_pin.sym} 380 1520 0 0 {name=l183 lab=VSS}
C {devices/lab_pin.sym} 330 1740 0 0 {name=l184 lab=CA4B}
C {devices/lab_pin.sym} 380 1660 0 0 {name=l185 lab=VDD}
C {devices/lab_pin.sym} 460 1720 2 0 {name=l186 lab=CH2}
C {devices/lab_pin.sym} 330 1700 0 0 {name=l187 lab=CA2B}
C {devices/lab_pin.sym} 330 1720 0 0 {name=l188 lab=CA3}
C {devices/lab_pin.sym} 380 1780 0 0 {name=l189 lab=VSS}
C {devices/lab_pin.sym} 330 2000 0 0 {name=l190 lab=CA4B}
C {devices/lab_pin.sym} 380 1920 0 0 {name=l191 lab=VDD}
C {devices/lab_pin.sym} 460 1980 2 0 {name=l192 lab=CH3}
C {devices/lab_pin.sym} 330 1960 0 0 {name=l193 lab=CA2}
C {devices/lab_pin.sym} 330 1980 0 0 {name=l194 lab=CA3}
C {devices/lab_pin.sym} 380 2040 0 0 {name=l195 lab=VSS}
C {devices/lab_pin.sym} 330 2260 0 0 {name=l196 lab=CA4}
C {devices/lab_pin.sym} 380 2180 0 0 {name=l197 lab=VDD}
C {devices/lab_pin.sym} 460 2240 2 0 {name=l198 lab=CH4}
C {devices/lab_pin.sym} 330 2220 0 0 {name=l199 lab=CA2B}
C {devices/lab_pin.sym} 330 2240 0 0 {name=l200 lab=CA3B}
C {devices/lab_pin.sym} 380 2300 0 0 {name=l201 lab=VSS}
C {devices/lab_pin.sym} 330 2520 0 0 {name=l202 lab=CA4}
C {devices/lab_pin.sym} 380 2440 0 0 {name=l203 lab=VDD}
C {devices/lab_pin.sym} 460 2500 2 0 {name=l204 lab=CH5}
C {devices/lab_pin.sym} 330 2480 0 0 {name=l205 lab=CA2}
C {devices/lab_pin.sym} 330 2500 0 0 {name=l206 lab=CA3B}
C {devices/lab_pin.sym} 380 2560 0 0 {name=l207 lab=VSS}
C {devices/lab_pin.sym} 330 2780 0 0 {name=l208 lab=CA4}
C {devices/lab_pin.sym} 380 2700 0 0 {name=l209 lab=VDD}
C {devices/lab_pin.sym} 460 2760 2 0 {name=l210 lab=CH6}
C {devices/lab_pin.sym} 330 2740 0 0 {name=l211 lab=CA2B}
C {devices/lab_pin.sym} 330 2760 0 0 {name=l212 lab=CA3}
C {devices/lab_pin.sym} 380 2820 0 0 {name=l213 lab=VSS}
C {devices/lab_pin.sym} 330 3040 0 0 {name=l214 lab=CA4}
C {devices/lab_pin.sym} 380 2960 0 0 {name=l215 lab=VDD}
C {devices/lab_pin.sym} 460 3020 2 0 {name=l216 lab=CH7}
C {devices/lab_pin.sym} 330 3000 0 0 {name=l217 lab=CA2}
C {devices/lab_pin.sym} 330 3020 0 0 {name=l218 lab=CA3}
C {devices/lab_pin.sym} 380 3080 0 0 {name=l219 lab=VSS}
C {devices/lab_pin.sym} 1480 -60 0 0 {name=l220 lab=VDD}
C {devices/lab_pin.sym} 1430 -20 0 0 {name=l221 lab=CL0}
C {devices/lab_pin.sym} 1430 20 0 0 {name=l222 lab=CH0}
C {devices/lab_pin.sym} 1480 60 0 0 {name=l223 lab=VSS}
C {devices/lab_pin.sym} 1480 320 0 0 {name=l224 lab=VDD}
C {devices/lab_pin.sym} 1430 360 0 0 {name=l225 lab=CL1}
C {devices/lab_pin.sym} 1430 400 0 0 {name=l226 lab=CH0}
C {devices/lab_pin.sym} 1480 440 0 0 {name=l227 lab=VSS}
C {devices/lab_pin.sym} 1480 700 0 0 {name=l228 lab=VDD}
C {devices/lab_pin.sym} 1430 740 0 0 {name=l229 lab=CL2}
C {devices/lab_pin.sym} 1430 780 0 0 {name=l230 lab=CH0}
C {devices/lab_pin.sym} 1480 820 0 0 {name=l231 lab=VSS}
C {devices/lab_pin.sym} 1480 1080 0 0 {name=l232 lab=VDD}
C {devices/lab_pin.sym} 1430 1120 0 0 {name=l233 lab=CL3}
C {devices/lab_pin.sym} 1430 1160 0 0 {name=l234 lab=CH0}
C {devices/lab_pin.sym} 1480 1200 0 0 {name=l235 lab=VSS}
C {devices/lab_pin.sym} 1480 1460 0 0 {name=l236 lab=VDD}
C {devices/lab_pin.sym} 1430 1500 0 0 {name=l237 lab=CL0}
C {devices/lab_pin.sym} 1430 1540 0 0 {name=l238 lab=CH1}
C {devices/lab_pin.sym} 1480 1580 0 0 {name=l239 lab=VSS}
C {devices/lab_pin.sym} 1480 1840 0 0 {name=l240 lab=VDD}
C {devices/lab_pin.sym} 1430 1880 0 0 {name=l241 lab=CL1}
C {devices/lab_pin.sym} 1430 1920 0 0 {name=l242 lab=CH1}
C {devices/lab_pin.sym} 1480 1960 0 0 {name=l243 lab=VSS}
C {devices/lab_pin.sym} 1480 2220 0 0 {name=l244 lab=VDD}
C {devices/lab_pin.sym} 1430 2260 0 0 {name=l245 lab=CL2}
C {devices/lab_pin.sym} 1430 2300 0 0 {name=l246 lab=CH1}
C {devices/lab_pin.sym} 1480 2340 0 0 {name=l247 lab=VSS}
C {devices/lab_pin.sym} 1480 2600 0 0 {name=l248 lab=VDD}
C {devices/lab_pin.sym} 1430 2640 0 0 {name=l249 lab=CL3}
C {devices/lab_pin.sym} 1430 2680 0 0 {name=l250 lab=CH1}
C {devices/lab_pin.sym} 1480 2720 0 0 {name=l251 lab=VSS}
C {devices/lab_pin.sym} 2130 -60 0 0 {name=l252 lab=VDD}
C {devices/lab_pin.sym} 2080 -20 0 0 {name=l253 lab=CL0}
C {devices/lab_pin.sym} 2080 20 0 0 {name=l254 lab=CH2}
C {devices/lab_pin.sym} 2130 60 0 0 {name=l255 lab=VSS}
C {devices/lab_pin.sym} 2130 320 0 0 {name=l256 lab=VDD}
C {devices/lab_pin.sym} 2080 360 0 0 {name=l257 lab=CL1}
C {devices/lab_pin.sym} 2080 400 0 0 {name=l258 lab=CH2}
C {devices/lab_pin.sym} 2130 440 0 0 {name=l259 lab=VSS}
C {devices/lab_pin.sym} 2130 700 0 0 {name=l260 lab=VDD}
C {devices/lab_pin.sym} 2080 740 0 0 {name=l261 lab=CL2}
C {devices/lab_pin.sym} 2080 780 0 0 {name=l262 lab=CH2}
C {devices/lab_pin.sym} 2130 820 0 0 {name=l263 lab=VSS}
C {devices/lab_pin.sym} 2130 1080 0 0 {name=l264 lab=VDD}
C {devices/lab_pin.sym} 2080 1120 0 0 {name=l265 lab=CL3}
C {devices/lab_pin.sym} 2080 1160 0 0 {name=l266 lab=CH2}
C {devices/lab_pin.sym} 2130 1200 0 0 {name=l267 lab=VSS}
C {devices/lab_pin.sym} 2130 1460 0 0 {name=l268 lab=VDD}
C {devices/lab_pin.sym} 2080 1500 0 0 {name=l269 lab=CL0}
C {devices/lab_pin.sym} 2080 1540 0 0 {name=l270 lab=CH3}
C {devices/lab_pin.sym} 2130 1580 0 0 {name=l271 lab=VSS}
C {devices/lab_pin.sym} 2130 1840 0 0 {name=l272 lab=VDD}
C {devices/lab_pin.sym} 2080 1880 0 0 {name=l273 lab=CL1}
C {devices/lab_pin.sym} 2080 1920 0 0 {name=l274 lab=CH3}
C {devices/lab_pin.sym} 2130 1960 0 0 {name=l275 lab=VSS}
C {devices/lab_pin.sym} 2130 2220 0 0 {name=l276 lab=VDD}
C {devices/lab_pin.sym} 2080 2260 0 0 {name=l277 lab=CL2}
C {devices/lab_pin.sym} 2080 2300 0 0 {name=l278 lab=CH3}
C {devices/lab_pin.sym} 2130 2340 0 0 {name=l279 lab=VSS}
C {devices/lab_pin.sym} 2130 2600 0 0 {name=l280 lab=VDD}
C {devices/lab_pin.sym} 2080 2640 0 0 {name=l281 lab=CL3}
C {devices/lab_pin.sym} 2080 2680 0 0 {name=l282 lab=CH3}
C {devices/lab_pin.sym} 2130 2720 0 0 {name=l283 lab=VSS}
C {devices/lab_pin.sym} 2780 -60 0 0 {name=l284 lab=VDD}
C {devices/lab_pin.sym} 2730 -20 0 0 {name=l285 lab=CL0}
C {devices/lab_pin.sym} 2730 20 0 0 {name=l286 lab=CH4}
C {devices/lab_pin.sym} 2780 60 0 0 {name=l287 lab=VSS}
C {devices/lab_pin.sym} 2780 320 0 0 {name=l288 lab=VDD}
C {devices/lab_pin.sym} 2730 360 0 0 {name=l289 lab=CL1}
C {devices/lab_pin.sym} 2730 400 0 0 {name=l290 lab=CH4}
C {devices/lab_pin.sym} 2780 440 0 0 {name=l291 lab=VSS}
C {devices/lab_pin.sym} 2780 700 0 0 {name=l292 lab=VDD}
C {devices/lab_pin.sym} 2730 740 0 0 {name=l293 lab=CL2}
C {devices/lab_pin.sym} 2730 780 0 0 {name=l294 lab=CH4}
C {devices/lab_pin.sym} 2780 820 0 0 {name=l295 lab=VSS}
C {devices/lab_pin.sym} 2780 1080 0 0 {name=l296 lab=VDD}
C {devices/lab_pin.sym} 2730 1120 0 0 {name=l297 lab=CL3}
C {devices/lab_pin.sym} 2730 1160 0 0 {name=l298 lab=CH4}
C {devices/lab_pin.sym} 2780 1200 0 0 {name=l299 lab=VSS}
C {devices/lab_pin.sym} 2780 1460 0 0 {name=l300 lab=VDD}
C {devices/lab_pin.sym} 2730 1500 0 0 {name=l301 lab=CL0}
C {devices/lab_pin.sym} 2730 1540 0 0 {name=l302 lab=CH5}
C {devices/lab_pin.sym} 2780 1580 0 0 {name=l303 lab=VSS}
C {devices/lab_pin.sym} 2780 1840 0 0 {name=l304 lab=VDD}
C {devices/lab_pin.sym} 2730 1880 0 0 {name=l305 lab=CL1}
C {devices/lab_pin.sym} 2730 1920 0 0 {name=l306 lab=CH5}
C {devices/lab_pin.sym} 2780 1960 0 0 {name=l307 lab=VSS}
C {devices/lab_pin.sym} 2780 2220 0 0 {name=l308 lab=VDD}
C {devices/lab_pin.sym} 2730 2260 0 0 {name=l309 lab=CL2}
C {devices/lab_pin.sym} 2730 2300 0 0 {name=l310 lab=CH5}
C {devices/lab_pin.sym} 2780 2340 0 0 {name=l311 lab=VSS}
C {devices/lab_pin.sym} 2780 2600 0 0 {name=l312 lab=VDD}
C {devices/lab_pin.sym} 2730 2640 0 0 {name=l313 lab=CL3}
C {devices/lab_pin.sym} 2730 2680 0 0 {name=l314 lab=CH5}
C {devices/lab_pin.sym} 2780 2720 0 0 {name=l315 lab=VSS}
C {devices/lab_pin.sym} 3430 -60 0 0 {name=l316 lab=VDD}
C {devices/lab_pin.sym} 3380 -20 0 0 {name=l317 lab=CL0}
C {devices/lab_pin.sym} 3380 20 0 0 {name=l318 lab=CH6}
C {devices/lab_pin.sym} 3430 60 0 0 {name=l319 lab=VSS}
C {devices/lab_pin.sym} 3430 320 0 0 {name=l320 lab=VDD}
C {devices/lab_pin.sym} 3380 360 0 0 {name=l321 lab=CL1}
C {devices/lab_pin.sym} 3380 400 0 0 {name=l322 lab=CH6}
C {devices/lab_pin.sym} 3430 440 0 0 {name=l323 lab=VSS}
C {devices/lab_pin.sym} 3430 700 0 0 {name=l324 lab=VDD}
C {devices/lab_pin.sym} 3380 740 0 0 {name=l325 lab=CL2}
C {devices/lab_pin.sym} 3380 780 0 0 {name=l326 lab=CH6}
C {devices/lab_pin.sym} 3430 820 0 0 {name=l327 lab=VSS}
C {devices/lab_pin.sym} 3430 1080 0 0 {name=l328 lab=VDD}
C {devices/lab_pin.sym} 3380 1120 0 0 {name=l329 lab=CL3}
C {devices/lab_pin.sym} 3380 1160 0 0 {name=l330 lab=CH6}
C {devices/lab_pin.sym} 3430 1200 0 0 {name=l331 lab=VSS}
C {devices/lab_pin.sym} 3430 1460 0 0 {name=l332 lab=VDD}
C {devices/lab_pin.sym} 3380 1500 0 0 {name=l333 lab=CL0}
C {devices/lab_pin.sym} 3380 1540 0 0 {name=l334 lab=CH7}
C {devices/lab_pin.sym} 3430 1580 0 0 {name=l335 lab=VSS}
C {devices/lab_pin.sym} 3430 1840 0 0 {name=l336 lab=VDD}
C {devices/lab_pin.sym} 3380 1880 0 0 {name=l337 lab=CL1}
C {devices/lab_pin.sym} 3380 1920 0 0 {name=l338 lab=CH7}
C {devices/lab_pin.sym} 3430 1960 0 0 {name=l339 lab=VSS}
C {devices/lab_pin.sym} 3430 2220 0 0 {name=l340 lab=VDD}
C {devices/lab_pin.sym} 3380 2260 0 0 {name=l341 lab=CL2}
C {devices/lab_pin.sym} 3380 2300 0 0 {name=l342 lab=CH7}
C {devices/lab_pin.sym} 3430 2340 0 0 {name=l343 lab=VSS}
C {devices/lab_pin.sym} 3430 2600 0 0 {name=l344 lab=VDD}
C {devices/lab_pin.sym} 3380 2640 0 0 {name=l345 lab=CL3}
C {devices/lab_pin.sym} 3380 2680 0 0 {name=l346 lab=CH7}
C {devices/lab_pin.sym} 3430 2720 0 0 {name=l347 lab=VSS}
