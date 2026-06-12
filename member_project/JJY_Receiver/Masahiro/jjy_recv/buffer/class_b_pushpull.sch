v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 450 210 450 280 {lab=out}
N 300 330 300 380 {lab=0}
N 450 340 450 380 {lab=0}
N 620 300 620 370 {lab=0}
N 620 70 620 240 {lab=#net1}
N 450 70 620 70 {lab=#net1}
N 450 70 450 150 {lab=#net1}
N 370 180 410 180 {lab=in}
N 370 180 370 300 {lab=in}
N 370 300 370 310 {lab=in}
N 370 310 410 310 {lab=in}
N 300 250 300 270 {lab=in}
N 300 250 370 250 {lab=in}
N 450 250 540 250 {lab=out}
N 450 180 500 180 {lab=0}
N 450 310 510 310 {lab=#net1}
N 590 210 620 210 {lab=#net1}
N 590 210 590 310 {lab=#net1}
N 510 310 590 310 {lab=#net1}
N 500 180 660 180 {lab=0}
N 660 180 660 330 {lab=0}
N 620 330 660 330 {lab=0}
C {devices/code.sym} -10 10 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {MN.sym} 410 180 0 0 {name=M1 model=NMOS w=8u l=20u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 410 310 0 0 {name=M2 model=PMOS w=3.4u l=20u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/vsource.sym} 620 270 0 0 {name=V1 value=5 savecurrent=false}
C {devices/vsource.sym} 300 300 0 0 {name=vin value=3 savecurrent=false}
C {devices/gnd.sym} 620 370 0 0 {name=l1 lab=0}
C {devices/gnd.sym} 450 380 0 0 {name=l2 lab=0}
C {devices/gnd.sym} 300 380 0 0 {name=l3 lab=0}
C {devices/lab_pin.sym} 530 250 0 1 {name=p1 sig_type=std_logic lab=out}
C {devices/lab_pin.sym} 300 250 0 0 {name=p2 sig_type=std_logic lab=in}
C {devices/code_shown.sym} 40 340 0 0 {name=spice only_toplevel=false value="""
.option savecurrent
.control
save all
dc vin 0 5 0.01
plot v(out)
.endc
"""}
