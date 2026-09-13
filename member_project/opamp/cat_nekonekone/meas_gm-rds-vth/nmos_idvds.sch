v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 390 190 390 200 {
lab=#net1}
N 390 190 430 190 {
lab=#net1}
N 470 190 490 190 {
lab=GND}
N 490 190 490 240 {
lab=GND}
N 470 240 490 240 {
lab=GND}
N 470 220 470 240 {
lab=GND}
N 390 260 390 290 {
lab=GND}
N 390 270 610 270 {
lab=GND}
N 610 260 610 270 {
lab=GND}
N 470 240 470 270 {
lab=GND}
N 470 140 470 160 {
lab=#net2}
N 470 140 610 140 {
lab=#net2}
N 610 140 610 200 {
lab=#net2}
C {devices/vsource.sym} 390 230 0 0 {name=Vgs value=1.25}
C {devices/vsource.sym} 610 230 0 0 {name=Vds value=2.5}
C {devices/gnd.sym} 390 290 0 0 {name=l1 lab=GND}
C {devices/code_shown.sym} -100 70 0 0 {name=control only_toplevel=false value=".option savecurrent
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
C {devices/code.sym} -110 -80 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {MN.sym} 430 190 0 0 {name=M1 model=NMOS w=50u l=5u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0 spiceprefix=X}
