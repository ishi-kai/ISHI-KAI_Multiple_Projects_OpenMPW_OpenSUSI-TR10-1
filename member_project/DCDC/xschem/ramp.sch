v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -20 60 0 60 {lab=0u5}
N 360 60 380 60 {lab=#net1}
N 420 60 480 60 {lab=vss}
N 420 90 420 120 {lab=#net2}
N 420 180 420 200 {lab=#net3}
N -20 180 0 180 {lab=0u5}
N -20 -20 -20 180 {lab=0u5}
N -20 -20 520 -20 {lab=0u5}
N 500 -20 500 30 {lab=0u5}
N 50 -40 50 -10 {lab=vdd}
N 170 -40 170 -10 {lab=vdd}
N 300 -40 300 10 {lab=vdd}
N 50 250 50 280 {lab=vss}
N 170 250 170 280 {lab=vss}
N 420 260 420 280 {lab=vss}
N 50 150 60 150 {lab=vdd}
N 60 -40 60 150 {lab=vdd}
N 170 150 180 150 {lab=vdd}
N 180 -40 180 150 {lab=vdd}
N 40 90 50 90 {lab=vss}
N 160 90 170 90 {lab=vss}
N 160 90 160 280 {lab=vss}
N 40 90 40 280 {lab=vss}
N 300 110 300 280 {lab=vss}
N 240 80 240 200 {lab=#net4}
N 440 60 440 280 {lab=vss}
N 500 90 500 280 {lab=vss}
N -40 0 -0 0 {lab=72ua}
N -40 20 -0 20 {lab=1v5}
N -40 160 -0 160 {lab=72ub}
N -40 220 -0 220 {lab=0v5}
N -40 280 500 280 {lab=vss}
N -40 -40 300 -40 {lab=vdd}
N 420 -20 420 30 {lab=0u5}
C {comparator.sym} 20 40 0 0 {name=x1}
C {comparator.sym} 20 200 0 0 {name=x2}
C {inverter_15v.sym} 140 40 0 0 {name=x3}
C {inverter_05v.sym} 140 200 0 0 {name=x4}
C {prsr_latch.sym} 300 60 0 0 {name=x5}
C {IP62LIB/MN.sym} 380 60 0 0 {name=XM1
model=NMOS
w=4u
l=2u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {IP62LIB/RR.sym} 420 120 0 0 {name=R1
w=2.8e-06
R=1
l=50e-06
model=F_RR
spiceprefix=X
tc1=0
tc2=0
m=1}
C {IP62LIB/RR.sym} 420 200 0 0 {name=R2
w=2.8e-06
R=1
l=50e-06
model=F_RR
spiceprefix=X
tc1=0
tc2=0
m=1}
C {IP62LIB/CSIO.sym} 500 30 0 0 {name=XC1
model=F_CSIO
spiceprefix=X
x=90.2u
y=90.2u
c="expr_eng( 0.6e-3 * @x * @y )"
a="expr_eng( @x * @y )"
p="expr_eng( 2 * ( @x + @y ) )"
m=1}
C {devices/iopin.sym} -40 -40 0 1 {name=p1 lab=vdd}
C {devices/iopin.sym} -40 280 0 1 {name=p2 lab=vss}
C {devices/ipin.sym} -40 20 0 0 {name=p4 lab=1v5}
C {devices/ipin.sym} -30 220 0 0 {name=p5 lab=0v5}
C {devices/opin.sym} 520 -20 0 0 {name=p6 lab=ramp}
C {devices/opin.sym} -40 0 0 1 {name=p7 lab=72ua}
C {devices/opin.sym} -40 160 0 1 {name=p8 lab=72ub}
