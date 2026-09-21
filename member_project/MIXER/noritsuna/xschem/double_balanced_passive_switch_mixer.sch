v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 160 -630 160 -580 {lab=DC_BIAS}
N 160 -520 160 -430 {lab=RF_P}
N 410 -460 410 -420 {lab=RF_P}
N -80 -460 160 -460 {lab=RF_P}
N 160 -460 410 -460 {lab=RF_P}
N -80 -400 120 -400 {lab=LO_P}
N -80 -230 120 -230 {lab=LO_N}
N 520 -50 520 10 {lab=IF_N}
N 330 -50 330 10 {lab=IF_P}
N 330 70 410 70 {lab=VSS}
N 160 -230 220 -230 {lab=VSS}
N 220 -230 220 70 {lab=VSS}
N 220 70 330 70 {lab=VSS}
N 410 -220 450 -220 {lab=VSS}
N 450 -220 450 70 {lab=VSS}
N 410 70 450 70 {lab=VSS}
N 410 -390 450 -390 {lab=VSS}
N 160 -400 220 -400 {lab=VSS}
N 220 -400 220 -230 {lab=VSS}
N 310 40 310 70 {lab=VSS}
N 500 40 500 70 {lab=VSS}
N 350 70 350 120 {lab=VSS}
N 450 -390 450 -220 {lab=VSS}
N 20 -400 20 -300 {lab=LO_P}
N 20 -300 370 -300 {lab=LO_P}
N 370 -300 370 -220 {lab=LO_P}
N 80 -320 80 -230 {lab=LO_N}
N 80 -320 370 -320 {lab=LO_N}
N 370 -390 370 -320 {lab=LO_N}
N -80 -270 410 -270 {lab=RF_N}
N 410 -270 410 -250 {lab=RF_N}
N 160 -270 160 -260 {lab=RF_N}
N 160 -370 330 -370 {lab=IF_P}
N 330 -370 330 -50 {lab=IF_P}
N 450 70 520 70 {lab=VSS}
N 410 -360 520 -360 {lab=IF_N}
N 520 -360 520 -50 {lab=IF_N}
N 160 -200 330 -200 {lab=IF_P}
N 410 -190 520 -190 {lab=IF_N}
N 160 -610 820 -610 {lab=DC_BIAS}
N 820 -610 820 -140 {lab=DC_BIAS}
N 680 -140 820 -140 {lab=DC_BIAS}
N 330 -140 620 -140 {lab=IF_P}
N 520 -80 720 -80 {lab=IF_N}
N 820 -140 820 -80 {lab=DC_BIAS}
N 780 -80 820 -80 {lab=DC_BIAS}
N 1720 -220 1720 -170 {lab=IF_P}
N 1640 -140 1680 -140 {lab=VSS}
N 1640 -140 1640 -70 {lab=VSS}
N 1640 -70 1720 -70 {lab=VSS}
N 1720 -110 1720 -70 {lab=VSS}
N 1720 -140 1750 -140 {lab=VSS}
N 1750 -140 1750 -70 {lab=VSS}
N 1720 -70 1750 -70 {lab=VSS}
N 1930 -220 1930 -170 {lab=IF_N}
N 1850 -140 1890 -140 {lab=VSS}
N 1850 -140 1850 -70 {lab=VSS}
N 1850 -70 1930 -70 {lab=VSS}
N 1930 -110 1930 -70 {lab=VSS}
N 1930 -140 1960 -140 {lab=VSS}
N 1960 -140 1960 -70 {lab=VSS}
N 1930 -70 1960 -70 {lab=VSS}
C {TR-1umLIB/MN.sym} 120 -400 0 0 {name=XM1
model=NMOS
w=100u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MN.sym} 370 -390 0 0 {name=XM2
model=NMOS
w=100u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MN.sym} 120 -230 0 0 {name=XM3
model=NMOS
w=100u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MN.sym} 370 -220 0 0 {name=XM4
model=NMOS
w=100u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {devices/iopin.sym} 160 -630 0 1 {name=p1 lab=DC_BIAS}
C {TR-1umLIB/RR.sym} 160 -580 0 0 {name=R1
l=49.4e-06
R=20.0e+03
w=2.8e-06
model=F_RR
spiceprefix=X
tc1=0
tc2=0
m=1}
C {TR-1umLIB/RR.sym} 680 -140 1 0 {name=R2
l=49.4e-06
R=20.0e+03
w=2.8e-06
model=F_RR
spiceprefix=X
tc1=0
tc2=0
m=1}
C {devices/ipin.sym} -80 -460 0 0 {name=p2 lab=RF_P}
C {devices/ipin.sym} -80 -400 0 0 {name=p3 lab=LO_P}
C {devices/ipin.sym} -80 -270 0 0 {name=p4 lab=RF_N}
C {devices/ipin.sym} -80 -230 0 0 {name=p5 lab=LO_N}
C {devices/opin.sym} 520 -50 0 0 {name=p6 lab=IF_N}
C {devices/opin.sym} 330 -50 0 0 {name=p7 lab=IF_P}
C {TR-1umLIB/CSIO.sym} 330 10 0 0 {name=XC1
model=F_CSIO
spiceprefix=X
x=90u
y=90u
c="expr_eng( 0.6e-3 * @x * @y )"
a="expr_eng( @x * @y )"
p="expr_eng( 2 * ( @x + @y ) )"
m=4}
C {TR-1umLIB/CSIO.sym} 520 10 0 0 {name=XC2
model=F_CSIO
spiceprefix=X
x=90u
y=90u
c="expr_eng( 0.6e-3 * @x * @y )"
a="expr_eng( @x * @y )"
p="expr_eng( 2 * ( @x + @y ) )"
m=4}
C {devices/iopin.sym} 350 120 0 0 {name=p8 lab=VSS}
C {TR-1umLIB/RR.sym} 780 -80 1 0 {name=R3
l=49.4e-06
R=20.0e+03
w=2.8e-06
model=F_RR
spiceprefix=X
tc1=0
tc2=0
m=1}
C {devices/lab_pin.sym} 180 -550 0 1 {name=l3 sig_type=std_logic lab=DC_BIAS}
C {devices/lab_pin.sym} 650 -120 0 1 {name=l4 sig_type=std_logic lab=DC_BIAS}
C {devices/lab_pin.sym} 750 -60 0 1 {name=l1 sig_type=std_logic lab=DC_BIAS}
C {TR-1umLIB/MN.sym} 1680 -140 0 0 {name=XM6
model=NMOS
w=10u
l=1u
m=4
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {devices/lab_pin.sym} 1640 -70 0 0 {name=p12 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 1720 -220 0 0 {name=p13 sig_type=std_logic lab=IF_P}
C {TR-1umLIB/MN.sym} 1890 -140 0 0 {name=XM7
model=NMOS
w=10u
l=1u
m=4
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {devices/lab_pin.sym} 1850 -70 0 0 {name=p14 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 1930 -220 0 0 {name=p15 sig_type=std_logic lab=IF_N}
