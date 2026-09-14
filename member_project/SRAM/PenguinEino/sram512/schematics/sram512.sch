v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
E {}
T {SRAM512 | 16 x 32 | 7-pin serial interface | 5 V} -1100 -1000 0 0 0.55 0.55 {}
C {sram512_array.sym} 4000 0 0 0 {name=xarray}
C {sram512_row_decoder.sym} 300 0 0 0 {name=xrow}
N 460 -300 780 -300 {lab=WL0}
C {devices/lab_wire.sym} 620 -300 0 0 {name=l10 lab=WL0}
N 460 -260 780 -260 {lab=WL1}
C {devices/lab_wire.sym} 620 -260 0 0 {name=l12 lab=WL1}
N 460 -220 780 -220 {lab=WL2}
C {devices/lab_wire.sym} 620 -220 0 0 {name=l14 lab=WL2}
N 460 -180 780 -180 {lab=WL3}
C {devices/lab_wire.sym} 620 -180 0 0 {name=l16 lab=WL3}
N 460 -140 780 -140 {lab=WL4}
C {devices/lab_wire.sym} 620 -140 0 0 {name=l18 lab=WL4}
N 460 -100 780 -100 {lab=WL5}
C {devices/lab_wire.sym} 620 -100 0 0 {name=l20 lab=WL5}
N 460 -60 780 -60 {lab=WL6}
C {devices/lab_wire.sym} 620 -60 0 0 {name=l22 lab=WL6}
N 460 -20 780 -20 {lab=WL7}
C {devices/lab_wire.sym} 620 -20 0 0 {name=l24 lab=WL7}
N 460 20 780 20 {lab=WL8}
C {devices/lab_wire.sym} 620 20 0 0 {name=l26 lab=WL8}
N 460 60 780 60 {lab=WL9}
C {devices/lab_wire.sym} 620 60 0 0 {name=l28 lab=WL9}
N 460 100 780 100 {lab=WL10}
C {devices/lab_wire.sym} 620 100 0 0 {name=l30 lab=WL10}
N 460 140 780 140 {lab=WL11}
C {devices/lab_wire.sym} 620 140 0 0 {name=l32 lab=WL11}
N 460 180 780 180 {lab=WL12}
C {devices/lab_wire.sym} 620 180 0 0 {name=l34 lab=WL12}
N 460 220 780 220 {lab=WL13}
C {devices/lab_wire.sym} 620 220 0 0 {name=l36 lab=WL13}
N 460 260 780 260 {lab=WL14}
C {devices/lab_wire.sym} 620 260 0 0 {name=l38 lab=WL14}
N 460 300 780 300 {lab=WL15}
C {devices/lab_wire.sym} 620 300 0 0 {name=l40 lab=WL15}
C {sram512_column.sym} 900 1300 0 0 {name=xcol0}
N 850 720 850 1140 {lab=BL0}
C {devices/lab_wire.sym} 850 940 0 0 {name=l43 lab=BL0}
N 950 720 950 1140 {lab=BLB0}
C {devices/lab_wire.sym} 950 940 0 0 {name=l45 lab=BLB0}
N 850 1460 850 1560 {lab=Y}
N 950 1460 950 1600 {lab=YB}
C {sram512_column.sym} 1100 1300 0 0 {name=xcol1}
N 1050 720 1050 1140 {lab=BL1}
C {devices/lab_wire.sym} 1050 940 0 0 {name=l50 lab=BL1}
N 1150 720 1150 1140 {lab=BLB1}
C {devices/lab_wire.sym} 1150 940 0 0 {name=l52 lab=BLB1}
N 1050 1460 1050 1560 {lab=Y}
N 1150 1460 1150 1600 {lab=YB}
C {sram512_column.sym} 1300 1300 0 0 {name=xcol2}
N 1250 720 1250 1140 {lab=BL2}
C {devices/lab_wire.sym} 1250 940 0 0 {name=l57 lab=BL2}
N 1350 720 1350 1140 {lab=BLB2}
C {devices/lab_wire.sym} 1350 940 0 0 {name=l59 lab=BLB2}
N 1250 1460 1250 1560 {lab=Y}
N 1350 1460 1350 1600 {lab=YB}
C {sram512_column.sym} 1500 1300 0 0 {name=xcol3}
N 1450 720 1450 1140 {lab=BL3}
C {devices/lab_wire.sym} 1450 940 0 0 {name=l64 lab=BL3}
N 1550 720 1550 1140 {lab=BLB3}
C {devices/lab_wire.sym} 1550 940 0 0 {name=l66 lab=BLB3}
N 1450 1460 1450 1560 {lab=Y}
N 1550 1460 1550 1600 {lab=YB}
C {sram512_column.sym} 1700 1300 0 0 {name=xcol4}
N 1650 720 1650 1140 {lab=BL4}
C {devices/lab_wire.sym} 1650 940 0 0 {name=l71 lab=BL4}
N 1750 720 1750 1140 {lab=BLB4}
C {devices/lab_wire.sym} 1750 940 0 0 {name=l73 lab=BLB4}
N 1650 1460 1650 1560 {lab=Y}
N 1750 1460 1750 1600 {lab=YB}
C {sram512_column.sym} 1900 1300 0 0 {name=xcol5}
N 1850 720 1850 1140 {lab=BL5}
C {devices/lab_wire.sym} 1850 940 0 0 {name=l78 lab=BL5}
N 1950 720 1950 1140 {lab=BLB5}
C {devices/lab_wire.sym} 1950 940 0 0 {name=l80 lab=BLB5}
N 1850 1460 1850 1560 {lab=Y}
N 1950 1460 1950 1600 {lab=YB}
C {sram512_column.sym} 2100 1300 0 0 {name=xcol6}
N 2050 720 2050 1140 {lab=BL6}
C {devices/lab_wire.sym} 2050 940 0 0 {name=l85 lab=BL6}
N 2150 720 2150 1140 {lab=BLB6}
C {devices/lab_wire.sym} 2150 940 0 0 {name=l87 lab=BLB6}
N 2050 1460 2050 1560 {lab=Y}
N 2150 1460 2150 1600 {lab=YB}
C {sram512_column.sym} 2300 1300 0 0 {name=xcol7}
N 2250 720 2250 1140 {lab=BL7}
C {devices/lab_wire.sym} 2250 940 0 0 {name=l92 lab=BL7}
N 2350 720 2350 1140 {lab=BLB7}
C {devices/lab_wire.sym} 2350 940 0 0 {name=l94 lab=BLB7}
N 2250 1460 2250 1560 {lab=Y}
N 2350 1460 2350 1600 {lab=YB}
C {sram512_column.sym} 2500 1300 0 0 {name=xcol8}
N 2450 720 2450 1140 {lab=BL8}
C {devices/lab_wire.sym} 2450 940 0 0 {name=l99 lab=BL8}
N 2550 720 2550 1140 {lab=BLB8}
C {devices/lab_wire.sym} 2550 940 0 0 {name=l101 lab=BLB8}
N 2450 1460 2450 1560 {lab=Y}
N 2550 1460 2550 1600 {lab=YB}
C {sram512_column.sym} 2700 1300 0 0 {name=xcol9}
N 2650 720 2650 1140 {lab=BL9}
C {devices/lab_wire.sym} 2650 940 0 0 {name=l106 lab=BL9}
N 2750 720 2750 1140 {lab=BLB9}
C {devices/lab_wire.sym} 2750 940 0 0 {name=l108 lab=BLB9}
N 2650 1460 2650 1560 {lab=Y}
N 2750 1460 2750 1600 {lab=YB}
C {sram512_column.sym} 2900 1300 0 0 {name=xcol10}
N 2850 720 2850 1140 {lab=BL10}
C {devices/lab_wire.sym} 2850 940 0 0 {name=l113 lab=BL10}
N 2950 720 2950 1140 {lab=BLB10}
C {devices/lab_wire.sym} 2950 940 0 0 {name=l115 lab=BLB10}
N 2850 1460 2850 1560 {lab=Y}
N 2950 1460 2950 1600 {lab=YB}
C {sram512_column.sym} 3100 1300 0 0 {name=xcol11}
N 3050 720 3050 1140 {lab=BL11}
C {devices/lab_wire.sym} 3050 940 0 0 {name=l120 lab=BL11}
N 3150 720 3150 1140 {lab=BLB11}
C {devices/lab_wire.sym} 3150 940 0 0 {name=l122 lab=BLB11}
N 3050 1460 3050 1560 {lab=Y}
N 3150 1460 3150 1600 {lab=YB}
C {sram512_column.sym} 3300 1300 0 0 {name=xcol12}
N 3250 720 3250 1140 {lab=BL12}
C {devices/lab_wire.sym} 3250 940 0 0 {name=l127 lab=BL12}
N 3350 720 3350 1140 {lab=BLB12}
C {devices/lab_wire.sym} 3350 940 0 0 {name=l129 lab=BLB12}
N 3250 1460 3250 1560 {lab=Y}
N 3350 1460 3350 1600 {lab=YB}
C {sram512_column.sym} 3500 1300 0 0 {name=xcol13}
N 3450 720 3450 1140 {lab=BL13}
C {devices/lab_wire.sym} 3450 940 0 0 {name=l134 lab=BL13}
N 3550 720 3550 1140 {lab=BLB13}
C {devices/lab_wire.sym} 3550 940 0 0 {name=l136 lab=BLB13}
N 3450 1460 3450 1560 {lab=Y}
N 3550 1460 3550 1600 {lab=YB}
C {sram512_column.sym} 3700 1300 0 0 {name=xcol14}
N 3650 720 3650 1140 {lab=BL14}
C {devices/lab_wire.sym} 3650 940 0 0 {name=l141 lab=BL14}
N 3750 720 3750 1140 {lab=BLB14}
C {devices/lab_wire.sym} 3750 940 0 0 {name=l143 lab=BLB14}
N 3650 1460 3650 1560 {lab=Y}
N 3750 1460 3750 1600 {lab=YB}
C {sram512_column.sym} 3900 1300 0 0 {name=xcol15}
N 3850 720 3850 1140 {lab=BL15}
C {devices/lab_wire.sym} 3850 940 0 0 {name=l148 lab=BL15}
N 3950 720 3950 1140 {lab=BLB15}
C {devices/lab_wire.sym} 3950 940 0 0 {name=l150 lab=BLB15}
N 3850 1460 3850 1560 {lab=Y}
N 3950 1460 3950 1600 {lab=YB}
C {sram512_column.sym} 4100 1300 0 0 {name=xcol16}
N 4050 720 4050 1140 {lab=BL16}
C {devices/lab_wire.sym} 4050 940 0 0 {name=l155 lab=BL16}
N 4150 720 4150 1140 {lab=BLB16}
C {devices/lab_wire.sym} 4150 940 0 0 {name=l157 lab=BLB16}
N 4050 1460 4050 1560 {lab=Y}
N 4150 1460 4150 1600 {lab=YB}
C {sram512_column.sym} 4300 1300 0 0 {name=xcol17}
N 4250 720 4250 1140 {lab=BL17}
C {devices/lab_wire.sym} 4250 940 0 0 {name=l162 lab=BL17}
N 4350 720 4350 1140 {lab=BLB17}
C {devices/lab_wire.sym} 4350 940 0 0 {name=l164 lab=BLB17}
N 4250 1460 4250 1560 {lab=Y}
N 4350 1460 4350 1600 {lab=YB}
C {sram512_column.sym} 4500 1300 0 0 {name=xcol18}
N 4450 720 4450 1140 {lab=BL18}
C {devices/lab_wire.sym} 4450 940 0 0 {name=l169 lab=BL18}
N 4550 720 4550 1140 {lab=BLB18}
C {devices/lab_wire.sym} 4550 940 0 0 {name=l171 lab=BLB18}
N 4450 1460 4450 1560 {lab=Y}
N 4550 1460 4550 1600 {lab=YB}
C {sram512_column.sym} 4700 1300 0 0 {name=xcol19}
N 4650 720 4650 1140 {lab=BL19}
C {devices/lab_wire.sym} 4650 940 0 0 {name=l176 lab=BL19}
N 4750 720 4750 1140 {lab=BLB19}
C {devices/lab_wire.sym} 4750 940 0 0 {name=l178 lab=BLB19}
N 4650 1460 4650 1560 {lab=Y}
N 4750 1460 4750 1600 {lab=YB}
C {sram512_column.sym} 4900 1300 0 0 {name=xcol20}
N 4850 720 4850 1140 {lab=BL20}
C {devices/lab_wire.sym} 4850 940 0 0 {name=l183 lab=BL20}
N 4950 720 4950 1140 {lab=BLB20}
C {devices/lab_wire.sym} 4950 940 0 0 {name=l185 lab=BLB20}
N 4850 1460 4850 1560 {lab=Y}
N 4950 1460 4950 1600 {lab=YB}
C {sram512_column.sym} 5100 1300 0 0 {name=xcol21}
N 5050 720 5050 1140 {lab=BL21}
C {devices/lab_wire.sym} 5050 940 0 0 {name=l190 lab=BL21}
N 5150 720 5150 1140 {lab=BLB21}
C {devices/lab_wire.sym} 5150 940 0 0 {name=l192 lab=BLB21}
N 5050 1460 5050 1560 {lab=Y}
N 5150 1460 5150 1600 {lab=YB}
C {sram512_column.sym} 5300 1300 0 0 {name=xcol22}
N 5250 720 5250 1140 {lab=BL22}
C {devices/lab_wire.sym} 5250 940 0 0 {name=l197 lab=BL22}
N 5350 720 5350 1140 {lab=BLB22}
C {devices/lab_wire.sym} 5350 940 0 0 {name=l199 lab=BLB22}
N 5250 1460 5250 1560 {lab=Y}
N 5350 1460 5350 1600 {lab=YB}
C {sram512_column.sym} 5500 1300 0 0 {name=xcol23}
N 5450 720 5450 1140 {lab=BL23}
C {devices/lab_wire.sym} 5450 940 0 0 {name=l204 lab=BL23}
N 5550 720 5550 1140 {lab=BLB23}
C {devices/lab_wire.sym} 5550 940 0 0 {name=l206 lab=BLB23}
N 5450 1460 5450 1560 {lab=Y}
N 5550 1460 5550 1600 {lab=YB}
C {sram512_column.sym} 5700 1300 0 0 {name=xcol24}
N 5650 720 5650 1140 {lab=BL24}
C {devices/lab_wire.sym} 5650 940 0 0 {name=l211 lab=BL24}
N 5750 720 5750 1140 {lab=BLB24}
C {devices/lab_wire.sym} 5750 940 0 0 {name=l213 lab=BLB24}
N 5650 1460 5650 1560 {lab=Y}
N 5750 1460 5750 1600 {lab=YB}
C {sram512_column.sym} 5900 1300 0 0 {name=xcol25}
N 5850 720 5850 1140 {lab=BL25}
C {devices/lab_wire.sym} 5850 940 0 0 {name=l218 lab=BL25}
N 5950 720 5950 1140 {lab=BLB25}
C {devices/lab_wire.sym} 5950 940 0 0 {name=l220 lab=BLB25}
N 5850 1460 5850 1560 {lab=Y}
N 5950 1460 5950 1600 {lab=YB}
C {sram512_column.sym} 6100 1300 0 0 {name=xcol26}
N 6050 720 6050 1140 {lab=BL26}
C {devices/lab_wire.sym} 6050 940 0 0 {name=l225 lab=BL26}
N 6150 720 6150 1140 {lab=BLB26}
C {devices/lab_wire.sym} 6150 940 0 0 {name=l227 lab=BLB26}
N 6050 1460 6050 1560 {lab=Y}
N 6150 1460 6150 1600 {lab=YB}
C {sram512_column.sym} 6300 1300 0 0 {name=xcol27}
N 6250 720 6250 1140 {lab=BL27}
C {devices/lab_wire.sym} 6250 940 0 0 {name=l232 lab=BL27}
N 6350 720 6350 1140 {lab=BLB27}
C {devices/lab_wire.sym} 6350 940 0 0 {name=l234 lab=BLB27}
N 6250 1460 6250 1560 {lab=Y}
N 6350 1460 6350 1600 {lab=YB}
C {sram512_column.sym} 6500 1300 0 0 {name=xcol28}
N 6450 720 6450 1140 {lab=BL28}
C {devices/lab_wire.sym} 6450 940 0 0 {name=l239 lab=BL28}
N 6550 720 6550 1140 {lab=BLB28}
C {devices/lab_wire.sym} 6550 940 0 0 {name=l241 lab=BLB28}
N 6450 1460 6450 1560 {lab=Y}
N 6550 1460 6550 1600 {lab=YB}
C {sram512_column.sym} 6700 1300 0 0 {name=xcol29}
N 6650 720 6650 1140 {lab=BL29}
C {devices/lab_wire.sym} 6650 940 0 0 {name=l246 lab=BL29}
N 6750 720 6750 1140 {lab=BLB29}
C {devices/lab_wire.sym} 6750 940 0 0 {name=l248 lab=BLB29}
N 6650 1460 6650 1560 {lab=Y}
N 6750 1460 6750 1600 {lab=YB}
C {sram512_column.sym} 6900 1300 0 0 {name=xcol30}
N 6850 720 6850 1140 {lab=BL30}
C {devices/lab_wire.sym} 6850 940 0 0 {name=l253 lab=BL30}
N 6950 720 6950 1140 {lab=BLB30}
C {devices/lab_wire.sym} 6950 940 0 0 {name=l255 lab=BLB30}
N 6850 1460 6850 1560 {lab=Y}
N 6950 1460 6950 1600 {lab=YB}
C {sram512_column.sym} 7100 1300 0 0 {name=xcol31}
N 7050 720 7050 1140 {lab=BL31}
C {devices/lab_wire.sym} 7050 940 0 0 {name=l260 lab=BL31}
N 7150 720 7150 1140 {lab=BLB31}
C {devices/lab_wire.sym} 7150 940 0 0 {name=l262 lab=BLB31}
N 7050 1460 7050 1560 {lab=Y}
N 7150 1460 7150 1600 {lab=YB}
N 800 1560 7300 1560 {lab=Y}
C {devices/lab_wire.sym} 800 1560 0 0 {name=l266 lab=Y}
N 800 1600 7300 1600 {lab=YB}
C {devices/lab_wire.sym} 800 1600 0 0 {name=l268 lab=YB}
C {sram512_col_decoder.sym} 4000 2140 0 0 {name=xcol_decode}
N 900 1960 900 1460 {lab=COL0}
C {devices/lab_wire.sym} 900 1850 0 0 {name=l271 lab=COL0}
N 1100 1960 1100 1460 {lab=COL1}
C {devices/lab_wire.sym} 1100 1850 0 0 {name=l273 lab=COL1}
N 1300 1960 1300 1460 {lab=COL2}
C {devices/lab_wire.sym} 1300 1850 0 0 {name=l275 lab=COL2}
N 1500 1960 1500 1460 {lab=COL3}
C {devices/lab_wire.sym} 1500 1850 0 0 {name=l277 lab=COL3}
N 1700 1960 1700 1460 {lab=COL4}
C {devices/lab_wire.sym} 1700 1850 0 0 {name=l279 lab=COL4}
N 1900 1960 1900 1460 {lab=COL5}
C {devices/lab_wire.sym} 1900 1850 0 0 {name=l281 lab=COL5}
N 2100 1960 2100 1460 {lab=COL6}
C {devices/lab_wire.sym} 2100 1850 0 0 {name=l283 lab=COL6}
N 2300 1960 2300 1460 {lab=COL7}
C {devices/lab_wire.sym} 2300 1850 0 0 {name=l285 lab=COL7}
N 2500 1960 2500 1460 {lab=COL8}
C {devices/lab_wire.sym} 2500 1850 0 0 {name=l287 lab=COL8}
N 2700 1960 2700 1460 {lab=COL9}
C {devices/lab_wire.sym} 2700 1850 0 0 {name=l289 lab=COL9}
N 2900 1960 2900 1460 {lab=COL10}
C {devices/lab_wire.sym} 2900 1850 0 0 {name=l291 lab=COL10}
N 3100 1960 3100 1460 {lab=COL11}
C {devices/lab_wire.sym} 3100 1850 0 0 {name=l293 lab=COL11}
N 3300 1960 3300 1460 {lab=COL12}
C {devices/lab_wire.sym} 3300 1850 0 0 {name=l295 lab=COL12}
N 3500 1960 3500 1460 {lab=COL13}
C {devices/lab_wire.sym} 3500 1850 0 0 {name=l297 lab=COL13}
N 3700 1960 3700 1460 {lab=COL14}
C {devices/lab_wire.sym} 3700 1850 0 0 {name=l299 lab=COL14}
N 3900 1960 3900 1460 {lab=COL15}
C {devices/lab_wire.sym} 3900 1850 0 0 {name=l301 lab=COL15}
N 4100 1960 4100 1460 {lab=COL16}
C {devices/lab_wire.sym} 4100 1850 0 0 {name=l303 lab=COL16}
N 4300 1960 4300 1460 {lab=COL17}
C {devices/lab_wire.sym} 4300 1850 0 0 {name=l305 lab=COL17}
N 4500 1960 4500 1460 {lab=COL18}
C {devices/lab_wire.sym} 4500 1850 0 0 {name=l307 lab=COL18}
N 4700 1960 4700 1460 {lab=COL19}
C {devices/lab_wire.sym} 4700 1850 0 0 {name=l309 lab=COL19}
N 4900 1960 4900 1460 {lab=COL20}
C {devices/lab_wire.sym} 4900 1850 0 0 {name=l311 lab=COL20}
N 5100 1960 5100 1460 {lab=COL21}
C {devices/lab_wire.sym} 5100 1850 0 0 {name=l313 lab=COL21}
N 5300 1960 5300 1460 {lab=COL22}
C {devices/lab_wire.sym} 5300 1850 0 0 {name=l315 lab=COL22}
N 5500 1960 5500 1460 {lab=COL23}
C {devices/lab_wire.sym} 5500 1850 0 0 {name=l317 lab=COL23}
N 5700 1960 5700 1460 {lab=COL24}
C {devices/lab_wire.sym} 5700 1850 0 0 {name=l319 lab=COL24}
N 5900 1960 5900 1460 {lab=COL25}
C {devices/lab_wire.sym} 5900 1850 0 0 {name=l321 lab=COL25}
N 6100 1960 6100 1460 {lab=COL26}
C {devices/lab_wire.sym} 6100 1850 0 0 {name=l323 lab=COL26}
N 6300 1960 6300 1460 {lab=COL27}
C {devices/lab_wire.sym} 6300 1850 0 0 {name=l325 lab=COL27}
N 6500 1960 6500 1460 {lab=COL28}
C {devices/lab_wire.sym} 6500 1850 0 0 {name=l327 lab=COL28}
N 6700 1960 6700 1460 {lab=COL29}
C {devices/lab_wire.sym} 6700 1850 0 0 {name=l329 lab=COL29}
N 6900 1960 6900 1460 {lab=COL30}
C {devices/lab_wire.sym} 6900 1850 0 0 {name=l331 lab=COL30}
N 7100 1960 7100 1460 {lab=COL31}
C {devices/lab_wire.sym} 7100 1850 0 0 {name=l333 lab=COL31}
C {sense_amp_7t.sym} 5600 2730 0 0 {name=xsense}
N 5450 2670 5360 2670 {lab=Y}
N 5360 2670 5360 1560 {lab=Y}
N 5450 2730 5280 2730 {lab=YB}
N 5280 2730 5280 1600 {lab=YB}
C {TR-1umLIB/MP.sym} 2400 2500 0 0 {name=xpc_Y model=PMOS w=10.2u l=1u m=1 spiceprefix=X}
C {TR-1umLIB/MN.sym} 2400 2940 0 0 {name=xwrite_Y model=NMOS w=10.2u l=1u m=1 spiceprefix=X}
N 2440 2530 2560 2530 {lab=Y}
N 2560 2530 2560 1560 {lab=Y}
N 2440 2910 2620 2910 {lab=Y}
N 2620 2910 2620 1560 {lab=Y}
C {TR-1um_5_stdcell/AND2_X1.sym} 1950 2940 0 0 {name=xwrite_data0}
N 2060 2940 2400 2940 {lab=PD_Y}
C {devices/lab_wire.sym} 2200 2940 0 0 {name=l347 lab=PD_Y}
C {TR-1umLIB/MP.sym} 3700 2500 0 0 {name=xpc_YB model=PMOS w=10.2u l=1u m=1 spiceprefix=X}
C {TR-1umLIB/MN.sym} 3700 2940 0 0 {name=xwrite_YB model=NMOS w=10.2u l=1u m=1 spiceprefix=X}
N 3740 2530 3860 2530 {lab=YB}
N 3860 2530 3860 1600 {lab=YB}
N 3740 2910 3920 2910 {lab=YB}
N 3920 2910 3920 1600 {lab=YB}
C {TR-1um_5_stdcell/AND2_X1.sym} 3250 2940 0 0 {name=xwrite_data1}
N 3360 2940 3700 2940 {lab=PD_YB}
C {devices/lab_wire.sym} 3500 2940 0 0 {name=l356 lab=PD_YB}
C {sram512_controller.sym} 0 2040 0 0 {name=xctrl}
T {INPUT GATE ANTENNA CLAMPS | pad / ESD network connects at chip integration} -1100 760 0 0 0.28 0.28 {}
C {sram512_input_clamp.sym} -1100 980 0 0 {name=xinput_clk}
C {sram512_input_clamp.sym} -680 980 0 0 {name=xinput_reset}
C {sram512_input_clamp.sym} -260 980 0 0 {name=xinput_sdi}
C {sram512_input_clamp.sym} 160 980 0 0 {name=xinput_we}
C {devices/ipin.sym} -1100 1400 0 0 {name=pCLK lab=CLK}
N -1100 1400 -1040 1400 {lab=CLK}
C {devices/lab_pin.sym} -1040 1400 0 0 {name=l365 lab=CLK hide_texts=true}
C {devices/ipin.sym} -1100 1540 0 0 {name=pRESET lab=RESET}
N -1100 1540 -1040 1540 {lab=RESET}
C {devices/lab_pin.sym} -1040 1540 0 0 {name=l368 lab=RESET hide_texts=true}
C {devices/ipin.sym} -1100 1680 0 0 {name=pSDI lab=SDI}
N -1100 1680 -1040 1680 {lab=SDI}
C {devices/lab_pin.sym} -1040 1680 0 0 {name=l371 lab=SDI hide_texts=true}
C {devices/ipin.sym} -1100 1820 0 0 {name=pWE lab=WE}
N -1100 1820 -1040 1820 {lab=WE}
C {devices/lab_pin.sym} -1040 1820 0 0 {name=l374 lab=WE hide_texts=true}
C {devices/opin.sym} -1100 1960 0 0 {name=pSDO lab=SDO}
N -1100 1960 -1040 1960 {lab=SDO}
C {devices/lab_pin.sym} -1040 1960 0 0 {name=l377 lab=SDO hide_texts=true}
C {devices/iopin.sym} -1100 2100 0 0 {name=pVDD lab=VDD}
N -1100 2100 -1040 2100 {lab=VDD}
C {devices/lab_pin.sym} -1040 2100 0 0 {name=l380 lab=VDD hide_texts=true}
C {devices/iopin.sym} -1100 2240 0 0 {name=pVSS lab=VSS}
N -1100 2240 -1040 2240 {lab=VSS}
C {devices/lab_pin.sym} -1040 2240 0 0 {name=l383 lab=VSS hide_texts=true}
T {Common lines Y / YB feed the shared write pulldown and 7T sense amplifier} 1000 3270 0 0 0.34 0.34 {}
T {E0 precharge; E1 release; E2 write drive; E3 WL; E4 SAE; E5 WL off; E6 capture; E7 end} 1000 3340 0 0 0.3 0.3 {}
C {devices/lab_pin.sym} 3800 -720 0 0 {name=l386 lab=VDD}
C {devices/lab_pin.sym} 4200 -720 0 0 {name=l387 lab=VSS}
C {devices/lab_pin.sym} 140 -80 0 0 {name=l388 lab=RA0}
C {devices/lab_pin.sym} 140 -40 0 0 {name=l389 lab=RA1}
C {devices/lab_pin.sym} 140 0 0 0 {name=l390 lab=RA2}
C {devices/lab_pin.sym} 140 40 0 0 {name=l391 lab=RA3}
C {devices/lab_pin.sym} 140 80 0 0 {name=l392 lab=WL_EN}
C {devices/lab_pin.sym} 300 -400 0 0 {name=l393 lab=VDD}
C {devices/lab_pin.sym} 300 400 0 0 {name=l394 lab=VSS}
C {devices/lab_pin.sym} 800 1250 0 0 {name=l395 lab=PREB}
C {devices/lab_pin.sym} 900 1140 0 0 {name=l396 lab=VDD}
C {devices/lab_pin.sym} 1000 1350 0 0 {name=l397 lab=VSS}
C {devices/lab_pin.sym} 1000 1250 0 0 {name=l398 lab=PREB}
C {devices/lab_pin.sym} 1100 1140 0 0 {name=l399 lab=VDD}
C {devices/lab_pin.sym} 1200 1350 0 0 {name=l400 lab=VSS}
C {devices/lab_pin.sym} 1200 1250 0 0 {name=l401 lab=PREB}
C {devices/lab_pin.sym} 1300 1140 0 0 {name=l402 lab=VDD}
C {devices/lab_pin.sym} 1400 1350 0 0 {name=l403 lab=VSS}
C {devices/lab_pin.sym} 1400 1250 0 0 {name=l404 lab=PREB}
C {devices/lab_pin.sym} 1500 1140 0 0 {name=l405 lab=VDD}
C {devices/lab_pin.sym} 1600 1350 0 0 {name=l406 lab=VSS}
C {devices/lab_pin.sym} 1600 1250 0 0 {name=l407 lab=PREB}
C {devices/lab_pin.sym} 1700 1140 0 0 {name=l408 lab=VDD}
C {devices/lab_pin.sym} 1800 1350 0 0 {name=l409 lab=VSS}
C {devices/lab_pin.sym} 1800 1250 0 0 {name=l410 lab=PREB}
C {devices/lab_pin.sym} 1900 1140 0 0 {name=l411 lab=VDD}
C {devices/lab_pin.sym} 2000 1350 0 0 {name=l412 lab=VSS}
C {devices/lab_pin.sym} 2000 1250 0 0 {name=l413 lab=PREB}
C {devices/lab_pin.sym} 2100 1140 0 0 {name=l414 lab=VDD}
C {devices/lab_pin.sym} 2200 1350 0 0 {name=l415 lab=VSS}
C {devices/lab_pin.sym} 2200 1250 0 0 {name=l416 lab=PREB}
C {devices/lab_pin.sym} 2300 1140 0 0 {name=l417 lab=VDD}
C {devices/lab_pin.sym} 2400 1350 0 0 {name=l418 lab=VSS}
C {devices/lab_pin.sym} 2400 1250 0 0 {name=l419 lab=PREB}
C {devices/lab_pin.sym} 2500 1140 0 0 {name=l420 lab=VDD}
C {devices/lab_pin.sym} 2600 1350 0 0 {name=l421 lab=VSS}
C {devices/lab_pin.sym} 2600 1250 0 0 {name=l422 lab=PREB}
C {devices/lab_pin.sym} 2700 1140 0 0 {name=l423 lab=VDD}
C {devices/lab_pin.sym} 2800 1350 0 0 {name=l424 lab=VSS}
C {devices/lab_pin.sym} 2800 1250 0 0 {name=l425 lab=PREB}
C {devices/lab_pin.sym} 2900 1140 0 0 {name=l426 lab=VDD}
C {devices/lab_pin.sym} 3000 1350 0 0 {name=l427 lab=VSS}
C {devices/lab_pin.sym} 3000 1250 0 0 {name=l428 lab=PREB}
C {devices/lab_pin.sym} 3100 1140 0 0 {name=l429 lab=VDD}
C {devices/lab_pin.sym} 3200 1350 0 0 {name=l430 lab=VSS}
C {devices/lab_pin.sym} 3200 1250 0 0 {name=l431 lab=PREB}
C {devices/lab_pin.sym} 3300 1140 0 0 {name=l432 lab=VDD}
C {devices/lab_pin.sym} 3400 1350 0 0 {name=l433 lab=VSS}
C {devices/lab_pin.sym} 3400 1250 0 0 {name=l434 lab=PREB}
C {devices/lab_pin.sym} 3500 1140 0 0 {name=l435 lab=VDD}
C {devices/lab_pin.sym} 3600 1350 0 0 {name=l436 lab=VSS}
C {devices/lab_pin.sym} 3600 1250 0 0 {name=l437 lab=PREB}
C {devices/lab_pin.sym} 3700 1140 0 0 {name=l438 lab=VDD}
C {devices/lab_pin.sym} 3800 1350 0 0 {name=l439 lab=VSS}
C {devices/lab_pin.sym} 3800 1250 0 0 {name=l440 lab=PREB}
C {devices/lab_pin.sym} 3900 1140 0 0 {name=l441 lab=VDD}
C {devices/lab_pin.sym} 4000 1350 0 0 {name=l442 lab=VSS}
C {devices/lab_pin.sym} 4000 1250 0 0 {name=l443 lab=PREB}
C {devices/lab_pin.sym} 4100 1140 0 0 {name=l444 lab=VDD}
C {devices/lab_pin.sym} 4200 1350 0 0 {name=l445 lab=VSS}
C {devices/lab_pin.sym} 4200 1250 0 0 {name=l446 lab=PREB}
C {devices/lab_pin.sym} 4300 1140 0 0 {name=l447 lab=VDD}
C {devices/lab_pin.sym} 4400 1350 0 0 {name=l448 lab=VSS}
C {devices/lab_pin.sym} 4400 1250 0 0 {name=l449 lab=PREB}
C {devices/lab_pin.sym} 4500 1140 0 0 {name=l450 lab=VDD}
C {devices/lab_pin.sym} 4600 1350 0 0 {name=l451 lab=VSS}
C {devices/lab_pin.sym} 4600 1250 0 0 {name=l452 lab=PREB}
C {devices/lab_pin.sym} 4700 1140 0 0 {name=l453 lab=VDD}
C {devices/lab_pin.sym} 4800 1350 0 0 {name=l454 lab=VSS}
C {devices/lab_pin.sym} 4800 1250 0 0 {name=l455 lab=PREB}
C {devices/lab_pin.sym} 4900 1140 0 0 {name=l456 lab=VDD}
C {devices/lab_pin.sym} 5000 1350 0 0 {name=l457 lab=VSS}
C {devices/lab_pin.sym} 5000 1250 0 0 {name=l458 lab=PREB}
C {devices/lab_pin.sym} 5100 1140 0 0 {name=l459 lab=VDD}
C {devices/lab_pin.sym} 5200 1350 0 0 {name=l460 lab=VSS}
C {devices/lab_pin.sym} 5200 1250 0 0 {name=l461 lab=PREB}
C {devices/lab_pin.sym} 5300 1140 0 0 {name=l462 lab=VDD}
C {devices/lab_pin.sym} 5400 1350 0 0 {name=l463 lab=VSS}
C {devices/lab_pin.sym} 5400 1250 0 0 {name=l464 lab=PREB}
C {devices/lab_pin.sym} 5500 1140 0 0 {name=l465 lab=VDD}
C {devices/lab_pin.sym} 5600 1350 0 0 {name=l466 lab=VSS}
C {devices/lab_pin.sym} 5600 1250 0 0 {name=l467 lab=PREB}
C {devices/lab_pin.sym} 5700 1140 0 0 {name=l468 lab=VDD}
C {devices/lab_pin.sym} 5800 1350 0 0 {name=l469 lab=VSS}
C {devices/lab_pin.sym} 5800 1250 0 0 {name=l470 lab=PREB}
C {devices/lab_pin.sym} 5900 1140 0 0 {name=l471 lab=VDD}
C {devices/lab_pin.sym} 6000 1350 0 0 {name=l472 lab=VSS}
C {devices/lab_pin.sym} 6000 1250 0 0 {name=l473 lab=PREB}
C {devices/lab_pin.sym} 6100 1140 0 0 {name=l474 lab=VDD}
C {devices/lab_pin.sym} 6200 1350 0 0 {name=l475 lab=VSS}
C {devices/lab_pin.sym} 6200 1250 0 0 {name=l476 lab=PREB}
C {devices/lab_pin.sym} 6300 1140 0 0 {name=l477 lab=VDD}
C {devices/lab_pin.sym} 6400 1350 0 0 {name=l478 lab=VSS}
C {devices/lab_pin.sym} 6400 1250 0 0 {name=l479 lab=PREB}
C {devices/lab_pin.sym} 6500 1140 0 0 {name=l480 lab=VDD}
C {devices/lab_pin.sym} 6600 1350 0 0 {name=l481 lab=VSS}
C {devices/lab_pin.sym} 6600 1250 0 0 {name=l482 lab=PREB}
C {devices/lab_pin.sym} 6700 1140 0 0 {name=l483 lab=VDD}
C {devices/lab_pin.sym} 6800 1350 0 0 {name=l484 lab=VSS}
C {devices/lab_pin.sym} 6800 1250 0 0 {name=l485 lab=PREB}
C {devices/lab_pin.sym} 6900 1140 0 0 {name=l486 lab=VDD}
C {devices/lab_pin.sym} 7000 1350 0 0 {name=l487 lab=VSS}
C {devices/lab_pin.sym} 7000 1250 0 0 {name=l488 lab=PREB}
C {devices/lab_pin.sym} 7100 1140 0 0 {name=l489 lab=VDD}
C {devices/lab_pin.sym} 7200 1350 0 0 {name=l490 lab=VSS}
C {devices/lab_pin.sym} 780 2020 0 0 {name=l491 lab=CA0}
C {devices/lab_pin.sym} 780 2045 0 0 {name=l492 lab=CA0B}
C {devices/lab_pin.sym} 780 2070 0 0 {name=l493 lab=CA1}
C {devices/lab_pin.sym} 780 2095 0 0 {name=l494 lab=CA1B}
C {devices/lab_pin.sym} 780 2120 0 0 {name=l495 lab=CA2}
C {devices/lab_pin.sym} 780 2145 0 0 {name=l496 lab=CA2B}
C {devices/lab_pin.sym} 780 2170 0 0 {name=l497 lab=CA3}
C {devices/lab_pin.sym} 780 2195 0 0 {name=l498 lab=CA3B}
C {devices/lab_pin.sym} 780 2220 0 0 {name=l499 lab=CA4}
C {devices/lab_pin.sym} 780 2245 0 0 {name=l500 lab=CA4B}
C {devices/lab_pin.sym} 4000 1960 0 0 {name=l501 lab=VDD}
C {devices/lab_pin.sym} 4000 2320 0 0 {name=l502 lab=VSS}
C {devices/lab_pin.sym} 5450 2790 0 0 {name=l503 lab=SAE}
C {devices/lab_pin.sym} 5750 2670 2 0 {name=l504 lab=SOUT}
C {devices/lab_pin.sym} 5750 2730 2 0 {name=l505 lab=SOUTB}
C {devices/noconn.sym} 5750 2730 0 0 {name=nc506}
C {devices/lab_pin.sym} 5600 2610 0 0 {name=l507 lab=VDD}
C {devices/lab_pin.sym} 5600 2850 0 0 {name=l508 lab=VSS}
C {devices/lab_pin.sym} 2400 2500 0 0 {name=l509 lab=PREB}
C {devices/lab_pin.sym} 2440 2470 0 0 {name=l510 lab=VDD}
C {devices/lab_pin.sym} 2440 2500 0 0 {name=l511 lab=VDD}
C {devices/lab_pin.sym} 2440 2970 0 0 {name=l512 lab=VSS}
C {devices/lab_pin.sym} 2440 2940 0 0 {name=l513 lab=VSS}
C {devices/lab_pin.sym} 1980 2880 0 0 {name=l514 lab=VDD}
C {devices/lab_pin.sym} 1930 2920 0 0 {name=l515 lab=DINB}
C {devices/lab_pin.sym} 1930 2960 0 0 {name=l516 lab=WRITE_EN}
C {devices/lab_pin.sym} 1980 3000 0 0 {name=l517 lab=VSS}
C {devices/lab_pin.sym} 3700 2500 0 0 {name=l518 lab=PREB}
C {devices/lab_pin.sym} 3740 2470 0 0 {name=l519 lab=VDD}
C {devices/lab_pin.sym} 3740 2500 0 0 {name=l520 lab=VDD}
C {devices/lab_pin.sym} 3740 2970 0 0 {name=l521 lab=VSS}
C {devices/lab_pin.sym} 3740 2940 0 0 {name=l522 lab=VSS}
C {devices/lab_pin.sym} 3280 2880 0 0 {name=l523 lab=VDD}
C {devices/lab_pin.sym} 3230 2920 0 0 {name=l524 lab=DIN}
C {devices/lab_pin.sym} 3230 2960 0 0 {name=l525 lab=WRITE_EN}
C {devices/lab_pin.sym} 3280 3000 0 0 {name=l526 lab=VSS}
C {devices/lab_pin.sym} -160 1920 0 0 {name=l527 lab=CLK}
C {devices/lab_pin.sym} -160 1980 0 0 {name=l528 lab=RESET}
C {devices/lab_pin.sym} -160 2040 0 0 {name=l529 lab=SDI}
C {devices/lab_pin.sym} -160 2100 0 0 {name=l530 lab=WE}
C {devices/lab_pin.sym} -160 2160 0 0 {name=l531 lab=SOUT}
C {devices/lab_pin.sym} 160 1320 2 0 {name=l532 lab=DIN}
C {devices/lab_pin.sym} 160 1380 2 0 {name=l533 lab=DINB}
C {devices/lab_pin.sym} 160 1440 2 0 {name=l534 lab=CA0}
C {devices/lab_pin.sym} 160 1500 2 0 {name=l535 lab=CA0B}
C {devices/lab_pin.sym} 160 1560 2 0 {name=l536 lab=CA1}
C {devices/lab_pin.sym} 160 1620 2 0 {name=l537 lab=CA1B}
C {devices/lab_pin.sym} 160 1680 2 0 {name=l538 lab=CA2}
C {devices/lab_pin.sym} 160 1740 2 0 {name=l539 lab=CA2B}
C {devices/lab_pin.sym} 160 1800 2 0 {name=l540 lab=CA3}
C {devices/lab_pin.sym} 160 1860 2 0 {name=l541 lab=CA3B}
C {devices/lab_pin.sym} 160 1920 2 0 {name=l542 lab=CA4}
C {devices/lab_pin.sym} 160 1980 2 0 {name=l543 lab=CA4B}
C {devices/lab_pin.sym} 160 2040 2 0 {name=l544 lab=RA0}
C {devices/lab_pin.sym} 160 2100 2 0 {name=l545 lab=RA0B}
C {devices/noconn.sym} 160 2100 0 0 {name=nc546}
C {devices/lab_pin.sym} 160 2160 2 0 {name=l547 lab=RA1}
C {devices/lab_pin.sym} 160 2220 2 0 {name=l548 lab=RA1B}
C {devices/noconn.sym} 160 2220 0 0 {name=nc549}
C {devices/lab_pin.sym} 160 2280 2 0 {name=l550 lab=RA2}
C {devices/lab_pin.sym} 160 2340 2 0 {name=l551 lab=RA2B}
C {devices/noconn.sym} 160 2340 0 0 {name=nc552}
C {devices/lab_pin.sym} 160 2400 2 0 {name=l553 lab=RA3}
C {devices/lab_pin.sym} 160 2460 2 0 {name=l554 lab=RA3B}
C {devices/noconn.sym} 160 2460 0 0 {name=nc555}
C {devices/lab_pin.sym} 160 2520 2 0 {name=l556 lab=PREB}
C {devices/lab_pin.sym} 160 2580 2 0 {name=l557 lab=SAE}
C {devices/lab_pin.sym} 160 2640 2 0 {name=l558 lab=WL_EN}
C {devices/lab_pin.sym} 160 2700 2 0 {name=l559 lab=WRITE_EN}
C {devices/lab_pin.sym} 160 2760 2 0 {name=l560 lab=SDO}
C {devices/lab_pin.sym} 0 1220 0 0 {name=l561 lab=VDD}
C {devices/lab_pin.sym} 0 2860 0 0 {name=l562 lab=VSS}
C {devices/lab_pin.sym} -1200 980 0 0 {name=l563 lab=CLK}
C {devices/lab_pin.sym} -1100 860 0 0 {name=l564 lab=VDD}
C {devices/lab_pin.sym} -1100 1100 0 0 {name=l565 lab=VSS}
C {devices/lab_pin.sym} -780 980 0 0 {name=l566 lab=RESET}
C {devices/lab_pin.sym} -680 860 0 0 {name=l567 lab=VDD}
C {devices/lab_pin.sym} -680 1100 0 0 {name=l568 lab=VSS}
C {devices/lab_pin.sym} -360 980 0 0 {name=l569 lab=SDI}
C {devices/lab_pin.sym} -260 860 0 0 {name=l570 lab=VDD}
C {devices/lab_pin.sym} -260 1100 0 0 {name=l571 lab=VSS}
C {devices/lab_pin.sym} 60 980 0 0 {name=l572 lab=WE}
C {devices/lab_pin.sym} 160 860 0 0 {name=l573 lab=VDD}
C {devices/lab_pin.sym} 160 1100 0 0 {name=l574 lab=VSS}
