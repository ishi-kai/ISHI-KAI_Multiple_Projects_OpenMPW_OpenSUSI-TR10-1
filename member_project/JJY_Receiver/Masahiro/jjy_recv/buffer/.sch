v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 270 70 330 70 {lab=#net1}
N 370 100 370 140 {lab=#net2}
N 370 140 460 140 {lab=#net2}
N 460 140 470 140 {lab=#net2}
N 470 100 470 140 {lab=#net2}
N 270 10 370 10 {lab=0}
N 370 10 370 40 {lab=0}
N 370 10 470 10 {lab=0}
N 470 10 470 40 {lab=0}
N 370 70 400 70 {lab=0}
N 400 30 400 70 {lab=0}
N 370 30 400 30 {lab=0}
C {devices/code.sym} -10 0 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {MP.sym} 330 70 0 0 {name=M1 model=PMOS w=3.4u l=1u nrd=0 nrs=0 m=1 spiceprefix=X}
C {devices/vsource.sym} 470 70 0 0 {name=V1 value=5 savecurrent=false}
C {devices/vsource.sym} 270 40 0 0 {name=V2 value=3 savecurrent=false}
C {devices/gnd.sym} 470 10 2 0 {name=l1 lab=0}
C {devices/code_shown.sym} 0 170 0 0 {name=s1 only_toplevel=false value="""
.option savecurrent
.control
save all
dc v2 0 5 0.01
plot i(v1)
.endc
"""

}
