v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 150 -180 150 -100 {lab=VOUT_woC}
N 150 -40 150 0 {lab=0}
N 150 -290 150 -240 {lab=#net1}
N 150 -340 150 -290 {lab=#net1}
N 150 -450 150 -400 {lab=#net2}
N -210 -110 -210 0 {lab=0}
N -210 -0 -140 -0 {lab=0}
N -210 -450 -210 -170 {lab=#net2}
N -140 -50 -140 0 {lab=0}
N -140 -210 -140 -170 {lab=VIN}
N -140 -210 -90 -210 {lab=VIN}
N -90 -210 110 -210 {lab=VIN}
N 190 -210 190 0 {lab=0}
N 190 -450 190 -370 {lab=#net2}
N 150 -70 190 -70 {lab=0}
N 150 -210 190 -210 {lab=0}
N 150 -450 190 -450 {lab=#net2}
N -140 -0 150 -0 {lab=0}
N 150 -0 190 -0 {lab=0}
N 190 -0 380 -0 {lab=0}
N 260 -280 300 -280 {lab=#net2}
N 300 -450 300 -280 {lab=#net2}
N 150 -280 220 -280 {lab=#net1}
N 150 -140 260 -140 {lab=VOUT_woC}
N 260 -250 260 -140 {lab=VOUT_woC}
N 260 -140 290 -140 {lab=VOUT_woC}
N 350 -140 380 -140 {lab=VOUT}
N 380 -140 380 -100 {lab=VOUT}
N 380 -40 380 0 {lab=0}
N -210 -450 150 -450 {lab=#net2}
N 190 -450 300 -450 {lab=#net2}
N 260 -450 260 -310 {lab=#net2}
N 70 -370 110 -370 {lab=#net3}
N 30 -450 30 -400 {lab=#net2}
N 30 -340 30 -320 {lab=#net3}
N 30 -320 90 -320 {lab=#net3}
N 90 -370 90 -320 {lab=#net3}
N -40 -40 -40 -0 {lab=0}
N 0 -70 110 -70 {lab=#net4}
N -40 -120 -40 -100 {lab=#net4}
N -40 -450 -40 -180 {lab=#net2}
N 10 -110 10 -70 {lab=#net4}
N -40 -110 10 -110 {lab=#net4}
N 30 -320 30 -300 {lab=#net3}
N 30 -240 30 -0 {lab=0}
N -70 -70 -40 -70 {lab=0}
N -70 -70 -70 -0 {lab=0}
N -0 -370 30 -370 {lab=#net2}
N 0 -450 0 -370 {lab=#net2}
N 150 -370 190 -370 {lab=#net2}
C {devices/vsource.sym} -210 -140 0 0 {name=V1 value=5 savecurrent=false}
C {devices/gnd.sym} -170 0 0 0 {name=l1 lab=0}
C {devices/vsource.sym} -140 -140 0 0 {name=VIN value="sin(0 0.1 2k)" savecurrent=false}
C {devices/lab_pin.sym} 380 -140 2 0 {name=p1 sig_type=std_logic lab=VOUT}
C {devices/code.sym} -160 70 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/code_shown.sym} 0 70 0 0 {name=spice only_toplevel=false value="""
.option savecurrent
.control
op
show m
save all
*save @m.xm1.m1[gds]
save @m.xm3.m1[id]


*dc VIN 0 5.0 0.01
tran 0.01m 100m
plot VOUT_woC
plot VOUT
*plot VCM
plot @m.xm3.m1[id]

.endc
"""}
C {devices/res.sym} 380 -70 0 0 {name=R1
value=8
footprint=1206
device=resistor
m=1}
C {devices/lab_pin.sym} -140 -210 0 0 {name=p2 sig_type=std_logic lab=VIN}
C {devices/vsource.sym} -140 -80 0 0 {name=V2 value=2.5 savecurrent=false}
C {devices/lab_pin.sym} 260 -180 2 0 {name=p3 sig_type=std_logic lab=VOUT_woC}
C {devices/capa.sym} 320 -140 1 0 {name=C1
m=1
value=10u
footprint=1206
device="ceramic capacitor"}
C {MN.sym} 110 -210 0 0 {name=M1 model=NMOS w=20u l=1u nrd=0 nrs=0 m=16 spiceprefix=X}
C {MN.sym} 110 -70 0 0 {name=M3 model=NMOS w=20u l=2u nrd=0 nrs=0 m=16 spiceprefix=X}
C {MN.sym} 0 -70 0 1 {name=M6 model=NMOS w=20u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/isource.sym} -40 -150 0 0 {name=I0 value=400u}
C {devices/isource.sym} 30 -270 0 0 {name=I1 value=400u}
C {MP.sym} 70 -370 0 1 {name=M2 model=PMOS w=20u l=2u nrd=0 nrs=0 m=1 spiceprefix=X}
C {MP.sym} 110 -370 0 0 {name=M4 model=PMOS w=20u l=2u nrd=0 nrs=0 m=10 spiceprefix=X}
C {MP.sym} 220 -280 0 0 {name=M5 model=PMOS w=20u l=2u nrd=0 nrs=0 m=30 spiceprefix=X}
