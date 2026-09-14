v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
E {}
T {SRAM512 MACRO | 16 x 32 | seven external connections} -550 -430 0 0 0.45 0.45 {}
T {The inner sheet contains the complete cell array and peripheral circuits.} -550 -370 0 0 0.3 0.3 {}
C {sram512.sym} 0 0 0 0 {name=xcore}
C {devices/ipin.sym} -550 -210 0 0 {name=pCLK lab=CLK}
N -550 -210 -490 -210 {lab=CLK}
C {devices/lab_pin.sym} -490 -210 0 0 {name=l11 lab=CLK hide_texts=true}
C {devices/ipin.sym} -550 -120 0 0 {name=pRESET lab=RESET}
N -550 -120 -490 -120 {lab=RESET}
C {devices/lab_pin.sym} -490 -120 0 0 {name=l14 lab=RESET hide_texts=true}
C {devices/ipin.sym} -550 -30 0 0 {name=pSDI lab=SDI}
N -550 -30 -490 -30 {lab=SDI}
C {devices/lab_pin.sym} -490 -30 0 0 {name=l17 lab=SDI hide_texts=true}
C {devices/ipin.sym} -550 60 0 0 {name=pWE lab=WE}
N -550 60 -490 60 {lab=WE}
C {devices/lab_pin.sym} -490 60 0 0 {name=l20 lab=WE hide_texts=true}
C {devices/opin.sym} -550 150 0 0 {name=pSDO lab=SDO}
N -550 150 -490 150 {lab=SDO}
C {devices/lab_pin.sym} -490 150 0 0 {name=l23 lab=SDO hide_texts=true}
C {devices/iopin.sym} -550 240 0 0 {name=pVDD lab=VDD}
N -550 240 -490 240 {lab=VDD}
C {devices/lab_pin.sym} -490 240 0 0 {name=l26 lab=VDD hide_texts=true}
C {devices/iopin.sym} -550 330 0 0 {name=pVSS lab=VSS}
N -550 330 -490 330 {lab=VSS}
C {devices/lab_pin.sym} -490 330 0 0 {name=l29 lab=VSS hide_texts=true}
C {devices/lab_pin.sym} -160 -90 0 0 {name=l30 lab=CLK}
C {devices/lab_pin.sym} -160 -30 0 0 {name=l31 lab=RESET}
C {devices/lab_pin.sym} -160 30 0 0 {name=l32 lab=SDI}
C {devices/lab_pin.sym} -160 90 0 0 {name=l33 lab=WE}
C {devices/lab_pin.sym} 160 0 2 0 {name=l34 lab=SDO}
C {devices/lab_pin.sym} 0 -200 0 0 {name=l35 lab=VDD}
C {devices/lab_pin.sym} 0 200 0 0 {name=l36 lab=VSS}
