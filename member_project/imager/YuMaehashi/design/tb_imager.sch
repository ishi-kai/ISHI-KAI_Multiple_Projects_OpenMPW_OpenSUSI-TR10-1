v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 120 -260 120 -140 {lab=CLK}
N 120 -260 180 -260 {lab=CLK}
N 80 -300 80 -200 {lab=RES_B}
N 80 -300 180 -300 {lab=RES_B}
N 80 -140 80 -60 {lab=GND}
N 40 -60 440 -60 {lab=GND}
N 220 -220 220 -60 {lab=GND}
N 120 -80 120 -60 {lab=GND}
N 40 -200 40 -60 {lab=GND}
N 40 -360 40 -260 {lab=#net1}
N 40 -360 240 -360 {lab=#net1}
N 220 -360 220 -340 {lab=#net1}
N 340 -300 440 -300 {lab=OUT}
N 340 -260 360 -260 {lab=HD_OUT}
N 240 -360 240 -340 {lab=#net1}
N 440 -300 440 -220 {lab=OUT}
N 440 -160 440 -60 {lab=GND}
C {devices/vsource.sym} 120 -110 0 0 {name=Vclk value="pulse(0 5 \{0.5/fclk-100e-9\} 100n 100n \{0.5/fclk-100e-9\} \{1/fclk\})" savecurrent=false}
C {devices/vsource.sym} 80 -170 0 0 {name=Vresb value="pwl(0 0 \{5/fclk\} 0 \{5.1/fclk\} 5)" savecurrent=false}
C {devices/gnd.sym} 40 -60 0 0 {name=l1 lab=GND}
C {devices/vsource.sym} 40 -230 0 0 {name=Vdd value=5 savecurrent=false}
C {devices/lab_wire.sym} 160 -260 0 0 {name=p1 sig_type=std_logic lab=CLK}
C {devices/lab_wire.sym} 160 -300 0 0 {name=p2 sig_type=std_logic lab=RES_B}
C {devices/lab_wire.sym} 350 -300 0 1 {name=p11 sig_type=std_logic lab=OUT}
C {devices/lab_wire.sym} 350 -260 0 1 {name=p12 sig_type=std_logic lab=HD_OUT}
C {devices/code.sym} 10 40 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/code.sym} 190 40 0 0 {name=tran only_toplevel=false value="
.option savecurrents reltol=1e-4 klu
.temp 40
.param fclk = 1e5

.control
set units=degree
save all

alterparam vthMN = 0 ; Slow:0.1, Fast:-0.1
alterparam vthMP = 0 ; Slow:-0.1, Fast:0.1
alterparam magCSIO = 1
reset

tran 512e-8 512e-5
write tb_imager.raw 
+ v(CLK) v(RES_B) v(OUT) v(HD_OUT)
+ v(x1.MEMOUT) v(x1.VL_0) v(x1.VL_1) v(x1.VL_2) v(x1.VL_3)
+ v(x1.P_WRTN) v(x1.P_WRTS)
+ v(x1.P_RDN_0) v(x1.P_RDN_1) v(x1.P_RDN_2) v(x1.P_RDN_3)
+ v(x1.P_RDS_0) v(x1.P_RDS_1) v(x1.P_RDS_2) v(x1.P_RDS_3)
+ v(x1.P_SEL_0) v(x1.P_SEL_1) v(x1.P_SEL_2) v(x1.P_SEL_3) 
+ v(x1.P_RES_0) v(x1.P_RES_1) v(x1.P_RES_2) v(x1.P_RES_3) 
+ v(x1.P_TX_0) v(x1.P_TX_1) v(x1.P_TX_2) v(x1.P_TX_3) 
+ v(x1.VD) v(x1.VCLK) v(x1.x4.VCLK_0)
+ v(x1.x6.x1.MEM_N) v(x1.x6.x2.MEM_N) v(x1.x6.x3.MEM_N) v(x1.x6.x4.MEM_N)
+ v(x1.x6.x1.MEM_S) v(x1.x6.x2.MEM_S) v(x1.x6.x3.MEM_S) v(x1.x6.x4.MEM_S)
.endc"
}
C {2026_imager/imager_for_test.sym} 260 -280 0 0 {name=x1}
C {devices/capa.sym} 440 -190 0 0 {name=C1
m=1
value=10p
footprint=1206
device="ceramic capacitor"}
