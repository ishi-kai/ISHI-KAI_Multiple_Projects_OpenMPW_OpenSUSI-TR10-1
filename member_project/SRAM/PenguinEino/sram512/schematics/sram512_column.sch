v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
E {}
T {ONE COLUMN: local precharge + nMOS pass MUX} -300 -360 0 0 0.35 0.35 {}
C {TR-1umLIB/MP.sym} 0 -160 0 0 {name=xpcBL model=PMOS w=3.4u l=1u m=1 spiceprefix=X}
C {TR-1umLIB/MN.sym} 0 160 0 0 {name=xmuxBL model=NMOS w=5.1u l=1u m=1 spiceprefix=X}
N 40 -130 40 130 {lab=BL}
N 40 -130 190 -130 {lab=BL}
C {devices/iopin.sym} 190 -130 0 0 {name=pBL lab=BL}
N 40 190 40 290 {lab=Y}
C {devices/iopin.sym} 40 290 0 0 {name=pY lab=Y}
C {TR-1umLIB/MP.sym} 600 -160 0 0 {name=xpcBLB model=PMOS w=3.4u l=1u m=1 spiceprefix=X}
C {TR-1umLIB/MN.sym} 600 160 0 0 {name=xmuxBLB model=NMOS w=5.1u l=1u m=1 spiceprefix=X}
N 640 -130 640 130 {lab=BLB}
N 640 -130 790 -130 {lab=BLB}
C {devices/iopin.sym} 790 -130 0 0 {name=pBLB lab=BLB}
N 640 190 640 290 {lab=YB}
C {devices/iopin.sym} 640 290 0 0 {name=pYB lab=YB}
C {devices/ipin.sym} -280 -200 0 0 {name=pPREB lab=PREB}
N -280 -200 -220 -200 {lab=PREB}
C {devices/lab_pin.sym} -220 -200 0 0 {name=l23 lab=PREB hide_texts=true}
C {devices/ipin.sym} -280 -40 0 0 {name=pCOL lab=COL}
N -280 -40 -220 -40 {lab=COL}
C {devices/lab_pin.sym} -220 -40 0 0 {name=l26 lab=COL hide_texts=true}
C {devices/iopin.sym} -280 120 0 0 {name=pVDD lab=VDD}
N -280 120 -220 120 {lab=VDD}
C {devices/lab_pin.sym} -220 120 0 0 {name=l29 lab=VDD hide_texts=true}
C {devices/iopin.sym} -280 280 0 0 {name=pVSS lab=VSS}
N -280 280 -220 280 {lab=VSS}
C {devices/lab_pin.sym} -220 280 0 0 {name=l32 lab=VSS hide_texts=true}
C {devices/lab_pin.sym} 0 -160 0 0 {name=l33 lab=PREB}
C {devices/lab_pin.sym} 40 -190 0 0 {name=l34 lab=VDD}
C {devices/lab_pin.sym} 40 -160 0 0 {name=l35 lab=VDD}
C {devices/lab_pin.sym} 0 160 0 0 {name=l36 lab=COL}
C {devices/lab_pin.sym} 40 190 0 0 {name=l37 lab=Y}
C {devices/lab_pin.sym} 40 160 0 0 {name=l38 lab=VSS}
C {devices/lab_pin.sym} 600 -160 0 0 {name=l39 lab=PREB}
C {devices/lab_pin.sym} 640 -190 0 0 {name=l40 lab=VDD}
C {devices/lab_pin.sym} 640 -160 0 0 {name=l41 lab=VDD}
C {devices/lab_pin.sym} 600 160 0 0 {name=l42 lab=COL}
C {devices/lab_pin.sym} 640 190 0 0 {name=l43 lab=YB}
C {devices/lab_pin.sym} 640 160 0 0 {name=l44 lab=VSS}
