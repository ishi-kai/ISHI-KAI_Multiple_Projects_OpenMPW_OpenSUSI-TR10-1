v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {AM_Radio} -360 -495 0 0 0.8 0.8 {}
T {Pin16 VDD
Pin15 iB
Pin14 VREF
Pin13 RFINP
Pin12 RFINN
Pin11 RFOUT
Pin10 DETIN
Pin09 DETOUT

Pin08 VSS} -80 -490 0 0 0.4 0.4 {}
T {iBIAS} -350 -145 0 0 0.5 0.5 {}
T {RF AMP} -50 -145 0 0 0.5 0.5 {}
T {Detector} 270 -145 0 0 0.5 0.5 {}
N 180 -220 230 -220 {lab=VSS}
N 180 -480 230 -480 {lab=VDD}
N 180 -450 230 -450 {lab=iB}
N 180 -420 230 -420 {lab=VREF}
N 180 -360 230 -360 {lab=RFINN}
N 180 -390 230 -390 {lab=RFINP}
N 180 -330 230 -330 {lab=RFOUT}
N 180 -300 230 -300 {lab=DETIN}
N 180 -270 230 -270 {lab=DETOUT}
N -280 -70 -280 -50 {lab=VDD}
N -320 -70 -280 -70 {lab=VDD}
N -280 50 -280 70 {lab=VSS}
N -320 70 -280 70 {lab=VSS}
N -200 -50 -130 -50 {lab=iB2}
N -240 -70 -240 -50 {lab=iB1}
N -240 -70 -130 -70 {lab=iB1}
N -240 50 -240 90 {lab=iB}
N -320 90 -240 90 {lab=iB}
N 60 -80 60 -60 {lab=VDD}
N -20 -80 60 -80 {lab=VDD}
N -10 80 60 80 {lab=VSS}
N -10 110 100 110 {lab=iB1}
N 310 -80 370 -80 {lab=VDD}
N 310 80 370 80 {lab=VSS}
N 310 110 450 110 {lab=iB2}
N 370 -80 370 -60 {lab=VDD}
N 450 -80 450 -60 {lab=VREF}
N 60 60 60 80 {lab=VSS}
N 100 60 100 110 {lab=iB1}
N 370 60 370 80 {lab=VSS}
N 450 60 450 110 {lab=iB2}
C {ideal_diode.sym} 410 0 0 0 {name=x3}
C {devices/ipin.sym} 180 -420 0 0 {name=p1 lab=VREF}
C {devices/iopin.sym} 180 -220 0 1 {name=p3 lab=VSS}
C {devices/iopin.sym} 180 -480 0 1 {name=p6 lab=VDD}
C {devices/lab_wire.sym} 230 -220 0 1 {name=p7 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 230 -480 0 1 {name=p8 sig_type=std_logic lab=VDD}
C {devices/iopin.sym} 180 -450 0 1 {name=p9 lab=iB}
C {devices/lab_wire.sym} 230 -450 0 1 {name=p10 sig_type=std_logic lab=iB}
C {devices/lab_wire.sym} 230 -420 0 1 {name=p11 sig_type=std_logic lab=VREF}
C {devices/ipin.sym} 180 -360 0 0 {name=p12 lab=RFINN}
C {devices/lab_wire.sym} 230 -360 0 1 {name=p13 sig_type=std_logic lab=RFINN}
C {devices/ipin.sym} 180 -390 0 0 {name=p14 lab=RFINP}
C {devices/lab_wire.sym} 230 -390 0 1 {name=p15 sig_type=std_logic lab=RFINP}
C {devices/lab_wire.sym} 230 -330 0 1 {name=p17 sig_type=std_logic lab=RFOUT}
C {devices/ipin.sym} 180 -300 0 0 {name=p18 lab=DETIN}
C {devices/lab_wire.sym} 230 -300 0 1 {name=p19 sig_type=std_logic lab=DETIN}
C {devices/opin.sym} 180 -330 0 1 {name=p16 lab=RFOUT}
C {devices/lab_wire.sym} 230 -270 0 1 {name=p20 sig_type=std_logic lab=DETOUT}
C {devices/opin.sym} 180 -270 0 1 {name=p21 lab=DETOUT}
C {current_mirror.sym} -240 -10 0 0 {name=x1}
C {devices/lab_wire.sym} -320 -70 0 0 {name=p22 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} -320 70 0 0 {name=p23 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} -130 -70 0 1 {name=p24 sig_type=std_logic lab=iB1}
C {devices/lab_wire.sym} -130 -50 0 1 {name=p25 sig_type=std_logic lab=iB2}
C {devices/lab_wire.sym} -320 90 0 0 {name=p26 sig_type=std_logic lab=iB}
C {cascode_opamp.sym} 60 0 0 0 {name=x2}
C {devices/lab_wire.sym} -20 -20 0 0 {name=p27 sig_type=std_logic lab=RFINP}
C {devices/lab_wire.sym} -20 20 0 0 {name=p28 sig_type=std_logic lab=RFINN}
C {devices/lab_wire.sym} -20 -80 0 0 {name=p29 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} -10 80 0 0 {name=p30 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} -10 110 0 0 {name=p31 sig_type=std_logic lab=iB1}
C {devices/lab_wire.sym} 140 0 0 1 {name=p32 sig_type=std_logic lab=RFOUT}
C {devices/lab_wire.sym} 310 0 0 0 {name=p2 sig_type=std_logic lab=DETIN}
C {devices/lab_wire.sym} 510 0 0 1 {name=p4 sig_type=std_logic lab=DETOUT}
C {devices/lab_wire.sym} 310 -80 0 0 {name=p5 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} 310 80 0 0 {name=p33 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 310 110 0 0 {name=p34 sig_type=std_logic lab=iB2}
C {devices/lab_wire.sym} 450 -80 0 0 {name=p35 sig_type=std_logic lab=VREF}
