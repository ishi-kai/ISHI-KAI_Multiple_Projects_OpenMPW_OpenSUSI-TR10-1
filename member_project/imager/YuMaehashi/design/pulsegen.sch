v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 170 -330 190 -330 {lab=VDD}
N 170 -210 190 -210 {lab=VSS}
N 170 -480 190 -480 {lab=VDD}
N 170 -360 190 -360 {lab=VSS}
N 350 -400 370 -400 {lab=VDD}
N 350 -280 370 -280 {lab=VSS}
N 270 -420 280 -420 {lab=#net1}
N 280 -420 280 -360 {lab=#net1}
N 280 -360 300 -360 {lab=#net1}
N 280 -320 300 -320 {lab=#net2}
N 280 -320 280 -270 {lab=#net2}
N 270 -270 280 -270 {lab=#net2}
N 170 -630 190 -630 {lab=VDD}
N 170 -510 190 -510 {lab=VSS}
N 170 -780 190 -780 {lab=VDD}
N 170 -660 190 -660 {lab=VSS}
N 350 -700 370 -700 {lab=VDD}
N 350 -580 370 -580 {lab=VSS}
N 270 -720 280 -720 {lab=#net3}
N 280 -720 280 -660 {lab=#net3}
N 280 -660 300 -660 {lab=#net3}
N 280 -620 300 -620 {lab=#net4}
N 280 -620 280 -570 {lab=#net4}
N 270 -570 280 -570 {lab=#net4}
N 550 -680 570 -680 {lab=VDD}
N 550 -560 570 -560 {lab=VSS}
N 430 -640 500 -640 {lab=r_b}
N 480 -600 500 -600 {lab=OUT}
N 430 -340 640 -340 {lab=f}
N 640 -460 640 -340 {lab=f}
N 640 -460 660 -460 {lab=f}
N 630 -620 640 -620 {lab=#net5}
N 640 -620 640 -500 {lab=#net5}
N 640 -500 660 -500 {lab=#net5}
N 710 -540 730 -540 {lab=VDD}
N 710 -420 730 -420 {lab=VSS}
N 840 -510 860 -510 {lab=VDD}
N 840 -390 860 -390 {lab=VSS}
N 790 -480 840 -480 {lab=#net6}
N 820 -440 840 -440 {lab=CLK}
N 920 -480 920 -300 {lab=OUT}
N 480 -300 920 -300 {lab=OUT}
N 480 -600 480 -300 {lab=OUT}
N 80 -100 820 -100 {lab=CLK}
N 820 -440 820 -100 {lab=CLK}
N 900 -480 980 -480 {lab=OUT}
N 80 -740 120 -740 {lab=D0F}
N 80 -80 870 -80 {lab=RES}
N 870 -410 870 -80 {lab=RES}
N 80 -720 120 -720 {lab=D1F}
N 80 -700 120 -700 {lab=D2F}
N 80 -600 120 -600 {lab=D3F}
N 80 -580 120 -580 {lab=D4F}
N 80 -560 120 -560 {lab=#net7}
N 80 -540 120 -540 {lab=D5F}
N 80 -440 120 -440 {lab=D0R}
N 80 -420 120 -420 {lab=D1R}
N 80 -400 120 -400 {lab=D2R}
N 80 -300 120 -300 {lab=D3R}
N 80 -280 120 -280 {lab=D4R}
N 80 -260 120 -260 {lab=#net8}
N 80 -240 120 -240 {lab=D5R}
C {devices/lab_wire.sym} 180 -330 2 0 {name=p76 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} 180 -210 0 1 {name=p77 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 180 -480 2 0 {name=p78 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} 180 -360 0 1 {name=p79 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 360 -400 2 0 {name=p80 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} 360 -280 0 1 {name=p81 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 180 -630 2 0 {name=p82 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} 180 -510 0 1 {name=p83 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 180 -780 2 0 {name=p84 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} 180 -660 0 1 {name=p85 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 360 -700 2 0 {name=p86 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} 360 -580 0 1 {name=p87 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 560 -680 2 0 {name=p88 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} 560 -560 0 1 {name=p89 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 720 -540 2 0 {name=p17 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} 720 -420 0 1 {name=p90 sig_type=std_logic lab=VSS}
C {TR-1um_5_stdcell/DFFR.sym} 870 -450 0 0 {name=x30}
C {devices/lab_wire.sym} 850 -510 0 1 {name=p91 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} 850 -390 2 0 {name=p92 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 520 -340 0 1 {name=p101 sig_type=std_logic lab=f}
C {devices/lab_wire.sym} 440 -640 0 1 {name=p102 sig_type=std_logic lab=r_b}
C {devices/iopin.sym} 80 -40 0 1 {name=p1 lab=VDD}
C {devices/iopin.sym} 80 -20 0 1 {name=p2 lab=VSS}
C {devices/ipin.sym} 80 -100 0 0 {name=p3 lab=CLK}
C {devices/ipin.sym} 80 -80 0 0 {name=p21 lab=RES}
C {devices/opin.sym} 980 -480 0 0 {name=p5 lab=OUT}
C {devices/ipin.sym} 80 -440 0 0 {name=p4 lab=D0R}
C {devices/ipin.sym} 80 -420 0 0 {name=p6 lab=D1R}
C {devices/ipin.sym} 80 -400 0 0 {name=p7 lab=D2R}
C {devices/ipin.sym} 80 -300 0 0 {name=p8 lab=D3R}
C {devices/ipin.sym} 80 -280 0 0 {name=p9 lab=D4R}
C {devices/ipin.sym} 80 -260 0 0 {name=p10 lab=D5R}
C {devices/ipin.sym} 80 -240 0 0 {name=p11 lab=D6R}
C {devices/ipin.sym} 80 -740 0 0 {name=p12 lab=D0F}
C {devices/ipin.sym} 80 -720 0 0 {name=p13 lab=D1F}
C {devices/ipin.sym} 80 -700 0 0 {name=p14 lab=D2F}
C {devices/ipin.sym} 80 -600 0 0 {name=p15 lab=D3F}
C {devices/ipin.sym} 80 -580 0 0 {name=p16 lab=D4F}
C {devices/ipin.sym} 80 -560 0 0 {name=p18 lab=D5F}
C {devices/ipin.sym} 80 -540 0 0 {name=p19 lab=D6F}
C {2026_imager/pulsegen_and2.sym} 520 -620 0 0 {name=x4}
C {2026_imager/pulsegen_or2.sym} 680 -480 0 0 {name=x5}
C {2026_imager/pulsegen_or2.sym} 320 -640 0 0 {name=x1}
C {2026_imager/pulsegen_nor2.sym} 320 -340 0 0 {name=x3}
C {2026_imager/pulsegen_nand3.sym} 140 -720 0 0 {name=x2}
C {2026_imager/pulsegen_nand3.sym} 140 -420 0 0 {name=x6}
C {2026_imager/pulsegen_nand4.sym} 140 -570 0 0 {name=x7}
C {2026_imager/pulsegen_nand4.sym} 140 -270 0 0 {name=x8}
