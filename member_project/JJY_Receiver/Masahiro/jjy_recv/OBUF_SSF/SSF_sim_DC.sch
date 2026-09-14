v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 190 -0 380 -0 {lab=VSS}
N 260 -140 290 -140 {lab=VOUT}
N 350 -140 380 -140 {lab=VSPEAKER}
N 380 -40 380 0 {lab=VSS}
N 120 -100 150 -100 {lab=VDD}
N 120 -80 150 -80 {lab=VSS}
N 40 -10 40 0 {lab=VSS}
N 40 -140 40 -130 {lab=VIN}
N -60 -100 -60 -80 {lab=VSS}
N -60 -190 -60 -160 {lab=VDD}
N 120 -120 150 -120 {lab=IBN40u}
N 50 -190 50 -170 {lab=IBN40u}
N 50 -270 50 -250 {lab=VDD}
N 380 -140 380 -120 {lab=VSPEAKER}
N 40 -130 40 -70 {lab=VIN}
N 380 -120 380 -100 {lab=VSPEAKER}
N 40 0 190 0 {lab=VSS}
N 40 -140 150 -140 {lab=VIN}
C {devices/vsource.sym} -60 -130 0 0 {name=VDD value=5 savecurrent=false}
C {devices/gnd.sym} -60 -20 0 0 {name=l1 lab=0}
C {devices/lab_pin.sym} 380 -140 2 0 {name=p1 sig_type=std_logic lab=VSPEAKER}
C {devices/code.sym} -160 70 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/code_shown.sym} -10 60 0 0 {name=s1 only_toplevel=false value="""
.option savecurrent
.control
set units = d
save all

*op
*show m

*dc VIN 0 5 0.01
*plot VOUT
*plot v(vop) v(von)

*ac dec 101 100 999Meg
*plot dB(VSPEAKER)
*plot ph(VSPEAKER)

tran 0.1u 20m

.endc
"""}
C {devices/res.sym} 380 -70 0 0 {name=R1
value=8
footprint=1206
device=resistor
m=1}
C {devices/lab_pin.sym} 40 -140 0 0 {name=p2 sig_type=std_logic lab=VIN}
C {devices/vsource.sym} 40 -40 0 0 {name=VIN value="AC 1 sin(2.5 0.1 2k 0 0 0)" savecurrent=false}
C {devices/lab_pin.sym} 270 -140 1 0 {name=p3 sig_type=std_logic lab=VOUT}
C {devices/capa.sym} 320 -140 1 0 {name=C1
m=1
value=100u
footprint=1206
device="ceramic capacitor"}
C {BUF_SSF.sym} 300 -120 0 0 {name=x1}
C {devices/lab_pin.sym} 120 -100 0 0 {name=p4 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 120 -80 0 0 {name=p5 sig_type=std_logic lab=VSS}
C {devices/vsource.sym} -60 -50 0 0 {name=V3 value=0 savecurrent=false}
C {devices/lab_pin.sym} -60 -90 0 0 {name=p6 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} -60 -190 0 0 {name=p7 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 40 0 0 0 {name=p8 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 120 -120 0 0 {name=p9 sig_type=std_logic lab=IBN40u}
C {devices/isource.sym} 50 -220 0 0 {name=I0 value=40u}
C {devices/lab_pin.sym} 50 -170 0 0 {name=p10 sig_type=std_logic lab=IBN40u}
C {devices/lab_pin.sym} 50 -270 0 0 {name=p11 sig_type=std_logic lab=VDD}
