v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 820 590 870 590 {lab=#net1}
N 750 620 750 650 {lab=0}
N 910 620 910 650 {lab=0}
N 690 590 750 590 {lab=0}
N 690 590 690 650 {lab=0}
N 690 650 750 650 {lab=0}
N 910 590 960 590 {lab=0}
N 960 590 960 650 {lab=0}
N 910 650 960 650 {lab=0}
N 150 270 150 290 {lab=vb}
N 50 520 50 530 {lab=#net2}
N 160 520 160 530 {lab=#net3}
N 910 370 990 370 {lab=0}
N 910 370 910 390 {lab=0}
N 830 400 830 460 {lab=#net4}
N 910 460 990 460 {lab=#net4}
N 990 400 990 460 {lab=#net4}
N 910 120 950 120 {lab=vb}
N 760 120 830 120 {lab=VDD}
N 990 120 1060 120 {lab=VDD}
N 750 650 910 650 {lab=0}
N 830 50 830 90 {lab=VDD}
N 830 50 990 50 {lab=VDD}
N 990 50 990 90 {lab=VDD}
N 750 560 820 560 {lab=#net1}
N 820 560 820 590 {lab=#net1}
N 910 90 910 120 {lab=vb}
N 990 150 990 180 {lab=vop}
N 830 150 830 180 {lab=von}
N 830 370 910 370 {lab=0}
N 830 460 910 460 {lab=#net4}
N 790 590 820 590 {lab=#net1}
N 870 120 910 120 {lab=vb}
N 990 180 990 340 {lab=vop}
N 830 180 830 340 {lab=von}
N 1050 270 1090 270 {lab=#net5}
N 1090 180 1090 190 {lab=vop}
N 740 270 780 270 {lab=#net6}
N 740 180 740 190 {lab=von}
N 740 340 740 370 {lab=vinp}
N 1090 220 1110 220 {lab=VDD}
N 720 220 740 220 {lab=VDD}
N 910 460 910 560 {lab=#net4}
N 740 180 740 190 {lab=von}
N 990 180 1280 180 {lab=vop}
N 580 180 830 180 {lab=von}
N 1030 370 1310 370 {lab=vinn}
N 530 370 790 370 {lab=vinp}
N 1210 490 1210 510 {lab=vinn}
N 1250 460 1270 460 {lab=vinn}
N 1270 460 1270 540 {lab=vinn}
N 1250 540 1270 540 {lab=vinn}
N 1210 500 1270 500 {lab=vinn}
N 1210 420 1210 430 {lab=VDD}
N 1170 460 1210 460 {lab=VDD}
N 1170 540 1210 540 {lab=0}
N 1170 540 1170 570 {lab=0}
N 1170 570 1210 570 {lab=0}
N 1170 430 1210 430 {lab=VDD}
N 1170 430 1170 460 {lab=VDD}
N 1210 570 1210 580 {lab=0}
N 590 490 590 510 {lab=vinp}
N 530 460 550 460 {lab=vinp}
N 530 460 530 540 {lab=vinp}
N 530 540 550 540 {lab=vinp}
N 530 500 590 500 {lab=vinp}
N 590 420 590 430 {lab=VDD}
N 590 460 630 460 {lab=VDD}
N 590 540 630 540 {lab=0}
N 630 540 630 570 {lab=0}
N 590 570 630 570 {lab=0}
N 590 430 630 430 {lab=VDD}
N 630 430 630 460 {lab=VDD}
N 590 570 590 580 {lab=0}
N 590 500 680 500 {lab=vinp}
N 1130 500 1210 500 {lab=vinn}
N 1130 370 1130 500 {lab=vinn}
N 680 370 680 500 {lab=vinp}
N 1090 250 1090 290 {lab=#net5}
N 1050 220 1050 320 {lab=#net5}
N 1090 350 1090 370 {lab=vinn}
N 720 220 720 320 {lab=VDD}
N 720 320 750 320 {lab=VDD}
N 780 220 780 320 {lab=#net6}
N 740 250 740 290 {lab=#net6}
N 160 450 160 460 {lab=vinn}
N 50 450 50 460 {lab=vinp}
N 1090 320 1110 320 {lab=VDD}
N 1110 220 1110 320 {lab=VDD}
C {devices/code.sym} 45 40 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/vdd.sym} 910 50 0 0 {name=l2 lab=VDD}
C {devices/vsource.sym} 60 320 0 0 {name=VDD value=5 savecurrent=false}
C {devices/vsource.sym} 50 560 0 0 {name=VINp value="DC 0 AC 1 sin(0 100u 40k 0 0 0)" savecurrent=false}
C {devices/gnd.sym} 50 590 0 0 {name=l3 lab=0}
C {devices/gnd.sym} 60 350 0 0 {name=l4 lab=0}
C {devices/vdd.sym} 60 290 0 0 {name=l5 lab=VDD}
C {devices/isource.sym} 750 530 0 0 {name=I0 value=40u}
C {devices/code_shown.sym} 235 40 0 0 {name=s1 only_toplevel=false value="""
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
C {devices/capa.sym} 620 210 0 0 {name=C1
m=1
value=100f
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 840 650 0 0 {name=l7 lab=0}
C {devices/vsource.sym} 150 320 0 0 {name=V1 value=3.967 savecurrent=false}
C {MP.sym} 950 120 0 0 {name=M1 model=PMOS w=45u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 870 120 0 1 {name=M2 model=PMOS w=45u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 870 590 0 0 {name=M3 model=NMOS w=20u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 790 590 0 1 {name=M4 model=NMOS w=20u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/capa.sym} 1220 210 0 0 {name=C2
m=1
value=100f
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 1220 240 0 0 {name=l1 lab=0}
C {devices/gnd.sym} 620 240 0 0 {name=l8 lab=0}
C {devices/lab_pin.sym} 1280 180 0 1 {name=p3 sig_type=std_logic lab=vop}
C {devices/lab_pin.sym} 580 180 0 0 {name=p4 sig_type=std_logic lab=von}
C {devices/lab_pin.sym} 910 90 0 0 {name=p5 sig_type=std_logic lab=vb}
C {devices/lab_pin.sym} 150 270 1 0 {name=p6 sig_type=std_logic lab=vb}
C {devices/vdd.sym} 760 120 0 0 {name=l9 lab=VDD}
C {devices/gnd.sym} 150 350 0 0 {name=l10 lab=0}
C {devices/vsource.sym} 160 560 0 0 {name=VINn value="DC 0 sin(0 100u 40k 0 0 180)" savecurrent=false}
C {devices/gnd.sym} 160 590 0 0 {name=l12 lab=0}
C {devices/lab_pin.sym} 50 450 1 0 {name=p9 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 160 450 1 0 {name=p10 sig_type=std_logic lab=vinn}
C {devices/lab_pin.sym} 530 370 2 1 {name=p11 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 1310 370 2 0 {name=p12 sig_type=std_logic lab=vinn}
C {MN.sym} 790 370 0 0 {name=M7 model=NMOS w=20u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 1030 370 0 1 {name=M8 model=NMOS w=20u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/gnd.sym} 910 390 0 0 {name=l11 lab=0}
C {devices/vdd.sym} 1060 120 0 0 {name=l13 lab=VDD}
C {devices/vdd.sym} 750 500 0 0 {name=l14 lab=VDD}
C {MP.sym} 1050 220 0 0 {name=M6 model=PMOS w=3.4u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 1050 320 2 1 {name=M9 model=PMOS w=3.4u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 780 220 0 1 {name=M5 model=PMOS w=3.4u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 780 320 2 0 {name=M10 model=PMOS w=3.4u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/vdd.sym} 1110 220 1 0 {name=l19 lab=VDD}
C {devices/vdd.sym} 720 220 3 0 {name=l20 lab=VDD}
C {devices/capa-2.sym} 160 490 0 0 {name=C3
m=1
value=100n
footprint=1206
device=polarized_capacitor}
C {devices/capa-2.sym} 50 490 0 0 {name=C4
m=1
value=100n
footprint=1206
device=polarized_capacitor}
C {MN.sym} 1250 540 0 1 {name=M12 model=NMOS w=3.4u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 1250 460 0 1 {name=M13 model=PMOS w=8.6u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/vdd.sym} 1210 420 0 1 {name=l6 lab=VDD}
C {devices/gnd.sym} 1210 580 0 1 {name=l15 lab=0}
C {MN.sym} 550 540 0 0 {name=M11 model=NMOS w=3.4u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 550 460 0 0 {name=M14 model=PMOS w=8.6u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/vdd.sym} 590 420 0 0 {name=l16 lab=VDD}
C {devices/gnd.sym} 590 580 0 0 {name=l17 lab=0}
