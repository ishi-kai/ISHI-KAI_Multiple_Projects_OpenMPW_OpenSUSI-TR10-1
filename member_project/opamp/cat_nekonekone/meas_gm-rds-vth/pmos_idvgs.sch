v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 20 -40 60 -40 {
lab=#net1}
N 100 -40 120 -40 {
lab=#net2}
N 100 -10 100 10 {
lab=GND}
N 100 10 100 40 {
lab=GND}
N 100 -90 100 -70 {
lab=#net2}
N 120 -90 120 -40 {
lab=#net2}
N 100 -90 120 -90 {
lab=#net2}
N 20 -130 20 -110 {
lab=#net2}
N 20 -130 240 -130 {
lab=#net2}
N 240 -130 240 -90 {
lab=#net2}
N 100 -130 100 -90 {
lab=#net2}
N 20 -50 20 -40 {
lab=#net1}
N 100 20 240 20 {
lab=GND}
N 240 -10 240 20 {
lab=GND}
N 240 -90 240 -70 {
lab=#net2}
C {devices/vsource.sym} 20 -80 0 0 {name=Vgs value=1.25
}
C {devices/vsource.sym} 240 -40 0 0 {name=Vds value=2.5}
C {devices/gnd.sym} 100 40 0 0 {name=l1 lab=GND}
C {devices/code_shown.sym} -450 -170 0 0 {name=control only_toplevel=false value=".option savecurrent
.control
op
show m
save all
save @m.xm1.m1[gds]
save @m.xm1.m1[gm]
save @m.xm1.m1[vth]
dc vgs 0 5.0 0.01
plot -i(Vds)
plot @m.xm1.m1[gm]
.endc"}
C {devices/code.sym} -460 -320 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {MP.sym} 60 -40 0 0 {name=M1 model=PMOS w=50u l=5u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0 spiceprefix=X}
