v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -410 -370 -360 -370 {lab=VDD}
N -410 -340 -360 -340 {lab=VSS}
N -410 -280 -360 -280 {lab=vb}
N 330 -130 530 -130 {lab=#net1}
N 590 -130 780 -130 {lab=#net2}
N 430 -130 430 -0 {lab=#net1}
N 680 -130 680 -0 {lab=#net2}
N 410 300 430 300 {lab=VSS}
N 660 300 680 300 {lab=VSS}
N 320 600 520 600 {lab=#net3}
N 580 600 770 600 {lab=#net4}
N 420 600 420 730 {lab=#net3}
N 670 600 670 730 {lab=#net4}
N 400 1030 420 1030 {lab=VSS}
N 650 1030 670 1030 {lab=VSS}
N 320 1390 520 1390 {lab=#net5}
N 580 1390 770 1390 {lab=#net6}
N 420 1390 420 1520 {lab=#net5}
N 670 1390 670 1520 {lab=#net6}
N 400 1820 420 1820 {lab=VSS}
N 650 1820 670 1820 {lab=VSS}
N -370 580 20 580 {lab=#net7}
N -190 430 520 430 {lab=#net8}
N -190 490 -190 580 {lab=#net7}
N -470 -110 30 -110 {lab=#net8}
N -470 -110 -470 560 {lab=#net8}
N -470 430 -190 430 {lab=#net8}
N 580 430 1210 430 {lab=RF_OUT}
N 1070 620 1330 620 {lab=#net9}
N 1080 -110 1390 -110 {lab=RF_OUT}
N 1450 -110 1450 640 {lab=RF_OUT}
N 1210 430 1450 430 {lab=RF_OUT}
N 1390 -110 1450 -110 {lab=RF_OUT}
N 1210 490 1210 620 {lab=#net9}
N 1210 620 1210 1410 {lab=#net9}
N 1070 1410 1210 1410 {lab=#net9}
N -210 -350 -190 -350 {lab=VSS}
N -210 -350 -210 -320 {lab=VSS}
N -210 -290 -190 -290 {lab=VSS}
N -210 -320 -210 -290 {lab=VSS}
C {TG.sym} 430 150 1 0 {name=x1}
C {TG.sym} 180 -130 0 1 {name=x2}
C {Non_Overlapping_Clock.sym} 560 -390 0 0 {name=x3}
C {opamp.sym} -450 580 2 1 {name=X4}
C {devices/iopin.sym} -410 -370 0 1 {name=p1 lab=VDD}
C {devices/iopin.sym} -410 -340 0 1 {name=p2 lab=VSS}
C {devices/lab_pin.sym} -360 -370 0 1 {name=p10 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} -360 -340 0 1 {name=p11 sig_type=std_logic lab=VSS}
C {devices/ipin.sym} -410 -280 0 0 {name=p3 lab=vb}
C {devices/lab_pin.sym} -360 -280 0 1 {name=p4 sig_type=std_logic lab=vb}
C {devices/lab_pin.sym} -470 620 0 0 {name=p5 sig_type=std_logic lab=vb}
C {TG.sym} 930 -130 0 0 {name=x5}
C {TG.sym} 680 150 1 0 {name=x6}
C {devices/lab_pin.sym} 330 -150 0 1 {name=p16 sig_type=std_logic lab=CLK2}
C {devices/lab_pin.sym} 780 -150 0 0 {name=p17 sig_type=std_logic lab=CLK2}
C {devices/lab_pin.sym} 330 -110 0 1 {name=p18 sig_type=std_logic lab=CLK2_BAR}
C {devices/lab_pin.sym} 780 -110 0 0 {name=p19 sig_type=std_logic lab=CLK2_BAR}
C {devices/lab_pin.sym} 450 0 0 1 {name=p20 sig_type=std_logic lab=CLK_1}
C {devices/lab_pin.sym} 700 0 0 1 {name=p21 sig_type=std_logic lab=CLK_1}
C {devices/lab_pin.sym} 410 0 0 0 {name=p22 sig_type=std_logic lab=CLK1_BAR}
C {devices/lab_pin.sym} 660 0 0 0 {name=p23 sig_type=std_logic lab=CLK1_BAR}
C {devices/lab_pin.sym} 660 300 0 0 {name=p24 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 410 300 0 0 {name=p25 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 30 -130 0 0 {name=p26 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 1080 -130 0 1 {name=p27 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 30 -150 0 0 {name=p28 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 1080 -150 0 1 {name=p29 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 700 300 0 1 {name=p30 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 450 300 0 1 {name=p31 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 710 -400 0 1 {name=p32 sig_type=std_logic lab=CLK_1}
C {devices/lab_pin.sym} 710 -380 0 1 {name=p33 sig_type=std_logic lab=CLK1_BAR}
C {devices/lab_pin.sym} 710 -360 0 1 {name=p34 sig_type=std_logic lab=CLK2}
C {devices/lab_pin.sym} 710 -340 0 1 {name=p35 sig_type=std_logic lab=CLK2_BAR}
C {devices/lab_pin.sym} 710 -440 0 1 {name=p36 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 710 -420 0 1 {name=p37 sig_type=std_logic lab=VSS}
C {devices/ipin.sym} 410 -440 0 0 {name=p38 lab=CLK_IN}
C {TG.sym} 420 880 1 0 {name=x7}
C {TG.sym} 170 580 0 0 {name=x8}
C {TG.sym} 920 600 0 0 {name=x9}
C {TG.sym} 670 880 1 0 {name=x10}
C {devices/lab_pin.sym} 440 730 0 1 {name=p39 sig_type=std_logic lab=CLK2}
C {devices/lab_pin.sym} 770 580 0 0 {name=p40 sig_type=std_logic lab=CLK2}
C {devices/lab_pin.sym} 400 730 0 0 {name=p41 sig_type=std_logic lab=CLK2_BAR}
C {devices/lab_pin.sym} 770 620 0 0 {name=p42 sig_type=std_logic lab=CLK2_BAR}
C {devices/lab_pin.sym} 20 560 0 0 {name=p43 sig_type=std_logic lab=CLK_1}
C {devices/lab_pin.sym} 690 730 0 1 {name=p44 sig_type=std_logic lab=CLK_1}
C {devices/lab_pin.sym} 20 600 0 0 {name=p45 sig_type=std_logic lab=CLK1_BAR}
C {devices/lab_pin.sym} 650 730 0 0 {name=p46 sig_type=std_logic lab=CLK1_BAR}
C {devices/lab_pin.sym} 650 1030 0 0 {name=p47 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 400 1030 0 0 {name=p48 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 1070 600 0 1 {name=p50 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 1070 580 0 1 {name=p52 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 690 1030 0 1 {name=p53 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 440 1030 0 1 {name=p54 sig_type=std_logic lab=VDD}
C {TG.sym} 420 1670 1 0 {name=x11}
C {TG.sym} 920 1390 0 0 {name=x13}
C {TG.sym} 670 1670 1 0 {name=x14}
C {devices/lab_pin.sym} 440 1520 0 1 {name=p55 sig_type=std_logic lab=CLK2}
C {devices/lab_pin.sym} 770 1370 0 0 {name=p56 sig_type=std_logic lab=CLK2}
C {devices/lab_pin.sym} 400 1520 0 0 {name=p57 sig_type=std_logic lab=CLK2_BAR}
C {devices/lab_pin.sym} 770 1410 0 0 {name=p58 sig_type=std_logic lab=CLK2_BAR}
C {devices/lab_pin.sym} 690 1520 0 1 {name=p60 sig_type=std_logic lab=CLK_1}
C {devices/lab_pin.sym} 650 1520 0 0 {name=p62 sig_type=std_logic lab=CLK1_BAR}
C {devices/lab_pin.sym} 650 1820 0 0 {name=p63 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 400 1820 0 0 {name=p64 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 1070 1390 0 1 {name=p66 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 1070 1370 0 1 {name=p68 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 690 1820 0 1 {name=p69 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 440 1820 0 1 {name=p70 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 320 560 0 1 {name=p49 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 320 580 0 1 {name=p51 sig_type=std_logic lab=VSS}
C {TG.sym} 180 1370 0 0 {name=x12}
C {devices/lab_pin.sym} 30 1350 0 0 {name=p59 sig_type=std_logic lab=CLK_1}
C {devices/lab_pin.sym} 30 1390 0 0 {name=p61 sig_type=std_logic lab=CLK1_BAR}
C {devices/lab_pin.sym} 330 1350 0 1 {name=p65 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 330 1370 0 1 {name=p67 sig_type=std_logic lab=VSS}
C {devices/ipin.sym} 30 1370 0 0 {name=p71 lab=RF_IN}
C {TR-1umLIB/CSIO.sym} 590 -130 1 0 {name=XC1
model=F_CSIO
spiceprefix=X
x=28.8u
y=28.8u
c="expr_eng( 0.6e-3 * @x * @y )"
a="expr_eng( @x * @y )"
p="expr_eng( 2 * ( @x + @y ) )"
m=5}
C {TR-1umLIB/CSIO.sym} 520 430 3 1 {name=XC2
model=F_CSIO
spiceprefix=X
x=28.8u
y=28.8u
c="expr_eng( 0.6e-3 * @x * @y )"
a="expr_eng( @x * @y )"
p="expr_eng( 2 * ( @x + @y ) )"
m=7}
C {TR-1umLIB/CSIO.sym} -190 -350 0 0 {name=XC3
model=F_CSIO
spiceprefix=X
x=28.8u
y=28.8u
c="expr_eng( 0.6e-3 * @x * @y )"
a="expr_eng( @x * @y )"
p="expr_eng( 2 * ( @x + @y ) )"
m=38}
C {TR-1umLIB/CSIO.sym} 1210 430 0 0 {name=XC4
model=F_CSIO
spiceprefix=X
x=28.8u
y=28.8u
c="expr_eng( 0.6e-3 * @x * @y )"
a="expr_eng( @x * @y )"
p="expr_eng( 2 * ( @x + @y ) )"
m=2}
C {TR-1umLIB/CSIO.sym} 520 1390 3 1 {name=XC5
model=F_CSIO
spiceprefix=X
x=28.8u
y=28.8u
c="expr_eng( 0.6e-3 * @x * @y )"
a="expr_eng( @x * @y )"
p="expr_eng( 2 * ( @x + @y ) )"
m=5}
C {TR-1umLIB/CSIO.sym} 520 600 3 1 {name=XC6
model=F_CSIO
spiceprefix=X
x=28.8u
y=28.8u
c="expr_eng( 0.6e-3 * @x * @y )"
a="expr_eng( @x * @y )"
p="expr_eng( 2 * ( @x + @y ) )"
m=5}
C {opamp.sym} 1350 640 2 1 {name=X15}
C {devices/lab_pin.sym} 1330 680 0 0 {name=p72 sig_type=std_logic lab=vb}
C {devices/lab_pin.sym} -470 600 0 0 {name=p73 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} -410 520 0 0 {name=p74 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 1390 580 0 0 {name=p75 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 1330 660 0 0 {name=p76 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} -410 640 0 0 {name=p77 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 1390 700 0 0 {name=p78 sig_type=std_logic lab=VDD}
C {devices/opin.sym} 1450 430 0 0 {name=p79 lab=RF_OUT}
C {devices/lab_pin.sym} 560 -150 0 1 {name=p6 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 550 410 0 1 {name=p7 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 550 580 0 1 {name=p8 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 550 1370 0 1 {name=p9 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} -210 460 0 0 {name=p12 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 1190 460 0 0 {name=p13 sig_type=std_logic lab=VSS}
C {TR-1umLIB/CSIO.sym} -190 430 0 0 {name=XC7
model=F_CSIO
spiceprefix=X
x=28.8u
y=28.8u
c="expr_eng( 0.6e-3 * @x * @y )"
a="expr_eng( @x * @y )"
p="expr_eng( 2 * ( @x + @y ) )"
m=2}
C {devices/lab_pin.sym} -210 -320 0 0 {name=p14 sig_type=std_logic lab=VSS}
