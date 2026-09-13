v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 0 -200 0 -150 {lab=VDD}
N 0 -120 30 -120 {lab=VDD}
N 0 -90 0 300 {lab=BL}
N 0 360 0 400 {lab=GND}
N 0 330 30 330 {lab=GND}
N 600 -200 600 -150 {lab=VDD}
N 600 -120 630 -120 {lab=VDD}
N 600 -90 600 300 {lab=BLB}
N 600 360 600 400 {lab=GND}
N 600 330 630 330 {lab=GND}
N 0 -50 270 -50 {lab=BL}
N 330 -50 600 -50 {lab=BLB}
N 300 -90 300 -50 {lab=VDD}
N 0 90 150 90 {lab=BL}
N 450 90 600 90 {lab=BLB}
N 450 110 490 110 {lab=Q}
N 450 130 490 130 {lab=QB}
N 450 150 490 150 {lab=VDD}
N 450 170 490 170 {lab=GND}
N 300 200 300 230 {lab=WL}
N 0 260 100 260 {lab=BL}
N 100 260 100 280 {lab=BL}
N 100 340 100 400 {lab=GND}
N 600 260 700 260 {lab=BLB}
N 700 260 700 280 {lab=BLB}
N 700 340 700 400 {lab=GND}
C {TR-1umLIB/MP.sym} -40 -120 0 0 {name=XP_BL
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
C {devices/lab_pin.sym} 0 -200 0 0 {name=l12 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 30 -120 2 0 {name=l14 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 0 0 0 0 {name=l17 sig_type=std_logic lab=BL}
C {TR-1umLIB/MN.sym} -40 330 0 0 {name=XW_BL
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
C {devices/lab_pin.sym} -40 330 0 0 {name=l19 sig_type=std_logic lab=PD_BL}
C {devices/gnd.sym} 0 400 0 0 {name=g21 lab=GND}
C {devices/lab_pin.sym} 30 330 2 0 {name=l23 sig_type=std_logic lab=GND}
C {TR-1umLIB/MP.sym} 560 -120 0 0 {name=XP_BLB
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
C {devices/lab_pin.sym} 600 -200 0 0 {name=l26 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 630 -120 2 0 {name=l28 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 560 -120 0 0 {name=l29 sig_type=std_logic lab=PREB}
C {devices/lab_pin.sym} 600 0 0 0 {name=l31 sig_type=std_logic lab=BLB}
C {TR-1umLIB/MN.sym} 560 330 0 0 {name=XW_BLB
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
C {devices/lab_pin.sym} 560 330 0 0 {name=l33 sig_type=std_logic lab=PD_BLB}
C {devices/gnd.sym} 600 400 0 0 {name=g35 lab=GND}
C {devices/lab_pin.sym} 630 330 2 0 {name=l37 sig_type=std_logic lab=GND}
C {TR-1umLIB/MP.sym} 300 -10 1 1 {name=XP_EQ
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
C {devices/lab_pin.sym} 300 -90 2 0 {name=l42 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 300 -10 2 0 {name=l43 sig_type=std_logic lab=PREB}
C {sram.sym} 300 120 0 0 {name=xcell}
C {devices/lab_pin.sym} 490 110 2 0 {name=l48 sig_type=std_logic lab=Q}
C {devices/lab_pin.sym} 490 130 2 0 {name=l50 sig_type=std_logic lab=QB}
C {devices/lab_pin.sym} 490 150 2 0 {name=l52 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 490 170 2 0 {name=l54 sig_type=std_logic lab=GND}
C {devices/lab_pin.sym} 300 230 2 0 {name=l56 sig_type=std_logic lab=WL}
C {devices/capa.sym} 100 310 0 0 {name=CBL
m=1
value='CBL'}
C {devices/gnd.sym} 100 400 0 0 {name=g61 lab=GND}
C {devices/capa.sym} 700 310 0 0 {name=CBLB
m=1
value='CBL'}
C {devices/gnd.sym} 700 400 0 0 {name=g66 lab=GND}
C {devices/lab_pin.sym} -40 -120 0 0 {name=l15 sig_type=std_logic lab=PREB}
T {SRAM CELL + 7T SENSE AMPLIFIER | WRITE / READ} -140 -360 0 0 0.45 0.45 {}
T {Real cell discharge; no ideal voltage source on BL / BLB. Direct connection (no column mux).} -140 -310 0 0 0.28 0.28 {}
T {PRECHARGE / CELL / WRITE DRIVERS} -140 -250 0 0 0.32 0.32 {}
C {sense_amp_7t.sym} 1130 120 0 0 {name=xsa}
C {devices/lab_pin.sym} 980 60 0 0 {name=lt68 lab=BL}
C {devices/lab_pin.sym} 980 120 0 0 {name=lt69 lab=BLB}
C {devices/lab_pin.sym} 980 180 0 0 {name=lt70 lab=SAE}
C {devices/lab_pin.sym} 1130 0 2 0 {name=lt71 lab=VDD}
C {devices/gnd.sym} 1130 240 0 0 {name=gsa lab=GND}
N 1280 60 1360 60 {lab=SOUT}
C {devices/lab_pin.sym} 1360 60 2 0 {name=lt74 lab=SOUT}
N 1360 60 1360 290 {lab=SOUT}
C {devices/capa.sym} 1360 320 0 0 {name=CSOUT value=10f m=1}
C {devices/gnd.sym} 1360 350 0 0 {name=gSOUT lab=GND}
N 1280 120 1510 120 {lab=SOUTB}
C {devices/lab_pin.sym} 1510 120 2 0 {name=lt79 lab=SOUTB}
N 1510 120 1510 290 {lab=SOUTB}
C {devices/capa.sym} 1510 320 0 0 {name=CSOUTB value=10f m=1}
C {devices/gnd.sym} 1510 350 0 0 {name=gSOUTB lab=GND}
T {SAE = 0: track/reset; SAE = 1: isolate/regenerate} 880 -180 0 0 0.28 0.28 {}
T {BL / BLB labels connect directly to the cell bitlines.} 880 -140 0 0 0.28 0.28 {}
T {Read result: SOUT = Q, SOUTB = QB} 880 440 0 0 0.3 0.3 {}
T {10 fF per output; 1 pF per bitline (learning load).} 880 480 0 0 0.28 0.28 {}
T {During write: SAE HIGH isolates the sense outputs.} -140 460 0 0 0.28 0.28 {}
T {Read validity is checked before SAE returns LOW.} -140 500 0 0 0.28 0.28 {}
T {STIMULUS / CBL: 10f, 100f or 1p in SIMULATION} -140 620 0 0 0.32 0.32 {}
C {devices/vsource.sym} 0 750 0 0 {name=VVDD
value="5"
savecurrent=false
hide_texts=true}
N 0 680 0 720 {lab=VDD}
C {devices/lab_pin.sym} 0 680 2 0 {name=lt92 lab=VDD}
N 0 780 0 820 {lab=GND}
C {devices/gnd.sym} 0 820 0 0 {name=gsrc0 lab=GND}
T {5 V} 25 740 0 0 0.25 0.25 {}
C {devices/vsource.sym} 240 750 0 0 {name=VPREB
value="PWL(0n 0 20n 0 21n 5 100n 5 101n 0 120n 0 121n 5 200n 5 201n 0 220n 0 221n 5 300n 5 301n 0 320n 0 321n 5 400n 5)"
savecurrent=false
hide_texts=true}
N 240 680 240 720 {lab=PREB}
C {devices/lab_pin.sym} 240 680 2 0 {name=lt98 lab=PREB}
N 240 780 240 820 {lab=GND}
C {devices/gnd.sym} 240 820 0 0 {name=gsrc1 lab=GND}
T {PWL} 265 740 0 0 0.25 0.25 {}
C {devices/vsource.sym} 480 750 0 0 {name=VWL
value="PWL(0n 0 35n 0 36n 5 65n 5 66n 0 135n 0 136n 5 165n 5 166n 0 235n 0 236n 5 265n 5 266n 0 335n 0 336n 5 365n 5 366n 0 400n 0)"
savecurrent=false
hide_texts=true}
N 480 680 480 720 {lab=WL}
C {devices/lab_pin.sym} 480 680 2 0 {name=lt104 lab=WL}
N 480 780 480 820 {lab=GND}
C {devices/gnd.sym} 480 820 0 0 {name=gsrc2 lab=GND}
T {PWL} 505 740 0 0 0.25 0.25 {}
C {devices/vsource.sym} 720 750 0 0 {name=VPD_BL
value="PWL(0n 0 225n 0 226n 5 275n 5 276n 0 400n 0)"
savecurrent=false
hide_texts=true}
N 720 680 720 720 {lab=PD_BL}
C {devices/lab_pin.sym} 720 680 2 0 {name=lt110 lab=PD_BL}
N 720 780 720 820 {lab=GND}
C {devices/gnd.sym} 720 820 0 0 {name=gsrc3 lab=GND}
T {PWL} 745 740 0 0 0.25 0.25 {}
C {devices/vsource.sym} 960 750 0 0 {name=VPD_BLB
value="PWL(0n 0 25n 0 26n 5 75n 5 76n 0 400n 0)"
savecurrent=false
hide_texts=true}
N 960 680 960 720 {lab=PD_BLB}
C {devices/lab_pin.sym} 960 680 2 0 {name=lt116 lab=PD_BLB}
N 960 780 960 820 {lab=GND}
C {devices/gnd.sym} 960 820 0 0 {name=gsrc4 lab=GND}
T {PWL} 985 740 0 0 0.25 0.25 {}
C {devices/vsource.sym} 1200 750 0 0 {name=VSAE
value="PWL(0n 5 100n 5 101n 0 145n 0 146n 5 300n 5 301n 0 345n 0 346n 5 400n 5)"
savecurrent=false
hide_texts=true}
N 1200 680 1200 720 {lab=SAE}
C {devices/lab_pin.sym} 1200 680 2 0 {name=lt122 lab=SAE}
N 1200 780 1200 820 {lab=GND}
C {devices/gnd.sym} 1200 820 0 0 {name=gsrc5 lab=GND}
T {PWL} 1225 740 0 0 0.25 0.25 {}
T {SEQUENCE / ns} 1750 -220 0 0 0.31 0.31 {}
T {0 - 100: WRITE Q = 1} 1750 -186 0 0 0.27 0.27 {}
T {100 - 200: READ Q = 1} 1750 -152 0 0 0.27 0.27 {}
T {200 - 300: WRITE Q = 0} 1750 -118 0 0 0.27 0.27 {}
T {300 - 400: READ Q = 0} 1750 -84 0 0 0.27 0.27 {}
T {EACH READ CYCLE (relative times)} 1750 -16 0 0 0.27 0.27 {}
T {0 - 1: PREB / SAE fall; precharge until 20} 1750 18 0 0 0.27 0.27 {}
T {20 - 21: precharge OFF} 1750 52 0 0 0.27 0.27 {}
T {35 - 36: WL rises; real cell discharges bitline} 1750 86 0 0 0.27 0.27 {}
T {45 - 46: SAE rises; sense and isolate} 1750 120 0 0 0.27 0.27 {}
T {65 - 66: WL returns LOW} 1750 154 0 0 0.27 0.27 {}
T {70: check SOUT/SOUTB match the stored bit} 1750 188 0 0 0.27 0.27 {}
T {SAE stays HIGH until the next read precharge} 1750 222 0 0 0.27 0.27 {}
T {90: check Q/QB still hold the original bit} 1750 256 0 0 0.27 0.27 {}
T {EACH WRITE CYCLE (relative times)} 1750 324 0 0 0.27 0.27 {}
T {0 - 20: bitline precharge only; SAE HIGH} 1750 358 0 0 0.27 0.27 {}
T {SAE HIGH throughout write: sense side isolated} 1750 392 0 0 0.27 0.27 {}
T {25 - 26: one pull-down turns ON} 1750 426 0 0 0.27 0.27 {}
T {35 - 36: WL rises} 1750 460 0 0 0.27 0.27 {}
T {65 - 66: WL returns LOW} 1750 494 0 0 0.27 0.27 {}
T {75 - 76: pull-down turns OFF} 1750 528 0 0 0.27 0.27 {}
T {90: check written Q/QB} 1750 562 0 0 0.27 0.27 {}
T {No sense-side reset during write} 1750 596 0 0 0.27 0.27 {}
T {Initial Q=0 / QB=5; output state is not forced.} 1750 664 0 0 0.27 0.27 {}
T {Sense reset checked at 119 ns and 319 ns.} 1750 698 0 0 0.27 0.27 {}
T {No decoder, column mux or output register yet.} 1750 732 0 0 0.27 0.27 {}
C {devices/code.sym} 1780 880 0 0 {name=TR_1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"}
C {devices/code.sym} 2150 880 0 0 {name=SIMULATION
only_toplevel=true
value=".param CBL=1p
.ic v(Q)=0 v(QB)=5
.control
save all
tran 0.02n 400n
let failures = 0
let bl_diff = v(BL)-v(BLB)
meas tran q_hold_0 find v(Q) at=90n
meas tran qb_hold_0 find v(QB) at=90n
if q_hold_0 < 4.5 or qb_hold_0 > 0.5
 let failures = failures + 1
end
meas tran q_hold_1 find v(Q) at=190n
meas tran qb_hold_1 find v(QB) at=190n
if q_hold_1 < 4.5 or qb_hold_1 > 0.5
 let failures = failures + 1
end
meas tran reset_1 find v(SOUT) at=119n
meas tran resetb_1 find v(SOUTB) at=119n
if reset_1 < 4.5 or resetb_1 < 4.5
 let failures = failures + 1
end
meas tran read_1 find v(SOUT) at=170n
meas tran readb_1 find v(SOUTB) at=170n
if read_1 < 4.5 or readb_1 > 0.5
 let failures = failures + 1
end
meas tran input_diff_1 find bl_diff at=145n
meas tran low_node_peak_1 max v(QB) from=135n to=166n
meas tran q_hold_2 find v(Q) at=290n
meas tran qb_hold_2 find v(QB) at=290n
if q_hold_2 > 0.5 or qb_hold_2 < 4.5
 let failures = failures + 1
end
meas tran q_hold_3 find v(Q) at=390n
meas tran qb_hold_3 find v(QB) at=390n
if q_hold_3 > 0.5 or qb_hold_3 < 4.5
 let failures = failures + 1
end
meas tran reset_3 find v(SOUT) at=319n
meas tran resetb_3 find v(SOUTB) at=319n
if reset_3 < 4.5 or resetb_3 < 4.5
 let failures = failures + 1
end
meas tran read_3 find v(SOUT) at=370n
meas tran readb_3 find v(SOUTB) at=370n
if read_3 > 0.5 or readb_3 < 4.5
 let failures = failures + 1
end
meas tran input_diff_3 find bl_diff at=345n
meas tran low_node_peak_3 max v(Q) from=335n to=366n
if failures = 0
 echo PASS: real-cell writes, sensed reads, reset and cell retention
else
 echo FAIL: inspect writes, sense outputs and cell retention
 print failures
end
write sram_tb_cell_sense.raw
plot v(Q) v(QB) ylimit -0.5 5.5 title 'CELL: write 1 / read 1 / write 0 / read 0'
plot v(BL) v(BLB) title 'BITLINES: actual cell discharge and sense loading'
plot v(BL) v(BLB) v(SOUT) v(SOUTB) xlimit 130n 170n title 'READ 1 ZOOM: WL rises at 135 ns / SAE rises at 145 ns'
plot v(SOUT) v(SOUTB) title 'SENSE OUTPUTS: check at 170 ns and 370 ns'
let PREB_T = v(PREB)/5+8
let WL_T = v(WL)/5+6
let SAE_T = v(SAE)/5+4
let PD_BL_T = v(PD_BL)/5+2
let PD_BLB_T = v(PD_BLB)/5+0
plot PREB_T WL_T SAE_T PD_BL_T PD_BLB_T ylimit -0.3 9.3 title 'CONTROLS: PREB+8 / WL+6 / SAE+4 / PD_BL+2 / PD_BLB+0'
.endc"}
C {devices/netlist_options.sym} 1750 1080 0 0 {name=NETLIST_OPTIONS
lvs_netlist=false
top_is_subckt=false
spiceprefix=true
hiersep=. }
