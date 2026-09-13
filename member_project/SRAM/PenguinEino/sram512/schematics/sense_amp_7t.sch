v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {7T CLOCKED SENSE AMPLIFIER} -140 -140 0 0 0.45 0.45 {}
T {SAE = 0: track / reset    |    SAE = 1: isolate / regenerate} -140 -90 0 0 0.3 0.3 {}
T {All W/L = 3.4u / 1u (starting dimensions)} -140 800 0 0 0.28 0.28 {}
N 0 -10 0 30 {lab=BL}
N -100 90 0 90 {lab=SOUT}
N -100 90 -100 380 {lab=SOUT}
N -100 380 0 380 {lab=SOUT}
N 480 -10 480 30 {lab=BLB}
N 480 90 580 90 {lab=SOUTB}
N 580 90 580 400 {lab=SOUTB}
N 480 400 580 400 {lab=SOUTB}
N 0 220 0 270 {lab=VDD}
N 0 330 0 470 {lab=SOUT}
N 40 300 180 300 {lab=SOUTB}
N 180 300 180 500 {lab=SOUTB}
N 40 500 180 500 {lab=SOUTB}
N 0 530 0 580 {lab=#net1}
N 480 220 480 270 {lab=VDD}
N 480 330 480 470 {lab=SOUTB}
N 300 300 440 300 {lab=SOUT}
N 300 300 300 500 {lab=SOUT}
N 300 500 440 500 {lab=SOUT}
N 480 530 480 580 {lab=#net1}
N 0 380 300 380 {lab=SOUT}
N 180 400 480 400 {lab=SOUTB}
N 0 580 480 580 {lab=#net1}
N 240 580 240 620 {lab=#net1}
N 240 680 240 730 {lab=VSS}
C {TR-1umLIB/MP.sym} 40 60 0 1 {name=XP_ISO_L
model=PMOS
w=3.4u
l=1u
m=1
spiceprefix=X
nrd=0
nrs=0}
C {devices/ipin.sym} 0 -10 0 0 {name=pBL lab=BL}
C {devices/lab_pin.sym} 40 60 2 0 {name=l12 lab=SAE}
C {devices/lab_pin.sym} 0 60 0 0 {name=l16 lab=VDD}
C {TR-1umLIB/MP.sym} 440 60 0 0 {name=XP_ISO_R
model=PMOS
w=3.4u
l=1u
m=1
spiceprefix=X
nrd=0
nrs=0}
C {devices/ipin.sym} 480 -10 0 0 {name=pBLB lab=BLB}
C {devices/lab_pin.sym} 440 60 0 0 {name=l20 lab=SAE}
C {devices/lab_pin.sym} 480 60 2 0 {name=l24 lab=VDD}
C {TR-1umLIB/MP.sym} 40 300 0 1 {name=XP_L
model=PMOS
w=3.4u
l=1u
m=1
spiceprefix=X
nrd=0
nrs=0}
C {TR-1umLIB/MN.sym} 40 500 0 1 {name=XN_L
model=NMOS
w=3.4u
l=1u
m=1
spiceprefix=X
nrd=0
nrs=0}
C {devices/lab_pin.sym} 0 220 0 0 {name=l28 lab=VDD}
C {devices/lab_pin.sym} 0 300 0 0 {name=l29 lab=VDD}
C {devices/lab_pin.sym} 0 500 0 0 {name=l30 lab=VSS}
C {TR-1umLIB/MP.sym} 440 300 0 0 {name=XP_R
model=PMOS
w=3.4u
l=1u
m=1
spiceprefix=X
nrd=0
nrs=0}
C {TR-1umLIB/MN.sym} 440 500 0 0 {name=XN_R
model=NMOS
w=3.4u
l=1u
m=1
spiceprefix=X
nrd=0
nrs=0}
C {devices/lab_pin.sym} 480 220 2 0 {name=l39 lab=VDD}
C {devices/lab_pin.sym} 480 300 2 0 {name=l40 lab=VDD}
C {devices/lab_pin.sym} 480 500 2 0 {name=l41 lab=VSS}
C {devices/opin.sym} -100 380 2 0 {name=pout lab=SOUT}
C {devices/opin.sym} 580 400 0 0 {name=poutb lab=SOUTB}
C {TR-1umLIB/MN.sym} 200 650 0 0 {name=XN_TAIL
model=NMOS
w=3.4u
l=1u
m=1
spiceprefix=X
nrd=0
nrs=0}
C {devices/lab_pin.sym} 200 650 0 0 {name=l54 lab=SAE}
C {devices/lab_pin.sym} 240 650 2 0 {name=l55 lab=VSS}
C {devices/iopin.sym} 240 730 1 0 {name=pvss lab=VSS}
C {devices/iopin.sym} 240 160 0 0 {name=pvdd lab=VDD}
C {devices/ipin.sym} -100 650 0 0 {name=psae lab=SAE}
