v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
E {}
T {INPUT GATE CLAMPS | dev PCell DP + DN, 3.6 x 3.6 um} -350 -270 0 0 0.32 0.32 {}
T {Connect to the shuttle pad / ESD network at chip integration.} -350 -210 0 0 0.27 0.27 {}
C {TR-1umLIB/DP.sym} 0 -120 0 0 {name=xupper model=DP w=3.6u l=3.6u m=1 spiceprefix=D}
C {TR-1umLIB/DN.sym} 0 80 0 0 {name=xlower model=DN w=3.6u l=3.6u m=1 spiceprefix=D}
N 0 -60 0 80 {lab=IN}
C {devices/iopin.sym} -250 0 0 0 {name=pIN lab=IN}
N -250 0 -190 0 {lab=IN}
C {devices/lab_pin.sym} -190 0 0 0 {name=l13 lab=IN hide_texts=true}
N -190 0 0 0 {lab=IN}
C {devices/iopin.sym} -250 -120 0 0 {name=pVDD lab=VDD}
N -250 -120 -190 -120 {lab=VDD}
C {devices/lab_pin.sym} -190 -120 0 0 {name=l17 lab=VDD hide_texts=true}
C {devices/iopin.sym} -250 140 0 0 {name=pVSS lab=VSS}
N -250 140 -190 140 {lab=VSS}
C {devices/lab_pin.sym} -190 140 0 0 {name=l20 lab=VSS hide_texts=true}
C {devices/lab_pin.sym} 0 -120 0 0 {name=l21 lab=VDD}
C {devices/lab_pin.sym} 0 140 0 0 {name=l22 lab=VSS}
