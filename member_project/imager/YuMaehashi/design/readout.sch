v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
P 4 5 1490 -450 1490 -330 1570 -330 1570 -450 1490 -450 {}
T {Dummy} 1510 -470 0 0 0.2 0.2 {}
N 400 -280 1540 -280 {lab=MEMOUT}
N 80 -260 1480 -260 {lab=VSS}
N 80 -420 1080 -420 {lab=VDD}
N 400 -400 1420 -400 {lab=IIN}
N 260 -500 260 -460 {lab=VL_0}
N 200 -220 200 -180 {lab=P_RDN_0}
N 580 -500 580 -460 {lab=VL_1}
N 900 -500 900 -460 {lab=VL_2}
N 1220 -500 1220 -460 {lab=VL_3}
N 220 -220 220 -180 {lab=P_RDN_B_0}
N 240 -220 240 -180 {lab=P_WRTN_0}
N 260 -220 260 -180 {lab=P_WRTN_B_0}
N 300 -220 300 -180 {lab=P_RDS_0}
N 320 -220 320 -180 {lab=P_RDS_B_0}
N 340 -220 340 -180 {lab=P_WRTS_0}
N 360 -220 360 -180 {lab=P_WRTS_B_0}
N 520 -220 520 -180 {lab=P_RDN_1}
N 540 -220 540 -180 {lab=P_RDN_B_1}
N 560 -220 560 -180 {lab=P_WRTN_1}
N 580 -220 580 -180 {lab=P_WRTN_B_1}
N 620 -220 620 -180 {lab=P_RDS_1}
N 640 -220 640 -180 {lab=P_RDS_B_1}
N 660 -220 660 -180 {lab=P_WRTS_1}
N 680 -220 680 -180 {lab=P_WRTS_B_1}
N 840 -220 840 -180 {lab=P_RDN_2}
N 860 -220 860 -180 {lab=P_RDN_B_2}
N 880 -220 880 -180 {lab=P_WRTN_2}
N 900 -220 900 -180 {lab=P_WRTN_B_2}
N 940 -220 940 -180 {lab=P_RDS_2}
N 960 -220 960 -180 {lab=P_RDS_B_2}
N 980 -220 980 -180 {lab=P_WRTS_2}
N 1000 -220 1000 -180 {lab=P_WRTS_B_2}
N 1160 -220 1160 -180 {lab=P_RDN_3}
N 1180 -220 1180 -180 {lab=P_RDN_B_3}
N 1200 -220 1200 -180 {lab=P_WRTN_3}
N 1220 -220 1220 -180 {lab=P_WRTN_B_3}
N 1260 -220 1260 -180 {lab=P_RDS_3}
N 1280 -220 1280 -180 {lab=P_RDS_B_3}
N 1300 -220 1300 -180 {lab=P_WRTS_3}
N 1320 -220 1320 -180 {lab=P_WRTS_B_3}
N 1460 -370 1460 -260 {lab=VSS}
N 1460 -400 1480 -400 {lab=VSS}
N 1480 -400 1480 -260 {lab=VSS}
N 1460 -500 1460 -430 {lab=IIN}
N 1400 -460 1400 -400 {lab=IIN}
N 1400 -460 1460 -460 {lab=IIN}
N 1540 -430 1560 -430 {lab=VSS}
N 1560 -430 1560 -340 {lab=VSS}
N 1480 -340 1560 -340 {lab=VSS}
N 1540 -370 1540 -340 {lab=VSS}
N 1540 -400 1560 -400 {lab=VSS}
N 1500 -400 1500 -340 {lab=VSS}
C {2026_imager/readout_unit.sym} 260 -340 0 0 {name=x1}
C {2026_imager/readout_unit.sym} 580 -340 0 0 {name=x2}
C {2026_imager/readout_unit.sym} 900 -340 0 0 {name=x3}
C {2026_imager/readout_unit.sym} 1220 -340 0 0 {name=x4}
C {devices/ipin.sym} 260 -500 1 0 {name=p1 lab=VL_0}
C {devices/iopin.sym} 80 -420 2 0 {name=p2 lab=VDD}
C {devices/iopin.sym} 80 -260 2 0 {name=p3 lab=VSS}
C {devices/ipin.sym} 1460 -500 3 1 {name=p4 lab=IIN}
C {devices/opin.sym} 1540 -280 0 0 {name=p5 lab=MEMOUT}
C {devices/ipin.sym} 200 -180 3 0 {name=p38 lab=P_RDN_0}
C {devices/ipin.sym} 220 -180 3 0 {name=p39 lab=P_RDN_B_0}
C {devices/ipin.sym} 240 -180 3 0 {name=p40 lab=P_WRTN_0}
C {devices/ipin.sym} 260 -180 3 0 {name=p41 lab=P_WRTN_B_0}
C {devices/ipin.sym} 300 -180 3 0 {name=p42 lab=P_RDS_0}
C {devices/ipin.sym} 320 -180 3 0 {name=p43 lab=P_RDS_B_0}
C {devices/ipin.sym} 340 -180 3 0 {name=p44 lab=P_WRTS_0}
C {devices/ipin.sym} 360 -180 3 0 {name=p45 lab=P_WRTS_B_0}
C {devices/ipin.sym} 580 -500 1 0 {name=p6 lab=VL_1}
C {devices/ipin.sym} 900 -500 1 0 {name=p7 lab=VL_2}
C {devices/ipin.sym} 1220 -500 1 0 {name=p8 lab=VL_3}
C {devices/ipin.sym} 520 -180 3 0 {name=p9 lab=P_RDN_1}
C {devices/ipin.sym} 540 -180 3 0 {name=p10 lab=P_RDN_B_1}
C {devices/ipin.sym} 560 -180 3 0 {name=p11 lab=P_WRTN_1}
C {devices/ipin.sym} 580 -180 3 0 {name=p12 lab=P_WRTN_B_1}
C {devices/ipin.sym} 620 -180 3 0 {name=p13 lab=P_RDS_1}
C {devices/ipin.sym} 640 -180 3 0 {name=p14 lab=P_RDS_B_1}
C {devices/ipin.sym} 660 -180 3 0 {name=p15 lab=P_WRTS_1}
C {devices/ipin.sym} 680 -180 3 0 {name=p16 lab=P_WRTS_B_1}
C {devices/ipin.sym} 840 -180 3 0 {name=p17 lab=P_RDN_2}
C {devices/ipin.sym} 860 -180 3 0 {name=p18 lab=P_RDN_B_2}
C {devices/ipin.sym} 880 -180 3 0 {name=p19 lab=P_WRTN_2}
C {devices/ipin.sym} 900 -180 3 0 {name=p20 lab=P_WRTN_B_2}
C {devices/ipin.sym} 940 -180 3 0 {name=p21 lab=P_RDS_2}
C {devices/ipin.sym} 960 -180 3 0 {name=p22 lab=P_RDS_B_2}
C {devices/ipin.sym} 980 -180 3 0 {name=p23 lab=P_WRTS_2}
C {devices/ipin.sym} 1000 -180 3 0 {name=p24 lab=P_WRTS_B_2}
C {devices/ipin.sym} 1160 -180 3 0 {name=p25 lab=P_RDN_3}
C {devices/ipin.sym} 1180 -180 3 0 {name=p26 lab=P_RDN_B_3}
C {devices/ipin.sym} 1200 -180 3 0 {name=p27 lab=P_WRTN_3}
C {devices/ipin.sym} 1220 -180 3 0 {name=p28 lab=P_WRTN_B_3}
C {devices/ipin.sym} 1260 -180 3 0 {name=p29 lab=P_RDS_3}
C {devices/ipin.sym} 1280 -180 3 0 {name=p30 lab=P_RDS_B_3}
C {devices/ipin.sym} 1300 -180 3 0 {name=p31 lab=P_WRTS_3}
C {devices/ipin.sym} 1320 -180 3 0 {name=p32 lab=P_WRTS_B_3}
C {TR-1umLIB/MN.sym} 1420 -400 0 0 {name=XM1
model=NMOS
w=10u
l=4u
m=8
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MN.sym} 1500 -400 0 0 {name=XM2
model=NMOS
w=10u
l=4u
m=2
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
