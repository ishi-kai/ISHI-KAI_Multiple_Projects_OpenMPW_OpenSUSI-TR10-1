v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 1450 -400 1450 -280 {lab=IN0}
N 1510 -400 1510 -280 {lab=OUT}
N 1610 -400 1610 -280 {lab=IN1}
N 1670 -400 1670 -280 {lab=OUT}
N 1770 -400 1770 -280 {lab=IN2}
N 1830 -400 1830 -280 {lab=OUT}
N 170 -820 190 -820 {lab=VDD}
N 170 -740 190 -740 {lab=VSS}
N 240 -780 280 -780 {lab=#net1}
N 330 -820 350 -820 {lab=VDD}
N 330 -740 350 -740 {lab=VSS}
N 400 -780 560 -780 {lab=sel1i}
N 260 -780 260 -720 {lab=#net1}
N 260 -720 540 -720 {lab=#net1}
N 170 -680 190 -680 {lab=VDD}
N 170 -600 190 -600 {lab=VSS}
N 330 -680 350 -680 {lab=VDD}
N 330 -600 350 -600 {lab=VSS}
N 240 -640 280 -640 {lab=#net2}
N 400 -640 520 -640 {lab=#net3}
N 260 -640 260 -580 {lab=#net2}
N 260 -580 500 -580 {lab=#net2}
N 80 -780 120 -780 {lab=SEL1}
N 80 -640 120 -640 {lab=SEL0}
N 720 -580 740 -580 {lab=VDD}
N 720 -460 740 -460 {lab=VSS}
N 500 -580 500 -140 {lab=#net2}
N 520 -640 520 -140 {lab=#net3}
N 540 -720 540 -140 {lab=#net1}
N 560 -780 560 -140 {lab=sel1i}
N 910 -560 930 -560 {lab=VDD}
N 910 -480 930 -480 {lab=VSS}
N 820 -520 860 -520 {lab=#net4}
N 840 -520 840 -460 {lab=#net4}
N 840 -460 1480 -460 {lab=#net4}
N 980 -520 1080 -520 {lab=in0sel}
N 540 -540 670 -540 {lab=#net1}
N 640 -500 670 -500 {lab=#net1}
N 640 -540 640 -500 {lab=#net1}
N 720 -420 740 -420 {lab=VDD}
N 720 -300 740 -300 {lab=VSS}
N 910 -400 930 -400 {lab=VDD}
N 910 -320 930 -320 {lab=VSS}
N 820 -360 860 -360 {lab=#net5}
N 840 -360 840 -300 {lab=#net5}
N 840 -300 1020 -300 {lab=#net5}
N 980 -360 1060 -360 {lab=in1sel}
N 560 -380 670 -380 {lab=sel1i}
N 500 -340 670 -340 {lab=#net2}
N 720 -260 740 -260 {lab=VDD}
N 720 -140 740 -140 {lab=VSS}
N 910 -240 930 -240 {lab=VDD}
N 910 -160 930 -160 {lab=VSS}
N 820 -200 860 -200 {lab=#net6}
N 840 -200 840 -140 {lab=#net6}
N 840 -140 1040 -140 {lab=#net6}
N 980 -200 1800 -200 {lab=in2sel}
N 560 -220 670 -220 {lab=sel1i}
N 520 -180 670 -180 {lab=#net3}
N 1640 -240 1640 -220 {lab=in1sel}
N 1800 -240 1800 -200 {lab=in2sel}
N 1480 -300 1480 -280 {lab=VSS}
N 1640 -300 1640 -280 {lab=VSS}
N 1800 -300 1800 -280 {lab=VSS}
N 1480 -400 1480 -380 {lab=VDD}
N 1640 -400 1640 -380 {lab=VDD}
N 1800 -400 1800 -380 {lab=VDD}
N 1040 -540 1040 -140 {lab=#net6}
N 1040 -540 1800 -540 {lab=#net6}
N 1800 -540 1800 -440 {lab=#net6}
N 1640 -480 1640 -440 {lab=#net5}
N 1480 -460 1480 -440 {lab=#net4}
N 1420 -340 1450 -340 {lab=IN0}
N 1420 -340 1420 -60 {lab=IN0}
N 1510 -340 1540 -340 {lab=OUT}
N 1540 -600 1540 -340 {lab=OUT}
N 1580 -340 1610 -340 {lab=IN1}
N 1580 -340 1580 -60 {lab=IN1}
N 1670 -340 1700 -340 {lab=OUT}
N 1700 -600 1700 -340 {lab=OUT}
N 1740 -340 1770 -340 {lab=IN2}
N 1740 -340 1740 -60 {lab=IN2}
N 1830 -340 1860 -340 {lab=OUT}
N 1860 -600 1860 -340 {lab=OUT}
N 1540 -600 1860 -600 {lab=OUT}
N 1700 -640 1700 -600 {lab=OUT}
N 1060 -360 1060 -220 {lab=in1sel}
N 1060 -220 1640 -220 {lab=in1sel}
N 1080 -520 1080 -240 {lab=in0sel}
N 1080 -240 1480 -240 {lab=in0sel}
N 1020 -480 1640 -480 {lab=#net5}
N 1020 -480 1020 -300 {lab=#net5}
C {MN.sym} 1480 -240 1 1 {name=XM1
model=NMOS
w=3.4u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {MP.sym} 1480 -440 1 0 {name=XM2
model=PMOS
w=10.2u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {MN.sym} 1640 -240 1 1 {name=XM4
model=NMOS
w=3.4u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {MP.sym} 1640 -440 1 0 {name=XM5
model=PMOS
w=10.2u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {MN.sym} 1800 -240 1 1 {name=XM6
model=NMOS
w=3.4u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {MP.sym} 1800 -440 1 0 {name=XM7
model=PMOS
w=10.2u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {IP62_5_stdcell/INV_X1.sym} 140 -780 0 0 {name=x1}
C {IP62_5_stdcell/INV_X1.sym} 300 -780 0 0 {name=x2}
C {devices/iopin.sym} 80 -820 0 1 {name=p1 lab=VDD}
C {devices/lab_wire.sym} 170 -820 0 1 {name=p2 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} 170 -740 2 0 {name=p3 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 330 -820 0 1 {name=p6 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} 330 -740 2 0 {name=p7 sig_type=std_logic lab=VSS}
C {devices/ipin.sym} 80 -780 0 0 {name=p8 lab=SEL1}
C {IP62_5_stdcell/INV_X1.sym} 140 -640 0 0 {name=x3}
C {IP62_5_stdcell/INV_X1.sym} 300 -640 0 0 {name=x4}
C {devices/lab_wire.sym} 170 -680 0 1 {name=p9 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} 170 -600 2 0 {name=p10 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 330 -680 0 1 {name=p11 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} 330 -600 2 0 {name=p12 sig_type=std_logic lab=VSS}
C {devices/iopin.sym} 80 -600 0 1 {name=p13 lab=VSS}
C {IP62_5_stdcell/NAND2.sym} 690 -520 0 0 {name=x5}
C {devices/lab_wire.sym} 720 -580 0 1 {name=p14 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} 720 -460 2 0 {name=p15 sig_type=std_logic lab=VSS}
C {IP62_5_stdcell/INV_X1.sym} 880 -520 0 0 {name=x6}
C {devices/lab_wire.sym} 910 -560 0 1 {name=p16 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} 910 -480 2 0 {name=p17 sig_type=std_logic lab=VSS}
C {IP62_5_stdcell/NAND2.sym} 690 -360 0 0 {name=x7}
C {devices/lab_wire.sym} 720 -420 0 1 {name=p18 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} 720 -300 2 0 {name=p19 sig_type=std_logic lab=VSS}
C {IP62_5_stdcell/INV_X1.sym} 880 -360 0 0 {name=x8}
C {devices/lab_wire.sym} 910 -400 0 1 {name=p20 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} 910 -320 2 0 {name=p21 sig_type=std_logic lab=VSS}
C {IP62_5_stdcell/NAND2.sym} 690 -200 0 0 {name=x9}
C {devices/lab_wire.sym} 720 -260 0 1 {name=p22 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} 720 -140 2 0 {name=p23 sig_type=std_logic lab=VSS}
C {IP62_5_stdcell/INV_X1.sym} 880 -200 0 0 {name=x10}
C {devices/lab_wire.sym} 910 -240 0 1 {name=p24 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} 910 -160 2 0 {name=p25 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 1480 -290 3 1 {name=p27 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 1640 -290 3 1 {name=p28 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 1800 -290 3 1 {name=p29 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 1480 -390 3 0 {name=p30 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} 1640 -390 3 0 {name=p31 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} 1800 -390 3 0 {name=p32 sig_type=std_logic lab=VDD}
C {devices/ipin.sym} 1420 -60 3 0 {name=p34 lab=IN0}
C {devices/ipin.sym} 1580 -60 3 0 {name=p35 lab=IN1}
C {devices/ipin.sym} 1740 -60 3 0 {name=p36 lab=IN2}
C {devices/opin.sym} 1700 -640 3 0 {name=p37 lab=OUT}
C {devices/ipin.sym} 80 -640 0 0 {name=p4 lab=SEL0}
C {devices/lab_wire.sym} 1120 -240 0 1 {name=p5 sig_type=std_logic lab=in0sel}
C {devices/lab_wire.sym} 1120 -220 0 1 {name=p26 sig_type=std_logic lab=in1sel}
C {devices/lab_wire.sym} 1120 -200 0 1 {name=p33 sig_type=std_logic lab=in2sel}
C {devices/lab_wire.sym} 480 -780 0 1 {name=p38 sig_type=std_logic lab=sel1i}
C {devices/lab_wire.sym} 480 -640 0 1 {name=p39 sig_type=std_logic lab=sel0i}
