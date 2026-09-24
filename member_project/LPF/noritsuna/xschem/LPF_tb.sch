v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -260 150 -260 170 {lab=GND}
N -260 50 -260 90 {lab=VDD}
N -150 150 -150 170 {lab=GND}
N -150 50 -150 90 {lab=ib}
N 40 -170 180 -170 {lab=RF_OUT}
N 30 150 30 170 {lab=GND}
N 30 50 30 90 {lab=CLK}
N 30 350 30 370 {lab=GND}
N 30 250 30 290 {lab=RF}
C {devices/code.sym} -570 -190 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/code_shown.sym} -565 20 0 0 {name=control only_toplevel=false value=".option savecurrent
.control
save all

# analysis
tran 1n 50u

plot v(RF_OUT)
load LFP_tb
linearize v(rf_out)
fft v(rf_out)
plot mag(v(rf_out))

write LFP_tb.raw
.endc"}
C {devices/isource.sym} -150 120 0 0 {name=I0 value=10e-6}
C {devices/gnd.sym} -260 170 0 0 {name=l8 lab=GND}
C {devices/vsource.sym} -260 120 0 0 {name=V6 value="dc 5.0" savecurrent=false}
C {devices/lab_pin.sym} -260 50 0 1 {name=l19 sig_type=std_logic lab=VDD
}
C {devices/gnd.sym} -150 170 0 0 {name=l1 lab=GND}
C {devices/lab_pin.sym} 180 -170 0 1 {name=p8 sig_type=std_logic lab=RF_OUT
}
C {devices/lab_pin.sym} -150 50 0 1 {name=p5 sig_type=std_logic lab=ib}
C {devices/lab_pin.sym} 40 -190 0 1 {name=p16 sig_type=std_logic lab=VDD}
C {devices/gnd.sym} 40 -150 0 0 {name=l2 lab=GND}
C {LPF.sym} -110 -170 0 0 {name=x1}
C {devices/capa.sym} 150 -140 0 0 {name=C1
m=1
value=40p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 150 -110 0 0 {name=l3 lab=GND}
C {devices/gnd.sym} 30 170 0 0 {name=l15 lab=GND}
C {devices/vsource.sym} 30 120 0 0 {name=V4 value="PULSE(0V 5V 0s 5ns 5ns 948.6ns 1.9073us)" savecurrent=false}
C {devices/lab_pin.sym} 30 50 0 1 {name=l16 sig_type=std_logic lab=CLK
}
C {devices/gnd.sym} 30 370 0 0 {name=l11 lab=GND}
C {devices/vsource.sym} 30 320 0 0 {name=V1 value="SIN(2.5V 100mV 594kHz 0 0 0)" savecurrent=false}
C {devices/lab_pin.sym} 30 250 0 1 {name=l12 sig_type=std_logic lab=RF
}
C {devices/lab_pin.sym} -260 -150 0 0 {name=l4 sig_type=std_logic lab=RF
}
C {devices/lab_pin.sym} -260 -190 0 0 {name=l5 sig_type=std_logic lab=CLK
}
C {devices/lab_pin.sym} -260 -170 0 0 {name=p1 sig_type=std_logic lab=ib}
