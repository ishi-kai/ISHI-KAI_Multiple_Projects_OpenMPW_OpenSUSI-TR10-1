v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 510 640 590 640 {lab=vb}
N 470 670 470 700 {lab=0}
N 470 700 630 700 {lab=0}
N 630 670 630 700 {lab=0}
N 470 520 470 610 {lab=von}
N 630 520 630 610 {lab=vop}
N 550 340 550 380 {lab=#net1}
N 550 430 630 430 {lab=#net1}
N 630 430 630 460 {lab=#net1}
N 470 430 470 460 {lab=#net1}
N 470 430 550 430 {lab=#net1}
N 410 640 470 640 {lab=0}
N 410 640 410 700 {lab=0}
N 410 700 470 700 {lab=0}
N 630 640 680 640 {lab=0}
N 680 640 680 700 {lab=0}
N 630 700 680 700 {lab=0}
N 550 700 550 730 {lab=0}
N 630 580 770 580 {lab=vop}
N 320 580 470 580 {lab=von}
N 770 580 810 580 {lab=vop}
N 300 580 320 580 {lab=von}
N 340 260 340 280 {lab=VDD}
N 550 260 550 270 {lab=VDD}
N 550 270 550 280 {lab=VDD}
N 290 310 340 310 {lab=VDD}
N 290 260 290 310 {lab=VDD}
N 550 310 590 310 {lab=VDD}
N 590 260 590 310 {lab=VDD}
N 550 260 590 260 {lab=VDD}
N 340 340 340 380 {lab=#net2}
N 340 360 400 360 {lab=#net2}
N 400 310 400 360 {lab=#net2}
N 470 490 630 490 {lab=VDD}
N 550 380 550 430 {lab=#net1}
N 130 320 130 340 {lab=vb}
N 30 470 30 480 {lab=vinp}
N 150 470 150 480 {lab=vinn}
N 410 490 430 490 {lab=vinp}
N 670 490 690 490 {lab=vinn}
N 380 310 510 310 {lab=#net2}
N 290 260 550 260 {lab=VDD}
N 550 640 550 670 {lab=vb}
C {devices/code.sym} 25 40 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/vdd.sym} 430 260 0 0 {name=l2 lab=VDD}
C {devices/vsource.sym} 40 370 0 0 {name=VDD value=5 savecurrent=false}
C {devices/vsource.sym} 30 510 0 0 {name=VINp value="DC 2.5 AC 1" savecurrent=false}
C {devices/gnd.sym} 30 540 0 0 {name=l3 lab=0}
C {devices/gnd.sym} 40 400 0 0 {name=l4 lab=0}
C {devices/vdd.sym} 40 340 0 0 {name=l5 lab=VDD}
C {devices/isource.sym} 340 410 0 0 {name=I0 value=40u}
C {devices/gnd.sym} 340 440 0 0 {name=l6 lab=0}
C {devices/code_shown.sym} 215 40 0 0 {name=s1 only_toplevel=false value="""
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
C {devices/capa.sym} 320 610 0 0 {name=C1
m=1
value=1p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 550 730 0 0 {name=l7 lab=0}
C {devices/vsource.sym} 130 370 0 0 {name=V1 value=1.02501 savecurrent=false}
C {MP.sym} 670 490 0 1 {name=M1 model=PMOS w=45u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 430 490 0 0 {name=M2 model=PMOS w=45u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 590 640 0 0 {name=M3 model=NMOS w=20u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 510 640 0 1 {name=M4 model=NMOS w=20u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 510 310 0 0 {name=M5 model=PMOS w=45u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 380 310 0 1 {name=M6 model=PMOS w=45u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/capa.sym} 770 610 0 0 {name=C2
m=1
value=1p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 770 640 0 0 {name=l1 lab=0}
C {devices/gnd.sym} 320 640 0 0 {name=l8 lab=0}
C {devices/lab_pin.sym} 810 580 0 1 {name=p3 sig_type=std_logic lab=vop}
C {devices/lab_pin.sym} 300 580 0 0 {name=p4 sig_type=std_logic lab=von}
C {devices/lab_pin.sym} 550 670 0 0 {name=p5 sig_type=std_logic lab=vb}
C {devices/lab_pin.sym} 130 320 1 0 {name=p6 sig_type=std_logic lab=vb}
C {devices/vdd.sym} 550 490 0 0 {name=l9 lab=VDD}
C {devices/gnd.sym} 130 400 0 0 {name=l10 lab=0}
C {devices/vsource.sym} 150 510 0 0 {name=VINn value=2.5 savecurrent=false}
C {devices/gnd.sym} 150 540 0 0 {name=l12 lab=0}
C {devices/lab_pin.sym} 30 470 1 0 {name=p9 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 150 470 1 0 {name=p10 sig_type=std_logic lab=vinn}
C {devices/lab_pin.sym} 410 490 2 1 {name=p11 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 690 490 2 0 {name=p12 sig_type=std_logic lab=vinn}
