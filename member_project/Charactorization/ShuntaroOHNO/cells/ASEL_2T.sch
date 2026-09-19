v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 50 -50 50 -40 {lab=VDD}
N 50 40 50 50 {lab=VSS}
N 120 0 120 60 {lab=#net1}
N 150 10 150 60 {lab=#net1}
N 330 10 330 60 {lab=#net1}
N 140 -10 150 -10 {lab=#net2}
N 140 -10 140 70 {lab=#net2}
N 320 -10 330 -10 {lab=#net2}
N 320 -10 320 70 {lab=#net2}
N 0 0 0 70 {lab=#net2}
N 290 10 310 10 {lab=P1}
N 310 -60 310 10 {lab=P1}
N 470 10 490 10 {lab=P4}
N 490 -60 490 10 {lab=P4}
N 290 -10 300 -10 {lab=DH}
N 470 -10 480 -10 {lab=DL}
N 480 -10 480 80 {lab=DL}
N 300 -10 300 80 {lab=DH}
N -10 50 50 50 {lab=VSS}
N -10 -50 50 -50 {lab=VDD}
N 50 -50 400 -50 {lab=VDD}
N 50 50 400 50 {lab=VSS}
N -0 70 320 70 {lab=#net2}
N 120 60 330 60 {lab=#net1}
N -130 -60 -80 -60 {lab=VDD}
N -80 -60 -10 -60 {lab=VDD}
N -10 -60 -10 -50 {lab=VDD}
N -130 60 -10 60 {lab=VSS}
N -10 50 -10 60 {lab=VSS}
C {TR-1um_5_stdcell/INV_X1.sym} 20 0 0 0 {name=x1}
C {TG.sym} 220 10 0 0 {name=x2}
C {TG.sym} 400 10 0 0 {name=x3}
C {devices/iopin.sym} 300 80 0 0 {name=p1 lab=DH}
C {devices/iopin.sym} 480 80 0 0 {name=p2 lab=DL}
C {devices/iopin.sym} 310 -60 0 0 {name=p5 lab=P1}
C {devices/iopin.sym} 490 -60 0 0 {name=p6 lab=P4}
C {devices/iopin.sym} -130 -60 0 1 {name=p10 lab=VDD}
C {devices/iopin.sym} -130 60 0 1 {name=p11 lab=VSS}
C {TR-1um_5_stdcell/NOR2.sym} -110 0 0 0 {name=x4}
C {devices/iopin.sym} -130 -20 0 1 {name=p3 lab=HG}
C {devices/iopin.sym} -130 20 0 1 {name=p4 lab=LN}
