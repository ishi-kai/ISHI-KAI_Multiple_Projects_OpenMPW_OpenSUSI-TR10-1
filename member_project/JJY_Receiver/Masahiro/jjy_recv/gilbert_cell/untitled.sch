v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 435 595 485 595 {lab=ib}
N 365 625 365 655 {lab=vss}
N 525 625 525 655 {lab=vss}
N 305 595 365 595 {lab=vss}
N 305 595 305 655 {lab=vss}
N 305 655 365 655 {lab=vss}
N 525 595 575 595 {lab=vss}
N 575 595 575 655 {lab=vss}
N 525 655 575 655 {lab=vss}
N 525 375 605 375 {lab=vss}
N 525 375 525 390 {lab=vss}
N 445 405 445 465 {lab=#net1}
N 525 465 605 465 {lab=#net1}
N 605 405 605 465 {lab=#net1}
N 525 125 565 125 {lab=vb}
N 375 125 445 125 {lab=vdd}
N 605 125 675 125 {lab=vdd}
N 365 655 525 655 {lab=vss}
N 445 55 445 95 {lab=vdd}
N 445 55 605 55 {lab=vdd}
N 605 55 605 95 {lab=vdd}
N 365 565 435 565 {lab=ib}
N 435 565 435 595 {lab=ib}
N 605 155 605 185 {lab=vop}
N 445 155 445 185 {lab=von}
N 445 375 525 375 {lab=vss}
N 445 465 525 465 {lab=#net1}
N 405 595 435 595 {lab=ib}
N 485 125 525 125 {lab=vb}
N 605 185 605 345 {lab=vop}
N 445 185 445 345 {lab=von}
N 525 465 525 565 {lab=#net1}
N 605 185 765 185 {lab=vop}
N 285 185 445 185 {lab=von}
N 365 535 365 565 {lab=ib}
N 115 225 140 225 {lab=vdd}
N 115 265 140 265 {lab=vss}
C {MP.sym} 565 125 0 0 {name=M1 model=PMOS w=45u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 485 125 0 1 {name=M2 model=PMOS w=45u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 485 595 0 0 {name=M3 model=NMOS w=20u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 405 595 0 1 {name=M4 model=NMOS w=20u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/lab_pin.sym} 525 55 3 1 {name=p3 sig_type=std_logic lab=vdd}
C {MN.sym} 405 375 0 0 {name=M7 model=NMOS w=20u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 645 375 0 1 {name=M8 model=NMOS w=20u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/code.sym} 55 80 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/opin.sym} 765 185 0 0 {name=p1 lab=vop}
C {devices/opin.sym} 285 185 0 1 {name=p2 lab=von}
C {devices/ipin.sym} 365 375 0 0 {name=p6 lab=vinp}
C {devices/ipin.sym} 525 125 1 0 {name=p7 lab=vb}
C {devices/ipin.sym} 365 535 1 0 {name=p8 lab=ib}
C {devices/ipin.sym} 675 375 0 1 {name=p9 lab=vinn}
C {devices/lab_pin.sym} 675 125 0 1 {name=p4 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} 375 125 0 0 {name=p10 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} 445 655 3 0 {name=p12 sig_type=std_logic lab=vss}
C {devices/lab_pin.sym} 525 390 3 0 {name=p15 sig_type=std_logic lab=vss}
C {devices/lab_pin.sym} 140 225 0 1 {name=p18 sig_type=std_logic lab=vdd}
C {devices/iopin.sym} 115 225 0 1 {name=p19 lab=vdd}
C {devices/iopin.sym} 115 265 0 1 {name=p20 lab=vss}
C {devices/lab_pin.sym} 140 265 0 1 {name=p21 sig_type=std_logic lab=vss}
