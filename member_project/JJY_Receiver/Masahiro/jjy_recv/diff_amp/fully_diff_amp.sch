v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 445 585 495 585 {lab=ib}
N 375 615 375 645 {lab=vss}
N 535 615 535 645 {lab=vss}
N 315 585 375 585 {lab=vss}
N 315 585 315 645 {lab=vss}
N 315 645 375 645 {lab=vss}
N 535 585 585 585 {lab=vss}
N 585 585 585 645 {lab=vss}
N 535 645 585 645 {lab=vss}
N 535 365 615 365 {lab=vss}
N 535 365 535 380 {lab=vss}
N 455 395 455 455 {lab=#net1}
N 535 455 615 455 {lab=#net1}
N 615 395 615 455 {lab=#net1}
N 535 115 575 115 {lab=vb}
N 385 115 455 115 {lab=vdd}
N 615 115 685 115 {lab=vdd}
N 375 645 535 645 {lab=vss}
N 455 45 455 85 {lab=vdd}
N 455 45 615 45 {lab=vdd}
N 615 45 615 85 {lab=vdd}
N 375 555 445 555 {lab=ib}
N 445 555 445 585 {lab=ib}
N 615 145 615 175 {lab=vop}
N 455 145 455 175 {lab=von}
N 455 365 535 365 {lab=vss}
N 455 455 535 455 {lab=#net1}
N 415 585 445 585 {lab=ib}
N 495 115 535 115 {lab=vb}
N 615 175 615 335 {lab=vop}
N 455 175 455 335 {lab=von}
N 675 265 715 265 {lab=#net2}
N 715 175 715 185 {lab=vop}
N 365 265 405 265 {lab=#net3}
N 365 175 365 185 {lab=von}
N 365 335 365 365 {lab=vinp}
N 715 215 735 215 {lab=vdd}
N 345 215 365 215 {lab=vdd}
N 535 455 535 555 {lab=#net1}
N 365 175 365 185 {lab=von}
N 655 365 935 365 {lab=vinn}
N 155 365 415 365 {lab=vinp}
N 845 485 845 505 {lab=vinn}
N 885 455 905 455 {lab=vinn}
N 905 455 905 535 {lab=vinn}
N 885 535 905 535 {lab=vinn}
N 845 495 905 495 {lab=vinn}
N 845 415 845 425 {lab=vdd}
N 805 455 845 455 {lab=vdd}
N 805 535 845 535 {lab=vss}
N 805 535 805 565 {lab=vss}
N 805 565 845 565 {lab=vss}
N 805 425 845 425 {lab=vdd}
N 805 425 805 455 {lab=vdd}
N 845 565 845 575 {lab=vss}
N 225 485 225 505 {lab=vinp}
N 165 455 185 455 {lab=vinp}
N 165 455 165 535 {lab=vinp}
N 165 535 185 535 {lab=vinp}
N 165 495 225 495 {lab=vinp}
N 225 415 225 425 {lab=vdd}
N 225 455 265 455 {lab=vdd}
N 225 535 265 535 {lab=vss}
N 265 535 265 565 {lab=vss}
N 225 565 265 565 {lab=vss}
N 225 425 265 425 {lab=vdd}
N 265 425 265 455 {lab=vdd}
N 225 565 225 575 {lab=vss}
N 225 495 315 495 {lab=vinp}
N 765 495 845 495 {lab=vinn}
N 765 365 765 495 {lab=vinn}
N 315 365 315 495 {lab=vinp}
N 715 245 715 285 {lab=#net2}
N 675 215 675 315 {lab=#net2}
N 715 345 715 365 {lab=vinn}
N 345 215 345 315 {lab=vdd}
N 345 315 375 315 {lab=vdd}
N 405 215 405 315 {lab=#net3}
N 365 245 365 285 {lab=#net3}
N 615 175 775 175 {lab=vop}
N 295 175 455 175 {lab=von}
N 375 525 375 555 {lab=ib}
N 715 315 735 315 {lab=vdd}
N 735 215 735 315 {lab=vdd}
N 315 215 345 215 {lab=vdd}
N 735 215 770 215 {lab=vdd}
N 125 175 150 175 {lab=vdd}
N 125 215 150 215 {lab=vss}
C {MP.sym} 575 115 0 0 {name=M1 model=PMOS w=45u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 495 115 0 1 {name=M2 model=PMOS w=45u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 495 585 0 0 {name=M3 model=NMOS w=20u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 415 585 0 1 {name=M4 model=NMOS w=20u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/lab_pin.sym} 535 45 3 1 {name=p3 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} 845 415 1 0 {name=p5 sig_type=std_logic lab=vdd}
C {MN.sym} 415 365 0 0 {name=M7 model=NMOS w=20u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 655 365 0 1 {name=M8 model=NMOS w=20u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 675 215 0 0 {name=M6 model=PMOS w=3.4u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 675 315 2 1 {name=M9 model=PMOS w=3.4u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 405 215 0 1 {name=M5 model=PMOS w=3.4u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 405 315 2 0 {name=M10 model=PMOS w=3.4u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 885 535 0 1 {name=M12 model=NMOS w=3.4u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 885 455 0 1 {name=M13 model=PMOS w=8.6u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} 185 535 0 0 {name=M11 model=NMOS w=3.4u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 185 455 0 0 {name=M14 model=PMOS w=8.6u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/code.sym} 65 30 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/opin.sym} 775 175 0 0 {name=p1 lab=vop}
C {devices/opin.sym} 295 175 0 1 {name=p2 lab=von}
C {devices/ipin.sym} 155 365 0 0 {name=p6 lab=vinp}
C {devices/ipin.sym} 535 115 1 0 {name=p7 lab=vb}
C {devices/ipin.sym} 375 525 1 0 {name=p8 lab=ib}
C {devices/ipin.sym} 935 365 0 1 {name=p9 lab=vinn}
C {devices/lab_pin.sym} 685 115 0 1 {name=p4 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} 385 115 0 0 {name=p10 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} 225 415 1 0 {name=p11 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} 455 645 3 0 {name=p12 sig_type=std_logic lab=vss}
C {devices/lab_pin.sym} 845 575 3 0 {name=p13 sig_type=std_logic lab=vss}
C {devices/lab_pin.sym} 225 575 3 0 {name=p14 sig_type=std_logic lab=vss}
C {devices/lab_pin.sym} 535 380 3 0 {name=p15 sig_type=std_logic lab=vss}
C {devices/lab_pin.sym} 315 215 2 1 {name=p16 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} 770 215 2 0 {name=p17 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} 150 175 0 1 {name=p18 sig_type=std_logic lab=vdd}
C {devices/iopin.sym} 125 175 0 1 {name=p19 lab=vdd}
C {devices/iopin.sym} 125 215 0 1 {name=p20 lab=vss}
C {devices/lab_pin.sym} 150 215 0 1 {name=p21 sig_type=std_logic lab=vss}
