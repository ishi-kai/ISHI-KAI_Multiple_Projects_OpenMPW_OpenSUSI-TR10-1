v {xschem version=3.4.8RC file_version=1.3
* Copyright 2022 GlobalFoundries PDK Authors
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     https://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.

}
G {}
K {}
V {}
S {}
F {}
E {}
L 4 50 -300 50 -240 {}
L 4 50 -240 320 -240 {}
L 4 320 -300 320 -240 {}
L 4 340 -300 340 -240 {}
L 4 340 -240 720 -240 {}
L 4 720 -300 720 -240 {}
L 4 740 -300 740 -240 {}
L 4 740 -240 1140 -240 {}
L 4 1140 -300 1140 -240 {}
T {Beta multiplier current reference} 0 -1030 0 0 1 1 {}
T {Start up} 110 -220 0 0 0.6 0.6 {}
T {Cascoded Beta multiplier} 330 -220 0 0 0.6 0.6 {}
T {Target: 10uA output} 940 -150 0 0 0.6 0.6 {}
T {Cascoded current mirror} 750 -220 0 0 0.6 0.6 {}
N 440 -760 440 -740 {lab=#net1}
N 130 -710 140 -710 {lab=VDD}
N 140 -780 140 -740 {lab=VDD}
N 130 -760 130 -710 {lab=VDD}
N 130 -760 140 -760 {lab=VDD}
N 440 -780 440 -760 {lab=#net1}
N 430 -710 440 -710 {lab=#net1}
N 430 -760 430 -710 {lab=#net1}
N 630 -780 630 -740 {lab=#net2}
N 630 -760 640 -760 {lab=#net2}
N 640 -760 640 -710 {lab=#net2}
N 630 -710 640 -710 {lab=#net2}
N 140 -660 240 -660 {lab=#net3}
N 180 -710 200 -710 {lab=#net3}
N 200 -700 200 -660 {lab=#net3}
N 280 -710 280 -690 {lab=#net4}
N 200 -710 200 -700 {lab=#net3}
N 280 -660 290 -660 {lab=GND}
N 290 -660 290 -620 {lab=GND}
N 430 -760 440 -760 {lab=#net1}
N 130 -570 140 -570 {lab=GND}
N 130 -570 130 -510 {lab=GND}
N 130 -510 140 -510 {lab=GND}
N 430 -470 430 -410 {lab=GND}
N 430 -410 440 -410 {lab=GND}
N 630 -470 640 -470 {lab=#net5}
N 640 -470 640 -410 {lab=#net5}
N 630 -410 640 -410 {lab=#net5}
N 440 -680 440 -600 {lab=#net6}
N 140 -680 140 -600 {lab=#net3}
N 140 -540 140 -400 {lab=GND}
N 440 -440 440 -300 {lab=GND}
N 630 -300 630 -280 {lab=GND}
N 220 -390 500 -390 {lab=#net6}
N 440 -300 440 -290 {lab=GND}
N 590 -330 610 -330 {lab=VDD}
N 630 -380 630 -360 {lab=#net5}
N 590 -350 590 -330 {lab=VDD}
N 180 -570 220 -570 {lab=#net6}
N 220 -570 220 -490 {lab=#net6}
N 630 -440 630 -380 {lab=#net5}
N 440 -290 440 -280 {lab=GND}
N 140 -400 140 -380 {lab=GND}
N 1280 -520 1300 -520 {lab=VDD}
N 1280 -480 1300 -480 {lab=GND}
N 1280 -440 1300 -440 {lab=64uA_OUT}
N 560 -530 560 -470 {lab=#net6}
N 560 -570 560 -530 {lab=#net6}
N 560 -470 590 -470 {lab=#net6}
N 630 -680 630 -500 {lab=#net4}
N 220 -490 220 -390 {lab=#net6}
N 440 -600 440 -500 {lab=#net6}
N 430 -470 440 -470 {lab=GND}
N 500 -570 500 -390 {lab=#net6}
N 480 -470 500 -470 {lab=#net6}
N 440 -570 500 -570 {lab=#net6}
N 280 -630 280 -570 {lab=#net6}
N 280 -570 440 -570 {lab=#net6}
N 560 -710 590 -710 {lab=#net4}
N 480 -710 540 -710 {lab=#net4}
N 540 -710 560 -710 {lab=#net4}
N 540 -710 540 -650 {lab=#net4}
N 500 -570 560 -570 {lab=#net6}
N 540 -650 630 -650 {lab=#net4}
N 830 -780 830 -740 {lab=#net7}
N 830 -760 840 -760 {lab=#net7}
N 840 -760 840 -710 {lab=#net7}
N 830 -710 840 -710 {lab=#net7}
N 760 -710 790 -710 {lab=#net4}
N 760 -710 760 -650 {lab=#net4}
N 830 -680 830 -600 {lab=#net8}
N 830 -540 830 -500 {lab=#net9}
N 830 -440 830 -400 {lab=GND}
N 820 -470 830 -470 {lab=GND}
N 820 -470 820 -420 {lab=GND}
N 820 -420 830 -420 {lab=GND}
N 630 -650 760 -650 {lab=#net4}
N 1000 -540 1000 -500 {lab=#net10}
N 1000 -440 1000 -400 {lab=GND}
N 1000 -470 1010 -470 {lab=GND}
N 1010 -470 1010 -420 {lab=GND}
N 1000 -420 1010 -420 {lab=GND}
N 870 -570 960 -570 {lab=#net8}
N 870 -470 960 -470 {lab=#net9}
N 830 -620 900 -620 {lab=#net8}
N 900 -620 900 -570 {lab=#net8}
N 830 -520 900 -520 {lab=#net9}
N 900 -520 900 -470 {lab=#net9}
N 1000 -680 1000 -600 {lab=64uA_OUT}
N 820 -570 830 -570 {lab=GND}
N 820 -570 820 -470 {lab=GND}
N 1000 -570 1010 -570 {lab=GND}
N 1010 -570 1010 -470 {lab=GND}
N 440 -860 440 -840 {lab=VDD}
N 440 -880 440 -860 {lab=VDD}
N 430 -810 440 -810 {lab=VDD}
N 430 -860 430 -810 {lab=VDD}
N 630 -880 630 -840 {lab=VDD}
N 630 -860 640 -860 {lab=VDD}
N 640 -860 640 -810 {lab=VDD}
N 630 -810 640 -810 {lab=VDD}
N 430 -860 440 -860 {lab=VDD}
N 560 -810 590 -810 {lab=#net2}
N 480 -810 540 -810 {lab=#net2}
N 540 -810 560 -810 {lab=#net2}
N 830 -880 830 -840 {lab=VDD}
N 830 -860 840 -860 {lab=VDD}
N 840 -860 840 -810 {lab=VDD}
N 830 -810 840 -810 {lab=VDD}
N 760 -810 790 -810 {lab=#net2}
N 760 -810 760 -760 {lab=#net2}
N 540 -760 630 -760 {lab=#net2}
N 540 -810 540 -760 {lab=#net2}
N 280 -710 340 -710 {lab=#net4}
N 360 -710 360 -650 {lab=#net4}
N 510 -710 510 -650 {lab=#net4}
N 640 -760 760 -760 {lab=#net2}
N 340 -710 360 -710 {lab=#net4}
N 360 -650 510 -650 {lab=#net4}
C {devices/title.sym} 160 -30 0 0 {name=l5 author="Yutaka KOTANI"}
C {gnd.sym} 290 -620 0 0 {name=l17 lab=GND}
C {lab_pin.sym} 140 -380 0 0 {name=p1 sig_type=std_logic lab=GND}
C {lab_pin.sym} 440 -280 0 0 {name=p2 sig_type=std_logic lab=GND}
C {lab_pin.sym} 630 -280 0 0 {name=p3 sig_type=std_logic lab=GND}
C {lab_pin.sym} 1000 -680 0 1 {name=p4 sig_type=std_logic lab=64uA_OUT}
C {lab_pin.sym} 590 -350 0 0 {name=p5 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 630 -880 0 0 {name=p7 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 440 -880 0 0 {name=p8 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 140 -780 0 0 {name=p9 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1300 -440 0 1 {name=p10 sig_type=std_logic lab=64uA_OUT}
C {lab_pin.sym} 1300 -520 0 1 {name=p11 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1300 -480 0 1 {name=p12 sig_type=std_logic lab=GND}
C {ipin.sym} 1280 -520 0 0 {name=p13 lab=VDD}
C {ipin.sym} 1280 -480 0 0 {name=p14 lab=GND}
C {opin.sym} 1280 -440 0 1 {name=p15 lab=64uA_OUT}
C {IP62LIB/MP.sym} 180 -710 0 1 {name=XM1
model=PMOS
w=4u
l=4u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {IP62LIB/MN.sym} 180 -570 0 1 {name=XM2
model=NMOS
w=10u
l=2u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {IP62LIB/MN.sym} 240 -660 0 0 {name=XM3
model=NMOS
w=10u
l=1u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {IP62LIB/MP.sym} 480 -710 0 1 {name=XM4
model=PMOS
w=30u
l=2u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {IP62LIB/MP.sym} 590 -710 0 0 {name=XM5
model=PMOS
w=30u
l=2u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {IP62LIB/MN.sym} 480 -470 0 1 {name=XM7
model=NMOS
w=10u
l=2u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {IP62LIB/MN.sym} 590 -470 0 0 {name=XM8
model=NMOS
w=40u
l=2u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {IP62LIB/RR.sym} 630 -360 0 1 {name=R1
w=4e-06
R=1
l=27e-06
model=F_RR
spiceprefix=X
tc1=0
tc2=0
m=1}
C {lab_pin.sym} 830 -880 0 0 {name=p6 sig_type=std_logic lab=VDD}
C {IP62LIB/MP.sym} 790 -710 0 0 {name=XM6
model=PMOS
w=30u
l=2u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {IP62LIB/MN.sym} 870 -570 0 1 {name=XM9
model=NMOS
w=10u
l=2u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {IP62LIB/MN.sym} 870 -470 0 1 {name=XM10
model=NMOS
w=10u
l=2u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {lab_pin.sym} 830 -400 0 0 {name=p16 sig_type=std_logic lab=GND}
C {IP62LIB/MN.sym} 960 -570 0 0 {name=XM11
model=NMOS
w=10u
l=2u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {IP62LIB/MN.sym} 960 -470 0 0 {name=XM12
model=NMOS
w=10u
l=2u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {lab_pin.sym} 1000 -400 0 1 {name=p17 sig_type=std_logic lab=GND}
C {IP62LIB/MP.sym} 480 -810 0 1 {name=XM13
model=PMOS
w=30u
l=2u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {IP62LIB/MP.sym} 590 -810 0 0 {name=XM14
model=PMOS
w=30u
l=2u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
C {IP62LIB/MP.sym} 790 -810 0 0 {name=XM15
model=PMOS
w=30u
l=2u
m=1
spiceprefix=X
as=0
ad=0
ps=0
pd=0
nrd=0
nrs=0}
