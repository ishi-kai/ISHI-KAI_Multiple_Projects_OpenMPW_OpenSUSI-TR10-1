v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 210 50 210 60 {lab=0}
N 210 30 210 50 {lab=0}
N 210 0 230 0 {lab=0}
N 230 0 230 40 {lab=0}
N 210 40 230 40 {lab=0}
N 210 60 210 80 {lab=0}
N 130 0 130 20 {lab=#net1}
N 130 0 170 0 {lab=#net1}
N 210 -70 210 -30 {lab=#net2}
N 210 -70 290 -70 {lab=#net2}
N 290 -70 290 20 {lab=#net2}
C {MN.sym} 170 0 0 0 {name=M1 model=NMOS w=40u l=4u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/gnd.sym} 210 80 0 0 {name=l1 lab=0}
C {devices/gnd.sym} 130 80 0 0 {name=l2 lab=0}
C {devices/gnd.sym} 290 80 0 0 {name=l3 lab=0}
C {devices/vsource.sym} 130 50 0 0 {name=V1 value=1 savecurrent=false}
C {devices/vsource.sym} 290 50 0 0 {name=V2 value=2.5 savecurrent=false}
C {devices/code.sym} -260 180 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/code_shown.sym} -290 -210 0 0 {name=spice only_toplevel=false value="""
.option savecurrent
.control
op
show m
save all
save @m.xm1.m1[gds]
save @m.xm1.m1[gm]
save @m.xm1.m1[vth]
dc v1 0 5.0 0.01
plot -i(v2)
plot @m.xm1.m1[gm]
plot @m.xm1.m1[gds]
*plot @m.xm1.m1[gm]/@m.xm1.m1[gds]
dc v2 0 5.0 0.01 v1 1.0 2.0 0.2
plot -i(v2)
.endc
"""}
