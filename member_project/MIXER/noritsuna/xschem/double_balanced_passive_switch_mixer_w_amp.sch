v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 320 -60 580 -60 {lab=#net1}
N 320 -40 580 -40 {lab=#net2}
N 320 -20 320 20 {lab=VSS}
N 320 20 880 20 {lab=VSS}
N 880 -20 880 20 {lab=VSS}
C {diff_amp.sym} 730 -40 0 0 {name=x1}
C {devices/iopin.sym} 580 -20 0 1 {name=p9 lab=T_BIAS}
C {devices/opin.sym} 880 -40 0 0 {name=p10 lab=RF_OUT}
C {double_balanced_passive_switch_mixer.sym} 170 -50 0 0 {name=x2}
C {devices/ipin.sym} 20 -80 0 0 {name=p2 lab=RF_P}
C {devices/ipin.sym} 20 -60 0 0 {name=p3 lab=LO_P}
C {devices/ipin.sym} 20 -40 0 0 {name=p4 lab=RF_N}
C {devices/ipin.sym} 20 -20 0 0 {name=p5 lab=LO_N}
C {devices/iopin.sym} 320 -80 0 0 {name=p1 lab=DC_BIAS}
C {devices/iopin.sym} 880 -60 0 0 {name=p6 lab=VDD}
C {devices/iopin.sym} 880 -20 0 0 {name=p7 lab=VSS}
