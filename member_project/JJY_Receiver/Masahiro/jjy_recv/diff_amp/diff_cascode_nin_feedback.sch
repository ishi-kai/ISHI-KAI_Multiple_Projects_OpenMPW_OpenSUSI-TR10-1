v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 680 660 760 660 {lab=#net1}
N 640 690 640 720 {lab=0}
N 800 690 800 720 {lab=0}
N 580 660 640 660 {lab=0}
N 580 660 580 720 {lab=0}
N 580 720 640 720 {lab=0}
N 800 660 850 660 {lab=0}
N 850 660 850 720 {lab=0}
N 800 720 850 720 {lab=0}
N 880 420 1020 420 {lab=vop}
N 1020 420 1060 420 {lab=vop}
N 200 420 200 440 {lab=vbl}
N 150 710 150 720 {lab=#net2}
N 270 710 270 720 {lab=#net3}
N 720 500 880 500 {lab=0}
N 800 500 800 520 {lab=0}
N 720 530 720 590 {lab=#net4}
N 720 590 880 590 {lab=#net4}
N 880 530 880 590 {lab=#net4}
N 800 590 800 630 {lab=#net4}
N 660 500 680 500 {lab=vinp}
N 920 500 940 500 {lab=vinn}
N 760 240 840 240 {lab=#net5}
N 650 240 720 240 {lab=VDD}
N 880 240 950 240 {lab=VDD}
N 640 720 800 720 {lab=0}
N 720 170 720 210 {lab=VDD}
N 720 170 880 170 {lab=VDD}
N 880 170 880 210 {lab=VDD}
N 640 630 710 630 {lab=#net1}
N 710 630 710 660 {lab=#net1}
N 800 210 800 230 {lab=#net5}
N 800 230 800 240 {lab=#net5}
N 760 330 840 330 {lab=von}
N 650 330 720 330 {lab=VDD}
N 880 330 950 330 {lab=VDD}
N 880 360 880 470 {lab=vop}
N 720 270 720 300 {lab=#net5}
N 880 270 880 300 {lab=#net6}
N 800 300 800 330 {lab=von}
N 670 480 670 500 {lab=vinp}
N 930 480 930 500 {lab=vinn}
N 290 420 290 440 {lab=vcb}
N 550 420 720 420 {lab=von}
N 720 360 720 470 {lab=von}
N 780 240 780 280 {lab=#net5}
N 720 280 780 280 {lab=#net5}
N 780 330 780 380 {lab=von}
N 720 380 780 380 {lab=von}
C {devices/code.sym} 95 140 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/vdd.sym} 800 170 0 0 {name=l2 lab=VDD}
C {devices/vsource.sym} 110 470 0 0 {name=VDD value=5 savecurrent=false}
C {devices/vsource.sym} 150 750 0 0 {name=VINp value="DC 2.5 AC 1" savecurrent=false}
C {devices/gnd.sym} 150 780 0 0 {name=l3 lab=0}
C {devices/gnd.sym} 110 500 0 0 {name=l4 lab=0}
C {devices/vdd.sym} 110 440 0 0 {name=l5 lab=VDD}
C {devices/isource.sym} 640 600 0 0 {name=I0 value=40u}
C {devices/code_shown.sym} 285 150 0 0 {name=s1 only_toplevel=false value="""
.option savecurrent
.control
set units = d
op
show m
dc vinp 0 5 0.01
plot v(vinp) v(vinn)
plot v(vop) v(von)
plot v(vop)-v(von)
ac dec 11 1 1G
plot vdb(vop)
.endc
"""}
C {devices/capa.sym} 570 450 0 0 {name=C1
m=1
value=500f
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 730 720 0 0 {name=l7 lab=0}
C {devices/vsource.sym} 200 470 0 0 {name=V1 value=3.96131 savecurrent=false}
C {MP.sym} 840 240 0 0 {name=M1 model=PMOS w=45u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 760 240 0 1 {name=M2 model=PMOS w=45u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 760 660 0 0 {name=M3 model=NMOS w=20u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 680 660 0 1 {name=M4 model=NMOS w=20u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/capa.sym} 1020 450 0 0 {name=C2
m=1
value=500f
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 1020 480 0 0 {name=l1 lab=0}
C {devices/gnd.sym} 570 480 0 0 {name=l8 lab=0}
C {devices/lab_pin.sym} 1060 420 0 1 {name=p3 sig_type=std_logic lab=vop}
C {devices/lab_pin.sym} 550 420 0 0 {name=p4 sig_type=std_logic lab=von}
C {devices/lab_pin.sym} 800 200 0 0 {name=p5 sig_type=std_logic lab=vbl}
C {devices/lab_pin.sym} 200 420 1 0 {name=p6 sig_type=std_logic lab=vbl}
C {devices/vdd.sym} 650 240 0 0 {name=l9 lab=VDD}
C {devices/gnd.sym} 200 500 0 0 {name=l10 lab=0}
C {devices/vsource.sym} 270 750 0 0 {name=VINn value=2.5 savecurrent=false}
C {devices/gnd.sym} 270 780 0 0 {name=l12 lab=0}
C {devices/lab_pin.sym} 150 650 1 0 {name=p9 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 270 650 1 0 {name=p10 sig_type=std_logic lab=vinn}
C {devices/lab_pin.sym} 660 500 2 1 {name=p11 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 940 500 2 0 {name=p12 sig_type=std_logic lab=vinn}
C {MN.sym} 680 500 0 0 {name=M7 model=NMOS w=20u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 920 500 0 1 {name=M8 model=NMOS w=20u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/gnd.sym} 800 520 0 0 {name=l11 lab=0}
C {devices/vdd.sym} 950 240 0 0 {name=l13 lab=VDD}
C {devices/vdd.sym} 640 570 0 0 {name=l14 lab=VDD}
C {MP.sym} 840 330 0 0 {name=M5 model=PMOS w=45u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 760 330 0 1 {name=M6 model=PMOS w=45u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/vdd.sym} 650 330 0 0 {name=l6 lab=VDD}
C {devices/vdd.sym} 950 330 0 0 {name=l15 lab=VDD}
C {devices/vsource.sym} 290 470 0 0 {name=V2 value=2.538 savecurrent=false}
C {devices/gnd.sym} 290 500 0 0 {name=l16 lab=0}
C {devices/res.sym} 670 450 0 0 {name=R1
value=5meg
footprint=1206
device=resistor
m=1}
C {devices/res.sym} 930 450 0 0 {name=R2
value=5meg
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} 270 680 0 0 {name=C3
m=1
value=10n
footprint=1206
device="ceramic capacitor"}
C {devices/capa.sym} 150 680 0 0 {name=C4
m=1
value=10n
footprint=1206
device="ceramic capacitor"}
C {devices/lab_pin.sym} 290 420 1 0 {name=p1 sig_type=std_logic lab=vcb
}
C {devices/lab_pin.sym} 810 300 1 0 {name=p2 sig_type=std_logic lab=vcb
}
