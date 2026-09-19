v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 580 120 580 160 {lab=out}
N 580 160 700 160 {lab=out}
N 700 100 700 160 {lab=out}
N 340 60 580 60 {lab=#net1}
N 340 60 340 120 {lab=#net1}
N 400 80 580 80 {lab=in}
N 400 80 400 120 {lab=in}
N 280 180 720 180 {lab=GND}
N 280 40 280 120 {lab=#net2}
N 280 40 630 40 {lab=#net2}
N 630 40 630 50 {lab=#net2}
N 700 100 720 100 {lab=out}
N 720 100 720 120 {lab=out}
N 630 150 630 180 {lab=GND}
C {devices/code.sym} -10 0 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/code_shown.sym} 0 160 0 0 {name=s1 only_toplevel=false value=".option savecurrents
.control
op
show m
save all
tran 10n 50u
plot v(in) v(out)
.endc"}
C {devices/vsource.sym} 400 150 0 0 {name=V1 value="pulse 0.5 1.5 0 10u 0.1u 10n 10.11u" savecurrent=false}
C {devices/gnd.sym} 280 180 0 0 {name=l2 lab=GND}
C {devices/vsource.sym} 280 150 0 0 {name=Vdd value=3.5 savecurrent=false}
C {devices/isource.sym} 340 150 0 0 {name=I1 value=72u}
C {devices/capa.sym} 720 150 0 0 {name=C1
m=1
value=20p
footprint=1206
device="ceramic capacitor"}
C {devices/lab_pin.sym} 720 100 0 1 {name=p1 sig_type=std_logic lab=out}
C {opamp_ramp.sym} 600 100 0 0 {name=x1}
C {devices/lab_pin.sym} 400 100 0 1 {name=p2 sig_type=std_logic lab=in}
