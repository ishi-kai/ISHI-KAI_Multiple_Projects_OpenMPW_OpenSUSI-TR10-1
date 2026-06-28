v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -60 -40 -30 -40 {lab=#net1}
N 30 -40 60 -40 {lab=#net2}
N -120 30 -30 30 {lab=A}
N -120 -10 -120 30 {lab=A}
N 30 30 120 30 {lab=B}
N 120 -10 120 30 {lab=B}
N -120 -40 -120 -10 {lab=A}
N 120 -40 120 -10 {lab=B}
N -160 0 -120 0 {lab=A}
N 120 0 160 0 {lab=B}
C {devices/ind.sym} -90 -40 1 0 {name=L1
m=1
value=7.9k
footprint=1206
device=inductor}
C {devices/capa.sym} 0 -40 1 0 {name=C3
m=1
value=2f
footprint=1206
device="ceramic capacitor"}
C {devices/res.sym} 90 -40 1 0 {name=R2
value=50k
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} 0 30 1 0 {name=C4
m=1
value=0.8p
footprint=1206
device="ceramic capacitor"}
C {devices/iopin.sym} 160 0 0 0 {name=p1 lab=B}
C {devices/iopin.sym} -160 0 0 1 {name=p2 lab=A}
