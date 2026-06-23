v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 150 310 150 330 {lab=vb}
N 50 560 50 570 {lab=#net1}
N 240 560 240 570 {lab=#net2}
N 50 490 50 500 {lab=vinp}
N 240 490 240 500 {lab=vinn}
N 620 330 650 330 {lab=vinn}
N 620 370 650 370 {lab=vinp}
N 810 370 850 370 {lab=von}
N 810 330 850 330 {lab=vop}
N 730 260 730 290 {lab=#net3}
N 840 370 840 380 {lab=von}
N 840 320 840 330 {lab=vop}
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
C {devices/code_shown.sym} 335 80 0 0 {name=s1 only_toplevel=false value="""
.option savecurrent
.control
set units = d
save all

op
show m

dc vinp 0 5 0.01
plot v(vop) v(von)

ac dec 11 1 1G
plot vdb(vop)

tran 0.1u 100u
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
C {devices/lab_pin.sym} 50 490 1 0 {name=p9 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 240 490 1 0 {name=p10 sig_type=std_logic lab=vinn}
C {devices/capa-2.sym} 240 530 0 0 {name=C3
m=1
value=100n
footprint=1206
device=polarized_capacitor}
C {devices/capa-2.sym} 50 530 0 0 {name=C4
m=1
value=100n
footprint=1206
device=polarized_capacitor}
C {devices/lab_pin.sym} 620 370 2 1 {name=p1 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 620 330 2 1 {name=p2 sig_type=std_logic lab=vinn}
C {devices/lab_pin.sym} 850 330 0 1 {name=p3 sig_type=std_logic lab=vop}
C {devices/lab_pin.sym} 850 370 0 1 {name=p4 sig_type=std_logic lab=von}
C {devices/vdd.sym} 700 290 0 0 {name=l2 lab=VDD}
C {devices/lab_pin.sym} 760 290 1 0 {name=p5 sig_type=std_logic lab=vb}
C {devices/isource.sym} 730 230 0 0 {name=I0 value=40u}
C {devices/vdd.sym} 730 200 0 0 {name=l14 lab=VDD}
C {devices/capa.sym} 840 290 2 0 {name=C1
m=1
value=100f
footprint=1206
device="ceramic capacitor"}
C {devices/capa.sym} 840 410 0 0 {name=C2
m=1
value=100f
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 840 440 0 0 {name=l6 lab=0}
C {devices/gnd.sym} 840 260 2 0 {name=l7 lab=0}
C {devices/gnd.sym} 730 410 0 0 {name=l1 lab=0}
C {/home/ishi-kai/ISHI-KAI_Multiple_Projects_OpenMPW_OpenSUSI-TR10-1/member_project/JJY_Receiver/Masahiro/jjy_recv/diff_amp/fully_diff_amp.sym} 730 350 0 0 {name=x1}
