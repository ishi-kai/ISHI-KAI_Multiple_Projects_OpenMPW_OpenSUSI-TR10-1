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
N 780 120 820 120 {lab=out}
N 800 100 800 120 {lab=out}
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
C {devices/lab_pin.sym} 820 120 0 1 {name=p1 sig_type=std_logic lab=out}
