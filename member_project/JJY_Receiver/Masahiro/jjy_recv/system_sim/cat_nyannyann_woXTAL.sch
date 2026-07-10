v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
L 4 670 40 670 60 {}
L 4 670 60 690 60 {}
L 4 690 40 690 60 {}
L 4 670 40 690 40 {}
L 4 820 40 820 60 {}
L 4 820 60 840 60 {}
L 4 840 40 840 60 {}
L 4 820 40 840 40 {}
L 4 310 50 1140 50 {}
L 4 530 40 530 60 {}
L 4 530 60 550 60 {}
L 4 550 40 550 60 {}
L 4 530 40 550 40 {}
L 4 300 320 300 340 {}
L 4 300 340 320 340 {}
L 4 320 320 320 340 {}
L 4 300 320 320 320 {}
L 4 300 360 300 380 {}
L 4 300 380 320 380 {}
L 4 320 360 320 380 {}
L 4 300 360 320 360 {}
L 4 300 210 300 230 {}
L 4 300 230 320 230 {}
L 4 320 210 320 230 {}
L 4 300 210 320 210 {}
L 4 1140 50 1140 480 {}
L 4 310 480 1140 480 {}
L 4 310 50 310 480 {}
L 4 1130 360 1130 380 {}
L 4 1130 380 1150 380 {}
L 4 1150 360 1150 380 {}
L 4 1130 360 1150 360 {}
L 4 960 470 960 490 {}
L 4 960 490 980 490 {}
L 4 980 470 980 490 {}
L 4 960 470 980 470 {}
P 4 2 730 -10 680 -10 {}
P 4 1 740 -10 {}
P 4 1 730 -10 {}
P 4 1 740 -0 {}
T {off-chip} 850 20 0 0 0.4 0.4 {}
N 550 370 550 380 {lab=von}
N 550 320 550 330 {lab=vop}
N 890 330 910 330 {lab=ifn}
N 890 370 910 370 {lab=ifp}
N 910 370 910 380 {lab=ifp}
N 910 320 910 330 {lab=ifn}
N 910 330 930 330 {lab=ifn}
N 540 10 540 50 {lab=VT}
N 1220 370 1250 370 {lab=VSPEAKER}
N 1250 370 1250 410 {lab=VSPEAKER}
N 830 -10 830 80 {lab=XTALP}
N 680 -10 680 80 {lab=XTALN}
N 770 80 770 100 {lab=XTALP}
N 840 150 840 190 {lab=VXON}
N 680 80 740 80 {lab=XTALN}
N 740 80 740 100 {lab=XTALN}
N 540 50 540 130 {lab=VT}
N 830 -50 830 -10 {lab=XTALP}
N 280 330 310 330 {lab=vinn}
N 280 370 310 370 {lab=vinp}
N 980 370 1010 370 {lab=ifp}
N 520 330 550 330 {lab=vop}
N 520 370 550 370 {lab=von}
N 550 370 590 370 {lab=von}
N 550 330 590 330 {lab=vop}
N 310 330 360 330 {lab=vinn}
N 310 370 360 370 {lab=vinp}
N 510 130 540 130 {lab=VT}
N 840 190 840 230 {lab=VXON}
N 770 230 770 270 {lab=VXON}
N 770 230 840 230 {lab=VXON}
N 840 130 860 130 {lab=VXOP}
N 810 250 860 250 {lab=VXOP}
N 860 130 860 250 {lab=VXOP}
N 810 250 810 270 {lab=VXOP}
N 910 370 980 370 {lab=ifp}
N 240 220 470 220 {lab=vb}
N 470 220 470 290 {lab=vb}
N 470 220 720 220 {lab=vb}
N 720 220 720 270 {lab=vb}
N 1120 370 1160 370 {lab=VOUT}
N 770 80 830 80 {lab=XTALP}
N 680 -10 730 -10 {lab=XTALN}
N 780 -10 830 -10 {lab=XTALP}
N 970 410 970 480 {lab=#net1}
N 970 480 970 550 {lab=#net1}
N 970 410 1010 410 {lab=#net1}
N 510 150 550 150 {lab=IBN40U}
N 840 -90 840 -70 {lab=XTALP}
N 830 -70 840 -70 {lab=XTALP}
N 830 -70 830 -50 {lab=XTALP}
N 680 -50 680 -10 {lab=XTALN}
N 680 -90 680 -50 {lab=XTALN}
N 680 -150 680 -90 {lab=XTALN}
N 680 -150 750 -150 {lab=XTALN}
C {devices/code.sym} 300 -110 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/gnd.sym} 120 120 0 0 {name=l4 lab=0}
C {devices/vdd.sym} 120 60 0 0 {name=l5 lab=VDD}
C {devices/code_shown.sym} -225 -415 0 0 {name=s1 only_toplevel=false value="""
.options savecurrent delmax=1u
#method=trap trtol=7 chgtol=1e-13 cshunt=1f
#.ic v(XTALN)=4 v(XTALP)=1
.control
set reltol=1e-4
set vntol=1e-6
set abstol=1e-12
set units = d
save all

#op
#show m

#tran 0.05u 0.04 uic
tran 1u 0.04
#plot v(vcar)
#plot v(vmod)
#plot v(vinp) v(vinn)
#plot v(vinp)-v(vinn)
#lot v(vop) v(von)
#plot v(vop)-v(von)
#plot v(ifp) v(ifn)
#plot v(ifp)-v(ifn)
plot VOUT
plot VSPEAKER
#plot @m.x1.xm6.m1[id]
plot i(VDD)
plot i(VDDBUF)
.endc
"""}
C {devices/gnd.sym} 240 280 0 0 {name=l10 lab=0}
C {devices/lab_pin.sym} 280 370 2 1 {name=p2 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 280 330 2 1 {name=p3 sig_type=std_logic lab=vinn}
C {devices/lab_pin.sym} 520 330 1 0 {name=p4 sig_type=std_logic lab=vop}
C {devices/lab_pin.sym} 520 370 1 1 {name=p5 sig_type=std_logic lab=von}
C {devices/vdd.sym} 410 290 0 0 {name=l2 lab=VDD}
C {devices/isource.sym} 540 -20 0 0 {name=I0 value=40u}
C {devices/vdd.sym} 540 -50 0 0 {name=l14 lab=VDD}
C {devices/capa.sym} 550 290 2 1 {name=C_para0
m=1
value=100f
footprint=1206
device="ceramic capacitor"}
C {devices/capa.sym} 550 410 0 0 {name=C_para1
m=1
value=100f
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 550 440 0 0 {name=l6 lab=0}
C {devices/gnd.sym} 550 260 2 0 {name=l7 lab=0}
C {devices/gnd.sym} 440 410 0 0 {name=l8 lab=0}
C {devices/gnd.sym} 740 430 0 0 {name=l1 lab=0}
C {devices/vdd.sym} 660 270 0 0 {name=l9 lab=VDD}
C {devices/lab_pin.sym} 890 330 1 0 {name=p13 sig_type=std_logic lab=ifn}
C {devices/lab_pin.sym} 890 370 1 1 {name=p14 sig_type=std_logic lab=ifp}
C {devices/capa.sym} 910 410 0 0 {name=C_para3
m=1
value=100f
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 910 440 0 0 {name=l3 lab=0}
C {devices/capa.sym} 910 290 2 1 {name=C_para2
m=1
value=100f
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 910 260 2 0 {name=l12 lab=0}
C {devices/gnd.sym} 1010 430 1 0 {name=l21 lab=0}
C {devices/lab_pin.sym} 1250 370 2 0 {name=p9 sig_type=std_logic lab=VSPEAKER}
C {devices/res.sym} 1250 440 0 0 {name=R_SPEAKER
value=8
footprint=1206
device=resistor
m=1}
C {devices/lab_pin.sym} 1160 370 1 0 {name=p10 sig_type=std_logic lab=VOUT}
C {devices/capa.sym} 1190 370 1 0 {name=C_ACCUP
m=1
value=100u
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 1250 470 0 0 {name=l23 lab=0}
C {devices/lab_pin.sym} 690 270 1 0 {name=p20 sig_type=std_logic lab=VT}
C {devices/capa.sym} 860 -50 3 1 {name=CL_offchip0
m=1
value=12.5p
footprint=1206
device="ceramic capacitor"}
C {devices/capa.sym} 650 -50 1 0 {name=CL_offchip1
m=1
value=12.5p
footprint=1206
device="ceramic capacitor"}
C {devices/lab_pin.sym} 680 80 0 0 {name=p29 sig_type=std_logic lab=XTALN}
C {devices/lab_pin.sym} 830 80 0 1 {name=p30 sig_type=std_logic lab=XTALP}
C {devices/lab_pin.sym} 860 190 0 1 {name=p11 sig_type=std_logic lab=VXOP}
C {devices/lab_pin.sym} 840 190 0 0 {name=p12 sig_type=std_logic lab=VXON}
C {devices/gnd.sym} 620 -50 1 0 {name=l25 lab=0}
C {devices/gnd.sym} 890 -50 3 1 {name=l26 lab=0}
C {devices/gnd.sym} 670 150 1 0 {name=l27 lab=0}
C {devices/lab_pin.sym} 340 220 3 1 {name=p7 sig_type=std_logic lab=vb}
C {devices/vsource.sym} 240 250 0 0 {name=V2 value=3.967 savecurrent=false}
C {devices/vsource.sym} -190 240 0 0 {name=VINp2 value="DC 0 AC 1 sin(0 10u 40k 0 0 0)" savecurrent=false}
C {devices/gnd.sym} -190 270 0 0 {name=l13 lab=0}
C {devices/lab_pin.sym} -190 210 1 0 {name=p8 sig_type=std_logic lab=vcar}
C {devices/vsource.sym} 40 240 0 0 {name=V1 value="pulse(0 5 0 19.9m 0.1m 0 20m)" savecurrent=false}
C {devices/gnd.sym} 40 270 0 0 {name=l17 lab=0}
C {devices/lab_pin.sym} 40 210 1 0 {name=p17 sig_type=std_logic lab=vmod}
C {devices/gnd.sym} -190 470 0 0 {name=l18 lab=0}
C {devices/bsource.sym} -190 440 0 0 {name=B2 VAR=V FUNC="V(vmod) > 2.5? V(vcar):V(vcar)*0.1" m=1}
C {devices/gnd.sym} 40 470 0 0 {name=l19 lab=0}
C {devices/bsource.sym} 40 440 0 0 {name=B1 VAR=V FUNC="V(vmod) > 2.5? -1*V(vcar):-1*V(vcar)*0.1" m=1}
C {devices/lab_pin.sym} -190 350 1 0 {name=p18 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 40 350 1 0 {name=p19 sig_type=std_logic lab=vinn}
C {devices/capa-2.sym} 40 380 0 0 {name=C5
m=1
value=100n
footprint=1206
device=polarized_capacitor}
C {devices/capa-2.sym} -190 380 0 0 {name=C6
m=1
value=100n
footprint=1206
device=polarized_capacitor}
C {devices/vdd.sym} 510 110 0 0 {name=l15 lab=VDD}
C {devices/lab_pin.sym} 550 150 2 0 {name=p22 sig_type=std_logic lab=IBN40U}
C {devices/gnd.sym} 510 170 3 0 {name=l20 lab=0}
C {devices/lab_pin.sym} 540 120 0 1 {name=p23 sig_type=std_logic lab=VT}
C {devices/vdd.sym} 670 130 3 0 {name=l22 lab=VDD}
C {devices/vsource.sym} 1000 550 3 0 {name=VDDBUF value="pwl(0 0 1u 5)" savecurrent=false}
C {devices/gnd.sym} 1030 550 3 1 {name=l11 lab=0}
C {devices/lab_pin.sym} 440 290 1 0 {name=p1 sig_type=std_logic lab=VT}
C {devices/lab_pin.sym} 1010 390 2 1 {name=p6 sig_type=std_logic lab=IBN40U}
C {devices/vsource.sym} 120 90 0 0 {name=VDD value="pwl(0 0 1u 5)" savecurrent=false}
C {devices/vsource.sym} 750 -120 0 0 {name=VINn4 value="pulse(0 5 13.1579u 100n 100n 13.1479u 26.315u)" savecurrent=false}
C {devices/gnd.sym} 750 -90 0 0 {name=l16 lab=0}
C {OBUF_SSF/OBUF_SSF.sym} 1160 390 0 0 {name=x1}
C {gilbert_cell/gilbert_cell.sym} 740 350 0 0 {name=x2}
C {diff_amp/fully_diff_amp.sym} 440 350 0 0 {name=x3}
C {XTALOSC/XTALOSC.sym} 690 160 0 0 {name=x4}
