v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {NOR x6 / ERROR RESTORATION / y = -max(a,b)} 40 -180 0 0 0.4 0.4 {}
T {27 C / +/-5 V / real next-stage gates / final load 10 fF per chain} 40 -125 0 0 0.25 0.25 {}
T {A: A propagates; B = -5 V} 40 -90 0 0 0.3 0.3 {}
C {/home/ishi-kai/balanced-ternary-logic/nor.sym} 180 0 0 0 {name=xa1}
N 80 -20 120 -20 {lab=vin}
C {devices/lab_pin.sym} 80 -20 0 0 {name=l1 lab=vin}
N 80 20 120 20 {lab=V-}
C {devices/lab_pin.sym} 80 20 0 0 {name=l2 lab=V-}
N 250 0 295 0 {lab=a1}
C {devices/lab_pin.sym} 295 0 0 0 {name=l3 lab=a1}
C {devices/lab_pin.sym} 180 -60 0 0 {name=l4 lab=V+}
C {devices/lab_pin.sym} 180 60 0 0 {name=l5 lab=V-}
C {/home/ishi-kai/balanced-ternary-logic/nor.sym} 410 0 0 0 {name=xa2}
N 310 -20 350 -20 {lab=a1}
C {devices/lab_pin.sym} 310 -20 0 0 {name=l6 lab=a1}
N 310 20 350 20 {lab=V-}
C {devices/lab_pin.sym} 310 20 0 0 {name=l7 lab=V-}
N 480 0 525 0 {lab=a2}
C {devices/lab_pin.sym} 525 0 0 0 {name=l8 lab=a2}
C {devices/lab_pin.sym} 410 -60 0 0 {name=l9 lab=V+}
C {devices/lab_pin.sym} 410 60 0 0 {name=l10 lab=V-}
C {/home/ishi-kai/balanced-ternary-logic/nor.sym} 640 0 0 0 {name=xa3}
N 540 -20 580 -20 {lab=a2}
C {devices/lab_pin.sym} 540 -20 0 0 {name=l11 lab=a2}
N 540 20 580 20 {lab=V-}
C {devices/lab_pin.sym} 540 20 0 0 {name=l12 lab=V-}
N 710 0 755 0 {lab=a3}
C {devices/lab_pin.sym} 755 0 0 0 {name=l13 lab=a3}
C {devices/lab_pin.sym} 640 -60 0 0 {name=l14 lab=V+}
C {devices/lab_pin.sym} 640 60 0 0 {name=l15 lab=V-}
C {/home/ishi-kai/balanced-ternary-logic/nor.sym} 870 0 0 0 {name=xa4}
N 770 -20 810 -20 {lab=a3}
C {devices/lab_pin.sym} 770 -20 0 0 {name=l16 lab=a3}
N 770 20 810 20 {lab=V-}
C {devices/lab_pin.sym} 770 20 0 0 {name=l17 lab=V-}
N 940 0 985 0 {lab=a4}
C {devices/lab_pin.sym} 985 0 0 0 {name=l18 lab=a4}
C {devices/lab_pin.sym} 870 -60 0 0 {name=l19 lab=V+}
C {devices/lab_pin.sym} 870 60 0 0 {name=l20 lab=V-}
C {/home/ishi-kai/balanced-ternary-logic/nor.sym} 1100 0 0 0 {name=xa5}
N 1000 -20 1040 -20 {lab=a4}
C {devices/lab_pin.sym} 1000 -20 0 0 {name=l21 lab=a4}
N 1000 20 1040 20 {lab=V-}
C {devices/lab_pin.sym} 1000 20 0 0 {name=l22 lab=V-}
N 1170 0 1215 0 {lab=a5}
C {devices/lab_pin.sym} 1215 0 0 0 {name=l23 lab=a5}
C {devices/lab_pin.sym} 1100 -60 0 0 {name=l24 lab=V+}
C {devices/lab_pin.sym} 1100 60 0 0 {name=l25 lab=V-}
C {/home/ishi-kai/balanced-ternary-logic/nor.sym} 1330 0 0 0 {name=xa6}
N 1230 -20 1270 -20 {lab=a5}
C {devices/lab_pin.sym} 1230 -20 0 0 {name=l26 lab=a5}
N 1230 20 1270 20 {lab=V-}
C {devices/lab_pin.sym} 1230 20 0 0 {name=l27 lab=V-}
N 1400 0 1445 0 {lab=a6}
C {devices/lab_pin.sym} 1445 0 0 0 {name=l28 lab=a6}
C {devices/lab_pin.sym} 1330 -60 0 0 {name=l29 lab=V+}
C {devices/lab_pin.sym} 1330 60 0 0 {name=l30 lab=V-}
C {devices/capa.sym} 1510 30 0 0 {name=Ca value=10f m=1}
N 1445 0 1510 0 {lab=a6}
C {devices/gnd.sym} 1510 60 0 0 {name=ga lab=GND}
T {B: B propagates; A = -5 V} 40 210 0 0 0.3 0.3 {}
C {/home/ishi-kai/balanced-ternary-logic/nor.sym} 180 300 0 0 {name=xb1}
N 80 280 120 280 {lab=V-}
C {devices/lab_pin.sym} 80 280 0 0 {name=l31 lab=V-}
N 80 320 120 320 {lab=vin}
C {devices/lab_pin.sym} 80 320 0 0 {name=l32 lab=vin}
N 250 300 295 300 {lab=b1}
C {devices/lab_pin.sym} 295 300 0 0 {name=l33 lab=b1}
C {devices/lab_pin.sym} 180 240 0 0 {name=l34 lab=V+}
C {devices/lab_pin.sym} 180 360 0 0 {name=l35 lab=V-}
C {/home/ishi-kai/balanced-ternary-logic/nor.sym} 410 300 0 0 {name=xb2}
N 310 280 350 280 {lab=V-}
C {devices/lab_pin.sym} 310 280 0 0 {name=l36 lab=V-}
N 310 320 350 320 {lab=b1}
C {devices/lab_pin.sym} 310 320 0 0 {name=l37 lab=b1}
N 480 300 525 300 {lab=b2}
C {devices/lab_pin.sym} 525 300 0 0 {name=l38 lab=b2}
C {devices/lab_pin.sym} 410 240 0 0 {name=l39 lab=V+}
C {devices/lab_pin.sym} 410 360 0 0 {name=l40 lab=V-}
C {/home/ishi-kai/balanced-ternary-logic/nor.sym} 640 300 0 0 {name=xb3}
N 540 280 580 280 {lab=V-}
C {devices/lab_pin.sym} 540 280 0 0 {name=l41 lab=V-}
N 540 320 580 320 {lab=b2}
C {devices/lab_pin.sym} 540 320 0 0 {name=l42 lab=b2}
N 710 300 755 300 {lab=b3}
C {devices/lab_pin.sym} 755 300 0 0 {name=l43 lab=b3}
C {devices/lab_pin.sym} 640 240 0 0 {name=l44 lab=V+}
C {devices/lab_pin.sym} 640 360 0 0 {name=l45 lab=V-}
C {/home/ishi-kai/balanced-ternary-logic/nor.sym} 870 300 0 0 {name=xb4}
N 770 280 810 280 {lab=V-}
C {devices/lab_pin.sym} 770 280 0 0 {name=l46 lab=V-}
N 770 320 810 320 {lab=b3}
C {devices/lab_pin.sym} 770 320 0 0 {name=l47 lab=b3}
N 940 300 985 300 {lab=b4}
C {devices/lab_pin.sym} 985 300 0 0 {name=l48 lab=b4}
C {devices/lab_pin.sym} 870 240 0 0 {name=l49 lab=V+}
C {devices/lab_pin.sym} 870 360 0 0 {name=l50 lab=V-}
C {/home/ishi-kai/balanced-ternary-logic/nor.sym} 1100 300 0 0 {name=xb5}
N 1000 280 1040 280 {lab=V-}
C {devices/lab_pin.sym} 1000 280 0 0 {name=l51 lab=V-}
N 1000 320 1040 320 {lab=b4}
C {devices/lab_pin.sym} 1000 320 0 0 {name=l52 lab=b4}
N 1170 300 1215 300 {lab=b5}
C {devices/lab_pin.sym} 1215 300 0 0 {name=l53 lab=b5}
C {devices/lab_pin.sym} 1100 240 0 0 {name=l54 lab=V+}
C {devices/lab_pin.sym} 1100 360 0 0 {name=l55 lab=V-}
C {/home/ishi-kai/balanced-ternary-logic/nor.sym} 1330 300 0 0 {name=xb6}
N 1230 280 1270 280 {lab=V-}
C {devices/lab_pin.sym} 1230 280 0 0 {name=l56 lab=V-}
N 1230 320 1270 320 {lab=b5}
C {devices/lab_pin.sym} 1230 320 0 0 {name=l57 lab=b5}
N 1400 300 1445 300 {lab=b6}
C {devices/lab_pin.sym} 1445 300 0 0 {name=l58 lab=b6}
C {devices/lab_pin.sym} 1330 240 0 0 {name=l59 lab=V+}
C {devices/lab_pin.sym} 1330 360 0 0 {name=l60 lab=V-}
C {devices/capa.sym} 1510 330 0 0 {name=Cb value=10f m=1}
N 1445 300 1510 300 {lab=b6}
C {devices/gnd.sym} 1510 360 0 0 {name=gb lab=GND}
T {T: A and B tied; both propagate} 40 510 0 0 0.3 0.3 {}
C {/home/ishi-kai/balanced-ternary-logic/nor.sym} 180 600 0 0 {name=xt1}
N 80 580 120 580 {lab=vin}
C {devices/lab_pin.sym} 80 580 0 0 {name=l61 lab=vin}
N 80 620 120 620 {lab=vin}
C {devices/lab_pin.sym} 80 620 0 0 {name=l62 lab=vin}
N 250 600 295 600 {lab=t1}
C {devices/lab_pin.sym} 295 600 0 0 {name=l63 lab=t1}
C {devices/lab_pin.sym} 180 540 0 0 {name=l64 lab=V+}
C {devices/lab_pin.sym} 180 660 0 0 {name=l65 lab=V-}
C {/home/ishi-kai/balanced-ternary-logic/nor.sym} 410 600 0 0 {name=xt2}
N 310 580 350 580 {lab=t1}
C {devices/lab_pin.sym} 310 580 0 0 {name=l66 lab=t1}
N 310 620 350 620 {lab=t1}
C {devices/lab_pin.sym} 310 620 0 0 {name=l67 lab=t1}
N 480 600 525 600 {lab=t2}
C {devices/lab_pin.sym} 525 600 0 0 {name=l68 lab=t2}
C {devices/lab_pin.sym} 410 540 0 0 {name=l69 lab=V+}
C {devices/lab_pin.sym} 410 660 0 0 {name=l70 lab=V-}
C {/home/ishi-kai/balanced-ternary-logic/nor.sym} 640 600 0 0 {name=xt3}
N 540 580 580 580 {lab=t2}
C {devices/lab_pin.sym} 540 580 0 0 {name=l71 lab=t2}
N 540 620 580 620 {lab=t2}
C {devices/lab_pin.sym} 540 620 0 0 {name=l72 lab=t2}
N 710 600 755 600 {lab=t3}
C {devices/lab_pin.sym} 755 600 0 0 {name=l73 lab=t3}
C {devices/lab_pin.sym} 640 540 0 0 {name=l74 lab=V+}
C {devices/lab_pin.sym} 640 660 0 0 {name=l75 lab=V-}
C {/home/ishi-kai/balanced-ternary-logic/nor.sym} 870 600 0 0 {name=xt4}
N 770 580 810 580 {lab=t3}
C {devices/lab_pin.sym} 770 580 0 0 {name=l76 lab=t3}
N 770 620 810 620 {lab=t3}
C {devices/lab_pin.sym} 770 620 0 0 {name=l77 lab=t3}
N 940 600 985 600 {lab=t4}
C {devices/lab_pin.sym} 985 600 0 0 {name=l78 lab=t4}
C {devices/lab_pin.sym} 870 540 0 0 {name=l79 lab=V+}
C {devices/lab_pin.sym} 870 660 0 0 {name=l80 lab=V-}
C {/home/ishi-kai/balanced-ternary-logic/nor.sym} 1100 600 0 0 {name=xt5}
N 1000 580 1040 580 {lab=t4}
C {devices/lab_pin.sym} 1000 580 0 0 {name=l81 lab=t4}
N 1000 620 1040 620 {lab=t4}
C {devices/lab_pin.sym} 1000 620 0 0 {name=l82 lab=t4}
N 1170 600 1215 600 {lab=t5}
C {devices/lab_pin.sym} 1215 600 0 0 {name=l83 lab=t5}
C {devices/lab_pin.sym} 1100 540 0 0 {name=l84 lab=V+}
C {devices/lab_pin.sym} 1100 660 0 0 {name=l85 lab=V-}
C {/home/ishi-kai/balanced-ternary-logic/nor.sym} 1330 600 0 0 {name=xt6}
N 1230 580 1270 580 {lab=t5}
C {devices/lab_pin.sym} 1230 580 0 0 {name=l86 lab=t5}
N 1230 620 1270 620 {lab=t5}
C {devices/lab_pin.sym} 1230 620 0 0 {name=l87 lab=t5}
N 1400 600 1445 600 {lab=t6}
C {devices/lab_pin.sym} 1445 600 0 0 {name=l88 lab=t6}
C {devices/lab_pin.sym} 1330 540 0 0 {name=l89 lab=V+}
C {devices/lab_pin.sym} 1330 660 0 0 {name=l90 lab=V-}
C {devices/capa.sym} 1510 630 0 0 {name=Ct value=10f m=1}
N 1445 600 1510 600 {lab=t6}
C {devices/gnd.sym} 1510 660 0 0 {name=gt lab=GND}
C {devices/vsource.sym} 160 980 0 0 {name=VDD value="5" savecurrent=false hide_texts=true}
C {devices/lab_pin.sym} 160 950 0 0 {name=l91 lab=V+}
C {devices/gnd.sym} 160 1010 0 0 {name=gVDD lab=GND}
T {VDD: 5 V} 110 1060 0 0 0.25 0.25 {}
C {devices/vsource.sym} 450 980 0 0 {name=VSS value="-5" savecurrent=false hide_texts=true}
C {devices/lab_pin.sym} 450 950 0 0 {name=l92 lab=V-}
C {devices/gnd.sym} 450 1010 0 0 {name=gVSS lab=GND}
T {VSS: -5 V} 400 1060 0 0 0.25 0.25 {}
C {devices/vsource.sym} 740 980 0 0 {name=VIN value="PWL(0 -5 200n -5 201n 0 400n 0 401n 5 600n 5 601n 0 800n 0 801n -5 1000n -5 1001n 5 1200n 5 1201n -5 1400n -5 1401n -1 1600n -1 1601n -0.5 1800n -0.5 1801n -0.2 2000n -0.2 2001n 0 2200n 0 2201n 0.2 2400n 0.2 2401n 0.5 2600n 0.5 2601n 1 2800n 1 2801n 0 3000n 0)" savecurrent=false hide_texts=true}
C {devices/lab_pin.sym} 740 950 0 0 {name=l93 lab=vin}
C {devices/gnd.sym} 740 1010 0 0 {name=gVIN lab=GND}
T {VIN: PWL sequence ->} 690 1060 0 0 0.25 0.25 {}
T {SEQUENCE / 1 ns edges / 200 ns per interval} 1650 -175 0 0 0.3 0.3 {}
T {Interval [ns]       VIN [V]       Ideal odd / even       Sample [ns]} 1650 -130 0 0 0.25 0.25 {}
T {   0 -  200            -5                 +5 / -5                   199} 1650 -85 0 0 0.23 0.23 {}
T { 201 -  400            +0                 +0 / +0                   399} 1650 -47 0 0 0.23 0.23 {}
T { 401 -  600            +5                 -5 / +5                   599} 1650 -9 0 0 0.23 0.23 {}
T { 601 -  800            +0                 +0 / +0                   799} 1650 29 0 0 0.23 0.23 {}
T { 801 - 1000            -5                 +5 / -5                   999} 1650 67 0 0 0.23 0.23 {}
T {1001 - 1200            +5                 -5 / +5                   1199} 1650 105 0 0 0.23 0.23 {}
T {1201 - 1400            -5                 +5 / -5                   1399} 1650 143 0 0 0.23 0.23 {}
T {1401 - 1600            -1                 +0 / +0                   1599} 1650 181 0 0 0.23 0.23 {}
T {1601 - 1800          -0.5                 +0 / +0                   1799} 1650 219 0 0 0.23 0.23 {}
T {1801 - 2000          -0.2                 +0 / +0                   1999} 1650 257 0 0 0.23 0.23 {}
T {2001 - 2200            +0                 +0 / +0                   2199} 1650 295 0 0 0.23 0.23 {}
T {2201 - 2400          +0.2                 +0 / +0                   2399} 1650 333 0 0 0.23 0.23 {}
T {2401 - 2600          +0.5                 +0 / +0                   2599} 1650 371 0 0 0.23 0.23 {}
T {2601 - 2800            +1                 +0 / +0                   2799} 1650 409 0 0 0.23 0.23 {}
T {2801 - 3000            +0                 +0 / +0                   2999} 1650 447 0 0 0.23 0.23 {}
T {0 V tests: VIN = -1, -0.5, -0.2, 0, +0.2, +0.5, +1 V.} 1650 540 0 0 0.25 0.25 {}
T {Odd/even are ideal logic levels, not the analog input voltage.} 1650 580 0 0 0.25 0.25 {}
T {DC: full sweep sign-aligned; zero close-up shows actual stage voltages.} 1650 640 0 0 0.25 0.25 {}
T {Transient: all six rail transitions, then perturbed zero inputs.} 1650 680 0 0 0.25 0.25 {}
T {Measure EVERY stage at each sample; PASS tolerance = +/-0.5 V.} 1650 720 0 0 0.25 0.25 {}
T {Observe settling and whether errors converge, oscillate, or grow.} 1650 760 0 0 0.25 0.25 {}
T {RUN: disable LVS -> Netlist -> Simulate (native ngspice plots).} 1650 820 0 0 0.28 0.28 {}
T {No internal load C in nor.sch. No added interstage C.} 40 1130 0 0 0.25 0.25 {}
T {Each row is an independent fanout-one chain; tied row drives both inputs.} 40 1170 0 0 0.25 0.25 {}
C {devices/code.sym} 1650 1000 0 0 {name=MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"}
C {devices/code.sym} 1930 1000 0 0 {name=SIMULATION
only_toplevel=true
value=".temp 27
.options rshunt=1e12
.control
save all
set wr_singlescale
set wr_vecnames
setplot const
let failures=0
dc VIN -5 5 0.025
let as1=-v(a1)
let as2=v(a2)
let as3=-v(a3)
let as4=v(a4)
let as5=-v(a5)
let as6=v(a6)
plot v(vin) as1 as2 as3 as4 as5 as6 ylimit -5.5 5.5 title 'NOR a: DC sign-aligned stages'
plot v(vin) v(a1) v(a2) v(a3) v(a4) v(a5) v(a6) xlimit -1 1 ylimit -0.7 0.7 title 'NOR a: zero restoration actual voltages'
let bs1=-v(b1)
let bs2=v(b2)
let bs3=-v(b3)
let bs4=v(b4)
let bs5=-v(b5)
let bs6=v(b6)
plot v(vin) bs1 bs2 bs3 bs4 bs5 bs6 ylimit -5.5 5.5 title 'NOR b: DC sign-aligned stages'
plot v(vin) v(b1) v(b2) v(b3) v(b4) v(b5) v(b6) xlimit -1 1 ylimit -0.7 0.7 title 'NOR b: zero restoration actual voltages'
let ts1=-v(t1)
let ts2=v(t2)
let ts3=-v(t3)
let ts4=v(t4)
let ts5=-v(t5)
let ts6=v(t6)
plot v(vin) ts1 ts2 ts3 ts4 ts5 ts6 ylimit -5.5 5.5 title 'NOR t: DC sign-aligned stages'
plot v(vin) v(t1) v(t2) v(t3) v(t4) v(t5) v(t6) xlimit -1 1 ylimit -0.7 0.7 title 'NOR t: zero restoration actual voltages'
wrdata nor_chain_dc.txt v(vin) v(a1) v(a2) v(a3) v(a4) v(a5) v(a6) v(b1) v(b2) v(b3) v(b4) v(b5) v(b6) v(t1) v(t2) v(t3) v(t4) v(t5) v(t6)
reset
tran 0.2n 3000n
plot v(vin) v(a1) v(a2) v(a3) v(a4) v(a5) v(a6) title 'NOR a: all six stages'
plot v(vin) v(a1) v(a2) v(a3) v(a4) v(a5) v(a6) xlimit 1.4u 3u ylimit -1.1 1.1 title 'NOR a: perturbed zero propagation'
plot v(vin) v(b1) v(b2) v(b3) v(b4) v(b5) v(b6) title 'NOR b: all six stages'
plot v(vin) v(b1) v(b2) v(b3) v(b4) v(b5) v(b6) xlimit 1.4u 3u ylimit -1.1 1.1 title 'NOR b: perturbed zero propagation'
plot v(vin) v(t1) v(t2) v(t3) v(t4) v(t5) v(t6) title 'NOR t: all six stages'
plot v(vin) v(t1) v(t2) v(t3) v(t4) v(t5) v(t6) xlimit 1.4u 3u ylimit -1.1 1.1 title 'NOR t: perturbed zero propagation'
wrdata nor_chain_tran.txt v(vin) v(a1) v(a2) v(a3) v(a4) v(a5) v(a6) v(b1) v(b2) v(b3) v(b4) v(b5) v(b6) v(t1) v(t2) v(t3) v(t4) v(t5) v(t6)
meas tran a1_sample01 find v(a1) at=199n
if abs(a1_sample01-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: a1_sample01 expected 5 V
end
meas tran a2_sample01 find v(a2) at=199n
if abs(a2_sample01-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: a2_sample01 expected -5 V
end
meas tran a3_sample01 find v(a3) at=199n
if abs(a3_sample01-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: a3_sample01 expected 5 V
end
meas tran a4_sample01 find v(a4) at=199n
if abs(a4_sample01-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: a4_sample01 expected -5 V
end
meas tran a5_sample01 find v(a5) at=199n
if abs(a5_sample01-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: a5_sample01 expected 5 V
end
meas tran a6_sample01 find v(a6) at=199n
if abs(a6_sample01-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: a6_sample01 expected -5 V
end
meas tran b1_sample01 find v(b1) at=199n
if abs(b1_sample01-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: b1_sample01 expected 5 V
end
meas tran b2_sample01 find v(b2) at=199n
if abs(b2_sample01-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: b2_sample01 expected -5 V
end
meas tran b3_sample01 find v(b3) at=199n
if abs(b3_sample01-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: b3_sample01 expected 5 V
end
meas tran b4_sample01 find v(b4) at=199n
if abs(b4_sample01-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: b4_sample01 expected -5 V
end
meas tran b5_sample01 find v(b5) at=199n
if abs(b5_sample01-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: b5_sample01 expected 5 V
end
meas tran b6_sample01 find v(b6) at=199n
if abs(b6_sample01-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: b6_sample01 expected -5 V
end
meas tran t1_sample01 find v(t1) at=199n
if abs(t1_sample01-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: t1_sample01 expected 5 V
end
meas tran t2_sample01 find v(t2) at=199n
if abs(t2_sample01-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: t2_sample01 expected -5 V
end
meas tran t3_sample01 find v(t3) at=199n
if abs(t3_sample01-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: t3_sample01 expected 5 V
end
meas tran t4_sample01 find v(t4) at=199n
if abs(t4_sample01-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: t4_sample01 expected -5 V
end
meas tran t5_sample01 find v(t5) at=199n
if abs(t5_sample01-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: t5_sample01 expected 5 V
end
meas tran t6_sample01 find v(t6) at=199n
if abs(t6_sample01-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: t6_sample01 expected -5 V
end
meas tran a1_sample02 find v(a1) at=399n
if abs(a1_sample02-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a1_sample02 expected 0 V
end
meas tran a2_sample02 find v(a2) at=399n
if abs(a2_sample02-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a2_sample02 expected 0 V
end
meas tran a3_sample02 find v(a3) at=399n
if abs(a3_sample02-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a3_sample02 expected 0 V
end
meas tran a4_sample02 find v(a4) at=399n
if abs(a4_sample02-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a4_sample02 expected 0 V
end
meas tran a5_sample02 find v(a5) at=399n
if abs(a5_sample02-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a5_sample02 expected 0 V
end
meas tran a6_sample02 find v(a6) at=399n
if abs(a6_sample02-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a6_sample02 expected 0 V
end
meas tran b1_sample02 find v(b1) at=399n
if abs(b1_sample02-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b1_sample02 expected 0 V
end
meas tran b2_sample02 find v(b2) at=399n
if abs(b2_sample02-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b2_sample02 expected 0 V
end
meas tran b3_sample02 find v(b3) at=399n
if abs(b3_sample02-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b3_sample02 expected 0 V
end
meas tran b4_sample02 find v(b4) at=399n
if abs(b4_sample02-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b4_sample02 expected 0 V
end
meas tran b5_sample02 find v(b5) at=399n
if abs(b5_sample02-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b5_sample02 expected 0 V
end
meas tran b6_sample02 find v(b6) at=399n
if abs(b6_sample02-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b6_sample02 expected 0 V
end
meas tran t1_sample02 find v(t1) at=399n
if abs(t1_sample02-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t1_sample02 expected 0 V
end
meas tran t2_sample02 find v(t2) at=399n
if abs(t2_sample02-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t2_sample02 expected 0 V
end
meas tran t3_sample02 find v(t3) at=399n
if abs(t3_sample02-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t3_sample02 expected 0 V
end
meas tran t4_sample02 find v(t4) at=399n
if abs(t4_sample02-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t4_sample02 expected 0 V
end
meas tran t5_sample02 find v(t5) at=399n
if abs(t5_sample02-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t5_sample02 expected 0 V
end
meas tran t6_sample02 find v(t6) at=399n
if abs(t6_sample02-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t6_sample02 expected 0 V
end
meas tran a1_sample03 find v(a1) at=599n
if abs(a1_sample03-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: a1_sample03 expected -5 V
end
meas tran a2_sample03 find v(a2) at=599n
if abs(a2_sample03-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: a2_sample03 expected 5 V
end
meas tran a3_sample03 find v(a3) at=599n
if abs(a3_sample03-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: a3_sample03 expected -5 V
end
meas tran a4_sample03 find v(a4) at=599n
if abs(a4_sample03-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: a4_sample03 expected 5 V
end
meas tran a5_sample03 find v(a5) at=599n
if abs(a5_sample03-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: a5_sample03 expected -5 V
end
meas tran a6_sample03 find v(a6) at=599n
if abs(a6_sample03-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: a6_sample03 expected 5 V
end
meas tran b1_sample03 find v(b1) at=599n
if abs(b1_sample03-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: b1_sample03 expected -5 V
end
meas tran b2_sample03 find v(b2) at=599n
if abs(b2_sample03-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: b2_sample03 expected 5 V
end
meas tran b3_sample03 find v(b3) at=599n
if abs(b3_sample03-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: b3_sample03 expected -5 V
end
meas tran b4_sample03 find v(b4) at=599n
if abs(b4_sample03-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: b4_sample03 expected 5 V
end
meas tran b5_sample03 find v(b5) at=599n
if abs(b5_sample03-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: b5_sample03 expected -5 V
end
meas tran b6_sample03 find v(b6) at=599n
if abs(b6_sample03-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: b6_sample03 expected 5 V
end
meas tran t1_sample03 find v(t1) at=599n
if abs(t1_sample03-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: t1_sample03 expected -5 V
end
meas tran t2_sample03 find v(t2) at=599n
if abs(t2_sample03-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: t2_sample03 expected 5 V
end
meas tran t3_sample03 find v(t3) at=599n
if abs(t3_sample03-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: t3_sample03 expected -5 V
end
meas tran t4_sample03 find v(t4) at=599n
if abs(t4_sample03-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: t4_sample03 expected 5 V
end
meas tran t5_sample03 find v(t5) at=599n
if abs(t5_sample03-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: t5_sample03 expected -5 V
end
meas tran t6_sample03 find v(t6) at=599n
if abs(t6_sample03-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: t6_sample03 expected 5 V
end
meas tran a1_sample04 find v(a1) at=799n
if abs(a1_sample04-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a1_sample04 expected 0 V
end
meas tran a2_sample04 find v(a2) at=799n
if abs(a2_sample04-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a2_sample04 expected 0 V
end
meas tran a3_sample04 find v(a3) at=799n
if abs(a3_sample04-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a3_sample04 expected 0 V
end
meas tran a4_sample04 find v(a4) at=799n
if abs(a4_sample04-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a4_sample04 expected 0 V
end
meas tran a5_sample04 find v(a5) at=799n
if abs(a5_sample04-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a5_sample04 expected 0 V
end
meas tran a6_sample04 find v(a6) at=799n
if abs(a6_sample04-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a6_sample04 expected 0 V
end
meas tran b1_sample04 find v(b1) at=799n
if abs(b1_sample04-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b1_sample04 expected 0 V
end
meas tran b2_sample04 find v(b2) at=799n
if abs(b2_sample04-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b2_sample04 expected 0 V
end
meas tran b3_sample04 find v(b3) at=799n
if abs(b3_sample04-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b3_sample04 expected 0 V
end
meas tran b4_sample04 find v(b4) at=799n
if abs(b4_sample04-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b4_sample04 expected 0 V
end
meas tran b5_sample04 find v(b5) at=799n
if abs(b5_sample04-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b5_sample04 expected 0 V
end
meas tran b6_sample04 find v(b6) at=799n
if abs(b6_sample04-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b6_sample04 expected 0 V
end
meas tran t1_sample04 find v(t1) at=799n
if abs(t1_sample04-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t1_sample04 expected 0 V
end
meas tran t2_sample04 find v(t2) at=799n
if abs(t2_sample04-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t2_sample04 expected 0 V
end
meas tran t3_sample04 find v(t3) at=799n
if abs(t3_sample04-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t3_sample04 expected 0 V
end
meas tran t4_sample04 find v(t4) at=799n
if abs(t4_sample04-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t4_sample04 expected 0 V
end
meas tran t5_sample04 find v(t5) at=799n
if abs(t5_sample04-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t5_sample04 expected 0 V
end
meas tran t6_sample04 find v(t6) at=799n
if abs(t6_sample04-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t6_sample04 expected 0 V
end
meas tran a1_sample05 find v(a1) at=999n
if abs(a1_sample05-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: a1_sample05 expected 5 V
end
meas tran a2_sample05 find v(a2) at=999n
if abs(a2_sample05-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: a2_sample05 expected -5 V
end
meas tran a3_sample05 find v(a3) at=999n
if abs(a3_sample05-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: a3_sample05 expected 5 V
end
meas tran a4_sample05 find v(a4) at=999n
if abs(a4_sample05-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: a4_sample05 expected -5 V
end
meas tran a5_sample05 find v(a5) at=999n
if abs(a5_sample05-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: a5_sample05 expected 5 V
end
meas tran a6_sample05 find v(a6) at=999n
if abs(a6_sample05-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: a6_sample05 expected -5 V
end
meas tran b1_sample05 find v(b1) at=999n
if abs(b1_sample05-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: b1_sample05 expected 5 V
end
meas tran b2_sample05 find v(b2) at=999n
if abs(b2_sample05-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: b2_sample05 expected -5 V
end
meas tran b3_sample05 find v(b3) at=999n
if abs(b3_sample05-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: b3_sample05 expected 5 V
end
meas tran b4_sample05 find v(b4) at=999n
if abs(b4_sample05-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: b4_sample05 expected -5 V
end
meas tran b5_sample05 find v(b5) at=999n
if abs(b5_sample05-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: b5_sample05 expected 5 V
end
meas tran b6_sample05 find v(b6) at=999n
if abs(b6_sample05-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: b6_sample05 expected -5 V
end
meas tran t1_sample05 find v(t1) at=999n
if abs(t1_sample05-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: t1_sample05 expected 5 V
end
meas tran t2_sample05 find v(t2) at=999n
if abs(t2_sample05-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: t2_sample05 expected -5 V
end
meas tran t3_sample05 find v(t3) at=999n
if abs(t3_sample05-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: t3_sample05 expected 5 V
end
meas tran t4_sample05 find v(t4) at=999n
if abs(t4_sample05-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: t4_sample05 expected -5 V
end
meas tran t5_sample05 find v(t5) at=999n
if abs(t5_sample05-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: t5_sample05 expected 5 V
end
meas tran t6_sample05 find v(t6) at=999n
if abs(t6_sample05-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: t6_sample05 expected -5 V
end
meas tran a1_sample06 find v(a1) at=1199n
if abs(a1_sample06-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: a1_sample06 expected -5 V
end
meas tran a2_sample06 find v(a2) at=1199n
if abs(a2_sample06-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: a2_sample06 expected 5 V
end
meas tran a3_sample06 find v(a3) at=1199n
if abs(a3_sample06-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: a3_sample06 expected -5 V
end
meas tran a4_sample06 find v(a4) at=1199n
if abs(a4_sample06-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: a4_sample06 expected 5 V
end
meas tran a5_sample06 find v(a5) at=1199n
if abs(a5_sample06-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: a5_sample06 expected -5 V
end
meas tran a6_sample06 find v(a6) at=1199n
if abs(a6_sample06-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: a6_sample06 expected 5 V
end
meas tran b1_sample06 find v(b1) at=1199n
if abs(b1_sample06-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: b1_sample06 expected -5 V
end
meas tran b2_sample06 find v(b2) at=1199n
if abs(b2_sample06-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: b2_sample06 expected 5 V
end
meas tran b3_sample06 find v(b3) at=1199n
if abs(b3_sample06-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: b3_sample06 expected -5 V
end
meas tran b4_sample06 find v(b4) at=1199n
if abs(b4_sample06-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: b4_sample06 expected 5 V
end
meas tran b5_sample06 find v(b5) at=1199n
if abs(b5_sample06-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: b5_sample06 expected -5 V
end
meas tran b6_sample06 find v(b6) at=1199n
if abs(b6_sample06-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: b6_sample06 expected 5 V
end
meas tran t1_sample06 find v(t1) at=1199n
if abs(t1_sample06-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: t1_sample06 expected -5 V
end
meas tran t2_sample06 find v(t2) at=1199n
if abs(t2_sample06-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: t2_sample06 expected 5 V
end
meas tran t3_sample06 find v(t3) at=1199n
if abs(t3_sample06-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: t3_sample06 expected -5 V
end
meas tran t4_sample06 find v(t4) at=1199n
if abs(t4_sample06-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: t4_sample06 expected 5 V
end
meas tran t5_sample06 find v(t5) at=1199n
if abs(t5_sample06-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: t5_sample06 expected -5 V
end
meas tran t6_sample06 find v(t6) at=1199n
if abs(t6_sample06-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: t6_sample06 expected 5 V
end
meas tran a1_sample07 find v(a1) at=1399n
if abs(a1_sample07-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: a1_sample07 expected 5 V
end
meas tran a2_sample07 find v(a2) at=1399n
if abs(a2_sample07-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: a2_sample07 expected -5 V
end
meas tran a3_sample07 find v(a3) at=1399n
if abs(a3_sample07-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: a3_sample07 expected 5 V
end
meas tran a4_sample07 find v(a4) at=1399n
if abs(a4_sample07-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: a4_sample07 expected -5 V
end
meas tran a5_sample07 find v(a5) at=1399n
if abs(a5_sample07-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: a5_sample07 expected 5 V
end
meas tran a6_sample07 find v(a6) at=1399n
if abs(a6_sample07-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: a6_sample07 expected -5 V
end
meas tran b1_sample07 find v(b1) at=1399n
if abs(b1_sample07-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: b1_sample07 expected 5 V
end
meas tran b2_sample07 find v(b2) at=1399n
if abs(b2_sample07-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: b2_sample07 expected -5 V
end
meas tran b3_sample07 find v(b3) at=1399n
if abs(b3_sample07-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: b3_sample07 expected 5 V
end
meas tran b4_sample07 find v(b4) at=1399n
if abs(b4_sample07-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: b4_sample07 expected -5 V
end
meas tran b5_sample07 find v(b5) at=1399n
if abs(b5_sample07-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: b5_sample07 expected 5 V
end
meas tran b6_sample07 find v(b6) at=1399n
if abs(b6_sample07-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: b6_sample07 expected -5 V
end
meas tran t1_sample07 find v(t1) at=1399n
if abs(t1_sample07-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: t1_sample07 expected 5 V
end
meas tran t2_sample07 find v(t2) at=1399n
if abs(t2_sample07-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: t2_sample07 expected -5 V
end
meas tran t3_sample07 find v(t3) at=1399n
if abs(t3_sample07-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: t3_sample07 expected 5 V
end
meas tran t4_sample07 find v(t4) at=1399n
if abs(t4_sample07-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: t4_sample07 expected -5 V
end
meas tran t5_sample07 find v(t5) at=1399n
if abs(t5_sample07-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: t5_sample07 expected 5 V
end
meas tran t6_sample07 find v(t6) at=1399n
if abs(t6_sample07-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: t6_sample07 expected -5 V
end
meas tran a1_sample08 find v(a1) at=1599n
if abs(a1_sample08-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a1_sample08 expected 0 V
end
meas tran a2_sample08 find v(a2) at=1599n
if abs(a2_sample08-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a2_sample08 expected 0 V
end
meas tran a3_sample08 find v(a3) at=1599n
if abs(a3_sample08-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a3_sample08 expected 0 V
end
meas tran a4_sample08 find v(a4) at=1599n
if abs(a4_sample08-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a4_sample08 expected 0 V
end
meas tran a5_sample08 find v(a5) at=1599n
if abs(a5_sample08-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a5_sample08 expected 0 V
end
meas tran a6_sample08 find v(a6) at=1599n
if abs(a6_sample08-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a6_sample08 expected 0 V
end
meas tran b1_sample08 find v(b1) at=1599n
if abs(b1_sample08-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b1_sample08 expected 0 V
end
meas tran b2_sample08 find v(b2) at=1599n
if abs(b2_sample08-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b2_sample08 expected 0 V
end
meas tran b3_sample08 find v(b3) at=1599n
if abs(b3_sample08-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b3_sample08 expected 0 V
end
meas tran b4_sample08 find v(b4) at=1599n
if abs(b4_sample08-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b4_sample08 expected 0 V
end
meas tran b5_sample08 find v(b5) at=1599n
if abs(b5_sample08-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b5_sample08 expected 0 V
end
meas tran b6_sample08 find v(b6) at=1599n
if abs(b6_sample08-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b6_sample08 expected 0 V
end
meas tran t1_sample08 find v(t1) at=1599n
if abs(t1_sample08-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t1_sample08 expected 0 V
end
meas tran t2_sample08 find v(t2) at=1599n
if abs(t2_sample08-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t2_sample08 expected 0 V
end
meas tran t3_sample08 find v(t3) at=1599n
if abs(t3_sample08-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t3_sample08 expected 0 V
end
meas tran t4_sample08 find v(t4) at=1599n
if abs(t4_sample08-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t4_sample08 expected 0 V
end
meas tran t5_sample08 find v(t5) at=1599n
if abs(t5_sample08-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t5_sample08 expected 0 V
end
meas tran t6_sample08 find v(t6) at=1599n
if abs(t6_sample08-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t6_sample08 expected 0 V
end
meas tran a1_sample09 find v(a1) at=1799n
if abs(a1_sample09-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a1_sample09 expected 0 V
end
meas tran a2_sample09 find v(a2) at=1799n
if abs(a2_sample09-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a2_sample09 expected 0 V
end
meas tran a3_sample09 find v(a3) at=1799n
if abs(a3_sample09-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a3_sample09 expected 0 V
end
meas tran a4_sample09 find v(a4) at=1799n
if abs(a4_sample09-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a4_sample09 expected 0 V
end
meas tran a5_sample09 find v(a5) at=1799n
if abs(a5_sample09-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a5_sample09 expected 0 V
end
meas tran a6_sample09 find v(a6) at=1799n
if abs(a6_sample09-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a6_sample09 expected 0 V
end
meas tran b1_sample09 find v(b1) at=1799n
if abs(b1_sample09-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b1_sample09 expected 0 V
end
meas tran b2_sample09 find v(b2) at=1799n
if abs(b2_sample09-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b2_sample09 expected 0 V
end
meas tran b3_sample09 find v(b3) at=1799n
if abs(b3_sample09-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b3_sample09 expected 0 V
end
meas tran b4_sample09 find v(b4) at=1799n
if abs(b4_sample09-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b4_sample09 expected 0 V
end
meas tran b5_sample09 find v(b5) at=1799n
if abs(b5_sample09-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b5_sample09 expected 0 V
end
meas tran b6_sample09 find v(b6) at=1799n
if abs(b6_sample09-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b6_sample09 expected 0 V
end
meas tran t1_sample09 find v(t1) at=1799n
if abs(t1_sample09-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t1_sample09 expected 0 V
end
meas tran t2_sample09 find v(t2) at=1799n
if abs(t2_sample09-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t2_sample09 expected 0 V
end
meas tran t3_sample09 find v(t3) at=1799n
if abs(t3_sample09-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t3_sample09 expected 0 V
end
meas tran t4_sample09 find v(t4) at=1799n
if abs(t4_sample09-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t4_sample09 expected 0 V
end
meas tran t5_sample09 find v(t5) at=1799n
if abs(t5_sample09-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t5_sample09 expected 0 V
end
meas tran t6_sample09 find v(t6) at=1799n
if abs(t6_sample09-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t6_sample09 expected 0 V
end
meas tran a1_sample10 find v(a1) at=1999n
if abs(a1_sample10-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a1_sample10 expected 0 V
end
meas tran a2_sample10 find v(a2) at=1999n
if abs(a2_sample10-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a2_sample10 expected 0 V
end
meas tran a3_sample10 find v(a3) at=1999n
if abs(a3_sample10-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a3_sample10 expected 0 V
end
meas tran a4_sample10 find v(a4) at=1999n
if abs(a4_sample10-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a4_sample10 expected 0 V
end
meas tran a5_sample10 find v(a5) at=1999n
if abs(a5_sample10-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a5_sample10 expected 0 V
end
meas tran a6_sample10 find v(a6) at=1999n
if abs(a6_sample10-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a6_sample10 expected 0 V
end
meas tran b1_sample10 find v(b1) at=1999n
if abs(b1_sample10-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b1_sample10 expected 0 V
end
meas tran b2_sample10 find v(b2) at=1999n
if abs(b2_sample10-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b2_sample10 expected 0 V
end
meas tran b3_sample10 find v(b3) at=1999n
if abs(b3_sample10-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b3_sample10 expected 0 V
end
meas tran b4_sample10 find v(b4) at=1999n
if abs(b4_sample10-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b4_sample10 expected 0 V
end
meas tran b5_sample10 find v(b5) at=1999n
if abs(b5_sample10-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b5_sample10 expected 0 V
end
meas tran b6_sample10 find v(b6) at=1999n
if abs(b6_sample10-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b6_sample10 expected 0 V
end
meas tran t1_sample10 find v(t1) at=1999n
if abs(t1_sample10-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t1_sample10 expected 0 V
end
meas tran t2_sample10 find v(t2) at=1999n
if abs(t2_sample10-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t2_sample10 expected 0 V
end
meas tran t3_sample10 find v(t3) at=1999n
if abs(t3_sample10-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t3_sample10 expected 0 V
end
meas tran t4_sample10 find v(t4) at=1999n
if abs(t4_sample10-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t4_sample10 expected 0 V
end
meas tran t5_sample10 find v(t5) at=1999n
if abs(t5_sample10-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t5_sample10 expected 0 V
end
meas tran t6_sample10 find v(t6) at=1999n
if abs(t6_sample10-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t6_sample10 expected 0 V
end
meas tran a1_sample11 find v(a1) at=2199n
if abs(a1_sample11-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a1_sample11 expected 0 V
end
meas tran a2_sample11 find v(a2) at=2199n
if abs(a2_sample11-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a2_sample11 expected 0 V
end
meas tran a3_sample11 find v(a3) at=2199n
if abs(a3_sample11-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a3_sample11 expected 0 V
end
meas tran a4_sample11 find v(a4) at=2199n
if abs(a4_sample11-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a4_sample11 expected 0 V
end
meas tran a5_sample11 find v(a5) at=2199n
if abs(a5_sample11-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a5_sample11 expected 0 V
end
meas tran a6_sample11 find v(a6) at=2199n
if abs(a6_sample11-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a6_sample11 expected 0 V
end
meas tran b1_sample11 find v(b1) at=2199n
if abs(b1_sample11-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b1_sample11 expected 0 V
end
meas tran b2_sample11 find v(b2) at=2199n
if abs(b2_sample11-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b2_sample11 expected 0 V
end
meas tran b3_sample11 find v(b3) at=2199n
if abs(b3_sample11-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b3_sample11 expected 0 V
end
meas tran b4_sample11 find v(b4) at=2199n
if abs(b4_sample11-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b4_sample11 expected 0 V
end
meas tran b5_sample11 find v(b5) at=2199n
if abs(b5_sample11-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b5_sample11 expected 0 V
end
meas tran b6_sample11 find v(b6) at=2199n
if abs(b6_sample11-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b6_sample11 expected 0 V
end
meas tran t1_sample11 find v(t1) at=2199n
if abs(t1_sample11-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t1_sample11 expected 0 V
end
meas tran t2_sample11 find v(t2) at=2199n
if abs(t2_sample11-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t2_sample11 expected 0 V
end
meas tran t3_sample11 find v(t3) at=2199n
if abs(t3_sample11-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t3_sample11 expected 0 V
end
meas tran t4_sample11 find v(t4) at=2199n
if abs(t4_sample11-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t4_sample11 expected 0 V
end
meas tran t5_sample11 find v(t5) at=2199n
if abs(t5_sample11-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t5_sample11 expected 0 V
end
meas tran t6_sample11 find v(t6) at=2199n
if abs(t6_sample11-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t6_sample11 expected 0 V
end
meas tran a1_sample12 find v(a1) at=2399n
if abs(a1_sample12-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a1_sample12 expected 0 V
end
meas tran a2_sample12 find v(a2) at=2399n
if abs(a2_sample12-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a2_sample12 expected 0 V
end
meas tran a3_sample12 find v(a3) at=2399n
if abs(a3_sample12-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a3_sample12 expected 0 V
end
meas tran a4_sample12 find v(a4) at=2399n
if abs(a4_sample12-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a4_sample12 expected 0 V
end
meas tran a5_sample12 find v(a5) at=2399n
if abs(a5_sample12-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a5_sample12 expected 0 V
end
meas tran a6_sample12 find v(a6) at=2399n
if abs(a6_sample12-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a6_sample12 expected 0 V
end
meas tran b1_sample12 find v(b1) at=2399n
if abs(b1_sample12-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b1_sample12 expected 0 V
end
meas tran b2_sample12 find v(b2) at=2399n
if abs(b2_sample12-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b2_sample12 expected 0 V
end
meas tran b3_sample12 find v(b3) at=2399n
if abs(b3_sample12-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b3_sample12 expected 0 V
end
meas tran b4_sample12 find v(b4) at=2399n
if abs(b4_sample12-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b4_sample12 expected 0 V
end
meas tran b5_sample12 find v(b5) at=2399n
if abs(b5_sample12-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b5_sample12 expected 0 V
end
meas tran b6_sample12 find v(b6) at=2399n
if abs(b6_sample12-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b6_sample12 expected 0 V
end
meas tran t1_sample12 find v(t1) at=2399n
if abs(t1_sample12-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t1_sample12 expected 0 V
end
meas tran t2_sample12 find v(t2) at=2399n
if abs(t2_sample12-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t2_sample12 expected 0 V
end
meas tran t3_sample12 find v(t3) at=2399n
if abs(t3_sample12-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t3_sample12 expected 0 V
end
meas tran t4_sample12 find v(t4) at=2399n
if abs(t4_sample12-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t4_sample12 expected 0 V
end
meas tran t5_sample12 find v(t5) at=2399n
if abs(t5_sample12-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t5_sample12 expected 0 V
end
meas tran t6_sample12 find v(t6) at=2399n
if abs(t6_sample12-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t6_sample12 expected 0 V
end
meas tran a1_sample13 find v(a1) at=2599n
if abs(a1_sample13-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a1_sample13 expected 0 V
end
meas tran a2_sample13 find v(a2) at=2599n
if abs(a2_sample13-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a2_sample13 expected 0 V
end
meas tran a3_sample13 find v(a3) at=2599n
if abs(a3_sample13-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a3_sample13 expected 0 V
end
meas tran a4_sample13 find v(a4) at=2599n
if abs(a4_sample13-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a4_sample13 expected 0 V
end
meas tran a5_sample13 find v(a5) at=2599n
if abs(a5_sample13-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a5_sample13 expected 0 V
end
meas tran a6_sample13 find v(a6) at=2599n
if abs(a6_sample13-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a6_sample13 expected 0 V
end
meas tran b1_sample13 find v(b1) at=2599n
if abs(b1_sample13-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b1_sample13 expected 0 V
end
meas tran b2_sample13 find v(b2) at=2599n
if abs(b2_sample13-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b2_sample13 expected 0 V
end
meas tran b3_sample13 find v(b3) at=2599n
if abs(b3_sample13-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b3_sample13 expected 0 V
end
meas tran b4_sample13 find v(b4) at=2599n
if abs(b4_sample13-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b4_sample13 expected 0 V
end
meas tran b5_sample13 find v(b5) at=2599n
if abs(b5_sample13-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b5_sample13 expected 0 V
end
meas tran b6_sample13 find v(b6) at=2599n
if abs(b6_sample13-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b6_sample13 expected 0 V
end
meas tran t1_sample13 find v(t1) at=2599n
if abs(t1_sample13-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t1_sample13 expected 0 V
end
meas tran t2_sample13 find v(t2) at=2599n
if abs(t2_sample13-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t2_sample13 expected 0 V
end
meas tran t3_sample13 find v(t3) at=2599n
if abs(t3_sample13-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t3_sample13 expected 0 V
end
meas tran t4_sample13 find v(t4) at=2599n
if abs(t4_sample13-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t4_sample13 expected 0 V
end
meas tran t5_sample13 find v(t5) at=2599n
if abs(t5_sample13-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t5_sample13 expected 0 V
end
meas tran t6_sample13 find v(t6) at=2599n
if abs(t6_sample13-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t6_sample13 expected 0 V
end
meas tran a1_sample14 find v(a1) at=2799n
if abs(a1_sample14-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a1_sample14 expected 0 V
end
meas tran a2_sample14 find v(a2) at=2799n
if abs(a2_sample14-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a2_sample14 expected 0 V
end
meas tran a3_sample14 find v(a3) at=2799n
if abs(a3_sample14-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a3_sample14 expected 0 V
end
meas tran a4_sample14 find v(a4) at=2799n
if abs(a4_sample14-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a4_sample14 expected 0 V
end
meas tran a5_sample14 find v(a5) at=2799n
if abs(a5_sample14-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a5_sample14 expected 0 V
end
meas tran a6_sample14 find v(a6) at=2799n
if abs(a6_sample14-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a6_sample14 expected 0 V
end
meas tran b1_sample14 find v(b1) at=2799n
if abs(b1_sample14-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b1_sample14 expected 0 V
end
meas tran b2_sample14 find v(b2) at=2799n
if abs(b2_sample14-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b2_sample14 expected 0 V
end
meas tran b3_sample14 find v(b3) at=2799n
if abs(b3_sample14-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b3_sample14 expected 0 V
end
meas tran b4_sample14 find v(b4) at=2799n
if abs(b4_sample14-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b4_sample14 expected 0 V
end
meas tran b5_sample14 find v(b5) at=2799n
if abs(b5_sample14-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b5_sample14 expected 0 V
end
meas tran b6_sample14 find v(b6) at=2799n
if abs(b6_sample14-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b6_sample14 expected 0 V
end
meas tran t1_sample14 find v(t1) at=2799n
if abs(t1_sample14-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t1_sample14 expected 0 V
end
meas tran t2_sample14 find v(t2) at=2799n
if abs(t2_sample14-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t2_sample14 expected 0 V
end
meas tran t3_sample14 find v(t3) at=2799n
if abs(t3_sample14-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t3_sample14 expected 0 V
end
meas tran t4_sample14 find v(t4) at=2799n
if abs(t4_sample14-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t4_sample14 expected 0 V
end
meas tran t5_sample14 find v(t5) at=2799n
if abs(t5_sample14-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t5_sample14 expected 0 V
end
meas tran t6_sample14 find v(t6) at=2799n
if abs(t6_sample14-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t6_sample14 expected 0 V
end
meas tran a1_sample15 find v(a1) at=2999n
if abs(a1_sample15-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a1_sample15 expected 0 V
end
meas tran a2_sample15 find v(a2) at=2999n
if abs(a2_sample15-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a2_sample15 expected 0 V
end
meas tran a3_sample15 find v(a3) at=2999n
if abs(a3_sample15-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a3_sample15 expected 0 V
end
meas tran a4_sample15 find v(a4) at=2999n
if abs(a4_sample15-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a4_sample15 expected 0 V
end
meas tran a5_sample15 find v(a5) at=2999n
if abs(a5_sample15-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a5_sample15 expected 0 V
end
meas tran a6_sample15 find v(a6) at=2999n
if abs(a6_sample15-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: a6_sample15 expected 0 V
end
meas tran b1_sample15 find v(b1) at=2999n
if abs(b1_sample15-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b1_sample15 expected 0 V
end
meas tran b2_sample15 find v(b2) at=2999n
if abs(b2_sample15-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b2_sample15 expected 0 V
end
meas tran b3_sample15 find v(b3) at=2999n
if abs(b3_sample15-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b3_sample15 expected 0 V
end
meas tran b4_sample15 find v(b4) at=2999n
if abs(b4_sample15-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b4_sample15 expected 0 V
end
meas tran b5_sample15 find v(b5) at=2999n
if abs(b5_sample15-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b5_sample15 expected 0 V
end
meas tran b6_sample15 find v(b6) at=2999n
if abs(b6_sample15-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: b6_sample15 expected 0 V
end
meas tran t1_sample15 find v(t1) at=2999n
if abs(t1_sample15-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t1_sample15 expected 0 V
end
meas tran t2_sample15 find v(t2) at=2999n
if abs(t2_sample15-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t2_sample15 expected 0 V
end
meas tran t3_sample15 find v(t3) at=2999n
if abs(t3_sample15-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t3_sample15 expected 0 V
end
meas tran t4_sample15 find v(t4) at=2999n
if abs(t4_sample15-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t4_sample15 expected 0 V
end
meas tran t5_sample15 find v(t5) at=2999n
if abs(t5_sample15-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t5_sample15 expected 0 V
end
meas tran t6_sample15 find v(t6) at=2999n
if abs(t6_sample15-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: t6_sample15 expected 0 V
end
if const.failures > 0
echo FAIL: NOR chain sampled logic errors
else
echo PASS: NOR chain all sampled stages within +/-0.5V
end
print const.failures
.endc"}
C {devices/netlist_options.sym} 2220 1000 0 0 {name=NETLIST_OPTIONS
lvs_netlist=false
top_is_subckt=false
spiceprefix=true
hiersep=.}
