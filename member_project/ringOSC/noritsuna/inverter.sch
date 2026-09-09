v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -10 -40 -10 40 {lab=vin}
N 30 -80 30 -70 {lab=#net1}
N 30 70 30 80 {lab=#net2}
N 30 140 30 160 {lab=gnd}
N 30 150 40 150 {lab=gnd}
N 40 40 40 150 {lab=gnd}
N 30 40 40 40 {lab=gnd}
N 30 110 40 110 {lab=gnd}
N 30 -160 30 -140 {lab=vdd}
N 30 -150 40 -150 {lab=vdd}
N 40 -150 40 -40 {lab=vdd}
N 30 -40 40 -40 {lab=vdd}
N 30 -110 40 -110 {lab=vdd}
N -40 0 -10 0 {lab=vin}
N -40 110 -10 110 {lab=vctrl}
N -40 -110 -10 -110 {lab=vvctrl}
N 30 -10 30 10 {lab=vout}
N 30 0 160 -0 {lab=vout}
N 160 0 300 -0 {lab=vout}
N 230 0 230 40 {lab=vout}
N 40 150 230 150 {lab=gnd}
N 230 100 230 150 {lab=gnd}
N 210 70 210 150 {lab=gnd}
N 160 0 160 40 {lab=vout}
N 160 100 160 150 {lab=gnd}
N 140 70 140 150 {lab=gnd}
C {devices/ipin.sym} -40 0 0 0 {name=p1 lab=vin}
C {devices/opin.sym} 300 0 0 0 {name=p2 lab=vout}
C {devices/iopin.sym} 30 -160 3 0 {name=p3 lab=vdd}
C {devices/iopin.sym} 30 160 3 1 {name=p4 lab=gnd}
C {devices/ipin.sym} -40 110 0 0 {name=p5 lab=vctrl}
C {devices/ipin.sym} -40 -110 0 0 {name=p6 lab=vvctrl}
C {IP62LIB/MN.sym} -10 40 0 0 {name=XM1 model=NMOS w=3.4u l=3.4u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0 dm=1}
C {IP62LIB/MP.sym} -10 -40 0 0 {name=XM2 model=PMOS w=10.2u l=3.4u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0 dm=1}
C {IP62LIB/MN.sym} -10 110 0 0 {name=XM3 model=NMOS w=6.8u l=30u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0 dm=1}
C {IP62LIB/MP.sym} -10 -110 0 0 {name=XM4 model=PMOS w=20.4u l=30u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0 dm=1}
C {TR-1umLIB/CSIO.sym} 230 40 0 0 {name=XC1
model=F_CSIO
spiceprefix=X
x=80u
y=80u
c="expr_eng( 0.6e-3 * @x * @y )"
a="expr_eng( @x * @y )"
p="expr_eng( 2 * ( @x + @y ) )"
m=1}
C {TR-1umLIB/CSIO.sym} 160 40 0 0 {name=XC2
model=F_CSIO
spiceprefix=X
x=80u
y=80u
c="expr_eng( 0.6e-3 * @x * @y )"
a="expr_eng( @x * @y )"
p="expr_eng( 2 * ( @x + @y ) )"
m=1}
