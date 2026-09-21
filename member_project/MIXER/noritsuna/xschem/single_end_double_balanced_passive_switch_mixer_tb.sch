v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {Single End Double Balanced Passive Switch Mixer with AMP} -840 -545 0 0 1 1 {}
N -780 110 -780 130 {lab=GND}
N -780 10 -780 50 {lab=DC_BIAS}
N -870 110 -870 130 {lab=GND}
N -870 10 -870 50 {lab=VDD}
N -690 110 -690 130 {lab=GND}
N -690 10 -690 50 {lab=T_BIAS}
N -420 110 -420 130 {lab=GND}
N -420 10 -420 50 {lab=LO_IN}
N -570 110 -570 130 {lab=GND}
N -570 10 -570 50 {lab=RF_IN}
N -1020 -340 -900 -340 {lab=RF_IN}
N -840 -340 -800 -340 {lab=#net1}
N -1020 -240 -980 -240 {lab=LO_IN}
N -920 -240 -800 -240 {lab=#net2}
N -500 -180 -320 -180 {lab=GND}
N -320 -190 -320 -180 {lab=GND}
N -500 -260 -210 -260 {lab=RF_OUT}
N -320 -260 -320 -250 {lab=RF_OUT}
N 140 -310 140 -280 {lab=RF_P}
N 140 -410 140 -370 {lab=VDD}
N 140 -220 140 -190 {lab=GND}
N 230 -310 230 -280 {lab=RF_N}
N 230 -410 230 -370 {lab=VDD}
N 230 -220 230 -190 {lab=GND}
N 320 -310 320 -280 {lab=LO_P}
N 320 -410 320 -370 {lab=VDD}
N 320 -220 320 -190 {lab=GND}
N 410 -310 410 -280 {lab=LO_N}
N 410 -410 410 -370 {lab=VDD}
N 410 -220 410 -190 {lab=GND}
N -500 -320 -100 -320 {lab=#net3}
N -40 -320 -10 -320 {lab=RF_N}
N -500 -280 -100 -280 {lab=#net4}
N -40 -280 -10 -280 {lab=RF_P}
N -500 -220 -100 -220 {lab=#net5}
N -40 -220 -10 -220 {lab=LO_N}
N -500 -200 -100 -200 {lab=#net6}
N -40 -200 -10 -200 {lab=LO_P}
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

plot V(RF_OUT)
plot V(RF_IN) V(LO_IN)

write sigle_end_double_balanced_passive_switch_mixer_tb.raw
.endc"}
C {devices/lab_pin.sym} -780 10 0 1 {name=l3 sig_type=std_logic lab=DC_BIAS
}
C {devices/gnd.sym} -870 130 0 0 {name=l8 lab=GND}
C {devices/vsource.sym} -870 80 0 0 {name=V6 value="dc 5.0" savecurrent=false}
C {devices/lab_pin.sym} -870 10 0 1 {name=l19 sig_type=std_logic lab=VDD
}
C {devices/gnd.sym} -690 130 0 0 {name=l21 lab=GND}
C {devices/vsource.sym} -690 80 0 0 {name=V7 value="dc 1.25" savecurrent=false}
C {devices/lab_pin.sym} -690 10 0 1 {name=l22 sig_type=std_logic lab=T_BIAS
}
C {devices/vsource.sym} -420 80 0 0 {name=V1 value="SIN(0 5V 1049k)" savecurrent=false}
C {devices/lab_pin.sym} -420 10 0 1 {name=l12 sig_type=std_logic lab=LO_IN
}
C {devices/gnd.sym} -420 130 0 0 {name=l11 lab=GND}
C {devices/vsource.sym} -570 80 0 0 {name=V2 value="SIN(0 100mV 594kHz)" savecurrent=false}
C {devices/lab_pin.sym} -570 10 0 1 {name=l13 sig_type=std_logic lab=RF_IN
}
C {devices/gnd.sym} -570 130 0 0 {name=l14 lab=GND}
C {devices/gnd.sym} -500 -180 0 0 {name=l1 lab=GND}
C {devices/lab_pin.sym} -500 -300 0 1 {name=l7 sig_type=std_logic lab=DC_BIAS
}
C {devices/lab_pin.sym} -210 -260 0 1 {name=l10 sig_type=std_logic lab=RF_OUT
}
C {devices/capa.sym} -320 -220 0 0 {name=C1
m=1
value=40p
footprint=1206
device="ceramic capacitor"}
C {devices/lab_pin.sym} -500 -340 0 1 {name=l20 sig_type=std_logic lab=VDD
}
C {devices/lab_pin.sym} -500 -240 0 1 {name=l23 sig_type=std_logic lab=T_BIAS
}
C {single_end_double_balanced_passive_switch_mixer.sym} -650 -260 0 0 {name=x1}
C {devices/capa.sym} -870 -340 3 1 {name=C2
m=1
value=10n
footprint=1206
device="ceramic capacitor"}
C {devices/lab_pin.sym} -1020 -340 0 0 {name=l16 sig_type=std_logic lab=RF_IN
}
C {devices/capa.sym} -950 -240 3 1 {name=C3
m=1
value=10n
footprint=1206
device="ceramic capacitor"}
C {devices/lab_pin.sym} -1020 -240 0 0 {name=l17 sig_type=std_logic lab=LO_IN
}
C {devices/capa.sym} -70 -320 3 1 {name=C4
m=1
value=10n
footprint=1206
device="ceramic capacitor"}
C {devices/lab_pin.sym} -800 -320 0 0 {name=l18 sig_type=std_logic lab=RF_P
}
C {devices/lab_pin.sym} -800 -300 0 0 {name=l24 sig_type=std_logic lab=LO_P
}
C {devices/lab_pin.sym} -800 -280 0 0 {name=l25 sig_type=std_logic lab=RF_N
}
C {devices/lab_pin.sym} -800 -260 0 0 {name=l26 sig_type=std_logic lab=LO_N
}
C {devices/lab_pin.sym} -10 -280 0 1 {name=l27 sig_type=std_logic lab=RF_P
}
C {devices/lab_pin.sym} -10 -200 0 1 {name=l28 sig_type=std_logic lab=LO_P
}
C {devices/lab_pin.sym} -10 -320 0 1 {name=l29 sig_type=std_logic lab=RF_N
}
C {devices/lab_pin.sym} -10 -220 0 1 {name=l30 sig_type=std_logic lab=LO_N
}
C {devices/res.sym} 140 -340 0 0 {name=R1
value=100k
footprint=1206
device=resistor
m=1}
C {devices/res.sym} 140 -250 0 0 {name=R2
value=100k
footprint=1206
device=resistor
m=1}
C {devices/lab_pin.sym} 140 -410 0 1 {name=l31 sig_type=std_logic lab=VDD
}
C {devices/res.sym} 230 -340 0 0 {name=R3
value=100k
footprint=1206
device=resistor
m=1}
C {devices/res.sym} 230 -250 0 0 {name=R4
value=100k
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 140 -190 0 0 {name=l32 lab=GND}
C {devices/res.sym} 320 -340 0 0 {name=R5
value=100k
footprint=1206
device=resistor
m=1}
C {devices/res.sym} 320 -250 0 0 {name=R6
value=100k
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 320 -190 0 0 {name=l33 lab=GND}
C {devices/lab_pin.sym} 320 -410 0 1 {name=l34 sig_type=std_logic lab=VDD
}
C {devices/res.sym} 410 -340 0 0 {name=R7
value=100k
footprint=1206
device=resistor
m=1}
C {devices/res.sym} 410 -250 0 0 {name=R8
value=100k
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 410 -190 0 0 {name=l35 lab=GND}
C {devices/lab_pin.sym} 410 -410 0 1 {name=l36 sig_type=std_logic lab=VDD
}
C {devices/lab_pin.sym} 140 -300 0 1 {name=l37 sig_type=std_logic lab=RF_P
}
C {devices/lab_pin.sym} 410 -300 0 1 {name=l38 sig_type=std_logic lab=LO_N
}
C {devices/lab_pin.sym} 320 -300 0 1 {name=l39 sig_type=std_logic lab=LO_P
}
C {devices/capa.sym} -70 -280 3 1 {name=C5
m=1
value=10n
footprint=1206
device="ceramic capacitor"}
C {devices/capa.sym} -70 -220 3 1 {name=C6
m=1
value=10n
footprint=1206
device="ceramic capacitor"}
C {devices/capa.sym} -70 -200 3 1 {name=C7
m=1
value=10n
footprint=1206
device="ceramic capacitor"}
C {devices/lab_pin.sym} 230 -300 0 1 {name=l40 sig_type=std_logic lab=RF_N
}
C {devices/lab_pin.sym} 230 -410 0 1 {name=l41 sig_type=std_logic lab=VDD
}
C {devices/gnd.sym} 230 -190 0 0 {name=l42 lab=GND}
