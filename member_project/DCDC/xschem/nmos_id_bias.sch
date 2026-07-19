v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 300 20 300 30 {lab=#net1}
N 380 20 380 30 {lab=#net1}
N 300 60 350 60 {lab=GND}
N 300 90 300 120 {lab=#net2}
N 380 90 380 120 {lab=#net2}
N 240 140 380 140 {lab=#net2}
N 300 20 380 20 {lab=#net1}
N 240 60 260 60 {lab=#net3}
N 240 60 240 80 {lab=#net3}
N 380 120 380 140 {lab=#net2}
N 350 60 360 60 {lab=GND}
N 300 120 300 140 {lab=#net2}
N 360 60 360 200 {lab=GND}
N 360 200 380 200 {lab=GND}
N 540 90 540 120 {lab=#net4}
N 540 30 620 30 {lab=#net5}
N 480 60 500 60 {lab=#net6}
N 540 120 540 140 {lab=#net4}
N 620 30 620 140 {lab=#net5}
N 480 200 620 200 {lab=GND}
N 480 60 480 140 {lab=#net6}
N 540 60 600 60 {lab=GND}
N 600 60 600 200 {lab=GND}
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
dc vbias 0 0.4 0.01
plot -i(v5)
.endc"}
C {devices/vsource.sym} 380 60 0 0 {name=V1 value=0.7 savecurrent=false}
C {MN.sym} 260 60 0 0 {name=M1 model=NMOS w=20u l=1u nrd=0 nrs=0 m=5 spiceprefix=X}
C {devices/vsource.sym} 380 170 0 0 {name=V2 value=0.3 savecurrent=false}
C {devices/gnd.sym} 380 200 0 0 {name=l1 lab=GND}
C {devices/vsource.sym} 240 110 0 0 {name=V3 value=1.0 savecurrent=false}
C {MN.sym} 500 60 0 0 {name=M2 model=NMOS w=4u l=40u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/vsource.sym} 620 170 0 0 {name=V5 value=0.4 savecurrent=false}
C {devices/gnd.sym} 620 200 0 0 {name=l2 lab=GND}
C {devices/vsource.sym} 480 170 0 0 {name=V6 value=3.0 savecurrent=false}
C {devices/vsource.sym} 540 170 0 0 {name=Vbias value=0.1 savecurrent=false}
