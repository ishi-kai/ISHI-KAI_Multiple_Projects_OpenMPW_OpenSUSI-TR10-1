v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
L 4 -520 -350 -400 -280 {}
L 4 -520 -210 -400 -280 {}
L 4 -520 -350 -520 -210 {}
B 2 80 -430 880 -30 {flags=graph
y2=4.3684345
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=-0.0001
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
color=4
node=in
x2=0.0009
autoload=0
rawfile=$netlist_dir/tb_am_detection_tr.raw
y1=1.856e-06
sim_type=tran}
B 2 80 30 880 430 {flags=graph
y1=0.41082488
y2=5.2668085
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=-0.0001
x2=0.0009
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
rawfile=$netlist_dir/tb_am_detection_tr.raw
color=4
node=out
sim_type=tran}
B 2 920 30 1720 430 {flags=graph
y1=1.5750892
y2=6.0604483
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=-0.0001
x2=0.0009
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node=opout
color=4
dataset=-1
unitx=1
logx=0
logy=0
rawfile=$netlist_dir/tb_am_detection_tr.raw
sim_type=tran}
B 2 920 -430 1720 -30 {flags=graph
y1=2
y2=4
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=-0.0001
x2=0.0009
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
sim_type=tran}
T {IDEAL_DIODE} -410 -475 0 0 0.5 0.5 {}
N -120 480 -120 500 {lab=GND}
N -120 380 -120 420 {lab=in}
N -210 400 -210 420 {lab=VDD}
N -210 480 -210 500 {lab=GND}
N -290 400 -290 420 {lab=VREF}
N -290 480 -290 500 {lab=GND}
N -580 -300 -530 -300 {lab=in}
N -560 -260 -530 -260 {lab=out}
N -580 -260 -560 -260 {lab=out}
N -360 -280 -330 -280 {lab=opout}
N -580 -260 -580 -100 {lab=out}
N -220 -280 -140 -280 {lab=out}
N -140 -280 -140 -240 {lab=out}
N -140 -180 -140 -140 {lab=VREF}
N -330 -280 -300 -280 {lab=opout}
N -270 -320 -240 -320 {lab=out}
N -240 -320 -240 -280 {lab=out}
N -270 -280 -270 -260 {lab=out}
N -270 -260 -240 -260 {lab=out}
N -240 -280 -240 -260 {lab=out}
N -420 -100 -420 -80 {lab=opout}
N -420 -80 -390 -80 {lab=opout}
N -390 -100 -390 -80 {lab=opout}
N -420 -140 -390 -140 {lab=opout}
N -390 -140 -390 -100 {lab=opout}
N -360 -280 -360 -100 {lab=opout}
N -220 -280 -220 -40 {lab=out}
N -580 -40 -220 -40 {lab=out}
N -580 -100 -580 -40 {lab=out}
N -490 -250 -490 -180 {lab=VREF}
N -490 -100 -450 -100 {lab=VREF}
N -430 100 -430 120 {lab=out2}
N -430 120 -400 120 {lab=out2}
N -400 100 -400 120 {lab=out2}
N -430 60 -400 60 {lab=out2}
N -400 60 -400 100 {lab=out2}
N -400 100 -370 100 {lab=out2}
N -140 100 -140 140 {lab=out2}
N -140 200 -140 240 {lab=VREF}
N -370 100 -140 100 {lab=out2}
N -390 -100 -360 -100 {lab=opout}
N -240 -280 -220 -280 {lab=out}
N -490 -310 -460 -310 {lab=#net1}
N -460 -310 -460 -280 {lab=#net1}
N -400 -280 -360 -280 {lab=opout}
N -590 100 -460 100 {lab=in}
C {devices/code.sym} -480 410 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/gnd.sym} -120 500 0 0 {name=l2 lab=GND}
C {devices/lab_pin.sym} -120 380 0 1 {name=p1 sig_type=std_logic lab=in}
C {devices/vdd.sym} -210 400 0 0 {name=l3 lab=VDD}
C {devices/gnd.sym} -210 500 0 0 {name=l4 lab=GND}
C {devices/vsource.sym} -210 450 0 0 {name=V2 value="dc 5" savecurrent=false}
C {devices/vdd.sym} -290 400 0 0 {name=l8 lab=VREF}
C {devices/gnd.sym} -290 500 0 0 {name=l9 lab=GND}
C {devices/vsource.sym} -290 450 0 0 {name=V3 value="dc 2.5" savecurrent=false}
C {devices/asrc.sym} -120 450 0 0 {name=B1 function="V=2.5+0.5*(1+0.5*sin(2*pi*10k*time))*sin(2*pi*500k*time)"}
C {devices/code_shown.sym} -835 400 0 0 {name=control only_toplevel=false value=".option savecurrent
.control
save all
# Transienst analysis
tran 0.1u 1m 0 0.1u
write tb_am_detection_tr.raw
.endc"}
C {devices/launcher.sym} 150 -460 0 0 {name=h5
descr="load waves" 
tclcommand="xschem raw_read $netlist_dir/tb_am_detection.raw tran"
}
C {devices/lab_pin.sym} -380 -280 0 1 {name=p2 sig_type=std_logic lab=opout}
C {devices/lab_pin.sym} -580 -300 0 0 {name=p3 sig_type=std_logic lab=in}
C {devices/vcvs.sym} -490 -280 0 0 {name=E1 value=10000}
C {devices/lab_pin.sym} -140 -280 0 1 {name=p5 sig_type=std_logic lab=out}
C {devices/lab_pin.sym} -140 -140 0 0 {name=p6 sig_type=std_logic lab=VREF}
C {MP.sym} -420 -140 1 0 {name=M1 model=PMOS w=2u l=1u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} -270 -320 1 0 {name=M2 model=PMOS w=2u l=1u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/lab_pin.sym} -490 -180 0 0 {name=p4 sig_type=std_logic lab=VREF}
C {devices/lab_pin.sym} -490 -100 0 0 {name=p7 sig_type=std_logic lab=VREF}
C {devices/res.sym} -140 -210 0 0 {name=R2
value=100k
footprint=1206
device=resistor
m=1}
C {MP.sym} -430 60 1 0 {name=M3 model=PMOS w=2u l=1u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/lab_pin.sym} -590 100 0 0 {name=p8 sig_type=std_logic lab=in}
C {devices/lab_pin.sym} -140 100 0 1 {name=p9 sig_type=std_logic lab=out2}
C {devices/lab_pin.sym} -140 240 0 0 {name=p10 sig_type=std_logic lab=VREF}
C {devices/res.sym} -140 170 0 0 {name=R3
value=100k
footprint=1206
device=resistor
m=1}
C {devices/res.sym} -430 -280 3 0 {name=R1
value=50
footprint=1206
device=resistor
m=1}
