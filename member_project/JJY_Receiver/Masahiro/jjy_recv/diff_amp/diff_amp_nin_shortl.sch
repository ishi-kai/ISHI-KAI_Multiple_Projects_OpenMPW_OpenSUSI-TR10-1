v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 770 640 820 640 {lab=#net1}
N 700 670 700 700 {lab=0}
N 860 670 860 700 {lab=0}
N 640 640 700 640 {lab=0}
N 640 640 640 700 {lab=0}
N 640 700 700 700 {lab=0}
N 860 640 910 640 {lab=0}
N 910 640 910 700 {lab=0}
N 860 700 910 700 {lab=0}
N 940 250 1120 250 {lab=vop}
N 610 250 780 250 {lab=von}
N 260 360 260 380 {lab=vb}
N 160 610 160 620 {lab=#net2}
N 280 610 280 620 {lab=#net3}
N 860 480 940 480 {lab=0}
N 860 480 860 500 {lab=0}
N 780 510 780 570 {lab=#net4}
N 860 570 940 570 {lab=#net4}
N 940 510 940 570 {lab=#net4}
N 860 570 860 610 {lab=#net4}
N 860 190 900 190 {lab=vb}
N 710 190 780 190 {lab=VDD}
N 940 190 1010 190 {lab=VDD}
N 700 700 860 700 {lab=0}
N 780 120 780 160 {lab=VDD}
N 780 120 940 120 {lab=VDD}
N 940 120 940 160 {lab=VDD}
N 700 610 770 610 {lab=#net1}
N 770 610 770 640 {lab=#net1}
N 860 160 860 190 {lab=vb}
N 940 220 940 250 {lab=vop}
N 780 220 780 250 {lab=von}
N 780 480 860 480 {lab=0}
N 780 570 860 570 {lab=#net4}
N 740 640 770 640 {lab=#net1}
N 820 190 860 190 {lab=vb}
N 720 360 760 360 {lab=#net5}
N 700 300 720 300 {lab=VDD}
N 700 420 720 420 {lab=VDD}
N 660 360 700 360 {lab=VDD}
N 720 330 720 390 {lab=#net5}
N 700 300 700 420 {lab=VDD}
N 760 300 760 420 {lab=#net5}
N 720 450 720 480 {lab=vinp}
N 720 250 720 270 {lab=von}
N 960 360 1000 360 {lab=#net6}
N 1000 420 1020 420 {lab=VDD}
N 1020 360 1060 360 {lab=VDD}
N 1000 330 1000 390 {lab=#net6}
N 1020 300 1020 420 {lab=VDD}
N 960 300 960 420 {lab=#net6}
N 780 250 780 450 {lab=von}
N 940 250 940 450 {lab=vop}
N 1000 250 1000 270 {lab=vop}
N 980 480 1120 480 {lab=vinn}
N 1000 450 1000 480 {lab=vinn}
N 580 480 740 480 {lab=vinp}
N 1000 300 1020 300 {lab=VDD}
C {devices/code.sym} 155 130 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/vdd.sym} 860 120 0 0 {name=l2 lab=VDD}
C {devices/vsource.sym} 170 410 0 0 {name=VDD value=5 savecurrent=false}
C {devices/vsource.sym} 160 650 0 0 {name=VINp value="DC 2.5 AC 1" savecurrent=false}
C {devices/gnd.sym} 160 680 0 0 {name=l3 lab=0}
C {devices/gnd.sym} 170 440 0 0 {name=l4 lab=0}
C {devices/vdd.sym} 170 380 0 0 {name=l5 lab=VDD}
C {devices/isource.sym} 700 580 0 0 {name=I0 value=40u}
C {devices/code_shown.sym} 345 130 0 0 {name=s1 only_toplevel=false value="""
.option savecurrent
.control
set units = d
op
show m
dc vinp 0 5 0.01

plot v(vop) v(von)
plot v(vop)-v(von)
ac dec 11 1 1G
plot vdb(vop)
.endc
"""}
C {devices/capa.sym} 630 280 0 0 {name=C1
m=1
value=1p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 790 700 0 0 {name=l7 lab=0}
C {devices/vsource.sym} 260 410 0 0 {name=V1 value=3.90495 savecurrent=false}
C {MP.sym} 900 190 0 0 {name=M1 model=PMOS w=23u l=1u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 820 190 0 1 {name=M2 model=PMOS w=23u l=1u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 820 640 0 0 {name=M3 model=NMOS w=10u l=1u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 740 640 0 1 {name=M4 model=NMOS w=10u l=1u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/capa.sym} 1080 280 0 0 {name=C2
m=1
value=1p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 1080 310 0 0 {name=l1 lab=0}
C {devices/gnd.sym} 630 310 0 0 {name=l8 lab=0}
C {devices/lab_pin.sym} 1120 250 0 1 {name=p3 sig_type=std_logic lab=vop}
C {devices/lab_pin.sym} 610 250 0 0 {name=p4 sig_type=std_logic lab=von}
C {devices/lab_pin.sym} 860 160 0 0 {name=p5 sig_type=std_logic lab=vb}
C {devices/lab_pin.sym} 260 360 1 0 {name=p6 sig_type=std_logic lab=vb}
C {devices/vdd.sym} 710 190 0 0 {name=l9 lab=VDD}
C {devices/gnd.sym} 260 440 0 0 {name=l10 lab=0}
C {devices/vsource.sym} 280 650 0 0 {name=VINn value=2.5 savecurrent=false}
C {devices/gnd.sym} 280 680 0 0 {name=l12 lab=0}
C {devices/lab_pin.sym} 160 550 1 0 {name=p9 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 280 550 1 0 {name=p10 sig_type=std_logic lab=vinn}
C {devices/lab_pin.sym} 580 480 2 1 {name=p11 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 1120 480 2 0 {name=p12 sig_type=std_logic lab=vinn}
C {MN.sym} 740 480 0 0 {name=M7 model=NMOS w=10u l=1u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 980 480 0 1 {name=M8 model=NMOS w=10u l=1u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/gnd.sym} 860 500 0 0 {name=l11 lab=0}
C {devices/vdd.sym} 1010 190 0 0 {name=l13 lab=VDD}
C {devices/vdd.sym} 700 550 0 0 {name=l14 lab=VDD}
C {devices/capa.sym} 160 580 0 0 {name=C3
m=1
value=10n
footprint=1206
device="ceramic capacitor"}
C {devices/capa.sym} 280 580 0 0 {name=C4
m=1
value=10n
footprint=1206
device="ceramic capacitor"}
C {MP.sym} 760 300 0 1 {name=M5 model=PMOS w=3.4u l=10u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 760 420 2 0 {name=M10 model=PMOS w=3.4u l=10u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/vdd.sym} 660 360 3 0 {name=l20 lab=VDD}
C {MP.sym} 960 300 0 0 {name=M6 model=PMOS w=3.4u l=10u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 960 420 2 1 {name=M9 model=PMOS w=3.4u l=10u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/vdd.sym} 1060 360 1 1 {name=l6 lab=VDD}
C {devices/res.sym} 640 510 0 0 {name=R3
value=100k
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 640 540 0 0 {name=l15 lab=0}
C {devices/res.sym} 620 450 0 0 {name=R4
value=100k
footprint=1206
device=resistor
m=1}
C {devices/vdd.sym} 620 420 0 0 {name=l16 lab=VDD}
C {devices/res.sym} 1080 510 0 0 {name=R5
value=100k
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 1080 540 0 0 {name=l17 lab=0}
C {devices/res.sym} 1100 450 0 0 {name=R6
value=100k
footprint=1206
device=resistor
m=1}
C {devices/vdd.sym} 1100 420 0 0 {name=l18 lab=VDD}
