v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {TERNARY SRAM BITCELL / latch + two NMOS access devices / 6 MOS + 4 R} 40 -140 0 0 0.38 0.38 {}
T {Data: -5 / 0 / +5 V. WL OFF=-5 V; ON=+5 V. Bodies connect to VSS.} 40 -80 0 0 0.24 0.24 {}
C {/home/ishi-kai/balanced-ternary-logic/ternary_latch.sym} 500 300 0 0 {name=x_store}
C {devices/lab_pin.sym} 500 180 0 0 {name=l1 lab=VDD}
C {devices/lab_pin.sym} 500 400 0 0 {name=l2 lab=VSS}
C {TR-1umLIB/MN.sym} 200 260 1 0 {name=XM_A
model=NMOS
w=3.4u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MN.sym} 800 260 3 1 {name=XM_AB
model=NMOS
w=3.4u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
N 200 100 200 260 {lab=WL}
N 200 300 200 480 {lab=VSS}
C {devices/lab_pin.sym} 200 480 0 0 {name=l3 lab=VSS}
N 800 100 800 260 {lab=WL}
N 800 300 800 480 {lab=VSS}
C {devices/lab_pin.sym} 800 480 0 0 {name=l4 lab=VSS}
N 200 100 800 100 {lab=WL}
C {devices/ipin.sym} 200 100 0 0 {name=l5 lab=WL}
N 80 300 170 300 {lab=BL}
N 230 300 380 300 {lab=Q}
N 620 300 770 300 {lab=QB}
N 830 300 920 300 {lab=BLB}
C {devices/iopin.sym} 80 300 0 0 {name=l6 lab=BL}
C {devices/iopin.sym} 920 300 0 0 {name=l7 lab=BLB}
N 300 300 300 380 {lab=Q}
C {devices/opin.sym} 300 380 0 0 {name=l8 lab=Q}
N 700 300 700 380 {lab=QB}
C {devices/opin.sym} 700 380 0 0 {name=l9 lab=QB}
C {devices/iopin.sym} 320 570 0 0 {name=l10 lab=VDD}
C {devices/iopin.sym} 620 570 0 0 {name=l11 lab=VSS}
T {Q/QB are storage-node monitor ports; attach loads only in the TB.} 40 650 0 0 0.24 0.24 {}
T {Access W/L = 3.4u / 1u. No precharge, sense amplifier, or write driver in the cell.} 40 690 0 0 0.24 0.24 {}
