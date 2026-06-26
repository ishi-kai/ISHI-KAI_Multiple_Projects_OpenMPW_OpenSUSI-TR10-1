v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 110 280 110 300 {lab=vb}
N 650 320 680 320 {lab=vinn}
N 650 360 680 360 {lab=vinp}
N 760 250 760 280 {lab=#net1}
N 870 360 870 370 {lab=von}
N 870 310 870 320 {lab=vop}
N 840 320 1010 320 {lab=vop}
N 840 360 1010 360 {lab=von}
N 1110 230 1110 260 {lab=#net2}
N 1310 320 1330 320 {lab=ifn}
N 1310 360 1330 360 {lab=ifp}
N 20 470 20 480 {lab=lop}
N 210 470 210 480 {lab=lon}
N 1330 360 1330 370 {lab=ifp}
N 1330 360 1350 360 {lab=ifp}
N 1330 310 1330 320 {lab=ifn}
N 1330 320 1350 320 {lab=ifn}
C {devices/code.sym} -10 40 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/vsource.sym} 20 330 0 0 {name=VDD value=5 savecurrent=false}
C {devices/gnd.sym} 20 360 0 0 {name=l4 lab=0}
C {devices/vdd.sym} 20 300 0 0 {name=l5 lab=VDD}
C {devices/code_shown.sym} 295 50 0 0 {name=s1 only_toplevel=false value="""
.option savecurrent
.control
set units = d
save all

op
show m

*dc vinp 0 5 0.01
*plot v(vop) v(von)

*ac dec 11 1 1G
*plot vdb(vop)

tran 0.1u 40m
plot v(vcar)
plot v(vmod)
plot v(vinp) v(vinn)
plot v(vinp)-v(vinn)
plot v(vop) v(von)
plot v(vop)-v(von)
plot v(ifp) v(ifn)
plot v(ifp)-v(ifn)

.endc
"""}
C {devices/vsource.sym} 110 330 0 0 {name=V2 value=3.967 savecurrent=false}
C {devices/lab_pin.sym} 110 280 1 0 {name=p6 sig_type=std_logic lab=vb}
C {devices/gnd.sym} 110 360 0 0 {name=l10 lab=0}
C {devices/lab_pin.sym} 650 360 2 1 {name=p2 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 650 320 2 1 {name=p3 sig_type=std_logic lab=vinn}
C {devices/lab_pin.sym} 930 320 3 1 {name=p4 sig_type=std_logic lab=vop}
C {devices/lab_pin.sym} 930 360 1 1 {name=p5 sig_type=std_logic lab=von}
C {devices/vdd.sym} 730 280 0 0 {name=l2 lab=VDD}
C {devices/lab_pin.sym} 790 280 1 0 {name=p7 sig_type=std_logic lab=vb}
C {devices/isource.sym} 760 220 0 0 {name=I0 value=40u}
C {devices/vdd.sym} 760 190 0 0 {name=l14 lab=VDD}
C {devices/capa.sym} 870 280 2 0 {name=C1
m=1
value=100f
footprint=1206
device="ceramic capacitor"}
C {devices/capa.sym} 870 400 0 0 {name=C2
m=1
value=100f
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 870 430 0 0 {name=l6 lab=0}
C {devices/gnd.sym} 870 250 2 0 {name=l7 lab=0}
C {devices/gnd.sym} 760 400 0 0 {name=l8 lab=0}
C {/home/ishi-kai/ISHI-KAI_Multiple_Projects_OpenMPW_OpenSUSI-TR10-1/member_project/JJY_Receiver/Masahiro/jjy_recv/diff_amp/fully_diff_amp.sym} 760 340 0 0 {name=x1}
C {/home/ishi-kai/ISHI-KAI_Multiple_Projects_OpenMPW_OpenSUSI-TR10-1/member_project/JJY_Receiver/Masahiro/jjy_recv/gilbert_cell/gilbert_cell.sym} 1160 340 0 0 {name=x2}
C {devices/gnd.sym} 1160 420 0 0 {name=l1 lab=0}
C {devices/vdd.sym} 1080 260 0 0 {name=l9 lab=VDD}
C {devices/isource.sym} 1110 200 0 0 {name=I1 value=40u}
C {devices/vdd.sym} 1110 170 0 0 {name=l11 lab=VDD}
C {devices/lab_pin.sym} 1140 260 1 0 {name=p1 sig_type=std_logic lab=vb}
C {devices/lab_pin.sym} 1190 260 1 0 {name=p11 sig_type=std_logic lab=lop
}
C {devices/lab_pin.sym} 1230 260 1 0 {name=p12 sig_type=std_logic lab=lon
}
C {devices/lab_pin.sym} 1350 320 0 1 {name=p13 sig_type=std_logic lab=ifn}
C {devices/lab_pin.sym} 1350 360 0 1 {name=p14 sig_type=std_logic lab=ifp}
C {devices/vsource.sym} 20 510 0 0 {name=VINp1 value="sin(2.5 100m 38k 0 0 180)" savecurrent=false}
C {devices/gnd.sym} 20 540 0 0 {name=l15 lab=0}
C {devices/vsource.sym} 210 510 0 0 {name=VINn1 value="sin(2.5 100m 38k 0 0 0)" savecurrent=false}
C {devices/gnd.sym} 210 540 0 0 {name=l16 lab=0}
C {devices/lab_pin.sym} 20 470 1 0 {name=p15 sig_type=std_logic lab=lop}
C {devices/lab_pin.sym} 210 470 1 0 {name=p16 sig_type=std_logic lab=lon}
C {devices/vsource.sym} 20 660 0 0 {name=VINp2 value="DC 0 AC 1 sin(0 10u 40k 0 0 0)" savecurrent=false}
C {devices/gnd.sym} 20 690 0 0 {name=l13 lab=0}
C {devices/lab_pin.sym} 20 630 1 0 {name=p8 sig_type=std_logic lab=vcar}
C {devices/vsource.sym} 260 660 0 0 {name=V1 value="pulse(0 5 0 19.9m 0.1m 0 20m)" savecurrent=false}
C {devices/gnd.sym} 260 690 0 0 {name=l17 lab=0}
C {devices/lab_pin.sym} 260 630 1 0 {name=p17 sig_type=std_logic lab=vmod}
C {devices/gnd.sym} 20 890 0 0 {name=l18 lab=0}
C {devices/bsource.sym} 20 860 0 0 {name=B2 VAR=V FUNC="V(vmod) > 2.5? V(vcar):V(vcar)*0.1" m=1}
C {devices/gnd.sym} 260 890 0 0 {name=l19 lab=0}
C {devices/bsource.sym} 260 860 0 0 {name=B1 VAR=V FUNC="V(vmod) > 2.5? -1*V(vcar):-1*V(vcar)*0.1" m=1}
C {devices/lab_pin.sym} 20 770 1 0 {name=p18 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 260 770 1 0 {name=p19 sig_type=std_logic lab=vinn}
C {devices/capa-2.sym} 260 800 0 0 {name=C5
m=1
value=100n
footprint=1206
device=polarized_capacitor}
C {devices/capa-2.sym} 20 800 0 0 {name=C6
m=1
value=100n
footprint=1206
device=polarized_capacitor}
C {devices/capa.sym} 1330 400 0 0 {name=C3
m=1
value=100f
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 1330 430 0 0 {name=l3 lab=0}
C {devices/capa.sym} 1330 280 2 0 {name=C4
m=1
value=100f
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 1330 250 2 0 {name=l12 lab=0}
