v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 40 -290 140 -290 {lab=VDD}
N 140 -290 140 -150 {lab=VDD}
N 140 -290 1350 -290 {lab=VDD}
N 1350 -290 1350 -150 {lab=VDD}
N 950 -290 950 -150 {lab=VDD}
N 550 -290 550 -150 {lab=VDD}
N 140 -70 140 -10 {lab=VSS}
N 140 -10 1350 -10 {lab=VSS}
N 1350 -70 1350 -10 {lab=VSS}
N 950 -70 950 -10 {lab=VSS}
N 550 -70 550 -10 {lab=VSS}
N -160 -250 -160 -150 {lab=WORD}
N -220 -250 -160 -250 {lab=WORD}
N 140 -90 140 -70 {lab=VSS}
N 1350 -90 1350 -70 {lab=VSS}
N 950 -90 950 -70 {lab=VSS}
N 550 -90 550 -70 {lab=VSS}
N -160 -250 1050 -250 {lab=WORD}
N 1050 -250 1050 -150 {lab=WORD}
N 650 -250 650 -150 {lab=WORD}
N 250 -250 250 -150 {lab=WORD}
C {1bit_sram.sym} -10 -120 0 0 {name=x1}
C {1bit_sram.sym} 400 -120 0 0 {name=x2}
C {1bit_sram.sym} 800 -120 0 0 {name=x3}
C {1bit_sram.sym} 1200 -120 0 0 {name=x4}
C {devices/iopin.sym} 40 -290 0 1 {name=p1 lab=VDD}
C {devices/opin.sym} 140 -130 0 0 {name=p2 lab=BIT_BAR_0}
C {devices/opin.sym} 550 -130 0 0 {name=p3 lab=BIT_BAR_1}
C {devices/opin.sym} 950 -130 0 0 {name=p4 lab=BIT_BAR_2}
C {devices/opin.sym} 1350 -130 0 0 {name=p5 lab=BIT_BAR_3}
C {devices/opin.sym} 140 -110 0 0 {name=p6 lab=BIT_0}
C {devices/opin.sym} 550 -110 0 0 {name=p7 lab=BIT_1}
C {devices/opin.sym} 950 -110 0 0 {name=p8 lab=BIT_2}
C {devices/opin.sym} 1350 -110 0 0 {name=p9 lab=BIT_3}
C {devices/ipin.sym} -220 -250 0 0 {name=p10 lab=WORD}
C {devices/iopin.sym} 1350 -10 0 0 {name=p11 lab=VSS}
