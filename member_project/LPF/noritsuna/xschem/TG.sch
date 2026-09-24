v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 330 40 330 150 {lab=VIN}
N 390 40 390 150 {lab=VOUT}
N 270 100 330 100 {lab=VIN}
N 390 100 450 100 {lab=VOUT}
N 450 100 560 100 {lab=VOUT}
N 490 100 490 130 {lab=VOUT}
N 530 0 530 160 {lab=CLK}
N 360 -0 530 -0 {lab=CLK}
N 490 190 490 220 {lab=VSS}
N 470 160 490 160 {lab=VSS}
N 470 160 470 200 {lab=VSS}
N 470 200 490 200 {lab=VSS}
N 270 0 360 -0 {lab=CLK}
N 270 190 360 190 {lab=CLK_BAR}
N 40 -150 90 -150 {lab=VDD}
N 40 -120 90 -120 {lab=VSS}
C {TR-1umLIB/MP.sym} 360 0 1 0 {name=XM3
model=PMOS
w=8.6u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MN.sym} 360 190 3 0 {name=XM4
model=NMOS
w=3.4u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MN.sym} 530 160 0 1 {name=XM5
model=NMOS
w=3.4u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {devices/iopin.sym} 40 -150 0 1 {name=p1 lab=VDD}
C {devices/iopin.sym} 40 -120 0 1 {name=p2 lab=VSS}
C {devices/ipin.sym} 270 0 0 0 {name=p3 lab=CLK}
C {devices/ipin.sym} 270 100 0 0 {name=p4 lab=VIN}
C {devices/opin.sym} 560 100 0 0 {name=p5 lab=VOUT}
C {devices/lab_pin.sym} 360 40 0 0 {name=p6 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 360 150 0 0 {name=p7 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 490 220 0 0 {name=p8 sig_type=std_logic lab=VSS}
C {devices/ipin.sym} 270 190 0 0 {name=p9 lab=CLK_BAR}
C {devices/lab_pin.sym} 90 -150 0 1 {name=p10 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 90 -120 0 1 {name=p11 sig_type=std_logic lab=VSS}
