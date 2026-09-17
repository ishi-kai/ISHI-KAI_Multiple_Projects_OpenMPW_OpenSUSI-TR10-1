v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
P 4 1 -520 -80 {}
P 4 1 -520 -80 {}
N -220 -40 -220 0 {lab=VSS}
N -220 -120 -220 -100 {lab=#net1}
N -180 -110 -180 -70 {lab=#net1}
N -250 -70 -220 -70 {lab=VSS}
N -250 -70 -250 0 {lab=VSS}
N -250 0 -220 0 {lab=VSS}
N -220 -110 -180 -110 {lab=#net1}
N -220 0 -180 0 {lab=VSS}
N -180 -70 -150 -70 {lab=#net1}
N -110 -40 -110 0 {lab=VSS}
N -180 0 -110 0 {lab=VSS}
N -110 -70 -80 -70 {lab=VSS}
N -80 -70 -80 0 {lab=VSS}
N -110 0 -80 0 {lab=VSS}
N -80 0 -20 0 {lab=VSS}
N -110 -340 -110 -100 {lab=#net2}
N -160 0 -160 30 {lab=VSS}
N -160 30 -120 30 {lab=VSS}
N -120 30 -120 60 {lab=VSS}
N -190 60 -160 60 {lab=VSS}
N -190 30 -190 60 {lab=VSS}
N -190 60 -190 90 {lab=VSS}
N -190 90 -160 90 {lab=VSS}
N -190 30 -160 30 {lab=VSS}
C {MN.sym} -180 -70 0 1 {name=M6 model=NMOS w=10u l=2u nrd=0 nrs=0 m=2 spiceprefix=X}
C {devices/ipin.sym} -260 -480 0 0 {name=p3 lab=VSS}
C {devices/lab_pin.sym} -250 0 0 0 {name=p5 sig_type=std_logic lab=VSS}
C {MN.sym} -150 -70 0 0 {name=M8 model=NMOS w=10u l=2u nrd=0 nrs=0 m=16 spiceprefix=X}
C {MN.sym} -120 60 0 1 {name=M1 model=NMOS w=10u l=2u nrd=0 nrs=0 m=6 spiceprefix=X}
