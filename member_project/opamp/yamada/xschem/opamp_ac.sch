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
N -130 -20 -100 -20 {lab=vinn}
N -40 -20 -10 -20 {lab=vinn}
N -100 -20 -40 -20 {lab=vinn}
N -80 -20 -80 -10 {lab=vinn}
N -80 50 -80 160 {lab=0}
C {devices/vsource.sym} -220 10 0 0 {name=V1 value=5 savecurrent=false}
C {devices/vsource.sym} -140 50 0 0 {name=Vin1 value="DC 2.5 AC 1" savecurrent=false}
C {devices/gnd.sym} 70 190 0 0 {name=l1 lab=0}
C {devices/isource.sym} -50 90 0 0 {name=Ibias value=20u}
C {devices/capa.sym} 190 80 0 0 {name=CL
m=1
value=100p
footprint=1206
device="ceramic capacitor"}
C {devices/capa.sym} -80 20 0 0 {name=Ccm
m=1
value=1
footprint=1206
device="ceramic capacitor"}
C {devices/code.sym} -260 -275 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/code_shown.sym} -100 -585 0 0 {name=control
only_toplevel=false
value=".option savecurrent
.control
op
print v(vout)
print v(x1.net1)
print v(x1.net2)
print v(x1.net3)
print v(x1.net5)
print -i(V1)
print @m.x1.xxm6.m1[vdsat]
print @m.x1.xxm7.m1[vdsat]
let gm7 = @m.x1.xxm7.m1[gm]
let g12 = @m.x1.xxm12.m1[gds]
print gm7
print gm7/g12
ac dec 40 1 1e9
let gain = vdb(vout)
let ph = 180*cph(vout)/pi
meas ac dcgain find gain at=1
meas ac ugf when gain=0
meas ac ph_ugf find ph when gain=0
plot gain
plot ph
.endc"}
C {devices/lab_pin.sym} 240 0 0 1 {name=p11 sig_type=std_logic lab=vout}
C {devices/lab_pin.sym} -40 -20 3 1 {name=p1 sig_type=std_logic lab=vinn}
C {devices/lab_pin.sym} -20 20 3 1 {name=p2 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} -40 60 3 1 {name=p3 sig_type=std_logic lab=nbp}
C {devices/lab_pin.sym} 70 -110 0 1 {name=p4 sig_type=std_logic lab=vddi}
C {opamp.sym} 50 0 0 0 {name=x1}
C {devices/res.sym} -130 -50 0 0 {name=Rfb
value=1G
footprint=1206
device=resistor
m=1}
