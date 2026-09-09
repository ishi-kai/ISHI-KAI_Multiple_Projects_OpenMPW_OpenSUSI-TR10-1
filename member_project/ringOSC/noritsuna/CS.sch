v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -570 800 -570 820 {lab=vvctrl}
N -580 730 -570 730 {lab=vdd}
N -580 730 -580 770 {lab=vdd}
N -580 770 -570 770 {lab=vdd}
N -570 880 -570 900 {lab=#net1}
N -570 730 -570 740 {lab=vdd}
N -570 960 -570 970 {lab=gnd}
N -570 930 -560 930 {lab=gnd}
N -560 930 -560 970 {lab=gnd}
N -570 810 -510 810 {lab=vvctrl}
N -510 770 -510 810 {lab=vvctrl}
N -640 850 -610 850 {lab=vvctrl}
N -640 810 -640 850 {lab=vvctrl}
N -640 810 -570 810 {lab=vvctrl}
N -640 930 -610 930 {lab=vctrl}
N -680 930 -640 930 {lab=vctrl}
N -570 850 -560 850 {lab=gnd}
N -560 850 -560 930 {lab=gnd}
N -570 970 -560 970 {lab=gnd}
N -530 770 -510 770 {lab=vvctrl}
C {devices/iopin.sym} -570 730 0 0 {name=p6 lab=vdd}
C {devices/opin.sym} -510 770 0 0 {name=p7 lab=vvctrl}
C {devices/iopin.sym} -560 970 0 0 {name=p8 lab=gnd}
C {IP62LIB/MN.sym} -610 930 0 0 {name=XM3 model=NMOS w=6.8u l=30u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0 dm=1}
C {IP62LIB/MP.sym} -530 770 0 1 {name=XM4 model=PMOS w=20.4u l=30u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0 dm=1}
C {IP62LIB/MN.sym} -610 850 0 0 {name=XM1 model=NMOS w=6.8u l=30u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0 dm=1}
C {devices/ipin.sym} -680 930 0 0 {name=p1 lab=vctrl}
