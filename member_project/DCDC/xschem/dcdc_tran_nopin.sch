v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 500 20 560 20 {lab=#net1}
N 500 100 560 100 {lab=#net2}
N 500 180 560 180 {lab=fb}
N 500 260 560 260 {lab=comp}
N 500 340 560 340 {lab=#net3}
N 500 420 560 420 {lab=#net3}
N 470 100 500 100 {lab=#net2}
N 470 40 470 100 {lab=#net2}
N 460 180 500 180 {lab=fb}
N 460 60 460 180 {lab=fb}
N 450 260 500 260 {lab=comp}
N 450 80 450 260 {lab=comp}
N 440 340 500 340 {lab=#net3}
N 440 100 440 340 {lab=#net3}
N 430 420 500 420 {lab=#net3}
N 430 120 430 420 {lab=#net3}
N 420 140 420 500 {lab=ss}
N 620 20 680 20 {lab=#net1}
N 620 340 660 340 {lab=#net3}
N 620 420 660 420 {lab=#net3}
N 660 340 660 420 {lab=#net3}
N 820 100 820 120 {lab=#net2}
N 620 100 840 100 {lab=#net2}
N 820 180 820 200 {lab=GND}
N 980 180 980 200 {lab=GND}
N 680 200 980 200 {lab=GND}
N 620 180 780 180 {lab=fb}
N 780 180 780 220 {lab=fb}
N 780 220 1040 220 {lab=fb}
N 1040 180 1040 220 {lab=fb}
N 1040 280 1040 300 {lab=GND}
N 980 200 980 300 {lab=GND}
N 980 300 1040 300 {lab=GND}
N 900 100 1040 100 {lab=out}
N 980 100 980 120 {lab=out}
N 1040 100 1040 120 {lab=out}
N 400 20 500 20 {lab=#net1}
N 400 40 470 40 {lab=#net2}
N 400 60 460 60 {lab=fb}
N 400 80 450 80 {lab=comp}
N 400 100 440 100 {lab=#net3}
N 400 120 430 120 {lab=#net3}
N 400 140 420 140 {lab=ss}
N 500 500 560 500 {lab=ss}
N 420 500 500 500 {lab=ss}
N 400 160 400 580 {lab=GND}
N 680 80 680 520 {lab=GND}
N 620 260 740 260 {lab=comp}
N 740 260 740 340 {lab=comp}
N 620 500 700 500 {lab=ss}
N 700 400 700 500 {lab=ss}
N 700 400 800 400 {lab=ss}
N 800 400 800 460 {lab=ss}
N 740 340 780 340 {lab=comp}
N 840 180 840 200 {lab=GND}
N 900 180 920 180 {lab=#net4}
N 920 160 920 180 {lab=#net4}
N 680 20 1100 20 {lab=#net1}
N 1100 80 1100 520 {lab=GND}
N 1100 20 1160 20 {lab=#net1}
N 1160 80 1160 520 {lab=GND}
N 680 520 680 580 {lab=GND}
N 720 520 720 580 {lab=GND}
N 800 520 800 580 {lab=GND}
N 1100 520 1100 580 {lab=GND}
N 1160 520 1160 580 {lab=GND}
N 560 20 620 20 {lab=#net1}
N 560 100 620 100 {lab=#net2}
N 560 180 620 180 {lab=fb}
N 560 260 620 260 {lab=comp}
N 560 340 620 340 {lab=#net3}
N 560 420 620 420 {lab=#net3}
N 560 500 620 500 {lab=ss}
N 400 580 1160 580 {lab=GND}
C {dcdc.sym} 330 90 0 0 {name=x1}
C {devices/vsource.sym} 680 50 0 0 {name=V1 value="pwl 0 0 100u 6" savecurrent=false}
C {devices/code.sym} -10 0 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/code_shown.sym} 0 150 0 0 {name=s1 only_toplevel=false value=".include SS14.spice.txt
.control
save v(out) v(ss) v(fb) v(comp) v(x1.v1v)
tran 20n 30m uic
plot v(out) v(ss) v(fb) v(comp)
plot v(x1.v1v)
.endc"}
C {devices/gnd.sym} 400 580 0 0 {name=l2 lab=GND}
C {devices/diode.sym} 820 150 2 0 {name=D1 model=SS14 area=1}
C {devices/ind.sym} 870 100 3 0 {name=Lout
m=1
value=470u
footprint=1206
device=inductor}
C {devices/capa.sym} 920 130 0 0 {name=Cout
m=1
value=47u
footprint=1206
device="ceramic capacitor"}
C {devices/res.sym} 980 150 0 0 {name=Rout
value=100
footprint=1206
device=resistor
m=1}
C {devices/res.sym} 1040 150 0 0 {name=Rt
value=100k
footprint=1206
device=resistor
m=1}
C {devices/res.sym} 1040 250 0 0 {name=Rb
value=100k
footprint=1206
device=resistor
m=1}
C {devices/res.sym} 780 310 0 0 {name=Rc
value=22k
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} 780 250 0 0 {name=Cc
m=1
value=10n
footprint=1206
device="ceramic capacitor"}
C {devices/capa.sym} 720 430 0 0 {name=Css
m=1
value=1n
footprint=1206
device="ceramic capacitor"}
C {devices/res.sym} 720 490 0 0 {name=Rss
value=1.5Meg
footprint=1206
device=resistor
m=1}
C {devices/res.sym} 800 490 0 0 {name=Rst
value=3Meg
footprint=1206
device=resistor
m=1}
C {devices/lab_pin.sym} 1040 100 0 1 {name=p1 sig_type=std_logic lab=out}
C {devices/lab_pin.sym} 1040 220 0 1 {name=p2 sig_type=std_logic lab=fb}
C {devices/lab_pin.sym} 740 340 0 0 {name=p3 sig_type=std_logic lab=comp}
C {devices/lab_pin.sym} 800 400 0 1 {name=p4 sig_type=std_logic lab=ss}
C {devices/res.sym} 870 180 1 1 {name=Rout1
value=100m
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} 1100 50 0 0 {name=Cin
m=1
value=10u
footprint=1206
device="ceramic capacitor"}
C {devices/capa.sym} 1160 50 0 0 {name=Cin1
m=1
value=0.1u
footprint=1206
device="ceramic capacitor"}
