v {xschem version=3.4.7RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
B 2 0 -400 800 0 {flags=graph
y1=-69.747075
y2=95.829949
ypos1=0
ypos2=2
divy=5
subdivy=4
unity=1
x1=-1.0542345
x2=10.095129
divx=5
subdivx=8
xlabmag=1.0
ylabmag=1.0
dataset=0
unitx=1
logx=1
logy=0
sim_type=ac
autoload=1
color=4
node="gain;  vout vinm / db20()"
rawfile=$netlist_dir/tb_cascode_opamp_2_openloop.raw}
B 2 0 0 800 400 {flags=graph
y1=-120.03891
y2=152.65891
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=-1.0542345
x2=10.095129
divx=5
subdivx=8
xlabmag=1.0
ylabmag=1.0
node="phase; ph(vout) ph(vinm) - 180 -"
color=4
dataset=0
unitx=1
logx=1
logy=0
sim_type=ac
rawfile=$netlist_dir/tb_cascode_opamp_2_openloop.raw
autoload=1}
T {<< How to measure Open Loop Gain >>

By using Nagative Feedback, saturation by offset error can be cancelled.
  Vout = A(VinP - Vinm)
  Vinm = Vout + Vin
  Vout = A*VinP - A*Vout - A*Vin
For AC analysis, Vinp = 0
  Vout = -A*Vout - A*Vin
As for Close Loop Gain;
  (1+A)*Vout = -A*Vin
  Vout = -A/(1+A)*Vin
As for Open Loop Gain:
  A = -Vout/(Vout + Vin) = -Vout/Vinm
Then to get A, meaeure -Vout/Vinm
} 30 440 0 0 0.2 0.2 {}
N -240 100 -240 120 {lab=VDD}
N -240 180 -240 200 {lab=GND}
N -330 100 -330 120 {lab=VREF}
N -330 180 -330 200 {lab=GND}
N -360 -170 -360 -140 {lab=GND}
N -320 -170 -320 -140 {lab=iB}
N -420 180 -420 200 {lab=GND}
N -420 80 -420 120 {lab=iB}
N -360 -330 -360 -290 {lab=VDD}
N -240 -230 -240 -90 {lab=VOUT}
N -520 -210 -440 -210 {lab=VINM}
N -520 -250 -440 -250 {lab=VINP}
N -570 -250 -520 -250 {lab=VINP}
N -520 -210 -520 -190 {lab=VINM}
N -570 -250 -570 -230 {lab=VINP}
N -520 -90 -240 -90 {lab=VOUT}
N -520 -130 -520 -90 {lab=VOUT}
N -280 -230 -200 -230 {lab=VOUT}
C {devices/code.sym} -660 30 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/vdd.sym} -240 100 0 0 {name=l3 lab=VDD}
C {devices/gnd.sym} -240 200 0 0 {name=l4 lab=GND}
C {devices/vsource.sym} -240 150 0 0 {name=V2 value="dc 5" savecurrent=false}
C {devices/vdd.sym} -330 100 0 0 {name=l8 lab=VREF}
C {devices/gnd.sym} -330 200 0 0 {name=l9 lab=GND}
C {devices/vsource.sym} -330 150 0 0 {name=V3 value="dc 1.4" savecurrent=false}
C {devices/code_shown.sym} -605 270 0 0 {name=spice only_toplevel=false value=".option savecurrent
.control
set units=degree
op
show m
save all

* AC analysis
ac dec 20 1e-1 1e10
let gain = db(-v(vout)/v(vinm))
let phase = vp(vout) - vp(vinm) - 180
let phase_margin = phase + 180
plot gain
plot phase
meas ac dc_gain find gain at=1
meas ac p_margin find phase_margin when gain=0
meas ac g_margin find gain when phase=-180
meas ac ugf_freq find frequency when gain=0
write tb_cascode_opamp_2_openloop.raw
.endc
.end
"
}
C {devices/gnd.sym} -360 -140 0 0 {name=l1 lab=GND}
C {devices/vdd.sym} -360 -330 0 0 {name=l6 lab=VDD}
C {devices/gnd.sym} -420 200 0 0 {name=l11 lab=GND}
C {devices/lab_pin.sym} -420 80 0 1 {name=l12 sig_type=std_logic lab=iB}
C {devices/isource.sym} -420 150 0 0 {name=I0 value=100u}
C {devices/lab_pin.sym} -320 -140 0 1 {name=l5 sig_type=std_logic lab=iB}
C {cascode_opamp_2.sym} -360 -230 0 0 {name=x1}
C {devices/lab_pin.sym} -200 -230 0 1 {name=p5 sig_type=std_logic lab=VOUT}
C {devices/vsource.sym} -520 -160 0 0 {name=VIN1 value="AC 1" savecurrent=false}
C {devices/lab_wire.sym} -460 -210 0 0 {name=p6 sig_type=std_logic lab=VINM}
C {devices/lab_wire.sym} -460 -250 0 0 {name=p7 sig_type=std_logic lab=VINP}
C {devices/vsource.sym} -570 -200 0 0 {name=VINP value=1.4 savecurrent=false}
C {devices/gnd.sym} -570 -170 0 0 {name=l7 lab=GND
}
