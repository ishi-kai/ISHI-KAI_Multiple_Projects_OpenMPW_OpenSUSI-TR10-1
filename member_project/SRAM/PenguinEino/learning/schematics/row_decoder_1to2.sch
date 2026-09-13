v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {ROW DECODER 1-to-2 | PDK standard cells} -100 -130 0 0 0.3 0.3 {}
T {WL0 = !RA & WL_EN     WL1 = RA & WL_EN} -100 -80 0 0 0.3 0.3 {}
C {TR-1um_5_stdcell/INV_X1.sym} 100 80 0 0 {name=xra_inv}
C {devices/lab_pin.sym} 130 40 2 0 {name=l10 lab=VDD}
C {devices/lab_pin.sym} 130 120 2 0 {name=l11 lab=VSS}
C {TR-1um_5_stdcell/NAND2.sym} 350 100 0 0 {name=xdec0}
C {devices/lab_pin.sym} 380 40 2 0 {name=l13 lab=VDD}
C {devices/lab_pin.sym} 380 160 2 0 {name=l14 lab=VSS}
C {TR-1um_5_stdcell/INV_X1.sym} 650 100 0 0 {name=xdrv0}
C {devices/lab_pin.sym} 680 60 2 0 {name=l16 lab=VDD}
C {devices/lab_pin.sym} 680 140 2 0 {name=l17 lab=VSS}
C {TR-1um_5_stdcell/NAND2.sym} 350 400 0 0 {name=xdec1}
C {devices/lab_pin.sym} 380 340 2 0 {name=l19 lab=VDD}
C {devices/lab_pin.sym} 380 460 2 0 {name=l20 lab=VSS}
C {TR-1um_5_stdcell/INV_X1.sym} 650 400 0 0 {name=xdrv1}
C {devices/lab_pin.sym} 680 360 2 0 {name=l22 lab=VDD}
C {devices/lab_pin.sym} 680 440 2 0 {name=l23 lab=VSS}
N -100 80 80 80 {lab=RA}
N -40 80 -40 380 {lab=RA}
N -40 380 330 380 {lab=RA}
N 200 80 330 80 {lab=RA_B}
C {devices/lab_pin.sym} 250 80 2 0 {name=l28 lab=RA_B}
N -100 540 280 540 {lab=WL_EN}
N 280 120 280 540 {lab=WL_EN}
N 280 120 330 120 {lab=WL_EN}
N 280 420 330 420 {lab=WL_EN}
N 480 100 630 100 {lab=WL0_B}
C {devices/lab_pin.sym} 550 100 2 0 {name=l34 lab=WL0_B}
N 750 100 900 100 {lab=WL0}
N 480 400 630 400 {lab=WL1_B}
C {devices/lab_pin.sym} 550 400 2 0 {name=l37 lab=WL1_B}
N 750 400 900 400 {lab=WL1}
C {devices/ipin.sym} -100 80 0 0 {name=pRA lab=RA}
C {devices/ipin.sym} -100 540 0 0 {name=pWL_EN lab=WL_EN}
C {devices/opin.sym} 900 100 0 0 {name=pWL0 lab=WL0}
C {devices/opin.sym} 900 400 0 0 {name=pWL1 lab=WL1}
C {devices/iopin.sym} 850 -40 0 0 {name=pVDD lab=VDD}
C {devices/iopin.sym} 850 540 0 0 {name=pVSS lab=VSS}
T {Change RA only while WL_EN=0; allow address and decoder to settle.} -100 640 0 0 0.3 0.3 {}
T {Output INV_X1 drives the actual wordline load. No ideal WL driver.} -100 690 0 0 0.3 0.3 {}
