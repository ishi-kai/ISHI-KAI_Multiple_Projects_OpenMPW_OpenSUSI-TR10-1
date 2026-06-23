v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 560 330 560 350 {lab=vo}
N 500 300 520 300 {lab=vo}
N 500 300 500 380 {lab=vo}
N 500 380 520 380 {lab=vo}
N 500 340 560 340 {lab=vo}
N 560 340 650 340 {lab=vo}
N 430 260 430 310 {lab=#net1}
N 560 260 560 270 {lab=#net2}
N 430 200 560 200 {lab=#net1}
N 430 370 430 450 {lab=0}
N 430 410 560 410 {lab=0}
N 560 300 600 300 {lab=#net2}
N 600 260 600 300 {lab=#net2}
N 560 260 600 260 {lab=#net2}
N 560 380 600 380 {lab=0}
N 600 380 600 410 {lab=0}
N 560 410 600 410 {lab=0}
N 430 200 430 260 {lab=#net1}
C {devices/code.sym} -5 30 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/code_shown.sym} 185 30 0 0 {name=s1 only_toplevel=false value="""
.option savecurrent
.control
set units = d
save all

op
show m

dc v1 0 5 0.01
plot v(vo)
plot i(vin)

.endc
"""}
C {MN.sym} 520 380 0 0 {name=M1 model=NMOS w=3.4u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 520 300 0 0 {name=M2 model=PMOS w=8.6u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/lab_pin.sym} 650 340 0 1 {name=p1 sig_type=std_logic lab=vo}
C {devices/gnd.sym} 430 450 0 0 {name=l1 lab=0}
C {devices/vsource.sym} 430 340 0 0 {name=V1 value=5 savecurrent=false}
C {devices/ammeter.sym} 560 230 0 0 {name=Vin savecurrent=true spice_ignore=0}
