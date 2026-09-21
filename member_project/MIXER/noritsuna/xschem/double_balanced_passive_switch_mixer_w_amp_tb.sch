v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {Double Balanced Passive Switch Mixer with AMP} -840 -545 0 0 1 1 {}
N -780 110 -780 130 {lab=GND}
N -780 10 -780 50 {lab=DC_BIAS}
N -380 -220 -180 -220 {lab=RF_AMP}
N -290 -220 -290 -170 {lab=RF_AMP}
N -380 -110 -290 -110 {lab=#net1}
N -530 110 -530 130 {lab=GND}
N -530 10 -530 50 {lab=RF_P}
N -530 270 -530 290 {lab=GND}
N -530 170 -530 210 {lab=RF_N}
N -280 110 -280 130 {lab=GND}
N -280 10 -280 50 {lab=LO_P}
N -280 270 -280 290 {lab=GND}
N -280 170 -280 210 {lab=LO_N}
N -870 110 -870 130 {lab=GND}
N -870 10 -870 50 {lab=VDD}
N -690 110 -690 130 {lab=GND}
N -690 10 -690 50 {lab=T_BIAS}
N -380 -200 -360 -200 {lab=#net1}
N -360 -200 -360 -110 {lab=#net1}
C {devices/code.sym} -1450 -420 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/gnd.sym} -780 130 0 0 {name=l9 lab=GND}
C {devices/vsource.sym} -780 80 0 0 {name=V3 value="dc 2.5" savecurrent=false}
C {devices/code_shown.sym} -1435 -190 0 0 {name=control only_toplevel=false value=".option savecurrent
.control
save all


# Transienst analysis
tran 0.1u 1m 0 0.1u

plot V(RF_AMP)

write double_balanced_passive_switch_mixer_tb.raw
.endc"}
C {devices/gnd.sym} -380 -110 0 0 {name=l1 lab=GND}
C {devices/lab_pin.sym} -780 10 0 1 {name=l3 sig_type=std_logic lab=DC_BIAS
}
C {devices/lab_pin.sym} -380 -260 0 1 {name=l7 sig_type=std_logic lab=DC_BIAS
}
C {devices/lab_pin.sym} -680 -260 0 0 {name=l2 sig_type=std_logic lab=RF_P
}
C {devices/lab_pin.sym} -680 -240 0 0 {name=l4 sig_type=std_logic lab=LO_P
}
C {devices/lab_pin.sym} -680 -220 0 0 {name=l5 sig_type=std_logic lab=RF_N
}
C {devices/lab_pin.sym} -680 -200 0 0 {name=l6 sig_type=std_logic lab=LO_N
}
C {devices/lab_pin.sym} -180 -220 0 1 {name=l10 sig_type=std_logic lab=RF_AMP
}
C {devices/capa.sym} -290 -140 0 0 {name=C1
m=1
value=40p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} -530 130 0 0 {name=l11 lab=GND}
C {devices/vsource.sym} -530 80 0 0 {name=V1 value="SIN(2.5V 100mV 594kHz 0 0 0)" savecurrent=false}
C {devices/lab_pin.sym} -530 10 0 1 {name=l12 sig_type=std_logic lab=RF_P
}
C {devices/gnd.sym} -530 290 0 0 {name=l13 lab=GND}
C {devices/vsource.sym} -530 240 0 0 {name=V2 value="SIN(2.5V 100mV 594kHz 0 0 180)" savecurrent=false}
C {devices/lab_pin.sym} -530 170 0 1 {name=l14 sig_type=std_logic lab=RF_N
}
C {devices/gnd.sym} -280 130 0 0 {name=l15 lab=GND}
C {devices/vsource.sym} -280 80 0 0 {name=V4 value="PULSE(0V 5V 0s 5ns 5ns 471.6ns 953.29ns)" savecurrent=false}
C {devices/lab_pin.sym} -280 10 0 1 {name=l16 sig_type=std_logic lab=LO_P
}
C {devices/gnd.sym} -280 290 0 0 {name=l17 lab=GND}
C {devices/vsource.sym} -280 240 0 0 {name=V5 value="PULSE(0V 5V 476.6ns 5ns 5ns 471.6ns 953.29ns)" savecurrent=false}
C {devices/lab_pin.sym} -280 170 0 1 {name=l18 sig_type=std_logic lab=LO_N
}
C {double_balanced_passive_switch_mixer_w_amp.sym} -530 -220 0 0 {name=x1}
C {devices/gnd.sym} -870 130 0 0 {name=l8 lab=GND}
C {devices/vsource.sym} -870 80 0 0 {name=V6 value="dc 5.0" savecurrent=false}
C {devices/lab_pin.sym} -870 10 0 1 {name=l19 sig_type=std_logic lab=VDD
}
C {devices/lab_pin.sym} -380 -240 0 1 {name=l20 sig_type=std_logic lab=VDD
}
C {devices/gnd.sym} -690 130 0 0 {name=l21 lab=GND}
C {devices/vsource.sym} -690 80 0 0 {name=V7 value="dc 1.25" savecurrent=false}
C {devices/lab_pin.sym} -690 10 0 1 {name=l22 sig_type=std_logic lab=T_BIAS
}
C {devices/lab_pin.sym} -380 -180 0 1 {name=l23 sig_type=std_logic lab=T_BIAS
}
