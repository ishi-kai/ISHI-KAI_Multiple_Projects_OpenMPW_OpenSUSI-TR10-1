v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 50 -50 50 -40 {lab=#net1}
N 50 -50 760 -50 {lab=#net1}
N 50 40 50 50 {lab=VSS}
N 50 50 760 50 {lab=VSS}
N 120 0 120 60 {lab=#net2}
N 150 10 150 60 {lab=#net2}
N 330 10 330 60 {lab=#net2}
N 510 10 510 60 {lab=#net2}
N 690 10 690 60 {lab=#net2}
N 120 60 690 60 {lab=#net2}
N 140 -10 150 -10 {lab=#net3}
N 140 -10 140 70 {lab=#net3}
N 320 -10 330 -10 {lab=#net3}
N 320 -10 320 70 {lab=#net3}
N 500 -10 510 -10 {lab=#net3}
N 500 -10 500 70 {lab=#net3}
N 680 -10 690 -10 {lab=#net3}
N 680 -10 680 70 {lab=#net3}
N 0 70 680 70 {lab=#net3}
N 290 10 310 10 {lab=P1}
N 310 -60 310 10 {lab=P1}
N 470 10 490 10 {lab=P2}
N 490 -60 490 10 {lab=P2}
N 650 10 670 10 {lab=P4}
N 670 -60 670 10 {lab=P4}
N 830 10 850 10 {lab=P5}
N 850 -60 850 10 {lab=P5}
N 290 -10 300 -10 {lab=DA}
N 470 -10 480 -10 {lab=DA}
N 480 -10 480 80 {lab=DA}
N 300 -10 300 80 {lab=DA}
N 650 -10 660 -10 {lab=DB}
N 660 -10 660 80 {lab=DB}
N 830 -10 840 -10 {lab=DB}
N 840 -10 840 80 {lab=DB}
N -10 50 50 50 {lab=VSS}
N -10 -50 50 -50 {lab=#net1}
N 1010 10 1030 10 {lab=P6}
N 1030 -60 1030 10 {lab=P6}
N 1010 -10 1020 -10 {lab=DG}
N 1020 -10 1020 80 {lab=DG}
N 760 -50 940 -50 {lab=#net1}
N 760 50 940 50 {lab=VSS}
N 680 70 860 70 {lab=#net3}
N 860 -10 870 -10 {lab=#net3}
N 860 -10 860 70 {lab=#net3}
N 690 60 870 60 {lab=#net2}
N 870 10 870 60 {lab=#net2}
N 660 80 840 80 {lab=DB}
N 300 80 480 80 {lab=DA}
N 0 0 0 70 {lab=#net4}
N -130 -60 -10 -60 {lab=VDD}
N -10 -60 -10 -50 {lab=VDD}
N -130 60 -10 60 {lab=VSS}
N -10 50 -10 60 {lab=VSS}
C {TR-1um_5_stdcell/INV_X1.sym} 20 0 0 0 {name=x1}
C {TG.sym} 220 10 0 0 {name=x2}
C {TG.sym} 400 10 0 0 {name=x3}
C {TG.sym} 580 10 0 0 {name=x4}
C {TG.sym} 760 10 0 0 {name=x5}
C {devices/iopin.sym} 480 80 0 0 {name=p2 lab=DA}
C {devices/iopin.sym} 840 80 0 0 {name=p4 lab=DB}
C {devices/iopin.sym} 310 -60 0 0 {name=p5 lab=P1}
C {devices/iopin.sym} 490 -60 0 0 {name=p6 lab=P2}
C {devices/iopin.sym} 670 -60 0 0 {name=p7 lab=P4}
C {devices/iopin.sym} 850 -60 0 0 {name=p8 lab=P5}
C {TG.sym} 940 10 0 0 {name=x6}
C {devices/iopin.sym} 1020 80 0 0 {name=p12 lab=DG}
C {devices/iopin.sym} 1030 -60 0 0 {name=p13 lab=P6}
C {devices/iopin.sym} -130 -60 0 1 {name=p1 lab=VDD}
C {devices/iopin.sym} -130 60 0 1 {name=p3 lab=VSS}
C {TR-1um_5_stdcell/NOR2.sym} -110 0 0 0 {name=x7}
C {devices/iopin.sym} -130 -20 0 1 {name=p9 lab=HG}
C {devices/iopin.sym} -130 20 0 1 {name=p14 lab=LN}
