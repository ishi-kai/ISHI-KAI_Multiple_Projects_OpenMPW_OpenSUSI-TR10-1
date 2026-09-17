v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -620 -250 -620 -190 {lab=VSS}
N -580 -280 -540 -280 {lab=R_D_G}
N -700 -280 -620 -280 {lab=VSS}
N -700 -280 -700 -210 {lab=VSS}
N -700 -210 -620 -210 {lab=VSS}
N -540 -280 -500 -280 {lab=R_D_G}
N -580 -380 -500 -380 {lab=R_U_G}
N -540 -330 -540 -280 {lab=R_D_G}
N -620 -350 -620 -310 {lab=R_D_G}
N -620 -470 -620 -430 {lab=R_U_G}
N -800 -470 -800 -410 {lab=T_D}
N -620 -430 -620 -410 {lab=R_U_G}
N -700 -380 -620 -380 {lab=VSS}
N -700 -380 -700 -280 {lab=VSS}
N -800 -250 -800 -190 {lab=VSS}
N -760 -280 -720 -280 {lab=L_D_G}
N -880 -280 -800 -280 {lab=VSS}
N -880 -280 -880 -210 {lab=VSS}
N -880 -210 -800 -210 {lab=VSS}
N -720 -330 -720 -280 {lab=L_D_G}
N -800 -350 -800 -310 {lab=#net1}
N -880 -380 -800 -380 {lab=VSS}
N -880 -380 -880 -280 {lab=VSS}
N -760 -380 -740 -380 {lab=L_U_G}
N -740 -450 -740 -380 {lab=L_U_G}
N -740 -500 -740 -450 {lab=L_U_G}
N -800 -210 -700 -210 {lab=VSS}
N -540 -450 -540 -380 {lab=R_U_G}
N -740 -580 -740 -500 {lab=L_U_G}
N -720 -540 -720 -330 {lab=L_D_G}
N -620 -330 -540 -330 {lab=R_D_G}
N -620 -450 -540 -450 {lab=R_U_G}
C {MN.sym} -580 -380 0 1 {name=MM1 model=NMOS w=84u l=8u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MN.sym} -580 -280 0 1 {name=MM2 model=NMOS w=84u l=8u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MN.sym} -760 -380 0 1 {name=MM11 model=NMOS w=84u l=8u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {MN.sym} -760 -280 0 1 {name=MM12 model=NMOS w=84u l=8u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {devices/iopin.sym} -620 -190 0 0 {name=p1 lab=VSS}
C {devices/iopin.sym} -500 -280 0 0 {name=p2 lab=R_D_G}
C {devices/iopin.sym} -500 -380 0 0 {name=p3 lab=R_U_G}
C {devices/iopin.sym} -740 -580 0 0 {name=p4 lab=L_U_G}
C {devices/iopin.sym} -720 -540 0 0 {name=p5 lab=L_D_G}
C {devices/iopin.sym} -800 -470 0 1 {name=p6 lab=T_D}
