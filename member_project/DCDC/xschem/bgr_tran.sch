v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 580 110 600 110 {lab=#net1}
N 600 110 600 300 {lab=#net1}
N 580 130 660 130 {lab=#net2}
N 660 130 660 300 {lab=#net2}
N 580 170 720 170 {lab=#net3}
N 580 190 780 190 {lab=#net4}
N 580 210 840 210 {lab=#net5}
N 580 230 900 230 {lab=#net6}
N 580 270 960 270 {lab=#net7}
N 580 290 1020 290 {lab=#net8}
N 340 -20 340 300 {lab=#net9}
N 480 320 480 360 {lab=GND}
N 1020 -20 1020 230 {lab=#net9}
N 340 -20 1020 -20 {lab=#net9}
N 960 -20 960 210 {lab=#net9}
N 900 -20 900 170 {lab=#net9}
N 840 -20 840 150 {lab=#net9}
N 780 -20 780 130 {lab=#net9}
N 720 -20 720 110 {lab=#net9}
N 340 360 660 360 {lab=GND}
N 580 10 1040 10 {lab=v3v}
N 660 360 1040 360 {lab=GND}
N 1040 10 1040 300 {lab=v3v}
C {devices/code.sym} -10 0 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/code_shown.sym} 0 160 0 0 {name=s1 only_toplevel=false value=".option savecurrents
.control
save all
save @m.x1.xm20.m1[id]
tran 100n 200u uic
plot @m.x1.xm20.m1[id]
plot v(x1.x3out)
plot v(v3v) v(v1v5)*2 v(v1v)*3 v(v0v5)*6
plot i(v0u5a) i(v0u5b)
plot i(v72ua) i(v72ub) i(v72uc) i(v72ud)
plot i(v5ua) i(v5ub)
.endc"}
C {devices/vsource.sym} 340 330 0 0 {name=Vdd value="pwl 0 0 100u 5" savecurrent=false}
C {devices/gnd.sym} 340 360 0 0 {name=l5 lab=GND}
C {bgr.sym} 480 150 0 0 {name=x1}
C {devices/lab_pin.sym} 580 30 0 1 {name=p2 sig_type=std_logic lab=v1v5}
C {devices/lab_pin.sym} 580 50 0 1 {name=p3 sig_type=std_logic lab=v1v}
C {devices/lab_pin.sym} 580 70 0 1 {name=p4 sig_type=std_logic lab=v0v5}
C {devices/lab_pin.sym} 1040 10 0 1 {name=p1 sig_type=std_logic lab=v3v}
C {devices/vsource.sym} 600 330 0 0 {name=v0u5a value="0" savecurrent=false}
C {devices/vsource.sym} 660 330 0 0 {name=v0u5b value="0" savecurrent=false}
C {devices/vsource.sym} 720 140 0 0 {name=v72ua value="0" savecurrent=false}
C {devices/vsource.sym} 780 160 0 0 {name=v72ub value="0" savecurrent=false}
C {devices/vsource.sym} 840 180 0 0 {name=v72uc value="0" savecurrent=false}
C {devices/vsource.sym} 900 200 0 0 {name=v72ud value="0" savecurrent=false}
C {devices/vsource.sym} 960 240 0 0 {name=v5ua value="0" savecurrent=false}
C {devices/vsource.sym} 1020 260 0 0 {name=v5ub value="0" savecurrent=false}
C {devices/res.sym} 1040 330 0 0 {name=R1
value=3k
footprint=1206
device=resistor
m=1}
