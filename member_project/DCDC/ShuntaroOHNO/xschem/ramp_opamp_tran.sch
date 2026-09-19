v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 600 160 620 160 {lab=#net1}
N 540 140 540 160 {lab=#net2}
N 540 140 620 140 {lab=#net2}
N 480 100 620 100 {lab=#net3}
N 480 100 480 160 {lab=#net3}
N 420 80 620 80 {lab=#net4}
N 420 80 420 160 {lab=#net4}
N 700 20 700 50 {lab=#net5}
N 360 220 700 220 {lab=GND}
N 700 190 700 220 {lab=GND}
N 800 20 800 40 {lab=#net5}
N 360 20 800 20 {lab=#net5}
N 360 20 360 160 {lab=#net5}
N 800 100 800 120 {lab=#net6}
N 300 220 360 220 {lab=GND}
N 780 120 840 120 {lab=#net6}
N 840 160 840 200 {lab=#net7}
N 820 100 820 160 {lab=#net8}
N 820 100 840 100 {lab=#net8}
N 960 140 960 200 {lab=#net7}
N 840 200 960 200 {lab=#net7}
N 890 190 890 220 {lab=GND}
N 700 220 890 220 {lab=GND}
N 300 0 300 160 {lab=#net9}
N 300 -0 890 0 {lab=#net9}
N 890 0 890 90 {lab=#net9}
N 960 140 1000 140 {lab=#net7}
N 980 140 980 160 {lab=#net7}
N 890 220 980 220 {lab=GND}
N 1060 140 1100 140 {lab=out}
N 1080 140 1080 160 {lab=out}
N 980 220 1080 220 {lab=GND}
C {devices/code.sym} -10 0 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/code_shown.sym} 0 160 0 0 {name=s1 only_toplevel=false value=".option savecurrents
.control
save all
tran 100n 500u uic
plot v(out)
.endc"}
C {devices/vsource.sym} 360 190 0 1 {name=Vdd value="3" savecurrent=false}
C {devices/gnd.sym} 360 220 0 0 {name=l5 lab=GND}
C {ramp.sym} 700 140 0 0 {name=x1}
C {devices/vsource.sym} 600 190 0 0 {name=Vl value=0.5 savecurrent=false}
C {devices/vsource.sym} 540 190 0 0 {name=Vh value=1.5 savecurrent=false}
C {devices/isource.sym} 800 70 0 0 {name=Ic value=0.5u}
C {devices/isource.sym} 420 190 0 0 {name=Ib1 value=72u}
C {devices/isource.sym} 480 190 0 0 {name=Ib2 value=72u}
C {devices/lab_pin.sym} 1100 140 0 1 {name=p1 sig_type=std_logic lab=out}
C {devices/vsource.sym} 300 190 0 1 {name=Vdd1 value="3.5" savecurrent=false}
C {opamp_ramp.sym} 860 140 0 0 {name=x2}
C {devices/isource.sym} 820 190 0 1 {name=Ib3 value=72u}
C {devices/capa.sym} 980 190 0 0 {name=C1
m=1
value=30p
footprint=1206
device="ceramic capacitor"}
C {devices/res.sym} 1030 140 3 0 {name=R1
value=100
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} 1080 190 0 0 {name=C2
m=1
value=30p
footprint=1206
device="ceramic capacitor"}
