v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 710 570 790 570 {lab=vbl}
N 670 600 670 630 {lab=0}
N 670 630 830 630 {lab=0}
N 830 600 830 630 {lab=0}
N 670 300 670 390 {lab=von}
N 830 300 830 390 {lab=vop}
N 750 120 750 160 {lab=#net1}
N 750 210 830 210 {lab=#net1}
N 830 210 830 240 {lab=#net1}
N 670 210 670 240 {lab=#net1}
N 670 210 750 210 {lab=#net1}
N 610 570 670 570 {lab=0}
N 610 570 610 630 {lab=0}
N 610 630 670 630 {lab=0}
N 830 570 880 570 {lab=0}
N 880 570 880 630 {lab=0}
N 830 630 880 630 {lab=0}
N 750 630 750 660 {lab=0}
N 830 360 970 360 {lab=vop}
N 520 360 670 360 {lab=von}
N 970 360 1010 360 {lab=vop}
N 500 360 520 360 {lab=von}
N 540 40 540 60 {lab=VDD}
N 750 40 750 50 {lab=VDD}
N 750 50 750 60 {lab=VDD}
N 490 90 540 90 {lab=VDD}
N 490 40 490 90 {lab=VDD}
N 750 90 790 90 {lab=VDD}
N 790 40 790 90 {lab=VDD}
N 750 40 790 40 {lab=VDD}
N 540 120 540 160 {lab=#net2}
N 540 140 600 140 {lab=#net2}
N 600 90 600 140 {lab=#net2}
N 670 270 830 270 {lab=VDD}
N 750 160 750 210 {lab=#net1}
N 170 480 170 500 {lab=vbl}
N 50 630 50 640 {lab=vinp}
N 170 630 170 640 {lab=vinn}
N 610 270 630 270 {lab=vinp}
N 870 270 890 270 {lab=vinn}
N 580 90 710 90 {lab=#net2}
N 490 40 750 40 {lab=VDD}
N 750 570 750 600 {lab=vbl}
N 710 460 790 460 {lab=vbc}
N 750 460 750 490 {lab=vbc}
N 830 490 830 540 {lab=#net3}
N 670 490 670 540 {lab=#net4}
N 670 390 670 430 {lab=von}
N 830 390 830 430 {lab=vop}
N 250 480 250 500 {lab=vbc}
N 610 460 670 460 {lab=0}
N 610 460 610 570 {lab=0}
N 830 460 880 460 {lab=0}
N 880 460 880 570 {lab=0}
N 770 380 830 380 {lab=vop}
N 670 380 730 380 {lab=von}
C {devices/code.sym} -5 30 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/vdd.sym} 630 40 0 0 {name=l2 lab=VDD}
C {devices/vsource.sym} 50 530 0 0 {name=VDD value=5 savecurrent=false}
C {devices/vsource.sym} 50 670 0 0 {name=VINp value="DC 2.5 AC 1" savecurrent=false}
C {devices/gnd.sym} 50 700 0 0 {name=l3 lab=0}
C {devices/gnd.sym} 50 560 0 0 {name=l4 lab=0}
C {devices/vdd.sym} 50 500 0 0 {name=l5 lab=VDD}
C {devices/isource.sym} 540 190 0 0 {name=I0 value=40u}
C {devices/gnd.sym} 540 220 0 0 {name=l6 lab=0}
C {devices/code_shown.sym} 5 200 0 0 {name=s1 only_toplevel=false value="""
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
C {devices/capa.sym} 520 390 0 0 {name=C1
m=1
value=10p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 750 660 0 0 {name=l7 lab=0}
C {devices/vsource.sym} 170 530 0 0 {name=V1 value=1.02501 savecurrent=false}
C {MP.sym} 870 270 0 1 {name=M1 model=PMOS w=45u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 630 270 0 0 {name=M2 model=PMOS w=45u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 790 570 0 0 {name=M3 model=NMOS w=20u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 710 570 0 1 {name=M4 model=NMOS w=20u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 710 90 0 0 {name=M5 model=PMOS w=45u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 580 90 0 1 {name=M6 model=PMOS w=45u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/capa.sym} 970 390 0 0 {name=C2
m=1
value=10p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 970 420 0 0 {name=l1 lab=0}
C {devices/gnd.sym} 520 420 0 0 {name=l8 lab=0}
C {devices/lab_pin.sym} 1010 360 0 1 {name=p3 sig_type=std_logic lab=vop}
C {devices/lab_pin.sym} 500 360 0 0 {name=p4 sig_type=std_logic lab=von}
C {devices/lab_pin.sym} 750 600 0 0 {name=p5 sig_type=std_logic lab=vbl}
C {devices/lab_pin.sym} 170 480 1 0 {name=p6 sig_type=std_logic lab=vbl}
C {devices/vdd.sym} 750 270 0 0 {name=l9 lab=VDD}
C {devices/gnd.sym} 170 560 0 0 {name=l10 lab=0}
C {devices/vsource.sym} 170 670 0 0 {name=VINn value=2.5 savecurrent=false}
C {devices/gnd.sym} 170 700 0 0 {name=l12 lab=0}
C {devices/lab_pin.sym} 50 630 1 0 {name=p9 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 170 630 1 0 {name=p10 sig_type=std_logic lab=vinn}
C {devices/lab_pin.sym} 610 270 2 1 {name=p11 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 890 270 2 0 {name=p12 sig_type=std_logic lab=vinn}
C {MN.sym} 790 460 0 0 {name=M7 model=NMOS w=20u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 710 460 0 1 {name=M8 model=NMOS w=20u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/lab_pin.sym} 750 490 0 0 {name=p1 sig_type=std_logic lab=vbc}
C {devices/vsource.sym} 250 530 0 0 {name=V2 value=2.44 savecurrent=false}
C {devices/lab_pin.sym} 250 480 1 0 {name=p2 sig_type=std_logic lab=vbc}
C {devices/gnd.sym} 250 560 0 0 {name=l11 lab=0}
C {devices/spice_probe_vdiff.sym} 750 380 1 1 {name=vout}
