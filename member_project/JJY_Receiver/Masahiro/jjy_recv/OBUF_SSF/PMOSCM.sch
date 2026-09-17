v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
P 4 1 -520 -80 {}
P 4 1 -520 -80 {}
N 150 -340 150 -290 {lab=#net1}
N 150 -450 150 -400 {lab=VDD}
N 190 -450 190 -370 {lab=VDD}
N 150 -450 190 -450 {lab=VDD}
N 150 -370 190 -370 {lab=VDD}
N -220 -450 -180 -450 {lab=VDD}
N -180 -450 -110 -450 {lab=VDD}
N -110 -320 -70 -320 {lab=#net2}
N -140 -370 -110 -370 {lab=VDD}
N -70 -370 -30 -370 {lab=#net2}
N -110 -450 10 -450 {lab=VDD}
N 10 -370 40 -370 {lab=VDD}
N 10 -450 40 -450 {lab=VDD}
N 40 -450 40 -370 {lab=VDD}
N 10 -450 10 -400 {lab=VDD}
N -110 -450 -110 -400 {lab=VDD}
N -140 -450 -140 -370 {lab=VDD}
N -110 -340 -110 -100 {lab=#net2}
N -70 -370 -70 -320 {lab=#net2}
N -70 -320 110 -320 {lab=#net2}
N 110 -370 110 -320 {lab=#net2}
N 40 -450 150 -450 {lab=VDD}
N 190 -450 260 -450 {lab=VDD}
N 90 -520 120 -520 {lab=VDD}
N 120 -550 120 -520 {lab=VDD}
N 90 -550 120 -550 {lab=VDD}
N 50 -520 50 -490 {lab=VDD}
N 50 -490 90 -490 {lab=VDD}
N 50 -490 50 -450 {lab=VDD}
N 120 -520 120 -490 {lab=VDD}
N 90 -490 120 -490 {lab=VDD}
C {MP.sym} 110 -370 0 0 {name=M4 model=PMOS w=10u l=2u nrd=0 nrs=0 m=16 spiceprefix=X}
C {devices/ipin.sym} -260 -500 0 0 {name=p4 lab=VDD}
C {devices/lab_pin.sym} -220 -450 0 0 {name=p6 sig_type=std_logic lab=VDD}
C {MP.sym} -70 -370 0 1 {name=M9 model=PMOS w=10u l=2u nrd=0 nrs=0 m=2 spiceprefix=X}
C {MP.sym} -30 -370 0 0 {name=M10 model=PMOS w=10u l=2u nrd=0 nrs=0 m=2 spiceprefix=X}
C {MP.sym} 50 -520 0 0 {name=M1 model=PMOS w=10u l=2u nrd=0 nrs=0 m=4 spiceprefix=X}
