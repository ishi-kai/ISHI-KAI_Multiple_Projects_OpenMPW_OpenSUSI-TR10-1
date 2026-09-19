# 半導体計測用アドレスデコーダ・マルチプレクサ

## 目的

限られたピン数で多くの回路機能を実現するため、8ビットのアドレスデコーダとマルチプレクサを実装しました。

回路を切り替えて、MOSFET、配線、抵抗、容量、接合、標準セル、素子のマッチングを計測することができます。
ただし、このチップは各パラメータを高精度に抽出するために最適化された専用TEG（Test Element Group）ではありません。
そのため、得られる値は正式なプロセスパラメータではなく、**実際に製造されたTR-1umチップの参考測定値**として扱います。

また、このチップの測定作業を通し、半導体計測に使用するツール（基板・ソフトウェア）がコミュニティレベルでどの程度まで作れるか試すことも目的としています。

## 動作

### アドレス指定

計測対象であるDUT（Device Under Test）は8ビットのアドレスで指定します。
アドレス`A`は

- `A7`..`A4`: `HGx`
- `A3`..`A0`: `LN0` ~ `LN15`

と分解され、HGとLNの組み合わせで回路を切り替えます。

### 具体的な操作方法

1. `SEL_EN`をLowにして全DUTを非選択にする
2. `SEL_CLK`に100kHzのクロックを供給しつつ、`SEL_CLK`からアドレスを入力（立上りを読む）
3. アドレス確定後に`SEL_EN`をHighにする
4. 選択されたDUTを測定する
5. 次のaddressへ変更する前に再び`SEL_EN`をLowにする

## ピン配置

| Position | Name | Function |
|---|---|---|
| P1 | `P1_HCUR` | Analog HIGH current / force |
| P2 | `P2_HPOT` | Analog HIGH potential / sense |
| P3 | `FF_ASYNC` | DFF asynchronous SET / RESET control |
| P4 | `P4_LCUR` | Analog LOW current / force |
| P5 | `P5_LPOT` | Analog LOW potential / sense |
| P6 | `P6_BIAS1` | MOS gate / analog bias |
| P7 | `CAL_OPEN` | Unconnected pad/frame parasitic calibration |
| P8 position | `VSS` | Ground |
| P9 | `SEL_CLK` | Address serial-register clock |
| P10 | `SEL_DATA` | Address serial data |
| P11 | `SEL_EN` | DUT selector enable, active high |
| P12 | `EXT_CLK` | External clock for digital DUTs |
| P13 | `DIG_IN` | Digital DUT input |
| P14 | `DIG_OUT` | Selected digital DUT output |
| P15 | `VDD_DUT` | PMOS body / well / DUT bias supply |
| P16 position | `VDD` | Digital logic and selector positive supply |

## アドレスマップ

### 0x01–0x06 : Calibration

| Address | DUT | Purpose |
|---|---|---|
| `0x01` | `CAL_KELVIN_OPEN` | 4-wire measurement open reference |
| `0x02` | `CAL_KELVIN_SHORT` | 4-wire measurement short reference |
| `0x03` | `CAL_CAP_OPEN` | Capacitance measurement open reference |
| `0x04` | `CAL_LEAK_OPEN` | Leakage measurement open reference |
| `0x05` | `CAL_DIG_THRU` | Direct digital input→output reference |
| `0x06` | `CAL_SELECTOR_PARASITIC` | Analog selector parasitic reference |

`CAL_DIG_THRU`ではP13から入力した信号がreference pathを通り、digital output muxを介してP14へ出力される。

---

### 0x20–0x37 : INTERCONNECT_R

M1、M2、contact、V1などの抵抗を測定する。
基本的にP1/P2/P4/P5による4-wire測定を行う。

| Address | DUT |
|---|---|
| `0x20` | `R_CO_CHAIN_10` |
| `0x21` | `R_CO_CHAIN_100` |
| `0x22` | `R_M2_W12_L50` |
| `0x23` | `R_M2_W12_L200` |
| `0x24` | `R_M2_W12_L800` |
| `0x25` | `R_M1_W7.2_L50` |
| `0x26` | `R_M1_W7.2_L200` |
| `0x27` | `R_M1_W7.2_L800` |
| `0x28` | `R_M2_W3_L50` |
| `0x29` | `R_M2_W3_L200` |
| `0x2A` | `R_M2_W3_L800` |
| `0x2B` | `R_M1_W1.8_L50` |
| `0x2C` | `R_M1_W1.8_L200` |
| `0x2D` | `R_M1_W1.8_L800` |
| `0x2E` | `R_LOCAL_OPEN` |
| `0x2F` | `R_LOCAL_SHORT` |
| `0x30` | `R_V1_CHAIN_10` |
| `0x31` | `R_V1_CHAIN_100` |
| `0x32` | `R_M2_W6_L50` |
| `0x33` | `R_M2_W6_L200` |
| `0x34` | `R_M2_W6_L800` |
| `0x35` | `R_M1_W3.6_L50` |
| `0x36` | `R_M1_W3.6_L200` |
| `0x37` | `R_M1_W3.6_L800` |

`R_CO_CHAIN_*`はcontact resistance、`R_V1_CHAIN_*`はM1-M2 via resistanceを多数直列化して測定しやすくした構造である。

`R_LOCAL_OPEN`と`R_LOCAL_SHORT`はselectorおよびlocal routingの寄生・直列抵抗を評価するためのreferenceである。

---

### 0x40–0x59 : INTERCONNECT_C

配線とsubstrate間、異なるmetal間、同一metal配線間の容量を測定する。

2-terminal structureであり、基本的にP1/P4を使用する。

| Address | DUT |
|---|---|
| `0x40` | `C_LOCAL_OPEN` |
| `0x41` | `C_M1_SUB_W1.8_L100` |
| `0x42` | `C_M1_SUB_W1.8_L400` |
| `0x43` | `C_M1_SUB_W3.6_L100` |
| `0x44` | `C_M1_SUB_W3.6_L400` |
| `0x45` | `C_M1_SUB_W7.2_L100` |
| `0x46` | `C_M1_SUB_W7.2_L400` |
| `0x47` | `C_M2_SUB_W3_L100` |
| `0x48` | `C_M2_SUB_W3_L400` |
| `0x49` | `C_M2_SUB_W6_L100` |
| `0x50` | `C_M2_SUB_W6_L400` |
| `0x51` | `C_M2_SUB_W12_L100` |
| `0x52` | `C_M2_SUB_W12_L400` |
| `0x53` | `C_M1M2_OVERLAP_22.5` |
| `0x54` | `C_M1M2_OVERLAP_45` |
| `0x55` | `C_M1M2_OVERLAP_90` |
| `0x56` | `C_M1_COUP_W1.8_S1.4_L400` |
| `0x57` | `C_M1_COUP_W1.8_S3_L400` |
| `0x58` | `C_M2_COUP_W3_S2_L400` |
| `0x59` | `C_M2_COUP_W3_S4_L400` |

`SUB` structureでは配線とsubstrate（`p_cont`）との実効容量を測定する。

`OVERLAP` structureではM1とM2を上下に重ね、M1-M2 capacitanceを測定する。

`COUP` structureでは2本の平行配線の幅W、edge-to-edge spacing S、平行長Lを規定し、lateral coupling capacitanceを測定する。

`C_LOCAL_OPEN`はselectorとlocal interconnectのみを含むcapacitance referenceである。

---

### 0x60–0x77 : MOS_DC

MOSFETのDC I-V特性およびW/L依存性を測定する。

NMOSではbodyはVSSへ固定される。

PMOSではbody / N-wellをP15から制御する。

#### NMOS

| Address | DUT |
|---|---|
| `0x60` | `NMOS_DC_W3.4_L1` |
| `0x61` | `NMOS_DC_W10_L1` |
| `0x62` | `NMOS_DC_W30_L1` |
| `0x63` | `NMOS_DC_W60_L1` |
| `0x64` | `NMOS_DC_W10_L2` |
| `0x65` | `NMOS_DC_W10_L5` |
| `0x66` | `NMOS_DC_W10_L10` |
| `0x67` | `NMOS_DC_W10_L30` |
| `0x68` | `NMOS_DC_W3.4_L5` |
| `0x69` | `NMOS_DC_W30_L5` |
| `0x6A` | `NMOS_DC_W60_L5` |
| `0x6B` | `NMOS_DC_W60_L30` |

#### PMOS

| Address | DUT |
|---|---|
| `0x6C` | `PMOS_DC_W3.4_L1` |
| `0x6D` | `PMOS_DC_W10_L1` |
| `0x6E` | `PMOS_DC_W30_L1` |
| `0x6F` | `PMOS_DC_W60_L1` |
| `0x70` | `PMOS_DC_W10_L2` |
| `0x71` | `PMOS_DC_W10_L5` |
| `0x72` | `PMOS_DC_W10_L10` |
| `0x73` | `PMOS_DC_W10_L30` |
| `0x74` | `PMOS_DC_W3.4_L5` |
| `0x75` | `PMOS_DC_W30_L5` |
| `0x76` | `PMOS_DC_W60_L5` |
| `0x77` | `PMOS_DC_W60_L30` |

各MOSについてP1/P2とP4/P5を使用することで、selectorやglobal wiringの電圧降下を分離した測定が可能である。

---

### 0x80–0x93 : MOS_JUNCTION_C

MOS gate capacitanceおよびdiffusion / well junction capacitanceを測定する。

#### MOS gate capacitance

| Address | DUT |
|---|---|
| `0x80` | `C_NMOS_WG20_L10_N1` |
| `0x81` | `C_NMOS_WG20_L10_N2` |
| `0x82` | `C_NMOS_WG20_L10_N4` |
| `0x83` | `C_NMOS_WG20_L10_N8` |
| `0x84` | `C_PMOS_WG20_L10_N1` |
| `0x85` | `C_PMOS_WG20_L10_N2` |
| `0x86` | `C_PMOS_WG20_L10_N4` |
| `0x87` | `C_PMOS_WG20_L10_N8` |

N1/N2/N4/N8によって並列unit数を変え、容量の面積依存性と測定系寄生を分離できる。

#### N+ / P-substrate junction

| Address | DUT |
|---|---|
| `0x88` | `C_JUNC_NPLUS_PSUB_SQ_N1` |
| `0x89` | `C_JUNC_NPLUS_PSUB_SQ_N2` |
| `0x8A` | `C_JUNC_NPLUS_PSUB_SQ_N4` |
| `0x8B` | `C_JUNC_NPLUS_PSUB_RECT_N1` |
| `0x8C` | `C_JUNC_NPLUS_PSUB_RECT_N2` |
| `0x8D` | `C_JUNC_NPLUS_PSUB_RECT_N4` |

#### P+ / N-well junction

| Address | DUT |
|---|---|
| `0x8E` | `C_JUNC_PPLUS_NWELL_SQ_N1` |
| `0x8F` | `C_JUNC_PPLUS_NWELL_SQ_N2` |
| `0x90` | `C_JUNC_PPLUS_NWELL_SQ_N4` |
| `0x91` | `C_JUNC_PPLUS_NWELL_RECT_N1` |
| `0x92` | `C_JUNC_PPLUS_NWELL_RECT_N2` |
| `0x93` | `C_JUNC_PPLUS_NWELL_RECT_N4` |

SQとRECT、さらにN1/N2/N4を比較することで、junction capacitanceのarea成分とperimeter成分を評価できる。

---

### 0xA0–0xA3 / 0xB0–0xB5 : MATCHING

各physical DUTは4個のunit MOSから構成される。

A memberとB memberはそれぞれ2個のunit MOSをparallel接続したものであり、AとBを別addressで測定する。

#### NMOS

| Address | DUT / member |
|---|---|
| `0xA0` | `MATCH_NMOS_W10_L1_ADJACENT` member A |
| `0xA1` | `MATCH_NMOS_W10_L1_ADJACENT` member B |
| `0xA2` | `MATCH_NMOS_W30_L5_ADJACENT` member A |
| `0xA3` | `MATCH_NMOS_W30_L5_ADJACENT` member B |

W10/L1 DUTはW5/L1 unit × 4で構成され、各memberはW5/L1を2個parallel接続してeffective W10/L1となる。

W30/L5 DUTはW15/L5 unit × 4で構成され、各memberはeffective W30/L5となる。

NMOS bodyはVSSに固定される。

#### PMOS

| Address | DUT / member |
|---|---|
| `0xB0` | `MATCH_PMOS_W10_L1_ADJACENT` member A |
| `0xB1` | `MATCH_PMOS_W10_L1_ADJACENT` member B |
| `0xB2` | `MATCH_PMOS_W30_L5_ADJACENT` member A |
| `0xB3` | `MATCH_PMOS_W30_L5_ADJACENT` member B |
| `0xB4` | `MATCH_PMOS_W30_L5_COMMON_CENTROID` member A |
| `0xB5` | `MATCH_PMOS_W30_L5_COMMON_CENTROID` member B |

PMOS W30/L5 COMMON_CENTROIDではA/Bを対角に配置し、A/Bの幾何学的centroidを一致させている。

これにより、

- ADJACENT配置で観測されるrandom mismatch + spatial gradient
- COMMON_CENTROID配置でspatial gradientを抑制した状態

を比較できる。

PMOS N-well / bodyはP15へ接続される。

---

### 0xC0–0xC7 : Passive resistors

TR-1umのpassive resistor構造を4-wireで測定する。

| Address | DUT |
|---|---|
| `0xC0` | `RR_W2p8_L13` |
| `0xC1` | `RR_W2p8_L100` |
| `0xC2` | `RR_W10_L50` |
| `0xC3` | `RR_W20_L100` |
| `0xC4` | `RS_W4_L20` |
| `0xC5` | `RS_W4_L100` |
| `0xC6` | `RS_W10_L50` |
| `0xC7` | `RS_W20_L100` |

幅・長さを変えることでsheet resistance、contact contribution、geometry dependenceを評価する。

---

### 0xD0–0xD5 : Digital standard-cell characterization

P13をdigital input、P14をselected digital outputとして使用する。

#### Inverter chains

| Address | DUT |
|---|---|
| `0xD0` | `INV_CHAIN_1` |
| `0xD1` | `INV_CHAIN_3` |
| `0xD2` | `INV_CHAIN_9` |
| `0xD3` | `INV_CHAIN_27` |

inverter段数を変えることで、

- propagation delay
- stage delay
- rise/fall behavior
- load accumulation

を実シリコン上で評価する。

`0x05 CAL_DIG_THRU`をinput/output routing delayのreferenceとして利用できる。

#### Flip-flops

| Address | DUT |
|---|---|
| `0xD4` | `DFFS` |
| `0xD5` | `DFFR` |

DFFでは、

- P12 = clock
- P13 = D
- P14 = Q
- P3 = asynchronous control

を使用する。

`DFFS`ではP3 `FF_ASYNC`がLOWになるとasynchronous SETが有効となり、Q=1となる。通常動作ではP3をHIGHにする。

`DFFR`ではP3 `FF_ASYNC`がHIGHになるとasynchronous RESETが有効となり、Q=0となる。通常動作ではP3をLOWにする。

これらを用いて、

- setup time
- hold time
- clock-to-Q delay
- asynchronous SET / RESET delay
- recovery time
- removal time

を測定できる。

## 動作原理

各DUTは、1個の**ASEL**と対になっている。
ASELはアドレスが指定したDUTだけを外部ピンに接続する。

| ASEL | External Pin | Function |
|---|---|---|
| `ASEL_2T` | `P1`, `P4` | 容量・junctionなどの2端子測定 |
| `ASEL_4T` | `P1`, `P2`, `P4`, `P5` | 抵抗などの4-wire / Kelvin測定 |
| `ASEL_5T` | `P1`, `P2`, `P4`, `P5`, `P6` | NMOS測定 |
| `ASEL_6T` | `P1`, `P2`, `P4`, `P5`, `P6`, `P15` | PMOW測定（`ASEL_5T` + Body制御端子） |