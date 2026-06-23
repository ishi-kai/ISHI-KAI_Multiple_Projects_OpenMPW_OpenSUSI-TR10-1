v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 0 -90 0 -50 {lab=VDD}
N -70 -160 -30 -160 {lab=VN}
N 30 -160 90 -160 {lab=VP}
N 90 -160 90 30 {lab=VP}
N -70 -160 -70 30 {lab=VN}
N -70 30 -70 110 {lab=VN}
N 90 30 90 110 {lab=VP}
N -70 170 -70 210 {lab=VSS}
N -70 210 0 210 {lab=VSS}
N 50 210 90 210 {lab=VSS}
N 90 170 90 210 {lab=VSS}
N -70 210 -70 240 {lab=VSS}
N -70 -260 -70 -160 {lab=VN}
N 90 -260 90 -160 {lab=VP}
N -60 -370 -30 -370 {lab=#net1}
N 30 -370 60 -370 {lab=#net2}
N -120 -300 -30 -300 {lab=VN}
N -120 -340 -120 -300 {lab=VN}
N 30 -300 120 -300 {lab=VP}
N 120 -340 120 -300 {lab=VP}
N -160 -260 -70 -260 {lab=VN}
N 90 -260 160 -260 {lab=VP}
N 90 210 190 210 {lab=VSS}
N 50 -90 190 -90 {lab=VDD}
N -0 -20 50 -20 {lab=VDD}
N 50 -90 50 -20 {lab=VDD}
N -0 30 0 40 {lab=VP}
N -40 30 -40 70 {lab=VN}
N -70 30 -40 30 {lab=VN}
N -0 30 90 30 {lab=VP}
N 0 100 0 210 {lab=VSS}
N 0 70 50 70 {lab=VSS}
N 50 70 50 210 {lab=VSS}
N -120 -370 -120 -340 {lab=VN}
N 120 -370 120 -340 {lab=VP}
N 0 -90 50 -90 {lab=VDD}
N -40 -20 -40 30 {lab=VN}
N 0 10 -0 30 {lab=VP}
N -0 210 50 210 {lab=VSS}
N -160 -330 -160 -260 {lab=VN}
N -160 -330 -120 -330 {lab=VN}
N 160 -330 160 -260 {lab=VP}
N 120 -330 160 -330 {lab=VP}
N 190 -90 190 -0 {lab=VDD}
N 190 60 190 210 {lab=VSS}
C {devices/res.sym} 0 -160 1 0 {name=R1
value=20000k
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} 90 140 0 0 {name=C1
m=1
value=12.5p
footprint=1206
device="ceramic capacitor"}
C {devices/capa.sym} -70 140 0 0 {name=C2
m=1
value=12.5p
footprint=1206
device="ceramic capacitor"}
C {devices/ipin.sym} -70 240 0 0 {name=p1 lab=VSS}
C {devices/ipin.sym} -70 -160 0 0 {name=p2 lab=VN}
C {devices/ipin.sym} 90 -160 2 0 {name=p3 lab=VP}
C {devices/ipin.sym} 0 -90 0 0 {name=p4 lab=VDD}
C {devices/ind.sym} -90 -370 1 0 {name=L1
m=1
value=7.9k
footprint=1206
device=inductor}
C {devices/capa.sym} 0 -370 1 0 {name=C3
m=1
value=2f
footprint=1206
device="ceramic capacitor"}
C {devices/res.sym} 90 -370 1 0 {name=R2
value=50k
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} 0 -300 1 0 {name=C4
m=1
value=0.8p
footprint=1206
device="ceramic capacitor"}
C {devices/code.sym} -330 -300 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/code_shown.sym} -500 -410 0 0 {name=spice only_toplevel=false value="""
.option savecurrent
*.options chgtol=1e-16 delmax=500n
*.options delmax=500n
.control
save all
tran 500n 0.5
plot VP VN
plot VN
.endc
"""}
C {devices/vsource.sym} 190 30 0 0 {name=V1 value="pwl(0 0 100n 5)" savecurrent=false}
C {devices/gnd.sym} -20 270 0 0 {name=l2 lab=0}
C {devices/res.sym} -20 240 0 0 {name=R3
value=0
footprint=1206
device=resistor
m=1}
C {MP.sym} -40 -20 0 0 {name=M1 model=PMOS w=12u l=10u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MN.sym} -40 70 0 0 {name=M2 model=NMOS w=4u l=10u nrd=0 nrs=0 m=1 spiceprefix=X}
