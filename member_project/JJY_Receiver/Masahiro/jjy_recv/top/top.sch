v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
L 4 450 -440 450 -420 {}
L 4 450 -420 470 -420 {}
L 4 470 -440 470 -420 {}
L 4 450 -440 470 -440 {}
L 4 600 -440 600 -420 {}
L 4 600 -420 620 -420 {}
L 4 620 -440 620 -420 {}
L 4 600 -440 620 -440 {}
L 4 90 -430 920 -430 {}
L 4 340 -440 340 -420 {}
L 4 340 -420 360 -420 {}
L 4 360 -440 360 -420 {}
L 4 340 -440 360 -440 {}
L 4 80 -160 80 -140 {}
L 4 80 -140 100 -140 {}
L 4 100 -160 100 -140 {}
L 4 80 -160 100 -160 {}
L 4 80 -120 80 -100 {}
L 4 80 -100 100 -100 {}
L 4 100 -120 100 -100 {}
L 4 80 -120 100 -120 {}
L 4 80 -290 80 -270 {}
L 4 80 -270 100 -270 {}
L 4 100 -290 100 -270 {}
L 4 80 -290 100 -290 {}
L 4 920 -430 920 0 {}
L 4 90 0 920 0 {}
L 4 90 -430 90 0 {}
L 4 910 -160 910 -140 {}
L 4 910 -140 930 -140 {}
L 4 930 -160 930 -140 {}
L 4 910 -160 930 -160 {}
L 4 740 -10 740 10 {}
L 4 740 10 760 10 {}
L 4 760 -10 760 10 {}
L 4 740 -10 760 -10 {}
L 4 110 -440 110 -420 {}
L 4 110 -420 130 -420 {}
L 4 130 -440 130 -420 {}
L 4 110 -440 130 -440 {}
L 4 140 -440 140 -420 {}
L 4 140 -420 160 -420 {}
L 4 160 -440 160 -420 {}
L 4 140 -440 160 -440 {}
L 4 910 -370 910 -350 {}
L 4 910 -350 930 -350 {}
L 4 930 -370 930 -350 {}
L 4 910 -370 930 -370 {}
L 4 910 -330 910 -310 {}
L 4 910 -310 930 -310 {}
L 4 930 -330 930 -310 {}
L 4 910 -330 930 -330 {}
T {NC0} 930 -380 0 0 0.4 0.4 {}
T {NC1(ifp output?)} 930 -340 0 0 0.4 0.4 {}
T {share with other circuits} 30 -520 0 0 0.4 0.4 {}
N 670 -150 690 -150 {lab=ifn}
N 670 -110 690 -110 {lab=ifp}
N 690 -110 690 -100 {lab=ifp}
N 690 -150 710 -150 {lab=ifn}
N 550 -400 550 -380 {lab=XTALP}
N 620 -330 620 -290 {lab=VXON}
N 460 -400 520 -400 {lab=XTALN}
N 520 -400 520 -380 {lab=XTALN}
N 350 -430 350 -350 {lab=IBN40U}
N 300 -150 330 -150 {lab=vop}
N 300 -110 330 -110 {lab=von}
N 330 -110 370 -110 {lab=von}
N 330 -150 370 -150 {lab=vop}
N 90 -150 140 -150 {lab=VINN}
N 90 -110 140 -110 {lab=VINP}
N 620 -290 620 -250 {lab=VXON}
N 550 -250 550 -210 {lab=VXON}
N 550 -250 620 -250 {lab=VXON}
N 620 -350 640 -350 {lab=VXOP}
N 590 -230 640 -230 {lab=VXOP}
N 640 -350 640 -230 {lab=VXOP}
N 590 -230 590 -210 {lab=VXOP}
N 250 -280 500 -280 {lab=VB}
N 550 -400 610 -400 {lab=XTALP}
N 750 -110 790 -110 {lab=VDDBUF}
N 460 -430 460 -400 {lab=XTALN}
N 610 -430 610 -400 {lab=XTALP}
N 900 -150 920 -150 {lab=VOUT}
N 750 -110 750 -0 {lab=VDDBUF}
N 710 -150 790 -150 {lab=ifn}
N 290 -350 350 -350 {lab=IBN40U}
N 500 -280 500 -210 {lab=VB}
N 90 -280 250 -280 {lab=VB}
N 250 -280 250 -190 {lab=VB}
C {devices/lab_pin.sym} 300 -150 1 0 {name=p4 sig_type=std_logic lab=vop}
C {devices/lab_pin.sym} 300 -110 1 1 {name=p5 sig_type=std_logic lab=von}
C {devices/lab_pin.sym} 670 -150 1 0 {name=p13 sig_type=std_logic lab=ifn}
C {devices/lab_pin.sym} 670 -110 1 1 {name=p14 sig_type=std_logic lab=ifp}
C {devices/lab_pin.sym} 470 -210 1 0 {name=p20 sig_type=std_logic lab=IBN40U}
C {devices/lab_pin.sym} 640 -290 0 1 {name=p11 sig_type=std_logic lab=VXOP}
C {devices/lab_pin.sym} 620 -290 0 0 {name=p12 sig_type=std_logic lab=VXON}
C {devices/lab_pin.sym} 290 -330 2 0 {name=p22 sig_type=std_logic lab=IBN40UI}
C {devices/lab_pin.sym} 220 -190 1 0 {name=p1 sig_type=std_logic lab=IBN40U}
C {devices/lab_pin.sym} 790 -130 2 1 {name=p6 sig_type=std_logic lab=IBN40UI}
C {gilbert_cell/gilbert_cell.sym} 520 -130 0 0 {name=x2}
C {diff_amp/fully_diff_amp.sym} 220 -130 0 0 {name=x3}
C {OBUF_SSF/OBUF_SSF.sym} 940 -130 0 0 {name=x1}
C {bias_for_mix_amp/bias40u.sym} 190 -340 0 0 {name=x4}
C {XTALOSC/XTALOSC.sym} 470 -320 0 0 {name=x5}
C {devices/ipin.sym} 350 -430 1 0 {name=p8 lab=IBN40U}
C {devices/iopin.sym} 460 -430 3 0 {name=p9 lab=XTALN}
C {devices/ipin.sym} 90 -150 0 0 {name=p16 lab=VINN}
C {devices/iopin.sym} 610 -430 3 0 {name=p15 lab=XTALP}
C {devices/ipin.sym} 90 -110 0 0 {name=p2 lab=VINP}
C {devices/ipin.sym} 90 -280 0 0 {name=p3 lab=VB}
C {devices/iopin.sym} 120 -430 1 1 {name=p7 lab=VDD}
C {devices/opin.sym} 920 -150 0 0 {name=p17 lab=VOUT}
C {devices/iopin.sym} 750 0 3 1 {name=p10 lab=VDDBUF}
C {devices/iopin.sym} 150 -430 1 1 {name=p18 lab=VSS}
C {devices/lab_pin.sym} 790 -90 2 1 {name=p19 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 520 -50 1 1 {name=p21 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 220 -70 1 1 {name=p23 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 450 -330 2 1 {name=p24 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 290 -310 2 0 {name=p25 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 450 -350 2 1 {name=p26 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 190 -190 1 0 {name=p27 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 440 -210 1 0 {name=p28 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 290 -370 2 0 {name=p29 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 120 -430 1 1 {name=p30 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 150 -430 1 1 {name=p31 sig_type=std_logic lab=VSS}
