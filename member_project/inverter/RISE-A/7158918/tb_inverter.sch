v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -340 -280 -340 -250 {lab=VDD}
N -140 -280 -140 -250 {lab=vin}
N -140 80 -120 80 {lab=vout}
N -120 100 -120 140 {lab=vin}
N 60 -270 60 -240 {lab=vout}
N 60 -180 60 -150 {lab=GND}
C {devices/lab_pin.sym} -340 -280 0 1 {name=p2 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} -120 140 0 1 {name=p4 sig_type=std_logic lab=vin}
C {devices/lab_pin.sym} -140 80 0 0 {name=p5 sig_type=std_logic lab=vout}
C {devices/vsource.sym} -340 -220 0 0 {name=Vdd value=5.0 savecurrent=false}
C {devices/gnd.sym} -340 -190 0 0 {name=l1 lab=GND}
C {devices/ammeter.sym} 210 80 1 0 {name=Vd savecurrent=true spice_ignore=0}
C {devices/vsource.sym} -140 -220 0 0 {name=vin value=5.0 savecurrent=false}
C {devices/gnd.sym} 180 100 0 0 {name=l4 lab=GND}
C {devices/lab_pin.sym} -140 -280 0 0 {name=p10 sig_type=std_logic lab=vin}
C {devices/code_shown.sym} 410 -240 0 0 {name=s1 only_toplevel=false value="

.option savecurrent
.control
save all

* DC analysis
dc vin 0 5.0 0.01
plot vout vin
plot i(vd)
wrdata tb_inverter.dat
write tb_inverter.raw
.endc


"
}
C {devices/gnd.sym} -140 -190 0 0 {name=l3 lab=GND}
C {inverter.sym} 30 90 0 0 {name=x1}
C {devices/code.sym} 510 100 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/lab_pin.sym} 240 80 0 1 {name=p1 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 60 -270 0 0 {name=p3 sig_type=std_logic lab=vout}
C {devices/capa.sym} 60 -210 0 0 {name=Cload
m=1
value=10f
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 60 -150 0 0 {name=l2 lab=GND}
