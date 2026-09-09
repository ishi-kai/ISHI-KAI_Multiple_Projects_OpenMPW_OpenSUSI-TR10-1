v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 190 20 210 20 {lab=GND}
N 190 -20 210 -20 {lab=vdd}
N 190 0 210 0 {lab=vout}
N -270 -70 -270 -40 {lab=vctrl}
N -270 20 -270 30 {lab=GND}
N -330 -70 -330 -40 {lab=VDD}
N -330 20 -330 30 {lab=GND}
N -150 0 -110 0 {lab=vctrl}
N -110 -180 280 -180 {lab=vout}
N -110 -180 -110 -150 {lab=vout}
N 190 -130 220 -130 {lab=#net1}
N 220 -130 220 -60 {lab=#net1}
N -110 -60 220 -60 {lab=#net1}
N -110 -60 -110 -20 {lab=#net1}
N 210 -0 280 -0 {lab=vout}
N 280 -180 280 -0 {lab=vout}
N 210 20 210 40 {lab=GND}
N -180 -20 -110 -20 {lab=#net1}
N -180 -20 -180 20 {lab=#net1}
C {devices/gnd.sym} 210 40 0 0 {name=l1 lab=GND}
C {devices/lab_pin.sym} 280 0 2 0 {name=p1 sig_type=std_logic lab=vout}
C {devices/lab_pin.sym} 210 -20 2 0 {name=p2 sig_type=std_logic lab=vdd}
C {devices/vsource.sym} -270 -10 0 0 {name=vctrl value=5.0 savecurrent=false}
C {devices/lab_pin.sym} -270 -70 1 0 {name=p4 sig_type=std_logic lab=vctrl}
C {devices/gnd.sym} -270 30 0 0 {name=l2 lab=GND}
C {devices/vsource.sym} -330 -10 0 0 {name=vdd value=5.0 savecurrent=false}
C {devices/gnd.sym} -330 30 0 0 {name=l3 lab=GND}
C {devices/vdd.sym} -330 -70 0 0 {name=l4 lab=VDD}
C {devices/code_shown.sym} 320 -60 0 0 {name=spice only_toplevel=false value=".option savecurrent
.control
save all

* DC analysis (I/O curve)
tran  1n 100u
write sim_vco.raw
.endc"}
C {devices/lab_pin.sym} -150 0 1 0 {name=p3 sig_type=std_logic lab=vctrl}
C {devices/code.sym} -360 -270 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {vco.sym} 40 0 0 0 {name=x1}
C {devices/gnd.sym} 190 -110 0 0 {name=l5 lab=GND}
C {devices/lab_pin.sym} 190 -150 2 0 {name=p5 sig_type=std_logic lab=vdd}
C {devices/capa.sym} 270 30 0 0 {name=C1
m=1
value=40p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 270 60 0 0 {name=l6 lab=GND}
C {devices/capa.sym} -180 50 0 0 {name=C2
m=1
value=40p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} -180 80 0 0 {name=l7 lab=GND}
C {inverter_kudo.sym} 40 -130 0 0 {name=x2}
