v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
C {devices/vsource.sym} 100 210 0 0 {name=VINp value="DC 0 AC 1 sin(0 10u 40k 0 0 0)" savecurrent=false}
C {devices/gnd.sym} 100 240 0 0 {name=l3 lab=0}
C {devices/lab_pin.sym} 100 180 1 0 {name=p9 sig_type=std_logic lab=vcar}
C {devices/vsource.sym} 320 210 0 0 {name=V1 value="pulse(0 5 0 19.9m 0.1m 0 20m)" savecurrent=false}
C {devices/gnd.sym} 320 240 0 0 {name=l1 lab=0}
C {devices/lab_pin.sym} 320 180 1 0 {name=p1 sig_type=std_logic lab=vmod}
C {devices/gnd.sym} 510 240 0 0 {name=l2 lab=0}
C {devices/lab_pin.sym} 510 180 1 0 {name=p2 sig_type=std_logic lab=vsig
}
C {devices/code_shown.sym} -225 10 0 0 {name=s1 only_toplevel=false value="""
.option savecurrent
.control
set units = d
save all

tran 1u 100m
plot v(vcar)
plot v(vmod)
plot v(vsig)

.endc
"""}
C {devices/bsource.sym} 510 210 0 0 {name=B2 VAR=V FUNC="V(vmod) > 2.5? V(vcar):V(vcar)*0.01" m=1}
