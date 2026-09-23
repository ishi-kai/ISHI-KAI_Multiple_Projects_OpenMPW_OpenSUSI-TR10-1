v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 120 -370 930 -370 {
lab=#net1}
N 120 -320 120 -280 {
lab=#net1}
N 120 -80 430 -80 {
lab=GND}
N 120 -220 120 -120 {
lab=GND}
N 120 -80 120 -60 {
lab=GND}
N 120 -370 120 -320 {
lab=#net1}
N 430 -80 530 -80 {
lab=GND}
N 120 -120 120 -80 {
lab=GND}
N 930 -370 930 -280 {lab=#net1}
N 900 -280 930 -280 {lab=#net1}
N 900 -240 930 -240 {lab=GND}
N 930 -240 930 -80 {lab=GND}
N 530 -80 930 -80 {lab=GND}
N 900 -260 1040 -260 {lab=out}
N 990 -100 990 -80 {lab=GND}
N 930 -80 990 -80 {lab=GND}
N 930 -370 990 -370 {lab=#net1}
N 990 -370 990 -350 {lab=#net1}
N 990 -290 990 -160 {lab=chg}
N 990 -200 1040 -200 {lab=chg}
N 570 -280 600 -280 {lab=chg}
N 570 -280 570 -180 {lab=chg}
N 570 -180 990 -180 {lab=chg}
N 900 -220 990 -220 {lab=chg}
N 550 -220 600 -220 {lab=#net1}
N 550 -370 550 -220 {lab=#net1}
N 490 -130 490 -80 {lab=GND}
N 490 -260 600 -260 {lab=#net2}
N 490 -260 490 -190 {lab=#net2}
N 330 -240 600 -240 {lab=in}
N 330 -240 330 -180 {lab=in}
N 330 -120 330 -80 {lab=GND}
N 300 -240 330 -240 {lab=in}
C {devices/code_shown.sym} -190 -200 0 0 {name=control only_toplevel=false value=".option savecurrent
.control
op
show m
save all
tran 1u 30m
plot v(in) V(chg) V(out)
.endc"}
C {devices/code_shown.sym} -180 -30 0 0 {name=measure only_toplevel=false value=".measure tran tr trig V(out) val=1 rise=1 targ V(out) val=4 rise=1"}
C {devices/code.sym} -200 -350 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/vsource.sym} 120 -250 0 0 {name=Vdd value=5.0}
C {devices/gnd.sym} 120 -60 0 0 {name=l1 lab=GND}
C {devices/lab_pin.sym} 1040 -260 0 1 {name=p1 sig_type=std_logic lab=out}
C {devices/capa.sym} 990 -130 0 0 {name=C1
m=1
value=0.47u
footprint=1206
device="ceramic capacitor"}
C {devices/lab_pin.sym} 300 -240 0 0 {name=p2 sig_type=std_logic lab=in}
C {devices/res.sym} 990 -320 2 0 {name=R1
value=20k
footprint=1206
device=resistor
m=1}
C {devices/vsource.sym} 330 -150 0 0 {name=Vinp value="pwl 0 5 4.99m 5 5.01m 0 9.99m 0 10.01m 5"}
C {555MOS.sym} 750 -250 0 0 {name=x1}
C {devices/lab_pin.sym} 1040 -200 0 1 {name=p3 sig_type=std_logic lab=chg}
C {devices/capa.sym} 490 -160 0 0 {name=C2
m=1
value=0.01u
footprint=1206
device="ceramic capacitor"}
