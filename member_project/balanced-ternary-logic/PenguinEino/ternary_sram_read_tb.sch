v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {TERNARY SRAM / FLOATING BITLINE READ / no precharge or sense amplifier} 40 -140 0 0 0.38 0.38 {}
T {Three separate runs: QINIT=-5 / 0 / +5 V, QBINIT=-QINIT. Bitlines initially 0 V.} 40 -80 0 0 0.24 0.24 {}
C {/home/ishi-kai/balanced-ternary-logic/ternary_sram.sym} 440 180 0 0 {name=xdut}
N 300 140 260 140 {lab=BL}
C {devices/lab_pin.sym} 260 140 0 0 {name=l1 lab=BL}
N 300 220 260 220 {lab=BLB}
C {devices/lab_pin.sym} 260 220 0 0 {name=l2 lab=BLB}
N 300 280 260 280 {lab=WL}
C {devices/lab_pin.sym} 260 280 0 0 {name=l3 lab=WL}
N 580 140 620 140 {lab=Q}
C {devices/lab_pin.sym} 620 140 0 1 {name=l4 lab=Q}
N 580 220 620 220 {lab=QB}
C {devices/lab_pin.sym} 620 220 0 1 {name=l5 lab=QB}
N 440 60 440 40 {lab=VDD}
C {devices/lab_pin.sym} 440 40 0 0 {name=l6 lab=VDD}
N 440 340 440 360 {lab=VSS}
C {devices/lab_pin.sym} 440 360 0 0 {name=l7 lab=VSS}
C {devices/capa.sym} 800 200 0 0 {name=CQ value=10f m=1}
C {devices/lab_pin.sym} 800 170 0 0 {name=l8 lab=Q}
C {devices/gnd.sym} 800 230 0 0 {name=l9 lab=GND}
C {devices/capa.sym} 1020 200 0 0 {name=CQB value=10f m=1}
C {devices/lab_pin.sym} 1020 170 0 0 {name=l10 lab=QB}
C {devices/gnd.sym} 1020 230 0 0 {name=l11 lab=GND}
C {devices/capa.sym} 180 460 0 0 {name=CBL value=10f m=1}
C {devices/lab_pin.sym} 180 430 0 0 {name=l12 lab=BL}
C {devices/gnd.sym} 180 490 0 0 {name=l13 lab=GND}
C {devices/capa.sym} 440 460 0 0 {name=CBLB value=10f m=1}
C {devices/lab_pin.sym} 440 430 0 0 {name=l14 lab=BLB}
C {devices/gnd.sym} 440 490 0 0 {name=l15 lab=GND}
C {devices/vsource.sym} 120 660 0 0 {name=VDD
value="5"
savecurrent=false
hide_texts=true}
C {devices/lab_pin.sym} 120 630 0 0 {name=l16 lab=VDD}
C {devices/gnd.sym} 120 690 0 0 {name=l17 lab=GND}
T {VDD} 150 650 0 0 0.24 0.24 {}
C {devices/vsource.sym} 360 660 0 0 {name=VSS
value="-5"
savecurrent=false
hide_texts=true}
C {devices/lab_pin.sym} 360 630 0 0 {name=l18 lab=VSS}
C {devices/gnd.sym} 360 690 0 0 {name=l19 lab=GND}
T {VSS} 390 650 0 0 0.24 0.24 {}
C {devices/vsource.sym} 660 660 0 0 {name=VWL
value="PWL(0 -5 200n -5 201n 5 700n 5 701n -5 1000n -5)"
savecurrent=false
hide_texts=true}
C {devices/lab_pin.sym} 660 630 0 0 {name=l20 lab=WL}
C {devices/gnd.sym} 660 690 0 0 {name=l21 lab=GND}
T {VWL} 690 650 0 0 0.24 0.24 {}
T {BL/BLB have capacitors only. No voltage source drives them during read.} 40 780 0 0 0.24 0.24 {}
T {Their starting voltages are explicit TB initial conditions, not a precharge circuit.} 40 825 0 0 0.24 0.24 {}
T {SEQUENCE / ns} 1260 -80 0 0 0.3 0.3 {}
T {0-200: WL OFF, retain state; BL/BLB float} 1260 -32 0 0 0.24 0.24 {}
T {200-201: WL rises to +5 V} 1260 16 0 0 0.24 0.24 {}
T {201-700: read into capacitive bitlines} 1260 64 0 0 0.24 0.24 {}
T {699: measure storage nodes and bitline differential} 1260 112 0 0 0.24 0.24 {}
T {700-701: WL falls to -5 V} 1260 160 0 0 0.24 0.24 {}
T {999: check retained Q/QB} 1260 208 0 0 0.24 0.24 {}
T {Storage tolerance +/-0.5 V; nonzero read |BL-BLB| > 1 V.} 1260 256 0 0 0.24 0.24 {}
T {Zero read: |BL-BLB| < 0.5 V; also check both near 0 V.} 1260 304 0 0 0.24 0.24 {}
T {NMOS read-high is not required to reach +5 V.} 1260 352 0 0 0.24 0.24 {}
T {BLINIT / BLBINIT in SIMULATION set bitline initial voltage.} 1260 400 0 0 0.24 0.24 {}
T {RUN: Netlist -> Simulate. Three state plots.} 1260 448 0 0 0.24 0.24 {}
C {devices/code.sym} 1260 660 0 0 {name=TR_1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"}
C {devices/code.sym} 1560 660 0 0 {name=SIMULATION
only_toplevel=true
value=".temp 27
.param QINIT=-5 BLINIT=0 BLBINIT=0
.ic v(Q)='QINIT' v(QB)='-QINIT' v(BL)='BLINIT' v(BLB)='BLBINIT'
.control
save all
set wr_singlescale
set wr_vecnames
setplot const
let failures=0
tran 0.2n 1000n 0 0.5n
let diff=v(BL)-v(BLB)
meas tran q0_199 find v(Q) at=199n
if abs(q0_199-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: q0_199 expected -5 V
end
meas tran qb0_199 find v(QB) at=199n
if abs(qb0_199-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: qb0_199 expected 5 V
end
meas tran q0_699 find v(Q) at=699n
if abs(q0_699-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: q0_699 expected -5 V
end
meas tran qb0_699 find v(QB) at=699n
if abs(qb0_699-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: qb0_699 expected 5 V
end
meas tran q0_999 find v(Q) at=999n
if abs(q0_999-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: q0_999 expected -5 V
end
meas tran qb0_999 find v(QB) at=999n
if abs(qb0_999-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: qb0_999 expected 5 V
end
meas tran read_diff_0 find diff at=699n
meas tran read_bl_0 find v(BL) at=699n
meas tran read_blb_0 find v(BLB) at=699n
if read_diff_0 > -1
let const.failures=const.failures+1
echo FAIL: read differential state -5
end
plot v(Q) v(QB) v(BL) v(BLB) ylimit -5.5 5.5 title 'SRAM floating read: initial Q=-5 V'
wrdata ternary_sram_read_0.txt v(Q) v(QB) v(BL) v(BLB) v(WL)
alterparam QINIT=0
reset
save all
tran 0.2n 1000n 0 0.5n
let diff=v(BL)-v(BLB)
meas tran q1_199 find v(Q) at=199n
if abs(q1_199-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: q1_199 expected 0 V
end
meas tran qb1_199 find v(QB) at=199n
if abs(qb1_199-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: qb1_199 expected 0 V
end
meas tran q1_699 find v(Q) at=699n
if abs(q1_699-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: q1_699 expected 0 V
end
meas tran qb1_699 find v(QB) at=699n
if abs(qb1_699-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: qb1_699 expected 0 V
end
meas tran q1_999 find v(Q) at=999n
if abs(q1_999-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: q1_999 expected 0 V
end
meas tran qb1_999 find v(QB) at=999n
if abs(qb1_999-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: qb1_999 expected 0 V
end
meas tran read_diff_1 find diff at=699n
meas tran read_bl_1 find v(BL) at=699n
meas tran read_blb_1 find v(BLB) at=699n
if abs(read_diff_1) > 0.5
let const.failures=const.failures+1
echo FAIL: read differential state 0
end
meas tran zero_bl find v(BL) at=699n
if abs(zero_bl-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: zero_bl expected 0 V
end
meas tran zero_blb find v(BLB) at=699n
if abs(zero_blb-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: zero_blb expected 0 V
end
plot v(Q) v(QB) v(BL) v(BLB) ylimit -5.5 5.5 title 'SRAM floating read: initial Q=0 V'
wrdata ternary_sram_read_1.txt v(Q) v(QB) v(BL) v(BLB) v(WL)
alterparam QINIT=5
reset
save all
tran 0.2n 1000n 0 0.5n
let diff=v(BL)-v(BLB)
meas tran q2_199 find v(Q) at=199n
if abs(q2_199-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: q2_199 expected 5 V
end
meas tran qb2_199 find v(QB) at=199n
if abs(qb2_199-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: qb2_199 expected -5 V
end
meas tran q2_699 find v(Q) at=699n
if abs(q2_699-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: q2_699 expected 5 V
end
meas tran qb2_699 find v(QB) at=699n
if abs(qb2_699-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: qb2_699 expected -5 V
end
meas tran q2_999 find v(Q) at=999n
if abs(q2_999-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: q2_999 expected 5 V
end
meas tran qb2_999 find v(QB) at=999n
if abs(qb2_999-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: qb2_999 expected -5 V
end
meas tran read_diff_2 find diff at=699n
meas tran read_bl_2 find v(BL) at=699n
meas tran read_blb_2 find v(BLB) at=699n
if read_diff_2 < 1
let const.failures=const.failures+1
echo FAIL: read differential state 5
end
plot v(Q) v(QB) v(BL) v(BLB) ylimit -5.5 5.5 title 'SRAM floating read: initial Q=5 V'
wrdata ternary_sram_read_2.txt v(Q) v(QB) v(BL) v(BLB) v(WL)
if const.failures = 0
echo PASS: three-state floating-bitline read and retention
else
echo FAIL: three-state floating-bitline read and retention
end
print const.failures
.endc"}
C {devices/netlist_options.sym} 1860 660 0 0 {name=NETLIST_OPTIONS
lvs_netlist=false
top_is_subckt=false
spiceprefix=true
hiersep=.}
