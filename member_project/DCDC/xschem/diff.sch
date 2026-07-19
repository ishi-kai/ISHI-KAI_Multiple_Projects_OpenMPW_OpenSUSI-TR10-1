v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 40 30 40 70 {lab=#net1}
N 180 30 180 70 {lab=out}
N 40 50 110 50 {lab=#net1}
N 110 50 110 100 {lab=#net1}
N 80 100 140 100 {lab=#net1}
N 40 -50 40 -30 {lab=#net2}
N 180 -50 180 -30 {lab=#net2}
N 40 -50 180 -50 {lab=#net2}
N 40 -0 50 -0 {lab=#net2}
N 50 -50 50 -0 {lab=#net2}
N 170 -50 170 -0 {lab=#net2}
N 170 0 180 0 {lab=#net2}
N 30 100 40 100 {lab=vss}
N 180 100 190 100 {lab=vss}
N 30 100 30 150 {lab=vss}
N 190 100 190 150 {lab=vss}
N 40 130 40 150 {lab=vss}
N 180 130 180 150 {lab=vss}
N 110 -170 110 -150 {lab=vdd}
N 110 -120 120 -120 {lab=vdd}
N 110 -160 120 -160 {lab=vdd}
N 120 -160 120 -120 {lab=vdd}
N 110 -90 110 -50 {lab=#net2}
N -40 -120 -40 -70 {lab=ib}
N -80 -170 -80 -150 {lab=vdd}
N -90 -160 -80 -160 {lab=vdd}
N -90 -160 -90 -120 {lab=vdd}
N -90 -120 -80 -120 {lab=vdd}
N -80 -90 -80 -40 {lab=ib}
N -100 -170 110 -170 {lab=vdd}
N -100 150 190 150 {lab=vss}
N -80 -70 -40 -70 {lab=ib}
N -40 -120 70 -120 {lab=ib}
C {MP.sym} 0 0 0 0 {name=M1 model=PMOS w=15u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 220 0 0 1 {name=M2 model=PMOS w=15u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 80 100 0 1 {name=M3 model=NMOS w=5u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 140 100 0 0 {name=M4 model=NMOS w=5u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 70 -120 0 0 {name=M5 model=PMOS w=8u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/iopin.sym} -100 -170 0 1 {name=p1 lab=vdd}
C {devices/iopin.sym} -100 150 0 1 {name=p2 lab=vss}
C {devices/ipin.sym} 0 0 0 0 {name=p4 lab=vinn}
C {devices/ipin.sym} 220 0 0 1 {name=p5 lab=vinp}
C {devices/opin.sym} 180 50 0 0 {name=p6 lab=out}
C {MP.sym} -40 -120 0 1 {name=M8 model=PMOS w=4u l=4u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/iopin.sym} -80 -40 1 0 {name=p3 lab=ib}
