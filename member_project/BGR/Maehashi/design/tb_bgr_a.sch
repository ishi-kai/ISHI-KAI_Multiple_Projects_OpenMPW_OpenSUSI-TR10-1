v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 60 -320 60 -160 {lab=VDD}
N 60 -320 160 -320 {lab=VDD}
N 160 -320 160 -300 {lab=VDD}
N 60 -100 60 -60 {lab=GND}
N 60 -80 160 -80 {lab=GND}
N 160 -220 160 -80 {lab=GND}
N 260 -260 300 -260 {lab=VBGR}
N 300 -260 300 -160 {lab=VBGR}
N 300 -100 300 -80 {lab=GND}
N 160 -80 300 -80 {lab=GND}
C {bgr_a.sym} 180 -260 0 0 {name=x1}
C {devices/code.sym} 0 40 0 0 {name=dcop only_toplevel=false value="
.option savecurrents
.temp 40
.param vdd = 5
.control
set units=degree
save all

alterparam vthMN = 0.1 ; Slow:0.1, Fast:-0.1
alterparam vthMP = 0.1 ; Slow:-0.1, Fast:0.1
alterparam magRS = 1 ; Slow:1.2, Fast:0.85
reset

op
show m
let vsat_marg_mp1 = @m.x1.xxmp1.m1[vds] - (@m.x1.xxmp1.m1[vgs] - @m.x1.xxmp1.m1[vth])
let vsat_marg_mp2 = @m.x1.xxmp2.m1[vds] - (@m.x1.xxmp2.m1[vgs] - @m.x1.xxmp2.m1[vth])
let vsat_marg_mp3 = @m.x1.xxmp3.m1[vds] - (@m.x1.xxmp3.m1[vgs] - @m.x1.xxmp3.m1[vth])
let vsat_marg_mp4 = @m.x1.xxmp4.m1[vds] - (@m.x1.xxmp4.m1[vgs] - @m.x1.xxmp4.m1[vth])
let vsat_marg_mp5 = @m.x1.xxmp5.m1[vds] - (@m.x1.xxmp5.m1[vgs] - @m.x1.xxmp5.m1[vth])
let vsat_marg_mp6 = @m.x1.xxmp6.m1[vds] - (@m.x1.xxmp6.m1[vgs] - @m.x1.xxmp6.m1[vth])

let vsat_marg_mn1 = @m.x1.xxmn1.m1[vds] - (@m.x1.xxmn1.m1[vgs] - @m.x1.xxmn1.m1[vth])
let vsat_marg_mn2 = @m.x1.xxmn2.m1[vds] - (@m.x1.xxmn2.m1[vgs] - @m.x1.xxmn2.m1[vth])
let vsat_marg_mn3 = @m.x1.xxmn3.m1[vds] - (@m.x1.xxmn3.m1[vgs] - @m.x1.xxmn3.m1[vth])
let vsat_marg_mn4 = @m.x1.xxmn4.m1[vds] - (@m.x1.xxmn4.m1[vgs] - @m.x1.xxmn4.m1[vth])

*echo '*** SF/5.0V/40deg ***' >> bgr_a_dcop.txt
*echo 'ignore VsatMargin Vds Vgs Vth' >> bgr_a_dcop.txt
*set appendwrite
*set wr_singlescale
*wrdata bgr_a_dcop.txt vsat_marg_mp1 @m.x1.xxmp1.m1[vds] @m.x1.xxmp1.m1[vgs] @m.x1.xxmp1.m1[vth]
*wrdata bgr_a_dcop.txt vsat_marg_mp2 @m.x1.xxmp2.m1[vds] @m.x1.xxmp2.m1[vgs] @m.x1.xxmp2.m1[vth]
*wrdata bgr_a_dcop.txt vsat_marg_mp3 @m.x1.xxmp3.m1[vds] @m.x1.xxmp3.m1[vgs] @m.x1.xxmp3.m1[vth]
*wrdata bgr_a_dcop.txt vsat_marg_mp4 @m.x1.xxmp4.m1[vds] @m.x1.xxmp4.m1[vgs] @m.x1.xxmp4.m1[vth]
*wrdata bgr_a_dcop.txt vsat_marg_mp5 @m.x1.xxmp5.m1[vds] @m.x1.xxmp5.m1[vgs] @m.x1.xxmp5.m1[vth]
*wrdata bgr_a_dcop.txt vsat_marg_mp6 @m.x1.xxmp6.m1[vds] @m.x1.xxmp6.m1[vgs] @m.x1.xxmp6.m1[vth]

*wrdata bgr_a_dcop.txt vsat_marg_mn1 @m.x1.xxmn1.m1[vds] @m.x1.xxmn1.m1[vgs] @m.x1.xxmn1.m1[vth]
*wrdata bgr_a_dcop.txt vsat_marg_mn2 @m.x1.xxmn2.m1[vds] @m.x1.xxmn2.m1[vgs] @m.x1.xxmn2.m1[vth]
*wrdata bgr_a_dcop.txt vsat_marg_mn3 @m.x1.xxmn3.m1[vds] @m.x1.xxmn3.m1[vgs] @m.x1.xxmn3.m1[vth]
*wrdata bgr_a_dcop.txt vsat_marg_mn4 @m.x1.xxmn4.m1[vds] @m.x1.xxmn4.m1[vgs] @m.x1.xxmn4.m1[vth]

.endc"
}
C {devices/code.sym} 140 40 0 0 {name=dc_temp only_toplevel=false value="
.option savecurrents
.temp 40
.param vdd = 5.5
.control
set units=degree
save all

alterparam vthMN = 0.1 ; Slow:0.1, Fast:-0.1
alterparam vthMP = 0.1 ; Slow:-0.1, Fast:0.1
alterparam magRS = 1 ; Slow:1.2, Fast:0.85
reset

*dc Vdd 4.5 5.5 0.1
*plot v(VBGR) ylimit 1.0 1.3 xlabel Vdd ylabel Vbgr
*plot @m.x1.xmp3.m1[id] xlabel Vdd ylabel Iout

dc temp 0 80 0.1
gnuplot bgraDcVoutTemp_SF55V v(VBGR)
*plot v(VBGR)  xlabel Temp ylabel Vout

.endc"
spice_ignore=true}
C {devices/code.sym} 280 40 0 0 {name=tran only_toplevel=false value="
.option savecurrents
.temp 40
.param vdd = 5
.control
set units=degree
save all

alterparam vthMN = -0.10001 ; Slow:0.1, Fast:-0.1
alterparam vthMP = -0.10001 ; Slow:-0.1, Fast:0.1
alterparam magRS = 1 ; Slow:1.2, Fast:0.85
reset

tran 10ns 5us
gnuplot bgraTranStartup_FS v(VDD) v(VBGR)
*plot v(VBGR) ylimit 0 1.2 xlabel Time ylabel Vbgr
*plot @m.x1.xmp3.m1[id] xlabel Temp ylabel Iout

.endc"
spice_ignore=true}
C {devices/vsource.sym} 60 -130 0 0 {name=V1 value="dc vdd pwl(0 0 1u vdd)"  savecurrent=false}
C {devices/gnd.sym} 60 -60 0 0 {name=l1 lab=GND}
C {devices/lab_wire.sym} 60 -320 0 0 {name=p1 sig_type=std_logic lab=VDD}
C {devices/capa.sym} 300 -130 0 0 {name=C1
m=1
value=1p
footprint=1206
device="ceramic capacitor"}
C {devices/lab_wire.sym} 280 -260 0 1 {name=p2 sig_type=std_logic lab=VBGR}
C {devices/code.sym} -180 40 0 0 {name=TR-1um_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".include $::LIB/ip62_models"
spice_ignore=false}
