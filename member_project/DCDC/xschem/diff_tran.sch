v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 700 180 720 180 {lab=#net1}
N 640 160 640 180 {lab=#net2}
N 640 160 720 160 {lab=#net2}
N 580 140 580 180 {lab=#net3}
N 580 140 720 140 {lab=#net3}
N 520 120 520 180 {lab=#net4}
N 400 80 400 180 {lab=#net5}
N 460 100 460 180 {lab=#net6}
N 400 80 720 80 {lab=#net5}
N 460 100 720 100 {lab=#net6}
N 520 120 720 120 {lab=#net4}
N 860 180 960 180 {lab=#net7}
N 860 60 860 80 {lab=out}
N 860 60 960 60 {lab=out}
N 960 60 960 120 {lab=out}
N 790 40 790 50 {lab=#net8}
N 340 40 790 40 {lab=#net8}
N 340 40 340 180 {lab=#net8}
N 340 240 880 240 {lab=GND}
N 790 210 790 240 {lab=GND}
C {devices/vsource.sym} 460 210 0 0 {name=Vinn value="DC 1" savecurrent=false}
C {devices/vsource.sym} 880 210 0 0 {name=Vinp value="pwl 0 0 100u 2 200u 0.9 210u 1.1 220u 0.9 230u 1.1 240u 0.9 250u 1.1 260u 0.9 270u 1.1 280u 0.9 290u 1.1 300u 0.9 310u 1.1 320u 0.9 330u 1.1 340u 0.9 350u 1.1 360u 0.9 370u 1.1 380u 0.9 390u 1.1 " savecurrent=false}
C {devices/vsource.sym} 340 210 0 0 {name=Vdd value=3.0 savecurrent=false}
C {devices/gnd.sym} 340 240 0 0 {name=l1 lab=GND}
C {devices/lab_pin.sym} 960 60 0 1 {name=p1 sig_type=std_logic lab=out}
C {devices/code.sym} -10 0 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/code_shown.sym} 0 150 0 0 {name=s1 only_toplevel=false value=".option savecurrents
.control
set units=degree
op
show m
save all
tran 10n 400u uic
plot v(out)
.endc"}
C {devices/isource.sym} 580 210 0 0 {name=I0 value=5u}
C {devices/res.sym} 900 90 0 0 {name=R1
value=100k
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} 900 150 0 0 {name=C1
m=1
value=10n
footprint=1206
device="ceramic capacitor"}
C {devices/capa.sym} 960 150 0 0 {name=C2
m=1
value=220p
footprint=1206
device="ceramic capacitor"}
C {devices/vsource.sym} 400 210 0 0 {name=Vb1 value=1.5 savecurrent=false}
C {devices/isource.sym} 640 210 0 0 {name=I1 value=5u}
C {devices/vsource.sym} 520 210 0 0 {name=Vb2 value=0.5 savecurrent=false}
C {devices/isource.sym} 700 210 0 0 {name=I2 value=5u}
C {pwm.sym} 790 130 0 0 {name=x1}
