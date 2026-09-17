v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -990 -890 -950 -890 {lab=VDD}
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
N 320 -470 440 -470 {lab=D_D}
N 280 -520 360 -520 {lab=#net1}
N 480 -570 490 -570 {lab=VDD}
N 560 -640 560 -570 {lab=VDD}
N 480 -640 560 -640 {lab=VDD}
N 200 -570 280 -570 {lab=VDD}
N 200 -640 200 -570 {lab=VDD}
N 200 -640 280 -640 {lab=VDD}
N 280 -440 280 -400 {lab=D_D}
N 480 -440 480 -400 {lab=OUT1}
N 360 -570 360 -520 {lab=#net1}
N 280 -420 360 -420 {lab=D_D}
N 360 -470 360 -420 {lab=D_D}
N 480 -470 560 -470 {lab=VDD}
N 560 -570 560 -470 {lab=VDD}
N 200 -470 280 -470 {lab=VDD}
N 200 -570 200 -470 {lab=VDD}
N 480 -420 580 -420 {lab=OUT1}
N 490 -570 560 -570 {lab=VDD}
N -570 -830 -530 -830 {lab=D_D}
N -570 -670 -530 -670 {lab=VB4}
N 900 -650 900 -610 {lab=VDD}
N 900 -580 980 -580 {lab=VDD}
N 980 -630 980 -580 {lab=VDD}
N 900 -630 980 -630 {lab=VDD}
N 900 -550 900 -510 {lab=#net4}
N 900 -480 980 -480 {lab=VDD}
N 980 -580 980 -480 {lab=VDD}
N 820 -580 860 -580 {lab=VB4}
N 820 -480 860 -480 {lab=iB}
N 900 -450 900 -410 {lab=D_D_OUT}
N -570 -870 -530 -870 {lab=D_D_OUT}
N 1220 -520 1220 -460 {
lab=VOUT}
N 1220 -620 1220 -600 {
lab=VDD}
N 1220 -490 1260 -490 {
lab=VOUT}
N 1220 -570 1240 -570 {
lab=VDD}
N 1240 -610 1240 -570 {
lab=VDD}
N 1220 -610 1240 -610 {
lab=VDD}
N 1150 -570 1180 -570 {
lab=iB}
N 1220 -640 1220 -620 {
lab=VDD}
N 1220 -540 1220 -520 {lab=VOUT}
N -570 -900 -530 -900 {lab=VOUT}
N -750 -420 -730 -420 {lab=VDD}
N -690 -420 -670 -420 {lab=VDD}
N -670 -470 -670 -420 {lab=VDD}
N -730 -470 -670 -470 {lab=VDD}
N -730 -470 -730 -450 {lab=VDD}
N -750 -470 -730 -470 {lab=VDD}
N -730 -390 -730 -370 {lab=D_D}
N -750 -470 -750 -420 {lab=VDD}
N -750 -280 -730 -280 {lab=VDD}
N -690 -280 -670 -280 {lab=VDD}
N -670 -330 -670 -280 {lab=VDD}
N -730 -330 -670 -330 {lab=VDD}
N -730 -330 -730 -310 {lab=VDD}
N -750 -330 -730 -330 {lab=VDD}
N -730 -250 -730 -230 {lab=VDD}
N -750 -330 -750 -280 {lab=VDD}
N -750 -230 -730 -230 {lab=VDD}
N -750 -280 -750 -230 {lab=VDD}
N -570 -790 -530 -790 {lab=iB}
C {devices/lab_pin.sym} -950 -890 0 1 {name=p11 sig_type=std_logic lab=VDD}
C {devices/iopin.sym} -990 -890 0 1 {name=p15 lab=VDD}
C {devices/opin.sym} -530 -750 0 0 {name=p8 lab=OUT1}
C {devices/lab_pin.sym} -570 -750 0 0 {name=p58 sig_type=std_logic lab=OUT1}
C {MP.sym} 440 -570 0 0 {name=MM2 model=PMOS w=240u l=8u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MP.sym} 320 -570 0 1 {name=MM16 model=PMOS w=240u l=8u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MP.sym} 440 -470 0 0 {name=MM17 model=PMOS w=240u l=8u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MP.sym} 320 -470 0 1 {name=MM18 model=PMOS w=240u l=8u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {devices/lab_pin.sym} 580 -420 0 1 {name=p3 sig_type=std_logic lab=OUT1}
C {devices/lab_pin.sym} 380 -680 0 1 {name=p4 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 280 -400 0 0 {name=p1 sig_type=std_logic lab=D_D}
C {devices/ipin.sym} -530 -830 0 1 {name=p5 lab=D_D}
C {devices/lab_pin.sym} -570 -830 0 0 {name=p6 sig_type=std_logic lab=D_D}
C {devices/ipin.sym} -530 -670 0 1 {name=p10 lab=VB4}
C {devices/lab_pin.sym} -570 -670 0 0 {name=p12 sig_type=std_logic lab=VB4}
C {devices/lab_pin.sym} 900 -650 0 1 {name=p13 sig_type=std_logic lab=VDD}
C {MP.sym} 860 -480 0 0 {name=MM1 model=PMOS w=240u l=8u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MP.sym} 860 -580 0 0 {name=MM9 model=PMOS w=240u l=8u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {devices/lab_pin.sym} 820 -580 0 0 {name=p14 sig_type=std_logic lab=VB4}
C {devices/lab_pin.sym} 820 -480 0 0 {name=p16 sig_type=std_logic lab=iB}
C {devices/lab_pin.sym} 900 -410 0 1 {name=p17 sig_type=std_logic lab=D_D_OUT}
C {devices/ipin.sym} -530 -870 0 1 {name=p18 lab=D_D_OUT}
C {devices/lab_pin.sym} -570 -870 0 0 {name=p19 sig_type=std_logic lab=D_D_OUT}
C {MP.sym} 1180 -570 0 0 {name=MM7 model=PMOS w=2400u l=8u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {devices/lab_pin.sym} 1150 -570 0 0 {name=p20 sig_type=std_logic lab=iB}
C {devices/lab_pin.sym} 1220 -640 0 1 {name=p21 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 1260 -490 0 1 {name=p37 sig_type=std_logic lab=VOUT}
C {devices/opin.sym} -530 -900 0 0 {name=p22 lab=VOUT}
C {devices/lab_pin.sym} -570 -900 0 0 {name=p45 sig_type=std_logic lab=VOUT}
C {MP.sym} -690 -420 0 1 {name=MDMYP2 model=PMOS w=20u l=8u m=4 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0 spiceprefix=X}
C {devices/lab_wire.sym} -670 -470 0 1 {name=p24 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} -730 -370 0 0 {name=p26 sig_type=std_logic lab=D_D}
C {MP.sym} -690 -280 0 1 {name=MDMYP3 model=PMOS w=60u l=8u m=4 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0 spiceprefix=X}
C {devices/lab_wire.sym} -670 -330 0 1 {name=p29 sig_type=std_logic lab=VDD}
C {devices/ipin.sym} -530 -790 0 1 {name=p25 lab=iB}
C {devices/lab_pin.sym} -570 -790 0 0 {name=p57 sig_type=std_logic lab=iB}
