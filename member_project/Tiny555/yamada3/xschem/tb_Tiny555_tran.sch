v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 360 20 700 20 {lab=VDD}
N 360 20 360 160 {lab=VDD}
N 700 20 700 50 {lab=VDD}
N 560 20 560 30 {lab=VDD}
N 560 70 560 90 {lab=DISCH}
N 560 130 560 150 {lab=RAMP}
N 560 190 560 220 {lab=GND}
N 360 220 700 220 {lab=GND}
N 700 190 700 220 {lab=GND}
N 620 120 640 120 {lab=DISCH}
N 780 120 820 120 {lab=RAMP}
N 780 160 820 160 {lab=OUT}
C {devices/code.sym} -10 0 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/code_shown.sym} 0 160 0 0 {name=s1 only_toplevel=false value=".option savecurrents
.control
save all
tran 100n 500u uic
plot v(RAMP) v(OUT) v(DISCH)
meas tran RAMP_MIN min v(RAMP) from=100u to=500u
meas tran RAMP_MAX max v(RAMP) from=100u to=500u
meas tran OUT_MAX max v(OUT) from=100u to=500u
.endc"}
C {devices/vsource.sym} 360 190 0 1 {name=Vdd value="5" savecurrent=false}
C {devices/gnd.sym} 360 220 0 0 {name=l1 lab=GND}
C {Tiny555.sym} 700 140 0 0 {name=x1}
C {devices/res.sym} 560 50 0 0 {name=RA value=100k footprint=1206 device=resistor m=1}
C {devices/res.sym} 560 110 0 0 {name=RB value=100k footprint=1206 device=resistor m=1}
C {devices/capa.sym} 560 170 0 0 {name=CT m=1 value=100p footprint=1206 device="ceramic capacitor"}
C {devices/lab_pin.sym} 560 20 0 0 {name=p1 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 560 80 0 0 {name=p2 sig_type=std_logic lab=DISCH}
C {devices/lab_pin.sym} 640 120 0 1 {name=p3 sig_type=std_logic lab=DISCH}
C {devices/lab_pin.sym} 560 140 0 0 {name=p4 sig_type=std_logic lab=RAMP}
C {devices/lab_pin.sym} 820 120 0 1 {name=p5 sig_type=std_logic lab=RAMP}
C {devices/lab_pin.sym} 820 160 0 1 {name=p6 sig_type=std_logic lab=OUT}
