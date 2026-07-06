v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
L 4 -80 -290 -80 -270 {}
L 4 -80 -270 -60 -270 {}
L 4 -60 -290 -60 -270 {}
L 4 -80 -290 -60 -290 {}
L 4 80 -290 80 -270 {}
L 4 80 -270 100 -270 {}
L 4 100 -290 100 -270 {}
L 4 80 -290 100 -290 {}
L 4 -120 -280 140 -280 {}
N 0 -90 0 -50 {lab=VDD}
N -70 -340 -30 -340 {lab=XTALN}
N 30 -340 90 -340 {lab=XTALP}
N 90 -160 90 30 {lab=XTALP}
N -70 -160 -70 30 {lab=XTALN}
N 0 100 0 130 {lab=VSS}
N -70 -440 -70 -340 {lab=XTALN}
N 90 -440 90 -340 {lab=XTALP}
N -0 -20 50 -20 {lab=VDD}
N 50 -90 50 -20 {lab=VDD}
N -0 30 0 40 {lab=XTALP}
N -40 30 -40 70 {lab=XTALN}
N -70 30 -40 30 {lab=XTALN}
N -0 30 90 30 {lab=XTALP}
N 0 70 50 70 {lab=VSS}
N 0 -90 50 -90 {lab=VDD}
N -40 -20 -40 30 {lab=XTALN}
N 0 10 -0 30 {lab=XTALP}
N -160 -380 -130 -380 {lab=VSS}
N 150 -380 180 -380 {lab=VSS}
N 50 70 50 130 {lab=VSS}
N 0 130 50 130 {lab=VSS}
N -70 -220 -70 -160 {lab=XTALN}
N 90 -220 90 -160 {lab=XTALP}
N 250 -160 250 -150 {lab=VSS}
N 250 -290 250 -270 {lab=VDD}
N 250 -70 250 -50 {lab=VDD}
N -70 -110 200 -110 {lab=XTALN}
N 670 -160 670 -150 {lab=VSS}
N 670 -290 670 -270 {lab=VDD}
N 670 -70 670 -50 {lab=VDD}
N 320 -230 340 -230 {lab=VOP0}
N 320 -110 340 -110 {lab=VON0}
N 90 -250 90 -220 {lab=XTALP}
N -70 -250 -70 -220 {lab=XTALN}
N 250 -190 250 -160 {lab=VSS}
N 670 -190 670 -160 {lab=VSS}
N 760 -230 900 -230 {lab=VOP}
N 760 -110 900 -110 {lab=VON}
N 820 -160 830 -160 {lab=VSS}
N 830 -180 830 -160 {lab=VSS}
N 830 -180 840 -180 {lab=VSS}
N 730 -160 740 -160 {lab=VDD}
N 940 -180 950 -180 {lab=VDD}
N 840 -180 850 -180 {lab=VSS}
N 850 -180 860 -180 {lab=VSS}
N 740 -230 760 -230 {lab=VOP}
N 740 -110 760 -110 {lab=VON}
N 90 -340 90 -250 {lab=XTALP}
N -70 -340 -70 -250 {lab=XTALN}
N 900 -110 960 -110 {lab=VON}
N 900 -230 960 -230 {lab=VOP}
N -190 -60 -190 -30 {lab=VSS}
N -190 -150 -190 -120 {lab=VDD}
N -190 -30 -190 0 {lab=VSS}
N 320 -290 320 -230 {lab=VOP0}
N 320 -110 320 -50 {lab=VON0}
N 150 -230 150 -110 {lab=XTALN}
N 150 -230 200 -230 {lab=XTALN}
N 390 -160 390 -150 {lab=VSS}
N 390 -290 390 -270 {lab=VDD}
N 390 -70 390 -50 {lab=VDD}
N 390 -190 390 -160 {lab=VSS}
N 460 -230 480 -230 {lab=VOP1}
N 460 -110 480 -110 {lab=VON1}
N 460 -290 460 -230 {lab=VOP1}
N 460 -110 460 -50 {lab=VON1}
N 530 -160 530 -150 {lab=VSS}
N 530 -290 530 -270 {lab=VDD}
N 530 -70 530 -50 {lab=VDD}
N 530 -190 530 -160 {lab=VSS}
N 600 -230 620 -230 {lab=VOP2}
N 600 -110 620 -110 {lab=VON2}
N 600 -290 600 -230 {lab=VOP2}
N 600 -110 600 -50 {lab=VON2}
C {devices/res.sym} 0 -340 1 0 {name=R1
value=20000k
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} 120 -380 3 0 {name=CL_offchip0
m=1
value=12.5p
footprint=1206
device="ceramic capacitor"}
C {devices/capa.sym} -100 -380 1 1 {name=CL_offchip1
m=1
value=12.5p
footprint=1206
device="ceramic capacitor"}
C {devices/ipin.sym} 0 130 0 0 {name=p1 lab=VSS}
C {devices/opin.sym} 960 -110 0 0 {name=p2 lab=VON}
C {devices/opin.sym} 960 -230 2 1 {name=p3 lab=VOP}
C {devices/ipin.sym} 0 -90 0 0 {name=p4 lab=VDD}
C {devices/code.sym} -450 -320 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {MP.sym} -40 -20 0 0 {name=M1 model=PMOS w=12u l=10u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} -40 70 0 0 {name=M2 model=NMOS w=4u l=10u nrd=0 nrs=0 m=1 spiceprefix=X}
C {INV_X1.sym} 220 -110 2 1 {name=x2}
C {devices/lab_pin.sym} -160 -380 0 0 {name=p6 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 180 -380 0 1 {name=p7 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 250 -290 0 0 {name=p5 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 250 -50 0 0 {name=p8 sig_type=std_logic lab=VDD}
C {INV_X4.sym} 640 -230 0 0 {name=x3}
C {INV_X4.sym} 640 -110 2 1 {name=x4}
C {devices/lab_pin.sym} 670 -290 0 0 {name=p9 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 670 -50 0 0 {name=p10 sig_type=std_logic lab=VDD}
C {INV_X1.sym} 900 -210 1 0 {name=x5}
C {INV_X1.sym} 780 -130 3 0 {name=x6}
C {devices/lab_pin.sym} 670 -170 0 0 {name=p11 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 250 -170 0 0 {name=p12 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 730 -160 0 0 {name=p13 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 950 -180 0 1 {name=p14 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 830 -160 0 1 {name=p15 sig_type=std_logic lab=VSS}
C {devices/ipin.sym} 90 -260 2 1 {name=p16 lab=XTALP}
C {devices/ipin.sym} -70 -260 2 1 {name=p17 lab=XTALN}
C {devices/code_shown.sym} -450 -160 0 0 {name=spice only_toplevel=false value="""
#.option savecurrent
.control
#save all
tran 500n 0.5
plot VOP VON
plot VOP0 VON0
plot VOP1 VON1
plot XTALP XTALN
.endc
"""}
C {devices/vsource.sym} -190 -90 0 0 {name=V1 value="pwl(0 0 10n 5)" savecurrent=false}
C {devices/lab_pin.sym} -190 -30 0 0 {name=p18 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} -190 -150 0 0 {name=p19 sig_type=std_logic lab=VDD}
C {devices/res.sym} -190 30 0 0 {name=R3
value=0
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} -190 60 0 0 {name=l2 lab=0}
C {devices/lab_pin.sym} 320 -290 0 0 {name=p20 sig_type=std_logic lab=VOP0}
C {devices/lab_pin.sym} 320 -50 0 0 {name=p21 sig_type=std_logic lab=VON0}
C {BUF_X1.sym} 220 -230 0 0 {name=x7}
C {INV_X1.sym} 360 -110 2 1 {name=x1}
C {devices/lab_pin.sym} 390 -290 0 0 {name=p22 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 390 -50 0 0 {name=p23 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 390 -170 0 0 {name=p24 sig_type=std_logic lab=VSS}
C {INV_X1.sym} 360 -230 0 0 {name=x8}
C {devices/lab_pin.sym} 460 -290 0 0 {name=p25 sig_type=std_logic lab=VOP1}
C {devices/lab_pin.sym} 460 -50 0 0 {name=p26 sig_type=std_logic lab=VON1}
C {INV_X2.sym} 500 -110 2 1 {name=x9}
C {devices/lab_pin.sym} 530 -290 0 0 {name=p27 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 530 -50 0 0 {name=p28 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 530 -170 0 0 {name=p29 sig_type=std_logic lab=VSS}
C {INV_X2.sym} 500 -230 0 0 {name=x10}
C {devices/lab_pin.sym} 600 -290 0 0 {name=p30 sig_type=std_logic lab=VOP2}
C {devices/lab_pin.sym} 600 -50 0 0 {name=p31 sig_type=std_logic lab=VON2}
C {XTAL_model.sym} 10 -420 0 0 {name=x11}
