v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 40 -60 40 -30 {lab=vdd}
N 40 -0 50 0 {lab=vdd}
N 50 -40 50 0 {lab=vdd}
N 40 -40 50 -40 {lab=vdd}
N 40 30 40 70 {lab=vout}
N 40 130 40 160 {lab=vss}
N 40 100 50 100 {lab=vss}
N 50 100 50 140 {lab=vss}
N 40 140 50 140 {lab=vss}
N -0 0 0 100 {lab=vin}
N -20 50 -0 50 {lab=vin}
N 40 50 60 50 {lab=vout}
C {MP.sym} 0 0 0 0 {name=M1 model=PMOS w=3.4u l=30u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 0 100 0 0 {name=M2 model=NMOS w=30u l=3.4u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/iopin.sym} 40 -60 0 0 {name=p1 lab=vdd}
C {devices/iopin.sym} 40 160 0 0 {name=p2 lab=vss}
C {devices/ipin.sym} -20 50 0 0 {name=p3 lab=vin}
C {devices/opin.sym} 60 50 0 0 {name=p4 lab=vout}
