v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -340 -120 -300 -120 {lab=A}
N -260 -90 -260 -30 {lab=VSS}
N -260 -90 -230 -90 {lab=VSS}
N -230 -120 -230 -90 {lab=VSS}
N -260 -120 -230 -120 {lab=VSS}
N -260 -200 -230 -200 {lab=Q}
N -260 -150 -230 -150 {lab=Q}
N -340 -230 -300 -230 {lab=A}
N -340 -230 -340 -120 {lab=A}
N -340 -180 -340 -120 {lab=A}
N -400 -180 -340 -180 {lab=A}
N -230 -200 -230 -150 {lab=Q}
N -230 -180 -190 -180 {lab=Q}
N -260 -230 -230 -230 {lab=VDD}
N -230 -260 -230 -230 {lab=VDD}
N -260 -260 -230 -260 {lab=VDD}
N -260 -310 -260 -260 {lab=VDD}
C {TR-1umLIB/MN.sym} -300 -120 0 0 {name=XM1
model=NMOS
w=54.4u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MP.sym} -300 -230 0 0 {name=XM2
model=PMOS
w=163.2u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {devices/ipin.sym} -400 -180 0 0 {name=p1 lab=A}
C {devices/opin.sym} -190 -180 0 0 {name=p3 lab=Q}
C {devices/iopin.sym} -260 -30 0 0 {name=p2 lab=VSS}
C {devices/iopin.sym} -260 -310 0 0 {name=p4 lab=VDD}
