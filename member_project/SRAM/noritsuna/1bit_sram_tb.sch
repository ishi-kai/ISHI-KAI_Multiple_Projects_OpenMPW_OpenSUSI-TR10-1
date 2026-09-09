v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 250 -140 250 -80 {lab=VDD}
N 250 -60 290 -60 {lab=vbit_bar}
N 250 -40 290 -40 {lab=vbit}
N 250 -20 250 30 {lab=gnd}
N -100 -80 -50 -80 {lab=vword}
N -380 340 -380 380 {
lab=gnd}
N -380 250 -380 280 {
lab=VDD}
N -270 250 -270 280 {
lab=vword}
N -270 340 -270 380 {
lab=gnd}
N -140 300 -140 330 {
lab=vbit_in}
N -140 390 -140 430 {
lab=gnd}
N -40 360 -40 390 {
lab=vbit_in_bar}
N -40 450 -40 490 {
lab=gnd}
N 250 30 480 30 {lab=gnd}
N 480 30 530 30 {lab=gnd}
N 30 430 30 460 {
lab=vbit_en}
N 30 520 30 560 {
lab=gnd}
N 410 -230 410 -140 {lab=vbit_en}
N 410 -210 530 -210 {lab=vbit_en}
N 530 -210 530 -140 {lab=vbit_en}
N 410 -120 410 30 {lab=gnd}
N 290 -60 380 -60 {lab=vbit_bar}
N 530 -120 530 30 {lab=gnd}
N 380 -60 450 -60 {lab=vbit_bar}
N 450 -110 450 -60 {lab=vbit_bar}
N 290 -40 570 -40 {lab=vbit}
N 570 -110 570 -40 {lab=vbit}
N 380 20 380 30 {lab=gnd}
N 330 -0 330 30 {lab=gnd}
C {1bit_sram.sym} 100 -50 0 0 {name=x1}
C {devices/code.sym} -530 -310 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/vsource.sym} -380 310 0 0 {name=Vdd value=5.0 savecurrent=false}
C {devices/lab_pin.sym} -270 250 1 0 {name=p12 sig_type=std_logic lab=vword}
C {devices/vsource.sym} -270 310 0 0 {name=vword value="pwl 0 0  10m 0  15m 5.0  280m 5.0  285m 0" savecurrent=false}
C {devices/lab_pin.sym} -140 300 1 0 {name=p4 sig_type=std_logic lab=vbit_in}
C {devices/vsource.sym} -140 360 0 0 {name=vbit_in value="pwl 0 0  10m 0  15m 5.0  120m 5.0  125m 0  180m 0  280m 0" savecurrent=false}
C {devices/vsource.sym} -40 420 0 0 {name=vbit_in_bar value="pwl 0 0  10m 0  15m 0    120m 0    125m 5.0  185m 5.0  280m 5.0" savecurrent=false}
C {devices/lab_pin.sym} -40 360 1 0 {name=p8 sig_type=std_logic lab=vbit_in_bar}
C {devices/vdd.sym} -380 250 0 0 {name=l7 lab=VDD}
C {devices/gnd.sym} -380 380 0 0 {name=l3 lab=gnd}
C {devices/gnd.sym} -270 380 0 0 {name=l1 lab=gnd}
C {devices/gnd.sym} -140 430 0 0 {name=l2 lab=gnd}
C {devices/gnd.sym} -40 490 0 0 {name=l4 lab=gnd}
C {devices/vdd.sym} 250 -140 0 0 {name=l6 lab=VDD}
C {devices/gnd.sym} 250 30 0 0 {name=l8 lab=gnd}
C {devices/code_shown.sym} -510 -100 0 0 {name=spice only_toplevel=false value=".option savecurrent
.control
save all

* Tran analysis
tran 10m 300m
plot v(vbit) v(vbit_bar) v(vword)
write 1bit_sram_tb.raw
.endc"}
C {devices/lab_pin.sym} -100 -80 2 1 {name=p9 sig_type=std_logic lab=vword}
C {devices/lab_pin.sym} 290 -60 2 0 {name=p1 sig_type=std_logic lab=vbit_bar}
C {devices/lab_pin.sym} 290 -40 2 0 {name=p2 sig_type=std_logic lab=vbit}
C {devices/lab_pin.sym} 30 430 1 0 {name=p3 sig_type=std_logic lab=vbit_en}
C {devices/vsource.sym} 30 490 0 0 {name=vbit_en value="pwl 0 0  10m 0  15m 5.0  100m 5.0  105m 0  180m 0  185m 5.0  250m 5.0  255m 0" savecurrent=false}
C {devices/gnd.sym} 30 560 0 0 {name=l5 lab=gnd}
C {devices/lab_pin.sym} 410 -230 1 0 {name=p6 sig_type=std_logic lab=vbit_en}
C {devices/lab_pin.sym} 570 -170 1 0 {name=p5 sig_type=std_logic lab=vbit_in}
C {devices/lab_pin.sym} 450 -170 1 0 {name=p7 sig_type=std_logic lab=vbit_in_bar}
C {devices/switch_ngspice.sym} 450 -140 0 0 {name=S1 model=SW1
device_model=".MODEL SW1 SW
+ VT=2.5 VH=0.2
+ RON=1 ROFF=100Meg "}
C {devices/switch_ngspice.sym} 570 -140 0 0 {name=S2 model=SW1
device_model=".MODEL SW1 SW
+ VT=2.5 VH=0.2
+ RON=1 ROFF=100Meg "}
C {devices/capa.sym} 330 -30 0 0 {name=C1
m=1
value=100p
footprint=1206
device="ceramic capacitor"}
C {devices/capa.sym} 380 -10 0 0 {name=C2
m=1
value=100p
footprint=1206
device="ceramic capacitor"}
