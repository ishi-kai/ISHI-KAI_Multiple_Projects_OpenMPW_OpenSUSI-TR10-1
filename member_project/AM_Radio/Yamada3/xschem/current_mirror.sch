v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {Current mirror} 30 -820 0 0 1 1 {}
T {To RF AMP} 630 -520 0 0 0.4 0.4 {}
T {To IDEAL DIODE} 930 -520 0 0 0.4 0.4 {}
T {To Current reference} 20 -370 0 0 0.4 0.4 {}
N 320 -260 320 -200 {lab=VSS}
N 320 -340 400 -340 {lab=VB1}
N 360 -290 400 -290 {lab=VB1}
N 240 -290 320 -290 {lab=VSS}
N 240 -290 240 -220 {lab=VSS}
N 240 -220 320 -220 {lab=VSS}
N 400 -290 440 -290 {lab=VB1}
N 360 -390 440 -390 {lab=VB2}
N 400 -340 400 -290 {lab=VB1}
N 320 -360 320 -320 {lab=VB1}
N 320 -680 320 -640 {lab=VDD}
N 320 -610 400 -610 {lab=VDD}
N 400 -660 400 -610 {lab=VDD}
N 320 -660 400 -660 {lab=VDD}
N 320 -580 320 -540 {lab=#net1}
N 320 -480 320 -440 {lab=VB2}
N 320 -510 400 -510 {lab=VDD}
N 400 -610 400 -510 {lab=VDD}
N 180 -610 280 -610 {lab=VB4}
N 140 -580 140 -540 {lab=VB4}
N 180 -510 280 -510 {lab=iB}
N 140 -560 200 -560 {lab=VB4}
N 200 -610 200 -560 {lab=VB4}
N 140 -480 140 -420 {lab=iB}
N 140 -460 200 -460 {lab=iB}
N 200 -510 200 -460 {lab=iB}
N 140 -680 140 -640 {lab=VDD}
N 240 -610 240 -560 {lab=VB4}
N 60 -610 140 -610 {lab=VDD}
N 60 -660 60 -610 {lab=VDD}
N 60 -660 140 -660 {lab=VDD}
N 60 -510 140 -510 {lab=VDD}
N 60 -610 60 -510 {lab=VDD}
N 140 -420 140 -400 {lab=iB}
N 320 -440 320 -420 {lab=VB2}
N 320 -440 400 -440 {lab=VB2}
N 400 -440 400 -390 {lab=VB2}
N 240 -390 320 -390 {lab=VSS}
N 240 -390 240 -290 {lab=VSS}
N 240 -510 240 -480 {lab=iB}
N 660 -260 660 -200 {lab=VSS}
N 580 -290 620 -290 {lab=VB1}
N 660 -290 740 -290 {lab=VSS}
N 740 -290 740 -220 {lab=VSS}
N 660 -220 740 -220 {lab=VSS}
N 540 -290 580 -290 {lab=VB1}
N 540 -390 620 -390 {lab=VB2}
N 660 -360 660 -320 {lab=#net2}
N 660 -480 660 -440 {lab=iB1}
N 660 -440 660 -420 {lab=iB1}
N 660 -390 740 -390 {lab=VSS}
N 740 -390 740 -290 {lab=VSS}
N 960 -260 960 -200 {lab=VSS}
N 880 -290 920 -290 {lab=VB1}
N 960 -290 1040 -290 {lab=VSS}
N 1040 -290 1040 -220 {lab=VSS}
N 960 -220 1040 -220 {lab=VSS}
N 840 -290 880 -290 {lab=VB1}
N 840 -390 920 -390 {lab=VB2}
N 960 -360 960 -320 {lab=#net3}
N 960 -480 960 -440 {lab=#net4}
N 960 -440 960 -420 {lab=#net4}
N 960 -390 1040 -390 {lab=VSS}
N 1040 -390 1040 -290 {lab=VSS}
N 720 -720 760 -720 {lab=VDD}
N 720 -680 760 -680 {lab=VSS}
N 720 -640 760 -640 {lab=iB}
N 720 -600 760 -600 {lab=iB1}
N 720 -560 760 -560 {lab=iB2}
C {MN.sym} 360 -390 0 1 {name=MM13 model=NMOS w=10u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MN.sym} 360 -290 0 1 {name=MM14 model=NMOS w=10u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {devices/lab_pin.sym} 320 -200 0 1 {name=p18 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 320 -680 0 1 {name=p30 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 440 -290 0 1 {name=p31 sig_type=std_logic lab=VB1}
C {devices/lab_pin.sym} 440 -390 0 1 {name=p32 sig_type=std_logic lab=VB2}
C {MP.sym} 180 -610 0 1 {name=MM23 model=PMOS w=30u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MP.sym} 280 -510 0 0 {name=MM24 model=PMOS w=30u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MP.sym} 280 -610 0 0 {name=MM25 model=PMOS w=30u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MP.sym} 180 -510 0 1 {name=MM26 model=PMOS w=30u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {devices/lab_pin.sym} 140 -680 0 1 {name=p34 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 240 -560 0 1 {name=p40 sig_type=std_logic lab=VB4}
C {devices/lab_pin.sym} 240 -480 0 1 {name=p5 sig_type=std_logic lab=iB}
C {devices/lab_pin.sym} 140 -400 0 1 {name=p8 sig_type=std_logic lab=iB}
C {MN.sym} 620 -390 0 0 {name=MM1 model=NMOS w=10u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MN.sym} 620 -290 0 0 {name=MM2 model=NMOS w=10u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {devices/lab_pin.sym} 660 -200 0 0 {name=p1 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 540 -290 0 0 {name=p2 sig_type=std_logic lab=VB1}
C {devices/lab_pin.sym} 540 -390 0 0 {name=p3 sig_type=std_logic lab=VB2}
C {MN.sym} 920 -390 0 0 {name=MM3 model=NMOS w=10u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MN.sym} 920 -290 0 0 {name=MM4 model=NMOS w=10u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {devices/lab_pin.sym} 960 -200 0 0 {name=p4 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 840 -290 0 0 {name=p6 sig_type=std_logic lab=VB1}
C {devices/lab_pin.sym} 840 -390 0 0 {name=p7 sig_type=std_logic lab=VB2}
C {devices/lab_pin.sym} 660 -480 0 1 {name=p9 sig_type=std_logic lab=iB1}
C {devices/lab_pin.sym} 760 -560 0 1 {name=p10 sig_type=std_logic lab=iB2}
C {devices/lab_pin.sym} 760 -720 0 1 {name=p11 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 760 -680 0 1 {name=p12 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 760 -640 0 1 {name=p13 sig_type=std_logic lab=iB}
C {devices/lab_pin.sym} 760 -600 0 1 {name=p14 sig_type=std_logic lab=iB1}
C {devices/iopin.sym} 720 -720 0 1 {name=p15 lab=VDD}
C {devices/iopin.sym} 720 -680 0 1 {name=p16 lab=VSS}
C {devices/iopin.sym} 720 -640 0 1 {name=p17 lab=iB}
C {devices/iopin.sym} 720 -600 0 1 {name=p19 lab=iB1}
C {devices/iopin.sym} 720 -560 0 1 {name=p20 lab=iB2}
C {devices/lab_pin.sym} 960 -480 0 1 {name=p21 sig_type=std_logic lab=iB2}
