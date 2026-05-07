v {xschem version=3.4.7RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -30 -0 0 -0 {lab=vin}
N -250 40 -250 70 {lab=VSUPPLY}
N -170 40 -170 70 {lab=vin}
N 190 100 190 130 {lab=GND}
N 190 0 190 40 {lab=vout}
N -250 130 -250 170 {lab=GND}
N -170 130 -170 170 {lab=GND}
N 70 -170 70 -150 {lab=VSUPPLY}
N 70 -90 70 -50 {lab=#net1}
N 140 0 190 0 {lab=vout}
N 70 50 70 130 {lab=GND}
C {devices/vdd.sym} 70 -170 0 0 {name=l1 lab=VSUPPLY}
C {devices/gnd.sym} 70 130 0 0 {name=l2 lab=GND}
C {devices/vdd.sym} -250 40 0 0 {name=l3 lab=VSUPPLY}
C {devices/vsource.sym} -250 100 0 0 {name=Vdd value=5.0 savecurrent=false}
C {devices/gnd.sym} -250 170 0 0 {name=l4 lab=GND}
C {devices/vsource.sym} -170 100 0 0 {name=vin value=5.0 savecurrent=false}
C {devices/gnd.sym} -170 170 0 0 {name=l6 lab=GND}
C {devices/lab_pin.sym} -30 0 0 0 {name=p1 sig_type=std_logic lab=vin}
C {devices/lab_pin.sym} -170 40 1 0 {name=p2 sig_type=std_logic lab=vin}
C {devices/lab_pin.sym} 190 0 2 0 {name=p4 sig_type=std_logic lab=vout}
C {devices/capa.sym} 190 70 0 0 {name=Cload
m=1
value=10f
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 190 130 0 0 {name=l5 lab=GND}
C {devices/code_shown.sym} 300 -140 0 0 {name=spice only_toplevel=false value=".option savecurrent
.control
save all

* DC analysis (I/O curve)
dc vin 0 5.0 0.01
plot vout vin
plot i(vd)
wrdata tb_inverter_dc.txt v(vout)
write tb_inverter_dc.raw
.endc"}
C {devices/code_shown.sym} 310 140 0 0 {name=measure only_toplevel=false value=".measure dc Vinv when v(vout)=2.5"}
C {devices/ammeter.sym} 70 -120 0 0 {name=Vd savecurrent=true spice_ignore=0}
C {devices/code.sym} -270 -190 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {inverter.sym} 110 0 0 0 {name=x1}
