v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 110 270 110 290 {lab=vb}
N 20 430 20 440 {lab=rfp}
N 240 430 240 440 {lab=rfn}
N 690 130 690 170 {lab=#net1}
N 20 590 20 600 {lab=lop}
N 240 590 240 600 {lab=lon}
C {devices/code.sym} 5 40 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/vsource.sym} 20 320 0 0 {name=VDD value=5 savecurrent=false}
C {devices/vsource.sym} 20 470 0 0 {name=VINp value="DC 2.43 AC 1 sin(2.5 10m 40k 0 0 0)" savecurrent=false}
C {devices/gnd.sym} 20 500 0 0 {name=l3 lab=0}
C {devices/gnd.sym} 20 350 0 0 {name=l4 lab=0}
C {devices/vdd.sym} 20 290 0 0 {name=l5 lab=VDD}
C {devices/code_shown.sym} 295 40 0 0 {name=s1 only_toplevel=false value="""
.option savecurrent
.control
set units = d
save all

op
show m

tran 0.1u 100u
plot v(rfp) v(rfn)
plot v(lop) v(lon)
plot v(ifp) v(ifn)
plot v(ifp)-v(ifn)

.endc
"""}
C {devices/vsource.sym} 110 320 0 0 {name=V1 value=3.967 savecurrent=false}
C {devices/lab_pin.sym} 110 270 1 0 {name=p6 sig_type=std_logic lab=vb}
C {devices/gnd.sym} 110 350 0 0 {name=l10 lab=0}
C {devices/vsource.sym} 240 470 0 0 {name=VINn value="DC 2.43 sin(2.5 10m 40k 0 0 180)" savecurrent=false}
C {devices/gnd.sym} 240 500 0 0 {name=l12 lab=0}
C {devices/gnd.sym} 740 330 0 0 {name=l1 lab=0}
C {devices/lab_pin.sym} 720 170 1 0 {name=p1 sig_type=std_logic lab=vb}
C {devices/isource.sym} 690 100 0 0 {name=I0 value=40u}
C {devices/vdd.sym} 690 70 0 0 {name=l14 lab=VDD}
C {devices/vdd.sym} 660 170 0 0 {name=l2 lab=VDD}
C {devices/lab_pin.sym} 20 430 1 0 {name=p2 sig_type=std_logic lab=rfp}
C {devices/lab_pin.sym} 240 430 1 0 {name=p3 sig_type=std_logic lab=rfn}
C {devices/vsource.sym} 20 630 0 0 {name=VINp1 value="DC 2.5 AC 1 sin(2.5 100m 40k 0 0 90)" savecurrent=false}
C {devices/gnd.sym} 20 660 0 0 {name=l6 lab=0}
C {devices/vsource.sym} 240 630 0 0 {name=VINn1 value="DC 2.5 sin(2.5 100m 40k 0 0 270)" savecurrent=false}
C {devices/gnd.sym} 240 660 0 0 {name=l7 lab=0}
C {devices/lab_pin.sym} 20 590 1 0 {name=p4 sig_type=std_logic lab=lop}
C {devices/lab_pin.sym} 240 590 1 0 {name=p5 sig_type=std_logic lab=lon}
C {devices/lab_pin.sym} 590 270 2 1 {name=p7 sig_type=std_logic lab=rfp}
C {devices/lab_pin.sym} 590 230 2 1 {name=p8 sig_type=std_logic lab=rfn}
C {devices/lab_pin.sym} 770 170 1 0 {name=p9 sig_type=std_logic lab=lop}
C {devices/lab_pin.sym} 810 170 1 0 {name=p10 sig_type=std_logic lab=lon}
C {devices/lab_pin.sym} 890 270 2 0 {name=p11 sig_type=std_logic lab=ifp}
C {devices/lab_pin.sym} 890 230 2 0 {name=p12 sig_type=std_logic lab=ifn}
C {/home/ishi-kai/ISHI-KAI_Multiple_Projects_OpenMPW_OpenSUSI-TR10-1/member_project/JJY_Receiver/Masahiro/jjy_recv/gilbert_cell/gilbert_cell.sym} 740 250 0 0 {name=x1}
