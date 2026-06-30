v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 40 -340 40 -120 {lab=#net1}
N 40 -340 220 -340 {lab=#net1}
N 220 -340 220 -320 {lab=#net1}
N 40 -60 40 -40 {lab=GND}
N 40 -40 220 -40 {lab=GND}
N 220 -200 220 -40 {lab=GND}
N 40 -40 40 -20 {lab=GND}
N 100 -60 100 -40 {lab=GND}
N 100 -260 100 -120 {lab=VIN}
N 100 -260 180 -260 {lab=VIN}
N 340 -260 440 -260 {lab=VOUT}
N 440 -260 440 -220 {lab=VOUT}
N 440 -60 440 -40 {lab=GND}
N 220 -40 440 -40 {lab=GND}
N -60 -240 -40 -240 {lab=#net2}
N -40 -360 -40 -240 {lab=#net2}
N -40 -360 240 -360 {lab=#net2}
N 240 -360 240 -320 {lab=#net2}
N -340 -340 40 -340 {lab=#net1}
N -340 -340 -340 -320 {lab=#net1}
N -140 -340 -140 -320 {lab=#net1}
N -340 -40 40 -40 {lab=GND}
N -340 -200 -340 -40 {lab=GND}
N -140 -200 -140 -40 {lab=GND}
N -220 -280 -180 -280 {lab=#net3}
N 440 -160 440 -120 {lab=#net4}
C {devices/code.sym} 10 40 0 0 {name=dc only_toplevel=false value="
.option savecurrents
.temp 80
.param vdd = 4.5
.param vin = vdd/2
.control
set units=degree
save all

alterparam vthMN = 0.1 ; Slow:0.1, Fast:-0.1
alterparam vthMP = -0.1 ; Slow:-0.1, Fast:0.1
alterparam magRS = 1.2 ; Slow:1.2, Fast:0.85
reset

op
show m

dc VIN 0 4.5 0.1
plot v(VIN) v(VOUT)
plot v(VOUT) - v(VIN)


.endc"
}
C {devices/code.sym} -170 40 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/vsource.sym} 40 -90 0 0 {name=VDD value="vdd" savecurrent=false}
C {devices/gnd.sym} 40 -20 0 0 {name=l1 lab=GND}
C {devices/vsource.sym} 100 -90 0 0 {name=VIN value="dc vin ac 1 0" savecurrent=false}
C {devices/capa.sym} 440 -90 0 0 {name=C1
m=1
value=1000p
footprint=1206
device="ceramic capacitor"}
C {devices/lab_wire.sym} 440 -260 0 1 {name=p1 sig_type=std_logic lab=VOUT}
C {2026_book/bgr_b.sym} -300 -260 0 0 {name=x2}
C {2026_book/ibuf.sym} -120 -260 0 0 {name=x3}
C {devices/lab_wire.sym} 160 -260 0 0 {name=p2 sig_type=std_logic lab=VIN}
C {2026_book/psf.sym} 260 -260 0 0 {name=x1}
C {devices/code.sym} 130 40 0 0 {name=ac only_toplevel=false value="
.option savecurrents
.temp 0
.param vdd = 5
.param vin = vdd/2
.control
set units=degree
save all

alterparam vthMN = 0 ; Slow:0.1, Fast:-0.1
alterparam vthMP = 0 ; Slow:-0.1, Fast:0.1
alterparam magRS = 1 ; Slow:1.2, Fast:0.85
reset

ac dec 10 1 100meg
plot vdb(VOUT)
plot phase(VOUT)

.endc"
spice_ignore=true}
C {devices/ind.sym} 440 -190 0 0 {name=L2
m=1
value=10n
footprint=1206
device=inductor}
