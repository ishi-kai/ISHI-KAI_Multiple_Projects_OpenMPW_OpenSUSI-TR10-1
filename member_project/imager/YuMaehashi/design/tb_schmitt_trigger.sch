v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 20 -80 20 -40 {lab=GND}
N 80 -160 80 -140 {lab=IN}
N 80 -160 120 -160 {lab=IN}
N 20 -60 170 -60 {lab=GND}
N 170 -120 170 -60 {lab=GND}
N 80 -80 80 -60 {lab=GND}
N 20 -220 20 -140 {lab=#net1}
N 20 -220 170 -220 {lab=#net1}
N 170 -220 170 -200 {lab=#net1}
N 240 -160 280 -160 {lab=OUT}
N 280 -160 280 -140 {lab=OUT}
N 280 -80 280 -60 {lab=GND}
N 170 -60 280 -60 {lab=GND}
C {devices/code.sym} 10 40 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/code.sym} 190 40 0 0 {name=tran only_toplevel=false value="
.option savecurrents
.temp 40

.control
set units=degree
save all

alterparam vthMN = 0 ; Slow:0.1, Fast:-0.1
alterparam vthMP = 0 ; Slow:-0.1, Fast:0.1
reset

tran 1n 2u
plot v(IN) v(OUT)
.endc"
}
C {devices/vsource.sym} 80 -110 0 0 {name=Vin value="pwl(0 0 1u 5 2u 0)" savecurrent=false}
C {devices/gnd.sym} 20 -40 0 0 {name=l1 lab=GND}
C {devices/vsource.sym} 20 -110 0 0 {name=Vdd value=5 savecurrent=false}
C {2026_imager/schmitt_trigger.sym} 170 -160 0 0 {name=x31}
C {devices/capa.sym} 280 -110 0 0 {name=C1
m=1
value=0.1p
footprint=1206
device="ceramic capacitor"}
C {devices/lab_wire.sym} 100 -160 0 0 {name=p103 sig_type=std_logic lab=IN}
C {devices/lab_wire.sym} 260 -160 0 1 {name=p1 sig_type=std_logic lab=OUT}
