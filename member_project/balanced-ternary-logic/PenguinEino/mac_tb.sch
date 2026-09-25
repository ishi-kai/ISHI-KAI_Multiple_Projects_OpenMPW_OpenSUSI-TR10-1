v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {MULTIPLY-ADD SLICE / all 81 input combinations / X+A*B+Cin=Sum+3*Cout} 40 -140 0 0 0.38 0.38 {}
T {27 C; +/-5 V and 0 V supplies; 10 pF || 1 Mohm on four outputs; 1 ns edges, 1 us slots.} 40 -80 0 0 0.24 0.24 {}
C {/home/ishi-kai/balanced-ternary-logic/mac.sym} 400 250 0 0 {name=xdut}
C {devices/lab_pin.sym} 280 190 0 0 {name=l1 lab=x}
C {devices/lab_pin.sym} 280 230 0 0 {name=l2 lab=a}
C {devices/lab_pin.sym} 280 270 0 0 {name=l3 lab=b}
C {devices/lab_pin.sym} 280 310 0 0 {name=l4 lab=cin}
C {devices/lab_pin.sym} 520 230 0 0 {name=l5 lab=sum}
C {devices/lab_pin.sym} 520 270 0 0 {name=l6 lab=cout}
C {devices/lab_pin.sym} 400 120 0 0 {name=l7 lab=VDD}
C {devices/lab_pin.sym} 400 380 0 0 {name=l8 lab=VSS}
C {devices/lab_pin.sym} 440 400 0 0 {name=l9 lab=VMID}
C {devices/lab_pin.sym} 520 190 0 0 {name=l10 lab=and_out}
C {devices/lab_pin.sym} 520 310 0 0 {name=l11 lab=or_out}
C {devices/capa.sym} 740 240 0 0 {name=Csum value=10p m=1}
C {devices/lab_pin.sym} 740 210 0 0 {name=l12 lab=sum}
C {devices/gnd.sym} 740 270 0 0 {name=l13 lab=GND}
C {devices/capa.sym} 960 240 0 0 {name=Ccout value=10p m=1}
C {devices/lab_pin.sym} 960 210 0 0 {name=l14 lab=cout}
C {devices/gnd.sym} 960 270 0 0 {name=l15 lab=GND}
C {devices/capa.sym} 740 380 0 0 {name=Cand_out value=10p m=1}
C {devices/lab_pin.sym} 740 350 0 0 {name=l16 lab=and_out}
C {devices/gnd.sym} 740 410 0 0 {name=l17 lab=GND}
C {devices/capa.sym} 960 380 0 0 {name=Cor_out value=10p m=1}
C {devices/lab_pin.sym} 960 350 0 0 {name=l18 lab=or_out}
C {devices/gnd.sym} 960 410 0 0 {name=l19 lab=GND}
C {devices/vsource.sym} 120 540 0 0 {name=VDD
value="5"
savecurrent=false
hide_texts=true text_size_1=0.001}
C {devices/lab_pin.sym} 120 510 0 0 {name=l20 lab=VDD}
C {devices/gnd.sym} 120 570 0 0 {name=l21 lab=GND}
T {VDD} 150 530 0 0 0.24 0.24 {}
C {devices/vsource.sym} 400 540 0 0 {name=VSS
value="-5"
savecurrent=false
hide_texts=true text_size_1=0.001}
C {devices/lab_pin.sym} 400 510 0 0 {name=l22 lab=VSS}
C {devices/gnd.sym} 400 570 0 0 {name=l23 lab=GND}
T {VSS} 430 530 0 0 0.24 0.24 {}
C {devices/vsource.sym} 680 540 0 0 {name=VMID
value="0"
savecurrent=false
hide_texts=true text_size_1=0.001}
C {devices/lab_pin.sym} 680 510 0 0 {name=l24 lab=VMID}
C {devices/gnd.sym} 680 570 0 0 {name=l25 lab=GND}
T {VMID} 710 530 0 0 0.24 0.24 {}
C {devices/vsource.sym} 100 790 0 0 {name=VX
value="PWL(0 -5 1000n -5 1001n -5 2000n -5 2001n -5 3000n -5 3001n -5 4000n -5 4001n -5 5000n -5 5001n -5 6000n -5 6001n -5 7000n -5 7001n -5 8000n -5 8001n -5 9000n -5 9001n -5 10000n -5 10001n -5 11000n -5 11001n -5 12000n -5 12001n -5 13000n -5 13001n -5 14000n -5 14001n -5 15000n -5 15001n -5 16000n -5 16001n -5 17000n -5 17001n -5 18000n -5 18001n -5 19000n -5 19001n -5 20000n -5 20001n -5 21000n -5 21001n -5 22000n -5 22001n -5 23000n -5 23001n -5 24000n -5 24001n -5 25000n -5 25001n -5 26000n -5 26001n -5 27000n -5 27001n 0 28000n 0 28001n 0 29000n 0 29001n 0 30000n 0 30001n 0 31000n 0 31001n 0 32000n 0 32001n 0 33000n 0 33001n 0 34000n 0 34001n 0 35000n 0 35001n 0 36000n 0 36001n 0 37000n 0 37001n 0 38000n 0 38001n 0 39000n 0 39001n 0 40000n 0 40001n 0 41000n 0 41001n 0 42000n 0 42001n 0 43000n 0 43001n 0 44000n 0 44001n 0 45000n 0 45001n 0 46000n 0 46001n 0 47000n 0 47001n 0 48000n 0 48001n 0 49000n 0 49001n 0 50000n 0 50001n 0 51000n 0 51001n 0 52000n 0 52001n 0 53000n 0 53001n 0 54000n 0 54001n 5 55000n 5 55001n 5 56000n 5 56001n 5 57000n 5 57001n 5 58000n 5 58001n 5 59000n 5 59001n 5 60000n 5 60001n 5 61000n 5 61001n 5 62000n 5 62001n 5 63000n 5 63001n 5 64000n 5 64001n 5 65000n 5 65001n 5 66000n 5 66001n 5 67000n 5 67001n 5 68000n 5 68001n 5 69000n 5 69001n 5 70000n 5 70001n 5 71000n 5 71001n 5 72000n 5 72001n 5 73000n 5 73001n 5 74000n 5 74001n 5 75000n 5 75001n 5 76000n 5 76001n 5 77000n 5 77001n 5 78000n 5 78001n 5 79000n 5 79001n 5 80000n 5 80001n 5 81000n 5 81001n -5 82000n -5)"
savecurrent=false
hide_texts=true text_size_1=0.001}
C {devices/lab_pin.sym} 100 760 0 0 {name=l26 lab=x}
C {devices/gnd.sym} 100 820 0 0 {name=l27 lab=GND}
T {VX} 130 780 0 0 0.24 0.24 {}
C {devices/vsource.sym} 380 790 0 0 {name=VA
value="PWL(0 -5 1000n -5 1001n -5 2000n -5 2001n -5 3000n -5 3001n -5 4000n -5 4001n -5 5000n -5 5001n -5 6000n -5 6001n -5 7000n -5 7001n -5 8000n -5 8001n -5 9000n -5 9001n 0 10000n 0 10001n 0 11000n 0 11001n 0 12000n 0 12001n 0 13000n 0 13001n 0 14000n 0 14001n 0 15000n 0 15001n 0 16000n 0 16001n 0 17000n 0 17001n 0 18000n 0 18001n 5 19000n 5 19001n 5 20000n 5 20001n 5 21000n 5 21001n 5 22000n 5 22001n 5 23000n 5 23001n 5 24000n 5 24001n 5 25000n 5 25001n 5 26000n 5 26001n 5 27000n 5 27001n -5 28000n -5 28001n -5 29000n -5 29001n -5 30000n -5 30001n -5 31000n -5 31001n -5 32000n -5 32001n -5 33000n -5 33001n -5 34000n -5 34001n -5 35000n -5 35001n -5 36000n -5 36001n 0 37000n 0 37001n 0 38000n 0 38001n 0 39000n 0 39001n 0 40000n 0 40001n 0 41000n 0 41001n 0 42000n 0 42001n 0 43000n 0 43001n 0 44000n 0 44001n 0 45000n 0 45001n 5 46000n 5 46001n 5 47000n 5 47001n 5 48000n 5 48001n 5 49000n 5 49001n 5 50000n 5 50001n 5 51000n 5 51001n 5 52000n 5 52001n 5 53000n 5 53001n 5 54000n 5 54001n -5 55000n -5 55001n -5 56000n -5 56001n -5 57000n -5 57001n -5 58000n -5 58001n -5 59000n -5 59001n -5 60000n -5 60001n -5 61000n -5 61001n -5 62000n -5 62001n -5 63000n -5 63001n 0 64000n 0 64001n 0 65000n 0 65001n 0 66000n 0 66001n 0 67000n 0 67001n 0 68000n 0 68001n 0 69000n 0 69001n 0 70000n 0 70001n 0 71000n 0 71001n 0 72000n 0 72001n 5 73000n 5 73001n 5 74000n 5 74001n 5 75000n 5 75001n 5 76000n 5 76001n 5 77000n 5 77001n 5 78000n 5 78001n 5 79000n 5 79001n 5 80000n 5 80001n 5 81000n 5 81001n -5 82000n -5)"
savecurrent=false
hide_texts=true text_size_1=0.001}
C {devices/lab_pin.sym} 380 760 0 0 {name=l28 lab=a}
C {devices/gnd.sym} 380 820 0 0 {name=l29 lab=GND}
T {VA} 410 780 0 0 0.24 0.24 {}
C {devices/vsource.sym} 660 790 0 0 {name=VB
value="PWL(0 -5 1000n -5 1001n -5 2000n -5 2001n -5 3000n -5 3001n 0 4000n 0 4001n 0 5000n 0 5001n 0 6000n 0 6001n 5 7000n 5 7001n 5 8000n 5 8001n 5 9000n 5 9001n -5 10000n -5 10001n -5 11000n -5 11001n -5 12000n -5 12001n 0 13000n 0 13001n 0 14000n 0 14001n 0 15000n 0 15001n 5 16000n 5 16001n 5 17000n 5 17001n 5 18000n 5 18001n -5 19000n -5 19001n -5 20000n -5 20001n -5 21000n -5 21001n 0 22000n 0 22001n 0 23000n 0 23001n 0 24000n 0 24001n 5 25000n 5 25001n 5 26000n 5 26001n 5 27000n 5 27001n -5 28000n -5 28001n -5 29000n -5 29001n -5 30000n -5 30001n 0 31000n 0 31001n 0 32000n 0 32001n 0 33000n 0 33001n 5 34000n 5 34001n 5 35000n 5 35001n 5 36000n 5 36001n -5 37000n -5 37001n -5 38000n -5 38001n -5 39000n -5 39001n 0 40000n 0 40001n 0 41000n 0 41001n 0 42000n 0 42001n 5 43000n 5 43001n 5 44000n 5 44001n 5 45000n 5 45001n -5 46000n -5 46001n -5 47000n -5 47001n -5 48000n -5 48001n 0 49000n 0 49001n 0 50000n 0 50001n 0 51000n 0 51001n 5 52000n 5 52001n 5 53000n 5 53001n 5 54000n 5 54001n -5 55000n -5 55001n -5 56000n -5 56001n -5 57000n -5 57001n 0 58000n 0 58001n 0 59000n 0 59001n 0 60000n 0 60001n 5 61000n 5 61001n 5 62000n 5 62001n 5 63000n 5 63001n -5 64000n -5 64001n -5 65000n -5 65001n -5 66000n -5 66001n 0 67000n 0 67001n 0 68000n 0 68001n 0 69000n 0 69001n 5 70000n 5 70001n 5 71000n 5 71001n 5 72000n 5 72001n -5 73000n -5 73001n -5 74000n -5 74001n -5 75000n -5 75001n 0 76000n 0 76001n 0 77000n 0 77001n 0 78000n 0 78001n 5 79000n 5 79001n 5 80000n 5 80001n 5 81000n 5 81001n -5 82000n -5)"
savecurrent=false
hide_texts=true text_size_1=0.001}
C {devices/lab_pin.sym} 660 760 0 0 {name=l30 lab=b}
C {devices/gnd.sym} 660 820 0 0 {name=l31 lab=GND}
T {VB} 690 780 0 0 0.24 0.24 {}
C {devices/vsource.sym} 940 790 0 0 {name=VCIN
value="PWL(0 -5 1000n -5 1001n 0 2000n 0 2001n 5 3000n 5 3001n -5 4000n -5 4001n 0 5000n 0 5001n 5 6000n 5 6001n -5 7000n -5 7001n 0 8000n 0 8001n 5 9000n 5 9001n -5 10000n -5 10001n 0 11000n 0 11001n 5 12000n 5 12001n -5 13000n -5 13001n 0 14000n 0 14001n 5 15000n 5 15001n -5 16000n -5 16001n 0 17000n 0 17001n 5 18000n 5 18001n -5 19000n -5 19001n 0 20000n 0 20001n 5 21000n 5 21001n -5 22000n -5 22001n 0 23000n 0 23001n 5 24000n 5 24001n -5 25000n -5 25001n 0 26000n 0 26001n 5 27000n 5 27001n -5 28000n -5 28001n 0 29000n 0 29001n 5 30000n 5 30001n -5 31000n -5 31001n 0 32000n 0 32001n 5 33000n 5 33001n -5 34000n -5 34001n 0 35000n 0 35001n 5 36000n 5 36001n -5 37000n -5 37001n 0 38000n 0 38001n 5 39000n 5 39001n -5 40000n -5 40001n 0 41000n 0 41001n 5 42000n 5 42001n -5 43000n -5 43001n 0 44000n 0 44001n 5 45000n 5 45001n -5 46000n -5 46001n 0 47000n 0 47001n 5 48000n 5 48001n -5 49000n -5 49001n 0 50000n 0 50001n 5 51000n 5 51001n -5 52000n -5 52001n 0 53000n 0 53001n 5 54000n 5 54001n -5 55000n -5 55001n 0 56000n 0 56001n 5 57000n 5 57001n -5 58000n -5 58001n 0 59000n 0 59001n 5 60000n 5 60001n -5 61000n -5 61001n 0 62000n 0 62001n 5 63000n 5 63001n -5 64000n -5 64001n 0 65000n 0 65001n 5 66000n 5 66001n -5 67000n -5 67001n 0 68000n 0 68001n 5 69000n 5 69001n -5 70000n -5 70001n 0 71000n 0 71001n 5 72000n 5 72001n -5 73000n -5 73001n 0 74000n 0 74001n 5 75000n 5 75001n -5 76000n -5 76001n 0 77000n 0 77001n 5 78000n 5 78001n -5 79000n -5 79001n 0 80000n 0 80001n 5 81000n 5 81001n -5 82000n -5)"
savecurrent=false
hide_texts=true text_size_1=0.001}
C {devices/lab_pin.sym} 940 760 0 0 {name=l32 lab=cin}
C {devices/gnd.sym} 940 820 0 0 {name=l33 lab=GND}
T {VCIN} 970 780 0 0 0.24 0.24 {}
T {Each 27-state block fixes X and enumerates A, B, Cin in -5/0/+5 order.} 40 900 0 0 0.24 0.24 {}
T {After state 80, return to (-5,-5,-5,-5) in slot 81; sample at 81999 ns.} 40 945 0 0 0.24 0.24 {}
T {RUN: disable LVS -> Netlist -> Simulate. Native voltage plots and PASS/FAIL log.} 40 990 0 0 0.24 0.24 {}
T {External samples allow logic to settle. No guarantee of glitch-free transitions.} 40 1035 0 0 0.24 0.24 {}
T {X=-5 V / 27 states} 1230 -90 0 0 0.29 0.29 {}
T {A    B   Cin   Sum  Cout  AND  OR  Sample(ns)} 1230 -45 0 0 0.22 0.22 {}
T {-5   -5   -5    -5    +0    -5    -5    999} 1230 0 0 0 0.22 0.22 {}
T {-5   -5   +0    +0    +0    -5    -5    1999} 1230 32 0 0 0.22 0.22 {}
T {-5   -5   +5    +5    +0    -5    -5    2999} 1230 64 0 0 0.22 0.22 {}
T {-5   +0   -5    +5    -5    -5    +0    3999} 1230 96 0 0 0.22 0.22 {}
T {-5   +0   +0    -5    +0    -5    +0    4999} 1230 128 0 0 0.22 0.22 {}
T {-5   +0   +5    +0    +0    -5    +0    5999} 1230 160 0 0 0.22 0.22 {}
T {-5   +5   -5    +0    -5    -5    +5    6999} 1230 192 0 0 0.22 0.22 {}
T {-5   +5   +0    +5    -5    -5    +5    7999} 1230 224 0 0 0.22 0.22 {}
T {-5   +5   +5    -5    +0    -5    +5    8999} 1230 256 0 0 0.22 0.22 {}
T {+0   -5   -5    +5    -5    -5    +0    9999} 1230 288 0 0 0.22 0.22 {}
T {+0   -5   +0    -5    +0    -5    +0    10999} 1230 320 0 0 0.22 0.22 {}
T {+0   -5   +5    +0    +0    -5    +0    11999} 1230 352 0 0 0.22 0.22 {}
T {+0   +0   -5    +5    -5    +0    +0    12999} 1230 384 0 0 0.22 0.22 {}
T {+0   +0   +0    -5    +0    +0    +0    13999} 1230 416 0 0 0.22 0.22 {}
T {+0   +0   +5    +0    +0    +0    +0    14999} 1230 448 0 0 0.22 0.22 {}
T {+0   +5   -5    +5    -5    +0    +5    15999} 1230 480 0 0 0.22 0.22 {}
T {+0   +5   +0    -5    +0    +0    +5    16999} 1230 512 0 0 0.22 0.22 {}
T {+0   +5   +5    +0    +0    +0    +5    17999} 1230 544 0 0 0.22 0.22 {}
T {+5   -5   -5    +0    -5    -5    +5    18999} 1230 576 0 0 0.22 0.22 {}
T {+5   -5   +0    +5    -5    -5    +5    19999} 1230 608 0 0 0.22 0.22 {}
T {+5   -5   +5    -5    +0    -5    +5    20999} 1230 640 0 0 0.22 0.22 {}
T {+5   +0   -5    +5    -5    +0    +5    21999} 1230 672 0 0 0.22 0.22 {}
T {+5   +0   +0    -5    +0    +0    +5    22999} 1230 704 0 0 0.22 0.22 {}
T {+5   +0   +5    +0    +0    +0    +5    23999} 1230 736 0 0 0.22 0.22 {}
T {+5   +5   -5    -5    +0    +5    +5    24999} 1230 768 0 0 0.22 0.22 {}
T {+5   +5   +0    +0    +0    +5    +5    25999} 1230 800 0 0 0.22 0.22 {}
T {+5   +5   +5    +5    +0    +5    +5    26999} 1230 832 0 0 0.22 0.22 {}
T {X=+0 V / 27 states} 1880 -90 0 0 0.29 0.29 {}
T {A    B   Cin   Sum  Cout  AND  OR  Sample(ns)} 1880 -45 0 0 0.22 0.22 {}
T {-5   -5   -5    +0    +0    -5    -5    27999} 1880 0 0 0 0.22 0.22 {}
T {-5   -5   +0    +5    +0    -5    -5    28999} 1880 32 0 0 0.22 0.22 {}
T {-5   -5   +5    -5    +5    -5    -5    29999} 1880 64 0 0 0.22 0.22 {}
T {-5   +0   -5    -5    +0    -5    +0    30999} 1880 96 0 0 0.22 0.22 {}
T {-5   +0   +0    +0    +0    -5    +0    31999} 1880 128 0 0 0.22 0.22 {}
T {-5   +0   +5    +5    +0    -5    +0    32999} 1880 160 0 0 0.22 0.22 {}
T {-5   +5   -5    +5    -5    -5    +5    33999} 1880 192 0 0 0.22 0.22 {}
T {-5   +5   +0    -5    +0    -5    +5    34999} 1880 224 0 0 0.22 0.22 {}
T {-5   +5   +5    +0    +0    -5    +5    35999} 1880 256 0 0 0.22 0.22 {}
T {+0   -5   -5    -5    +0    -5    +0    36999} 1880 288 0 0 0.22 0.22 {}
T {+0   -5   +0    +0    +0    -5    +0    37999} 1880 320 0 0 0.22 0.22 {}
T {+0   -5   +5    +5    +0    -5    +0    38999} 1880 352 0 0 0.22 0.22 {}
T {+0   +0   -5    -5    +0    +0    +0    39999} 1880 384 0 0 0.22 0.22 {}
T {+0   +0   +0    +0    +0    +0    +0    40999} 1880 416 0 0 0.22 0.22 {}
T {+0   +0   +5    +5    +0    +0    +0    41999} 1880 448 0 0 0.22 0.22 {}
T {+0   +5   -5    -5    +0    +0    +5    42999} 1880 480 0 0 0.22 0.22 {}
T {+0   +5   +0    +0    +0    +0    +5    43999} 1880 512 0 0 0.22 0.22 {}
T {+0   +5   +5    +5    +0    +0    +5    44999} 1880 544 0 0 0.22 0.22 {}
T {+5   -5   -5    +5    -5    -5    +5    45999} 1880 576 0 0 0.22 0.22 {}
T {+5   -5   +0    -5    +0    -5    +5    46999} 1880 608 0 0 0.22 0.22 {}
T {+5   -5   +5    +0    +0    -5    +5    47999} 1880 640 0 0 0.22 0.22 {}
T {+5   +0   -5    -5    +0    +0    +5    48999} 1880 672 0 0 0.22 0.22 {}
T {+5   +0   +0    +0    +0    +0    +5    49999} 1880 704 0 0 0.22 0.22 {}
T {+5   +0   +5    +5    +0    +0    +5    50999} 1880 736 0 0 0.22 0.22 {}
T {+5   +5   -5    +0    +0    +5    +5    51999} 1880 768 0 0 0.22 0.22 {}
T {+5   +5   +0    +5    +0    +5    +5    52999} 1880 800 0 0 0.22 0.22 {}
T {+5   +5   +5    -5    +5    +5    +5    53999} 1880 832 0 0 0.22 0.22 {}
T {X=+5 V / 27 states} 2530 -90 0 0 0.29 0.29 {}
T {A    B   Cin   Sum  Cout  AND  OR  Sample(ns)} 2530 -45 0 0 0.22 0.22 {}
T {-5   -5   -5    +5    +0    -5    -5    54999} 2530 0 0 0 0.22 0.22 {}
T {-5   -5   +0    -5    +5    -5    -5    55999} 2530 32 0 0 0.22 0.22 {}
T {-5   -5   +5    +0    +5    -5    -5    56999} 2530 64 0 0 0.22 0.22 {}
T {-5   +0   -5    +0    +0    -5    +0    57999} 2530 96 0 0 0.22 0.22 {}
T {-5   +0   +0    +5    +0    -5    +0    58999} 2530 128 0 0 0.22 0.22 {}
T {-5   +0   +5    -5    +5    -5    +0    59999} 2530 160 0 0 0.22 0.22 {}
T {-5   +5   -5    -5    +0    -5    +5    60999} 2530 192 0 0 0.22 0.22 {}
T {-5   +5   +0    +0    +0    -5    +5    61999} 2530 224 0 0 0.22 0.22 {}
T {-5   +5   +5    +5    +0    -5    +5    62999} 2530 256 0 0 0.22 0.22 {}
T {+0   -5   -5    +0    +0    -5    +0    63999} 2530 288 0 0 0.22 0.22 {}
T {+0   -5   +0    +5    +0    -5    +0    64999} 2530 320 0 0 0.22 0.22 {}
T {+0   -5   +5    -5    +5    -5    +0    65999} 2530 352 0 0 0.22 0.22 {}
T {+0   +0   -5    +0    +0    +0    +0    66999} 2530 384 0 0 0.22 0.22 {}
T {+0   +0   +0    +5    +0    +0    +0    67999} 2530 416 0 0 0.22 0.22 {}
T {+0   +0   +5    -5    +5    +0    +0    68999} 2530 448 0 0 0.22 0.22 {}
T {+0   +5   -5    +0    +0    +0    +5    69999} 2530 480 0 0 0.22 0.22 {}
T {+0   +5   +0    +5    +0    +0    +5    70999} 2530 512 0 0 0.22 0.22 {}
T {+0   +5   +5    -5    +5    +0    +5    71999} 2530 544 0 0 0.22 0.22 {}
T {+5   -5   -5    -5    +0    -5    +5    72999} 2530 576 0 0 0.22 0.22 {}
T {+5   -5   +0    +0    +0    -5    +5    73999} 2530 608 0 0 0.22 0.22 {}
T {+5   -5   +5    +5    +0    -5    +5    74999} 2530 640 0 0 0.22 0.22 {}
T {+5   +0   -5    +0    +0    +0    +5    75999} 2530 672 0 0 0.22 0.22 {}
T {+5   +0   +0    +5    +0    +0    +5    76999} 2530 704 0 0 0.22 0.22 {}
T {+5   +0   +5    -5    +5    +0    +5    77999} 2530 736 0 0 0.22 0.22 {}
T {+5   +5   -5    +5    +0    +5    +5    78999} 2530 768 0 0 0.22 0.22 {}
T {+5   +5   +0    -5    +5    +5    +5    79999} 2530 800 0 0 0.22 0.22 {}
T {+5   +5   +5    +0    +5    +5    +5    80999} 2530 832 0 0 0.22 0.22 {}
C {devices/code.sym} 1300 1050 0 0 {name=TR_1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"}
C {devices/code.sym} 1600 1050 0 0 {name=SIMULATION
only_toplevel=true
value=".temp 27
.options rshunt=1e12 method=gear maxord=2 reltol=1e-4
Rload_sum sum 0 1meg
Rload_cout cout 0 1meg
Rload_and_out and_out 0 1meg
Rload_or_out or_out 0 1meg
.nodeset v(sum)=-4.94462634
.nodeset v(cout)=-0.0346307864
.nodeset v(and_out)=-4.9441784
.nodeset v(or_out)=-4.94417841
.nodeset v(xdut.p)=4.99999887
.nodeset v(a)=-5
.nodeset v(b)=-5
.nodeset v(cin)=-5
.nodeset v(vdd)=5
.nodeset v(vmid)=0
.nodeset v(vss)=-5
.nodeset v(x)=-5
.nodeset v(xdut.nmin)=4.99999971
.nodeset v(xdut.or_n)=4.99999909
.nodeset v(xdut.or_raw)=-4.99999968
.nodeset v(xdut.x_and.net1)=-4.94417817
.nodeset v(xdut.x_and.net2)=-4.99511425
.nodeset v(xdut.x_fa.c1)=5.04845297e-08
.nodeset v(xdut.x_fa.c2)=-0.0433348398
.nodeset v(xdut.x_fa.nc)=-0.0430459702
.nodeset v(xdut.x_fa.s1)=-0.0433397968
.nodeset v(xdut.x_fa.x_cmerge.net1)=4.78324053
.nodeset v(xdut.x_fa.x_cmerge.net2)=4.55319102
.nodeset v(xdut.x_fa.x_cmerge.net3)=-4.53211873
.nodeset v(xdut.x_fa.x_cmerge.net4)=-4.77192741
.nodeset v(xdut.x_fa.x_cmerge.net5)=0.000557406959
.nodeset v(xdut.x_fa.x_cmerge.net6)=0.000555808048
.nodeset v(xdut.x_fa.x_cout.net1)=4.40177363
.nodeset v(xdut.x_fa.x_cout.net2)=-4.37149662
.nodeset v(xdut.x_fa.x_ha1.d)=-0.0445943352
.nodeset v(xdut.x_fa.x_ha1.na)=4.99999909
.nodeset v(xdut.x_fa.x_ha1.nd)=-0.0346812213
.nodeset v(xdut.x_fa.x_ha1.t)=5.04451695e-08
.nodeset v(xdut.x_fa.x_ha1.u)=-4.99999927
.nodeset v(xdut.x_fa.x_ha1.x_c.net1)=4.36290302e-07
.nodeset v(xdut.x_fa.x_ha1.x_c.net2)=4.11720083e-07
.nodeset v(xdut.x_fa.x_ha1.x_c.net3)=-2.44852036e-07
.nodeset v(xdut.x_fa.x_ha1.x_c.net4)=-2.58990473e-07
.nodeset v(xdut.x_fa.x_ha1.x_c.net5)=0.00056
.nodeset v(xdut.x_fa.x_ha1.x_c.net6)=1.45240763e-08
.nodeset v(xdut.x_fa.x_ha1.x_d.net1)=4.7832404
.nodeset v(xdut.x_fa.x_ha1.x_d.net2)=4.55160615
.nodeset v(xdut.x_fa.x_ha1.x_d.net3)=-4.53363603
.nodeset v(xdut.x_fa.x_ha1.x_d.net4)=-4.77335702
.nodeset v(xdut.x_fa.x_ha1.x_d.net5)=0.000555808061
.nodeset v(xdut.x_fa.x_ha1.x_d.net6)=0.000555808061
.nodeset v(xdut.x_fa.x_ha1.x_na.net1)=4.99999992
.nodeset v(xdut.x_fa.x_ha1.x_na.net2)=4.99999832
.nodeset v(xdut.x_fa.x_ha1.x_nd.net1)=4.40190262
.nodeset v(xdut.x_fa.x_ha1.x_nd.net2)=-4.37134723
.nodeset v(xdut.x_fa.x_ha1.x_s.net1)=4.78428286
.nodeset v(xdut.x_fa.x_ha1.x_s.net2)=4.55273261
.nodeset v(xdut.x_fa.x_ha1.x_s.net3)=-4.53225631
.nodeset v(xdut.x_fa.x_ha1.x_s.net4)=-4.77336507
.nodeset v(xdut.x_fa.x_ha1.x_s.net5)=0.000555808051
.nodeset v(xdut.x_fa.x_ha1.x_s.net6)=0.000557145623
.nodeset v(xdut.x_fa.x_ha1.x_t.net1)=4.99999999
.nodeset v(xdut.x_fa.x_ha1.x_t.net2)=3.06011146e-07
.nodeset v(xdut.x_fa.x_ha1.x_t.net3)=-1.39355478e-07
.nodeset v(xdut.x_fa.x_ha1.x_t.net4)=-4.99999999
.nodeset v(xdut.x_fa.x_ha1.x_t.net5)=1.45127557e-08
.nodeset v(xdut.x_fa.x_ha1.x_t.net6)=0.00056
.nodeset v(xdut.x_fa.x_ha1.x_u.net1)=1.17635504
.nodeset v(xdut.x_fa.x_ha1.x_u.net2)=-4.99999887
.nodeset v(xdut.x_fa.x_ha1.x_u.net3)=-4.99999994
.nodeset v(xdut.x_fa.x_ha1.x_u.net4)=-4.99999996
.nodeset v(xdut.x_fa.x_ha1.x_u.net5)=0.000555808073
.nodeset v(xdut.x_fa.x_ha1.x_u.net6)=1.50089411e-12
.nodeset v(xdut.x_fa.x_ha2.d)=-4.99999927
.nodeset v(xdut.x_fa.x_ha2.na)=-0.034818012
.nodeset v(xdut.x_fa.x_ha2.nd)=4.99999909
.nodeset v(xdut.x_fa.x_ha2.t)=4.99999917
.nodeset v(xdut.x_fa.x_ha2.u)=5.04448848e-08
.nodeset v(xdut.x_fa.x_ha2.x_c.net1)=4.78428693
.nodeset v(xdut.x_fa.x_ha2.x_c.net2)=4.55273702
.nodeset v(xdut.x_fa.x_ha2.x_c.net3)=-4.53225081
.nodeset v(xdut.x_fa.x_ha2.x_c.net4)=-4.7733651
.nodeset v(xdut.x_fa.x_ha2.x_c.net5)=0.000555808051
.nodeset v(xdut.x_fa.x_ha2.x_c.net6)=0.000557149951
.nodeset v(xdut.x_fa.x_ha2.x_d.net1)=1.14024145
.nodeset v(xdut.x_fa.x_ha2.x_d.net2)=-4.99999886
.nodeset v(xdut.x_fa.x_ha2.x_d.net3)=-4.99999994
.nodeset v(xdut.x_fa.x_ha2.x_d.net4)=-4.99999996
.nodeset v(xdut.x_fa.x_ha2.x_d.net5)=0.00055740697
.nodeset v(xdut.x_fa.x_ha2.x_d.net6)=1.50089392e-12
.nodeset v(xdut.x_fa.x_ha2.x_na.net1)=4.40177517
.nodeset v(xdut.x_fa.x_ha2.x_na.net2)=-4.37149326
.nodeset v(xdut.x_fa.x_ha2.x_nd.net1)=4.99999992
.nodeset v(xdut.x_fa.x_ha2.x_nd.net2)=4.99999832
.nodeset v(xdut.x_fa.x_ha2.x_s.net1)=1.14048869
.nodeset v(xdut.x_fa.x_ha2.x_s.net2)=-4.94462593
.nodeset v(xdut.x_fa.x_ha2.x_s.net3)=-4.99556708
.nodeset v(xdut.x_fa.x_ha2.x_s.net4)=-4.99745097
.nodeset v(xdut.x_fa.x_ha2.x_s.net5)=0.00055740697
.nodeset v(xdut.x_fa.x_ha2.x_s.net6)=1.50066999e-12
.nodeset v(xdut.x_fa.x_ha2.x_t.net1)=4.99999996
.nodeset v(xdut.x_fa.x_ha2.x_t.net2)=4.99999993
.nodeset v(xdut.x_fa.x_ha2.x_t.net3)=4.9999988
.nodeset v(xdut.x_fa.x_ha2.x_t.net4)=-0.762532153
.nodeset v(xdut.x_fa.x_ha2.x_t.net5)=4.99999915
.nodeset v(xdut.x_fa.x_ha2.x_t.net6)=4.99999916
.nodeset v(xdut.x_fa.x_ha2.x_u.net1)=4.99999999
.nodeset v(xdut.x_fa.x_ha2.x_u.net2)=3.06009898e-07
.nodeset v(xdut.x_fa.x_ha2.x_u.net3)=-1.39355762e-07
.nodeset v(xdut.x_fa.x_ha2.x_u.net4)=-4.99999999
.nodeset v(xdut.x_fa.x_ha2.x_u.net5)=1.45126732e-08
.nodeset v(xdut.x_fa.x_ha2.x_u.net6)=0.00056
.nodeset v(xdut.x_mul.t2)=4.9999978
.nodeset v(xdut.x_mul.x_p.net1)=4.99999993
.nodeset v(xdut.x_mul.x_p.net2)=4.99999786
.nodeset v(xdut.x_mul.x_p.net3)=3.51894221
.nodeset v(xdut.x_mul.x_t1.net1)=4.99999999
.nodeset v(xdut.x_mul.x_t1.net2)=4.99999949
.nodeset v(xdut.x_mul.x_t1.net3)=-4.82561956
.nodeset v(xdut.x_mul.x_t2.net1)=4.99999993
.nodeset v(xdut.x_mul.x_t2.net2)=4.99999986
.nodeset v(xdut.x_mul.x_t2.net3)=4.99999579
.nodeset v(xdut.x_mul.x_t3.net1)=-4.99999945
.nodeset v(xdut.x_mul.x_t3.net2)=-4.99999997
.nodeset v(xdut.x_or1.net1)=4.99999992
.nodeset v(xdut.x_or1.net2)=4.99999832
.nodeset v(xdut.x_or2.net1)=-4.94417818
.nodeset v(xdut.x_or2.net2)=-4.99511425
.control
save all
set wr_singlescale
set wr_vecnames
setplot const
let failures=0
tran 10n 82000n 0 10n
meas tran tran_0_sum find v(sum) at=999n
if abs(tran_0_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_0_sum expected -5 V
end
meas tran tran_0_cout find v(cout) at=999n
if abs(tran_0_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_0_cout expected 0 V
end
meas tran tran_0_xdut_p find v(xdut.p) at=999n
if abs(tran_0_xdut_p-(5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_0_xdut_p expected 5.0 V
end
meas tran tran_0_and_out find v(and_out) at=999n
if abs(tran_0_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_0_and_out expected -5 V
end
meas tran tran_0_or_out find v(or_out) at=999n
if abs(tran_0_or_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_0_or_out expected -5 V
end
meas tran tran_1_sum find v(sum) at=1999n
if abs(tran_1_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_1_sum expected 0 V
end
meas tran tran_1_cout find v(cout) at=1999n
if abs(tran_1_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_1_cout expected 0 V
end
meas tran tran_1_xdut_p find v(xdut.p) at=1999n
if abs(tran_1_xdut_p-(5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_1_xdut_p expected 5.0 V
end
meas tran tran_1_and_out find v(and_out) at=1999n
if abs(tran_1_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_1_and_out expected -5 V
end
meas tran tran_1_or_out find v(or_out) at=1999n
if abs(tran_1_or_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_1_or_out expected -5 V
end
meas tran tran_2_sum find v(sum) at=2999n
if abs(tran_2_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_2_sum expected 5 V
end
meas tran tran_2_cout find v(cout) at=2999n
if abs(tran_2_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_2_cout expected 0 V
end
meas tran tran_2_xdut_p find v(xdut.p) at=2999n
if abs(tran_2_xdut_p-(5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_2_xdut_p expected 5.0 V
end
meas tran tran_2_and_out find v(and_out) at=2999n
if abs(tran_2_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_2_and_out expected -5 V
end
meas tran tran_2_or_out find v(or_out) at=2999n
if abs(tran_2_or_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_2_or_out expected -5 V
end
meas tran tran_3_sum find v(sum) at=3999n
if abs(tran_3_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_3_sum expected 5 V
end
meas tran tran_3_cout find v(cout) at=3999n
if abs(tran_3_cout-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_3_cout expected -5 V
end
meas tran tran_3_xdut_p find v(xdut.p) at=3999n
if abs(tran_3_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_3_xdut_p expected 0.0 V
end
meas tran tran_3_and_out find v(and_out) at=3999n
if abs(tran_3_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_3_and_out expected -5 V
end
meas tran tran_3_or_out find v(or_out) at=3999n
if abs(tran_3_or_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_3_or_out expected 0 V
end
meas tran tran_4_sum find v(sum) at=4999n
if abs(tran_4_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_4_sum expected -5 V
end
meas tran tran_4_cout find v(cout) at=4999n
if abs(tran_4_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_4_cout expected 0 V
end
meas tran tran_4_xdut_p find v(xdut.p) at=4999n
if abs(tran_4_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_4_xdut_p expected 0.0 V
end
meas tran tran_4_and_out find v(and_out) at=4999n
if abs(tran_4_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_4_and_out expected -5 V
end
meas tran tran_4_or_out find v(or_out) at=4999n
if abs(tran_4_or_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_4_or_out expected 0 V
end
meas tran tran_5_sum find v(sum) at=5999n
if abs(tran_5_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_5_sum expected 0 V
end
meas tran tran_5_cout find v(cout) at=5999n
if abs(tran_5_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_5_cout expected 0 V
end
meas tran tran_5_xdut_p find v(xdut.p) at=5999n
if abs(tran_5_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_5_xdut_p expected 0.0 V
end
meas tran tran_5_and_out find v(and_out) at=5999n
if abs(tran_5_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_5_and_out expected -5 V
end
meas tran tran_5_or_out find v(or_out) at=5999n
if abs(tran_5_or_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_5_or_out expected 0 V
end
meas tran tran_6_sum find v(sum) at=6999n
if abs(tran_6_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_6_sum expected 0 V
end
meas tran tran_6_cout find v(cout) at=6999n
if abs(tran_6_cout-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_6_cout expected -5 V
end
meas tran tran_6_xdut_p find v(xdut.p) at=6999n
if abs(tran_6_xdut_p-(-5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_6_xdut_p expected -5.0 V
end
meas tran tran_6_and_out find v(and_out) at=6999n
if abs(tran_6_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_6_and_out expected -5 V
end
meas tran tran_6_or_out find v(or_out) at=6999n
if abs(tran_6_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_6_or_out expected 5 V
end
meas tran tran_7_sum find v(sum) at=7999n
if abs(tran_7_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_7_sum expected 5 V
end
meas tran tran_7_cout find v(cout) at=7999n
if abs(tran_7_cout-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_7_cout expected -5 V
end
meas tran tran_7_xdut_p find v(xdut.p) at=7999n
if abs(tran_7_xdut_p-(-5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_7_xdut_p expected -5.0 V
end
meas tran tran_7_and_out find v(and_out) at=7999n
if abs(tran_7_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_7_and_out expected -5 V
end
meas tran tran_7_or_out find v(or_out) at=7999n
if abs(tran_7_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_7_or_out expected 5 V
end
meas tran tran_8_sum find v(sum) at=8999n
if abs(tran_8_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_8_sum expected -5 V
end
meas tran tran_8_cout find v(cout) at=8999n
if abs(tran_8_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_8_cout expected 0 V
end
meas tran tran_8_xdut_p find v(xdut.p) at=8999n
if abs(tran_8_xdut_p-(-5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_8_xdut_p expected -5.0 V
end
meas tran tran_8_and_out find v(and_out) at=8999n
if abs(tran_8_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_8_and_out expected -5 V
end
meas tran tran_8_or_out find v(or_out) at=8999n
if abs(tran_8_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_8_or_out expected 5 V
end
meas tran tran_9_sum find v(sum) at=9999n
if abs(tran_9_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_9_sum expected 5 V
end
meas tran tran_9_cout find v(cout) at=9999n
if abs(tran_9_cout-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_9_cout expected -5 V
end
meas tran tran_9_xdut_p find v(xdut.p) at=9999n
if abs(tran_9_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_9_xdut_p expected 0.0 V
end
meas tran tran_9_and_out find v(and_out) at=9999n
if abs(tran_9_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_9_and_out expected -5 V
end
meas tran tran_9_or_out find v(or_out) at=9999n
if abs(tran_9_or_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_9_or_out expected 0 V
end
meas tran tran_10_sum find v(sum) at=10999n
if abs(tran_10_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_10_sum expected -5 V
end
meas tran tran_10_cout find v(cout) at=10999n
if abs(tran_10_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_10_cout expected 0 V
end
meas tran tran_10_xdut_p find v(xdut.p) at=10999n
if abs(tran_10_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_10_xdut_p expected 0.0 V
end
meas tran tran_10_and_out find v(and_out) at=10999n
if abs(tran_10_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_10_and_out expected -5 V
end
meas tran tran_10_or_out find v(or_out) at=10999n
if abs(tran_10_or_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_10_or_out expected 0 V
end
meas tran tran_11_sum find v(sum) at=11999n
if abs(tran_11_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_11_sum expected 0 V
end
meas tran tran_11_cout find v(cout) at=11999n
if abs(tran_11_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_11_cout expected 0 V
end
meas tran tran_11_xdut_p find v(xdut.p) at=11999n
if abs(tran_11_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_11_xdut_p expected 0.0 V
end
meas tran tran_11_and_out find v(and_out) at=11999n
if abs(tran_11_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_11_and_out expected -5 V
end
meas tran tran_11_or_out find v(or_out) at=11999n
if abs(tran_11_or_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_11_or_out expected 0 V
end
meas tran tran_12_sum find v(sum) at=12999n
if abs(tran_12_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_12_sum expected 5 V
end
meas tran tran_12_cout find v(cout) at=12999n
if abs(tran_12_cout-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_12_cout expected -5 V
end
meas tran tran_12_xdut_p find v(xdut.p) at=12999n
if abs(tran_12_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_12_xdut_p expected 0.0 V
end
meas tran tran_12_and_out find v(and_out) at=12999n
if abs(tran_12_and_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_12_and_out expected 0 V
end
meas tran tran_12_or_out find v(or_out) at=12999n
if abs(tran_12_or_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_12_or_out expected 0 V
end
meas tran tran_13_sum find v(sum) at=13999n
if abs(tran_13_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_13_sum expected -5 V
end
meas tran tran_13_cout find v(cout) at=13999n
if abs(tran_13_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_13_cout expected 0 V
end
meas tran tran_13_xdut_p find v(xdut.p) at=13999n
if abs(tran_13_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_13_xdut_p expected 0.0 V
end
meas tran tran_13_and_out find v(and_out) at=13999n
if abs(tran_13_and_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_13_and_out expected 0 V
end
meas tran tran_13_or_out find v(or_out) at=13999n
if abs(tran_13_or_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_13_or_out expected 0 V
end
meas tran tran_14_sum find v(sum) at=14999n
if abs(tran_14_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_14_sum expected 0 V
end
meas tran tran_14_cout find v(cout) at=14999n
if abs(tran_14_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_14_cout expected 0 V
end
meas tran tran_14_xdut_p find v(xdut.p) at=14999n
if abs(tran_14_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_14_xdut_p expected 0.0 V
end
meas tran tran_14_and_out find v(and_out) at=14999n
if abs(tran_14_and_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_14_and_out expected 0 V
end
meas tran tran_14_or_out find v(or_out) at=14999n
if abs(tran_14_or_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_14_or_out expected 0 V
end
meas tran tran_15_sum find v(sum) at=15999n
if abs(tran_15_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_15_sum expected 5 V
end
meas tran tran_15_cout find v(cout) at=15999n
if abs(tran_15_cout-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_15_cout expected -5 V
end
meas tran tran_15_xdut_p find v(xdut.p) at=15999n
if abs(tran_15_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_15_xdut_p expected 0.0 V
end
meas tran tran_15_and_out find v(and_out) at=15999n
if abs(tran_15_and_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_15_and_out expected 0 V
end
meas tran tran_15_or_out find v(or_out) at=15999n
if abs(tran_15_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_15_or_out expected 5 V
end
meas tran tran_16_sum find v(sum) at=16999n
if abs(tran_16_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_16_sum expected -5 V
end
meas tran tran_16_cout find v(cout) at=16999n
if abs(tran_16_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_16_cout expected 0 V
end
meas tran tran_16_xdut_p find v(xdut.p) at=16999n
if abs(tran_16_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_16_xdut_p expected 0.0 V
end
meas tran tran_16_and_out find v(and_out) at=16999n
if abs(tran_16_and_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_16_and_out expected 0 V
end
meas tran tran_16_or_out find v(or_out) at=16999n
if abs(tran_16_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_16_or_out expected 5 V
end
meas tran tran_17_sum find v(sum) at=17999n
if abs(tran_17_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_17_sum expected 0 V
end
meas tran tran_17_cout find v(cout) at=17999n
if abs(tran_17_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_17_cout expected 0 V
end
meas tran tran_17_xdut_p find v(xdut.p) at=17999n
if abs(tran_17_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_17_xdut_p expected 0.0 V
end
meas tran tran_17_and_out find v(and_out) at=17999n
if abs(tran_17_and_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_17_and_out expected 0 V
end
meas tran tran_17_or_out find v(or_out) at=17999n
if abs(tran_17_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_17_or_out expected 5 V
end
meas tran tran_18_sum find v(sum) at=18999n
if abs(tran_18_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_18_sum expected 0 V
end
meas tran tran_18_cout find v(cout) at=18999n
if abs(tran_18_cout-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_18_cout expected -5 V
end
meas tran tran_18_xdut_p find v(xdut.p) at=18999n
if abs(tran_18_xdut_p-(-5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_18_xdut_p expected -5.0 V
end
meas tran tran_18_and_out find v(and_out) at=18999n
if abs(tran_18_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_18_and_out expected -5 V
end
meas tran tran_18_or_out find v(or_out) at=18999n
if abs(tran_18_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_18_or_out expected 5 V
end
meas tran tran_19_sum find v(sum) at=19999n
if abs(tran_19_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_19_sum expected 5 V
end
meas tran tran_19_cout find v(cout) at=19999n
if abs(tran_19_cout-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_19_cout expected -5 V
end
meas tran tran_19_xdut_p find v(xdut.p) at=19999n
if abs(tran_19_xdut_p-(-5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_19_xdut_p expected -5.0 V
end
meas tran tran_19_and_out find v(and_out) at=19999n
if abs(tran_19_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_19_and_out expected -5 V
end
meas tran tran_19_or_out find v(or_out) at=19999n
if abs(tran_19_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_19_or_out expected 5 V
end
meas tran tran_20_sum find v(sum) at=20999n
if abs(tran_20_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_20_sum expected -5 V
end
meas tran tran_20_cout find v(cout) at=20999n
if abs(tran_20_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_20_cout expected 0 V
end
meas tran tran_20_xdut_p find v(xdut.p) at=20999n
if abs(tran_20_xdut_p-(-5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_20_xdut_p expected -5.0 V
end
meas tran tran_20_and_out find v(and_out) at=20999n
if abs(tran_20_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_20_and_out expected -5 V
end
meas tran tran_20_or_out find v(or_out) at=20999n
if abs(tran_20_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_20_or_out expected 5 V
end
meas tran tran_21_sum find v(sum) at=21999n
if abs(tran_21_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_21_sum expected 5 V
end
meas tran tran_21_cout find v(cout) at=21999n
if abs(tran_21_cout-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_21_cout expected -5 V
end
meas tran tran_21_xdut_p find v(xdut.p) at=21999n
if abs(tran_21_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_21_xdut_p expected 0.0 V
end
meas tran tran_21_and_out find v(and_out) at=21999n
if abs(tran_21_and_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_21_and_out expected 0 V
end
meas tran tran_21_or_out find v(or_out) at=21999n
if abs(tran_21_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_21_or_out expected 5 V
end
meas tran tran_22_sum find v(sum) at=22999n
if abs(tran_22_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_22_sum expected -5 V
end
meas tran tran_22_cout find v(cout) at=22999n
if abs(tran_22_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_22_cout expected 0 V
end
meas tran tran_22_xdut_p find v(xdut.p) at=22999n
if abs(tran_22_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_22_xdut_p expected 0.0 V
end
meas tran tran_22_and_out find v(and_out) at=22999n
if abs(tran_22_and_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_22_and_out expected 0 V
end
meas tran tran_22_or_out find v(or_out) at=22999n
if abs(tran_22_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_22_or_out expected 5 V
end
meas tran tran_23_sum find v(sum) at=23999n
if abs(tran_23_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_23_sum expected 0 V
end
meas tran tran_23_cout find v(cout) at=23999n
if abs(tran_23_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_23_cout expected 0 V
end
meas tran tran_23_xdut_p find v(xdut.p) at=23999n
if abs(tran_23_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_23_xdut_p expected 0.0 V
end
meas tran tran_23_and_out find v(and_out) at=23999n
if abs(tran_23_and_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_23_and_out expected 0 V
end
meas tran tran_23_or_out find v(or_out) at=23999n
if abs(tran_23_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_23_or_out expected 5 V
end
meas tran tran_24_sum find v(sum) at=24999n
if abs(tran_24_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_24_sum expected -5 V
end
meas tran tran_24_cout find v(cout) at=24999n
if abs(tran_24_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_24_cout expected 0 V
end
meas tran tran_24_xdut_p find v(xdut.p) at=24999n
if abs(tran_24_xdut_p-(5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_24_xdut_p expected 5.0 V
end
meas tran tran_24_and_out find v(and_out) at=24999n
if abs(tran_24_and_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_24_and_out expected 5 V
end
meas tran tran_24_or_out find v(or_out) at=24999n
if abs(tran_24_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_24_or_out expected 5 V
end
meas tran tran_25_sum find v(sum) at=25999n
if abs(tran_25_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_25_sum expected 0 V
end
meas tran tran_25_cout find v(cout) at=25999n
if abs(tran_25_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_25_cout expected 0 V
end
meas tran tran_25_xdut_p find v(xdut.p) at=25999n
if abs(tran_25_xdut_p-(5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_25_xdut_p expected 5.0 V
end
meas tran tran_25_and_out find v(and_out) at=25999n
if abs(tran_25_and_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_25_and_out expected 5 V
end
meas tran tran_25_or_out find v(or_out) at=25999n
if abs(tran_25_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_25_or_out expected 5 V
end
meas tran tran_26_sum find v(sum) at=26999n
if abs(tran_26_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_26_sum expected 5 V
end
meas tran tran_26_cout find v(cout) at=26999n
if abs(tran_26_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_26_cout expected 0 V
end
meas tran tran_26_xdut_p find v(xdut.p) at=26999n
if abs(tran_26_xdut_p-(5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_26_xdut_p expected 5.0 V
end
meas tran tran_26_and_out find v(and_out) at=26999n
if abs(tran_26_and_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_26_and_out expected 5 V
end
meas tran tran_26_or_out find v(or_out) at=26999n
if abs(tran_26_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_26_or_out expected 5 V
end
meas tran tran_27_sum find v(sum) at=27999n
if abs(tran_27_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_27_sum expected 0 V
end
meas tran tran_27_cout find v(cout) at=27999n
if abs(tran_27_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_27_cout expected 0 V
end
meas tran tran_27_xdut_p find v(xdut.p) at=27999n
if abs(tran_27_xdut_p-(5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_27_xdut_p expected 5.0 V
end
meas tran tran_27_and_out find v(and_out) at=27999n
if abs(tran_27_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_27_and_out expected -5 V
end
meas tran tran_27_or_out find v(or_out) at=27999n
if abs(tran_27_or_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_27_or_out expected -5 V
end
meas tran tran_28_sum find v(sum) at=28999n
if abs(tran_28_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_28_sum expected 5 V
end
meas tran tran_28_cout find v(cout) at=28999n
if abs(tran_28_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_28_cout expected 0 V
end
meas tran tran_28_xdut_p find v(xdut.p) at=28999n
if abs(tran_28_xdut_p-(5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_28_xdut_p expected 5.0 V
end
meas tran tran_28_and_out find v(and_out) at=28999n
if abs(tran_28_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_28_and_out expected -5 V
end
meas tran tran_28_or_out find v(or_out) at=28999n
if abs(tran_28_or_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_28_or_out expected -5 V
end
meas tran tran_29_sum find v(sum) at=29999n
if abs(tran_29_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_29_sum expected -5 V
end
meas tran tran_29_cout find v(cout) at=29999n
if abs(tran_29_cout-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_29_cout expected 5 V
end
meas tran tran_29_xdut_p find v(xdut.p) at=29999n
if abs(tran_29_xdut_p-(5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_29_xdut_p expected 5.0 V
end
meas tran tran_29_and_out find v(and_out) at=29999n
if abs(tran_29_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_29_and_out expected -5 V
end
meas tran tran_29_or_out find v(or_out) at=29999n
if abs(tran_29_or_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_29_or_out expected -5 V
end
meas tran tran_30_sum find v(sum) at=30999n
if abs(tran_30_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_30_sum expected -5 V
end
meas tran tran_30_cout find v(cout) at=30999n
if abs(tran_30_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_30_cout expected 0 V
end
meas tran tran_30_xdut_p find v(xdut.p) at=30999n
if abs(tran_30_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_30_xdut_p expected 0.0 V
end
meas tran tran_30_and_out find v(and_out) at=30999n
if abs(tran_30_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_30_and_out expected -5 V
end
meas tran tran_30_or_out find v(or_out) at=30999n
if abs(tran_30_or_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_30_or_out expected 0 V
end
meas tran tran_31_sum find v(sum) at=31999n
if abs(tran_31_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_31_sum expected 0 V
end
meas tran tran_31_cout find v(cout) at=31999n
if abs(tran_31_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_31_cout expected 0 V
end
meas tran tran_31_xdut_p find v(xdut.p) at=31999n
if abs(tran_31_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_31_xdut_p expected 0.0 V
end
meas tran tran_31_and_out find v(and_out) at=31999n
if abs(tran_31_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_31_and_out expected -5 V
end
meas tran tran_31_or_out find v(or_out) at=31999n
if abs(tran_31_or_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_31_or_out expected 0 V
end
meas tran tran_32_sum find v(sum) at=32999n
if abs(tran_32_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_32_sum expected 5 V
end
meas tran tran_32_cout find v(cout) at=32999n
if abs(tran_32_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_32_cout expected 0 V
end
meas tran tran_32_xdut_p find v(xdut.p) at=32999n
if abs(tran_32_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_32_xdut_p expected 0.0 V
end
meas tran tran_32_and_out find v(and_out) at=32999n
if abs(tran_32_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_32_and_out expected -5 V
end
meas tran tran_32_or_out find v(or_out) at=32999n
if abs(tran_32_or_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_32_or_out expected 0 V
end
meas tran tran_33_sum find v(sum) at=33999n
if abs(tran_33_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_33_sum expected 5 V
end
meas tran tran_33_cout find v(cout) at=33999n
if abs(tran_33_cout-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_33_cout expected -5 V
end
meas tran tran_33_xdut_p find v(xdut.p) at=33999n
if abs(tran_33_xdut_p-(-5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_33_xdut_p expected -5.0 V
end
meas tran tran_33_and_out find v(and_out) at=33999n
if abs(tran_33_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_33_and_out expected -5 V
end
meas tran tran_33_or_out find v(or_out) at=33999n
if abs(tran_33_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_33_or_out expected 5 V
end
meas tran tran_34_sum find v(sum) at=34999n
if abs(tran_34_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_34_sum expected -5 V
end
meas tran tran_34_cout find v(cout) at=34999n
if abs(tran_34_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_34_cout expected 0 V
end
meas tran tran_34_xdut_p find v(xdut.p) at=34999n
if abs(tran_34_xdut_p-(-5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_34_xdut_p expected -5.0 V
end
meas tran tran_34_and_out find v(and_out) at=34999n
if abs(tran_34_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_34_and_out expected -5 V
end
meas tran tran_34_or_out find v(or_out) at=34999n
if abs(tran_34_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_34_or_out expected 5 V
end
meas tran tran_35_sum find v(sum) at=35999n
if abs(tran_35_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_35_sum expected 0 V
end
meas tran tran_35_cout find v(cout) at=35999n
if abs(tran_35_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_35_cout expected 0 V
end
meas tran tran_35_xdut_p find v(xdut.p) at=35999n
if abs(tran_35_xdut_p-(-5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_35_xdut_p expected -5.0 V
end
meas tran tran_35_and_out find v(and_out) at=35999n
if abs(tran_35_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_35_and_out expected -5 V
end
meas tran tran_35_or_out find v(or_out) at=35999n
if abs(tran_35_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_35_or_out expected 5 V
end
meas tran tran_36_sum find v(sum) at=36999n
if abs(tran_36_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_36_sum expected -5 V
end
meas tran tran_36_cout find v(cout) at=36999n
if abs(tran_36_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_36_cout expected 0 V
end
meas tran tran_36_xdut_p find v(xdut.p) at=36999n
if abs(tran_36_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_36_xdut_p expected 0.0 V
end
meas tran tran_36_and_out find v(and_out) at=36999n
if abs(tran_36_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_36_and_out expected -5 V
end
meas tran tran_36_or_out find v(or_out) at=36999n
if abs(tran_36_or_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_36_or_out expected 0 V
end
meas tran tran_37_sum find v(sum) at=37999n
if abs(tran_37_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_37_sum expected 0 V
end
meas tran tran_37_cout find v(cout) at=37999n
if abs(tran_37_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_37_cout expected 0 V
end
meas tran tran_37_xdut_p find v(xdut.p) at=37999n
if abs(tran_37_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_37_xdut_p expected 0.0 V
end
meas tran tran_37_and_out find v(and_out) at=37999n
if abs(tran_37_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_37_and_out expected -5 V
end
meas tran tran_37_or_out find v(or_out) at=37999n
if abs(tran_37_or_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_37_or_out expected 0 V
end
meas tran tran_38_sum find v(sum) at=38999n
if abs(tran_38_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_38_sum expected 5 V
end
meas tran tran_38_cout find v(cout) at=38999n
if abs(tran_38_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_38_cout expected 0 V
end
meas tran tran_38_xdut_p find v(xdut.p) at=38999n
if abs(tran_38_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_38_xdut_p expected 0.0 V
end
meas tran tran_38_and_out find v(and_out) at=38999n
if abs(tran_38_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_38_and_out expected -5 V
end
meas tran tran_38_or_out find v(or_out) at=38999n
if abs(tran_38_or_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_38_or_out expected 0 V
end
meas tran tran_39_sum find v(sum) at=39999n
if abs(tran_39_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_39_sum expected -5 V
end
meas tran tran_39_cout find v(cout) at=39999n
if abs(tran_39_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_39_cout expected 0 V
end
meas tran tran_39_xdut_p find v(xdut.p) at=39999n
if abs(tran_39_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_39_xdut_p expected 0.0 V
end
meas tran tran_39_and_out find v(and_out) at=39999n
if abs(tran_39_and_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_39_and_out expected 0 V
end
meas tran tran_39_or_out find v(or_out) at=39999n
if abs(tran_39_or_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_39_or_out expected 0 V
end
meas tran tran_40_sum find v(sum) at=40999n
if abs(tran_40_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_40_sum expected 0 V
end
meas tran tran_40_cout find v(cout) at=40999n
if abs(tran_40_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_40_cout expected 0 V
end
meas tran tran_40_xdut_p find v(xdut.p) at=40999n
if abs(tran_40_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_40_xdut_p expected 0.0 V
end
meas tran tran_40_and_out find v(and_out) at=40999n
if abs(tran_40_and_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_40_and_out expected 0 V
end
meas tran tran_40_or_out find v(or_out) at=40999n
if abs(tran_40_or_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_40_or_out expected 0 V
end
meas tran tran_41_sum find v(sum) at=41999n
if abs(tran_41_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_41_sum expected 5 V
end
meas tran tran_41_cout find v(cout) at=41999n
if abs(tran_41_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_41_cout expected 0 V
end
meas tran tran_41_xdut_p find v(xdut.p) at=41999n
if abs(tran_41_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_41_xdut_p expected 0.0 V
end
meas tran tran_41_and_out find v(and_out) at=41999n
if abs(tran_41_and_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_41_and_out expected 0 V
end
meas tran tran_41_or_out find v(or_out) at=41999n
if abs(tran_41_or_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_41_or_out expected 0 V
end
meas tran tran_42_sum find v(sum) at=42999n
if abs(tran_42_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_42_sum expected -5 V
end
meas tran tran_42_cout find v(cout) at=42999n
if abs(tran_42_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_42_cout expected 0 V
end
meas tran tran_42_xdut_p find v(xdut.p) at=42999n
if abs(tran_42_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_42_xdut_p expected 0.0 V
end
meas tran tran_42_and_out find v(and_out) at=42999n
if abs(tran_42_and_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_42_and_out expected 0 V
end
meas tran tran_42_or_out find v(or_out) at=42999n
if abs(tran_42_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_42_or_out expected 5 V
end
meas tran tran_43_sum find v(sum) at=43999n
if abs(tran_43_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_43_sum expected 0 V
end
meas tran tran_43_cout find v(cout) at=43999n
if abs(tran_43_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_43_cout expected 0 V
end
meas tran tran_43_xdut_p find v(xdut.p) at=43999n
if abs(tran_43_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_43_xdut_p expected 0.0 V
end
meas tran tran_43_and_out find v(and_out) at=43999n
if abs(tran_43_and_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_43_and_out expected 0 V
end
meas tran tran_43_or_out find v(or_out) at=43999n
if abs(tran_43_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_43_or_out expected 5 V
end
meas tran tran_44_sum find v(sum) at=44999n
if abs(tran_44_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_44_sum expected 5 V
end
meas tran tran_44_cout find v(cout) at=44999n
if abs(tran_44_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_44_cout expected 0 V
end
meas tran tran_44_xdut_p find v(xdut.p) at=44999n
if abs(tran_44_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_44_xdut_p expected 0.0 V
end
meas tran tran_44_and_out find v(and_out) at=44999n
if abs(tran_44_and_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_44_and_out expected 0 V
end
meas tran tran_44_or_out find v(or_out) at=44999n
if abs(tran_44_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_44_or_out expected 5 V
end
meas tran tran_45_sum find v(sum) at=45999n
if abs(tran_45_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_45_sum expected 5 V
end
meas tran tran_45_cout find v(cout) at=45999n
if abs(tran_45_cout-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_45_cout expected -5 V
end
meas tran tran_45_xdut_p find v(xdut.p) at=45999n
if abs(tran_45_xdut_p-(-5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_45_xdut_p expected -5.0 V
end
meas tran tran_45_and_out find v(and_out) at=45999n
if abs(tran_45_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_45_and_out expected -5 V
end
meas tran tran_45_or_out find v(or_out) at=45999n
if abs(tran_45_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_45_or_out expected 5 V
end
meas tran tran_46_sum find v(sum) at=46999n
if abs(tran_46_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_46_sum expected -5 V
end
meas tran tran_46_cout find v(cout) at=46999n
if abs(tran_46_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_46_cout expected 0 V
end
meas tran tran_46_xdut_p find v(xdut.p) at=46999n
if abs(tran_46_xdut_p-(-5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_46_xdut_p expected -5.0 V
end
meas tran tran_46_and_out find v(and_out) at=46999n
if abs(tran_46_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_46_and_out expected -5 V
end
meas tran tran_46_or_out find v(or_out) at=46999n
if abs(tran_46_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_46_or_out expected 5 V
end
meas tran tran_47_sum find v(sum) at=47999n
if abs(tran_47_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_47_sum expected 0 V
end
meas tran tran_47_cout find v(cout) at=47999n
if abs(tran_47_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_47_cout expected 0 V
end
meas tran tran_47_xdut_p find v(xdut.p) at=47999n
if abs(tran_47_xdut_p-(-5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_47_xdut_p expected -5.0 V
end
meas tran tran_47_and_out find v(and_out) at=47999n
if abs(tran_47_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_47_and_out expected -5 V
end
meas tran tran_47_or_out find v(or_out) at=47999n
if abs(tran_47_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_47_or_out expected 5 V
end
meas tran tran_48_sum find v(sum) at=48999n
if abs(tran_48_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_48_sum expected -5 V
end
meas tran tran_48_cout find v(cout) at=48999n
if abs(tran_48_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_48_cout expected 0 V
end
meas tran tran_48_xdut_p find v(xdut.p) at=48999n
if abs(tran_48_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_48_xdut_p expected 0.0 V
end
meas tran tran_48_and_out find v(and_out) at=48999n
if abs(tran_48_and_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_48_and_out expected 0 V
end
meas tran tran_48_or_out find v(or_out) at=48999n
if abs(tran_48_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_48_or_out expected 5 V
end
meas tran tran_49_sum find v(sum) at=49999n
if abs(tran_49_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_49_sum expected 0 V
end
meas tran tran_49_cout find v(cout) at=49999n
if abs(tran_49_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_49_cout expected 0 V
end
meas tran tran_49_xdut_p find v(xdut.p) at=49999n
if abs(tran_49_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_49_xdut_p expected 0.0 V
end
meas tran tran_49_and_out find v(and_out) at=49999n
if abs(tran_49_and_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_49_and_out expected 0 V
end
meas tran tran_49_or_out find v(or_out) at=49999n
if abs(tran_49_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_49_or_out expected 5 V
end
meas tran tran_50_sum find v(sum) at=50999n
if abs(tran_50_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_50_sum expected 5 V
end
meas tran tran_50_cout find v(cout) at=50999n
if abs(tran_50_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_50_cout expected 0 V
end
meas tran tran_50_xdut_p find v(xdut.p) at=50999n
if abs(tran_50_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_50_xdut_p expected 0.0 V
end
meas tran tran_50_and_out find v(and_out) at=50999n
if abs(tran_50_and_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_50_and_out expected 0 V
end
meas tran tran_50_or_out find v(or_out) at=50999n
if abs(tran_50_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_50_or_out expected 5 V
end
meas tran tran_51_sum find v(sum) at=51999n
if abs(tran_51_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_51_sum expected 0 V
end
meas tran tran_51_cout find v(cout) at=51999n
if abs(tran_51_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_51_cout expected 0 V
end
meas tran tran_51_xdut_p find v(xdut.p) at=51999n
if abs(tran_51_xdut_p-(5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_51_xdut_p expected 5.0 V
end
meas tran tran_51_and_out find v(and_out) at=51999n
if abs(tran_51_and_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_51_and_out expected 5 V
end
meas tran tran_51_or_out find v(or_out) at=51999n
if abs(tran_51_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_51_or_out expected 5 V
end
meas tran tran_52_sum find v(sum) at=52999n
if abs(tran_52_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_52_sum expected 5 V
end
meas tran tran_52_cout find v(cout) at=52999n
if abs(tran_52_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_52_cout expected 0 V
end
meas tran tran_52_xdut_p find v(xdut.p) at=52999n
if abs(tran_52_xdut_p-(5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_52_xdut_p expected 5.0 V
end
meas tran tran_52_and_out find v(and_out) at=52999n
if abs(tran_52_and_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_52_and_out expected 5 V
end
meas tran tran_52_or_out find v(or_out) at=52999n
if abs(tran_52_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_52_or_out expected 5 V
end
meas tran tran_53_sum find v(sum) at=53999n
if abs(tran_53_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_53_sum expected -5 V
end
meas tran tran_53_cout find v(cout) at=53999n
if abs(tran_53_cout-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_53_cout expected 5 V
end
meas tran tran_53_xdut_p find v(xdut.p) at=53999n
if abs(tran_53_xdut_p-(5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_53_xdut_p expected 5.0 V
end
meas tran tran_53_and_out find v(and_out) at=53999n
if abs(tran_53_and_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_53_and_out expected 5 V
end
meas tran tran_53_or_out find v(or_out) at=53999n
if abs(tran_53_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_53_or_out expected 5 V
end
meas tran tran_54_sum find v(sum) at=54999n
if abs(tran_54_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_54_sum expected 5 V
end
meas tran tran_54_cout find v(cout) at=54999n
if abs(tran_54_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_54_cout expected 0 V
end
meas tran tran_54_xdut_p find v(xdut.p) at=54999n
if abs(tran_54_xdut_p-(5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_54_xdut_p expected 5.0 V
end
meas tran tran_54_and_out find v(and_out) at=54999n
if abs(tran_54_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_54_and_out expected -5 V
end
meas tran tran_54_or_out find v(or_out) at=54999n
if abs(tran_54_or_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_54_or_out expected -5 V
end
meas tran tran_55_sum find v(sum) at=55999n
if abs(tran_55_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_55_sum expected -5 V
end
meas tran tran_55_cout find v(cout) at=55999n
if abs(tran_55_cout-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_55_cout expected 5 V
end
meas tran tran_55_xdut_p find v(xdut.p) at=55999n
if abs(tran_55_xdut_p-(5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_55_xdut_p expected 5.0 V
end
meas tran tran_55_and_out find v(and_out) at=55999n
if abs(tran_55_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_55_and_out expected -5 V
end
meas tran tran_55_or_out find v(or_out) at=55999n
if abs(tran_55_or_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_55_or_out expected -5 V
end
meas tran tran_56_sum find v(sum) at=56999n
if abs(tran_56_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_56_sum expected 0 V
end
meas tran tran_56_cout find v(cout) at=56999n
if abs(tran_56_cout-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_56_cout expected 5 V
end
meas tran tran_56_xdut_p find v(xdut.p) at=56999n
if abs(tran_56_xdut_p-(5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_56_xdut_p expected 5.0 V
end
meas tran tran_56_and_out find v(and_out) at=56999n
if abs(tran_56_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_56_and_out expected -5 V
end
meas tran tran_56_or_out find v(or_out) at=56999n
if abs(tran_56_or_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_56_or_out expected -5 V
end
meas tran tran_57_sum find v(sum) at=57999n
if abs(tran_57_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_57_sum expected 0 V
end
meas tran tran_57_cout find v(cout) at=57999n
if abs(tran_57_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_57_cout expected 0 V
end
meas tran tran_57_xdut_p find v(xdut.p) at=57999n
if abs(tran_57_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_57_xdut_p expected 0.0 V
end
meas tran tran_57_and_out find v(and_out) at=57999n
if abs(tran_57_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_57_and_out expected -5 V
end
meas tran tran_57_or_out find v(or_out) at=57999n
if abs(tran_57_or_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_57_or_out expected 0 V
end
meas tran tran_58_sum find v(sum) at=58999n
if abs(tran_58_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_58_sum expected 5 V
end
meas tran tran_58_cout find v(cout) at=58999n
if abs(tran_58_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_58_cout expected 0 V
end
meas tran tran_58_xdut_p find v(xdut.p) at=58999n
if abs(tran_58_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_58_xdut_p expected 0.0 V
end
meas tran tran_58_and_out find v(and_out) at=58999n
if abs(tran_58_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_58_and_out expected -5 V
end
meas tran tran_58_or_out find v(or_out) at=58999n
if abs(tran_58_or_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_58_or_out expected 0 V
end
meas tran tran_59_sum find v(sum) at=59999n
if abs(tran_59_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_59_sum expected -5 V
end
meas tran tran_59_cout find v(cout) at=59999n
if abs(tran_59_cout-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_59_cout expected 5 V
end
meas tran tran_59_xdut_p find v(xdut.p) at=59999n
if abs(tran_59_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_59_xdut_p expected 0.0 V
end
meas tran tran_59_and_out find v(and_out) at=59999n
if abs(tran_59_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_59_and_out expected -5 V
end
meas tran tran_59_or_out find v(or_out) at=59999n
if abs(tran_59_or_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_59_or_out expected 0 V
end
meas tran tran_60_sum find v(sum) at=60999n
if abs(tran_60_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_60_sum expected -5 V
end
meas tran tran_60_cout find v(cout) at=60999n
if abs(tran_60_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_60_cout expected 0 V
end
meas tran tran_60_xdut_p find v(xdut.p) at=60999n
if abs(tran_60_xdut_p-(-5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_60_xdut_p expected -5.0 V
end
meas tran tran_60_and_out find v(and_out) at=60999n
if abs(tran_60_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_60_and_out expected -5 V
end
meas tran tran_60_or_out find v(or_out) at=60999n
if abs(tran_60_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_60_or_out expected 5 V
end
meas tran tran_61_sum find v(sum) at=61999n
if abs(tran_61_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_61_sum expected 0 V
end
meas tran tran_61_cout find v(cout) at=61999n
if abs(tran_61_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_61_cout expected 0 V
end
meas tran tran_61_xdut_p find v(xdut.p) at=61999n
if abs(tran_61_xdut_p-(-5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_61_xdut_p expected -5.0 V
end
meas tran tran_61_and_out find v(and_out) at=61999n
if abs(tran_61_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_61_and_out expected -5 V
end
meas tran tran_61_or_out find v(or_out) at=61999n
if abs(tran_61_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_61_or_out expected 5 V
end
meas tran tran_62_sum find v(sum) at=62999n
if abs(tran_62_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_62_sum expected 5 V
end
meas tran tran_62_cout find v(cout) at=62999n
if abs(tran_62_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_62_cout expected 0 V
end
meas tran tran_62_xdut_p find v(xdut.p) at=62999n
if abs(tran_62_xdut_p-(-5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_62_xdut_p expected -5.0 V
end
meas tran tran_62_and_out find v(and_out) at=62999n
if abs(tran_62_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_62_and_out expected -5 V
end
meas tran tran_62_or_out find v(or_out) at=62999n
if abs(tran_62_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_62_or_out expected 5 V
end
meas tran tran_63_sum find v(sum) at=63999n
if abs(tran_63_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_63_sum expected 0 V
end
meas tran tran_63_cout find v(cout) at=63999n
if abs(tran_63_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_63_cout expected 0 V
end
meas tran tran_63_xdut_p find v(xdut.p) at=63999n
if abs(tran_63_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_63_xdut_p expected 0.0 V
end
meas tran tran_63_and_out find v(and_out) at=63999n
if abs(tran_63_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_63_and_out expected -5 V
end
meas tran tran_63_or_out find v(or_out) at=63999n
if abs(tran_63_or_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_63_or_out expected 0 V
end
meas tran tran_64_sum find v(sum) at=64999n
if abs(tran_64_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_64_sum expected 5 V
end
meas tran tran_64_cout find v(cout) at=64999n
if abs(tran_64_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_64_cout expected 0 V
end
meas tran tran_64_xdut_p find v(xdut.p) at=64999n
if abs(tran_64_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_64_xdut_p expected 0.0 V
end
meas tran tran_64_and_out find v(and_out) at=64999n
if abs(tran_64_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_64_and_out expected -5 V
end
meas tran tran_64_or_out find v(or_out) at=64999n
if abs(tran_64_or_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_64_or_out expected 0 V
end
meas tran tran_65_sum find v(sum) at=65999n
if abs(tran_65_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_65_sum expected -5 V
end
meas tran tran_65_cout find v(cout) at=65999n
if abs(tran_65_cout-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_65_cout expected 5 V
end
meas tran tran_65_xdut_p find v(xdut.p) at=65999n
if abs(tran_65_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_65_xdut_p expected 0.0 V
end
meas tran tran_65_and_out find v(and_out) at=65999n
if abs(tran_65_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_65_and_out expected -5 V
end
meas tran tran_65_or_out find v(or_out) at=65999n
if abs(tran_65_or_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_65_or_out expected 0 V
end
meas tran tran_66_sum find v(sum) at=66999n
if abs(tran_66_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_66_sum expected 0 V
end
meas tran tran_66_cout find v(cout) at=66999n
if abs(tran_66_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_66_cout expected 0 V
end
meas tran tran_66_xdut_p find v(xdut.p) at=66999n
if abs(tran_66_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_66_xdut_p expected 0.0 V
end
meas tran tran_66_and_out find v(and_out) at=66999n
if abs(tran_66_and_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_66_and_out expected 0 V
end
meas tran tran_66_or_out find v(or_out) at=66999n
if abs(tran_66_or_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_66_or_out expected 0 V
end
meas tran tran_67_sum find v(sum) at=67999n
if abs(tran_67_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_67_sum expected 5 V
end
meas tran tran_67_cout find v(cout) at=67999n
if abs(tran_67_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_67_cout expected 0 V
end
meas tran tran_67_xdut_p find v(xdut.p) at=67999n
if abs(tran_67_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_67_xdut_p expected 0.0 V
end
meas tran tran_67_and_out find v(and_out) at=67999n
if abs(tran_67_and_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_67_and_out expected 0 V
end
meas tran tran_67_or_out find v(or_out) at=67999n
if abs(tran_67_or_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_67_or_out expected 0 V
end
meas tran tran_68_sum find v(sum) at=68999n
if abs(tran_68_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_68_sum expected -5 V
end
meas tran tran_68_cout find v(cout) at=68999n
if abs(tran_68_cout-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_68_cout expected 5 V
end
meas tran tran_68_xdut_p find v(xdut.p) at=68999n
if abs(tran_68_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_68_xdut_p expected 0.0 V
end
meas tran tran_68_and_out find v(and_out) at=68999n
if abs(tran_68_and_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_68_and_out expected 0 V
end
meas tran tran_68_or_out find v(or_out) at=68999n
if abs(tran_68_or_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_68_or_out expected 0 V
end
meas tran tran_69_sum find v(sum) at=69999n
if abs(tran_69_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_69_sum expected 0 V
end
meas tran tran_69_cout find v(cout) at=69999n
if abs(tran_69_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_69_cout expected 0 V
end
meas tran tran_69_xdut_p find v(xdut.p) at=69999n
if abs(tran_69_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_69_xdut_p expected 0.0 V
end
meas tran tran_69_and_out find v(and_out) at=69999n
if abs(tran_69_and_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_69_and_out expected 0 V
end
meas tran tran_69_or_out find v(or_out) at=69999n
if abs(tran_69_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_69_or_out expected 5 V
end
meas tran tran_70_sum find v(sum) at=70999n
if abs(tran_70_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_70_sum expected 5 V
end
meas tran tran_70_cout find v(cout) at=70999n
if abs(tran_70_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_70_cout expected 0 V
end
meas tran tran_70_xdut_p find v(xdut.p) at=70999n
if abs(tran_70_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_70_xdut_p expected 0.0 V
end
meas tran tran_70_and_out find v(and_out) at=70999n
if abs(tran_70_and_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_70_and_out expected 0 V
end
meas tran tran_70_or_out find v(or_out) at=70999n
if abs(tran_70_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_70_or_out expected 5 V
end
meas tran tran_71_sum find v(sum) at=71999n
if abs(tran_71_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_71_sum expected -5 V
end
meas tran tran_71_cout find v(cout) at=71999n
if abs(tran_71_cout-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_71_cout expected 5 V
end
meas tran tran_71_xdut_p find v(xdut.p) at=71999n
if abs(tran_71_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_71_xdut_p expected 0.0 V
end
meas tran tran_71_and_out find v(and_out) at=71999n
if abs(tran_71_and_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_71_and_out expected 0 V
end
meas tran tran_71_or_out find v(or_out) at=71999n
if abs(tran_71_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_71_or_out expected 5 V
end
meas tran tran_72_sum find v(sum) at=72999n
if abs(tran_72_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_72_sum expected -5 V
end
meas tran tran_72_cout find v(cout) at=72999n
if abs(tran_72_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_72_cout expected 0 V
end
meas tran tran_72_xdut_p find v(xdut.p) at=72999n
if abs(tran_72_xdut_p-(-5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_72_xdut_p expected -5.0 V
end
meas tran tran_72_and_out find v(and_out) at=72999n
if abs(tran_72_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_72_and_out expected -5 V
end
meas tran tran_72_or_out find v(or_out) at=72999n
if abs(tran_72_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_72_or_out expected 5 V
end
meas tran tran_73_sum find v(sum) at=73999n
if abs(tran_73_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_73_sum expected 0 V
end
meas tran tran_73_cout find v(cout) at=73999n
if abs(tran_73_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_73_cout expected 0 V
end
meas tran tran_73_xdut_p find v(xdut.p) at=73999n
if abs(tran_73_xdut_p-(-5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_73_xdut_p expected -5.0 V
end
meas tran tran_73_and_out find v(and_out) at=73999n
if abs(tran_73_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_73_and_out expected -5 V
end
meas tran tran_73_or_out find v(or_out) at=73999n
if abs(tran_73_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_73_or_out expected 5 V
end
meas tran tran_74_sum find v(sum) at=74999n
if abs(tran_74_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_74_sum expected 5 V
end
meas tran tran_74_cout find v(cout) at=74999n
if abs(tran_74_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_74_cout expected 0 V
end
meas tran tran_74_xdut_p find v(xdut.p) at=74999n
if abs(tran_74_xdut_p-(-5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_74_xdut_p expected -5.0 V
end
meas tran tran_74_and_out find v(and_out) at=74999n
if abs(tran_74_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_74_and_out expected -5 V
end
meas tran tran_74_or_out find v(or_out) at=74999n
if abs(tran_74_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_74_or_out expected 5 V
end
meas tran tran_75_sum find v(sum) at=75999n
if abs(tran_75_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_75_sum expected 0 V
end
meas tran tran_75_cout find v(cout) at=75999n
if abs(tran_75_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_75_cout expected 0 V
end
meas tran tran_75_xdut_p find v(xdut.p) at=75999n
if abs(tran_75_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_75_xdut_p expected 0.0 V
end
meas tran tran_75_and_out find v(and_out) at=75999n
if abs(tran_75_and_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_75_and_out expected 0 V
end
meas tran tran_75_or_out find v(or_out) at=75999n
if abs(tran_75_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_75_or_out expected 5 V
end
meas tran tran_76_sum find v(sum) at=76999n
if abs(tran_76_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_76_sum expected 5 V
end
meas tran tran_76_cout find v(cout) at=76999n
if abs(tran_76_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_76_cout expected 0 V
end
meas tran tran_76_xdut_p find v(xdut.p) at=76999n
if abs(tran_76_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_76_xdut_p expected 0.0 V
end
meas tran tran_76_and_out find v(and_out) at=76999n
if abs(tran_76_and_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_76_and_out expected 0 V
end
meas tran tran_76_or_out find v(or_out) at=76999n
if abs(tran_76_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_76_or_out expected 5 V
end
meas tran tran_77_sum find v(sum) at=77999n
if abs(tran_77_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_77_sum expected -5 V
end
meas tran tran_77_cout find v(cout) at=77999n
if abs(tran_77_cout-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_77_cout expected 5 V
end
meas tran tran_77_xdut_p find v(xdut.p) at=77999n
if abs(tran_77_xdut_p-(0.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_77_xdut_p expected 0.0 V
end
meas tran tran_77_and_out find v(and_out) at=77999n
if abs(tran_77_and_out-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_77_and_out expected 0 V
end
meas tran tran_77_or_out find v(or_out) at=77999n
if abs(tran_77_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_77_or_out expected 5 V
end
meas tran tran_78_sum find v(sum) at=78999n
if abs(tran_78_sum-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_78_sum expected 5 V
end
meas tran tran_78_cout find v(cout) at=78999n
if abs(tran_78_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_78_cout expected 0 V
end
meas tran tran_78_xdut_p find v(xdut.p) at=78999n
if abs(tran_78_xdut_p-(5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_78_xdut_p expected 5.0 V
end
meas tran tran_78_and_out find v(and_out) at=78999n
if abs(tran_78_and_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_78_and_out expected 5 V
end
meas tran tran_78_or_out find v(or_out) at=78999n
if abs(tran_78_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_78_or_out expected 5 V
end
meas tran tran_79_sum find v(sum) at=79999n
if abs(tran_79_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_79_sum expected -5 V
end
meas tran tran_79_cout find v(cout) at=79999n
if abs(tran_79_cout-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_79_cout expected 5 V
end
meas tran tran_79_xdut_p find v(xdut.p) at=79999n
if abs(tran_79_xdut_p-(5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_79_xdut_p expected 5.0 V
end
meas tran tran_79_and_out find v(and_out) at=79999n
if abs(tran_79_and_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_79_and_out expected 5 V
end
meas tran tran_79_or_out find v(or_out) at=79999n
if abs(tran_79_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_79_or_out expected 5 V
end
meas tran tran_80_sum find v(sum) at=80999n
if abs(tran_80_sum-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_80_sum expected 0 V
end
meas tran tran_80_cout find v(cout) at=80999n
if abs(tran_80_cout-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_80_cout expected 5 V
end
meas tran tran_80_xdut_p find v(xdut.p) at=80999n
if abs(tran_80_xdut_p-(5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_80_xdut_p expected 5.0 V
end
meas tran tran_80_and_out find v(and_out) at=80999n
if abs(tran_80_and_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_80_and_out expected 5 V
end
meas tran tran_80_or_out find v(or_out) at=80999n
if abs(tran_80_or_out-(5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_80_or_out expected 5 V
end
meas tran tran_81_sum find v(sum) at=81999n
if abs(tran_81_sum-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_81_sum expected -5 V
end
meas tran tran_81_cout find v(cout) at=81999n
if abs(tran_81_cout-(0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_81_cout expected 0 V
end
meas tran tran_81_xdut_p find v(xdut.p) at=81999n
if abs(tran_81_xdut_p-(5.0)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_81_xdut_p expected 5.0 V
end
meas tran tran_81_and_out find v(and_out) at=81999n
if abs(tran_81_and_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_81_and_out expected -5 V
end
meas tran tran_81_or_out find v(or_out) at=81999n
if abs(tran_81_or_out-(-5)) > 0.5
let const.failures=const.failures+1
echo FAIL: tran_81_or_out expected -5 V
end
plot v(x) v(a) v(b) v(cin) v(sum) ylimit -5.5 5.5 title 'Multiply-add SUM: all 81 states'
plot v(x) v(a) v(b) v(cin) v(cout) ylimit -5.5 5.5 title 'Multiply-add COUT: all 81 states'
plot v(xdut.p) v(sum) v(cout) title 'MUL product and multiply-add outputs'
plot v(a) v(b) v(and_out) v(or_out) ylimit -5.5 5.5 title 'AND=MIN / OR=MAX'
wrdata mac_tran.txt v(x) v(a) v(b) v(cin) v(sum) v(cout) v(xdut.p) v(and_out) v(or_out)
if const.failures = 0
echo PASS: multiply-add all 81 states
else
echo FAIL: multiply-add all 81 states
end
print const.failures
.endc"}
C {devices/netlist_options.sym} 1900 1050 0 0 {name=NETLIST_OPTIONS
lvs_netlist=false
top_is_subckt=false
spiceprefix=true
hiersep=.}
