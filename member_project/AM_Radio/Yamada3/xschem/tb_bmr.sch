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
B 2 1080 -620 1790 -80 {flags=graph
y1=0
y2=80u
ypos1=0
ypos2=2
divy=5
subdivy=4
unity=1
x1=0
divx=5
subdivx=4

unitx=1
dataset=-1
sim_type=dc
color=4
node=i(vmeas_p)
logx=0
logy=0
legend=1
x2=5.5
hilight_wave=0
autoload=1
rainbow=1
rawfile=$netlist_dir/tb_bmr_dc.raw}
B 2 1820 -620 2530 -80 {flags=graph
y1=0
ypos1=0
ypos2=2
divy=5
subdivy=4
unity=1
x1=0
divx=5
subdivx=4

unitx=1
dataset=-1
sim_type=tran
color=4
node=i(vmeas_p)
logx=0
logy=0
legend=1
x2=0.005
hilight_wave=0
autoload=1
rainbow=1
rawfile=$netlist_dir/tb_bmr_tran.raw
y2=80e-06}
B 2 1820 -1160 2530 -620 {flags=graph
y1=0
ypos1=0
ypos2=2
divy=5
subdivy=4
unity=1
x1=0
divx=5
subdivx=4

unitx=1
dataset=-1
sim_type=tran
logx=0
logy=0
legend=1
x2=5m
hilight_wave=0
autoload=1
rainbow=1
rawfile=$netlist_dir/tb_bmr_tran.raw
color=4
node=vdd
y2=5}
B 2 1080 -1160 1790 -620 {flags=graph
y1=0
ypos1=0
ypos2=2
divy=5
subdivy=4
unity=1
x1=0
divx=5
subdivx=4

unitx=1
dataset=-1
sim_type=dc
color=4
node=out
logx=0
logy=0
legend=1
x2=5.5
hilight_wave=0
autoload=1
rainbow=1
rawfile=$netlist_dir/tb_bmr_dc.raw
y2=5}
T {Beta multiplier current reference} 120 -1140 0 0 1 1 {}
T {DC analysis} 1310 -1240 0 0 0.8 0.8 {}
T {TRAN analysis} 2020 -1240 0 0 0.8 0.8 {}
T {Target: 64uA output} 500 -1020 0 0 0.6 0.6 {}
N 140 -760 140 -740 {lab=GND}
N 140 -800 140 -780 {lab=VDD}
N 340 -980 340 -960 {lab=VDD}
N 340 -800 340 -780 {lab=out}
N 440 -900 440 -880 {lab=GND}
N 440 -980 440 -960 {lab=VDD}
N 340 -900 340 -880 {lab=#net1}
N 340 -820 340 -800 {lab=out}
C {devices/code_shown.sym} 290 -420 0 0 {name=NGSPICE only_toplevel=true
value="
.control
save all
save currents
* DC analysis
dc v1 0 5.5 0.1 r1 1k 50k 5k
write tb_bmr_dc.raw
meas dc current_p find i(vmeas_p) at=5

* TRANS analysis
tran 1u 5m
write tb_bmr_tran.raw
.endc
"}
C {devices/title.sym} 160 -30 0 0 {name=l5 author="Yutaka KOTANI"}
C {devices/launcher.sym} 365 -675 0 0 {name=h1
descr="Click left mouse button here with CTRL key
to reload waveforms in graph."
tclcommand="
xschem raw_read $netlist_dir/tb_bmr_dc.raw
xschem raw_read $netlist_dir/tb_bmr_tran.raw

"
}
C {vdd.sym} 140 -800 0 0 {name=l2 lab=VDD}
C {gnd.sym} 140 -740 0 0 {name=l3 lab=GND}
C {vsource.sym} 440 -930 0 0 {name=V1 value="5 PWL(0 0,2ms 5)" savecurrent=false}
C {ammeter.sym} 340 -930 0 0 {name=Vmeas_p savecurrent=true spice_ignore=0}
C {bmr.sym} 240 -770 0 0 {name=x1}
C {vdd.sym} 440 -980 0 0 {name=l1 lab=VDD}
C {gnd.sym} 440 -880 0 0 {name=l4 lab=GND}
C {devices/code.sym} 290 -590 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
C {devices/lab_pin.sym} 340 -800 0 1 {name=p1 sig_type=std_logic lab=out}
C {devices/res.sym} 340 -850 0 0 {name=R1
value=1k
footprint=1206
device=resistor
m=1}
C {vdd.sym} 340 -980 0 0 {name=l6 lab=VDD}
