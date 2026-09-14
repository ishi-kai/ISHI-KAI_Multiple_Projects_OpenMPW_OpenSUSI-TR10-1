v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {COLUMN DECODER 1-to-2 | always selected} -100 -130 0 0 0.3 0.3 {}
T {COL0 = !CA     COL1 = CA} -100 -80 0 0 0.3 0.3 {}
C {TR-1um_5_stdcell/INV_X1.sym} 250 100 0 0 {name=xca_inv}
C {devices/ipin.sym} -100 100 0 0 {name=pCA lab=CA}
N -100 100 230 100 {lab=CA}
N 400 100 400 260 {lab=COL0}
N 150 260 400 260 {lab=COL0}
N 150 260 150 350 {lab=COL0}
N 150 350 230 350 {lab=COL0}
C {TR-1um_5_stdcell/INV_X1.sym} 250 350 0 0 {name=xcol1_drv}
C {devices/lab_pin.sym} 280 310 2 0 {name=drv_vdd lab=VDD}
C {devices/lab_pin.sym} 280 390 2 0 {name=drv_vss lab=VSS}
N 350 350 550 350 {lab=COL1}
N 350 100 550 100 {lab=COL0}
C {devices/opin.sym} 550 100 0 0 {name=pCOL0 lab=COL0}
C {devices/opin.sym} 550 350 0 0 {name=pCOL1 lab=COL1}
C {devices/iopin.sym} 280 -10 0 0 {name=pVDD lab=VDD}
N 280 -10 280 60 {lab=VDD}
C {devices/iopin.sym} 280 230 0 0 {name=pVSS lab=VSS}
N 280 140 280 230 {lab=VSS}
T {Change CA only after all WL are LOW and write pull-downs are OFF.} -100 440 0 0 0.27 0.27 {}
T {Then finish local/common precharge before accessing the next cell.} -100 490 0 0 0.27 0.27 {}
T {Two INV_X1 stages: COL0=!CA; COL1=!COL0. Both mux controls have real drivers.} -100 540 0 0 0.27 0.27 {}
