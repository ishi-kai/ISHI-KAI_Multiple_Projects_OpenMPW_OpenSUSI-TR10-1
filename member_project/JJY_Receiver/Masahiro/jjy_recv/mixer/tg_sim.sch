v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 300 370 550 370 {lab=vin}
N 590 400 590 430 {lab=0}
N 590 370 620 370 {lab=0}
N 620 370 620 420 {lab=0}
N 590 290 590 340 {lab=std1}
N 300 260 300 270 {lab=vsw}
N 300 260 550 260 {lab=vsw}
N 590 430 590 450 {lab=0}
N 590 510 590 530 {lab=0}
N 300 370 300 390 {lab=vin}
N 590 260 620 260 {lab=0}
N 620 420 620 520 {lab=0}
N 590 520 620 520 {lab=0}
N 590 450 590 510 {lab=0}
N 620 260 620 370 {lab=0}
N 440 70 500 70 {lab=#net1}
N 350 70 370 70 {lab=#net2}
N 310 0 310 40 {lab=#net3}
N 590 20 690 20 {lab=VDD}
N 250 70 310 70 {lab=#net3}
N 250 30 250 70 {lab=#net3}
N 250 30 310 30 {lab=#net3}
N 360 70 360 120 {lab=#net2}
N 620 260 720 260 {lab=0}
N 720 290 720 330 {lab=std1}
N 590 330 720 330 {lab=std1}
N 310 100 310 120 {lab=#net4}
N 500 30 500 70 {lab=#net1}
N 440 30 500 30 {lab=#net1}
N 440 0 440 40 {lab=#net1}
N 590 140 590 230 {lab=#net5}
N 440 100 440 210 {lab=#net6}
N 370 70 400 70 {lab=#net2}
N 690 20 720 20 {lab=VDD}
N 480 180 920 180 {lab=vsw}
N 900 260 920 260 {lab=vsw}
N 760 260 780 260 {lab=#net7}
N 720 160 1050 160 {lab=vout}
N 1050 160 1050 180 {lab=vout}
N 1050 180 1050 210 {lab=vout}
N 590 120 590 140 {lab=#net5}
N 590 20 590 60 {lab=VDD}
N 720 20 720 60 {lab=VDD}
N 720 120 720 230 {lab=vout}
N 920 180 920 260 {lab=vsw}
N 480 180 480 260 {lab=vsw}
C {devices/code.sym} 0 0 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {MN.sym} 550 370 0 0 {name=M1 model=NMOS w=40u l=4u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/vsource.sym} 300 300 0 0 {name=V1 value="dc 0 pulse(0 5 0 1n 1n 13.16u 26.32u 100)" savecurrent=false}
C {devices/gnd.sym} 300 330 0 0 {name=l1 lab=0}
C {devices/gnd.sym} 590 530 0 0 {name=l2 lab=0}
C {devices/vsource.sym} 40 470 0 0 {name=V2 value=5 savecurrent=false}
C {devices/gnd.sym} 40 500 0 0 {name=l4 lab=0}
C {devices/vdd.sym} 40 440 0 0 {name=l6 lab=VDD}
C {devices/vsource.sym} 300 420 0 0 {name=V3 value="dc 0 sin(2.5 100m 80k)" savecurrent=false}
C {devices/gnd.sym} 300 450 0 0 {name=l7 lab=0}
C {devices/lab_pin.sym} 300 370 0 0 {name=p1 sig_type=std_logic lab=vin}
C {devices/lab_pin.sym} 1050 170 0 1 {name=p2 sig_type=std_logic lab=vout}
C {devices/lab_pin.sym} 300 260 0 0 {name=p3 sig_type=std_logic lab=vsw}
C {devices/code_shown.sym} 30 610 0 0 {name=spice only_toplevel=false value="""
.option savecurrent
.control
save all

dc v3 0 5 0.01
plot vout
plot std1

tran 100n 100u
plot vout vsw
plot vin 
.endc
"""}
C {devices/gnd.sym} 1050 270 0 0 {name=l9 lab=0}
C {devices/vdd.sym} 660 20 0 0 {name=l3 lab=VDD}
C {MN.sym} 550 260 0 0 {name=M2 model=NMOS w=40u l=4u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 400 70 0 0 {name=M3 model=PMOS w=80u l=4u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 350 70 0 1 {name=M4 model=PMOS w=80u l=4u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/lab_pin.sym} 590 320 0 0 {name=p4 sig_type=std_logic lab=std1
}
C {MN.sym} 760 260 0 1 {name=M5 model=NMOS w=40u l=4u nrd=0 nrs=0 m=1 spiceprefix=X}
C {INV_X1.sym} 880 260 0 1 {name=x1}
C {devices/gnd.sym} 850 300 0 0 {name=l8 lab=0}
C {devices/vdd.sym} 850 220 0 0 {name=l10 lab=VDD}
C {devices/res.sym} 590 90 0 0 {name=R1
value=2k
footprint=1206
device=resistor
m=1}
C {devices/res.sym} 720 90 0 0 {name=R2
value=2k
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} 1050 240 0 0 {name=C1
m=1
value=1p
footprint=1206
device="ceramic capacitor"}
