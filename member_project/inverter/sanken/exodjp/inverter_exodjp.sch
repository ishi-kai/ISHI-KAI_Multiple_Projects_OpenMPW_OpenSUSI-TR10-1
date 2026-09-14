v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -40 -170 0 -170 {
lab=#net1}
N 0 -170 0 -70 {
lab=#net1}
N -40 -70 0 -70 {
lab=#net1}
N -110 -40 -80 -40 {
lab=vin}
N -110 -200 -110 -40 {
lab=vin}
N -110 -200 -80 -200 {
lab=vin}
N -180 -120 -110 -120 {
lab=vin}
N 0 -120 70 -120 {
lab=#net1}
N -40 -10 -40 40 {
lab=Vss}
N -40 -40 -30 -40 {
lab=Vss}
N -30 -40 -30 0 {
lab=Vss}
N -40 0 -30 0 {
lab=Vss}
N -40 -240 -30 -240 {
lab=Vdd}
N -30 -240 -30 -200 {
lab=Vdd}
N -40 -200 -30 -200 {
lab=Vdd}
N -40 -270 -40 -240 {
lab=Vdd}
N -40 -240 -40 -230 {
lab=Vdd}
C {MP.sym} -80 -200 0 0 {name=M1 model=PMOS w=3.4u l=1u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} -80 -40 0 0 {name=M2 model=NMOS w=3.4u l=1u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/iopin.sym} -40 -270 0 0 {name=p3 lab=Vdd}
C {devices/iopin.sym} -40 40 0 0 {name=p4 lab=Vss}
C {devices/ipin.sym} -180 -120 0 0 {name=p1 lab=vin}
C {devices/opin.sym} 70 -120 0 0 {name=p2 lab=vout}
