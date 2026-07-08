v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 120 260 120 280 {lab=vb}
N 740 350 770 350 {lab=vinn}
N 740 390 770 390 {lab=vinp}
N 930 390 970 390 {lab=von}
N 930 350 970 350 {lab=vop}
N 960 390 960 400 {lab=von}
N 960 340 960 350 {lab=vop}
N 850 190 850 310 {lab=#net1}
N 830 70 830 90 {lab=VDD}
N 780 150 800 150 {lab=VDD}
N 800 80 800 150 {lab=VDD}
N 800 80 830 80 {lab=VDD}
N 830 150 830 170 {lab=#net1}
N 780 170 830 170 {lab=#net1}
N 830 170 850 170 {lab=#net1}
N 850 170 850 190 {lab=#net1}
N 780 210 790 210 {lab=0}
N 790 210 790 220 {lab=0}
C {devices/code.sym} 15 30 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/vsource.sym} 30 310 0 0 {name=VDD value=5 savecurrent=false}
C {devices/vsource.sym} 20 550 0 0 {name=VINp value="DC 0 AC 1 sin(0 100u 40k 0 0 0)" savecurrent=false}
C {devices/gnd.sym} 20 580 0 0 {name=l3 lab=0}
C {devices/gnd.sym} 30 340 0 0 {name=l4 lab=0}
C {devices/vdd.sym} 30 280 0 0 {name=l5 lab=VDD}
C {devices/code_shown.sym} 305 30 0 0 {name=s1 only_toplevel=false value="""
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
C {devices/vsource.sym} 120 310 0 0 {name=V1 value=3.967 savecurrent=false}
C {devices/lab_pin.sym} 120 260 1 0 {name=p6 sig_type=std_logic lab=vb}
C {devices/gnd.sym} 120 340 0 0 {name=l10 lab=0}
C {devices/vsource.sym} 210 550 0 0 {name=VINn value="DC 0 sin(0 100u 40k 0 0 180)" savecurrent=false}
C {devices/gnd.sym} 210 580 0 0 {name=l12 lab=0}
C {devices/lab_pin.sym} 20 460 1 0 {name=p9 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 210 460 1 0 {name=p10 sig_type=std_logic lab=vinn}
C {devices/capa-2.sym} 210 490 0 0 {name=C3
m=1
value=10n
footprint=1206
device=polarized_capacitor}
C {devices/capa-2.sym} 20 490 0 0 {name=C4
m=1
value=10n
footprint=1206
device=polarized_capacitor}
C {devices/lab_pin.sym} 740 390 2 1 {name=p1 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 740 350 2 1 {name=p2 sig_type=std_logic lab=vinn}
C {devices/lab_pin.sym} 970 350 0 1 {name=p3 sig_type=std_logic lab=vop}
C {devices/lab_pin.sym} 970 390 0 1 {name=p4 sig_type=std_logic lab=von}
C {devices/vdd.sym} 820 310 0 0 {name=l2 lab=VDD}
C {devices/capa.sym} 960 310 2 0 {name=C1
m=1
value=100f
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 960 280 2 0 {name=l7 lab=0}
C {devices/gnd.sym} 850 430 0 0 {name=l1 lab=0}
C {devices/isource.sym} 830 120 0 0 {name=I1 value=40u}
C {devices/vdd.sym} 830 70 0 0 {name=l8 lab=VDD}
C {fully_diff_amp.sym} 850 370 0 0 {name=x1}
C {devices/lab_pin.sym} 880 310 1 0 {name=p5 sig_type=std_logic lab=vb}
C {devices/capa.sym} 960 430 0 0 {name=C2
m=1
value=100f
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 960 460 0 0 {name=l6 lab=0}
C {/home/ishi-kai/ISHI-KAI_Multiple_Projects_OpenMPW_OpenSUSI-TR10-1/member_project/JJY_Receiver/Masahiro/jjy_recv/bias_for_mix_amp/bias40u.sym} 680 180 0 0 {name=x2}
C {devices/gnd.sym} 790 220 0 0 {name=l9 lab=0}
