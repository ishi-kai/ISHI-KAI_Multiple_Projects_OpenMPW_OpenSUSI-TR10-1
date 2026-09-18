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
N 40 -60 200 -60 {lab=GND}
N 200 -100 200 -60 {lab=GND}
N 120 -80 120 -60 {lab=GND}
N 40 -200 40 -60 {lab=GND}
N 40 -500 40 -260 {lab=#net1}
N 40 -500 220 -500 {lab=#net1}
N 220 -500 220 -480 {lab=#net1}
N 380 -300 400 -300 {lab=P_RDN_0}
N 380 -280 400 -280 {lab=P_RDN_1}
N 380 -260 400 -260 {lab=P_RDN_2}
N 380 -240 400 -240 {lab=P_RDN_3}
N 380 -200 400 -200 {lab=P_RDS_0}
N 380 -180 400 -180 {lab=P_RDS_1}
N 380 -160 400 -160 {lab=P_RDS_2}
N 380 -140 400 -140 {lab=P_RDS_3}
N 380 -360 400 -360 {lab=P_WRTN}
N 380 -340 400 -340 {lab=P_WRTS}
N 240 -500 240 -480 {lab=RES_B_O}
N 280 -100 280 -80 {lab=HD}
N 260 -500 260 -480 {lab=VCLK}
N 280 -500 280 -480 {lab=VD}
N 300 -500 300 -480 {lab=P_TX}
N 320 -500 320 -480 {lab=P_RES}
N 340 -500 340 -480 {lab=P_SEL}
C {2026_imager/tg.sym} 280 -280 0 0 {name=x1}
C {devices/vsource.sym} 120 -110 0 0 {name=Vclk value="pulse(0 5 \{0.5/fclk-100e-9\} 100n 100n \{0.5/fclk-100e-9\} \{1/fclk\})" savecurrent=false}
C {devices/vsource.sym} 80 -170 0 0 {name=Vresb value="pwl(0 0 \{5/fclk\} 0 \{5.1/fclk\} 5)" savecurrent=false}
C {devices/gnd.sym} 40 -60 0 0 {name=l1 lab=GND}
C {devices/vsource.sym} 40 -230 0 0 {name=Vdd value=5 savecurrent=false}
C {devices/lab_wire.sym} 160 -260 0 0 {name=p1 sig_type=std_logic lab=CLK}
C {devices/lab_wire.sym} 160 -300 0 0 {name=p2 sig_type=std_logic lab=RES_B}
C {devices/lab_wire.sym} 390 -300 0 1 {name=p3 sig_type=std_logic lab=P_RDN_0}
C {devices/lab_wire.sym} 390 -280 0 1 {name=p4 sig_type=std_logic lab=P_RDN_1}
C {devices/lab_wire.sym} 390 -260 0 1 {name=p5 sig_type=std_logic lab=P_RDN_2}
C {devices/lab_wire.sym} 390 -240 0 1 {name=p6 sig_type=std_logic lab=P_RDN_3}
C {devices/lab_wire.sym} 390 -200 0 1 {name=p7 sig_type=std_logic lab=P_RDS_0}
C {devices/lab_wire.sym} 390 -180 0 1 {name=p8 sig_type=std_logic lab=P_RDS_1}
C {devices/lab_wire.sym} 390 -160 0 1 {name=p9 sig_type=std_logic lab=P_RDS_2}
C {devices/lab_wire.sym} 390 -140 0 1 {name=p10 sig_type=std_logic lab=P_RDS_3}
C {devices/lab_wire.sym} 390 -360 0 1 {name=p11 sig_type=std_logic lab=P_WRTN}
C {devices/lab_wire.sym} 390 -340 0 1 {name=p12 sig_type=std_logic lab=P_WRTS}
C {devices/lab_wire.sym} 240 -490 3 1 {name=p13 sig_type=std_logic lab=RES_B_O}
C {devices/lab_wire.sym} 280 -90 1 1 {name=p14 sig_type=std_logic lab=HD}
C {devices/lab_wire.sym} 280 -490 3 1 {name=p15 sig_type=std_logic lab=VD}
C {devices/lab_wire.sym} 260 -490 3 1 {name=p16 sig_type=std_logic lab=VCLK}
C {devices/lab_wire.sym} 300 -490 3 1 {name=p17 sig_type=std_logic lab=P_TX}
C {devices/lab_wire.sym} 320 -490 3 1 {name=p18 sig_type=std_logic lab=P_RES}
C {devices/lab_wire.sym} 340 -490 3 1 {name=p19 sig_type=std_logic lab=P_SEL}
C {devices/code.sym} 10 40 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/code.sym} 190 40 0 0 {name=tran only_toplevel=false value="
.option savecurrents reltol=1e-4 klu
.temp 40
.param fclk = 1e6

.control
set units=degree
save all

alterparam vthMN = 0 ; Slow:0.1, Fast:-0.1
alterparam vthMP = 0 ; Slow:-0.1, Fast:0.1
reset

tran 512e-9 512e-6
write tb_tg.raw 
+ v(CLK) v(RES_B) v(RES_B_O) v(VD) v(HD) v(VCLK)
+ v(x1.d1) v(x1.d1_b) v(x1.ffout1)
+ v(x1.d2) v(x1.d2_b) v(x1.ffout2)
+ v(x1.d4) v(x1.d4_b) v(x1.ffout4)
+ v(x1.d8) v(x1.d8_b) v(x1.ffout8)
+ v(x1.d16) v(x1.d16_b) v(x1.ffout16)
+ v(x1.d32) v(x1.d32_b) v(x1.ffout32)
+ v(x1.d64) v(x1.d64_b) v(x1.ffout64)
+ v(x1.d128_b) v(x1.ffout128)
+ v(x1.d256_b) v(x1.ffout256)
+ v(x1.x22.r_b) v(x1.x22.f)
+ v(P_SEL) v(P_RES) v(P_TX)
+ v(P_WRTN) v(P_WRTS)
+ v(P_RDN_0) v(P_RDN_1) v(P_RDN_2) v(P_RDN_3)
+ v(P_RDS_0) v(P_RDS_1) v(P_RDS_2) v(P_RDS_3)
.endc"
}
