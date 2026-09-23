v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -590 -240 -590 -210 {lab=VDD}
N -390 -240 -390 -210 {lab=vin}
N -390 120 -370 120 {lab=vout}
N -370 140 -370 180 {lab=vin}
N -130 -240 -130 -210 {lab=vout}
N -130 -150 -130 -120 {lab=GND}
C {devices/lab_pin.sym} -590 -240 0 1 {name=p2 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} -370 180 0 1 {name=p4 sig_type=std_logic lab=vin}
C {devices/lab_pin.sym} -390 120 0 0 {name=p5 sig_type=std_logic lab=vout}
C {devices/vsource.sym} -590 -180 0 0 {name=Vdd value=5.0 savecurrent=false}
C {devices/gnd.sym} -590 -150 0 0 {name=l1 lab=GND}
C {devices/ammeter.sym} -40 120 1 0 {name=Vd savecurrent=true spice_ignore=0}
C {devices/vsource.sym} -390 -180 0 0 {name=vin value="pwl 0 0 10n 0 20n 5.0 60n 5.0 70n 0" savecurrent=false}
C {devices/gnd.sym} -70 140 0 0 {name=l4 lab=GND}
C {devices/lab_pin.sym} -390 -240 0 0 {name=p10 sig_type=std_logic lab=vin}
C {devices/code_shown.sym} 160 -200 0 0 {name=s1 only_toplevel=false value="

.option savecurrent
.control
save all

* Tran analysis
tran 0.1n 100n
plot vout vin
plot i(vd)
wrdata tb_inverter_trans.dat
write inverter tb_inverter_trans.raw
.endc


"
}
C {devices/gnd.sym} -390 -150 0 0 {name=l3 lab=GND}
C {inverter.sym} -220 130 0 0 {name=x1}
C {devices/code.sym} 260 140 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/lab_pin.sym} -10 120 0 1 {name=p1 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} -130 -240 0 0 {name=p3 sig_type=std_logic lab=vout}
C {devices/capa.sym} -130 -180 0 0 {name=Cload
m=1
value=10f
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} -130 -120 0 0 {name=l2 lab=GND}
