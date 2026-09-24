v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
L 4 780 20 780 60 {}
L 4 780 60 1020 60 {}
L 4 1420 20 1420 60 {}
L 4 1020 60 1420 60 {}
T {Differential input stage (rail-to-rail)} 780 80 0 0 0.4 0.4 {}
N 880 -1020 880 -900 {lab=#net1}
N 880 -870 900 -870 {lab=VDD}
N 900 -1050 900 -870 {lab=VDD}
N 880 -1050 900 -1050 {lab=VDD}
N 880 -1050 900 -1050 {lab=VDD}
N 900 -1080 900 -1050 {lab=VDD}
N 880 -840 880 -720 {lab=#net2}
N 880 -690 900 -690 {lab=VDD}
N 900 -870 900 -690 {lab=VDD}
N 880 -1200 880 -1080 {lab=VDD}
N 900 -1200 900 -1080 {lab=VDD}
N 880 -1200 900 -1200 {lab=VDD}
N 800 -1050 840 -1050 {lab=BPO}
N 800 -870 840 -870 {lab=BPI}
N 800 -690 840 -690 {lab=INP}
N 1120 -1020 1120 -900 {lab=#net1}
N 1100 -870 1120 -870 {lab=VDD}
N 1100 -1050 1100 -870 {lab=VDD}
N 1100 -1050 1120 -1050 {lab=VDD}
N 1100 -1050 1120 -1050 {lab=VDD}
N 1100 -1080 1100 -1050 {lab=VDD}
N 1120 -840 1120 -720 {lab=#net2}
N 1100 -690 1120 -690 {lab=VDD}
N 1100 -870 1100 -690 {lab=VDD}
N 1120 -1200 1120 -1080 {lab=VDD}
N 1100 -1200 1100 -1080 {lab=VDD}
N 1100 -1200 1120 -1200 {lab=VDD}
N 1160 -1050 1200 -1050 {lab=BPO}
N 1160 -870 1200 -870 {lab=BPI}
N 920 -1200 1100 -1200 {lab=VDD}
N 880 -660 880 -540 {lab=CN_PP3}
N 1120 -660 1120 -540 {lab=MP3}
N 1000 -620 1000 -540 {lab=CP_PN3}
N 1000 -480 1000 -360 {lab=#net3}
N 1000 -300 1000 -180 {lab=#net4}
N 1000 -120 1000 0 {lab=VSS}
N 1000 -510 1020 -510 {lab=VSS}
N 1020 -510 1020 0 {lab=VSS}
N 1000 0 1020 0 {lab=VSS}
N 1000 -150 1020 -150 {lab=VSS}
N 1000 -330 1020 -330 {lab=VSS}
N 900 -1200 920 -1200 {lab=VDD}
N 880 -840 1120 -840 {lab=#net2}
N 800 -510 960 -510 {lab=INP}
N 800 -690 800 -510 {lab=INP}
N 920 -330 960 -330 {lab=BNI}
N 920 -150 960 -150 {lab=#net5}
N 1320 -620 1320 -540 {lab=MN3}
N 1320 -480 1320 -360 {lab=#net3}
N 1320 -300 1320 -180 {lab=#net4}
N 1320 -120 1320 0 {lab=VSS}
N 1300 -510 1320 -510 {lab=VSS}
N 1300 -510 1300 0 {lab=VSS}
N 1300 0 1320 0 {lab=VSS}
N 1300 -150 1320 -150 {lab=VSS}
N 1300 -330 1320 -330 {lab=VSS}
N 1360 -330 1400 -330 {lab=BNI}
N 1360 -150 1400 -150 {lab=BNO}
N 1360 -510 1400 -510 {lab=INM}
N 1400 -690 1400 -510 {lab=INM}
N 1020 0 1300 0 {lab=VSS}
N 1120 -1200 1480 -1200 {lab=VDD}
N 1320 0 1520 -0 {lab=VSS}
N 1120 -280 1680 -280 {lab=MP3}
N 880 -540 880 -260 {lab=CN_PP3}
N 880 -260 1920 -260 {lab=CN_PP3}
N 1010 -980 1920 -980 {lab=CP_PN3}
N 1320 -960 1680 -960 {lab=MN3}
N 1160 -690 1400 -690 {lab=INM}
N 1320 -960 1320 -620 {lab=MN3}
N 1000 -980 1010 -980 {lab=CP_PN3}
N 1000 -980 1000 -620 {lab=CP_PN3}
N 1480 -1200 1560 -1200 {lab=VDD}
N 1000 -360 1320 -360 {lab=#net3}
N 1120 -540 1120 -280 {lab=MP3}
N 880 -1020 1120 -1020 {lab=#net1}
N 1000 -180 1320 -180 {lab=#net4}
C {IP62LIB/MP.sym} 840 -1050 0 0 {name=XMINPP1 model=PMOS w=13.2u l=5u m=8 as=20.4p ad=20.4p ps=16.6u pd=16.6u nrd=0 nrs=0}
C {IP62LIB/MP.sym} 840 -870 0 0 {name=XMINPP2 model=PMOS w=13.2u l=5u m=8 as=20.4p ad=20.4p ps=16.6u pd=16.6u nrd=0 nrs=0}
C {IP62LIB/MP.sym} 840 -690 0 0 {name=XMINPP3 model=PMOS w=13.2u l=5u m=8 as=20.4p ad=20.4p ps=16.6u pd=16.6u nrd=0 nrs=0}
C {IP62LIB/MP.sym} 1160 -1050 0 1 {name=XMINMP1 model=PMOS w=13.2u l=5u m=8 as=20.4p ad=20.4p ps=16.6u pd=16.6u nrd=0 nrs=0}
C {IP62LIB/MP.sym} 1160 -870 0 1 {name=XMINMP2 model=PMOS w=13.2u l=5u m=8 as=20.4p ad=20.4p ps=16.6u pd=16.6u nrd=0 nrs=0}
C {IP62LIB/MP.sym} 1160 -690 0 1 {name=XMINMP3 model=PMOS w=13.2u l=5u m=8 as=20.4p ad=20.4p ps=16.6u pd=16.6u nrd=0 nrs=0}
C {devices/lab_wire.sym} 1180 -1050 0 1 {name=p5 sig_type=std_logic lab=BPO
m=4
w=13.2u}
C {devices/lab_wire.sym} 1180 -870 0 1 {name=p6 sig_type=std_logic lab=BPI
m=4
w=13.2u}
C {IP62LIB/MN.sym} 960 -330 0 0 {name=XMINPN2 model=NMOS w=4.8u l=5u m=8 as=7.2p ad=7.2p ps=7.8u pd=7.8u nrd=0 nrs=0}
C {IP62LIB/MN.sym} 960 -150 0 0 {name=XMINPN1 model=NMOS w=4.8u l=5u m=8 as=7.2p ad=7.2p ps=7.8u pd=7.8u nrd=0 nrs=0}
C {IP62LIB/MN.sym} 960 -510 0 0 {name=XMINPN3 model=NMOS w=4.8u l=5u m=8 as=7.2p ad=7.2p ps=7.8u pd=7.8u nrd=0 nrs=0}
C {IP62LIB/MN.sym} 1360 -330 0 1 {name=XMINMN2 model=NMOS w=4.8u l=5u m=8 as=7.2p ad=7.2p ps=7.8u pd=7.8u nrd=0 nrs=0}
C {IP62LIB/MN.sym} 1360 -150 0 1 {name=XMINMN1 model=NMOS w=4.8u l=5u m=8 as=7.2p ad=7.2p ps=7.8u pd=7.8u nrd=0 nrs=0}
C {IP62LIB/MN.sym} 1360 -510 0 1 {name=XMINMN3 model=NMOS w=4.8u l=5u m=8 as=7.2p ad=7.2p ps=7.8u pd=7.8u nrd=0 nrs=0}
C {devices/lab_wire.sym} 1380 -330 0 1 {name=p16 sig_type=std_logic lab=BNI
m=4}
C {devices/lab_wire.sym} 1380 -150 0 1 {name=p17 sig_type=std_logic lab=BNO}
C {devices/iopin.sym} 880 -1200 2 0 {name=p22 lab=VDD}
C {devices/iopin.sym} 1000 0 2 0 {name=p23 lab=VSS}
C {devices/ipin.sym} 800 -510 0 0 {name=p7 lab=INP}
C {devices/ipin.sym} 1400 -690 0 1 {name=p24 lab=INM}
C {devices/opin.sym} 1920 -980 0 0 {name=p31 lab=CP_PN3}
C {devices/opin.sym} 1680 -960 0 0 {name=p32 lab=MN3}
C {devices/opin.sym} 1920 -260 0 0 {name=p10 lab=CN_PP3}
C {devices/opin.sym} 1680 -280 0 0 {name=p33 lab=MP3}
C {devices/ipin.sym} 920 -330 0 0 {name=p2 lab=BNI}
C {devices/ipin.sym} 800 -870 0 0 {name=p13 lab=BPI}
C {devices/ipin.sym} 800 -1050 0 0 {name=p14 lab=BPO}
C {devices/ipin.sym} 920 -150 0 0 {name=p1 lab=BNO}
