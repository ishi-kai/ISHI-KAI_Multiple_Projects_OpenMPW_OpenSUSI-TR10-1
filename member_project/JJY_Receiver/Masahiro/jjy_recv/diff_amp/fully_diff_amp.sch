v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 450 610 500 610 {lab=vt}
N 540 640 540 670 {lab=vss}
N 540 610 590 610 {lab=vss}
N 590 610 590 670 {lab=vss}
N 540 670 590 670 {lab=vss}
N 540 390 620 390 {lab=vss}
N 540 390 540 405 {lab=vss}
N 460 420 460 480 {lab=#net1}
N 540 480 620 480 {lab=#net1}
N 620 420 620 480 {lab=#net1}
N 540 140 580 140 {lab=vb}
N 390 140 460 140 {lab=vdd}
N 620 140 690 140 {lab=vdd}
N 460 70 460 110 {lab=vdd}
N 460 70 620 70 {lab=vdd}
N 620 70 620 110 {lab=vdd}
N 620 170 620 200 {lab=vop}
N 460 170 460 200 {lab=von}
N 460 390 540 390 {lab=vss}
N 460 480 540 480 {lab=#net1}
N 500 140 540 140 {lab=vb}
N 620 200 620 360 {lab=vop}
N 460 200 460 360 {lab=von}
N 680 290 720 290 {lab=#net2}
N 720 200 720 210 {lab=vop}
N 370 290 410 290 {lab=#net3}
N 370 200 370 210 {lab=von}
N 370 360 370 390 {lab=vinp}
N 720 240 740 240 {lab=vdd}
N 350 240 370 240 {lab=vdd}
N 540 480 540 580 {lab=#net1}
N 370 200 370 210 {lab=von}
N 660 390 940 390 {lab=vinn}
N 160 390 420 390 {lab=vinp}
N 850 510 850 530 {lab=vinn}
N 890 480 910 480 {lab=vinn}
N 910 480 910 560 {lab=vinn}
N 890 560 910 560 {lab=vinn}
N 850 520 910 520 {lab=vinn}
N 850 440 850 450 {lab=vdd}
N 810 480 850 480 {lab=vdd}
N 810 560 850 560 {lab=vss}
N 810 560 810 590 {lab=vss}
N 810 590 850 590 {lab=vss}
N 810 450 850 450 {lab=vdd}
N 810 450 810 480 {lab=vdd}
N 850 590 850 600 {lab=vss}
N 230 510 230 530 {lab=vinp}
N 170 480 190 480 {lab=vinp}
N 170 480 170 560 {lab=vinp}
N 170 560 190 560 {lab=vinp}
N 170 520 230 520 {lab=vinp}
N 230 440 230 450 {lab=vdd}
N 230 480 270 480 {lab=vdd}
N 230 560 270 560 {lab=vss}
N 270 560 270 590 {lab=vss}
N 230 590 270 590 {lab=vss}
N 230 450 270 450 {lab=vdd}
N 270 450 270 480 {lab=vdd}
N 230 590 230 600 {lab=vss}
N 230 520 320 520 {lab=vinp}
N 770 520 850 520 {lab=vinn}
N 320 390 320 520 {lab=vinp}
N 720 270 720 310 {lab=#net2}
N 680 240 680 340 {lab=#net2}
N 720 370 720 390 {lab=vinn}
N 350 240 350 340 {lab=vdd}
N 350 340 380 340 {lab=vdd}
N 410 240 410 340 {lab=#net3}
N 370 270 370 310 {lab=#net3}
N 620 200 780 200 {lab=vop}
N 300 200 460 200 {lab=von}
N 720 340 740 340 {lab=vdd}
N 740 240 740 340 {lab=vdd}
N 320 240 350 240 {lab=vdd}
N 740 240 775 240 {lab=vdd}
N 130 200 155 200 {lab=vdd}
N 130 240 155 240 {lab=vss}
N 740 390 740 520 {lab=vinn}
N 740 520 770 520 {lab=vinn}
C {MP.sym} 580 140 0 0 {name=M1 model=PMOS w=45u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 500 140 0 1 {name=M2 model=PMOS w=45u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 500 610 0 0 {name=M3 model=NMOS w=10u l=2u nrd=0 nrs=0 m=2 spiceprefix=X}
C {devices/lab_pin.sym} 540 70 3 1 {name=p3 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} 850 440 1 0 {name=p5 sig_type=std_logic lab=vdd}
C {MN.sym} 420 390 0 0 {name=M7 model=NMOS w=20u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 660 390 0 1 {name=M8 model=NMOS w=20u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 680 240 0 0 {name=M6 model=PMOS w=45u l=8u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 680 340 2 1 {name=M9 model=PMOS w=45u l=8u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 410 240 0 1 {name=M5 model=PMOS w=45u l=8u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 410 340 2 0 {name=M10 model=PMOS w=45u l=8u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 890 560 0 1 {name=M12 model=NMOS w=12.6u l=8u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 890 480 0 1 {name=M13 model=PMOS w=34.4u l=8u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 190 560 0 0 {name=M11 model=NMOS w=12.6u l=8u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 190 480 0 0 {name=M14 model=PMOS w=34.4u l=8u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/opin.sym} 780 200 0 0 {name=p1 lab=vop}
C {devices/opin.sym} 300 200 0 1 {name=p2 lab=von}
C {devices/ipin.sym} 160 390 0 0 {name=p6 lab=vinp}
C {devices/ipin.sym} 540 140 1 0 {name=p7 lab=vb}
C {devices/ipin.sym} 450 610 0 0 {name=p8 lab=vt}
C {devices/ipin.sym} 940 390 0 1 {name=p9 lab=vinn}
C {devices/lab_pin.sym} 690 140 0 1 {name=p4 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} 390 140 0 0 {name=p10 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} 230 440 1 0 {name=p11 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} 540 670 3 0 {name=p12 sig_type=std_logic lab=vss}
C {devices/lab_pin.sym} 850 600 3 0 {name=p13 sig_type=std_logic lab=vss}
C {devices/lab_pin.sym} 230 600 3 0 {name=p14 sig_type=std_logic lab=vss}
C {devices/lab_pin.sym} 540 405 3 0 {name=p15 sig_type=std_logic lab=vss}
C {devices/lab_pin.sym} 320 240 2 1 {name=p16 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} 775 240 2 0 {name=p17 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} 155 200 0 1 {name=p18 sig_type=std_logic lab=vdd}
C {devices/iopin.sym} 130 200 0 1 {name=p19 lab=vdd}
C {devices/iopin.sym} 130 240 0 1 {name=p20 lab=vss}
C {devices/lab_pin.sym} 155 240 0 1 {name=p21 sig_type=std_logic lab=vss}
