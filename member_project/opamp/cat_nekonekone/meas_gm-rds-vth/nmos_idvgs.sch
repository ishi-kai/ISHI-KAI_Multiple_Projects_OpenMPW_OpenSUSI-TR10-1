v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 350 150 350 160 {
lab=#net1}
N 350 150 390 150 {
lab=#net1}
N 430 150 450 150 {
lab=GND}
N 450 150 450 200 {
lab=GND}
N 430 200 450 200 {
lab=GND}
N 430 180 430 200 {
lab=GND}
N 350 220 350 250 {
lab=GND}
N 350 230 570 230 {
lab=GND}
N 570 220 570 230 {
lab=GND}
N 430 200 430 230 {
lab=GND}
N 430 100 430 120 {
lab=#net2}
N 430 100 570 100 {
lab=#net2}
N 570 100 570 160 {
lab=#net2}
C {devices/vsource.sym} 350 190 0 0 {name=Vgs value=1.25}
C {devices/vsource.sym} 570 190 0 0 {name=Vds value=2.5}
C {devices/gnd.sym} 350 250 0 0 {name=l1 lab=GND}
C {devices/code_shown.sym} -140 40 0 0 {name=control only_toplevel=false value=".option savecurrent
.control
op
show m
save all
save @m.xm1.m1[gds]
save @m.xm1.m1[gm]
save @m.xm1.m1[vth]
dc vgs 0.01 5.0 0.01
plot -i(Vds)
plot @m.xm1.m1[gm]
.endc"}
C {MN.sym} 390 150 0 0 {name=M1 model=NMOS w=50u l=5u m=1 as=0 ad=0 ps=0 pd=0 nrd=0 nrs=0 spiceprefix=X}
C {devices/code.sym} -150 -110 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
