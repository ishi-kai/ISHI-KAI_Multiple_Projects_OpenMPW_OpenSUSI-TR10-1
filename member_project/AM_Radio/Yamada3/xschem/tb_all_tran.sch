v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
L 4 950 -1140 970 -1120 {}
L 4 950 -1140 955 -1140 {}
L 4 950 -1140 950 -1135 {}
L 4 750 -1170 930 -1170 {}
L 4 930 -1170 930 -1050 {}
L 4 750 -1050 930 -1050 {}
L 4 750 -1170 750 -1050 {}
L 4 800 -1240 800 -1200 {}
L 4 800 -1240 810 -1250 {}
L 4 790 -1250 800 -1240 {}
L 4 880 -710 1000 -640 {}
L 4 880 -570 1000 -640 {}
L 4 880 -710 880 -570 {}
L 4 860 530 980 600 {}
L 4 860 670 980 600 {}
L 4 860 530 860 670 {}
L 4 1020 640 1020 800 {}
L 4 1020 640 1100 640 {}
L 4 1100 640 1100 800 {}
L 4 1020 800 1100 800 {}
L 4 640 520 1000 520 {}
L 4 1000 520 1000 720 {}
L 4 640 720 1000 720 {}
L 4 640 520 640 720 {}
L 4 720 110 840 180 {}
L 4 720 250 840 180 {}
L 4 720 110 720 250 {}
L 4 990 230 1110 300 {}
L 4 990 370 1110 300 {}
L 4 990 230 990 370 {}
L 4 540 -1300 2060 -1300 {}
L 4 540 -860 2060 -860 {}
L 4 540 -420 2060 -420 {}
L 4 540 20 2060 20 {}
L 4 540 440 2060 440 {}
L 4 540 880 2060 880 {}
L 4 540 -1740 2060 -1740 {}
L 4 540 -1740 540 880 {}
L 4 2060 -1740 2060 880 {}
B 2 1240 -1720 2040 -1320 {flags=graph
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node=in
color=4
dataset=-1
unitx=1
logx=0
logy=0
rawfile=$netlist_dir/tb_all_tran.raw
sim_type=tran
hilight_wave=-1
x1=0
autoload=1
y1=-3m
y2=3m
x2=5m}
B 2 1240 -1280 2040 -880 {flags=graph
y1=2.4
y2=2.6
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node=out1
color=4
dataset=-1
unitx=1
logx=0
logy=0
sim_type=tran
hilight_wave=-1
autoload=1
rawfile=$netlist_dir/tb_all_tran.raw
x2=5m}
B 2 1240 -840 2040 -440 {flags=graph
y1=0
y2=5
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node=out2
color=4
dataset=-1
unitx=1
logx=0
logy=0
sim_type=tran
hilight_wave=-1
autoload=1
rawfile=$netlist_dir/tb_tran.raw
x2=5m}
B 2 1240 -400 2040 0 {flags=graph
y1=0
y2=5
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node=out3
color=4
dataset=-1
unitx=1
logx=0
logy=0
sim_type=tran
hilight_wave=0
autoload=1
rawfile=$netlist_dir/tb_all_tran.raw
x2=5m}
B 2 1240 20 2040 420 {flags=graph
y1=1
y2=4
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node=out4
color=4
dataset=-1
unitx=1
logx=0
logy=0
sim_type=tran
hilight_wave=0
autoload=1
rawfile=$netlist_dir/tb_all_tran.raw
x2=5m}
B 2 1240 460 2040 860 {flags=graph
y1=0
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node=out5
color=4
dataset=-1
unitx=1
logx=0
logy=0
sim_type=tran
hilight_wave=0
autoload=1
rawfile=$netlist_dir/tb_all_tran.raw
x2=5m
y2=5}
A 4 845 180 11.18033988749895 116.565051177078 360 {}
A 4 855 180 11.18033988749895 116.565051177078 360 {}
T {All - Transient analysis} 560 -1825 0 0 0.8 0.8 {}
T {Rod antenna} 980 -1255 0 1 0.5 0.5 {}
T {LNA} 960 -695 0 0 0.5 0.5 {}
T {Power amp} 860 485 0 0 0.5 0.5 {}
T {Speaker 
8ohm} 1110 645 0 0 0.5 0.5 {}
T {OTA} 800 125 0 0 0.5 0.5 {}
T {Buffer} 1060 225 0 0 0.5 0.5 {}
T {0.AM Radio signal} 830 -1725 0 1 0.6 0.6 {}
T {1.Tuner} 680 -1285 0 1 0.6 0.6 {}
T {2.Low noise amp} 820 -845 0 1 0.6 0.6 {}
T {3.Absolute} 720 -405 0 1 0.6 0.6 {}
T {4.Low pass filter} 810 35 0 1 0.6 0.6 {}
T {5.Power amp} 760 455 0 1 0.6 0.6 {}
N 960 -1460 960 -1440 {lab=GND}
N 960 -1560 960 -1520 {lab=in}
N 870 -1540 870 -1520 {lab=VDD}
N 870 -1460 870 -1440 {lab=GND}
N 790 -1540 790 -1520 {lab=VREF}
N 790 -1460 790 -1440 {lab=GND}
N 880 -1080 880 -1020 {lab=#net1}
N 880 -1100 880 -1080 {lab=#net1}
N 960 -1100 960 -1080 {lab=#net1}
N 880 -1080 940 -1080 {lab=#net1}
N 800 -1200 800 -1160 {lab=in}
N 880 -1180 880 -1160 {lab=out1}
N 960 -1180 960 -1160 {lab=out1}
N 880 -1180 940 -1180 {lab=out1}
N 800 -1100 800 -1080 {lab=GND}
N 940 -1180 960 -1180 {lab=out1}
N 800 -1080 800 -1020 {lab=GND}
N 1030 -1180 1070 -1180 {lab=out1}
N 1120 -1180 1120 -1140 {lab=out1}
N 1120 -1080 1120 -1020 {lab=VREF}
N 940 -1080 960 -1080 {lab=#net1}
N 960 -1180 1030 -1180 {lab=out1}
N 1070 -1180 1100 -1180 {lab=out1}
N 1100 -1180 1140 -1180 {lab=out1}
N 960 -1080 1020 -1080 {lab=#net1}
N 1020 -1100 1020 -1080 {lab=#net1}
N 1020 -1180 1020 -1160 {lab=out1}
N 880 -960 880 -940 {lab=VREF}
N 1000 -140 1040 -140 {lab=out2}
N 920 -305 920 -280 {lab=VDD}
N 860 -250 920 -250 {lab=VDD}
N 860 -305 860 -250 {lab=VDD}
N 860 -305 920 -305 {lab=VDD}
N 1100 -300 1100 -280 {lab=VDD}
N 980 -250 980 -200 {lab=#net2}
N 1100 -300 1160 -300 {lab=VDD}
N 1160 -300 1160 -250 {lab=VDD}
N 1100 -250 1160 -250 {lab=VDD}
N 1100 -180 1100 -140 {lab=out3}
N 1100 -180 1160 -180 {lab=out3}
N 1070 -180 1070 -140 {lab=VDD}
N 680 -320 680 -300 {lab=VREF}
N 680 -270 740 -270 {lab=VDD}
N 680 -220 680 -180 {lab=VREF2}
N 620 -270 640 -270 {lab=VREF2}
N 620 -270 620 -220 {lab=VREF2}
N 620 -220 680 -220 {lab=VREF2}
N 680 -100 680 -80 {lab=GND}
N 680 -180 760 -180 {lab=VREF2}
N 740 -320 740 -270 {lab=VDD}
N 1070 -100 1070 -80 {lab=VREF2}
N 920 -100 920 -80 {lab=GND}
N 680 -180 680 -160 {lab=VREF2}
N 920 -200 920 -160 {lab=#net2}
N 920 -200 980 -200 {lab=#net2}
N 980 -250 1060 -250 {lab=#net2}
N 920 -320 920 -305 {lab=VDD}
N 960 -250 980 -250 {lab=#net2}
N 1100 -320 1100 -300 {lab=VDD}
N 1100 -220 1100 -180 {lab=out3}
N 680 -240 680 -220 {lab=VREF2}
N 920 -220 920 -200 {lab=#net2}
N 910 -690 910 -670 {lab=out2}
N 820 -660 870 -660 {lab=out1}
N 840 -620 870 -620 {lab=VREF}
N 910 -610 910 -570 {lab=VREF}
N 910 -690 950 -690 {lab=out2}
N 950 -690 950 -640 {lab=out2}
N 950 -640 1040 -640 {lab=out2}
N 820 -620 840 -620 {lab=VREF}
N 890 550 890 570 {lab=out5}
N 600 570 650 570 {lab=out4}
N 820 620 850 620 {lab=VREF}
N 890 630 890 670 {lab=VREF}
N 890 550 930 550 {lab=out5}
N 930 550 930 600 {lab=out5}
N 930 600 1020 600 {lab=out5}
N 810 620 820 620 {lab=VREF}
N 810 620 810 650 {lab=VREF}
N 810 650 810 670 {lab=VREF}
N 770 570 830 570 {lab=#net3}
N 830 570 830 580 {lab=#net3}
N 830 580 850 580 {lab=#net3}
N 650 570 670 570 {lab=out4}
N 730 570 770 570 {lab=#net3}
N 750 570 750 590 {lab=#net3}
N 750 650 750 670 {lab=VREF}
N 1020 600 1080 600 {lab=out5}
N 1050 600 1050 630 {lab=out5}
N 1050 710 1050 730 {lab=#net4}
N 1050 790 1050 830 {lab=GND}
N 1050 630 1050 650 {lab=out5}
N 750 130 750 150 {lab=VDD}
N 750 210 820 210 {lab=#net5}
N 880 260 880 280 {lab=#net6}
N 880 280 880 300 {lab=#net6}
N 880 280 920 280 {lab=#net6}
N 680 200 680 230 {lab=#net6}
N 820 180 820 210 {lab=#net5}
N 820 180 880 180 {lab=#net5}
N 680 230 680 260 {lab=#net6}
N 880 180 880 200 {lab=#net5}
N 660 160 710 160 {lab=out3}
N 680 200 710 200 {lab=#net6}
N 680 280 880 280 {lab=#net6}
N 680 260 680 280 {lab=#net6}
N 880 360 880 380 {lab=GND}
N 960 320 980 320 {lab=GND}
N 960 320 960 380 {lab=GND}
N 920 280 980 280 {lab=#net6}
N 1090 300 1140 300 {lab=out4}
N 1020 330 1020 380 {lab=GND}
N 1090 270 1090 300 {lab=out4}
N 1020 270 1090 270 {lab=out4}
C {devices/code_shown.sym} 275 -1710 0 0 {name=control only_toplevel=false value=".option savecurrent
.control
save all
# Transienst analysis
tran 0.1u 5m 0 0.1u
write tb_all_tran.raw
.endc"}
C {devices/gnd.sym} 960 -1440 0 0 {name=l2 lab=GND}
C {devices/lab_pin.sym} 960 -1560 0 1 {name=p1 sig_type=std_logic lab=in}
C {devices/vdd.sym} 870 -1540 0 0 {name=l3 lab=VDD}
C {devices/gnd.sym} 870 -1440 0 0 {name=l4 lab=GND}
C {devices/vsource.sym} 870 -1490 0 0 {name=V2 value="dc 5" savecurrent=false}
C {devices/vdd.sym} 790 -1540 0 0 {name=l8 lab=VREF}
C {devices/gnd.sym} 790 -1440 0 0 {name=l9 lab=GND}
C {devices/vsource.sym} 790 -1490 0 0 {name=V3 value="dc 2.5" savecurrent=false}
C {devices/asrc.sym} 960 -1490 0 0 {name=B1 function="V=0.5m*(1+0.5*sin(2*pi*1k*time))*sin(2*pi*500k*time)+0.5m*(1+0.5*sin(2*pi*3k*time))*sin(2*pi*800k*time)+0.5m*(1+0.5*sin(2*pi*5k*time))*sin(2*pi*663.74k*time)"}
C {devices/launcher.sym} 1570 -1780 0 0 {name=h5
descr="load waves (CTRL + LEFT BUTTON CLICK)" 
tclcommand="xschem raw_read $netlist_dir/tb_all_tran.raw tran"
}
C {devices/code.sym} 290 -1510 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/capa.sym} 960 -1130 0 0 {name=C1
m=1
value=160p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 880 -940 0 1 {name=l12 lab=VREF}
C {devices/lab_pin.sym} 800 -1200 0 0 {name=p6 sig_type=std_logic lab=in}
C {devices/ind.sym} 800 -1130 0 1 {name=L14
m=1
value=36u
footprint=1206
device=inductor}
C {devices/k.sym} 840 -1130 0 1 {name=K1 K=0.9 L1=L17 L2=L14}
C {devices/ind.sym} 880 -1130 0 0 {name=L17
m=1
value=360u
footprint=1206
device=inductor}
C {devices/res.sym} 1120 -1110 0 1 {name=R1
value=470k
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 1120 -1020 0 1 {name=l18 lab=VREF}
C {devices/lab_pin.sym} 1140 -1180 0 1 {name=p7 sig_type=std_logic lab=out1}
C {devices/res.sym} 880 -990 0 1 {name=R2
value=470k
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 800 -1020 0 1 {name=l19 lab=GND}
C {devices/capa.sym} 1020 -1130 0 0 {name=C2
m=1
value=680p
footprint=1206
device="ceramic capacitor"}
C {devices/lab_pin.sym} 1000 -140 0 0 {name=p4 sig_type=std_logic lab=out2}
C {devices/isource.sym} 920 -130 0 0 {name=I0 value=10u}
C {devices/lab_pin.sym} 1160 -180 0 1 {name=p5 sig_type=std_logic lab=out3}
C {devices/vdd.sym} 920 -320 0 0 {name=l13 lab=VDD}
C {devices/vdd.sym} 1100 -320 0 0 {name=l15 lab=VDD}
C {devices/gnd.sym} 920 -80 0 0 {name=l16 lab=GND}
C {devices/vdd.sym} 1070 -180 0 0 {name=l6 lab=VDD}
C {devices/gnd.sym} 1070 -80 0 0 {name=l7 lab=VREF2}
C {devices/isource.sym} 680 -130 0 0 {name=I1 value=10u}
C {devices/gnd.sym} 680 -80 0 0 {name=l11 lab=GND}
C {devices/lab_pin.sym} 760 -180 0 1 {name=p8 sig_type=std_logic lab=VREF2}
C {devices/vdd.sym} 680 -320 0 0 {name=l10 lab=VREF}
C {devices/vdd.sym} 740 -320 0 0 {name=l20 lab=VDD}
C {MP.sym} 640 -270 0 0 {name=XM3 model=PMOS w=90u l=3u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MP.sym} 960 -250 0 1 {name=XM1 model=PMOS w=90u l=3u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MP.sym} 1060 -250 0 0 {name=XM4 model=PMOS w=90u l=3u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MP.sym} 1070 -100 3 0 {name=XM5 model=PMOS w=90u l=3u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {devices/lab_pin.sym} 1040 -640 0 1 {name=p9 sig_type=std_logic lab=out2}
C {devices/lab_pin.sym} 820 -660 0 0 {name=p10 sig_type=std_logic lab=out1}
C {devices/vcvs.sym} 910 -640 0 0 {name=E1 value=20}
C {devices/lab_pin.sym} 820 -620 0 0 {name=p11 sig_type=std_logic lab=VREF}
C {devices/gnd.sym} 910 -570 0 1 {name=l21 lab=VREF}
C {devices/lab_pin.sym} 1080 600 0 1 {name=p12 sig_type=std_logic lab=out5}
C {devices/lab_pin.sym} 600 570 0 0 {name=p13 sig_type=std_logic lab=out4}
C {devices/vcvs.sym} 890 600 0 0 {name=E2 value=5}
C {devices/gnd.sym} 890 670 0 0 {name=l22 lab=VREF}
C {devices/gnd.sym} 810 670 0 0 {name=l23 lab=VREF}
C {devices/capa.sym} 700 570 1 1 {name=C4
m=1
value=0.48u
footprint=1206
device="ceramic capacitor"}
C {devices/res.sym} 1050 760 0 0 {name=R3
value=5
footprint=1206
device=resistor
m=1}
C {devices/res.sym} 750 620 0 0 {name=R4
value=18k
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 750 670 0 0 {name=l24 lab=VREF}
C {devices/ind.sym} 1050 680 0 0 {name=L25
m=1
value=1m
footprint=1206
device=inductor}
C {devices/gnd.sym} 1050 830 0 0 {name=l26 lab=GND}
C {devices/vccs.sym} 750 180 0 0 {name=G1 value=1.113e-6}
C {devices/ammeter.sym} 880 230 0 0 {name=Vmeas savecurrent=true spice_ignore=0}
C {devices/vdd.sym} 750 130 0 0 {name=l1 lab=VDD}
C {devices/lab_pin.sym} 1140 300 0 1 {name=p2 sig_type=std_logic lab=out4}
C {devices/lab_pin.sym} 660 160 0 0 {name=p3 sig_type=std_logic lab=out3}
C {devices/capa.sym} 880 330 0 0 {name=C3
m=1
value=8.856p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 880 380 0 0 {name=l5 lab=GND}
C {devices/vcvs.sym} 1020 300 0 0 {name=E3 value=1}
C {devices/gnd.sym} 960 380 0 0 {name=l27 lab=GND}
C {devices/gnd.sym} 1020 380 0 0 {name=l28 lab=GND}
