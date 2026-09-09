v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -20 60 0 60 {lab=RAMP}
N -20 180 0 180 {lab=RAMP}
N -20 60 -20 180 {lab=RAMP}
N -80 120 -20 120 {lab=RAMP}
N 360 60 380 60 {lab=OUT}
N 370 60 370 100 {lab=OUT}
N 420 30 520 30 {lab=DISCH}
N 420 60 480 60 {lab=VSS}
N 420 90 420 280 {lab=VSS}
N 50 -40 50 -10 {lab=VDD}
N 170 -40 170 -10 {lab=VDD}
N 300 -40 300 10 {lab=VDD}
N 50 250 50 280 {lab=VSS}
N 170 250 170 280 {lab=VSS}
N 50 150 60 150 {lab=VDD}
N 60 -40 60 150 {lab=VDD}
N 170 150 180 150 {lab=VDD}
N 180 -40 180 150 {lab=VDD}
N 40 90 50 90 {lab=VSS}
N 160 90 170 90 {lab=VSS}
N 160 90 160 280 {lab=VSS}
N 40 90 40 280 {lab=VSS}
N 300 110 300 280 {lab=VSS}
N 240 80 240 200 {lab=#net4}
N 480 60 480 280 {lab=VSS}
N -40 0 -0 0 {lab=IBIAS}
N -40 20 -0 20 {lab=VTH_H}
N -40 160 -0 160 {lab=IBIAS}
N -40 220 -0 220 {lab=VTH_L}
N -40 280 480 280 {lab=VSS}
N -40 -40 300 -40 {lab=VDD}
N 300 -40 440 -40 {lab=VDD}
N 650 -40 650 0 {lab=VDD}
N 650 180 650 280 {lab=VSS}
N 670 -40 670 150 {lab=VDD}
N 760 200 760 220 {lab=IBIAS}
N 760 280 760 300 {lab=VSS}
N 780 230 780 250 {lab=VDD}
N 880 20 920 20 {lab=VTH_H}
N 880 80 920 80 {lab=VSS}
N 1000 20 1040 20 {lab=VTH_L}
N 1000 80 1040 80 {lab=VSS}
C {comparator.sym} 20 40 0 0 {name=x1}
C {comparator.sym} 20 200 0 0 {name=x2}
C {inverter_15v.sym} 140 40 0 0 {name=x3}
C {inverter_05v.sym} 140 200 0 0 {name=x4}
C {prsr_latch.sym} 300 60 0 0 {name=x5}
C {MN.sym} 380 60 0 0 {name=XM1 model=NMOS w=4u l=2u m=1 spiceprefix=X as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0}
C {RR.sym} 650 0 0 0 {name=RTH1 w=4e-06 R=1 l=50e-06 model=F_RR spiceprefix=X tc1=0 tc2=0 m=1}
C {RR.sym} 650 60 0 0 {name=RTH2 w=4e-06 R=1 l=50e-06 model=F_RR spiceprefix=X tc1=0 tc2=0 m=1}
C {RR.sym} 650 120 0 0 {name=RTH3 w=4e-06 R=1 l=50e-06 model=F_RR spiceprefix=X tc1=0 tc2=0 m=1}
C {RR.sym} 760 220 0 0 {name=RBIAS w=4e-06 R=1 l=100e-06 model=F_RR spiceprefix=X tc1=0 tc2=0 m=1}
C {DN.sym} 880 20 0 0 {name=DPROT_H model=DN w=3.6u l=3.6u a="expr_eng( @w * @l )" p="expr_eng( 2 * ( @w + @l ) )" spiceprefix=D m=1}
C {DN.sym} 1000 20 0 0 {name=DPROT_L model=DN w=3.6u l=3.6u a="expr_eng( @w * @l )" p="expr_eng( 2 * ( @w + @l ) )" spiceprefix=D m=1}
C {devices/lab_pin.sym} 650 60 0 1 {name=p10 sig_type=std_logic lab=VTH_H}
C {devices/lab_pin.sym} 650 120 0 1 {name=p11 sig_type=std_logic lab=VTH_L}
C {devices/lab_pin.sym} -40 20 0 0 {name=p12 sig_type=std_logic lab=VTH_H}
C {devices/lab_pin.sym} -40 220 0 0 {name=p13 sig_type=std_logic lab=VTH_L}
C {devices/lab_pin.sym} 650 0 0 1 {name=p14 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 650 180 0 1 {name=p15 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} -40 0 0 0 {name=p16 sig_type=std_logic lab=IBIAS}
C {devices/lab_pin.sym} -40 160 0 0 {name=p17 sig_type=std_logic lab=IBIAS}
C {devices/lab_pin.sym} 760 200 0 0 {name=p18 sig_type=std_logic lab=IBIAS}
C {devices/lab_pin.sym} 760 300 0 0 {name=p19 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 780 230 0 1 {name=p20 sig_type=std_logic lab=VDD}
C {devices/iopin.sym} -40 -40 0 1 {name=p1 lab=VDD}
C {devices/iopin.sym} -40 280 0 1 {name=p2 lab=VSS}
C {devices/iopin.sym} -80 120 0 1 {name=p3 lab=RAMP}
C {devices/iopin.sym} 520 30 0 0 {name=p4 lab=DISCH}
C {devices/opin.sym} 370 100 1 0 {name=p5 lab=OUT}
