v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 380 70 380 140 {lab=R}
N 320 30 380 30 {lab=S}
N 320 30 320 80 {lab=S}
N 440 100 440 200 {lab=GND}
N 260 0 440 0 {lab=#net1}
N 260 0 260 140 {lab=#net1}
N 320 140 320 200 {lab=GND}
N 260 200 440 200 {lab=GND}
C {devices/code.sym} -10 0 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/code_shown.sym} 0 160 0 0 {name=s1 only_toplevel=false value=".option savecurrents
.control
save all
tran 50n 60u uic
plot v(s) v(r) v(q)
.endc"}
C {prsr_latch.sym} 440 50 0 0 {name=x1}
C {devices/vsource.sym} 260 170 0 0 {name=V1 value=3 savecurrent=false}
C {devices/vsource.sym} 320 110 0 0 {name=V2 value="pwl 0 0 10u 0 10.1u 3 20u 3 20.1u 0 40u 0 40.1u 3 55u 3 55.1u 0" savecurrent=false}
C {devices/vsource.sym} 380 170 0 0 {name=V3 value="pwl 0 0 30u 0 30.1u 3 35u 3 35.1u 0 50u 0 50.1u 3" savecurrent=false}
C {devices/lab_pin.sym} 320 30 0 0 {name=p1 sig_type=std_logic lab=S}
C {devices/lab_pin.sym} 380 70 0 0 {name=p2 sig_type=std_logic lab=R}
C {devices/lab_pin.sym} 500 50 0 1 {name=p3 sig_type=std_logic lab=Q}
C {devices/gnd.sym} 260 200 0 0 {name=l1 lab=GND}
