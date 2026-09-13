# TR-1um 6T SRAM：共有ソース案を22.0 µm幅へ縮小

2026-09-11。**現時点の検証済み最小コアを651.20 µm²/bitへ更新した。** 配置周期は22.0×29.6 µm。従来の23.2×29.6＝686.72 µm²/bitから、面積5.17%減、ビット密度5.45%増。6T構成、全MOSのW/L＝3.4/1 µm、M1/M2のみという条件を維持した。

タップ・電源配線を含むアレーは**20×76＝1,520 bit、回転後592.0×1799.8 µm**。従来の1,440 bitから80 bit増えた。これは600×1800 µmの**メモリアレー単体**の収容結果であり、周辺回路・パッドを含む完成マクロの容量ではない。

![実GDSのコア比較](/home/ishi-kai/sram/klayout/sram_compact/cell_comparison.png)

## 参照資料と今回の位置づけ

- [Apostolidis・Balobas・Konofaos, 2016, Design and Simulation of 6T SRAM Cell Architectures in 32nm Technology](https://www.jestr.org/downloads/Volume9Issue5/fulltext23952016.pdf)：**PDF 2ページのFig. 2・3、4ページのFig. 8**。T1b系の素子配置と、単体ではなく反転・共有後のアレーを比較する観点を引き続き参照した。
- [Balobas・Konofaos, 2015, Design and evaluation of 6T SRAM layout designs at modern nanoscale CMOS processes](https://www.researchgate.net/publication/277075492_Design_and_evaluation_of_6T_SRAM_layout_designs_at_modern_nanoscale_CMOS_processes)：**Fig. 2・3の単セル／4×4アレー比較**。トポロジー名や縦横比だけで順位を決めず、同条件の実アレーを比較する方針。
- [Adam Teman, Digital VLSI Design — SRAM](https://www.eng.biu.ac.il/temanad/files/2017/02/Lecture-7-SRAM.pdf)：pp.33–53の安定性・SNMの説明。前段と同じDC伝達曲線の方法で安定性を比較した。

論文の3層Metalや32 nmの寸法・MOS比を移植したものではない。今回のGCの折り曲げ、コンタクト・ビアの移動量は**TR-1umの通常ルールから決めた独自配線**である。前段で実装した[T4のM1/M2版](/home/ishi-kai/sram/klayout/sram_t4/README.md)は857.38 µm²/bitだったため、それより小さい共有ソース案をさらに詰めた。掲載画像はすべて保存GDSのポリゴンから生成した。

## 何を変えると縮まったか

NMOSの1本の拡散列とPMOSの1本の拡散列、中央VSS/VDD共有、行反転という構成は維持した。主な変更は次のとおり。座標は繰返しコア内のµm値で、図ではYに5.7 µmを加えて表示している。

| 箇所 | 従来 | 今回 | 効果 |
|---|---|---|---|
| BL/BLB拡散コンタクトX | 0 / 19.2 | 0.6 / 18.6 | 両端の拡散領域を内側へ詰める |
| アクセスゲートX | 2.4 / 16.8 | 2.6 / 16.6 | コンタクト–ゲート間隔を確保。W/Lは変更しない |
| BL/BLBのM1配線X | −0.4 / 19.6 | 0.2 / 19.0 | 隣接列に必要な幅を減らす |
| 左インバータのGC配線 | X＝7.2で直線 | N/P間だけX＝6.6へ曲げる | 左側と中央の帰還ビアの通路を確保 |
| 帰還M2のY | 8.4 / 13.8 | 7.9 / 13.3 | コンタクトとビアをずらした配線を成立させる |
| VSSへのビアY | 3.0 | 2.5 | 上の帰還配線とのM2間隔を確保 |

幅を変えるだけの初期試作では、隣接列のN拡散とM1に違反が残った。両端コンタクト、BL、セル内帰還配線をまとめて配置し直すことで解消した。MOSを形成する部分のGCは直線のままで、折り曲げはN/P間の非活性領域に置いた。

## 寸法を振った実レイアウトと不採用案

[scan.py](/home/ishi-kai/sram/klayout/sram_compact/scan.py)で7種類の4×4 GDSを作り、同じ未変更PDKでDRCと厳密ポートLVSを実行した。0.05 µm DBUを使い、半端な座標丸めによるビア寸法の変化を避けた。

| 列×行ピッチ | 名目コア面積 µm²/bit | DRC | LVS | 判定 |
|---|---:|---|---|---|
| 22.4×29.6 | 663.04 | 0件 | 一致 | 有効な中間案 |
| 22.2×29.6 | 657.12 | 0件 | 一致 | 有効な中間案 |
| **22.0×29.6** | **651.20** | **0件** | **一致** | **採用候補** |
| 21.9×29.6 | 648.24 | M1間隔16件、V1–GC間隔16件 | 一致 | 不採用 |
| 21.8×29.6 | 645.28 | M1間隔16件、V1–GC間隔16件 | 一致 | 不採用 |
| 22.0×29.5 | 649.00 | 隣接行のGC間隔16件 | 一致 | 不採用 |
| 22.0×28.5 | 627.00 | 0件 | **不一致** | 反転行同士の帰還ゲートがつながるため不採用 |

![各寸法の実4×4 GDS](/home/ishi-kai/sram/klayout/sram_compact/scan_comparison.png)

[全結果](/home/ishi-kai/sram/klayout/sram_compact/scan.json)。この配線の寸法探索では、22.0×29.6 µmより小さい候補は成立しなかった。**配線・素子配置を固定した範囲での結果であり、全6Tレイアウトの大域最適性は証明していない。** 627.00の試作は、DRCだけを見れば誤採用できてしまうため、LVSと組み合わせる必要を示している。失敗候補の面積を密度改善には数えない。

## タップ・電源配線を含む面積比較

| 構成 | 従来の共有ソース案 | 今回の縮小案 |
|---|---:|---:|
| コア面積 | 686.72 µm²/bit | **651.20 µm²/bit** |
| 4×4、端部込み | 16,078.72 µm² | **15,510.40 µm²** |
| 1,024 bit、16×64 | 1591.4×473.6 µm | **1514.6×473.6 µm** |
| 同面積 | 753,687.04 µm² | **717,314.56 µm²、4.83%減** |
| 600×1800内の最大矩形アレー | 20×72＝1,440 bit | **20×76＝1,520 bit、5.56%増** |

16列ごとのタップ列、21.2 µmのタップ間隙、端部電源配線43 µmを両案で揃えた。メモリ単体の最大値は、1～100行・1～100列を両方向で列挙した結果。外形の式を保存GDSと照合し、最大候補そのものもDRC/LVSを通した。任意形状や別タップ間隔を含む上限ではない。

[dimensions.json](/home/ishi-kai/sram/klayout/sram_compact/dimensions.json)、[最大配置の計算](/home/ishi-kai/sram/klayout/sram_compact/capacity_comparison.json)。奇数行にはウェル終端の張り出しが加わる。配置周期を単純に掛けるだけで収容可否を判定していない。

## 周辺回路込み：512 bitとWL接続間隔の両立に余地

前段と同じシリアル制御方式、標準セル寸法、列周辺・共通アナログ領域の予算で再計算した。下表はすべて512 bit、16×32のアレーを90度回転する構成。ロジック配置率は標準セル行の充填目標であり、チップ全体の使用率ではない。

| 配置率・列周辺の奥行き | 従来セル・WL16列ごと | 縮小セル・WL16列ごと | 縮小セル・WL8列ごと |
|---|---|---|---|
| 75%・120 µm | 593.6×1821.8、入らない | **593.6×1783.4、入る見積もり** | 593.6×1825.8、入らない |
| 85%・120 µm | 593.6×1771.8 | **593.6×1733.4** | **593.6×1775.8** |

縮小セルでは、85%配置なら8列ごとのWL接続を入れても外形に収まる計算となった。従来セルの同条件は593.6×1814.2 µmで収まらなかった。今回の`compact_strap8_16x32`は実アレーGDSとして生成し、DRC/LVSを通している。

65%・列周辺150 µmの条件では、従来と同様、256 bitが最大の2べき乗候補。縮小セル＋8列ごとの接続でも592.6×1561.2 µm。周辺回路の共通領域が外形を決めるため、セルを縮めてもこの256 bitマクロの全外形は同じになる。

![アレー単体と周辺ブロック込みの比較](/home/ishi-kai/sram/klayout/sram_compact/capacity.png)

ここでの周辺回路は**未配置・未配線のブロック見積もり**。パッド・ESDを除く。512 bit＋8列接続の予算は幅6.4 µm、高さ24.2 µmしか余らず、実配線の成立を保証しない。1,520 bitの完成マクロが収まるという意味でもない。

行ピッチとWL端子位置は変わらず、Y＝2.7、56.5、61.9、115.7…µm、間隔は53.8 / 5.4 µmの交互。デコーダ最終段は、引き続き偶数行／奇数行を分ける2レーンとピッチ変換用の領域を予約する。列ピッチ22.0 µmはAND2_X1の共有配置幅22.0 µmと一致するが、**セル端・ウェル・電源・信号の実配線まで成立することを示したわけではない**。原寸法の詳細と代替案は[周辺回路調査](/home/ishi-kai/sram/klayout/sram_macro_study/README.md)を参照。

## 検証範囲

保存した`compact.gds`の13トップすべてでDRC 0件・LVS一致。1×1、2×2、4×4、8×8、タップ境界をまたぐ4×17、256/512/1,024 bit、最大1,520 bit、WL8列ごとの3構成、観測用2×2を含む。[verification.json](/home/ishi-kai/sram/klayout/sram_compact/verification.json)に保存GDSのハッシュと結果を記録した。[検証入力のハッシュ](/home/ishi-kai/sram/klayout/sram_compact/verification_inputs.json)も保存した。規則除外、素子寸法許容差の追加、ポート無視はしていない。

保持・読出しSNMは抽出1×1のMOS・接合形状から、5 V・27℃で計算した。保持**1.5373 V**、読出し**0.4421 V**。従来案とこの計算精度で同等。[snm.json](/home/ishi-kai/sram/klayout/sram_compact/snm.json)。MOS幅比の改善によるSNM向上を主張するものではない。

実2×2の抽出回路を既存の`learning/schematics/sram_tb_serial.sch`へ接続し、通常条件、85℃、BL/共通線に各1 pFを追加した条件の3条件でPASS。各条件5 V、100 nsクロック、19操作、3,408件のRTL比較と745件のアナログ区間判定、計4,153件を確認した。[serial_results.json](/home/ishi-kai/sram/klayout/sram_compact/serial_results.json)。共有部を含む実2×2の抽出MOSを使い、周辺回路は回路図モデル。追加容量は仮定した負荷であり、PEX値ではない。

**512 bit＋8列ごとのWL接続の全トランジスタマクロも8操作でPASS**。`compact_strap8_16x32`の全メモリ抽出MOSに、生成したシリアル制御・行列デコーダ・列MUX・書き込み・プリチャージ・7Tセンスアンプを接続した。5 V・27℃・100 nsクロックで、先頭／末尾の2アドレスへ両極性を書き、読み戻し、反転データを再び書いて読み戻した。SDOに加え、PREBと選択WLの電圧も判定した。メモリ全体のMOSは回路に存在するが、**全アドレス／全パターンの動作試験ではない**。

[全マクロの試験結果](/home/ishi-kai/sram/klayout/sram_compact/macro_spice_results.json)、[512 bit SPICE回路](/home/ishi-kai/sram/klayout/sram_compact/macro_16x32.spice)。WL・PREB・SAEは回路から生成し、理想電圧源で置き換えていない。周辺回路は回路図モデル、メモリはGDS抽出モデル。試験用負荷容量はSPICE実行デッキ側に追加した。

配線RC・製造ばらつき・プロセスコーナー・ラッチアップ距離・IR dropは未評価。WL8列ごとの実GDSがあっても、それだけでRC込みの周波数を保証しない。前段のWL抵抗・容量の感度分析は設定値を仮定した別試験であり、今回のSPICEへ実配線PEXを入れたものではない。

## 成果物と再実行

[採用候補GDS](/home/ishi-kai/sram/klayout/sram_compact/compact.gds)。コア名は`compact_core`。端部付きの単セルラッパーを全ビットへ並べると、この密度にはならない。`compact_20x76`がアレー単体の最大候補、`compact_strap8_16x32`が512 bit＋8列WL接続の候補。

```bash
cd /home/ishi-kai/sram
python3 klayout/sram_compact/build.py
python3 klayout/sram_compact/verify.py
python3 klayout/sram_compact/scan.py
python3 klayout/sram_compact/verify_serial.py
python3 klayout/sram_compact/verify_dc.py
python3 klayout/sram_compact/verify_macro_spice.py
python3 klayout/sram_compact/compare_capacity.py
python3 klayout/sram_compact/render_results.py
```

容量計算と拡大シリアル回路の生成は、前段の`build/sram_macro_study/serial/sram_tb_serial.spice`を参照する。未生成の環境では先に`python3 klayout/sram_macro_study/verify_serial.py`を実行する。波形・抽出回路・ログ・寸法探索の各GDSは`build/sram_compact/`へ出力する。画像と結果JSON、生成・検証コードを保存し、大きな波形はコミットしない。既存の手編集回路図と旧GDSは保持した。
