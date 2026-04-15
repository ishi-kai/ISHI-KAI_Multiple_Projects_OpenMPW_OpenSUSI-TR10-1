v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {OTA} 220 -605 0 0 0.8 0.8 {}
N 540 -300 540 -280 {lab=#net1}
N 380 -300 540 -300 {lab=#net1}
N 380 -300 380 -280 {lab=#net1}
N 460 -340 460 -300 {lab=#net1}
N 460 -410 510 -410 {lab=VDD}
N 460 -460 510 -460 {lab=VDD}
N 510 -460 510 -410 {lab=VDD}
N 460 -480 460 -440 {lab=VDD}
N 460 -250 540 -250 {lab=VDD}
N 380 -250 460 -250 {lab=VDD}
N 460 -500 460 -480 {lab=VDD}
N 520 -450 520 -260 {lab=VDD}
N 460 -480 520 -480 {lab=VDD}
N 540 -220 540 -180 {lab=#net2}
N 380 -220 380 -180 {lab=#net3}
N 460 -370 460 -340 {lab=#net1}
N 520 -480 520 -450 {lab=VDD}
N 460 -380 460 -370 {lab=#net1}
N 240 -300 240 -180 {lab=#net4}
N 680 -300 680 -180 {lab=OUT}
N 240 -120 240 -80 {lab=GND}
N 240 -80 680 -80 {lab=GND}
N 680 -120 680 -80 {lab=GND}
N 540 -120 540 -80 {lab=GND}
N 380 -120 380 -80 {lab=GND}
N 460 -80 460 -40 {lab=GND}
N 520 -480 680 -480 {lab=VDD}
N 680 -480 680 -360 {lab=VDD}
N 280 -330 640 -330 {lab=#net4}
N 240 -280 300 -280 {lab=#net4}
N 300 -330 300 -280 {lab=#net4}
N 280 -150 340 -150 {lab=#net3}
N 320 -200 380 -200 {lab=#net3}
N 320 -200 320 -150 {lab=#net3}
N 580 -150 640 -150 {lab=#net2}
N 540 -200 600 -200 {lab=#net2}
N 600 -200 600 -150 {lab=#net2}
N 240 -480 460 -480 {lab=VDD}
N 240 -480 240 -360 {lab=VDD}
N 580 -250 600 -250 {lab=INP}
N 320 -250 340 -250 {lab=INN}
N 680 -240 720 -240 {lab=OUT}
N 380 -150 540 -150 {lab=GND}
N 460 -150 460 -80 {lab=GND}
N 520 -260 520 -250 {lab=VDD}
N 680 -150 740 -150 {lab=GND}
N 740 -150 740 -80 {lab=GND}
N 680 -80 740 -80 {lab=GND}
N 180 -150 230 -150 {lab=GND}
N 180 -150 180 -80 {lab=GND}
N 180 -80 240 -80 {lab=GND}
N 230 -150 240 -150 {lab=GND}
N 460 -520 460 -500 {lab=VDD}
N 680 -330 740 -330 {lab=VDD}
N 740 -380 740 -330 {lab=VDD}
N 680 -380 740 -380 {lab=VDD}
N 180 -330 240 -330 {lab=VDD}
N 180 -380 180 -330 {lab=VDD}
N 180 -380 240 -380 {lab=VDD}
N 100 -410 120 -410 {lab=ib}
N 120 -410 120 -360 {lab=ib}
N 60 -360 120 -360 {lab=ib}
N 120 -410 140 -410 {lab=ib}
N 140 -410 420 -410 {lab=ib}
N 60 -480 240 -480 {lab=VDD}
N 60 -480 60 -440 {lab=VDD}
N 60 -380 60 -320 {lab=ib}
C {MP.sym} 420 -410 0 0 {name=M3 model=PMOS w=24u l=4u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 580 -250 0 1 {name=M4 model=PMOS w=12u l=4u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 580 -150 0 1 {name=M5 model=NMOS w=120u l=4u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 340 -250 0 0 {name=M6 model=PMOS w=12u l=4u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 340 -150 0 0 {name=M7 model=NMOS w=120u l=4u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/ipin.sym} 460 -520 0 0 {name=p4 lab=VDD}
C {devices/ipin.sym} 460 -40 0 0 {name=p5 lab=GND}
C {MN.sym} 640 -150 0 0 {name=M8 model=NMOS w=4u l=4u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 280 -150 0 1 {name=M9 model=NMOS w=4u l=4u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 640 -330 0 0 {name=M10 model=PMOS w=12u l=4u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 280 -330 0 1 {name=M11 model=PMOS w=12u l=4u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/ipin.sym} 320 -250 0 0 {name=p6 lab=INN}
C {devices/ipin.sym} 600 -250 0 1 {name=p7 lab=INP}
C {devices/opin.sym} 720 -240 0 0 {name=p9 lab=OUT}
C {MP.sym} 100 -410 0 1 {name=M1 model=PMOS w=8u l=4u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/ipin.sym} 60 -320 0 0 {name=p1 lab=ib}
