v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {Double Balanced Passive Switch Mixer} -840 -545 0 0 1 1 {}
N -670 110 -670 130 {lab=GND}
N -670 10 -670 50 {lab=DC_BIAS}
N -380 -220 -180 -220 {lab=IF_P}
N -380 -200 -180 -200 {lab=IF_N}
N -230 -220 -230 -150 {lab=IF_P}
N -290 -200 -290 -150 {lab=IF_N}
N -290 -90 -230 -90 {lab=GND}
N -380 -90 -290 -90 {lab=GND}
N -530 110 -530 130 {lab=GND}
N -530 10 -530 50 {lab=RF_P}
N -530 270 -530 290 {lab=GND}
N -530 170 -530 210 {lab=RF_N}
N -280 110 -280 130 {lab=GND}
N -280 10 -280 50 {lab=LO_P}
N -280 270 -280 290 {lab=GND}
N -280 170 -280 210 {lab=LO_N}
N -380 -180 -380 -60 {lab=GND}
C {devices/code.sym} -1450 -420 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/gnd.sym} -670 130 0 0 {name=l9 lab=GND}
C {devices/vsource.sym} -670 80 0 0 {name=V3 value="dc 2.5" savecurrent=false}
C {devices/code_shown.sym} -1435 -190 0 0 {name=control only_toplevel=false value=".option savecurrent
.control
save all


# Transienst analysis
tran 0.1u 1m 0 0.1u

plot V(IF_P) - V(IF_N)

write double_balanced_passive_switch_mixer_tb.raw
.endc"}
C {devices/gnd.sym} -380 -60 0 0 {name=l1 lab=GND}
C {devices/lab_pin.sym} -670 10 0 1 {name=l3 sig_type=std_logic lab=DC_BIAS
}
C {devices/lab_pin.sym} -380 -240 0 1 {name=l7 sig_type=std_logic lab=DC_BIAS
}
C {devices/lab_pin.sym} -680 -240 0 0 {name=l2 sig_type=std_logic lab=RF_P
}
C {devices/lab_pin.sym} -680 -220 0 0 {name=l4 sig_type=std_logic lab=LO_P
}
C {devices/lab_pin.sym} -680 -200 0 0 {name=l5 sig_type=std_logic lab=RF_N
}
C {devices/lab_pin.sym} -680 -180 0 0 {name=l6 sig_type=std_logic lab=LO_N
}
C {devices/lab_pin.sym} -180 -220 0 1 {name=l8 sig_type=std_logic lab=IF_P
}
C {devices/lab_pin.sym} -180 -200 0 1 {name=l10 sig_type=std_logic lab=IF_N
}
C {devices/capa.sym} -290 -120 0 0 {name=C1
m=1
value=40p
footprint=1206
device="ceramic capacitor"}
C {devices/capa.sym} -230 -120 0 0 {name=C2
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
C {double_balanced_passive_switch_mixer.sym} -530 -210 0 0 {name=x1}
