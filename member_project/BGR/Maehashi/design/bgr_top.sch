v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
P 4 5 840 -590 840 -450 960 -450 960 -590 840 -590 {}
T {Antenna Diode} 840 -610 0 0 0.3 0.3 {}
N 860 -260 900 -260 {lab=#net1}
N 1060 -260 1100 -260 {lab=VOUT}
N 620 -280 640 -280 {lab=IOUT}
N 640 -380 640 -280 {lab=IOUT}
N 640 -380 1100 -380 {lab=IOUT}
N 620 -240 660 -240 {lab=#net2}
N 660 -360 660 -240 {lab=#net2}
N 660 -360 960 -360 {lab=#net2}
N 960 -360 960 -320 {lab=#net2}
N 420 -280 500 -280 {lab=#net3}
N 200 -280 220 -280 {lab=bgr_a_out}
N 220 -280 220 -140 {lab=bgr_a_out}
N 220 -140 700 -140 {lab=bgr_a_out}
N 700 -260 700 -140 {lab=bgr_a_out}
N 700 -260 740 -260 {lab=bgr_a_out}
N 420 -240 440 -240 {lab=bgr_b_out}
N 440 -240 440 -160 {lab=bgr_b_out}
N 440 -160 680 -160 {lab=bgr_b_out}
N 680 -300 680 -160 {lab=bgr_b_out}
N 680 -300 740 -300 {lab=bgr_b_out}
N 720 -220 720 -20 {lab=VSS}
N 720 -220 740 -220 {lab=VSS}
N 60 -20 940 -20 {lab=VSS}
N 940 -200 940 -20 {lab=VSS}
N 780 -180 780 -20 {lab=VSS}
N 540 -200 540 -20 {lab=VSS}
N 300 -200 300 -20 {lab=VSS}
N 100 -240 100 -20 {lab=VSS}
N 60 -420 940 -420 {lab=VDD}
N 940 -420 940 -320 {lab=VDD}
N 780 -420 780 -340 {lab=VDD}
N 540 -420 540 -320 {lab=VDD}
N 300 -420 300 -320 {lab=VDD}
N 100 -420 100 -320 {lab=VDD}
N 800 -620 800 -340 {lab=SEL1}
N 820 -620 820 -340 {lab=SEL0}
N 860 -560 860 -540 {lab=SEL1}
N 800 -560 860 -560 {lab=SEL1}
N 820 -580 940 -580 {lab=SEL0}
N 940 -580 940 -540 {lab=SEL0}
N 860 -480 860 -460 {lab=VSS}
N 860 -460 940 -460 {lab=VSS}
N 940 -480 940 -460 {lab=VSS}
C {2026_book/bgr_a.sym} 120 -280 0 0 {name=x1}
C {2026_book/bgr_b.sym} 340 -260 0 0 {name=x2}
C {2026_book/ibuf.sym} 560 -260 0 0 {name=x3}
C {2026_book/psf.sym} 980 -260 0 0 {name=x4}
C {2026_book/sel.sym} 800 -260 0 0 {name=x5}
C {devices/opin.sym} 1100 -260 0 0 {name=p1 lab=VOUT}
C {devices/opin.sym} 1100 -380 0 0 {name=p2 lab=IOUT}
C {devices/iopin.sym} 60 -20 0 1 {name=p3 lab=VSS}
C {devices/iopin.sym} 60 -420 0 1 {name=p4 lab=VDD}
C {devices/ipin.sym} 800 -620 1 0 {name=p5 lab=SEL1}
C {devices/ipin.sym} 820 -620 1 0 {name=p6 lab=SEL0}
C {devices/lab_wire.sym} 730 -260 0 0 {name=p8 sig_type=std_logic lab=bgr_a_out}
C {devices/lab_wire.sym} 730 -300 0 0 {name=p9 sig_type=std_logic lab=bgr_b_out}
C {TR-1umLIB/DN.sym} 860 -540 0 0 {name=D1
model=DN
w=3.6u
l=7.2u
a="expr_eng( @w * @l )"
p="expr_eng( 2 * ( @w + @l ) )"
spiceprefix=D
m=1}
C {TR-1umLIB/DN.sym} 940 -540 0 0 {name=D2
model=DN
w=3.6u
l=7.2u
a="expr_eng( @w * @l )"
p="expr_eng( 2 * ( @w + @l ) )"
spiceprefix=D
m=1}
C {devices/lab_wire.sym} 930 -460 0 0 {name=p7 sig_type=std_logic lab=VSS}
