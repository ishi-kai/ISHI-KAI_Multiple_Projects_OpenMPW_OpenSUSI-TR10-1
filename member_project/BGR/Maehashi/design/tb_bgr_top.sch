v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 40 -60 40 -40 {lab=GND}
N 40 -40 620 -40 {lab=GND}
N 40 -40 40 -20 {lab=GND}
N 100 -60 100 -40 {lab=GND}
N 400 -260 440 -260 {lab=VOUT_int}
N 440 -260 440 -220 {lab=VOUT_int}
N 440 -60 440 -40 {lab=GND}
N 440 -160 440 -120 {lab=VOUT}
N 400 -300 540 -300 {lab=IOUT_int}
N 540 -300 540 -220 {lab=IOUT_int}
N 540 -60 540 -40 {lab=GND}
N 160 -80 160 -40 {lab=GND}
N 100 -300 100 -120 {lab=SEL1}
N 160 -260 160 -140 {lab=SEL0}
N 240 -220 240 -40 {lab=GND}
N 40 -340 40 -120 {lab=VDD}
N 40 -340 240 -340 {lab=VDD}
N 160 -260 200 -260 {lab=SEL0}
N 100 -300 200 -300 {lab=SEL1}
N 540 -160 540 -120 {lab=IOUT}
N 540 -140 620 -140 {lab=IOUT}
N 620 -140 620 -120 {lab=IOUT}
N 620 -60 620 -40 {lab=GND}
C {devices/code.sym} 10 40 0 0 {name=tran only_toplevel=false value="
.option savecurrents
.temp 40
.param vdd = 5
.control
set units=degree
save all

alterparam vthMN = 0 ; Slow:0.1, Fast:-0.1
alterparam vthMP = 0 ; Slow:-0.1, Fast:0.1
alterparam magRS = 1 ; Slow:1.2, Fast:0.85
reset

tran 10n 200u
plot v(SEL1) v(SEL0) 
*plot v(x1.x5.sel0i) v(x1.x5.sel1i) v(x1.x5.in0sel) v(x1.x5.in1sel) v(x1.x5.in2sel)
plot v(VOUT) v(x1.bgr_a_out) v(x1.bgr_b_out)
plot v(IOUT)
.endc"
}
C {devices/code.sym} -170 40 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/vsource.sym} 40 -90 0 0 {name=VDD value="vdd" savecurrent=false}
C {devices/gnd.sym} 40 -20 0 0 {name=l1 lab=GND}
C {devices/vsource.sym} 100 -90 0 0 {name=VSEL1 value="dc 0 pulse(0 vdd 99.9u 0.1u 0.1u 99.9u 200u)" savecurrent=false}
C {devices/capa.sym} 440 -90 0 0 {name=C1
m=1
value=100p
footprint=1206
device="ceramic capacitor"}
C {devices/lab_wire.sym} 420 -260 0 1 {name=p1 sig_type=std_logic lab=VOUT_int}
C {devices/ind.sym} 440 -190 0 0 {name=L2
m=1
value=10n
footprint=1206
device=inductor}
C {2026_book/bgr_top.sym} 300 -280 0 0 {name=x1}
C {devices/res.sym} 620 -90 0 0 {name=R1
value=10k
footprint=1206
device=resistor
m=1}
C {devices/vsource.sym} 160 -110 0 0 {name=VSEL0 value="dc 0 pulse(0 vdd 49.9u 0.1u 0.1u 49.9u 100u)" savecurrent=false}
C {devices/lab_wire.sym} 420 -300 0 1 {name=p3 sig_type=std_logic lab=IOUT_int}
C {devices/lab_wire.sym} 220 -340 0 0 {name=p4 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} 180 -300 0 0 {name=p2 sig_type=std_logic lab=SEL1}
C {devices/lab_wire.sym} 180 -260 0 0 {name=p5 sig_type=std_logic lab=SEL0}
C {devices/ind.sym} 540 -190 0 0 {name=L3
m=1
value=10n
footprint=1206
device=inductor}
C {devices/capa.sym} 540 -90 0 0 {name=C2
m=1
value=100p
footprint=1206
device="ceramic capacitor"}
C {devices/lab_wire.sym} 620 -140 0 1 {name=p6 sig_type=std_logic lab=IOUT}
C {devices/lab_wire.sym} 440 -140 0 1 {name=p7 sig_type=std_logic lab=VOUT}
