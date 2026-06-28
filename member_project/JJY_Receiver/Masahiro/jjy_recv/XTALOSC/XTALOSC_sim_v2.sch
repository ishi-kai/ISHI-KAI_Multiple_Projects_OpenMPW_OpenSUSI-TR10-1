v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
L 4 160 -140 160 -120 {}
L 4 160 -120 180 -120 {}
L 4 180 -140 180 -120 {}
L 4 160 -140 180 -140 {}
L 4 320 -140 320 -120 {}
L 4 320 -120 340 -120 {}
L 4 340 -140 340 -120 {}
L 4 320 -140 340 -140 {}
L 4 110 -130 390 -130 {}
T {off-chip} 340 -160 0 0 0.4 0.4 {}
N 170 -190 210 -190 {lab=XTALN}
N 270 -190 330 -190 {lab=XTALP}
N 170 -290 170 -190 {lab=XTALN}
N 330 -290 330 -190 {lab=XTALP}
N 80 -230 110 -230 {lab=VSS}
N 390 -230 420 -230 {lab=VSS}
N 330 -190 330 -100 {lab=XTALP}
N 170 -190 170 -100 {lab=XTALN}
N 0 -140 0 -110 {lab=VSS}
N 0 -230 0 -200 {lab=VDD}
N 0 -110 0 -80 {lab=VSS}
N 170 -100 230 -100 {lab=XTALN}
N 230 -100 230 -80 {lab=XTALN}
N 260 -100 260 -80 {lab=XTALP}
N 260 -100 330 -100 {lab=XTALP}
C {devices/res.sym} 240 -190 1 0 {name=R1
value=20000k
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} 360 -230 3 0 {name=CL_offchip0
m=1
value=12.5p
footprint=1206
device="ceramic capacitor"}
C {devices/capa.sym} 140 -230 1 1 {name=CL_offchip1
m=1
value=12.5p
footprint=1206
device="ceramic capacitor"}
C {devices/opin.sym} 330 -30 0 0 {name=p2 lab=VON}
C {devices/opin.sym} 330 -50 2 1 {name=p3 lab=VOP}
C {devices/code.sym} -250 -320 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/lab_pin.sym} 80 -230 0 0 {name=p6 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 420 -230 0 1 {name=p7 sig_type=std_logic lab=VSS}
C {devices/code_shown.sym} -250 -160 0 0 {name=spice only_toplevel=false value="""
#.option savecurrent
.control
#save all
tran 500n 0.2
plot VOP VON
plot VOP0 VON0
plot VOP1 VON1
plot XTALP XTALN
.endc
"""}
C {devices/vsource.sym} 0 -170 0 0 {name=V1 value="pwl(0 0 10n 5)" savecurrent=false}
C {devices/lab_pin.sym} 0 -110 0 0 {name=p18 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 0 -230 0 0 {name=p19 sig_type=std_logic lab=VDD}
C {devices/res.sym} 0 -50 0 0 {name=R3
value=0
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 0 -20 0 0 {name=l2 lab=0}
C {XTAL_model.sym} 250 -270 0 0 {name=x11}
C {XTALOSC.sym} 180 -20 0 0 {name=x12}
C {devices/lab_pin.sym} 160 -50 0 0 {name=p1 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 160 -30 0 0 {name=p4 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 170 -100 0 0 {name=p5 sig_type=std_logic lab=XTALN}
C {devices/lab_pin.sym} 330 -100 0 1 {name=p8 sig_type=std_logic lab=XTALP}
