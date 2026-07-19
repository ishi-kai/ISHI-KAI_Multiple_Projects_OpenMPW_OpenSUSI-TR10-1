v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 440 240 460 240 {lab=#net1}
N 460 280 460 320 {lab=RampOut}
N 580 260 580 320 {lab=RampOut}
N 460 320 580 320 {lab=RampOut}
N 420 20 460 20 {lab=Comp}
N 220 40 280 40 {lab=v1v}
N 220 200 280 200 {lab=#net2}
N 220 220 280 220 {lab=#net3}
N 220 180 460 180 {lab=#net4}
N 460 180 460 220 {lab=#net4}
N 220 100 440 100 {lab=#net1}
N 440 100 440 240 {lab=#net1}
N 220 160 450 160 {lab=#net5}
N 450 -40 450 160 {lab=#net5}
N 450 -40 460 -40 {lab=#net5}
N 220 60 250 60 {lab=#net6}
N 250 60 250 280 {lab=#net6}
N 250 280 280 280 {lab=#net6}
N 220 20 260 20 {lab=#net7}
N 260 20 260 260 {lab=#net7}
N 260 260 280 260 {lab=#net7}
N 270 60 280 60 {lab=#net8}
N 270 60 270 140 {lab=#net8}
N 220 260 230 260 {lab=#net8}
N 230 140 230 260 {lab=#net8}
N 230 140 270 140 {lab=#net8}
N 280 80 280 150 {lab=#net9}
N 240 150 280 150 {lab=#net9}
N 240 150 240 280 {lab=#net9}
N 220 280 240 280 {lab=#net9}
N 220 -60 630 -60 {lab=#net10}
N 510 -60 510 -50 {lab=#net10}
N 630 -60 630 -50 {lab=#net10}
N 510 210 520 210 {lab=Vdd}
N 520 -80 520 210 {lab=Vdd}
N 350 -60 350 -10 {lab=#net10}
N 350 110 350 340 {lab=Vss}
N 360 -60 360 170 {lab=#net10}
N 360 310 360 340 {lab=Vss}
N 510 310 510 340 {lab=Vss}
N 120 310 120 340 {lab=Vss}
N 500 50 510 50 {lab=Vss}
N 500 50 500 340 {lab=Vss}
N 630 50 630 340 {lab=Vss}
N 750 50 750 340 {lab=Vss}
N 750 -80 750 -50 {lab=Vdd}
N 820 -0 880 0 {lab=#net11}
N 120 -80 120 -30 {lab=Vdd}
N 20 -20 460 -20 {lab=RampIn}
N 850 -80 850 -40 {lab=Vdd}
N 880 -80 880 -40 {lab=Vdd}
N 20 -80 880 -80 {lab=Vdd}
N 20 340 750 340 {lab=Vss}
N 280 -40 280 20 {lab=SS}
N 220 120 240 120 {lab=SS}
N 240 -40 240 120 {lab=SS}
N 20 -40 280 -40 {lab=SS}
N 580 260 940 260 {lab=RampOut}
N 910 -40 940 -40 {lab=Vout}
N 420 80 940 80 {lab=FB}
N 460 20 460 100 {lab=Comp}
N 460 100 940 100 {lab=Comp}
N 220 -60 220 0 {lab=#net10}
C {ramp.sym} 360 260 0 0 {name=x2}
C {pwm.sym} 350 60 0 0 {name=x3}
C {comparator.sym} 480 0 0 0 {name=x4}
C {inverter_15v.sym} 600 0 0 0 {name=x5}
C {inverter_sw.sym} 720 0 0 0 {name=x6}
C {opamp_ramp.sym} 480 260 0 0 {name=x7}
C {devices/opin.sym} 940 260 0 0 {name=p1 lab=RampOut}
C {devices/ipin.sym} 20 -20 0 0 {name=p2 lab=RampIn}
C {IP62LIB/MP.sym} 880 0 3 0 {name=XM1
model=PMOS
w=25u
l=1u
m=66
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {devices/opin.sym} 940 -40 0 0 {name=p4 lab=Vout}
C {devices/ipin.sym} 940 80 0 1 {name=p5 lab=FB}
C {devices/iopin.sym} 20 -80 0 1 {name=p6 lab=Vdd}
C {devices/iopin.sym} 20 340 0 1 {name=p7 lab=Vss}
C {devices/iopin.sym} 20 -40 0 1 {name=p3 lab=SS}
C {devices/opin.sym} 940 100 0 0 {name=p8 lab=Comp}
C {bgr.sym} 120 140 0 0 {name=x1}
C {devices/lab_pin.sym} 220 40 0 0 {name=p9 sig_type=std_logic lab=v1v}
