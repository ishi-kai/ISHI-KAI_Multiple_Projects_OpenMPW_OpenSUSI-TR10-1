v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 570 190 570 260 {lab=out}
N 570 290 600 290 {lab=0}
N 600 290 600 360 {lab=0}
N 570 360 600 360 {lab=0}
N 570 160 600 160 {lab=#net1}
N 600 100 600 160 {lab=#net1}
N 570 100 600 100 {lab=#net1}
N 570 70 570 130 {lab=#net1}
N 460 160 530 160 {lab=#net2}
N 460 160 460 290 {lab=#net2}
N 460 290 530 290 {lab=#net2}
N 340 380 340 400 {lab=0}
N 340 230 340 320 {lab=in}
N 730 380 730 400 {lab=0}
N 570 320 570 400 {lab=0}
N 730 70 730 320 {lab=#net3}
N 570 240 660 240 {lab=out}
N 730 10 730 70 {lab=#net3}
N 570 10 730 10 {lab=#net3}
N 340 230 370 230 {lab=in}
N 430 230 460 230 {lab=#net2}
N 480 230 490 230 {lab=#net2}
N 480 230 480 240 {lab=#net2}
N 460 240 480 240 {lab=#net2}
N 550 230 570 230 {lab=out}
C {devices/code.sym} 10 250 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {MN.sym} 530 290 0 0 {name=M1 model=NMOS w=6.8u l=10u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 530 160 0 0 {name=M2 model=PMOS w=20u l=10u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/vsource.sym} 340 350 0 0 {name=vgs value="DC 2.5 AC 1" savecurrent=false}
C {devices/vsource.sym} 730 350 0 0 {name=V2 value=5 savecurrent=false}
C {devices/gnd.sym} 340 400 0 0 {name=l1 lab=0}
C {devices/gnd.sym} 730 400 0 0 {name=l2 lab=0}
C {devices/gnd.sym} 570 400 0 0 {name=l3 lab=0}
C {devices/lab_pin.sym} 650 240 0 0 {name=p1 sig_type=std_logic lab=out
}
C {devices/lab_pin.sym} 340 230 0 0 {name=p2 sig_type=std_logic lab=in}
C {devices/code_shown.sym} 20 30 0 0 {name=spice1 only_toplevel=false value="""
.option savecurrent
.control
save all

ac dec 11 10 100Meg
plot vdb(out)
plot vp(out)
.endc
"""}
C {devices/ammeter.sym} 570 40 0 0 {name=vd savecurrent=true spice_ignore=0}
C {devices/res.sym} 520 230 1 0 {name=R2
value=1Meg
footprint=1206
device=resistor
m=1}
C {devices/res.sym} 400 230 1 0 {name=R1
value=10k
footprint=1206
device=resistor
m=1}
