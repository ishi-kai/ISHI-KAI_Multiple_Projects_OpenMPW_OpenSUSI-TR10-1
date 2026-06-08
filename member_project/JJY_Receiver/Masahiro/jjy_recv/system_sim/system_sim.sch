v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 70 60 100 60 {lab=0}
N 120 30 120 60 {lab=0}
N 120 30 130 30 {lab=0}
N 100 60 120 60 {lab=0}
N 170 70 170 80 {lab=0}
N 170 40 170 70 {lab=0}
N 170 60 260 60 {lab=0}
N 170 -40 170 -20 {lab=st1}
N 170 -40 260 -40 {lab=st1}
N 260 -40 260 -20 {lab=st1}
N 260 30 260 40 {lab=0}
N 260 -20 260 -10 {lab=st1}
N 300 40 300 60 {lab=0}
N 260 60 300 60 {lab=0}
N 260 40 260 60 {lab=0}
N 120 60 170 60 {lab=0}
N 300 -40 320 -40 {lab=st2}
N 300 -40 300 -20 {lab=st2}
N 380 -40 380 -20 {lab=st2}
N 320 -40 380 -40 {lab=st2}
N 300 60 380 60 {lab=0}
N 20 50 20 60 {lab=0}
N 20 60 70 60 {lab=0}
N 70 60 70 80 {lab=0}
N 20 -10 130 -10 {lab=in}
N 380 -20 380 -10 {lab=st2}
N 380 60 430 60 {lab=0}
N 430 30 430 60 {lab=0}
N 430 60 510 60 {lab=0}
N 440 -10 510 -10 {lab=mix}
N 570 -10 590 -10 {lab=filt}
N 590 -10 590 -0 {lab=filt}
N 510 60 590 60 {lab=0}
N 900 -10 900 0 {lab=out}
N 900 -10 960 -10 {lab=out}
N 590 -10 610 -10 {lab=filt}
N 610 -10 660 -10 {lab=filt}
N 590 60 840 60 {lab=0}
N 700 40 700 60 {lab=0}
N 660 30 660 60 {lab=0}
N 700 -40 700 -20 {lab=#net1}
N 700 -40 760 -40 {lab=#net1}
N 760 -40 760 -10 {lab=#net1}
N 760 -10 790 -10 {lab=#net1}
N 840 60 900 60 {lab=0}
N 850 -10 900 -10 {lab=out}
N 410 30 410 100 {lab=lo}
N 370 160 410 160 {lab=0}
N 370 60 370 160 {lab=0}
C {devices/vcvs.sym} 170 10 0 0 {name=E1 value=33
}
C {devices/gnd.sym} 170 80 0 0 {name=l1 lab=0}
C {devices/vsource.sym} 20 20 0 0 {name=vin value="DC 0 AC 1 sin(0 50u 40k)" savecurrent=false}
C {devices/gnd.sym} 70 80 0 0 {name=l2 lab=0}
C {devices/lab_pin.sym} 260 -20 0 0 {name=p1 sig_type=std_logic lab=st1}
C {devices/code_shown.sym} 0 -260 0 0 {name=spice only_toplevel=false value="""
.option savecurrent
.control
op
tran 0.01u 2m
plot v(in)
plot v(st2)
plot v(lo)
plot v(filt)
plot v(out)
.endc
"""}
C {devices/vcvs.sym} 300 10 0 0 {name=E2 value=33}
C {devices/lab_pin.sym} 380 -30 0 0 {name=p2 sig_type=std_logic lab=st2}
C {devices/switch_ngspice.sym} 410 -10 3 0 {name=S1 model=SW1
device_model=".MODEL SW1 SW 
+ VT=2.5 VH=0.01
+ RON=0.01 ROFF=10G "}
C {devices/vsource.sym} 410 130 0 0 {name=V1 value="sin(2.5 2.5 38k)" savecurrent=false}
C {devices/res.sym} 540 -10 1 0 {name=R1
value=1.6k
footprint=1206
device=resistor
m=1}
C {devices/lab_pin.sym} 500 -10 0 0 {name=p3 sig_type=std_logic lab=mix}
C {devices/capa.sym} 590 30 0 0 {name=C1
m=1
value=10n
footprint=1206
device="ceramic capacitor"}
C {devices/lab_pin.sym} 960 -10 0 0 {name=p4 sig_type=std_logic lab=out}
C {devices/res.sym} 900 30 0 0 {name=R2
value=8
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} 820 -10 3 0 {name=C2
m=1
value=10u
footprint=1206
device="ceramic capacitor"}
C {devices/vcvs.sym} 700 10 0 0 {name=E3 value=15}
C {devices/lab_pin.sym} 640 -10 0 0 {name=p5 sig_type=std_logic lab=filt}
C {devices/lab_pin.sym} 410 80 0 0 {name=p6 sig_type=std_logic lab=lo}
C {devices/lab_pin.sym} 90 -10 0 0 {name=p7 sig_type=std_logic lab=in}
