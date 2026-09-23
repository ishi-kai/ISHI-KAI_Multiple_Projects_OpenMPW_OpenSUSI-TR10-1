v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -80 -140 -80 -120 {lab=#net1}
N -80 -140 80 -140 {lab=#net1}
N 80 -140 80 -120 {lab=#net1}
N -140 -90 -120 -90 {lab=vin}
N -140 -90 -140 -40 {lab=vin}
N -140 -40 20 -40 {lab=vin}
N 20 -90 20 -40 {lab=vin}
N 20 -90 40 -90 {lab=vin}
N -80 -90 -50 -90 {lab=#net1}
N -50 -140 -50 -90 {lab=#net1}
N 80 -90 110 -90 {lab=#net1}
N 110 -140 110 -90 {lab=#net1}
N 80 -140 110 -140 {lab=#net1}
N -80 -60 -80 -20 {lab=vout}
N -80 -20 80 -20 {lab=vout}
N 80 -60 80 -20 {lab=vout}
N -80 20 -80 60 {lab=vout}
N -80 20 80 20 {lab=vout}
N 80 20 80 60 {lab=vout}
N -140 90 -120 90 {lab=vin}
N -140 40 -140 90 {lab=vin}
N -140 40 20 40 {lab=vin}
N 20 40 20 90 {lab=vin}
N 20 90 40 90 {lab=vin}
N -80 120 -80 140 {lab=GND}
N -80 140 80 140 {lab=GND}
N 80 120 80 140 {lab=GND}
N -80 90 -50 90 {lab=GND}
N -50 90 -50 140 {lab=GND}
N 80 90 110 90 {lab=GND}
N 110 90 110 140 {lab=GND}
N 80 140 110 140 {lab=GND}
N 0 140 0 180 {lab=GND}
N 0 -180 -0 -140 {lab=#net1}
N -0 -20 0 20 {lab=vout}
N 0 -0 180 0 {lab=vout}
N -160 60 -140 60 {lab=vin}
N -160 -60 -160 60 {lab=vin}
N -160 -60 -140 -60 {lab=vin}
N -200 -0 -160 0 {lab=vin}
N -390 80 -390 90 {lab=VDD}
N -390 150 -390 160 {lab=GND}
N -320 150 -320 160 {lab=GND}
N -320 60 -320 90 {lab=vin}
N 0 -250 0 -240 {lab=VDD}
N 180 100 180 140 {lab=GND}
N 180 0 180 40 {lab=vout}
C {TR-1umLIB/MP.sym} 40 -90 0 0 {name=XM1
model=PMOS
w=8.2u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MN.sym} 40 90 0 0 {name=XM2
model=NMOS
w=3.4u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MP.sym} -120 -90 0 0 {name=XM3
model=PMOS
w=8.2u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MN.sym} -120 90 0 0 {name=XM4
model=NMOS
w=3.4u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {devices/code.sym} -420 -170 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/vsource.sym} -390 120 0 0 {name=Vdd value=5.0 savecurrent=false}
C {devices/vdd.sym} -390 80 0 0 {name=l3 lab=VDD}
C {devices/gnd.sym} -390 160 0 0 {name=l4 lab=GND}
C {devices/gnd.sym} -320 160 0 0 {name=l5 lab=GND}
C {devices/lab_pin.sym} -320 60 0 0 {name=p5 sig_type=std_logic lab=vin}
C {devices/vdd.sym} 0 -250 0 0 {name=l1 lab=VDD}
C {devices/ammeter.sym} 0 -210 0 0 {name=Vd savecurrent=true spice_ignore=0}
C {devices/lab_pin.sym} 180 0 2 0 {name=p2 sig_type=std_logic lab=vout}
C {devices/gnd.sym} 180 140 0 0 {name=l6 lab=GND}
C {devices/lab_pin.sym} -200 0 0 0 {name=p1 sig_type=std_logic lab=vin}
C {devices/gnd.sym} 0 180 0 0 {name=l2 lab=GND}
C {devices/code_shown.sym} 260 -180 0 0 {name=spice only_toplevel=false value=".option savecurrent
.control
save all

* Tran analysis
tran 0.3n 300n
plot vout vin
plot i(vd)
wrdata ~/inverter_tb_tran.txt v(vout)
write inverter_tb_trans.raw
.endc"}
C {devices/code_shown.sym} 260 70 0 0 {name=measure only_toplevel=false value="
.measure tran td_r trig v(vin) val=2.5 fall=1 targ v(vout) val=2.5 rise=1
.measure tran td_f trig v(vin) val=2.5 rise=1 targ v(vout) val=2.5 fall=1
.measure tran trise trig v(vout) val=0.83 rise=1 targ v(vout) val=4.17 rise=1
.measure tran tfall trig v(vout) val=4.17 fall=1 targ v(vout) val=0.83 fall=1
"}
C {devices/capa.sym} 180 70 0 0 {name=Cload1
m=1
value=40p
footprint=1206
device="ceramic capacitor"}
C {devices/vsource.sym} -320 120 0 0 {name=vin1 value="pwl 0 0 10n 0 10.1n 5 150n 5 150.1n 0" savecurrent=false}
