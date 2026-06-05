v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
L 4 60 -1000 60 -940 {}
L 4 60 -940 620 -940 {}
L 4 620 -1000 620 -940 {}
L 4 360 -1300 360 -1180 {}
L 4 360 -1180 520 -1240 {}
L 4 360 -1300 520 -1240 {}
L 4 540 -180 540 -120 {}
L 4 540 -120 1040 -120 {}
L 4 1040 -180 1040 -120 {}
L 4 1080 -180 1080 -120 {}
L 4 1080 -120 1640 -120 {}
L 4 1640 -180 1640 -120 {}
L 4 60 -180 60 -120 {}
L 4 60 -120 500 -120 {}
L 4 500 -180 500 -120 {}
L 4 1720 -180 1720 -120 {}
L 4 1720 -120 1980 -120 {}
L 4 1980 -180 1980 -120 {}
B 2 2030 -1080 2740 -540 {flags=graph
y1=0.063
y2=5
ypos1=0
ypos2=2
divy=5
subdivy=4
unity=1
x1=0
divx=5
subdivx=4

unitx=1
dataset=-1
sim_type=dc
logx=0
logy=0
legend=1
x2=5
hilight_wave=0
autoload=1
rawfile=$netlist_dir/tb_cascode_opamp_dc.raw
rainbow=1
color="11 8"
node="out1
out2"}
B 2 2030 -540 2740 0 {flags=graph
y1=-1
ypos1=0
ypos2=2
divy=5
subdivy=8
unity=1
x1=0
divx=5
subdivx=4

unitx=1
dataset=-1
sim_type=dc
color=4
node=dc_gain
logx=0
logy=1
legend=1
x2=5
hilight_wave=0
autoload=1
rawfile=$netlist_dir/tb_cascode_opamp_dc.raw
rainbow=1
y2=4}
B 2 2770 -1080 3480 -540 {flags=graph
y1=30
ypos1=0
ypos2=2
divy=5
subdivy=4
unity=1
divx=5
subdivx=8

unitx=1
dataset=-1
sim_type=ac
logx=1
logy=0
legend=1
hilight_wave=0
autoload=1
rawfile=$netlist_dir/tb_cascode_opamp_ac.raw
rainbow=1
digital=0
x1=4
color=4
node=re(ac_gain_db)
y2=70
x2=6}
B 2 2770 -540 3480 0 {flags=graph
ypos1=0
ypos2=2
divy=5
subdivy=4
unity=1
divx=5
subdivx=8

unitx=1
dataset=-1
sim_type=ac
logx=1
logy=0
legend=1
hilight_wave=0
autoload=1
rawfile=$netlist_dir/tb_cascode_opamp_ac.raw
rainbow=0
digital=0
x1=4
y1=-180
y2=180
color=4
node=ac_phase_deg
x2=6}
B 2 3510 -1080 4220 -540 {flags=graph
y1=1.35
y2=1.45
ypos1=0
ypos2=2
divy=5
subdivy=4
unity=1
x1=2.1175824e-22
divx=5
subdivx=4

unitx=1
dataset=-1
sim_type=tran
logx=0
logy=0
legend=1
x2=2e-05
hilight_wave=0
autoload=1
rawfile=$netlist_dir/tb_cascode_opamp_tran.raw
rainbow=1
color=4
node=vin_p}
B 2 3510 -540 4220 0 {flags=graph
y1=1.2
y2=2.5
ypos1=0
ypos2=2
divy=5
subdivy=4
unity=1
x1=2.1175824e-22
divx=5
subdivx=4

unitx=1
dataset=-1
sim_type=tran
logx=0
logy=0
legend=1
x2=2e-05
hilight_wave=0
autoload=1
rawfile=$netlist_dir/tb_cascode_opamp_tran.raw
rainbow=1
color=11
node=out2}
T {Telescopic cascode two stage opamp} 30 -1390 0 0 1 1 {}
T {Test circuit - 60db AMP} 210 -920 0 0 0.4 0.4 {}
T {DC analysis} 2280 -1150 0 0 0.8 0.8 {}
T {AC analysis} 3020 -1150 0 0 0.8 0.8 {}
T {TRAN analysis} 3750 -1150 0 0 0.8 0.8 {}
T {Cascoded Differential amp} 660 -100 0 0 0.4 0.4 {}
T {Phase compensation} 1270 -100 0 0 0.4 0.4 {}
T {Bias} 260 -100 0 0 0.4 0.4 {}
T {Common source amp} 1740 -100 0 0 0.4 0.4 {}
N 1860 -360 1860 -300 {
lab=OUT2}
N 1860 -240 1860 -210 {
lab=GND}
N 1860 -460 1860 -440 {
lab=VDD}
N 1860 -330 1900 -330 {
lab=OUT2}
N 1860 -410 1880 -410 {
lab=VDD}
N 1880 -450 1880 -410 {
lab=VDD}
N 1860 -450 1880 -450 {
lab=VDD}
N 1860 -270 1870 -270 {
lab=GND}
N 1870 -270 1870 -230 {
lab=GND}
N 1860 -230 1870 -230 {
lab=GND}
N 1860 -380 1860 -360 {
lab=OUT2}
N 1790 -410 1820 -410 {
lab=iB}
N 1860 -480 1860 -460 {
lab=VDD}
N 1860 -210 1860 -200 {
lab=GND}
N 680 -800 680 -780 {lab=VDD}
N 680 -800 880 -800 {lab=VDD}
N 880 -800 880 -780 {lab=VDD}
N 780 -840 780 -800 {lab=VDD}
N 720 -730 840 -730 {lab=#net1}
N 680 -780 680 -760 {lab=VDD}
N 880 -780 880 -760 {lab=VDD}
N 680 -700 680 -660 {lab=#net1}
N 880 -700 880 -660 {lab=#net2}
N 720 -630 840 -630 {lab=#net3}
N 680 -680 760 -680 {lab=#net1}
N 880 -730 890 -730 {lab=VDD}
N 960 -800 960 -730 {lab=VDD}
N 880 -800 960 -800 {lab=VDD}
N 600 -730 680 -730 {lab=VDD}
N 600 -800 600 -730 {lab=VDD}
N 600 -800 680 -800 {lab=VDD}
N 680 -600 680 -560 {lab=#net3}
N 880 -600 880 -560 {lab=OUT1}
N 760 -730 760 -680 {lab=#net1}
N 680 -580 760 -580 {lab=#net3}
N 760 -630 760 -580 {lab=#net3}
N 720 -530 840 -530 {lab=VB2}
N 780 -530 780 -500 {lab=VB2}
N 880 -530 920 -530 {lab=GND}
N 880 -630 960 -630 {lab=VDD}
N 960 -730 960 -630 {lab=VDD}
N 600 -630 680 -630 {lab=VDD}
N 600 -730 600 -630 {lab=VDD}
N 640 -530 680 -530 {lab=GND}
N 680 -500 680 -460 {lab=#net4}
N 880 -500 880 -460 {lab=#net5}
N 680 -430 730 -430 {lab=GND}
N 730 -430 880 -430 {lab=GND}
N 770 -430 770 -400 {lab=GND}
N 600 -430 640 -430 {lab=VIN_N}
N 920 -430 960 -430 {lab=VIN_P}
N 680 -400 680 -340 {lab=#net6}
N 680 -340 880 -340 {lab=#net6}
N 880 -400 880 -340 {lab=#net6}
N 780 -340 780 -320 {lab=#net6}
N 780 -290 810 -290 {lab=GND}
N 710 -290 740 -290 {lab=VB1}
N 780 -260 780 -200 {lab=GND}
N 880 -580 980 -580 {lab=OUT1}
N 1790 -270 1820 -270 {lab=OUT1}
N 1450 -520 1470 -520 {
lab=#net7}
N 1200 -360 1200 -340 {
lab=#net8}
N 1150 -350 1200 -350 {
lab=#net8}
N 1150 -350 1150 -310 {
lab=#net8}
N 1150 -310 1160 -310 {
lab=#net8}
N 1200 -280 1200 -200 {lab=GND}
N 1200 -310 1300 -310 {lab=GND}
N 1300 -310 1300 -240 {lab=GND}
N 1200 -240 1300 -240 {lab=GND}
N 1200 -390 1300 -390 {lab=GND}
N 1300 -390 1300 -310 {lab=GND}
N 1360 -520 1390 -520 {lab=OUT1}
N 1470 -520 1480 -520 {lab=#net7}
N 1540 -520 1560 -520 {lab=OUT2}
N 320 -260 320 -200 {lab=GND}
N 320 -340 400 -340 {lab=VB1}
N 360 -290 400 -290 {lab=VB1}
N 240 -290 320 -290 {lab=GND}
N 240 -290 240 -220 {lab=GND}
N 240 -220 320 -220 {lab=GND}
N 400 -290 440 -290 {lab=VB1}
N 360 -390 440 -390 {lab=VB2}
N 400 -340 400 -290 {lab=VB1}
N 320 -360 320 -320 {lab=VB1}
N 320 -680 320 -640 {lab=VDD}
N 320 -610 400 -610 {lab=VDD}
N 400 -660 400 -610 {lab=VDD}
N 320 -660 400 -660 {lab=VDD}
N 320 -580 320 -540 {lab=#net9}
N 320 -480 320 -440 {lab=VB2}
N 320 -510 400 -510 {lab=VDD}
N 400 -610 400 -510 {lab=VDD}
N 180 -610 280 -610 {lab=VB4}
N 140 -580 140 -540 {lab=VB4}
N 180 -510 280 -510 {lab=iB}
N 140 -560 200 -560 {lab=VB4}
N 200 -610 200 -560 {lab=VB4}
N 140 -480 140 -420 {lab=iB}
N 140 -460 200 -460 {lab=iB}
N 200 -510 200 -460 {lab=iB}
N 140 -680 140 -640 {lab=VDD}
N 240 -610 240 -560 {lab=VB4}
N 1830 -840 1870 -840 {lab=VDD}
N 1830 -800 1870 -800 {lab=GND}
N 1830 -760 1870 -760 {lab=VIN_P}
N 1830 -720 1870 -720 {lab=VIN_N}
N 1830 -680 1870 -680 {lab=OUT2}
N 1510 -500 1510 -470 {lab=GND}
N 60 -610 140 -610 {lab=VDD}
N 60 -660 60 -610 {lab=VDD}
N 60 -660 140 -660 {lab=VDD}
N 60 -510 140 -510 {lab=VDD}
N 60 -610 60 -510 {lab=VDD}
N 140 -1140 140 -1120 {lab=GND}
N 220 -1140 220 -1120 {lab=GND}
N 140 -1220 140 -1200 {lab=VDD}
N 320 -1220 360 -1220 {lab=VIN_N}
N 320 -1220 320 -1120 {lab=VIN_N}
N 320 -1120 400 -1120 {lab=VIN_N}
N 520 -1240 540 -1240 {lab=OUT2}
N 540 -1240 540 -1120 {lab=OUT2}
N 460 -1120 540 -1120 {lab=OUT2}
N 240 -1260 360 -1260 {lab=VIN_P}
N 220 -1260 220 -1200 {lab=VIN_P}
N 60 -1140 60 -1120 {lab=GND}
N 60 -1220 60 -1200 {lab=VREF}
N 540 -1240 580 -1240 {lab=OUT2}
N 580 -1240 580 -1190 {lab=OUT2}
N 580 -1130 580 -1110 {lab=GND}
N 220 -1260 240 -1260 {lab=VIN_P}
N 440 -1210 440 -1190 {lab=GND}
N 140 -420 140 -400 {lab=iB}
N 440 -1290 440 -1270 {lab=VDD}
N 580 -1240 600 -1240 {lab=OUT2}
N 1420 -600 1420 -520 {lab=GND}
N 320 -440 320 -420 {lab=VB2}
N 320 -440 400 -440 {lab=VB2}
N 400 -440 400 -390 {lab=VB2}
N 240 -390 320 -390 {lab=GND}
N 240 -390 240 -290 {lab=GND}
N 890 -730 960 -730 {lab=VDD}
N 1200 -680 1200 -640 {lab=VDD}
N 1200 -610 1280 -610 {lab=VDD}
N 1280 -660 1280 -610 {lab=VDD}
N 1200 -660 1280 -660 {lab=VDD}
N 1200 -580 1200 -540 {lab=#net10}
N 1200 -480 1200 -440 {lab=#net11}
N 1200 -510 1280 -510 {lab=VDD}
N 1280 -610 1280 -510 {lab=VDD}
N 1200 -440 1200 -420 {lab=#net11}
N 240 -510 240 -480 {lab=iB}
N 1120 -610 1160 -610 {lab=VB4}
N 1120 -510 1160 -510 {lab=VB3}
N 1140 -390 1160 -390 {lab=#net11}
N 1140 -440 1140 -390 {lab=#net11}
N 1140 -440 1200 -440 {lab=#net11}
N 1200 -440 1420 -440 {lab=#net11}
N 1420 -480 1420 -440 {lab=#net11}
N 600 -1240 660 -1240 {lab=OUT2}
N 660 -1240 680 -1240 {lab=OUT2}
N 660 -1130 660 -1110 {lab=GND}
N 660 -1240 660 -1190 {lab=OUT2}
N 320 -1120 320 -1100 {lab=VIN_N}
N 320 -1040 320 -1010 {lab=VREF}
N 1830 -640 1870 -640 {lab=VIN_N}
C {devices/code.sym} 1230 -1270 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {MP.sym} 840 -730 0 0 {name=MM2 model=PMOS w=30u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MN.sym} 840 -530 0 0 {name=MM4 model=NMOS w=10u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {devices/opin.sym} 1870 -680 0 0 {name=p17 lab=OUT2}
C {MP.sym} 1820 -410 0 0 {name=MM7 model=PMOS w=300u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MN.sym} 1820 -270 0 0 {name=MM8 model=NMOS w=200u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MP.sym} 720 -730 0 1 {name=MM16 model=PMOS w=30u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MP.sym} 840 -630 0 0 {name=MM17 model=PMOS w=30u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MP.sym} 720 -630 0 1 {name=MM18 model=PMOS w=30u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MN.sym} 720 -530 0 1 {name=MM19 model=NMOS w=10u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MN.sym} 920 -430 0 1 {name=MM20 model=NMOS w=80u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MN.sym} 640 -430 0 0 {name=MM21 model=NMOS w=80u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {devices/lab_pin.sym} 920 -530 0 1 {name=p20 sig_type=std_logic lab=GND}
C {devices/lab_pin.sym} 640 -530 0 0 {name=p21 sig_type=std_logic lab=GND}
C {devices/lab_pin.sym} 780 -500 0 1 {name=p23 sig_type=std_logic lab=VB2}
C {devices/ipin.sym} 1870 -720 0 1 {name=p24 lab=VIN_N}
C {devices/ipin.sym} 1870 -760 0 1 {name=p25 lab=VIN_P}
C {MN.sym} 740 -290 0 0 {name=MM22 model=NMOS w=10u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {devices/lab_pin.sym} 810 -290 0 1 {name=p26 sig_type=std_logic lab=GND}
C {devices/lab_pin.sym} 710 -290 0 0 {name=p27 sig_type=std_logic lab=VB1}
C {devices/lab_pin.sym} 780 -200 0 1 {name=p28 sig_type=std_logic lab=GND}
C {devices/lab_pin.sym} 780 -840 0 1 {name=p29 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 1790 -410 0 0 {name=p9 sig_type=std_logic lab=iB}
C {devices/lab_pin.sym} 1860 -480 0 1 {name=p10 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 1860 -200 0 1 {name=p11 sig_type=std_logic lab=GND}
C {devices/lab_pin.sym} 980 -580 0 1 {name=p12 sig_type=std_logic lab=OUT1}
C {devices/lab_pin.sym} 1790 -270 0 0 {name=p13 sig_type=std_logic lab=OUT1}
C {MN.sym} 1420 -480 1 1 {name=MM3 model=NMOS w=20u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {CSIO.sym} 1480 -520 3 0 {name=CC2
model=F_CSIO
c=0.1p
x=120u
y=120u
m=1}
C {MN.sym} 1160 -390 0 0 {name=MM5 model=NMOS w=20u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MN.sym} 1160 -310 0 0 {name=MM6 model=NMOS w=20u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {devices/lab_pin.sym} 1200 -200 0 1 {name=p14 sig_type=std_logic lab=GND}
C {devices/lab_pin.sym} 1360 -520 0 0 {name=p15 sig_type=std_logic lab=OUT1}
C {devices/lab_pin.sym} 1560 -520 0 1 {name=p16 sig_type=std_logic lab=OUT2}
C {MN.sym} 360 -390 0 1 {name=MM13 model=NMOS w=10u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MN.sym} 360 -290 0 1 {name=MM14 model=NMOS w=10u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {devices/lab_pin.sym} 320 -200 0 1 {name=p18 sig_type=std_logic lab=GND}
C {devices/lab_pin.sym} 780 -840 0 1 {name=p19 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 320 -680 0 1 {name=p30 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 440 -290 0 1 {name=p31 sig_type=std_logic lab=VB1}
C {devices/lab_pin.sym} 440 -390 0 1 {name=p32 sig_type=std_logic lab=VB2}
C {MP.sym} 180 -610 0 1 {name=MM23 model=PMOS w=30u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MP.sym} 280 -510 0 0 {name=MM24 model=PMOS w=30u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MP.sym} 280 -610 0 0 {name=MM25 model=PMOS w=30u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MP.sym} 180 -510 0 1 {name=MM26 model=PMOS w=30u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {devices/lab_pin.sym} 140 -680 0 1 {name=p34 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 600 -430 0 0 {name=p35 sig_type=std_logic lab=VIN_N}
C {devices/lab_pin.sym} 960 -430 0 1 {name=p36 sig_type=std_logic lab=VIN_P}
C {devices/lab_pin.sym} 1900 -330 0 1 {name=p37 sig_type=std_logic lab=OUT2}
C {devices/ipin.sym} 1870 -800 0 1 {name=p38 lab=GND}
C {devices/ipin.sym} 1870 -840 0 1 {name=p39 lab=VDD}
C {devices/lab_pin.sym} 240 -560 0 1 {name=p40 sig_type=std_logic lab=VB4}
C {devices/lab_pin.sym} 1830 -840 0 0 {name=p41 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 1830 -800 0 0 {name=p42 sig_type=std_logic lab=GND}
C {devices/lab_pin.sym} 1830 -760 0 0 {name=p43 sig_type=std_logic lab=VIN_P}
C {devices/lab_pin.sym} 1830 -720 0 0 {name=p44 sig_type=std_logic lab=VIN_N}
C {devices/lab_pin.sym} 1830 -680 0 0 {name=p45 sig_type=std_logic lab=OUT2}
C {devices/lab_pin.sym} 1510 -470 0 1 {name=p1 sig_type=std_logic lab=GND}
C {devices/code_shown.sym} 820 -1250 0 0 {name=NGSPICE only_toplevel=true
value=".control
save all
save currents
* DC analysis
dc v2 0 5 1m rload 10k 100k 20k
let dc_gain=deriv(OUT2)
write tb_cascode_opamp_dc.raw
* AC analysis
ac dec 10 1k 10Meg
let ac_gain = OUT2 / vin_p
let ac_gain_db = db(ac_gain)
let ac_phase_deg = (180 / PI) * cph(ac_gain)
write tb_cascode_opamp_ac.raw
* TRAN analysis
tran 0.1u 20u
write tb_cascode_opamp_tran.raw
.endc
"}
C {devices/launcher.sym} 2095 -1205 0 0 {name=h1
descr="Click left mouse button here with CTRL key
to reload waveforms in graph."
tclcommand="
xschem raw_read $netlist_dir/tb_cascode_opamp_dc.raw
xschem raw_read $netlist_dir/tb_cascode_opamp_ac.raw
xschem raw_read $netlist_dir/tb_cascode_opamp_tran.raw
"
}
C {devices/vdd.sym} 140 -1220 0 0 {name=l2 lab=VDD}
C {devices/gnd.sym} 140 -1120 0 0 {name=l3 lab=GND}
C {devices/vsource.sym} 140 -1170 0 0 {name=V1 value=5 savecurrent=false}
C {devices/res.sym} 430 -1120 1 0 {name=R2
value=1Meg
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 220 -1120 0 0 {name=l21 lab=GND}
C {devices/vsource.sym} 220 -1170 0 0 {name=V2 value="dc 1.4 ac 1 sin(1.4 1m 500k 0 0 0)" savecurrent=false}
C {devices/vdd.sym} 60 -1220 0 0 {name=l22 lab=VREF}
C {devices/gnd.sym} 60 -1120 0 0 {name=l23 lab=GND}
C {devices/vsource.sym} 60 -1170 0 0 {name=V4 value=1.4 savecurrent=false}
C {devices/res.sym} 580 -1160 0 0 {name=RLOAD
value=100k
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 580 -1110 0 0 {name=l7 lab=GND}
C {devices/gnd.sym} 440 -1190 0 0 {name=l17 lab=GND}
C {devices/vdd.sym} 440 -1290 0 0 {name=l4 lab=VDD}
C {devices/lab_pin.sym} 680 -1240 0 1 {name=l6 sig_type=std_logic lab=OUT2}
C {devices/lab_pin.sym} 220 -1260 0 0 {name=l8 sig_type=std_logic lab=VIN_P}
C {devices/lab_pin.sym} 320 -1220 0 0 {name=l9 sig_type=std_logic lab=VIN_N}
C {devices/lab_pin.sym} 1420 -600 0 1 {name=p2 sig_type=std_logic lab=GND}
C {devices/lab_pin.sym} 1200 -680 0 1 {name=p3 sig_type=std_logic lab=VDD}
C {MP.sym} 1160 -510 0 0 {name=MM1 model=PMOS w=30u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MP.sym} 1160 -610 0 0 {name=MM9 model=PMOS w=30u l=1u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {devices/lab_pin.sym} 1120 -610 0 0 {name=p4 sig_type=std_logic lab=VB4}
C {devices/lab_pin.sym} 240 -480 0 1 {name=p5 sig_type=std_logic lab=iB}
C {devices/lab_pin.sym} 1120 -510 0 0 {name=p6 sig_type=std_logic lab=VB3}
C {devices/lab_pin.sym} 770 -400 0 1 {name=p7 sig_type=std_logic lab=GND}
C {devices/capa.sym} 660 -1160 0 0 {name=C1
m=1
value=24p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 660 -1110 0 0 {name=l1 lab=GND}
C {devices/gnd.sym} 320 -1010 0 0 {name=l5 lab=VREF}
C {devices/res.sym} 320 -1070 2 0 {name=R1
value=1k
footprint=1206
device=resistor
m=1}
C {devices/lab_pin.sym} 140 -400 0 1 {name=p8 sig_type=std_logic lab=iB}
C {devices/ipin.sym} 1870 -640 0 1 {name=p22 lab=iB}
C {devices/lab_pin.sym} 1830 -640 0 0 {name=p33 sig_type=std_logic lab=iB}
