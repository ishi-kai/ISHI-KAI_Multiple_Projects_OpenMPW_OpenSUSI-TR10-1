v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -340 -120 -300 -120 {lab=vin}
N -260 -90 -260 -30 {lab=GND}
N -260 -90 -230 -90 {lab=GND}
N -230 -120 -230 -90 {lab=GND}
N -260 -120 -230 -120 {lab=GND}
N -260 -200 -230 -200 {lab=vout}
N -260 -150 -230 -150 {lab=vout}
N -340 -230 -300 -230 {lab=vin}
N -340 -230 -340 -120 {lab=vin}
N -340 -180 -340 -120 {lab=vin}
N -400 -180 -340 -180 {lab=vin}
N -230 -200 -230 -150 {lab=vout}
N -260 -230 -230 -230 {lab=#net1}
N -230 -260 -230 -230 {lab=#net1}
N -260 -260 -230 -260 {lab=#net1}
N -230 -180 -170 -180 {lab=vout}
N -170 -180 -170 -160 {lab=vout}
N -260 -280 -260 -260 {lab=#net1}
N -260 -370 -260 -340 {lab=VDD}
N -520 -120 -520 -100 {lab=vin}
N -170 -100 -170 -30 {lab=GND}
C {TR-1umLIB/MN.sym} -300 -120 0 0 {name=XM1
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
C {TR-1umLIB/MP.sym} -300 -230 0 0 {name=XM2
model=PMOS
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
C {devices/code.sym} -590 -320 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/vdd.sym} -260 -370 0 0 {name=l1 lab=VDD}
C {devices/gnd.sym} -260 -30 0 0 {name=l2 lab=GND}
C {devices/capa.sym} -170 -130 0 0 {name=Cload
m=1
value=10f
footprint=1206
device="ceramic capacitor"}
C {devices/vsource.sym} -520 -70 0 0 {name=vin value=5.0 savecurrent=false}
C {devices/vsource.sym} -580 -70 0 0 {name=Vdd value=5.0 savecurrent=false}
C {devices/vdd.sym} -580 -100 0 0 {name=l3 lab=VDD}
C {devices/gnd.sym} -580 -40 0 0 {name=l4 lab=GND}
C {devices/ammeter.sym} -260 -310 0 0 {name=Vd savecurrent=true spice_ignore=0}
C {devices/lab_pin.sym} -400 -180 0 0 {name=p2 sig_type=std_logic lab=vin
}
C {devices/lab_pin.sym} -520 -120 0 0 {name=p1 sig_type=std_logic lab=vin
}
C {devices/gnd.sym} -520 -40 0 0 {name=l5 lab=GND}
C {devices/lab_pin.sym} -170 -180 0 0 {name=p3 sig_type=std_logic lab=vout
}
C {devices/code_shown.sym} -90 -390 0 0 {name=spice
only_toplevel=false
format="tcleval( @value )"
value=".option savecurrent
.control
save all

* DC analysis (I/O curve)
dc vin 0 5.0 0.01
plot vout vin
plot i(vd)
wrdata ~/inverter_tb.txt v(vout)
write inverter_tb.raw
.endc"
}
C {devices/code_shown.sym} -80 -90 0 0 {name=measure
only_toplevel=false
format="tcleval( @value )"
value=".measure dc Vinv when v(vout)=2.5
"
}
C {devices/gnd.sym} -170 -30 0 0 {name=l6 lab=GND}
