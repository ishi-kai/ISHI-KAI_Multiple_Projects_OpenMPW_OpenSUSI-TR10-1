v {xschem version=3.4.7RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
L 4 -2130 -180 -2110 -160 {}
L 4 -2130 -180 -2125 -180 {}
L 4 -2130 -180 -2130 -175 {}
L 4 -2090 -420 -2090 -380 {}
L 4 -2090 -420 -2080 -430 {}
L 4 -2100 -430 -2090 -420 {}
L 4 -2220 1330 -2100 1400 {}
L 4 -2220 1470 -2100 1400 {}
L 4 -2220 1330 -2220 1470 {}
L 4 -2240 -700 -2120 -630 {}
L 4 -2240 -560 -2120 -630 {}
L 4 -2240 -700 -2240 -560 {}
L 4 -2480 -410 -2480 -370 {}
L 4 -2480 -410 -2470 -420 {}
L 4 -2490 -420 -2480 -410 {}
B 2 -1640 -920 -840 -520 {flags=graph
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
rawfile=$netlist_dir/tb_am_radio_tran.raw
sim_type=tran
hilight_wave=-1
autoload=1
y1=-0.034531997
y2=0.022264449
x2=0.003293727
x1=1.2236781e-05}
B 2 -1640 -480 -840 -80 {flags=graph
y1=2.4911493
y2=2.5098794
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
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
rawfile=$netlist_dir/tb_am_radio_tran.raw
x1=1.2236781e-05
x2=0.003293727}
B 2 -1640 -40 -840 360 {flags=graph
y1=2.459155
y2=2.5507051
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=1.2236781e-05
x2=0.003293727
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
rawfile=$netlist_dir/tb_am_radio_tran.raw
color=4
node=out2
sim_type=tran}
B 2 -1640 400 -840 800 {flags=graph
y1=2.3295515
y2=2.6327075
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=1.2236781e-05
x2=0.003293727
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
rawfile=$netlist_dir/tb_am_radio_tran.raw
sim_type=tran
color=4
node=out3}
B 2 -1640 840 -840 1240 {flags=graph
y1=1.3742979
y2=3.879123
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=1.2236781e-05
x2=0.003293727
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
rawfile=$netlist_dir/tb_am_radio_tran.raw
sim_type=tran
color=4
node=out4}
B 2 -1640 1280 -840 1680 {flags=graph
y1=1.6998892
y2=3.0357959
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=1.2236781e-05
x2=0.003293727
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
rawfile=$netlist_dir/tb_am_radio_tran.raw
sim_type=tran
color=4
node=det}
B 2 -1640 1720 -840 2120 {flags=graph
y1=1.8792094
y2=3.215116
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=1.2236781e-05
x2=0.003293727
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
rawfile=$netlist_dir/tb_am_radio_tran.raw
sim_type=tran
color=4
node=det2}
B 2 -800 -480 0 -80 {flags=graph
y1=-7.9143511e-06
y2=6.2289631e-06
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0.00046652704
x2=0.0030917194
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node=i(vmeas)
color=4
dataset=-1
unitx=1
logx=0
logy=0
rawfile=$netlist_dir/tb_am_radio_tran.raw}
B 2 -800 -920 0 -520 {flags=graph
y1=1.3215121
y2=3.7215121
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0.00046652704
x2=0.0030917194
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node=vref
color=4
dataset=-1
unitx=1
logx=0
logy=0
rawfile=$netlist_dir/tb_am_radio_tran.raw}
T {IDEAL_DIODE} -2310 1285 0 0 0.5 0.5 {}
T {AM Radio} -2440 -935 0 0 0.8 0.8 {}
T {Bar Antenna + Poly Vari-Con} -1810 -495 0 1 0.5 0.5 {}
T {Carrier,Audio
500KHz,1KHz
1000KHz,3KHz <-- Tune
1500KHz,5KHz
} -2190 -285 0 1 0.4 0.4 {}
N -2480 -650 -2480 -630 {lab=VDD}
N -2480 -570 -2480 -550 {lab=GND}
N -1980 -120 -1980 -60 {lab=VREF}
N -1980 -140 -1980 -120 {lab=VREF}
N -1980 -220 -1980 -200 {lab=#net1}
N -2060 -140 -2060 -120 {lab=#net2}
N -2060 -220 -2060 -200 {lab=#net3}
N -2120 -220 -2120 -200 {lab=#net3}
N -2120 -140 -2120 -120 {lab=GND}
N -2120 -220 -2060 -220 {lab=#net3}
N -2060 -60 -2060 -40 {lab=GND}
N -2120 -40 -2060 -40 {lab=GND}
N -2120 -120 -2120 -40 {lab=GND}
N -2090 -240 -2090 -220 {lab=#net3}
N -2090 -320 -2090 -300 {lab=#net4}
N -2000 120 -2000 180 {lab=out2}
N -2060 90 -2040 90 {lab=#net5}
N -2060 90 -2060 210 {lab=#net5}
N -2060 210 -2040 210 {lab=#net5}
N -2000 40 -2000 60 {lab=VDD}
N -2000 240 -2000 270 {lab=GND}
N -2150 150 -2060 150 {lab=#net5}
N -2000 150 -1880 150 {lab=out2}
N -2110 320 -2050 320 {lab=#net5}
N -2110 150 -2110 320 {lab=#net5}
N -1990 320 -1950 320 {lab=out2}
N -1950 150 -1950 320 {lab=out2}
N -2000 210 -1980 210 {lab=GND}
N -1980 210 -1980 240 {lab=GND}
N -2000 240 -1980 240 {lab=GND}
N -2000 90 -1980 90 {lab=VDD}
N -1980 60 -1980 90 {lab=VDD}
N -2000 60 -1980 60 {lab=VDD}
N -2300 150 -2270 150 {lab=out1}
N -2000 540 -2000 600 {lab=out3}
N -2060 510 -2040 510 {lab=out2}
N -2060 510 -2060 630 {lab=out2}
N -2060 630 -2040 630 {lab=out2}
N -2000 460 -2000 480 {lab=VDD}
N -2000 660 -2000 690 {lab=GND}
N -2150 570 -2060 570 {lab=out2}
N -2000 570 -1880 570 {lab=out3}
N -2110 740 -2050 740 {lab=out2}
N -2110 570 -2110 740 {lab=out2}
N -1990 740 -1950 740 {lab=out3}
N -1950 570 -1950 740 {lab=out3}
N -2000 630 -1980 630 {lab=GND}
N -1980 630 -1980 660 {lab=GND}
N -2000 660 -1980 660 {lab=GND}
N -2000 510 -1980 510 {lab=VDD}
N -1980 480 -1980 510 {lab=VDD}
N -2000 480 -1980 480 {lab=VDD}
N -2240 570 -2210 570 {lab=out2}
N -2000 970 -2000 1030 {lab=out4}
N -2060 940 -2040 940 {lab=out3}
N -2060 940 -2060 1060 {lab=out3}
N -2060 1060 -2040 1060 {lab=out3}
N -2000 890 -2000 910 {lab=VDD}
N -2000 1090 -2000 1120 {lab=GND}
N -2150 1000 -2060 1000 {lab=out3}
N -2000 1000 -1880 1000 {lab=out4}
N -2110 1170 -2050 1170 {lab=out3}
N -2110 1000 -2110 1170 {lab=out3}
N -1990 1170 -1950 1170 {lab=out4}
N -1950 1000 -1950 1170 {lab=out4}
N -2000 1060 -1980 1060 {lab=GND}
N -1980 1060 -1980 1090 {lab=GND}
N -2000 1090 -1980 1090 {lab=GND}
N -2000 940 -1980 940 {lab=VDD}
N -1980 910 -1980 940 {lab=VDD}
N -2000 910 -1980 910 {lab=VDD}
N -2240 1000 -2210 1000 {lab=out3}
N -1980 -220 -1920 -220 {lab=#net1}
N -1860 -220 -1720 -220 {lab=out1}
N -2270 150 -2210 150 {lab=out1}
N -2280 1380 -2230 1380 {lab=out4}
N -2260 1420 -2230 1420 {lab=det}
N -2280 1420 -2260 1420 {lab=det}
N -2060 1400 -2030 1400 {lab=opout}
N -2280 1420 -2280 1580 {lab=det}
N -1920 1400 -1840 1400 {lab=det}
N -1840 1400 -1840 1440 {lab=det}
N -1840 1500 -1840 1540 {lab=VREF}
N -2030 1400 -2000 1400 {lab=opout}
N -1970 1360 -1940 1360 {lab=det}
N -1940 1360 -1940 1400 {lab=det}
N -1970 1400 -1970 1420 {lab=det}
N -1970 1420 -1940 1420 {lab=det}
N -1940 1400 -1940 1420 {lab=det}
N -2120 1580 -2120 1600 {lab=opout}
N -2120 1600 -2090 1600 {lab=opout}
N -2090 1580 -2090 1600 {lab=opout}
N -2120 1540 -2090 1540 {lab=opout}
N -2090 1540 -2090 1580 {lab=opout}
N -2060 1400 -2060 1580 {lab=opout}
N -1920 1400 -1920 1640 {lab=det}
N -2280 1640 -1920 1640 {lab=det}
N -2280 1580 -2280 1640 {lab=det}
N -2190 1430 -2190 1500 {lab=VREF}
N -2190 1580 -2150 1580 {lab=VREF}
N -2090 1580 -2060 1580 {lab=opout}
N -1940 1400 -1920 1400 {lab=det}
N -2190 1370 -2160 1370 {lab=#net6}
N -2160 1370 -2160 1400 {lab=#net6}
N -2100 1400 -2060 1400 {lab=opout}
N -2210 570 -2150 570 {lab=out2}
N -2210 1000 -2150 1000 {lab=out3}
N -2000 1850 -2000 1910 {lab=det2}
N -2060 1820 -2040 1820 {lab=#net7}
N -2060 1820 -2060 1940 {lab=#net7}
N -2060 1940 -2040 1940 {lab=#net7}
N -2000 1770 -2000 1790 {lab=VDD}
N -2000 1970 -2000 2000 {lab=GND}
N -2150 1880 -2060 1880 {lab=#net7}
N -2000 1880 -1880 1880 {lab=det2}
N -2110 2050 -2050 2050 {lab=#net7}
N -2110 1880 -2110 2050 {lab=#net7}
N -1990 2050 -1950 2050 {lab=det2}
N -1950 1880 -1950 2050 {lab=det2}
N -2000 1940 -1980 1940 {lab=GND}
N -1980 1940 -1980 1970 {lab=GND}
N -2000 1970 -1980 1970 {lab=GND}
N -2000 1820 -1980 1820 {lab=VDD}
N -1980 1790 -1980 1820 {lab=VDD}
N -2000 1790 -1980 1790 {lab=VDD}
N -2210 1880 -2150 1880 {lab=#net7}
N -2320 1880 -2270 1880 {lab=det}
N -2110 2110 -2050 2110 {lab=#net7}
N -2110 2050 -2110 2110 {lab=#net7}
N -1990 2110 -1950 2110 {lab=det2}
N -1950 2050 -1950 2110 {lab=det2}
N -2360 -650 -2360 -610 {lab=#net8}
N -2080 -630 -2030 -630 {lab=#net9}
N -2030 -650 -2030 -630 {lab=#net9}
N -2210 -660 -2180 -660 {lab=#net10}
N -2180 -660 -2180 -630 {lab=#net10}
N -2120 -630 -2080 -630 {lab=#net9}
N -2360 -630 -2320 -630 {lab=#net8}
N -2320 -650 -2320 -630 {lab=#net8}
N -2320 -650 -2250 -650 {lab=#net8}
N -2280 -610 -2250 -610 {lab=#net9}
N -2280 -610 -2280 -520 {lab=#net9}
N -2280 -520 -2080 -520 {lab=#net9}
N -2080 -630 -2080 -520 {lab=#net9}
N -2210 -600 -2210 -550 {lab=GND}
N -2480 -370 -2480 -350 {lab=in}
N -2480 -290 -2480 -40 {lab=GND}
C {devices/code_shown.sym} -1935 -900 0 0 {name=control1 only_toplevel=false value=".option savecurrent
.control
save all
# Transienst analysis
tran 0.1u 10m 0 0.1u
write tb_am_radio_tran.raw
.endc"}
C {devices/gnd.sym} -2480 -40 0 0 {name=l1 lab=GND}
C {devices/lab_pin.sym} -2480 -370 0 1 {name=p8 sig_type=std_logic lab=in}
C {devices/vdd.sym} -2480 -650 0 0 {name=l5 lab=VDD}
C {devices/gnd.sym} -2480 -550 0 0 {name=l6 lab=GND}
C {devices/vsource.sym} -2480 -600 0 0 {name=V1 value="dc 5" savecurrent=false}
C {devices/vdd.sym} -2030 -710 0 0 {name=l7 lab=VREF}
C {devices/asrc.sym} -2480 -320 0 0 {name=B2 function="V=5m*(1+0.5*sin(2*pi*1k*time))*sin(2*pi*500k*time)+5m*(1+0.5*sin(2*pi*3k*time))*sin(2*pi*1000k*time)+5m*(1+0.5*sin(2*pi*5k*time))*sin(2*pi*1500k*time)"}
C {devices/code.sym} -2110 -900 0 0 {name=TR-1
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/capa.sym} -2120 -170 0 1 {name=C1
m=1
value=76.75p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} -1980 -60 0 1 {name=l12 lab=VREF}
C {devices/lab_pin.sym} -2090 -380 0 0 {name=p9 sig_type=std_logic lab=in}
C {devices/ind.sym} -2060 -170 0 1 {name=L14
m=1
value=330u
footprint=1206
device=inductor}
C {devices/k.sym} -2020 -170 0 1 {name=K1 K=0.9 L1=L17 L2=L14}
C {devices/ind.sym} -1980 -170 0 0 {name=L17
m=1
value=330u
footprint=1206
device=inductor}
C {devices/lab_pin.sym} -1720 -220 0 1 {name=p10 sig_type=std_logic lab=out1}
C {devices/gnd.sym} -2090 -40 0 1 {name=l19 lab=GND}
C {devices/res.sym} -2060 -90 0 1 {name=R2
value=10
footprint=1206
device=resistor
m=1}
C {devices/res.sym} -2090 -270 0 1 {name=R1
value=1000
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} -2090 -350 0 1 {name=C2
m=1
value=5p
footprint=1206
device="ceramic capacitor"}
C {MP.sym} -2040 90 0 0 {name=M1 model=PMOS w=30u l=5u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} -2040 210 0 0 {name=M2 model=NMOS w=10u l=5u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/gnd.sym} -2000 270 0 1 {name=l2 lab=GND}
C {devices/vdd.sym} -2000 40 0 0 {name=l3 lab=VDD}
C {devices/res.sym} -2020 320 3 1 {name=R3
value=100k
footprint=1206
device=resistor
m=1}
C {devices/lab_pin.sym} -2300 150 0 0 {name=p3 sig_type=std_logic lab=out1}
C {devices/lab_pin.sym} -1880 150 0 1 {name=p11 sig_type=std_logic lab=out2}
C {devices/capa.sym} -1890 -220 1 1 {name=C3
m=1
value=22u
footprint=1206
device="ceramic capacitor"}
C {MP.sym} -2040 510 0 0 {name=M3 model=PMOS w=30u l=5u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} -2040 630 0 0 {name=M4 model=NMOS w=10u l=5u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/gnd.sym} -2000 690 0 1 {name=l4 lab=GND}
C {devices/vdd.sym} -2000 460 0 0 {name=l8 lab=VDD}
C {devices/res.sym} -2020 740 3 1 {name=R4
value=100k
footprint=1206
device=resistor
m=1}
C {devices/lab_pin.sym} -2240 570 0 0 {name=p12 sig_type=std_logic lab=out2}
C {devices/lab_pin.sym} -1880 570 0 1 {name=p13 sig_type=std_logic lab=out3}
C {MP.sym} -2040 940 0 0 {name=M5 model=PMOS w=30u l=5u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} -2040 1060 0 0 {name=M6 model=NMOS w=10u l=5u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/gnd.sym} -2000 1120 0 1 {name=l9 lab=GND}
C {devices/vdd.sym} -2000 890 0 0 {name=l11 lab=VDD}
C {devices/res.sym} -2020 1170 3 1 {name=R5
value=100k
footprint=1206
device=resistor
m=1}
C {devices/lab_pin.sym} -2240 1000 0 0 {name=p14 sig_type=std_logic lab=out3}
C {devices/lab_pin.sym} -1880 1000 0 1 {name=p15 sig_type=std_logic lab=out4}
C {devices/res.sym} -2180 150 3 1 {name=R6
value=5k
footprint=1206
device=resistor
m=1}
C {devices/lab_pin.sym} -2080 1400 0 1 {name=p16 sig_type=std_logic lab=opout}
C {devices/lab_pin.sym} -2280 1380 0 0 {name=p17 sig_type=std_logic lab=out4}
C {devices/vcvs.sym} -2190 1400 0 0 {name=E2 value=10000}
C {devices/lab_pin.sym} -1840 1400 0 1 {name=p18 sig_type=std_logic lab=det}
C {devices/lab_pin.sym} -1840 1540 0 0 {name=p19 sig_type=std_logic lab=VREF}
C {MP.sym} -2120 1540 1 0 {name=M7 model=PMOS w=2u l=1u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} -1970 1360 1 0 {name=M8 model=PMOS w=2u l=1u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/lab_pin.sym} -2190 1500 0 0 {name=p20 sig_type=std_logic lab=VREF}
C {devices/lab_pin.sym} -2190 1580 0 0 {name=p21 sig_type=std_logic lab=VREF}
C {devices/res.sym} -1840 1470 0 0 {name=R8
value=100k
footprint=1206
device=resistor
m=1}
C {devices/res.sym} -2130 1400 3 0 {name=R9
value=10k
footprint=1206
device=resistor
m=1}
C {MP.sym} -2040 1820 0 0 {name=M9 model=PMOS w=30u l=5u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} -2040 1940 0 0 {name=M10 model=NMOS w=10u l=5u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/gnd.sym} -2000 2000 0 1 {name=l13 lab=GND}
C {devices/vdd.sym} -2000 1770 0 0 {name=l15 lab=VDD}
C {devices/res.sym} -2020 2050 3 1 {name=R10
value=100k
footprint=1206
device=resistor
m=1}
C {devices/lab_pin.sym} -2320 1880 0 0 {name=p1 sig_type=std_logic lab=det}
C {devices/lab_pin.sym} -1880 1880 0 1 {name=p2 sig_type=std_logic lab=det2}
C {devices/res.sym} -2240 1880 3 1 {name=R11
value=100k
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} -2020 2110 3 1 {name=C4
m=1
value=8p
footprint=1206
device="ceramic capacitor"}
C {devices/ammeter.sym} -2030 -680 2 0 {name=Vmeas savecurrent=true spice_ignore=0}
C {devices/res.sym} -2360 -580 0 1 {name=R7
value=50k
footprint=1206
device=resistor
m=1}
C {devices/res.sym} -2360 -680 0 1 {name=R12
value=50k
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} -2360 -550 0 0 {name=l16 lab=GND}
C {devices/vdd.sym} -2360 -710 0 0 {name=l18 lab=VDD}
C {devices/vcvs.sym} -2210 -630 0 0 {name=E1 value=10000}
C {devices/res.sym} -2150 -630 3 0 {name=R13
value=10
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} -2210 -550 0 0 {name=l10 lab=GND}
