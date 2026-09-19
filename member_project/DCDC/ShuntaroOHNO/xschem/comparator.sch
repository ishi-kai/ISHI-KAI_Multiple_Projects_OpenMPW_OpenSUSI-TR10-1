v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 40 -70 40 -50 {lab=vdd}
N 40 -20 50 -20 {lab=vdd}
N -150 -20 -140 -20 {lab=vdd}
N -140 10 -140 60 {lab=ib}
N -140 -70 -140 -50 {lab=vdd}
N -20 30 40 30 {lab=#net1}
N -20 30 -20 50 {lab=#net1}
N -20 40 -10 40 {lab=#net1}
N -20 80 -10 80 {lab=#net1}
N -10 40 -10 80 {lab=#net1}
N 40 30 100 30 {lab=#net1}
N 100 30 100 50 {lab=#net1}
N 90 40 100 40 {lab=#net1}
N 90 80 100 80 {lab=#net1}
N 90 40 90 80 {lab=#net1}
N -30 160 -20 160 {lab=vss}
N -30 160 -30 200 {lab=vss}
N -20 190 -20 200 {lab=vss}
N 100 190 100 200 {lab=vss}
N 100 160 110 160 {lab=vss}
N 110 160 110 200 {lab=vss}
N 40 10 40 30 {lab=#net1}
N -20 110 -20 130 {lab=#net2}
N 100 110 100 130 {lab=out}
N -150 -70 -150 -20 {lab=vdd}
N 50 -70 50 -20 {lab=vdd}
N -100 -20 0 -20 {lab=ib}
N 20 160 60 160 {lab=#net2}
N -20 120 40 120 {lab=#net2}
N 40 120 40 160 {lab=#net2}
N 100 120 120 120 {lab=out}
N -180 -70 50 -70 {lab=vdd}
N -180 200 110 200 {lab=vss}
N -80 -20 -80 20 {lab=ib}
N -140 20 -80 20 {lab=ib}
C {MP.sym} 0 -20 0 0 {name=M5 model=PMOS w=20u l=1u nrd=0 nrs=0 m=9 spiceprefix=X}
C {devices/iopin.sym} -180 -70 0 1 {name=p1 lab=vdd}
C {MP.sym} -100 -20 0 1 {name=M20 model=PMOS w=20u l=1u nrd=0 nrs=0 m=5 spiceprefix=X}
C {devices/iopin.sym} -140 60 1 0 {name=p3 lab=ib}
C {MP.sym} -60 80 0 0 {name=M1 model=PMOS w=20u l=1u nrd=0 nrs=0 m=5 spiceprefix=X}
C {MP.sym} 140 80 0 1 {name=M2 model=PMOS w=20u l=1u nrd=0 nrs=0 m=5 spiceprefix=X}
C {devices/ipin.sym} -60 80 0 0 {name=p4 lab=vinp}
C {devices/ipin.sym} 140 80 0 1 {name=p2 lab=vinn}
C {MN.sym} 20 160 0 1 {name=M3 model=NMOS w=10u l=1u nrd=0 nrs=0 m=5 spiceprefix=X}
C {MN.sym} 60 160 0 0 {name=M4 model=NMOS w=10u l=1u nrd=0 nrs=0 m=5 spiceprefix=X}
C {devices/iopin.sym} -180 200 0 1 {name=p5 lab=vss}
C {devices/opin.sym} 120 120 0 0 {name=p6 lab=out}
