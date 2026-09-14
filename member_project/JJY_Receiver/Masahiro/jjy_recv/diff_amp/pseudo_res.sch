v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 510 210 550 210 {lab=#net1}
N 510 280 510 310 {lab=0}
N 490 160 510 160 {lab=VDD}
N 490 160 490 260 {lab=VDD}
N 490 260 520 260 {lab=VDD}
N 550 160 550 260 {lab=#net1}
N 510 190 510 230 {lab=#net1}
N 460 160 490 160 {lab=VDD}
N 510 50 510 60 {lab=VDD}
N 510 120 510 130 {lab=#net2}
N 440 160 460 160 {lab=VDD}
C {MP.sym} 550 160 0 1 {name=M5 model=PMOS w=45u l=8u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 550 260 2 0 {name=M10 model=PMOS w=45u l=8u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/ammeter.sym} 510 90 0 0 {name=Vmeas savecurrent=true spice_ignore=0}
C {devices/code.sym} 35 30 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/vsource.sym} 130 250 0 0 {name=VDD value=5 savecurrent=false}
C {devices/gnd.sym} 130 280 0 0 {name=l4 lab=0}
C {devices/vdd.sym} 130 220 0 0 {name=l5 lab=VDD}
C {devices/vdd.sym} 510 50 0 0 {name=l1 lab=VDD}
C {devices/vdd.sym} 440 160 0 0 {name=l2 lab=VDD}
C {devices/gnd.sym} 510 310 0 0 {name=l3 lab=0}
C {devices/code_shown.sym} 195 40 0 0 {name=s1 only_toplevel=false value="""
.option savecurrent
.control
set units = d
save all

dc VDD 0 1 0.005
plot VDD/i(Vmeas)

.endc
"""}
