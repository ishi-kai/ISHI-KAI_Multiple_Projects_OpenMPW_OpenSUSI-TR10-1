v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 60 -350 60 -280 {lab=VDD}
N 80 -250 130 -250 {lab=VDD}
N 130 -320 130 -250 {lab=VDD}
N 60 -320 130 -320 {lab=VDD}
N 80 60 130 60 {lab=VDD}
N 130 -250 130 60 {lab=VDD}
N -200 -100 20 -100 {lab=RF_IN}
N 60 -70 60 30 {lab=RF_P}
N 60 -220 60 -130 {lab=RF_N}
N 60 90 60 170 {lab=VSS}
N 60 -20 280 -20 {lab=RF_P}
N 60 -180 280 -180 {lab=RF_N}
N 60 -100 100 -100 {lab=VSS}
N 100 -100 100 120 {lab=VSS}
N 60 120 100 120 {lab=VSS}
N -110 -320 -110 -270 {lab=VDD}
N -110 -320 60 -320 {lab=VDD}
N -110 -210 -110 -100 {lab=RF_IN}
N -110 90 -110 120 {lab=VSS}
N -110 120 60 120 {lab=VSS}
N -90 -320 -90 -240 {lab=VDD}
N 660 -150 660 -100 {lab=RF_N}
N 580 -70 620 -70 {lab=VSS}
N 580 -70 580 0 {lab=VSS}
N 580 0 660 0 {lab=VSS}
N 660 -40 660 0 {lab=VSS}
N 660 -70 690 -70 {lab=VSS}
N 690 -70 690 0 {lab=VSS}
N 660 0 690 0 {lab=VSS}
N -110 -100 -110 -30 {lab=RF_IN}
N -90 -240 -90 60 {lab=VDD}
C {TR-1umLIB/MN.sym} 20 -100 0 0 {name=XM1
model=NMOS
w=50u
l=2u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/RR.sym} 60 -280 0 0 {name=R1
w=2.8e-06
R=5e+03
l=17.8e-06
model=F_RR
spiceprefix=X
tc1=0
tc2=0
m=1}
C {TR-1umLIB/RR.sym} 60 30 0 0 {name=R2
w=2.8e-06
R=5e+03
l=17.8e-06
model=F_RR
spiceprefix=X
tc1=0
tc2=0
m=1}
C {devices/iopin.sym} 60 -350 0 1 {name=p9 lab=VDD}
C {devices/iopin.sym} 60 170 0 0 {name=p8 lab=VSS}
C {devices/opin.sym} 280 -180 0 0 {name=p7 lab=RF_N}
C {devices/opin.sym} 280 -20 0 0 {name=p1 lab=RF_P}
C {devices/ipin.sym} -200 -100 0 0 {name=p2 lab=RF_IN}
C {TR-1umLIB/RR.sym} -110 -270 0 0 {name=R3
w=2.8e-06
R=20e+03
l=49.2e-06
model=F_RR
spiceprefix=X
tc1=0
tc2=0
m=1}
C {TR-1umLIB/RR.sym} -110 30 0 0 {name=R4
w=2.8e-06
R=40e+03
l=49.2e-06
model=F_RR
spiceprefix=X
tc1=0
tc2=0
m=1}
C {TR-1umLIB/MN.sym} 620 -70 0 0 {name=XM6
model=NMOS
w=5u
l=2u
m=2
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {devices/lab_pin.sym} 580 0 0 0 {name=p12 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 660 -150 0 0 {name=p13 sig_type=std_logic lab=RF_N}
C {TR-1umLIB/RR.sym} -110 -30 0 0 {name=R5
w=2.8e-06
R=40e+03
l=49.2e-06
model=F_RR
spiceprefix=X
tc1=0
tc2=0
m=1}
