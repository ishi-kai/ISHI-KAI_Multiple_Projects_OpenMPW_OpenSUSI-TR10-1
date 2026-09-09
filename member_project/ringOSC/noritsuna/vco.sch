v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 160 810 190 810 {lab=#net1}
N 490 810 520 810 {lab=#net2}
N 480 890 510 890 {lab=#net3}
N 820 810 830 810 {lab=#net4}
N 830 810 830 890 {lab=#net4}
N 810 890 830 890 {lab=#net4}
N -140 770 -140 790 {lab=#net5}
N -140 770 190 770 {lab=#net5}
N 190 770 190 790 {lab=#net5}
N 520 770 520 790 {lab=#net5}
N 190 770 520 770 {lab=#net5}
N 810 910 810 940 {lab=#net5}
N 480 910 480 940 {lab=#net5}
N 520 830 520 850 {lab=vctrl}
N 190 830 190 850 {lab=vctrl}
N -140 830 -140 850 {lab=vctrl}
N 480 850 480 870 {lab=vctrl}
N 810 850 810 870 {lab=vctrl}
N 820 730 820 790 {lab=vdd}
N 490 730 490 790 {lab=vdd}
N 820 830 820 970 {lab=gnd}
N 160 730 160 790 {lab=vdd}
N 160 870 180 870 {lab=gnd}
N 160 870 160 970 {lab=gnd}
N 490 870 510 870 {lab=gnd}
N 490 870 490 970 {lab=gnd}
N 500 910 510 910 {lab=vdd}
N 500 730 500 910 {lab=vdd}
N 170 910 180 910 {lab=vdd}
N 170 730 170 910 {lab=vdd}
N 160 830 160 870 {lab=gnd}
N 490 830 490 870 {lab=gnd}
N -570 730 1160 730 {lab=vdd}
N -570 970 1160 970 {lab=gnd}
N 150 890 180 890 {lab=#net6}
N 150 910 150 940 {lab=#net5}
N -180 890 -150 890 {lab=#net7}
N -160 910 -150 910 {lab=vdd}
N -160 730 -160 910 {lab=vdd}
N -530 770 -140 770 {lab=#net5}
N 150 850 150 870 {lab=vctrl}
N -170 870 -150 870 {lab=gnd}
N -170 870 -170 970 {lab=gnd}
N -530 940 810 940 {lab=#net5}
N -540 850 810 850 {lab=vctrl}
N -950 830 -910 830 {lab=vctrl}
N -480 730 -480 890 {lab=vdd}
N -480 930 -480 970 {lab=gnd}
N -180 810 -140 810 {lab=inv_out}
N -610 730 -610 830 {lab=vdd}
N -610 730 -570 730 {lab=vdd}
N -610 870 -610 970 {lab=gnd}
N -610 970 -570 970 {lab=gnd}
N -930 790 -930 830 {lab=vctrl}
N -930 790 -540 790 {lab=vctrl}
N -540 790 -540 850 {lab=vctrl}
N -610 850 -580 850 {lab=#net5}
N -580 770 -580 850 {lab=#net5}
N -580 770 -530 770 {lab=#net5}
N -580 850 -580 940 {lab=#net5}
N -580 940 -530 940 {lab=#net5}
C {devices/iopin.sym} 1160 730 0 0 {name=p6 lab=vdd}
C {devices/opin.sym} -480 910 0 1 {name=p7 lab=vout}
C {devices/iopin.sym} 1160 970 0 0 {name=p8 lab=gnd}
C {inverter.sym} 10 810 0 0 {name=x2}
C {inverter.sym} 340 810 0 0 {name=x3}
C {inverter.sym} 670 810 0 0 {name=x4}
C {inverter.sym} 660 890 2 0 {name=x5}
C {buffer.sym} -330 910 0 1 {name=x1}
C {inverter.sym} 330 890 2 0 {name=x9}
C {inverter.sym} 0 890 2 0 {name=x6}
C {devices/ipin.sym} -950 830 0 0 {name=p1 lab=vctrl}
C {devices/ipin.sym} -180 810 0 0 {name=p2 lab=inv_out}
C {CS.sym} -760 850 0 0 {name=x7}
