v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {Current mirror} 30 -820 0 0 1 1 {}
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
N 180 -610 280 -610 {lab=VB}
N 140 -580 140 -540 {lab=VB}
N 180 -510 280 -510 {lab=iB}
N 140 -560 200 -560 {lab=VB}
N 200 -610 200 -560 {lab=VB}
N 140 -480 140 -420 {lab=iB}
N 140 -680 140 -640 {lab=VDD}
N 240 -610 240 -560 {lab=VB}
N 60 -610 140 -610 {lab=VDD}
N 60 -660 60 -610 {lab=VDD}
N 60 -660 140 -660 {lab=VDD}
N 60 -510 140 -510 {lab=VDD}
N 60 -610 60 -510 {lab=VDD}
N 320 -440 320 -420 {lab=VB2}
N 320 -440 400 -440 {lab=VB2}
N 400 -440 400 -390 {lab=VB2}
N 240 -390 320 -390 {lab=VSS}
N 240 -390 240 -290 {lab=VSS}
N 720 -720 760 -720 {lab=VDD}
N 720 -680 760 -680 {lab=VSS}
N 720 -640 760 -640 {lab=VB}
N 140 -260 140 -200 {lab=VSS}
N 140 -340 220 -340 {lab=#net2}
N 180 -290 220 -290 {lab=#net2}
N 60 -290 140 -290 {lab=VSS}
N 60 -290 60 -220 {lab=VSS}
N 60 -220 140 -220 {lab=VSS}
N 220 -340 220 -290 {lab=#net2}
N 140 -360 140 -320 {lab=#net2}
N 60 -390 140 -390 {lab=VSS}
N 60 -390 60 -290 {lab=VSS}
N 180 -390 200 -390 {lab=iB}
N 200 -460 200 -390 {lab=iB}
N 200 -510 200 -460 {lab=iB}
N 720 -610 760 -610 {lab=VB1}
N 720 -580 760 -580 {lab=VB2}
N -410 -290 -390 -290 {lab=VDD}
N -350 -290 -330 -290 {lab=VDD}
N -330 -340 -330 -290 {lab=VDD}
N -390 -340 -330 -340 {lab=VDD}
N -390 -340 -390 -320 {lab=VDD}
N -410 -340 -390 -340 {lab=VDD}
N -390 -260 -390 -240 {lab=iB}
N -410 -340 -410 -290 {lab=VDD}
N -250 -280 -230 -280 {lab=VSS}
N -250 -280 -250 -230 {lab=VSS}
N -250 -230 -190 -230 {lab=VSS}
N -190 -250 -190 -230 {lab=VSS}
N -190 -280 -170 -280 {lab=VSS}
N -170 -280 -170 -230 {lab=VSS}
N -190 -230 -170 -230 {lab=VSS}
N -190 -330 -190 -310 {lab=iB}
N 140 -660 320 -660 {lab=VDD}
N 140 -220 240 -220 {lab=VSS}
N 140 -450 200 -450 {lab=iB}
C {MN.sym} 360 -390 0 1 {name=MM13 model=NMOS w=84u l=8u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MN.sym} 360 -290 0 1 {name=MM14 model=NMOS w=84u l=8u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {devices/lab_pin.sym} 320 -200 0 1 {name=p18 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 320 -680 0 1 {name=p30 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 440 -290 0 1 {name=p31 sig_type=std_logic lab=VB1}
C {devices/lab_pin.sym} 440 -390 0 1 {name=p32 sig_type=std_logic lab=VB2}
C {MP.sym} 180 -610 0 1 {name=MM23 model=PMOS w=240u l=8u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MP.sym} 280 -510 0 0 {name=MM24 model=PMOS w=240u l=8u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MP.sym} 280 -610 0 0 {name=MM25 model=PMOS w=240u l=8u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MP.sym} 180 -510 0 1 {name=MM26 model=PMOS w=240u l=8u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {devices/lab_pin.sym} 140 -680 0 1 {name=p34 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 240 -560 0 1 {name=p40 sig_type=std_logic lab=VB}
C {devices/lab_pin.sym} 760 -720 0 1 {name=p11 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 760 -680 0 1 {name=p12 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 760 -640 0 1 {name=p13 sig_type=std_logic lab=VB}
C {devices/iopin.sym} 720 -720 0 1 {name=p15 lab=VDD}
C {devices/iopin.sym} 720 -680 0 1 {name=p16 lab=VSS}
C {devices/ipin.sym} 720 -640 0 0 {name=p17 lab=VB}
C {MN.sym} 180 -390 0 1 {name=MM5 model=NMOS w=84u l=8u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MN.sym} 180 -290 0 1 {name=MM6 model=NMOS w=84u l=8u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {devices/lab_pin.sym} 140 -200 0 1 {name=p5 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 760 -610 0 1 {name=p1 sig_type=std_logic lab=VB1}
C {devices/opin.sym} 720 -610 0 1 {name=p2 lab=VB1}
C {devices/lab_pin.sym} 760 -580 0 1 {name=p3 sig_type=std_logic lab=VB2}
C {devices/opin.sym} 720 -580 0 1 {name=p4 lab=VB2}
C {MP.sym} -350 -290 0 1 {name=MDMYP1 model=PMOS w=20u l=8u m=4 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0 spiceprefix=X}
C {devices/lab_wire.sym} -330 -340 0 1 {name=p55 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} -390 -240 0 0 {name=p56 sig_type=std_logic lab=iB}
C {devices/lab_pin.sym} 140 -450 0 0 {name=p6 sig_type=std_logic lab=iB}
C {MN.sym} -230 -280 0 0 {name=MDMYN7 model=NMOS w=7u l=8u m=4 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0 spiceprefix=X}
C {devices/lab_wire.sym} -250 -230 0 0 {name=p65 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} -190 -330 0 0 {name=p66 sig_type=std_logic lab=iB}
