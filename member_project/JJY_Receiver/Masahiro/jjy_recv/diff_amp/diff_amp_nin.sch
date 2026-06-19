v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 660 440 710 440 {lab=#net1}
N 590 470 590 500 {lab=0}
N 750 470 750 500 {lab=0}
N 530 440 590 440 {lab=0}
N 530 440 530 500 {lab=0}
N 530 500 590 500 {lab=0}
N 750 440 800 440 {lab=0}
N 800 440 800 500 {lab=0}
N 750 500 800 500 {lab=0}
N 830 200 1010 200 {lab=vop}
N 500 200 670 200 {lab=von}
N 150 270 150 290 {lab=vb}
N 50 520 50 530 {lab=#net2}
N 170 520 170 530 {lab=#net3}
N 750 280 830 280 {lab=0}
N 750 280 750 300 {lab=0}
N 670 310 670 370 {lab=#net4}
N 750 370 830 370 {lab=#net4}
N 830 310 830 370 {lab=#net4}
N 750 370 750 410 {lab=#net4}
N 620 280 630 280 {lab=vinp}
N 880 280 890 280 {lab=vinn}
N 750 140 790 140 {lab=vb}
N 670 200 670 250 {lab=von}
N 830 200 830 250 {lab=vop}
N 600 140 670 140 {lab=VDD}
N 830 140 900 140 {lab=VDD}
N 590 500 750 500 {lab=0}
N 670 70 670 110 {lab=VDD}
N 670 70 830 70 {lab=VDD}
N 830 70 830 110 {lab=VDD}
N 590 410 660 410 {lab=#net1}
N 660 410 660 440 {lab=#net1}
N 750 110 750 140 {lab=vb}
N 620 260 620 280 {lab=vinp}
N 880 260 880 280 {lab=vinn}
N 830 170 830 200 {lab=vop}
N 670 170 670 200 {lab=von}
N 670 280 750 280 {lab=0}
N 670 370 750 370 {lab=#net4}
N 630 440 660 440 {lab=#net1}
N 710 140 750 140 {lab=vb}
N 610 280 620 280 {lab=vinp}
N 870 280 880 280 {lab=vinn}
C {devices/code.sym} 45 40 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/vdd.sym} 750 70 0 0 {name=l2 lab=VDD}
C {devices/vsource.sym} 60 320 0 0 {name=VDD value=5 savecurrent=false}
C {devices/vsource.sym} 50 560 0 0 {name=VINp value="DC 2.5 AC 1" savecurrent=false}
C {devices/gnd.sym} 50 590 0 0 {name=l3 lab=0}
C {devices/gnd.sym} 60 350 0 0 {name=l4 lab=0}
C {devices/vdd.sym} 60 290 0 0 {name=l5 lab=VDD}
C {devices/isource.sym} 590 380 0 0 {name=I0 value=40u}
C {devices/code_shown.sym} 235 40 0 0 {name=s1 only_toplevel=false value="""
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
C {devices/capa.sym} 520 230 0 0 {name=C1
m=1
value=1p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 680 500 0 0 {name=l7 lab=0}
C {devices/vsource.sym} 150 320 0 0 {name=V1 value=3.967 savecurrent=false}
C {MP.sym} 790 140 0 0 {name=M1 model=PMOS w=45u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 710 140 0 1 {name=M2 model=PMOS w=45u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 710 440 0 0 {name=M3 model=NMOS w=20u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 630 440 0 1 {name=M4 model=NMOS w=20u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/capa.sym} 970 230 0 0 {name=C2
m=1
value=1p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 970 260 0 0 {name=l1 lab=0}
C {devices/gnd.sym} 520 260 0 0 {name=l8 lab=0}
C {devices/lab_pin.sym} 1010 200 0 1 {name=p3 sig_type=std_logic lab=vop}
C {devices/lab_pin.sym} 500 200 0 0 {name=p4 sig_type=std_logic lab=von}
C {devices/lab_pin.sym} 750 110 0 0 {name=p5 sig_type=std_logic lab=vb}
C {devices/lab_pin.sym} 150 270 1 0 {name=p6 sig_type=std_logic lab=vb}
C {devices/vdd.sym} 600 140 0 0 {name=l9 lab=VDD}
C {devices/gnd.sym} 150 350 0 0 {name=l10 lab=0}
C {devices/vsource.sym} 170 560 0 0 {name=VINn value=2.5 savecurrent=false}
C {devices/gnd.sym} 170 590 0 0 {name=l12 lab=0}
C {devices/lab_pin.sym} 50 460 1 0 {name=p9 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 170 460 1 0 {name=p10 sig_type=std_logic lab=vinn}
C {devices/lab_pin.sym} 610 280 2 1 {name=p11 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 890 280 2 0 {name=p12 sig_type=std_logic lab=vinn}
C {MN.sym} 630 280 0 0 {name=M7 model=NMOS w=20u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 870 280 0 1 {name=M8 model=NMOS w=20u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/gnd.sym} 750 300 0 0 {name=l11 lab=0}
C {devices/vdd.sym} 900 140 0 0 {name=l13 lab=VDD}
C {devices/vdd.sym} 590 350 0 0 {name=l14 lab=VDD}
C {devices/capa.sym} 50 490 0 0 {name=C3
m=1
value=100n
footprint=1206
device="ceramic capacitor"}
C {devices/capa.sym} 170 490 0 0 {name=C4
m=1
value=100n
footprint=1206
device="ceramic capacitor"}
C {devices/res.sym} 880 230 0 0 {name=R1
value=10meg
footprint=1206
device=resistor
m=1}
C {devices/res.sym} 620 230 0 0 {name=R2
value=10meg
footprint=1206
device=resistor
m=1}
