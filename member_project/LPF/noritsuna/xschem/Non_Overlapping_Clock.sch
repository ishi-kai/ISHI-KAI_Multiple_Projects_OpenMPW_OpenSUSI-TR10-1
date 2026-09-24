v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -160 -40 -0 -40 {lab=CLK_IN}
N -140 -380 -90 -380 {lab=VDD}
N -140 -350 -90 -350 {lab=VSS}
N 120 -40 270 -40 {lab=#net1}
N -90 -40 -90 260 {lab=CLK_IN}
N -90 260 270 260 {lab=CLK_IN}
N 400 -20 620 -20 {lab=#net2}
N 400 240 620 240 {lab=#net3}
N 740 240 940 240 {lab=#net4}
N 740 -20 940 -20 {lab=#net5}
N 1060 -20 1210 -20 {lab=CLK_OUT_1}
N 1070 240 1210 240 {lab=CLK_OUT_1_BAR}
N 1140 -20 1140 60 {lab=CLK_OUT_1}
N 220 160 1140 60 {lab=CLK_OUT_1}
N 220 160 220 220 {lab=CLK_OUT_1}
N 220 220 270 220 {lab=CLK_OUT_1}
N 220 -0 270 -0 {lab=CLK_OUT_1_BAR}
N 220 -0 220 70 {lab=CLK_OUT_1_BAR}
N 220 70 1140 180 {lab=CLK_OUT_1_BAR}
N 1140 180 1140 240 {lab=CLK_OUT_1_BAR}
N 50 -80 320 -80 {lab=VDD}
N 320 -80 990 -80 {lab=VDD}
N 990 -80 990 -60 {lab=VDD}
N 670 -80 670 -60 {lab=VDD}
N 320 40 990 40 {lab=VSS}
N 990 20 990 40 {lab=VSS}
N 670 20 670 40 {lab=VSS}
N 50 40 320 40 {lab=VSS}
N 50 0 50 40 {lab=VSS}
N 320 180 990 180 {lab=VDD}
N 990 180 990 200 {lab=VDD}
N 670 180 670 200 {lab=VDD}
N 320 300 990 300 {lab=VSS}
N 990 280 990 300 {lab=VSS}
N 670 280 670 300 {lab=VSS}
N 260 530 410 530 {lab=#net6}
N 50 530 50 830 {lab=#net7}
N 50 830 410 830 {lab=#net7}
N 540 550 760 550 {lab=#net8}
N 540 810 760 810 {lab=#net9}
N 880 810 1080 810 {lab=#net10}
N 880 550 1080 550 {lab=#net11}
N 1200 550 1350 550 {lab=CLK_OUT_2}
N 1210 810 1350 810 {lab=CLK_OUT_2_BAR}
N 1280 550 1280 630 {lab=CLK_OUT_2}
N 360 730 1280 630 {lab=CLK_OUT_2}
N 360 730 360 790 {lab=CLK_OUT_2}
N 360 790 410 790 {lab=CLK_OUT_2}
N 360 570 410 570 {lab=CLK_OUT_2_BAR}
N 360 570 360 640 {lab=CLK_OUT_2_BAR}
N 360 640 1280 750 {lab=CLK_OUT_2_BAR}
N 1280 750 1280 810 {lab=CLK_OUT_2_BAR}
N 190 490 460 490 {lab=VDD}
N 460 490 1130 490 {lab=VDD}
N 1130 490 1130 510 {lab=VDD}
N 810 490 810 510 {lab=VDD}
N 460 610 1130 610 {lab=VSS}
N 1130 590 1130 610 {lab=VSS}
N 810 590 810 610 {lab=VSS}
N 190 610 460 610 {lab=VSS}
N 190 570 190 610 {lab=VSS}
N 460 750 1130 750 {lab=VDD}
N 1130 750 1130 770 {lab=VDD}
N 810 750 810 770 {lab=VDD}
N 460 870 1130 870 {lab=VSS}
N 1130 850 1130 870 {lab=VSS}
N 810 850 810 870 {lab=VSS}
N 50 530 140 530 {lab=#net7}
N -90 260 -90 530 {lab=CLK_IN}
N -90 530 -70 530 {lab=CLK_IN}
N -20 490 190 490 {lab=VDD}
N -20 610 190 610 {lab=VSS}
N -20 570 -20 610 {lab=VSS}
N 1200 810 1210 810 {lab=CLK_OUT_2_BAR}
N 1060 240 1070 240 {lab=CLK_OUT_1_BAR}
C {TR-1um_5_stdcell/INV_X1.sym} 20 -40 0 0 {name=x1}
C {devices/ipin.sym} -160 -40 0 0 {name=p3 lab=CLK_IN}
C {devices/iopin.sym} -140 -380 0 1 {name=p1 lab=VDD}
C {devices/iopin.sym} -140 -350 0 1 {name=p2 lab=VSS}
C {devices/lab_pin.sym} -90 -380 0 1 {name=p10 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} -90 -350 0 1 {name=p11 sig_type=std_logic lab=VSS}
C {TR-1um_5_stdcell/NOR2.sym} 290 -20 0 0 {name=x2}
C {TR-1um_5_stdcell/INV_X1.sym} 640 -20 0 0 {name=x3}
C {TR-1um_5_stdcell/INV_X1.sym} 960 -20 0 0 {name=x4}
C {TR-1um_5_stdcell/NOR2.sym} 290 240 0 0 {name=x5}
C {TR-1um_5_stdcell/INV_X1.sym} 640 240 0 0 {name=x6}
C {TR-1um_5_stdcell/INV_X1.sym} 960 240 0 0 {name=x7}
C {devices/opin.sym} 1210 -20 0 0 {name=p5 lab=CLK_OUT_1}
C {TR-1um_5_stdcell/INV_X1.sym} -50 530 0 0 {name=x8}
C {devices/opin.sym} 1210 240 0 0 {name=p4 lab=CLK_OUT_1_BAR}
C {devices/lab_pin.sym} 990 -80 0 1 {name=p6 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 990 40 0 1 {name=p7 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 990 180 0 1 {name=p8 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 990 300 0 1 {name=p9 sig_type=std_logic lab=VSS}
C {TR-1um_5_stdcell/INV_X1.sym} 160 530 0 0 {name=x9}
C {TR-1um_5_stdcell/NOR2.sym} 430 550 0 0 {name=x10}
C {TR-1um_5_stdcell/INV_X1.sym} 780 550 0 0 {name=x11}
C {TR-1um_5_stdcell/INV_X1.sym} 1100 550 0 0 {name=x12}
C {TR-1um_5_stdcell/NOR2.sym} 430 810 0 0 {name=x13}
C {TR-1um_5_stdcell/INV_X1.sym} 780 810 0 0 {name=x14}
C {TR-1um_5_stdcell/INV_X1.sym} 1100 810 0 0 {name=x15}
C {devices/opin.sym} 1350 550 0 0 {name=p13 lab=CLK_OUT_2}
C {devices/opin.sym} 1350 810 0 0 {name=p14 lab=CLK_OUT_2_BAR}
C {devices/lab_pin.sym} 1130 490 0 1 {name=p15 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 1130 610 0 1 {name=p16 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 1130 750 0 1 {name=p17 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 1130 870 0 1 {name=p18 sig_type=std_logic lab=VSS}
