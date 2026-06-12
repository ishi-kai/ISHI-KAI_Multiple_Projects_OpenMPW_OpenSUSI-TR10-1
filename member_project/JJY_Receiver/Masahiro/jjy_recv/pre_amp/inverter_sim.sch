v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 360 -50 360 20 {lab=out}
N 360 50 390 50 {lab=0}
N 390 50 390 120 {lab=0}
N 360 120 390 120 {lab=0}
N 360 -80 390 -80 {lab=#net1}
N 390 -140 390 -80 {lab=#net1}
N 360 -140 390 -140 {lab=#net1}
N 360 -170 360 -110 {lab=#net1}
N 250 -80 320 -80 {lab=in}
N 250 -80 250 50 {lab=in}
N 250 50 320 50 {lab=in}
N 130 140 130 160 {lab=0}
N 130 -10 130 80 {lab=in}
N 130 -10 250 -10 {lab=in}
N 520 140 520 160 {lab=0}
N 360 80 360 160 {lab=0}
N 520 -170 520 80 {lab=#net2}
N 360 0 450 0 {lab=out}
N 520 -230 520 -170 {lab=#net2}
N 360 -230 520 -230 {lab=#net2}
C {devices/code.sym} -200 10 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {MN.sym} 320 50 0 0 {name=M1 model=NMOS w=6.8u l=10u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 320 -80 0 0 {name=M2 model=PMOS w=20u l=10u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/vsource.sym} 130 110 0 0 {name=vgs value=0 savecurrent=false}
C {devices/vsource.sym} 520 110 0 0 {name=V2 value=5 savecurrent=false}
C {devices/gnd.sym} 130 160 0 0 {name=l1 lab=0}
C {devices/gnd.sym} 520 160 0 0 {name=l2 lab=0}
C {devices/gnd.sym} 360 160 0 0 {name=l3 lab=0}
C {devices/lab_pin.sym} 440 0 0 0 {name=p1 sig_type=std_logic lab=out
}
C {devices/lab_pin.sym} 130 -10 0 0 {name=p2 sig_type=std_logic lab=in}
C {devices/code_shown.sym} -190 -210 0 0 {name=spice1 only_toplevel=false value="""
.option savecurrent
.control
save all

dc vgs 0 5.0 0.01
plot v(in) v(out)
plot i(vd)
.endc
"""}
C {devices/ammeter.sym} 360 -200 0 0 {name=vd savecurrent=true spice_ignore=0}
