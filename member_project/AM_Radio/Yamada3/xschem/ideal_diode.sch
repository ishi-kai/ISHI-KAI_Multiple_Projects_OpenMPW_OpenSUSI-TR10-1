v {xschem version=3.4.7RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -80 -100 -80 -60 {lab=VDD}
N -40 60 -40 80 {lab=iB}
N -80 160 10 160 {lab=VREF}
N -190 230 230 230 {lab=VOUT}
N -190 20 -190 230 {lab=VOUT}
N -190 20 -160 20 {lab=VOUT}
N -190 -20 -160 -20 {lab=VIN}
N -400 -80 -370 -80 {lab=VDD}
N -400 -40 -370 -40 {lab=VSS}
N -400 0 -370 0 {lab=VREF}
N -400 40 -370 40 {lab=iB}
N -400 80 -370 80 {lab=VIN}
N -400 120 -370 120 {lab=VOUT}
N 100 0 140 0 {lab=opout}
N 200 0 230 0 {lab=VOUT}
N -0 0 100 0 {lab=opout}
N -80 60 -80 80 {lab=VSS}
N -190 110 -170 110 {lab=VOUT}
N -140 130 -140 190 {lab=VSS}
N 230 0 230 230 {lab=VOUT}
N 70 160 100 160 {lab=opout}
N 230 -0 330 0 {lab=VOUT}
N 290 0 290 90 {lab=VOUT}
N 290 150 290 230 {lab=VREF}
N 310 120 360 120 {lab=VSS}
N -110 110 20 110 {lab=opout}
N 20 0 20 110 {lab=opout}
N 100 -0 100 160 {lab=opout}
C {devices/lab_pin.sym} -80 -100 0 1 {name=l6 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} -80 80 0 0 {name=l1 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} -40 80 0 1 {name=l2 sig_type=std_logic lab=iB}
C {devices/lab_pin.sym} 100 0 2 1 {name=p2 sig_type=std_logic lab=opout}
C {devices/lab_pin.sym} -80 160 0 0 {name=l3 sig_type=std_logic lab=VREF}
C {devices/lab_pin.sym} -190 -20 0 0 {name=l5 sig_type=std_logic lab=VIN}
C {devices/lab_pin.sym} 330 0 0 1 {name=l7 sig_type=std_logic lab=VOUT}
C {devices/iopin.sym} -400 -80 0 1 {name=p1 lab=VDD}
C {devices/ipin.sym} -400 80 0 0 {name=p3 lab=VIN}
C {devices/opin.sym} -400 120 0 1 {name=p4 lab=VOUT}
C {devices/iopin.sym} -400 -40 0 1 {name=p5 lab=VSS}
C {devices/iopin.sym} -400 0 0 1 {name=p6 lab=VREF}
C {devices/iopin.sym} -400 40 0 1 {name=p7 lab=iB}
C {devices/lab_pin.sym} -370 -80 0 1 {name=l8 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} -370 -40 0 1 {name=l9 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} -370 0 0 1 {name=l10 sig_type=std_logic lab=VREF}
C {devices/lab_pin.sym} -370 40 0 1 {name=l11 sig_type=std_logic lab=iB}
C {devices/lab_pin.sym} -370 80 0 1 {name=l12 sig_type=std_logic lab=VIN}
C {devices/lab_pin.sym} -370 120 0 1 {name=l13 sig_type=std_logic lab=VOUT}
C {DP.sym} 200 0 1 0 {name=D1 model=DP m=4}
C {DP.sym} 70 160 1 0 {name=D2 model=DP m=4}
C {CSIO.sym} -170 110 3 0 {name=C2
model=F_CSIO
c=0.5p
x=28.5u
y=28.5u
m=1
spiceprefix=X}
C {devices/lab_pin.sym} -140 190 0 0 {name=l4 sig_type=std_logic lab=VSS}
C {IP62LIB/RR.sym} 290 90 0 0 {name=R1
w=4e-06
R=20k
l=76.9e-06
model=F_RR
spiceprefix=X
tc1=0
tc2=0
m=1}
C {devices/lab_pin.sym} 290 230 0 1 {name=l14 sig_type=std_logic lab=VREF}
C {devices/lab_pin.sym} 360 120 0 1 {name=l15 sig_type=std_logic lab=VDD}
C {cascode_opamp_2.sym} -80 0 0 0 {name=x1}
