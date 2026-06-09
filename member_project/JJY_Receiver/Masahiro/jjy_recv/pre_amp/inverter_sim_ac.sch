v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 340 380 340 400 {lab=0}
N 340 230 340 320 {lab=in}
N 730 380 730 400 {lab=0}
N 730 70 730 320 {lab=#net1}
N 730 10 730 70 {lab=#net1}
N 340 230 370 230 {lab=in}
N 430 230 460 230 {lab=#net2}
N 520 280 520 300 {lab=0}
N 450 230 450 380 {lab=#net2}
N 450 380 490 380 {lab=#net2}
N 620 230 660 230 {lab=out}
N 640 230 640 380 {lab=out}
N 550 380 640 380 {lab=out}
N 520 150 520 180 {lab=#net3}
N 520 10 520 90 {lab=#net1}
N 520 10 730 10 {lab=#net1}
N 450 490 490 490 {lab=#net2}
N 450 380 450 490 {lab=#net2}
N 550 490 640 490 {lab=out}
N 640 380 640 490 {lab=out}
N 520 510 520 530 {lab=0}
C {devices/code.sym} 10 250 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/vsource.sym} 340 350 0 0 {name=vgs value="DC 2.5 AC 1" savecurrent=false}
C {devices/vsource.sym} 730 350 0 0 {name=V2 value=5 savecurrent=false}
C {devices/gnd.sym} 340 400 0 0 {name=l1 lab=0}
C {devices/gnd.sym} 730 400 0 0 {name=l2 lab=0}
C {devices/lab_pin.sym} 660 230 0 1 {name=p1 sig_type=std_logic lab=out
}
C {devices/lab_pin.sym} 340 230 0 0 {name=p2 sig_type=std_logic lab=in}
C {devices/code_shown.sym} 20 -80 0 0 {name=spice only_toplevel=false value="""
.option savecurrent
.control
save all
set units = d

ac dec 11 10 100Meg
plot vdb(out)
plot vp(out)
meas ac f_0db when vdb(out)=0
meas ac ph_at_f_0db find vp(out) at=f_0db

.endc
"""}
C {devices/ammeter.sym} 520 120 0 0 {name=vd savecurrent=true spice_ignore=0}
C {devices/res.sym} 520 380 1 0 {name=R2
value=1Meg
footprint=1206
device=resistor
m=1}
C {devices/res.sym} 400 230 1 0 {name=R1
value=10k
footprint=1206
device=resistor
m=1}
C {inverter.sym} 520 230 0 0 {name=x1}
C {devices/gnd.sym} 520 300 0 0 {name=l3 lab=0}
C {CSIO.sym} 490 490 3 0 {name=C1
model=F_CSIO
c=0.653p
x=33u
y=33u
m=1
spiceprefix=X}
C {devices/gnd.sym} 520 530 0 0 {name=l4 lab=0}
