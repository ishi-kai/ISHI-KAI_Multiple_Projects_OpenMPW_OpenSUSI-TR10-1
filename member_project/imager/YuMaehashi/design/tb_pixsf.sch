v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 270 -320 440 -320 {lab=FD}
N 360 -410 360 -320 {lab=FD}
N 420 -220 440 -220 {lab=VDD}
N 420 -500 420 -220 {lab=VDD}
N 480 -290 480 -250 {lab=#net1}
N 480 -500 480 -350 {lab=VDD}
N 60 -500 480 -500 {lab=VDD}
N 360 -500 360 -470 {lab=VDD}
N 100 -440 320 -440 {lab=RG}
N 240 -380 240 -360 {lab=TG}
N 140 -380 240 -380 {lab=TG}
N 180 -320 210 -320 {lab=#net2}
N 180 -320 180 -100 {lab=#net2}
N 480 -50 480 -20 {lab=GND}
N 20 -20 500 -20 {lab=GND}
N 480 -320 500 -320 {lab=GND}
N 500 -440 500 -20 {lab=GND}
N 480 -220 500 -220 {lab=GND}
N 480 -190 480 -110 {lab=VL}
N 480 -80 500 -80 {lab=GND}
N 240 -320 240 -20 {lab=GND}
N 320 -50 320 -20 {lab=GND}
N 360 -80 440 -80 {lab=#net3}
N 300 -80 320 -80 {lab=GND}
N 300 -240 300 -20 {lab=GND}
N 320 -160 320 -110 {lab=#net3}
N 320 -140 380 -140 {lab=#net3}
N 380 -140 380 -80 {lab=#net3}
N 300 -240 320 -240 {lab=GND}
N 320 -240 320 -220 {lab=GND}
N 180 -40 180 -20 {lab=GND}
N 140 -380 140 -180 {lab=TG}
N 140 -120 140 -20 {lab=GND}
N 100 -220 100 -20 {lab=GND}
N 100 -440 100 -280 {lab=RG}
N 60 -40 60 -20 {lab=GND}
N 60 -500 60 -100 {lab=VDD}
N 360 -440 500 -440 {lab=GND}
C {TR-1umLIB/MN.sym} 440 -320 0 0 {name=XM1
model=NMOS
w=3.4u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MN.sym} 440 -220 0 0 {name=XM2
model=NMOS
w=3.4u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MN.sym} 320 -440 0 0 {name=XM3
model=NMOS
w=3.4u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MN.sym} 240 -360 1 0 {name=XM4
model=NMOS
w=3.4u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MN.sym} 440 -80 0 0 {name=XM5
model=NMOS
w=3.4u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MN.sym} 360 -80 0 1 {name=XM6
model=NMOS
w=3.4u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {devices/isource.sym} 320 -190 0 0 {name=I0 value=10u}
C {devices/vsource.sym} 180 -70 0 0 {name=Vpix value=2 savecurrent=false}
C {devices/vsource.sym} 140 -150 0 0 {name=Vtx value="dc 3 pulse(0 5 99.9u 100n 100n 90.9u 200u)" savecurrent=false}
C {devices/vsource.sym} 100 -250 0 0 {name=Vres value="dc 3 pulse(0 5 4.9u 100n 100n 90.9u 200u)" savecurrent=false}
C {devices/vsource.sym} 60 -70 0 0 {name=Vdd value=5 savecurrent=false}
C {devices/lab_wire.sym} 480 -140 0 0 {name=p1 sig_type=std_logic lab=VL}
C {devices/lab_wire.sym} 340 -320 0 0 {name=p2 sig_type=std_logic lab=FD}
C {devices/lab_wire.sym} 200 -380 0 0 {name=p3 sig_type=std_logic lab=TG}
C {devices/lab_wire.sym} 200 -440 0 0 {name=p4 sig_type=std_logic lab=RG}
C {devices/lab_wire.sym} 200 -500 0 0 {name=p5 sig_type=std_logic lab=VDD}
C {devices/gnd.sym} 20 -20 0 0 {name=l1 lab=GND}
C {devices/code.sym} 190 40 0 0 {name=tran only_toplevel=false value="
.option savecurrents
.control
set units=degree
save all

tran 10n 200u
write tb_pixsf.raw 
.endc"
}
C {devices/code.sym} 10 40 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
