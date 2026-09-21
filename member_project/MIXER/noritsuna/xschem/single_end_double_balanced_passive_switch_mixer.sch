v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -110 -300 -110 -230 {lab=VDD}
N -110 -300 450 -300 {lab=VDD}
N 400 -180 450 -180 {lab=VDD}
N 450 -300 450 -180 {lab=VDD}
N -110 -90 -80 -90 {lab=VDD}
N -80 -300 -80 -90 {lab=VDD}
N -110 -170 -60 -170 {lab=VSS}
N -60 -170 -60 -30 {lab=VSS}
N -110 -30 -60 -30 {lab=VSS}
N -110 -30 -60 -30 {lab=VSS}
N -60 -30 460 -30 {lab=VSS}
N 460 -140 460 -30 {lab=VSS}
N 400 -140 460 -140 {lab=VSS}
C {double_balanced_passive_switch_mixer_w_amp.sym} 250 -160 0 0 {name=x2}
C {single_to_diff_LO.sym} -260 -60 0 0 {name=x1}
C {single_to_diff_RF.sym} -260 -200 0 0 {name=x3}
C {devices/iopin.sym} 400 -200 0 0 {name=p9 lab=DC_BIAS}
C {devices/iopin.sym} 400 -120 0 0 {name=p1 lab=T_BIAS}
C {devices/ipin.sym} -410 -90 0 0 {name=p2 lab=LO_IN}
C {devices/ipin.sym} -410 -230 0 0 {name=p3 lab=RF_IN}
C {devices/iopin.sym} -110 -300 0 1 {name=p4 lab=VDD}
C {devices/iopin.sym} 460 -30 0 0 {name=p8 lab=VSS}
C {devices/opin.sym} 400 -160 0 0 {name=p7 lab=RF_OUT}
C {devices/opin.sym} -110 -210 2 1 {name=p5 lab=RF_N_OUT}
C {devices/opin.sym} -110 -190 2 1 {name=p6 lab=RF_P_OUT}
C {devices/opin.sym} -110 -50 2 1 {name=p10 lab=LO_P_OUT}
C {devices/opin.sym} -110 -70 2 1 {name=p11 lab=LO_N_OUT}
C {devices/ipin.sym} 100 -160 2 1 {name=p12 lab=RF_N_IN}
C {devices/ipin.sym} 100 -200 2 1 {name=p13 lab=RF_P_IN}
C {devices/ipin.sym} 100 -180 2 1 {name=p14 lab=LO_P_IN}
C {devices/ipin.sym} 100 -140 2 1 {name=p15 lab=LO_N_IN}
