v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 330 20 360 20 {lab=#net1}
N 280 120 330 120 {lab=#net1}
N 280 150 280 180 {lab=GND}
N 360 150 360 180 {lab=GND}
N 280 180 360 180 {lab=GND}
N 220 100 220 120 {lab=#net2}
N 220 120 240 120 {lab=#net2}
N 360 20 360 90 {lab=#net1}
N 280 20 280 90 {lab=#net1}
N 330 20 330 120 {lab=#net1}
N 220 20 220 40 {lab=#net1}
N 220 20 280 20 {lab=#net1}
N 280 20 330 20 {lab=#net1}
N 500 20 530 20 {lab=#net3}
N 500 120 550 120 {lab=#net4}
N 500 150 500 180 {lab=GND}
N 580 150 580 180 {lab=GND}
N 500 180 580 180 {lab=GND}
N 440 100 440 120 {lab=#net5}
N 440 120 460 120 {lab=#net5}
N 580 20 580 90 {lab=#net3}
N 500 -80 550 -80 {lab=#net4}
N 500 -80 500 -70 {lab=#net4}
N 500 70 500 90 {lab=#net3}
N 440 20 440 40 {lab=#net3}
N 440 20 500 20 {lab=#net3}
N 500 -70 500 -60 {lab=#net4}
N 500 0 500 20 {lab=#net3}
N 500 20 500 70 {lab=#net3}
N 530 20 580 20 {lab=#net3}
N 550 -80 550 120 {lab=#net4}
C {devices/code.sym} -10 0 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/code_shown.sym} 0 160 0 0 {name=s1 only_toplevel=false value=".option savecurrents
.control
op
show m
save all
dc v3 0 1.5 0.01
plot -i(v3)
.endc"}
C {MP.sym} 240 120 0 0 {name=M1 model=PMOS w=60u l=4u nrd=0 nrs=0 m=12 spiceprefix=X}
C {devices/vsource.sym} 360 120 0 0 {name=V1 value=0.35 savecurrent=false}
C {devices/vsource.sym} 220 70 0 0 {name=V2 value=1.05 savecurrent=false}
C {MP.sym} 460 120 0 0 {name=M2 model=PMOS w=20u l=1u nrd=0 nrs=0 m=5 spiceprefix=X}
C {devices/vsource.sym} 580 120 0 0 {name=V3 value=0.7 savecurrent=false}
C {devices/vsource.sym} 440 70 0 0 {name=V4 value=1.11 savecurrent=false}
C {devices/gnd.sym} 360 180 0 0 {name=l1 lab=GND}
C {devices/gnd.sym} 580 180 0 0 {name=l2 lab=GND}
C {devices/vsource.sym} 500 -30 0 0 {name=V5 value=0.3 savecurrent=false}
