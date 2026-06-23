v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 460 610 510 610 {lab=ib}
N 390 640 390 670 {lab=vss}
N 550 640 550 670 {lab=vss}
N 330 610 390 610 {lab=vss}
N 330 610 330 670 {lab=vss}
N 330 670 390 670 {lab=vss}
N 550 610 600 610 {lab=vss}
N 600 610 600 670 {lab=vss}
N 550 670 600 670 {lab=vss}
N 550 430 550 445 {lab=vss}
N 540 130 580 130 {lab=vb}
N 390 130 460 130 {lab=vdd}
N 620 130 690 130 {lab=vdd}
N 390 670 550 670 {lab=vss}
N 460 60 460 100 {lab=vdd}
N 460 60 620 60 {lab=vdd}
N 620 60 620 100 {lab=vdd}
N 390 580 460 580 {lab=ib}
N 460 580 460 610 {lab=ib}
N 620 160 620 190 {lab=ifp}
N 460 160 460 190 {lab=ifn}
N 430 610 460 610 {lab=ib}
N 500 130 540 130 {lab=vb}
N 620 190 780 190 {lab=ifp}
N 300 190 460 190 {lab=ifn}
N 60 180 85 180 {lab=vdd}
N 60 220 85 220 {lab=vss}
N 790 430 820 430 {lab=rfn}
N 250 430 290 430 {lab=rfp}
N 330 300 410 300 {lab=vss}
N 330 300 330 315 {lab=vss}
N 250 300 330 300 {lab=vss}
N 390 560 390 580 {lab=ib}
N 250 370 410 370 {lab=#net1}
N 330 370 330 400 {lab=#net1}
N 750 300 830 300 {lab=vss}
N 750 300 750 315 {lab=vss}
N 670 300 750 300 {lab=vss}
N 670 370 830 370 {lab=#net2}
N 750 370 750 400 {lab=#net2}
N 330 500 750 500 {lab=#net3}
N 330 430 750 430 {lab=vss}
N 60 260 85 260 {lab=lop}
N 60 300 85 300 {lab=lon}
N 190 300 210 300 {lab=lop}
N 450 300 630 300 {lab=lon}
N 870 300 890 300 {lab=lop}
N 410 220 830 220 {lab=ifp}
N 620 190 620 220 {lab=ifp}
N 410 220 410 270 {lab=ifp}
N 830 220 830 270 {lab=ifp}
N 460 190 460 240 {lab=ifn}
N 250 240 460 240 {lab=ifn}
N 250 240 250 270 {lab=ifn}
N 460 240 670 240 {lab=ifn}
N 670 240 670 270 {lab=ifn}
N 750 460 750 500 {lab=#net3}
N 330 460 330 500 {lab=#net3}
N 830 330 830 370 {lab=#net2}
N 670 330 670 370 {lab=#net2}
N 250 330 250 370 {lab=#net1}
N 410 330 410 370 {lab=#net1}
N 550 500 550 580 {lab=#net3}
C {MP.sym} 580 130 0 0 {name=M1 model=PMOS w=45u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 500 130 0 1 {name=M2 model=PMOS w=45u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 510 610 0 0 {name=M3 model=NMOS w=20u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 430 610 0 1 {name=M4 model=NMOS w=20u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/lab_pin.sym} 540 60 3 1 {name=p3 sig_type=std_logic lab=vdd}
C {MN.sym} 290 430 0 0 {name=M7 model=NMOS w=20u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 790 430 0 1 {name=M8 model=NMOS w=20u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/code.sym} 0 35 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/opin.sym} 780 190 0 0 {name=p1 lab=ifp}
C {devices/opin.sym} 300 190 0 1 {name=p2 lab=ifn}
C {devices/ipin.sym} 250 430 0 0 {name=p6 lab=rfp}
C {devices/ipin.sym} 540 130 1 0 {name=p7 lab=vb}
C {devices/ipin.sym} 390 560 1 0 {name=p8 lab=ib}
C {devices/ipin.sym} 820 430 0 1 {name=p9 lab=rfn}
C {devices/lab_pin.sym} 690 130 0 1 {name=p4 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} 390 130 0 0 {name=p10 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} 470 670 3 0 {name=p12 sig_type=std_logic lab=vss}
C {devices/lab_pin.sym} 550 445 3 0 {name=p15 sig_type=std_logic lab=vss}
C {devices/lab_pin.sym} 85 180 0 1 {name=p18 sig_type=std_logic lab=vdd}
C {devices/iopin.sym} 60 180 0 1 {name=p19 lab=vdd}
C {devices/iopin.sym} 60 220 0 1 {name=p20 lab=vss}
C {devices/lab_pin.sym} 85 220 0 1 {name=p21 sig_type=std_logic lab=vss}
C {MN.sym} 210 300 0 0 {name=M5 model=NMOS w=20u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 450 300 0 1 {name=M6 model=NMOS w=20u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/ipin.sym} 60 300 0 0 {name=p5 lab=lon}
C {devices/lab_pin.sym} 330 315 3 0 {name=p13 sig_type=std_logic lab=vss}
C {MN.sym} 630 300 0 0 {name=M9 model=NMOS w=20u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 870 300 0 1 {name=M10 model=NMOS w=20u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/lab_pin.sym} 750 315 3 0 {name=p17 sig_type=std_logic lab=vss}
C {devices/ipin.sym} 60 260 0 0 {name=p11 lab=lop}
C {devices/lab_pin.sym} 85 260 0 1 {name=p14 sig_type=std_logic lab=lop}
C {devices/lab_pin.sym} 85 300 0 1 {name=p22 sig_type=std_logic lab=lon
}
C {devices/lab_pin.sym} 190 300 0 0 {name=p23 sig_type=std_logic lab=lop}
C {devices/lab_pin.sym} 550 300 1 0 {name=p24 sig_type=std_logic lab=lon}
C {devices/lab_pin.sym} 890 300 0 1 {name=p16 sig_type=std_logic lab=lop}
