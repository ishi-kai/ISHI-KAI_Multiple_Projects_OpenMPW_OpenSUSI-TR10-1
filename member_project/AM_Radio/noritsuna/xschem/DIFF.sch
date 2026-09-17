v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -990 -890 -950 -890 {lab=VDD}
N -990 -850 -950 -850 {lab=VSS}
N -800 -770 -760 -770 {lab=VB1}
N -800 -730 -760 -730 {lab=iB2}
N -570 -830 -530 -830 {lab=VIN_P}
N -570 -790 -530 -790 {lab=VIN_N}
N -570 -750 -530 -750 {lab=OUT1}
N 280 -640 280 -620 {lab=VDD}
N 280 -640 480 -640 {lab=VDD}
N 480 -640 480 -620 {lab=VDD}
N 380 -680 380 -640 {lab=VDD}
N 320 -570 440 -570 {lab=#net1}
N 280 -620 280 -600 {lab=VDD}
N 480 -620 480 -600 {lab=VDD}
N 280 -540 280 -500 {lab=#net1}
N 480 -540 480 -500 {lab=#net2}
N 320 -470 440 -470 {lab=#net3}
N 280 -520 360 -520 {lab=#net1}
N 480 -570 490 -570 {lab=VDD}
N 560 -640 560 -570 {lab=VDD}
N 480 -640 560 -640 {lab=VDD}
N 200 -570 280 -570 {lab=VDD}
N 200 -640 200 -570 {lab=VDD}
N 200 -640 280 -640 {lab=VDD}
N 280 -440 280 -400 {lab=#net3}
N 480 -440 480 -400 {lab=OUT1}
N 360 -570 360 -520 {lab=#net1}
N 280 -420 360 -420 {lab=#net3}
N 360 -470 360 -420 {lab=#net3}
N 320 -370 440 -370 {lab=VB2}
N 380 -370 380 -340 {lab=VB2}
N 480 -370 520 -370 {lab=VSS}
N 480 -470 560 -470 {lab=VDD}
N 560 -570 560 -470 {lab=VDD}
N 200 -470 280 -470 {lab=VDD}
N 200 -570 200 -470 {lab=VDD}
N 240 -370 280 -370 {lab=VSS}
N 280 -340 280 -300 {lab=#net4}
N 480 -340 480 -300 {lab=#net5}
N 280 -270 330 -270 {lab=VSS}
N 330 -270 480 -270 {lab=VSS}
N 370 -270 370 -240 {lab=VSS}
N 200 -270 240 -270 {lab=VIN_N}
N 520 -270 560 -270 {lab=VIN_P}
N 280 -240 280 -180 {lab=#net6}
N 280 -180 480 -180 {lab=#net6}
N 480 -240 480 -180 {lab=#net6}
N 380 -180 380 -160 {lab=#net6}
N 380 -130 410 -130 {lab=VSS}
N 310 -130 340 -130 {lab=VB1}
N 380 -100 380 -40 {lab=VSS}
N 480 -420 580 -420 {lab=OUT1}
N 490 -570 560 -570 {lab=VDD}
C {devices/lab_pin.sym} -760 -730 0 1 {name=p10 sig_type=std_logic lab=VB2}
C {devices/lab_pin.sym} -950 -890 0 1 {name=p11 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} -950 -850 0 1 {name=p12 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} -760 -770 0 1 {name=p14 sig_type=std_logic lab=VB1}
C {devices/iopin.sym} -990 -890 0 1 {name=p15 lab=VDD}
C {devices/iopin.sym} -990 -850 0 1 {name=p16 lab=VSS}
C {devices/iopin.sym} -800 -770 0 1 {name=p19 lab=VB1}
C {devices/iopin.sym} -800 -730 0 1 {name=p20 lab=VB2}
C {devices/opin.sym} -530 -750 0 0 {name=p8 lab=OUT1}
C {devices/ipin.sym} -530 -790 0 1 {name=p25 lab=VIN_N}
C {devices/ipin.sym} -530 -830 0 1 {name=p26 lab=VIN_P}
C {devices/lab_pin.sym} -570 -830 0 0 {name=p56 sig_type=std_logic lab=VIN_P}
C {devices/lab_pin.sym} -570 -790 0 0 {name=p57 sig_type=std_logic lab=VIN_N}
C {devices/lab_pin.sym} -570 -750 0 0 {name=p58 sig_type=std_logic lab=OUT1}
C {MP.sym} 440 -570 0 0 {name=MM2 model=PMOS w=240u l=8u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MN.sym} 440 -370 0 0 {name=MM4 model=NMOS w=84u l=8u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MP.sym} 320 -570 0 1 {name=MM16 model=PMOS w=240u l=8u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MP.sym} 440 -470 0 0 {name=MM17 model=PMOS w=240u l=8u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MP.sym} 320 -470 0 1 {name=MM18 model=PMOS w=240u l=8u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MN.sym} 320 -370 0 1 {name=MM19 model=NMOS w=84u l=8u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MN.sym} 520 -270 0 1 {name=MM20 model=NMOS w=672u l=8u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MN.sym} 240 -270 0 0 {name=MM21 model=NMOS w=672u l=8u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {devices/lab_pin.sym} 520 -370 0 1 {name=p1 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 240 -370 0 0 {name=p21 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 380 -340 0 1 {name=p23 sig_type=std_logic lab=VB2}
C {MN.sym} 340 -130 0 0 {name=MM22 model=NMOS w=84u l=8u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {devices/lab_pin.sym} 410 -130 0 1 {name=p2 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 310 -130 0 0 {name=p27 sig_type=std_logic lab=VB1}
C {devices/lab_pin.sym} 380 -40 0 1 {name=p28 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 580 -420 0 1 {name=p3 sig_type=std_logic lab=OUT1}
C {devices/lab_pin.sym} 380 -680 0 1 {name=p4 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 200 -270 0 0 {name=p35 sig_type=std_logic lab=VIN_N}
C {devices/lab_pin.sym} 560 -270 0 1 {name=p36 sig_type=std_logic lab=VIN_P}
C {devices/lab_pin.sym} 370 -240 0 1 {name=p7 sig_type=std_logic lab=VSS}
