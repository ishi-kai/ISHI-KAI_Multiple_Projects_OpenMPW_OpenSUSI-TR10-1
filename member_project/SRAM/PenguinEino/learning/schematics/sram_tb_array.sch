v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 350 630 1010 630 {lab=WL0}
N 1010 580 1010 630 {lab=WL0}
N 350 590 350 630 {lab=WL0}
N 100 870 760 870 {lab=WL1}
N 350 820 350 870 {lab=WL1}
N 160 350 160 710 {lab=BL0}
N 160 710 200 710 {lab=BL0}
N 160 480 200 480 {lab=BL0}
N 820 340 820 700 {lab=BL1}
N 820 710 860 710 {lab=BL1}
N 820 470 860 470 {lab=BL1}
N 1220 340 1220 700 {lab=BLB1}
N 1160 710 1200 710 {lab=BLB1}
N 1180 470 1220 470 {lab=BLB1}
N 100 630 210 630 {lab=WL0}
N 560 350 560 710 {lab=BLB0}
N 520 480 560 480 {lab=BLB0}
N 760 870 870 870 {lab=WL1}
N 500 480 520 480 {lab=BLB0}
N 540 710 560 710 {lab=BLB0}
N 1160 470 1180 470 {lab=BLB1}
N 500 710 540 710 {lab=BLB0}
N 160 270 160 350 {lab=BL0}
N 560 270 560 350 {lab=BLB0}
N 820 270 820 340 {lab=BL1}
N 1220 270 1220 340 {lab=BLB1}
N 210 630 350 630 {lab=WL0}
N 1010 820 1010 870 {lab=WL1}
N 870 870 1010 870 {lab=WL1}
N 160 170 160 210 {lab=Vdd}
N 160 170 1220 170 {lab=Vdd}
N 1220 170 1220 210 {lab=Vdd}
N 820 170 820 210 {lab=Vdd}
N 560 170 560 210 {lab=Vdd}
N 160 710 160 990 {lab=BL0}
N 560 710 560 990 {lab=BLB0}
N 820 720 820 1000 {lab=BL1}
N 820 700 820 720 {lab=BL1}
N 1220 700 1220 1000 {lab=BLB1}
N 1200 710 1220 710 {lab=BLB1}
N 560 990 560 1000 {lab=BLB0}
N 160 990 160 1000 {lab=BL0}
N 160 1060 160 1170 {lab=Vss}
N 160 1170 1180 1170 {lab=Vss}
N 1220 1060 1220 1170 {lab=Vss}
N 1180 1170 1220 1170 {lab=Vss}
N 820 1060 820 1170 {lab=Vss}
N 560 1060 560 1170 {lab=Vss}
N 100 1170 160 1170 {lab=Vss}
N 160 240 220 240 {lab=Vdd}
N 220 170 220 240 {lab=Vdd}
N 560 240 620 240 {lab=Vdd}
N 620 170 620 240 {lab=Vdd}
N 820 240 880 240 {lab=Vdd}
N 880 170 880 240 {lab=Vdd}
N 1220 240 1280 240 {lab=Vdd}
N 1280 170 1280 240 {lab=Vdd}
N 1220 170 1280 170 {lab=Vdd}
N 160 1030 220 1030 {lab=Vss}
N 220 1030 220 1170 {lab=Vss}
N 560 1030 620 1030 {lab=Vss}
N 620 1030 620 1170 {lab=Vss}
N 820 1030 880 1030 {lab=Vss}
N 880 1030 880 1170 {lab=Vss}
N 1220 1030 1280 1030 {lab=Vss}
N 1280 1030 1280 1170 {lab=Vss}
N 1220 1170 1280 1170 {lab=Vss}
N 160 320 320 320 {lab=BL0}
N 380 320 560 320 {lab=BLB0}
N 350 170 350 320 {lab=Vdd}
N 820 320 980 320 {lab=BL1}
N 1040 320 1220 320 {lab=BLB1}
N 1010 170 1010 320 {lab=Vdd}
C {sram.sym} 350 510 0 0 {name=x1}
C {sram.sym} 350 740 0 0 {name=x2}
C {sram.sym} 1010 500 0 0 {name=x3}
C {sram.sym} 1010 740 0 0 {name=x4}
C {devices/lab_pin.sym} 160 340 2 0 {name=p9 lab=BL0}
C {devices/lab_pin.sym} 560 350 2 0 {name=p3 lab=BLB0}
C {devices/lab_pin.sym} 820 350 2 0 {name=p4 lab=BL1}
C {devices/lab_pin.sym} 1220 340 2 0 {name=p5 lab=BLB1}
C {devices/lab_pin.sym} 100 870 0 0 {name=p8 lab=WL1}
C {devices/lab_pin.sym} 100 630 0 0 {name=p1 lab=WL0}
C {devices/lab_pin.sym} 500 560 2 0 {name=p7 lab=Vss}
C {devices/lab_pin.sym} 500 770 2 0 {name=p10 lab=Vdd}
C {devices/lab_pin.sym} 500 790 2 0 {name=p11 lab=Vss}
C {devices/lab_pin.sym} 1160 770 2 0 {name=p12 lab=Vdd}
C {devices/lab_pin.sym} 1160 790 2 0 {name=p13 lab=Vss}
C {devices/lab_pin.sym} 1160 530 2 0 {name=p6 lab=Vdd}
C {devices/lab_pin.sym} 1160 550 2 0 {name=p14 lab=Vss}
C {TR-1umLIB/MP.sym} 120 240 0 0 {name=XM1
model=PMOS
w=10.2u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MP.sym} 520 240 0 0 {name=XM2
model=PMOS
w=10.2u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MP.sym} 780 240 0 0 {name=XM3
model=PMOS
w=10.2u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MP.sym} 1180 240 0 0 {name=XM4
model=PMOS
w=10.2u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {devices/lab_pin.sym} 500 540 2 0 {name=p2 lab=Vdd}
C {devices/lab_pin.sym} 160 170 0 0 {name=p15 lab=Vdd}
C {devices/lab_pin.sym} 120 240 0 0 {name=p16 lab=PREB}
C {devices/lab_pin.sym} 520 240 0 0 {name=p17 lab=PREB}
C {devices/lab_pin.sym} 780 240 0 0 {name=p18 lab=PREB}
C {devices/lab_pin.sym} 1180 240 0 0 {name=p19 lab=PREB}
C {TR-1umLIB/MN.sym} 120 1030 0 0 {name=XM5
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
C {TR-1umLIB/MN.sym} 520 1030 0 0 {name=XM6
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
C {TR-1umLIB/MN.sym} 780 1030 0 0 {name=XM7
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
C {TR-1umLIB/MN.sym} 1180 1030 0 0 {name=XM8
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
C {devices/lab_pin.sym} 100 1170 0 0 {name=p20 lab=Vss}
C {TR-1umLIB/MP.sym} 350 360 1 1 {name=XM9
model=PMOS
w=10.2u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {TR-1umLIB/MP.sym} 1010 360 1 1 {name=XM10
model=PMOS
w=10.2u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
T {2 x 2 SRAM | PRECHARGE / WRITE / READ} 40 -70 0 0 0.5 0.5 {}
T {Array copied from sram_array.sch; test sources, gate controls and probes added.} 40 -20 0 0 0.3 0.3 {}
T {ROW 0: Q00 / Q01} 40 395 0 0 0.28 0.28 {}
T {ROW 1: Q10 / Q11} 40 650 0 0 0.28 0.28 {}
C {devices/lab_pin.sym} 350 360 2 0 {name=l_tb228 lab=PREB}
C {devices/lab_pin.sym} 1010 360 2 0 {name=l_tb229 lab=PREB}
C {devices/lab_pin.sym} 120 1030 0 0 {name=l_tb230 lab=PD_BL0}
C {devices/lab_pin.sym} 520 1030 0 0 {name=l_tb231 lab=PD_BLB0}
C {devices/lab_pin.sym} 780 1030 0 0 {name=l_tb232 lab=PD_BL1}
C {devices/lab_pin.sym} 1180 1030 0 0 {name=l_tb233 lab=PD_BLB1}
N 500 500 550 500 {lab=Q00}
C {devices/lab_pin.sym} 550 500 0 0 {name=l_tb235 lab=Q00}
N 500 520 550 520 {lab=QB00}
C {devices/lab_pin.sym} 550 520 0 0 {name=l_tb237 lab=QB00}
N 500 730 550 730 {lab=Q10}
C {devices/lab_pin.sym} 550 730 0 0 {name=l_tb239 lab=Q10}
N 500 750 550 750 {lab=QB10}
C {devices/lab_pin.sym} 550 750 0 0 {name=l_tb241 lab=QB10}
N 1160 490 1210 490 {lab=Q01}
C {devices/lab_pin.sym} 1210 490 0 0 {name=l_tb243 lab=Q01}
N 1160 510 1210 510 {lab=QB01}
C {devices/lab_pin.sym} 1210 510 0 0 {name=l_tb245 lab=QB01}
N 1160 730 1210 730 {lab=Q11}
C {devices/lab_pin.sym} 1210 730 0 0 {name=l_tb247 lab=Q11}
N 1160 750 1210 750 {lab=QB11}
C {devices/lab_pin.sym} 1210 750 0 0 {name=l_tb249 lab=QB11}
C {devices/vsource.sym} -50 1140 0 0 {name=VSS value=0 savecurrent=false}
C {devices/lab_pin.sym} -50 1110 0 0 {name=l_tb251 lab=Vss}
C {devices/gnd.sym} -50 1170 0 0 {name=GREF lab=GND}
T {BITLINE LOADS / 10 fF per line, assumed (not extracted)} 40 1260 0 0 0.3 0.3 {}
C {devices/capa.sym} 160 1350 0 0 {name=CBL0
m=1
value=10f}
C {devices/lab_pin.sym} 160 1320 2 0 {name=l_tb255 lab=BL0}
C {devices/gnd.sym} 160 1380 0 0 {name=gBL0 lab=GND}
C {devices/capa.sym} 500 1350 0 0 {name=CBLB0
m=1
value=10f}
C {devices/lab_pin.sym} 500 1320 2 0 {name=l_tb258 lab=BLB0}
C {devices/gnd.sym} 500 1380 0 0 {name=gBLB0 lab=GND}
C {devices/capa.sym} 840 1350 0 0 {name=CBL1
m=1
value=10f}
C {devices/lab_pin.sym} 840 1320 2 0 {name=l_tb261 lab=BL1}
C {devices/gnd.sym} 840 1380 0 0 {name=gBL1 lab=GND}
C {devices/capa.sym} 1180 1350 0 0 {name=CBLB1
m=1
value=10f}
C {devices/lab_pin.sym} 1180 1320 2 0 {name=l_tb264 lab=BLB1}
C {devices/gnd.sym} 1180 1380 0 0 {name=gBLB1 lab=GND}
T {STIMULUS / PWL sources: select and press q to edit} 40 1450 0 0 0.32 0.32 {}
C {devices/vsource.sym} 100 1580 0 0 {name=VVdd
value="5"
savecurrent=false
hide_texts=true}
N 100 1510 100 1550 {lab=Vdd}
C {devices/lab_pin.sym} 100 1510 2 0 {name=l_tb269 lab=Vdd}
N 100 1610 100 1640 {lab=GND}
C {devices/gnd.sym} 100 1640 0 0 {name=g_src0 lab=GND}
T {5 V} 122 1570 0 0 0.25 0.25 {}
C {devices/vsource.sym} 270 1580 0 0 {name=VPREB
value="PWL(0n 0 20n 0 21n 5 100n 5 101n 0 120n 0 121n 5 200n 5 201n 0 220n 0 221n 5 300n 5 301n 0 320n 0 321n 5 400n 5 401n 0 420n 0 421n 5 500n 5 501n 0 520n 0 521n 5 600n 5 601n 0 620n 0 621n 5 700n 5 701n 0 720n 0 721n 5 800n 5 801n 0 820n 0 821n 5 900n 5 901n 0 920n 0 921n 5 1000n 5 1001n 0 1020n 0 1021n 5 1100n 5 1101n 0 1120n 0 1121n 5 1200n 5)"
savecurrent=false
hide_texts=true}
N 270 1510 270 1550 {lab=PREB}
C {devices/lab_pin.sym} 270 1510 2 0 {name=l_tb275 lab=PREB}
N 270 1610 270 1640 {lab=GND}
C {devices/gnd.sym} 270 1640 0 0 {name=g_src1 lab=GND}
T {PWL} 292 1570 0 0 0.25 0.25 {}
C {devices/vsource.sym} 440 1580 0 0 {name=VWL0
value="PWL(0n 0 35n 0 36n 5 65n 5 66n 0 235n 0 236n 5 265n 5 266n 0 435n 0 436n 5 465n 5 466n 0 635n 0 636n 5 665n 5 666n 0 835n 0 836n 5 865n 5 866n 0 935n 0 936n 5 965n 5 966n 0 1200n 0)"
savecurrent=false
hide_texts=true}
N 440 1510 440 1550 {lab=WL0}
C {devices/lab_pin.sym} 440 1510 2 0 {name=l_tb281 lab=WL0}
N 440 1610 440 1640 {lab=GND}
C {devices/gnd.sym} 440 1640 0 0 {name=g_src2 lab=GND}
T {PWL} 462 1570 0 0 0.25 0.25 {}
C {devices/vsource.sym} 610 1580 0 0 {name=VWL1
value="PWL(0n 0 135n 0 136n 5 165n 5 166n 0 335n 0 336n 5 365n 5 366n 0 535n 0 536n 5 565n 5 566n 0 735n 0 736n 5 765n 5 766n 0 1035n 0 1036n 5 1065n 5 1066n 0 1135n 0 1136n 5 1165n 5 1166n 0 1200n 0)"
savecurrent=false
hide_texts=true}
N 610 1510 610 1550 {lab=WL1}
C {devices/lab_pin.sym} 610 1510 2 0 {name=l_tb287 lab=WL1}
N 610 1610 610 1640 {lab=GND}
C {devices/gnd.sym} 610 1640 0 0 {name=g_src3 lab=GND}
T {PWL} 632 1570 0 0 0.25 0.25 {}
C {devices/vsource.sym} 780 1580 0 0 {name=VPD_BL0
value="PWL(0n 0 25n 0 26n 5 75n 5 76n 0 525n 0 526n 5 575n 5 576n 0 825n 0 826n 5 875n 5 876n 0 1200n 0)"
savecurrent=false
hide_texts=true}
N 780 1510 780 1550 {lab=PD_BL0}
C {devices/lab_pin.sym} 780 1510 2 0 {name=l_tb293 lab=PD_BL0}
N 780 1610 780 1640 {lab=GND}
C {devices/gnd.sym} 780 1640 0 0 {name=g_src4 lab=GND}
T {PWL} 802 1570 0 0 0.25 0.25 {}
C {devices/vsource.sym} 950 1580 0 0 {name=VPD_BLB0
value="PWL(0n 0 125n 0 126n 5 175n 5 176n 0 425n 0 426n 5 475n 5 476n 0 1200n 0)"
savecurrent=false
hide_texts=true}
N 950 1510 950 1550 {lab=PD_BLB0}
C {devices/lab_pin.sym} 950 1510 2 0 {name=l_tb299 lab=PD_BLB0}
N 950 1610 950 1640 {lab=GND}
C {devices/gnd.sym} 950 1640 0 0 {name=g_src5 lab=GND}
T {PWL} 972 1570 0 0 0.25 0.25 {}
C {devices/vsource.sym} 1120 1580 0 0 {name=VPD_BL1
value="PWL(0n 0 125n 0 126n 5 175n 5 176n 0 425n 0 426n 5 475n 5 476n 0 1025n 0 1026n 5 1075n 5 1076n 0 1200n 0)"
savecurrent=false
hide_texts=true}
N 1120 1510 1120 1550 {lab=PD_BL1}
C {devices/lab_pin.sym} 1120 1510 2 0 {name=l_tb305 lab=PD_BL1}
N 1120 1610 1120 1640 {lab=GND}
C {devices/gnd.sym} 1120 1640 0 0 {name=g_src6 lab=GND}
T {PWL} 1142 1570 0 0 0.25 0.25 {}
C {devices/vsource.sym} 1290 1580 0 0 {name=VPD_BLB1
value="PWL(0n 0 25n 0 26n 5 75n 5 76n 0 525n 0 526n 5 575n 5 576n 0 1200n 0)"
savecurrent=false
hide_texts=true}
N 1290 1510 1290 1550 {lab=PD_BLB1}
C {devices/lab_pin.sym} 1290 1510 2 0 {name=l_tb311 lab=PD_BLB1}
N 1290 1610 1290 1640 {lab=GND}
C {devices/gnd.sym} 1290 1640 0 0 {name=g_src7 lab=GND}
T {PWL} 1312 1570 0 0 0.25 0.25 {}
T {SEQUENCE / each cycle = 100 ns} 1500 130 0 0 0.35 0.35 {}
T {0     W row 0 = 01} 1500 180 0 0 0.3 0.3 {}
T {100   W row 1 = 10} 1500 215 0 0 0.3 0.3 {}
T {200   R row 0 = 01} 1500 250 0 0 0.3 0.3 {}
T {300   R row 1 = 10} 1500 285 0 0 0.3 0.3 {}
T {400   W row 0 = 10} 1500 320 0 0 0.3 0.3 {}
T {500   W row 1 = 01} 1500 355 0 0 0.3 0.3 {}
T {600   R row 0 = 10} 1500 390 0 0 0.3 0.3 {}
T {700   R row 1 = 01} 1500 425 0 0 0.3 0.3 {}
T {800   W row 0, col 0 only -> 00} 1500 460 0 0 0.3 0.3 {}
T {900   R row 0 = 00} 1500 495 0 0 0.3 0.3 {}
T {1000  W row 1, col 1 only -> 00} 1500 530 0 0 0.3 0.3 {}
T {1100  R row 1 = 00} 1500 565 0 0 0.3 0.3 {}
T {WITHIN EACH CYCLE} 1500 650 0 0 0.28 0.28 {}
T {0 - 20: precharge; both WL LOW} 1500 685 0 0 0.28 0.28 {}
T {25 - 75: selected pull-down ON (write only)} 1500 720 0 0 0.28 0.28 {}
T {35 - 65: selected WL HIGH} 1500 755 0 0 0.28 0.28 {}
T {60: sample read bitline differences} 1500 790 0 0 0.28 0.28 {}
T {90: verify all four stored bits} 1500 825 0 0 0.28 0.28 {}
T {Qrc: row r, column c; data shown as col 0 / col 1} 1500 895 0 0 0.28 0.28 {}
T {Initial array = 00 / 00 using .ic} 1500 930 0 0 0.28 0.28 {}
T {Cell + write NMOS: W/L = 3.4u / 1u} 1500 965 0 0 0.28 0.28 {}
T {Precharge PMOS: W/L = 10.2u / 1u} 1500 1000 0 0 0.28 0.28 {}
T {Nonselected row: check Q and QB throughout cycle.} 1500 1070 0 0 0.28 0.28 {}
T {Masked write: other column must retain its bit.} 1500 1105 0 0 0.28 0.28 {}
T {Reads observe bitline difference; no sense amplifier.} 1500 1140 0 0 0.28 0.28 {}
T {RUN / Netlist, then Simulate} 1500 1220 0 0 0.34 0.34 {}
T {Console: measurements + PASS / FAIL} 1500 1260 0 0 0.28 0.28 {}
T {Plots: stored bits / bitlines / control timing} 1500 1300 0 0 0.28 0.28 {}
C {devices/code.sym} 1540 1440 0 0 {name=TR_1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"}
C {devices/code.sym} 1880 1440 0 0 {name=SIMULATION
only_toplevel=true
value="* Nominal functional test. Qrc = row r, column c.
.ic v(Q00)=0 v(QB00)=5 v(Q01)=0 v(QB01)=5 v(Q10)=0 v(QB10)=5 v(Q11)=0 v(QB11)=5
.control
save all
tran 0.05n 1200n
let failures = 0
let diff0 = v(BL0)-v(BLB0)
let diff1 = v(BL1)-v(BLB1)
echo CYCLE_0: W row_0
meas tran nslo_0_0 max v(Q10) from=0n to=99n
meas tran nshi_0_0 min v(QB10) from=0n to=99n
if nslo_0_0 > 0.5 or nshi_0_0 < 4.5
 let failures = failures + 1
end
meas tran nslo_0_1 max v(Q11) from=0n to=99n
meas tran nshi_0_1 min v(QB11) from=0n to=99n
if nslo_0_1 > 0.5 or nshi_0_1 < 4.5
 let failures = failures + 1
end
meas tran q_0_00 find v(Q00) at=90n
meas tran qb_0_00 find v(QB00) at=90n
if q_0_00 > 0.5 or qb_0_00 < 4.5
 let failures = failures + 1
end
meas tran q_0_01 find v(Q01) at=90n
meas tran qb_0_01 find v(QB01) at=90n
if q_0_01 < 4.5 or qb_0_01 > 0.5
 let failures = failures + 1
end
meas tran q_0_10 find v(Q10) at=90n
meas tran qb_0_10 find v(QB10) at=90n
if q_0_10 > 0.5 or qb_0_10 < 4.5
 let failures = failures + 1
end
meas tran q_0_11 find v(Q11) at=90n
meas tran qb_0_11 find v(QB11) at=90n
if q_0_11 > 0.5 or qb_0_11 < 4.5
 let failures = failures + 1
end
echo CYCLE_1: W row_1
meas tran nslo_1_0 max v(Q00) from=100n to=199n
meas tran nshi_1_0 min v(QB00) from=100n to=199n
if nslo_1_0 > 0.5 or nshi_1_0 < 4.5
 let failures = failures + 1
end
meas tran nslo_1_1 max v(QB01) from=100n to=199n
meas tran nshi_1_1 min v(Q01) from=100n to=199n
if nslo_1_1 > 0.5 or nshi_1_1 < 4.5
 let failures = failures + 1
end
meas tran q_1_00 find v(Q00) at=190n
meas tran qb_1_00 find v(QB00) at=190n
if q_1_00 > 0.5 or qb_1_00 < 4.5
 let failures = failures + 1
end
meas tran q_1_01 find v(Q01) at=190n
meas tran qb_1_01 find v(QB01) at=190n
if q_1_01 < 4.5 or qb_1_01 > 0.5
 let failures = failures + 1
end
meas tran q_1_10 find v(Q10) at=190n
meas tran qb_1_10 find v(QB10) at=190n
if q_1_10 < 4.5 or qb_1_10 > 0.5
 let failures = failures + 1
end
meas tran q_1_11 find v(Q11) at=190n
meas tran qb_1_11 find v(QB11) at=190n
if q_1_11 > 0.5 or qb_1_11 < 4.5
 let failures = failures + 1
end
echo CYCLE_2: R row_0
meas tran nslo_2_0 max v(QB10) from=200n to=299n
meas tran nshi_2_0 min v(Q10) from=200n to=299n
if nslo_2_0 > 0.5 or nshi_2_0 < 4.5
 let failures = failures + 1
end
meas tran nslo_2_1 max v(Q11) from=200n to=299n
meas tran nshi_2_1 min v(QB11) from=200n to=299n
if nslo_2_1 > 0.5 or nshi_2_1 < 4.5
 let failures = failures + 1
end
meas tran rd_2_0 find diff0 at=260n
if rd_2_0 > -0.5
 let failures = failures + 1
end
meas tran rd_2_1 find diff1 at=260n
if rd_2_1 < 0.5
 let failures = failures + 1
end
meas tran q_2_00 find v(Q00) at=290n
meas tran qb_2_00 find v(QB00) at=290n
if q_2_00 > 0.5 or qb_2_00 < 4.5
 let failures = failures + 1
end
meas tran q_2_01 find v(Q01) at=290n
meas tran qb_2_01 find v(QB01) at=290n
if q_2_01 < 4.5 or qb_2_01 > 0.5
 let failures = failures + 1
end
meas tran q_2_10 find v(Q10) at=290n
meas tran qb_2_10 find v(QB10) at=290n
if q_2_10 < 4.5 or qb_2_10 > 0.5
 let failures = failures + 1
end
meas tran q_2_11 find v(Q11) at=290n
meas tran qb_2_11 find v(QB11) at=290n
if q_2_11 > 0.5 or qb_2_11 < 4.5
 let failures = failures + 1
end
echo CYCLE_3: R row_1
meas tran nslo_3_0 max v(Q00) from=300n to=399n
meas tran nshi_3_0 min v(QB00) from=300n to=399n
if nslo_3_0 > 0.5 or nshi_3_0 < 4.5
 let failures = failures + 1
end
meas tran nslo_3_1 max v(QB01) from=300n to=399n
meas tran nshi_3_1 min v(Q01) from=300n to=399n
if nslo_3_1 > 0.5 or nshi_3_1 < 4.5
 let failures = failures + 1
end
meas tran rd_3_0 find diff0 at=360n
if rd_3_0 < 0.5
 let failures = failures + 1
end
meas tran rd_3_1 find diff1 at=360n
if rd_3_1 > -0.5
 let failures = failures + 1
end
meas tran q_3_00 find v(Q00) at=390n
meas tran qb_3_00 find v(QB00) at=390n
if q_3_00 > 0.5 or qb_3_00 < 4.5
 let failures = failures + 1
end
meas tran q_3_01 find v(Q01) at=390n
meas tran qb_3_01 find v(QB01) at=390n
if q_3_01 < 4.5 or qb_3_01 > 0.5
 let failures = failures + 1
end
meas tran q_3_10 find v(Q10) at=390n
meas tran qb_3_10 find v(QB10) at=390n
if q_3_10 < 4.5 or qb_3_10 > 0.5
 let failures = failures + 1
end
meas tran q_3_11 find v(Q11) at=390n
meas tran qb_3_11 find v(QB11) at=390n
if q_3_11 > 0.5 or qb_3_11 < 4.5
 let failures = failures + 1
end
echo CYCLE_4: W row_0
meas tran nslo_4_0 max v(QB10) from=400n to=499n
meas tran nshi_4_0 min v(Q10) from=400n to=499n
if nslo_4_0 > 0.5 or nshi_4_0 < 4.5
 let failures = failures + 1
end
meas tran nslo_4_1 max v(Q11) from=400n to=499n
meas tran nshi_4_1 min v(QB11) from=400n to=499n
if nslo_4_1 > 0.5 or nshi_4_1 < 4.5
 let failures = failures + 1
end
meas tran q_4_00 find v(Q00) at=490n
meas tran qb_4_00 find v(QB00) at=490n
if q_4_00 < 4.5 or qb_4_00 > 0.5
 let failures = failures + 1
end
meas tran q_4_01 find v(Q01) at=490n
meas tran qb_4_01 find v(QB01) at=490n
if q_4_01 > 0.5 or qb_4_01 < 4.5
 let failures = failures + 1
end
meas tran q_4_10 find v(Q10) at=490n
meas tran qb_4_10 find v(QB10) at=490n
if q_4_10 < 4.5 or qb_4_10 > 0.5
 let failures = failures + 1
end
meas tran q_4_11 find v(Q11) at=490n
meas tran qb_4_11 find v(QB11) at=490n
if q_4_11 > 0.5 or qb_4_11 < 4.5
 let failures = failures + 1
end
echo CYCLE_5: W row_1
meas tran nslo_5_0 max v(QB00) from=500n to=599n
meas tran nshi_5_0 min v(Q00) from=500n to=599n
if nslo_5_0 > 0.5 or nshi_5_0 < 4.5
 let failures = failures + 1
end
meas tran nslo_5_1 max v(Q01) from=500n to=599n
meas tran nshi_5_1 min v(QB01) from=500n to=599n
if nslo_5_1 > 0.5 or nshi_5_1 < 4.5
 let failures = failures + 1
end
meas tran q_5_00 find v(Q00) at=590n
meas tran qb_5_00 find v(QB00) at=590n
if q_5_00 < 4.5 or qb_5_00 > 0.5
 let failures = failures + 1
end
meas tran q_5_01 find v(Q01) at=590n
meas tran qb_5_01 find v(QB01) at=590n
if q_5_01 > 0.5 or qb_5_01 < 4.5
 let failures = failures + 1
end
meas tran q_5_10 find v(Q10) at=590n
meas tran qb_5_10 find v(QB10) at=590n
if q_5_10 > 0.5 or qb_5_10 < 4.5
 let failures = failures + 1
end
meas tran q_5_11 find v(Q11) at=590n
meas tran qb_5_11 find v(QB11) at=590n
if q_5_11 < 4.5 or qb_5_11 > 0.5
 let failures = failures + 1
end
echo CYCLE_6: R row_0
meas tran nslo_6_0 max v(Q10) from=600n to=699n
meas tran nshi_6_0 min v(QB10) from=600n to=699n
if nslo_6_0 > 0.5 or nshi_6_0 < 4.5
 let failures = failures + 1
end
meas tran nslo_6_1 max v(QB11) from=600n to=699n
meas tran nshi_6_1 min v(Q11) from=600n to=699n
if nslo_6_1 > 0.5 or nshi_6_1 < 4.5
 let failures = failures + 1
end
meas tran rd_6_0 find diff0 at=660n
if rd_6_0 < 0.5
 let failures = failures + 1
end
meas tran rd_6_1 find diff1 at=660n
if rd_6_1 > -0.5
 let failures = failures + 1
end
meas tran q_6_00 find v(Q00) at=690n
meas tran qb_6_00 find v(QB00) at=690n
if q_6_00 < 4.5 or qb_6_00 > 0.5
 let failures = failures + 1
end
meas tran q_6_01 find v(Q01) at=690n
meas tran qb_6_01 find v(QB01) at=690n
if q_6_01 > 0.5 or qb_6_01 < 4.5
 let failures = failures + 1
end
meas tran q_6_10 find v(Q10) at=690n
meas tran qb_6_10 find v(QB10) at=690n
if q_6_10 > 0.5 or qb_6_10 < 4.5
 let failures = failures + 1
end
meas tran q_6_11 find v(Q11) at=690n
meas tran qb_6_11 find v(QB11) at=690n
if q_6_11 < 4.5 or qb_6_11 > 0.5
 let failures = failures + 1
end
echo CYCLE_7: R row_1
meas tran nslo_7_0 max v(QB00) from=700n to=799n
meas tran nshi_7_0 min v(Q00) from=700n to=799n
if nslo_7_0 > 0.5 or nshi_7_0 < 4.5
 let failures = failures + 1
end
meas tran nslo_7_1 max v(Q01) from=700n to=799n
meas tran nshi_7_1 min v(QB01) from=700n to=799n
if nslo_7_1 > 0.5 or nshi_7_1 < 4.5
 let failures = failures + 1
end
meas tran rd_7_0 find diff0 at=760n
if rd_7_0 > -0.5
 let failures = failures + 1
end
meas tran rd_7_1 find diff1 at=760n
if rd_7_1 < 0.5
 let failures = failures + 1
end
meas tran q_7_00 find v(Q00) at=790n
meas tran qb_7_00 find v(QB00) at=790n
if q_7_00 < 4.5 or qb_7_00 > 0.5
 let failures = failures + 1
end
meas tran q_7_01 find v(Q01) at=790n
meas tran qb_7_01 find v(QB01) at=790n
if q_7_01 > 0.5 or qb_7_01 < 4.5
 let failures = failures + 1
end
meas tran q_7_10 find v(Q10) at=790n
meas tran qb_7_10 find v(QB10) at=790n
if q_7_10 > 0.5 or qb_7_10 < 4.5
 let failures = failures + 1
end
meas tran q_7_11 find v(Q11) at=790n
meas tran qb_7_11 find v(QB11) at=790n
if q_7_11 < 4.5 or qb_7_11 > 0.5
 let failures = failures + 1
end
echo CYCLE_8: W row_0
meas tran nslo_8_0 max v(Q10) from=800n to=899n
meas tran nshi_8_0 min v(QB10) from=800n to=899n
if nslo_8_0 > 0.5 or nshi_8_0 < 4.5
 let failures = failures + 1
end
meas tran nslo_8_1 max v(QB11) from=800n to=899n
meas tran nshi_8_1 min v(Q11) from=800n to=899n
if nslo_8_1 > 0.5 or nshi_8_1 < 4.5
 let failures = failures + 1
end
meas tran q_8_00 find v(Q00) at=890n
meas tran qb_8_00 find v(QB00) at=890n
if q_8_00 > 0.5 or qb_8_00 < 4.5
 let failures = failures + 1
end
meas tran q_8_01 find v(Q01) at=890n
meas tran qb_8_01 find v(QB01) at=890n
if q_8_01 > 0.5 or qb_8_01 < 4.5
 let failures = failures + 1
end
meas tran q_8_10 find v(Q10) at=890n
meas tran qb_8_10 find v(QB10) at=890n
if q_8_10 > 0.5 or qb_8_10 < 4.5
 let failures = failures + 1
end
meas tran q_8_11 find v(Q11) at=890n
meas tran qb_8_11 find v(QB11) at=890n
if q_8_11 < 4.5 or qb_8_11 > 0.5
 let failures = failures + 1
end
echo CYCLE_9: R row_0
meas tran nslo_9_0 max v(Q10) from=900n to=999n
meas tran nshi_9_0 min v(QB10) from=900n to=999n
if nslo_9_0 > 0.5 or nshi_9_0 < 4.5
 let failures = failures + 1
end
meas tran nslo_9_1 max v(QB11) from=900n to=999n
meas tran nshi_9_1 min v(Q11) from=900n to=999n
if nslo_9_1 > 0.5 or nshi_9_1 < 4.5
 let failures = failures + 1
end
meas tran rd_9_0 find diff0 at=960n
if rd_9_0 > -0.5
 let failures = failures + 1
end
meas tran rd_9_1 find diff1 at=960n
if rd_9_1 > -0.5
 let failures = failures + 1
end
meas tran q_9_00 find v(Q00) at=990n
meas tran qb_9_00 find v(QB00) at=990n
if q_9_00 > 0.5 or qb_9_00 < 4.5
 let failures = failures + 1
end
meas tran q_9_01 find v(Q01) at=990n
meas tran qb_9_01 find v(QB01) at=990n
if q_9_01 > 0.5 or qb_9_01 < 4.5
 let failures = failures + 1
end
meas tran q_9_10 find v(Q10) at=990n
meas tran qb_9_10 find v(QB10) at=990n
if q_9_10 > 0.5 or qb_9_10 < 4.5
 let failures = failures + 1
end
meas tran q_9_11 find v(Q11) at=990n
meas tran qb_9_11 find v(QB11) at=990n
if q_9_11 < 4.5 or qb_9_11 > 0.5
 let failures = failures + 1
end
echo CYCLE_10: W row_1
meas tran nslo_10_0 max v(Q00) from=1000n to=1099n
meas tran nshi_10_0 min v(QB00) from=1000n to=1099n
if nslo_10_0 > 0.5 or nshi_10_0 < 4.5
 let failures = failures + 1
end
meas tran nslo_10_1 max v(Q01) from=1000n to=1099n
meas tran nshi_10_1 min v(QB01) from=1000n to=1099n
if nslo_10_1 > 0.5 or nshi_10_1 < 4.5
 let failures = failures + 1
end
meas tran q_10_00 find v(Q00) at=1090n
meas tran qb_10_00 find v(QB00) at=1090n
if q_10_00 > 0.5 or qb_10_00 < 4.5
 let failures = failures + 1
end
meas tran q_10_01 find v(Q01) at=1090n
meas tran qb_10_01 find v(QB01) at=1090n
if q_10_01 > 0.5 or qb_10_01 < 4.5
 let failures = failures + 1
end
meas tran q_10_10 find v(Q10) at=1090n
meas tran qb_10_10 find v(QB10) at=1090n
if q_10_10 > 0.5 or qb_10_10 < 4.5
 let failures = failures + 1
end
meas tran q_10_11 find v(Q11) at=1090n
meas tran qb_10_11 find v(QB11) at=1090n
if q_10_11 > 0.5 or qb_10_11 < 4.5
 let failures = failures + 1
end
echo CYCLE_11: R row_1
meas tran nslo_11_0 max v(Q00) from=1100n to=1199n
meas tran nshi_11_0 min v(QB00) from=1100n to=1199n
if nslo_11_0 > 0.5 or nshi_11_0 < 4.5
 let failures = failures + 1
end
meas tran nslo_11_1 max v(Q01) from=1100n to=1199n
meas tran nshi_11_1 min v(QB01) from=1100n to=1199n
if nslo_11_1 > 0.5 or nshi_11_1 < 4.5
 let failures = failures + 1
end
meas tran rd_11_0 find diff0 at=1160n
if rd_11_0 > -0.5
 let failures = failures + 1
end
meas tran rd_11_1 find diff1 at=1160n
if rd_11_1 > -0.5
 let failures = failures + 1
end
meas tran q_11_00 find v(Q00) at=1190n
meas tran qb_11_00 find v(QB00) at=1190n
if q_11_00 > 0.5 or qb_11_00 < 4.5
 let failures = failures + 1
end
meas tran q_11_01 find v(Q01) at=1190n
meas tran qb_11_01 find v(QB01) at=1190n
if q_11_01 > 0.5 or qb_11_01 < 4.5
 let failures = failures + 1
end
meas tran q_11_10 find v(Q10) at=1190n
meas tran qb_11_10 find v(QB10) at=1190n
if q_11_10 > 0.5 or qb_11_10 < 4.5
 let failures = failures + 1
end
meas tran q_11_11 find v(Q11) at=1190n
meas tran qb_11_11 find v(QB11) at=1190n
if q_11_11 > 0.5 or qb_11_11 < 4.5
 let failures = failures + 1
end
if failures = 0
 echo PASS: writes, reads, masked writes and nonselected-row retention
else
 echo FAIL: array checks failed
 print failures
end
write sram_tb_array.raw
plot v(Q00) v(Q01) ylimit -0.5 5.5 title 'ROW 0: Q00 / Q01'
plot v(Q10) v(Q11) ylimit -0.5 5.5 title 'ROW 1: Q10 / Q11'
plot v(BL0) v(BLB0) ylimit -0.5 5.5 title 'COLUMN 0: BL / BLB'
plot v(BL1) v(BLB1) ylimit -0.5 5.5 title 'COLUMN 1: BL / BLB'
let PREB_T = v(PREB)/5+12
let WL0_T = v(WL0)/5+10
let WL1_T = v(WL1)/5+8
let PD_BL0_T = v(PD_BL0)/5+6
let PD_BLB0_T = v(PD_BLB0)/5+4
let PD_BL1_T = v(PD_BL1)/5+2
let PD_BLB1_T = v(PD_BLB1)/5+0
plot PREB_T WL0_T WL1_T PD_BL0_T PD_BLB0_T PD_BL1_T PD_BLB1_T ylimit -0.3 13.3 title 'CONTROLS: PREB +12 / WL0 +10 / WL1 +8 / PD_BL0 +6 / PD_BLB0 +4 / PD_BL1 +2 / PD_BLB1 +0'
.endc"}
C {devices/netlist_options.sym} 1500 1670 0 0 {name=NETLIST_OPTIONS
lvs_netlist=false
top_is_subckt=false
spiceprefix=true
hiersep=. }
