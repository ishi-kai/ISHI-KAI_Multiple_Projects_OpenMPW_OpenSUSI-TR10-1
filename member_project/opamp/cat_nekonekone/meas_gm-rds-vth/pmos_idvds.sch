v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 90 -10 130 -10 {
lab=#net1}
N 170 -10 190 -10 {
lab=#net2}
N 170 20 170 40 {
lab=GND}
N 170 40 170 70 {
lab=GND}
N 170 -60 170 -40 {
lab=#net2}
N 190 -60 190 -10 {
lab=#net2}
N 170 -60 190 -60 {
lab=#net2}
N 90 -100 90 -80 {
lab=#net2}
N 90 -100 310 -100 {
lab=#net2}
N 310 -100 310 -60 {
lab=#net2}
N 170 -100 170 -60 {
lab=#net2}
N 90 -20 90 -10 {
lab=#net1}
N 170 50 310 50 {
lab=GND}
N 310 20 310 50 {
lab=GND}
N 310 -60 310 -40 {
lab=#net2}
C {devices/vsource.sym} 90 -50 0 0 {name=Vgs value=1.25}
C {devices/vsource.sym} 310 -10 0 0 {name=Vds value=2.5}
C {devices/gnd.sym} 170 70 0 0 {name=l1 lab=GND}
C {devices/code_shown.sym} -260 -100 0 0 {name=control only_toplevel=false value=".option savecurrent
.control
op
show m
save all
save @m.xm1.m1[gds]
save @m.xm1.m1[gm]
save @m.xm1.m1[vth]
dc vds 0.01 5.0 0.01
plot -i(Vds)
plot @m.xm1.m1[vth]
plot 1/@m.xm1.m1[gds]
plot @m.xm1.m1[gm]
.endc"}
C {MP.sym} 130 -10 0 0 {name=M1 model=PMOS w=50u l=5u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0 spiceprefix=X}
C {devices/code.sym} -270 -250 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
