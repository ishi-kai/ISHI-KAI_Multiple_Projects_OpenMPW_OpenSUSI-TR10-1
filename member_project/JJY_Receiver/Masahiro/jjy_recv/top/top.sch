v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 340 270 390 270 {lab=#net1}
N 340 310 390 310 {lab=#net2}
N 540 50 610 50 {lab=#net3}
N 610 50 610 120 {lab=#net3}
N 570 160 610 120 {lab=#net3}
N 570 160 570 210 {lab=#net3}
N 610 160 610 210 {lab=#net4}
N 570 120 610 160 {lab=#net4}
N 570 70 570 120 {lab=#net4}
N 540 70 570 70 {lab=#net4}
N 490 170 490 210 {lab=ib40u}
N 150 170 490 170 {lab=ib40u}
N 260 170 260 230 {lab=ib40u}
N 440 -20 440 20 {lab=XTALN}
N 470 -20 470 20 {lab=XTALP}
N 70 50 90 50 {lab=VDD}
N 70 80 90 80 {lab=VSS}
N 170 150 170 170 {lab=ib40u}
N 70 110 90 110 {lab=Vb}
N 150 270 180 270 {lab=vinn}
N 150 310 180 310 {lab=vinp}
C {/home/ishi-kai/ISHI-KAI_Multiple_Projects_OpenMPW_OpenSUSI-TR10-1/member_project/JJY_Receiver/Masahiro/jjy_recv/gilbert_cell/gilbert_cell.sym} 540 290 0 0 {name=x1}
C {/home/ishi-kai/ISHI-KAI_Multiple_Projects_OpenMPW_OpenSUSI-TR10-1/member_project/JJY_Receiver/Masahiro/jjy_recv/XTALOSC/XTALOSC.sym} 390 80 0 0 {name=x2}
C {/home/ishi-kai/ISHI-KAI_Multiple_Projects_OpenMPW_OpenSUSI-TR10-1/member_project/JJY_Receiver/Masahiro/jjy_recv/diff_amp/fully_diff_amp.sym} 260 290 0 0 {name=x3}
C {devices/lab_pin.sym} 370 50 0 0 {name=p1 sig_type=std_logic lab=vdd
}
C {devices/lab_pin.sym} 460 210 0 0 {name=p2 sig_type=std_logic lab=vdd
}
C {devices/lab_pin.sym} 230 230 0 0 {name=p3 sig_type=std_logic lab=vdd
}
C {devices/lab_pin.sym} 260 350 0 0 {name=p4 sig_type=std_logic lab=vss
}
C {devices/lab_pin.sym} 540 370 0 0 {name=p5 sig_type=std_logic lab=vss
}
C {devices/lab_pin.sym} 370 70 0 0 {name=p6 sig_type=std_logic lab=vss
}
C {/home/ishi-kai/ISHI-KAI_Multiple_Projects_OpenMPW_OpenSUSI-TR10-1/member_project/JJY_Receiver/Masahiro/jjy_recv/bias_for_mix_amp/bias40u.sym} 70 180 0 0 {name=x4}
C {devices/lab_pin.sym} 150 190 0 1 {name=p7 sig_type=std_logic lab=vss
}
C {/home/ishi-kai/ISHI-KAI_Multiple_Projects_OpenMPW_OpenSUSI-TR10-1/member_project/JJY_Receiver/Masahiro/jjy_recv/OBUF_SSF/BUF_SSF.sym} 950 290 0 0 {name=x5}
C {devices/iopin.sym} 70 50 0 1 {name=p8 lab=VDD}
C {devices/iopin.sym} 70 80 0 1 {name=p9 lab=VSS}
C {devices/iopin.sym} 440 -20 3 0 {name=p10 lab=XTALN}
C {devices/iopin.sym} 470 -20 3 0 {name=p11 lab=XTALP}
C {devices/ipin.sym} 150 270 0 0 {name=p12 lab=vinn}
C {devices/ipin.sym} 150 310 0 0 {name=p13 lab=vinp}
C {devices/lab_pin.sym} 90 50 0 1 {name=p14 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} 90 80 0 1 {name=p15 sig_type=std_logic lab=vss}
C {devices/iopin.sym} 170 150 3 0 {name=p16 lab=ib40u}
C {devices/iopin.sym} 70 110 0 1 {name=p17 lab=Vb}
C {devices/lab_pin.sym} 90 110 0 1 {name=p18 sig_type=std_logic lab=vb}
C {devices/lab_pin.sym} 520 210 3 1 {name=p19 sig_type=std_logic lab=vb}
C {devices/lab_pin.sym} 290 230 3 1 {name=p20 sig_type=std_logic lab=vb}
