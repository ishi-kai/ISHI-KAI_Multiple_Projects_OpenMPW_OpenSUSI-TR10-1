v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {7T SENSE AMPLIFIER | STANDALONE TEST} -120 -240 0 0 0.45 0.45 {}
T {Ideal input pair / 5 V / alternate data on every cycle} -120 -190 0 0 0.3 0.3 {}
C {sense_amp_7t.sym} 300 100 0 0 {name=xsa}
C {devices/lab_pin.sym} 150 40 0 0 {name=l10 lab=BL}
C {devices/lab_pin.sym} 150 100 0 0 {name=l11 lab=BLB}
C {devices/lab_pin.sym} 150 160 0 0 {name=l12 lab=SAE}
C {devices/lab_pin.sym} 450 40 2 0 {name=l13 lab=SOUT}
C {devices/lab_pin.sym} 450 100 2 0 {name=l14 lab=SOUTB}
C {devices/lab_pin.sym} 300 -20 2 0 {name=l15 lab=VDD}
C {devices/gnd.sym} 300 220 0 0 {name=gsa lab=GND}
N 450 40 550 40 {lab=SOUT}
N 550 40 550 250 {lab=SOUT}
C {devices/capa.sym} 550 280 0 0 {name=CSOUT
m=1
value=10f}
C {devices/gnd.sym} 550 310 0 0 {name=gSOUT lab=GND}
N 450 100 710 100 {lab=SOUTB}
N 710 100 710 250 {lab=SOUTB}
C {devices/capa.sym} 710 280 0 0 {name=CSOUTB
m=1
value=10f}
C {devices/gnd.sym} 710 310 0 0 {name=gSOUTB lab=GND}
T {Output load: 10 fF each (assumed; no pad load)} -120 370 0 0 0.28 0.28 {}
T {Open sense_amp_7t.sch to inspect the seven transistors.} -120 410 0 0 0.28 0.28 {}
T {STIMULUS / edit VDIFF in SIMULATION} -120 490 0 0 0.32 0.32 {}
C {devices/vsource.sym} 0 620 0 0 {name=VVDD
value="5"
savecurrent=false
hide_texts=true}
N 0 550 0 590 {lab=VDD}
C {devices/lab_pin.sym} 0 550 2 0 {name=l30 lab=VDD}
N 0 650 0 690 {lab=GND}
C {devices/gnd.sym} 0 690 0 0 {name=gsrc0 lab=GND}
T {5 V} 25 610 0 0 0.25 0.25 {}
C {devices/vsource.sym} 210 620 0 0 {name=VBL
value="PWL(0n 5 120n 5 121n '5-VDIFF' 185n '5-VDIFF' 186n 5 320n 5 321n '5-VDIFF' 385n '5-VDIFF' 386n 5 400n 5)"
savecurrent=false
hide_texts=true}
N 210 550 210 590 {lab=BL}
C {devices/lab_pin.sym} 210 550 2 0 {name=l36 lab=BL}
N 210 650 210 690 {lab=GND}
C {devices/gnd.sym} 210 690 0 0 {name=gsrc1 lab=GND}
T {PWL} 235 610 0 0 0.25 0.25 {}
C {devices/vsource.sym} 420 620 0 0 {name=VBLB
value="PWL(0n 5 20n 5 21n '5-VDIFF' 85n '5-VDIFF' 86n 5 220n 5 221n '5-VDIFF' 285n '5-VDIFF' 286n 5 400n 5)"
savecurrent=false
hide_texts=true}
N 420 550 420 590 {lab=BLB}
C {devices/lab_pin.sym} 420 550 2 0 {name=l42 lab=BLB}
N 420 650 420 690 {lab=GND}
C {devices/gnd.sym} 420 690 0 0 {name=gsrc2 lab=GND}
T {PWL} 445 610 0 0 0.25 0.25 {}
C {devices/vsource.sym} 630 620 0 0 {name=VSAE
value="PWL(0n 0 40n 0 41n 5 80n 5 81n 0 140n 0 141n 5 180n 5 181n 0 240n 0 241n 5 280n 5 281n 0 340n 0 341n 5 380n 5 381n 0 400n 0)"
savecurrent=false
hide_texts=true}
N 630 550 630 590 {lab=SAE}
C {devices/lab_pin.sym} 630 550 2 0 {name=l48 lab=SAE}
N 630 650 630 690 {lab=GND}
C {devices/gnd.sym} 630 690 0 0 {name=gsrc3 lab=GND}
T {PWL} 655 610 0 0 0.25 0.25 {}
T {SEQUENCE / each cycle = 100 ns} 940 -150 0 0 0.31 0.31 {}
T {0 - 20: BL = BLB = 5 V, SAE = 0} 940 -115 0 0 0.27 0.27 {}
T {20 - 21: develop input voltage difference} 940 -80 0 0 0.27 0.27 {}
T {40 - 41: SAE rises; isolate and regenerate} 940 -45 0 0 0.27 0.27 {}
T {70: check SOUT / SOUTB} 940 -10 0 0 0.27 0.27 {}
T {80 - 81: SAE falls; return to tracking} 940 25 0 0 0.27 0.27 {}
T {85 - 86: both inputs return to 5 V} 940 60 0 0 0.27 0.27 {}
T {95: verify reset to HIGH / HIGH} 940 95 0 0 0.27 0.27 {}
T {EXPECTED OUTPUT AT 70 ns OF EACH CYCLE} 940 165 0 0 0.27 0.27 {}
T {Cycle 0 / 2: BL > BLB -> SOUT = 1} 940 200 0 0 0.27 0.27 {}
T {Cycle 1 / 3: BL < BLB -> SOUT = 0} 940 235 0 0 0.27 0.27 {}
T {VDIFF = 0.5 V; both polarities, no .ic} 940 305 0 0 0.27 0.27 {}
T {Perfectly matched nominal models only.} 940 340 0 0 0.27 0.27 {}
T {No column mux, SRAM cell or output buffer yet.} 940 375 0 0 0.27 0.27 {}
T {SAE resets the result: capture before SAE falls.} 940 410 0 0 0.27 0.27 {}
C {devices/code.sym} 970 560 0 0 {name=TR_1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"}
C {devices/code.sym} 1290 560 0 0 {name=SIMULATION
only_toplevel=true
value=".param VDIFF=0.5
.control
save all
tran 0.02n 400n
let failures = 0
meas tran out_0 find v(SOUT) at=70n
meas tran outb_0 find v(SOUTB) at=70n
if out_0 < 4.5 or outb_0 > 0.5
 let failures = failures + 1
end
meas tran reset_0 find v(SOUT) at=95n
meas tran resetb_0 find v(SOUTB) at=95n
if reset_0 < 4.5 or resetb_0 < 4.5
 let failures = failures + 1
end
meas tran out_1 find v(SOUT) at=170n
meas tran outb_1 find v(SOUTB) at=170n
if out_1 > 0.5 or outb_1 < 4.5
 let failures = failures + 1
end
meas tran reset_1 find v(SOUT) at=195n
meas tran resetb_1 find v(SOUTB) at=195n
if reset_1 < 4.5 or resetb_1 < 4.5
 let failures = failures + 1
end
meas tran out_2 find v(SOUT) at=270n
meas tran outb_2 find v(SOUTB) at=270n
if out_2 < 4.5 or outb_2 > 0.5
 let failures = failures + 1
end
meas tran reset_2 find v(SOUT) at=295n
meas tran resetb_2 find v(SOUTB) at=295n
if reset_2 < 4.5 or resetb_2 < 4.5
 let failures = failures + 1
end
meas tran out_3 find v(SOUT) at=370n
meas tran outb_3 find v(SOUTB) at=370n
if out_3 > 0.5 or outb_3 < 4.5
 let failures = failures + 1
end
meas tran reset_3 find v(SOUT) at=395n
meas tran resetb_3 find v(SOUTB) at=395n
if reset_3 < 4.5 or resetb_3 < 4.5
 let failures = failures + 1
end
if failures = 0
 echo PASS: both input polarities, alternating reads and reset
else
 echo FAIL: inspect output and reset measurements
 print failures
end
write sram_tb_sense_amp.raw
plot v(BL) v(BLB) ylimit 4.3 5.2 title 'INPUTS: precharge and differential voltage'
plot v(SOUT) v(SOUTB) ylimit -0.5 5.5 title 'OUTPUTS: valid while SAE is HIGH'
plot v(SAE) ylimit -0.5 5.5 title 'SAE: LOW tracks / HIGH regenerates'
.endc"}
C {devices/netlist_options.sym} 940 800 0 0 {name=NETLIST_OPTIONS
lvs_netlist=false
top_is_subckt=false
spiceprefix=true
hiersep=. }
