v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 620 240 650 240 {lab=VSPEAKER}
N 650 240 650 280 {lab=VSPEAKER}
N 520 240 560 240 {lab=VOUT}
N 290 280 380 280 {lab=#net1}
N 520 340 520 390 {lab=XTALN}
C {devices/code.sym} 380 -150 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/gnd.sym} 230 120 0 0 {name=l4 lab=0}
C {devices/code_shown.sym} -375 -185 0 0 {name=s1 only_toplevel=false value="""
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
#tran 1u 2
tran 1u 0.04
plot VOUT
plot VSPEAKER
plot i(VDD)
plot i(VDDBUF)
.endc
"""}
C {devices/gnd.sym} 470 120 0 0 {name=l10 lab=0}
C {devices/lab_pin.sym} 380 260 2 1 {name=p2 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 380 240 2 1 {name=p3 sig_type=std_logic lab=vinn}
C {devices/isource.sym} 290 250 0 0 {name=I0 value=40u}
C {devices/lab_pin.sym} 650 240 2 0 {name=p9 sig_type=std_logic lab=VSPEAKER}
C {devices/res.sym} 650 310 0 0 {name=R_SPEAKER
value=8
footprint=1206
device=resistor
m=1}
C {devices/lab_pin.sym} 560 240 1 0 {name=p10 sig_type=std_logic lab=VOUT}
C {devices/capa.sym} 590 240 1 0 {name=C_ACCUP
m=1
value=100u
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 650 340 0 0 {name=l23 lab=0}
C {devices/lab_pin.sym} 470 60 3 1 {name=p7 sig_type=std_logic lab=VB}
C {devices/vsource.sym} 470 90 0 0 {name=V2 value=3.967 savecurrent=false}
C {devices/vsource.sym} 590 -110 0 0 {name=VINp2 value="DC 0 AC 1 sin(0 10u 40k 0 0 0)" savecurrent=false}
C {devices/gnd.sym} 590 -80 0 0 {name=l13 lab=0}
C {devices/lab_pin.sym} 590 -140 1 0 {name=p8 sig_type=std_logic lab=vcar}
C {devices/vsource.sym} 820 -110 0 0 {name=V1 value="pulse(0 5 0 19.9m 0.1m 0 20m)" savecurrent=false}
C {devices/gnd.sym} 820 -80 0 0 {name=l17 lab=0}
C {devices/lab_pin.sym} 820 -140 1 0 {name=p17 sig_type=std_logic lab=vmod}
C {devices/gnd.sym} 590 120 0 0 {name=l18 lab=0}
C {devices/bsource.sym} 590 90 0 0 {name=B2 VAR=V FUNC="V(vmod) > 2.5? V(vcar):V(vcar)*0.1" m=1}
C {devices/gnd.sym} 820 120 0 0 {name=l19 lab=0}
C {devices/bsource.sym} 820 90 0 0 {name=B1 VAR=V FUNC="V(vmod) > 2.5? -1*V(vcar):-1*V(vcar)*0.1" m=1}
C {devices/lab_pin.sym} 590 0 1 0 {name=p18 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 820 0 1 0 {name=p19 sig_type=std_logic lab=vinn}
C {devices/capa-2.sym} 820 30 0 0 {name=C5
m=1
value=100n
footprint=1206
device=polarized_capacitor}
C {devices/capa-2.sym} 590 30 0 0 {name=C6
m=1
value=100n
footprint=1206
device=polarized_capacitor}
C {devices/vsource.sym} 350 90 0 0 {name=VDDBUF value="pwl(0 0 1u 5)" savecurrent=false}
C {devices/gnd.sym} 350 120 0 1 {name=l11 lab=0}
C {devices/vsource.sym} 230 90 0 0 {name=VDD value="pwl(0 0 1u 5)" savecurrent=false}
C {top/top.sym} 530 290 0 0 {name=x1}
C {devices/lab_pin.sym} 230 60 1 0 {name=p1 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 350 60 1 0 {name=p4 sig_type=std_logic lab=VDDBUF}
C {devices/lab_pin.sym} 290 220 1 0 {name=p5 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 380 300 2 1 {name=p6 sig_type=std_logic lab=VB}
C {devices/lab_pin.sym} 380 320 2 1 {name=p11 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 380 340 2 1 {name=p12 sig_type=std_logic lab=VDDBUF}
C {devices/gnd.sym} 380 360 1 1 {name=l1 lab=0}
C {devices/vsource.sym} 520 420 0 0 {name=VINn4 value="pulse(0 5 13.1579u 100n 100n 13.1479u 26.315u)" savecurrent=false}
C {devices/gnd.sym} 520 450 0 0 {name=l16 lab=0}
C {devices/lab_pin.sym} 520 320 2 0 {name=p13 sig_type=std_logic lab=XTALP}
C {devices/lab_pin.sym} 520 340 2 0 {name=p14 sig_type=std_logic lab=XTALN}
