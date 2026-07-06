v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 110 280 110 300 {lab=vb}
N 690 480 720 480 {lab=vinn}
N 690 520 720 520 {lab=vinp}
N 800 410 800 440 {lab=#net1}
N 910 520 910 530 {lab=von}
N 910 470 910 480 {lab=vop}
N 880 480 1050 480 {lab=vop}
N 880 520 1050 520 {lab=von}
N 1350 480 1370 480 {lab=ifn}
N 1350 520 1370 520 {lab=ifp}
N 20 470 20 480 {lab=lop}
N 210 470 210 480 {lab=lon}
N 1370 520 1370 530 {lab=ifp}
N 1370 520 1390 520 {lab=ifp}
N 1370 470 1370 480 {lab=ifn}
N 1370 480 1390 480 {lab=ifn}
N 770 290 800 290 {lab=#net1}
N 800 290 800 410 {lab=#net1}
N 800 170 800 190 {lab=VDD}
N 770 270 780 270 {lab=VDD}
N 780 180 780 270 {lab=VDD}
N 780 180 800 180 {lab=VDD}
N 800 250 800 290 {lab=#net1}
N 800 350 1150 350 {lab=#net1}
N 1150 350 1150 420 {lab=#net1}
C {devices/code.sym} -10 40 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/vsource.sym} 20 330 0 0 {name=VDD value=5 savecurrent=false}
C {devices/gnd.sym} 20 360 0 0 {name=l4 lab=0}
C {devices/vdd.sym} 20 300 0 0 {name=l5 lab=VDD}
C {devices/code_shown.sym} 295 20 0 0 {name=s1 only_toplevel=false value="""
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
C {devices/lab_pin.sym} 690 520 2 1 {name=p2 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 690 480 2 1 {name=p3 sig_type=std_logic lab=vinn}
C {devices/lab_pin.sym} 970 480 3 1 {name=p4 sig_type=std_logic lab=vop}
C {devices/lab_pin.sym} 970 520 1 1 {name=p5 sig_type=std_logic lab=von}
C {devices/vdd.sym} 770 440 0 0 {name=l2 lab=VDD}
C {devices/lab_pin.sym} 830 440 1 0 {name=p7 sig_type=std_logic lab=vb}
C {devices/isource.sym} 800 220 0 0 {name=I0 value=40u}
C {devices/vdd.sym} 800 170 0 0 {name=l14 lab=VDD}
C {devices/capa.sym} 910 440 2 0 {name=C1
m=1
value=100f
footprint=1206
device="ceramic capacitor"}
C {devices/capa.sym} 910 560 0 0 {name=C2
m=1
value=100f
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 910 590 0 0 {name=l6 lab=0}
C {devices/gnd.sym} 910 410 2 0 {name=l7 lab=0}
C {devices/gnd.sym} 800 560 0 0 {name=l8 lab=0}
C {fully_diff_amp.sym} 800 500 0 0 {name=x1}
C {/home/ishi-kai/ISHI-KAI_Multiple_Projects_OpenMPW_OpenSUSI-TR10-1/member_project/JJY_Receiver/Masahiro/jjy_recv/gilbert_cell/gilbert_cell.sym} 1200 500 0 0 {name=x2}
C {devices/gnd.sym} 1200 580 0 0 {name=l1 lab=0}
C {devices/vdd.sym} 1120 420 0 0 {name=l9 lab=VDD}
C {devices/lab_pin.sym} 1180 420 1 0 {name=p1 sig_type=std_logic lab=vb}
C {devices/lab_pin.sym} 1230 420 1 0 {name=p11 sig_type=std_logic lab=lop
}
C {devices/lab_pin.sym} 1270 420 1 0 {name=p12 sig_type=std_logic lab=lon
}
C {devices/lab_pin.sym} 1390 480 0 1 {name=p13 sig_type=std_logic lab=ifn}
C {devices/lab_pin.sym} 1390 520 0 1 {name=p14 sig_type=std_logic lab=ifp}
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
C {devices/capa.sym} 1370 560 0 0 {name=C3
m=1
value=100f
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 1370 590 0 0 {name=l3 lab=0}
C {devices/capa.sym} 1370 440 2 0 {name=C4
m=1
value=100f
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 1370 410 2 0 {name=l12 lab=0}
C {/home/ishi-kai/ISHI-KAI_Multiple_Projects_OpenMPW_OpenSUSI-TR10-1/member_project/JJY_Receiver/Masahiro/jjy_recv/bias_for_mix_amp/bias40u.sym} 670 300 0 0 {name=x3}
C {devices/gnd.sym} 770 330 0 0 {name=l11 lab=0}
