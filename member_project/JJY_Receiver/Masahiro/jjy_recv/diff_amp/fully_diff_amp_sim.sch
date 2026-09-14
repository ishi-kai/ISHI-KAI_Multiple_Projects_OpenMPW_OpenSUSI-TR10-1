v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 150 310 150 330 {lab=vb}
N 330 380 360 380 {lab=vinn}
N 330 420 360 420 {lab=vinp}
N 520 420 560 420 {lab=von}
N 520 380 560 380 {lab=vop}
N 550 420 550 430 {lab=von}
N 550 370 550 380 {lab=vop}
N 320 150 320 190 {lab=#net1}
N 320 170 370 170 {lab=#net1}
N 370 170 370 210 {lab=#net1}
N 370 210 370 220 {lab=#net1}
N 360 220 370 220 {lab=#net1}
N 320 250 320 270 {lab=0}
N 300 260 320 260 {lab=0}
N 300 220 300 260 {lab=0}
N 300 220 320 220 {lab=0}
N 370 220 430 220 {lab=#net1}
N 430 220 440 220 {lab=#net1}
N 440 220 440 340 {lab=#net1}
C {devices/code.sym} 45 80 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/vsource.sym} 60 360 0 0 {name=VDD value=5 savecurrent=false}
C {devices/vsource.sym} 50 600 0 0 {name=VINp value="DC 0 AC 1 sin(0 100u 40k 0 0 0)" savecurrent=false}
C {devices/gnd.sym} 50 630 0 0 {name=l3 lab=0}
C {devices/gnd.sym} 60 390 0 0 {name=l4 lab=0}
C {devices/vdd.sym} 60 330 0 0 {name=l5 lab=VDD}
C {devices/code_shown.sym} 605 90 0 0 {name=s1 only_toplevel=false value="""
.option savecurrent
.control
set units = d
save all

*op
*show m

*dc vinp 0 5 0.01
*plot v(vop) v(von)

ac dec 11 1 1G
plot db(v(von)-v(vop))
plot ph(v(von)-v(vop))
*plot db(v(vinp)-v(vinn))
*plot ph(v(vinp)-v(vinn))
*plot db(v(vinp))
*plot ph(v(vinp) - v(von))
*plot db(v(vinn))
*plot ph(v(vinn) - v(vop))
*plot vdb(vop)
*plot ph(vop)
*plot vdb(von)
*plot ph(von)

tran 0.1u 1m
plot v(vinp) v(vinn)
plot v(vop) v(von)
plot v(vinp)-v(vinn)
plot v(vop)-v(von)

.endc
"""}
C {devices/vsource.sym} 150 360 0 0 {name=V1 value=3.967 savecurrent=false}
C {devices/lab_pin.sym} 150 310 1 0 {name=p6 sig_type=std_logic lab=vb}
C {devices/gnd.sym} 150 390 0 0 {name=l10 lab=0}
C {devices/vsource.sym} 240 600 0 0 {name=VINn value="DC 0 sin(0 100u 40k 0 0 180)" savecurrent=false}
C {devices/gnd.sym} 240 630 0 0 {name=l12 lab=0}
C {devices/lab_pin.sym} 50 510 1 0 {name=p9 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 240 510 1 0 {name=p10 sig_type=std_logic lab=vinn}
C {devices/capa-2.sym} 240 540 0 0 {name=C3
m=1
value=10n
footprint=1206
device=polarized_capacitor}
C {devices/capa-2.sym} 50 540 0 0 {name=C4
m=1
value=10n
footprint=1206
device=polarized_capacitor}
C {devices/lab_pin.sym} 330 420 2 1 {name=p1 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 330 380 2 1 {name=p2 sig_type=std_logic lab=vinn}
C {devices/lab_pin.sym} 560 380 0 1 {name=p3 sig_type=std_logic lab=vop}
C {devices/lab_pin.sym} 560 420 0 1 {name=p4 sig_type=std_logic lab=von}
C {devices/vdd.sym} 410 340 0 0 {name=l2 lab=VDD}
C {devices/lab_pin.sym} 470 340 1 0 {name=p5 sig_type=std_logic lab=vb}
C {devices/capa.sym} 550 340 2 0 {name=C1
m=1
value=100f
footprint=1206
device="ceramic capacitor"}
C {devices/capa.sym} 550 460 0 0 {name=C2
m=1
value=100f
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 550 490 0 0 {name=l6 lab=0}
C {devices/gnd.sym} 550 310 2 0 {name=l7 lab=0}
C {devices/gnd.sym} 440 460 0 0 {name=l1 lab=0}
C {devices/isource.sym} 320 120 0 0 {name=I1 value=40u}
C {devices/vdd.sym} 320 90 0 0 {name=l8 lab=VDD}
C {TR-1umLIB/MN.sym} 360 220 0 1 {name=XM1
model=NMOS
w=10u
l=2u
m=2
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {devices/gnd.sym} 320 270 0 0 {name=l9 lab=0}
C {fully_diff_amp.sym} 440 400 0 0 {name=x1}
