v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -20 0 -0 0 {lab=vin}
N -20 0 -20 100 {lab=vin}
N -40 50 -20 50 {lab=vin}
N -20 100 -0 100 {lab=vin}
N 40 30 40 70 {lab=vout}
N 40 -60 40 -30 {lab=vdd}
N 40 -40 60 -40 {lab=vdd}
N 60 -40 60 -0 {lab=vdd}
N 40 0 60 0 {lab=vdd}
N 40 130 40 160 {lab=vss}
N 40 100 60 100 {lab=vss}
N 60 100 60 140 {lab=vss}
N 40 140 60 140 {lab=vss}
N 40 50 80 50 {lab=vout}
C {MP.sym} 0 0 0 0 {name=M1 model=PMOS w=10u l=1u nrd=0 nrs=0 m=3 spiceprefix=X}
C {MN.sym} 0 100 0 0 {name=M2 model=NMOS w=10u l=1u nrd=0 nrs=0 m=9 spiceprefix=X}
C {devices/ipin.sym} -40 50 0 0 {name=p1 lab=vin}
C {devices/iopin.sym} 40 -60 0 0 {name=p2 lab=vdd}
C {devices/iopin.sym} 40 160 0 0 {name=p3 lab=vss}
C {devices/opin.sym} 80 50 0 0 {name=p4 lab=vout}
