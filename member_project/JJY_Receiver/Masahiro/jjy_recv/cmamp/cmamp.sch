v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 710 310 710 390 {lab=0}
N 710 280 740 280 {lab=0}
N 740 280 740 350 {lab=0}
N 710 350 740 350 {lab=0}
N 710 170 710 250 {lab=out}
N 710 140 770 140 {lab=VDD}
N 770 80 770 140 {lab=VDD}
N 710 80 770 80 {lab=VDD}
N 710 50 710 110 {lab=VDD}
N 610 280 610 330 {lab=#net1}
N 610 280 670 280 {lab=#net1}
N 710 220 840 220 {lab=out}
N 650 140 670 140 {lab=in}
N 610 70 610 110 {lab=VDD}
N 610 70 710 70 {lab=VDD}
N 550 140 610 140 {lab=VDD}
N 550 100 550 140 {lab=VDD}
N 550 100 610 100 {lab=VDD}
N 660 140 660 200 {lab=in}
N 620 200 660 200 {lab=in}
N 610 200 620 200 {lab=in}
N 610 170 610 230 {lab=in}
N 410 230 610 230 {lab=in}
N 410 230 410 330 {lab=in}
N 820 340 820 390 {lab=0}
N 820 220 820 280 {lab=out}
C {MN.sym} 670 280 0 0 {name=M4 model=NMOS w=40u l=2u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {devices/code.sym} 0 0 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/gnd.sym} 710 390 0 0 {name=l1 lab=0}
C {MP.sym} 670 140 0 0 {name=M1 model=PMOS w=40u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/vdd.sym} 710 50 0 0 {name=l2 lab=VDD}
C {devices/vsource.sym} 510 360 0 0 {name=VDD value=5 savecurrent=false}
C {devices/vsource.sym} 610 360 0 0 {name=VIN value="DC 1.68 AC 1.0" savecurrent=false}
C {devices/gnd.sym} 610 390 0 0 {name=l3 lab=0}
C {devices/gnd.sym} 510 390 0 0 {name=l4 lab=0}
C {devices/vdd.sym} 510 330 0 0 {name=l5 lab=VDD}
C {MP.sym} 650 140 0 1 {name=M2 model=PMOS w=40u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/isource.sym} 410 360 0 0 {name=I0 value=500u}
C {devices/gnd.sym} 410 390 0 0 {name=l6 lab=0}
C {devices/lab_pin.sym} 840 220 0 1 {name=p1 sig_type=std_logic lab=out}
C {devices/lab_pin.sym} 410 230 0 0 {name=p2 sig_type=std_logic lab=in}
C {devices/code_shown.sym} 70 230 0 0 {name=s1 only_toplevel=false value="""
.option savecurrent
.control
set units = d

op
dc VIN 0 5.0 0.01
plot v(out)
ac dec 11 10 1G
plot vdb(out)
plot vp(out)
.endc
"""}
C {devices/capa.sym} 820 310 0 0 {name=C1
m=1
value=10p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 820 390 0 0 {name=l7 lab=0}
