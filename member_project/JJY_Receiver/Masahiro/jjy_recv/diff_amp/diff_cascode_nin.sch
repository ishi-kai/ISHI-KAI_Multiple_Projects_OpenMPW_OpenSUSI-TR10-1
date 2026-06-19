v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 620 560 700 560 {lab=#net1}
N 580 590 580 620 {lab=0}
N 740 590 740 620 {lab=0}
N 520 560 580 560 {lab=0}
N 520 560 520 620 {lab=0}
N 520 620 580 620 {lab=0}
N 740 560 790 560 {lab=0}
N 790 560 790 620 {lab=0}
N 740 620 790 620 {lab=0}
N 820 320 960 320 {lab=vop}
N 960 320 1000 320 {lab=vop}
N -330 1170 -310 1170 {lab=#net2}
N 140 320 140 340 {lab=vbl}
N 90 610 90 620 {lab=#net3}
N 210 610 210 620 {lab=#net4}
N 660 400 820 400 {lab=0}
N 740 400 740 420 {lab=0}
N 660 430 660 490 {lab=#net5}
N 660 490 820 490 {lab=#net5}
N 820 430 820 490 {lab=#net5}
N 740 490 740 530 {lab=#net5}
N 600 400 620 400 {lab=vinp}
N 860 400 880 400 {lab=vinn}
N 700 140 780 140 {lab=vbl}
N 590 140 660 140 {lab=VDD}
N 820 140 890 140 {lab=VDD}
N 580 620 740 620 {lab=0}
N 660 70 660 110 {lab=VDD}
N 660 70 820 70 {lab=VDD}
N 820 70 820 110 {lab=VDD}
N 580 530 650 530 {lab=#net1}
N 650 530 650 560 {lab=#net1}
N 740 110 740 130 {lab=vbl}
N 740 130 740 140 {lab=vbl}
N 700 230 780 230 {lab=vcb}
N 590 230 660 230 {lab=VDD}
N 820 230 890 230 {lab=VDD}
N 820 260 820 370 {lab=vop}
N 660 170 660 200 {lab=#net6}
N 820 170 820 200 {lab=#net7}
N 740 200 740 230 {lab=vcb}
N 610 380 610 400 {lab=vinp}
N 870 380 870 400 {lab=vinn}
N 230 320 230 340 {lab=vcb}
N 490 320 660 320 {lab=von}
N 660 260 660 370 {lab=von}
C {devices/code.sym} 35 40 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/vdd.sym} 740 70 0 0 {name=l2 lab=VDD}
C {devices/vsource.sym} 50 370 0 0 {name=VDD value=5 savecurrent=false}
C {devices/vsource.sym} 90 650 0 0 {name=VINp value="DC 2.5 AC 1" savecurrent=false}
C {devices/gnd.sym} 90 680 0 0 {name=l3 lab=0}
C {devices/gnd.sym} 50 400 0 0 {name=l4 lab=0}
C {devices/vdd.sym} 50 340 0 0 {name=l5 lab=VDD}
C {devices/isource.sym} 580 500 0 0 {name=I0 value=40u}
C {devices/code_shown.sym} 225 50 0 0 {name=s1 only_toplevel=false value="""
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
C {devices/capa.sym} 510 350 0 0 {name=C1
m=1
value=1p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 670 620 0 0 {name=l7 lab=0}
C {devices/vsource.sym} 140 370 0 0 {name=V1 value=3.96131 savecurrent=false}
C {MP.sym} 780 140 0 0 {name=M1 model=PMOS w=45u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 700 140 0 1 {name=M2 model=PMOS w=45u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 700 560 0 0 {name=M3 model=NMOS w=20u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 620 560 0 1 {name=M4 model=NMOS w=20u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/capa.sym} 960 350 0 0 {name=C2
m=1
value=1p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 960 380 0 0 {name=l1 lab=0}
C {devices/gnd.sym} 510 380 0 0 {name=l8 lab=0}
C {devices/lab_pin.sym} 1000 320 0 1 {name=p3 sig_type=std_logic lab=vop}
C {devices/lab_pin.sym} 490 320 0 0 {name=p4 sig_type=std_logic lab=von}
C {devices/lab_pin.sym} 740 110 0 0 {name=p5 sig_type=std_logic lab=vbl}
C {devices/lab_pin.sym} 140 320 1 0 {name=p6 sig_type=std_logic lab=vbl}
C {devices/vdd.sym} 590 140 0 0 {name=l9 lab=VDD}
C {devices/gnd.sym} 140 400 0 0 {name=l10 lab=0}
C {devices/vsource.sym} 210 650 0 0 {name=VINn value=2.5 savecurrent=false}
C {devices/gnd.sym} 210 680 0 0 {name=l12 lab=0}
C {devices/lab_pin.sym} 90 550 1 0 {name=p9 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 210 550 1 0 {name=p10 sig_type=std_logic lab=vinn}
C {devices/lab_pin.sym} 600 400 2 1 {name=p11 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 880 400 2 0 {name=p12 sig_type=std_logic lab=vinn}
C {MN.sym} 620 400 0 0 {name=M7 model=NMOS w=20u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 860 400 0 1 {name=M8 model=NMOS w=20u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/gnd.sym} 740 420 0 0 {name=l11 lab=0}
C {devices/vdd.sym} 890 140 0 0 {name=l13 lab=VDD}
C {devices/vdd.sym} 580 470 0 0 {name=l14 lab=VDD}
C {MP.sym} 780 230 0 0 {name=M5 model=PMOS w=45u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 700 230 0 1 {name=M6 model=PMOS w=45u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/vdd.sym} 590 230 0 0 {name=l6 lab=VDD}
C {devices/vdd.sym} 890 230 0 0 {name=l15 lab=VDD}
C {devices/vsource.sym} 230 370 0 0 {name=V2 value=2.538 savecurrent=false}
C {devices/gnd.sym} 230 400 0 0 {name=l16 lab=0}
C {devices/res.sym} 610 350 0 0 {name=R1
value=10k
footprint=1206
device=resistor
m=1}
C {devices/res.sym} 870 350 0 0 {name=R2
value=10k
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} 210 580 0 0 {name=C3
m=1
value=0.1u
footprint=1206
device="ceramic capacitor"}
C {devices/capa.sym} 90 580 0 0 {name=C4
m=1
value=0.1u
footprint=1206
device="ceramic capacitor"}
C {devices/lab_pin.sym} 230 320 1 0 {name=p1 sig_type=std_logic lab=vcb
}
C {devices/lab_pin.sym} 740 200 1 0 {name=p2 sig_type=std_logic lab=vcb
}
