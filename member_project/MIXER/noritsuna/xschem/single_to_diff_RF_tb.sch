v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 100 180 100 200 {lab=GND}
N 100 80 100 120 {lab=VDD}
N 10 -140 90 -140 {lab=#net1}
N -130 -140 -50 -140 {lab=RF_IN}
N 210 180 210 200 {lab=GND}
N 210 80 210 120 {lab=RF_IN}
C {devices/code.sym} -680 -200 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/code_shown.sym} -665 30 0 0 {name=control only_toplevel=false value=".option savecurrent
.control
save all


# Transienst analysis
tran 0.1u 1m 0 0.1u

plot V(RF_P) V(RF_N)

write single_to_diff_RF_tb.raw
.endc"}
C {single_to_diff_RF.sym} 240 -110 0 0 {name=x1}
C {devices/gnd.sym} 100 200 0 0 {name=l9 lab=GND}
C {devices/vsource.sym} 100 150 0 0 {name=V3 value="dc 5.0" savecurrent=false}
C {devices/lab_pin.sym} 100 80 0 1 {name=l3 sig_type=std_logic lab=VDD
}
C {devices/gnd.sym} 390 -80 0 0 {name=l1 lab=GND}
C {devices/capa.sym} -20 -140 3 1 {name=C1
m=1
value=10n
footprint=1206
device="ceramic capacitor"}
C {devices/lab_pin.sym} -130 -140 0 0 {name=l4 sig_type=std_logic lab=RF_IN
}
C {devices/lab_pin.sym} 390 -120 0 1 {name=l2 sig_type=std_logic lab=RF_N
}
C {devices/lab_pin.sym} 390 -100 0 1 {name=l5 sig_type=std_logic lab=RF_P
}
C {devices/lab_pin.sym} 390 -140 0 1 {name=l6 sig_type=std_logic lab=VDD
}
C {devices/vsource.sym} 210 150 0 0 {name=V1 value="SIN(0 100mV 594kHz)" savecurrent=false}
C {devices/lab_pin.sym} 210 80 0 1 {name=l12 sig_type=std_logic lab=RF_IN
}
C {devices/gnd.sym} 210 200 0 0 {name=l7 lab=GND}
