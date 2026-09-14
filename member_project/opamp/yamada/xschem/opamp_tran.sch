v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -220 -110 -220 -20 {lab=vddi}
N -220 -110 70 -110 {lab=vddi}
N 70 -110 70 -50 {lab=vddi}
N -90 20 -10 20 {lab=vinp}
N 70 100 70 190 {lab=0}
N -220 90 -220 160 {lab=0}
N -220 160 70 160 {lab=0}
N -140 130 -140 160 {lab=0}
N -220 40 -220 80 {lab=0}
N -220 80 -220 90 {lab=0}
N -140 80 -140 130 {lab=0}
N 70 50 70 100 {lab=0}
N -50 60 -10 60 {lab=nbp}
N -50 120 -50 160 {lab=0}
N -140 20 -90 20 {lab=vinp}
N 150 -0 190 -0 {lab=vout}
N 190 -0 190 50 {lab=vout}
N 190 110 190 160 {lab=0}
N 70 160 190 160 {lab=0}
N 190 0 240 0 {lab=vout}
N 240 -80 240 0 {lab=vout}
N -30 -80 240 -80 {lab=vout}
N -130 -80 -30 -80 {lab=vout}
N -130 -20 -100 -20 {lab=vout}
N -40 -20 -10 -20 {lab=vout}
N -100 -20 -40 -20 {lab=vout}
N -130 -80 -130 -20 {lab=vout}
C {devices/vsource.sym} -220 10 0 0 {name=V1 value=5 savecurrent=false}
C {devices/vsource.sym} -140 50 0 0 {name=Vin1 value="PWL(0 0 1n 0 1.1n 5.0 40u 5.0))" savecurrent=false}
C {devices/gnd.sym} 70 190 0 0 {name=l1 lab=0}
C {devices/isource.sym} -50 90 0 0 {name=Ibias value=20u}
C {devices/capa.sym} 190 80 0 0 {name=CL
m=1
value=100p
footprint=1206
device="ceramic capacitor"}
C {devices/code.sym} -260 -275 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/code_shown.sym} -110 -345 0 0 {name=control
only_toplevel=false
value=".option savecurrent
.control
tran 2n 40u
meas tran tr trig v(vout) val=1.0 rise=1 targ v(vout) val=4.0 rise=1
let f = 1/tr
let sr = 2*3.14159265*f*5
print tr
print f
print sr
plot v(vout) v(vinp)
.endc"}
C {devices/lab_pin.sym} 240 0 0 1 {name=p11 sig_type=std_logic lab=vout}
C {devices/lab_pin.sym} -20 20 3 1 {name=p2 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} -40 60 3 1 {name=p3 sig_type=std_logic lab=nbp}
C {devices/lab_pin.sym} 70 -110 0 1 {name=p4 sig_type=std_logic lab=vddi}
C {opamp.sym} 50 0 0 0 {name=x1}
