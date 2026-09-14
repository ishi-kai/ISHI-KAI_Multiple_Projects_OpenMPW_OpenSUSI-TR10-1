# SRAMテストベンチ

通常は次の順に確認します。各 `.sch` をXschemで開き、Netlist → Simulateを実行してください。
電源は5 V、セルは `learning/schematics/sram.sch` の最小寸法です。波形源は各電圧源、解析条件は `SIMULATION` で編集できます。

| ファイル | 確認する内容 |
|---|---|
| [sram_tb_tran_write.sch](../schematics/sram_tb_tran_write.sch) | 理想電圧源でBL・BLBを駆動する基準テスト。0→1→0の書き込み時間と保持値を測定。 |
| [sram_tb_tran_write_pulldown.sch](../schematics/sram_tb_tran_write_pulldown.sch) | プリチャージ後、片側だけをNMOSでプルダウン。両方向の書き込みと保持を確認し、PASS/FAILを表示。今のアレイ周辺回路の検討に使用。 |
| [sram_tb_tran_read.sch](../schematics/sram_tb_tran_read.sch) | プリチャージ後の読み出しをQ=0・Q=1の両方で確認。ビット線の変化、内部ノードの揺れ、読み出し後の保持、アクセス電流、LOW側のセル内プルダウン電流を測定。 |

## 2×2アレイ

[sram_tb_array.sch](../schematics/sram_tb_array.sch) は `learning/schematics/sram_array.sch` をコピーし、電源・制御信号・観測ラベル・仮のビット線容量を加えたテストベンチです。元のLVS用 `learning/schematics/sram_array.sch` は変更していません。セル4個と周辺MOSの寸法・配列内配線を引き継ぎ、未接続だったイコライザと書き込みNMOSのゲートを接続しています。

- 2行に01/10を書き込み、両行を読み出す。
- 10/01へ反転して、再度読み出す。
- 1列だけを書き換え、同じ行の他列と非選択行の保持を確認する。
- 各操作後に全セルのQ/QBを測定。非選択行は操作中の最大・最小電圧も確認する。

1周期100 ns、全体1.2 µs。`Q00` は行0・列0、`Q01` は行0・列1です。読み出しはセンスアンプを使わず、BL−BLBの符号と0.5 V以上の差で判定します。保持判定はLOW < 0.5 V、HIGH > 4.5 Vです。全判定を通るとコンソールに `PASS` を表示します。

これはコピーなので、今後LVS用アレイを変更した場合はテストベンチ側にも反映が必要です。

DCテストは、WL電圧に対するセルの応答を詳しく見るために残しています。

| ファイル | 確認する内容 |
|---|---|
| [sram_tb_dc_write.sch](../schematics/sram_tb_dc_write.sch) | BL=5 V、BLB=0 Vを固定し、WLを0〜5 Vで掃引。理想駆動下のDC応答。実際の書き込み成否は過渡解析で確認。 |
| [sram_tb_dc_read_wl.sch](../schematics/sram_tb_dc_read_wl.sch) | BL・BLBを5 Vに固定してWLを掃引。読み出し時のQの持ち上がりとQBの低下を観測。プリチャージを切る通常の読み出しとは条件が異なる。 |

プリチャージを使うテストのビット線容量10 fFは仮の値で、レイアウト抽出値ではありません。
現在のテストは指定条件での機能確認です。製造ばらつき・温度・電源範囲の保証や長時間保持の評価は含みません。

## 整理したファイル

- `sram_tb_tran.sch` → 同じ刺激・解析の `learning/schematics/sram_tb_tran_write.sch` に一本化。
- `sram_tb_dc.sch` → 同じ刺激・解析の `learning/schematics/sram_tb_dc_write.sch` に一本化。
- `sram_tb_read_strength.sch` → 電流比較を `learning/schematics/sram_tb_tran_read.sch` に統合。Q=1の場合のLOW側も比較。
- `sram_tb.sch`、`sram_sim.sch` → 同じ固定入力の保持テスト。読み書き後の保持は上記の過渡解析で確認するため削除。

LVS設定とシミュレーション出力の切り替えについては
[xschem/testbench_mode/README.md](../../xschem/testbench_mode/README.md)を参照してください。

## 7Tクロック式センスアンプ単体

- [sense_amp_7t.sch](../../sram512/schematics/sense_amp_7t.sch)：ラッチ4T＋入力分離pMOS 2T＋共通ソース側nMOS 1T。初期寸法は全てW/L=3.4u/1u。
- [sense_amp_7t.sym](../../sram512/schematics/sense_amp_7t.sym)：配列接続用シンボル。
- [sram_tb_sense_amp.sch](../schematics/sram_tb_sense_amp.sch)：理想電圧源で入力差を正負交互に与え、判定と次回用リセットを自動確認。

SAE=0で入力に追従し、SAE=1で入力から切り離して正帰還で判定します。
BL > BLBならSOUTがHIGH、逆ならLOWです。SAEをLOWへ戻すと判定結果を失うので、実装時にはその前に結果を取り込みます。

1周期100 nsで、20〜21 nsに入力差を作り、40〜41 nsにSAEをHIGHへ、70 nsで出力判定、80〜81 nsにSAEをLOWへ、85〜86 nsに両入力を5 Vへ戻し、95 nsで両出力がHIGHに戻ることを確認します。4周期連続で逆の値を読みます。初期値を強制する `.ic` は使いません。

`SIMULATION` の `.param VDIFF=0.5` で入力差を変更できます。電源5 V、出力負荷は各10 fFの仮定です。27℃・対称なモデルで0.5 Vと0.1 Vの入力差はPASS、入力差0 VはFAILを確認しました。これは最小入力差や素子ばらつきへの保証ではありません。列選択・実セル・出力バッファは含まない単体テストです。

## 実セル＋センスアンプ

[sram_tb_cell_sense.sch](../schematics/sram_tb_cell_sense.sch) は、1個のSRAMセルと7TセンスアンプをBL/BLBで直接接続したテストです。列MUXはまだ含みません。ビット線には理想電圧源を接続せず、PMOSでプリチャージし、セルの電流で放電します。

100 nsずつ、1の書き込み→1の読み出し→0の書き込み→0の読み出しを実行します。片側プルダウンで実際に書いた値をセンス出力から判定します。初期状態はQ=0/QB=5ですが、読み出し結果を初期値だけで作るテストではありません。

読み出し周期内では、20〜21 nsにプリチャージを切り、35〜36 nsにWLを上げ、45〜46 nsにSAEを上げます。65〜66 nsにWLを下げ、70 nsにセンス出力を判定し、90 nsにセルの保持を確認します。SAEは次の読み出し前までHIGHを維持します。書き込み中はビット線のプリチャージ期間を含めてSAEをHIGHに保ち、センス側を初期化しません。読み出し周期の0〜1 nsでSAEをLOWへ戻し、ビット線とセンス側を一緒にプリチャージします。再プリチャージ後にセンス側が両方HIGHへ戻ることも測定します。

5 V・27℃、各ビット線10 fF、各センス出力10 fFで全判定PASS。読み出し時のセルLOW側の最大電圧は約0.975 V、その後は元の値を保持しました。このタイミングではセンス開始直前のBL−BLBが約±5.047 Vまで開いています。十分に待った基本機能テストであり、微小差での最短センス開始時間は未評価です。

### ビット線容量を増やす学習用設定

`learning/schematics/sram_tb_cell_sense.sch` の現在の既定値は `.param CBL=1p`（各ビット線1 pF）。センス出力容量は各10 fFのままです。制御タイミングは変えず、読み出し1を130〜170 nsに拡大した波形も表示します。`SIMULATION` 内のCBLを `10f` / `100f` / `1p` に変更して比較できます。いずれも実レイアウトから抽出した値ではありません。

| 各ビット線の容量 | SAE立上り開始直前の電圧差（読み出し1） | 読み書き・リセット・保持 |
|---|---:|---|
| 10 fF | 5.047 V | PASS |
| 100 fF | 5.105 V | PASS |
| 1 pF | 2.644 V | PASS |

測定時刻は145 ns。小容量で5 Vを少し超える差は、容量結合などによる電源範囲外への変動を含みます。1 pFではセンス開始時点でも放電途中ですが、2.64 Vはまだ大きな入力差です。微小差での限界評価ではありません。

[容量比較波形](../simulation/cell_sense_capacitance.png)：上段はBL−BLB、下段はSOUTB。灰色の帯がWL立上り、紫の帯がSAE立上りです。

## 2×2＋nMOS列MUX＋共通センスアンプ

[sram_tb_array_mux.sch](../schematics/sram_tb_array_mux.sch) は、4個の `learning/schematics/sram.sym`、各列のローカルBL/BLBプリチャージ、nMOS列MUX（計4個）、共通線Y/YBのプリチャージ、共通の片側プルダウン書き込み回路、7Tセンスアンプを接続したTBです。LVS用 `learning/schematics/sram_array.sch` は変更していません。WL0/1とCOL0/1は理想制御源で選択し、デコーダはまだ含みません。MOSによる実回路でビット線を充放電します。

- 前半：Q00/Q01/Q10/Q11へ順に0/1/1/0を書き、同じ順に読み出す。
- 後半：1/0/0/1へ書き換え、再度読み出す。
- 1周期200 ns、16周期で3.2 µs。各周期後に全セルのQ/QBをチェックします。
- 読み出し値はSOUT/SOUTBで判定。非選択セルはWL動作中にも論理反転していないか、Q/QBの最大・最小値を2.5 V基準で確認します。周期後の保持とセンス出力は0.5/4.5 V基準です。

周期内の相対時刻：0〜40 nsにローカル線をプリチャージ（共通線は1〜2 nsで開始）、40〜41 nsに解除、45〜46 nsにCOLを上げます。書き込みは50〜51 nsに片側プルダウンを入れます。70〜71 nsにWLを上げ、読み出しなら90〜91 nsにSAEを上げます。140〜141 nsにWLを下げ、150 nsに読み出し値を確認、155〜156 nsに書き込みプルダウンを切り、170〜171 nsにCOLを下げ、190 nsに全セルの保持値を確認します。

共通線Y/YBは書き込み前にも充電します。前回のLOWが残った共通線を次の列へ接続することを避けるためです。書き込み中のSAEはHIGHなので、センス内部のプリチャージは行いません。読み出しでは1〜2 nsにSAEをLOWへ戻し、39 nsに両センス出力のリセットを確認します。

既定の追加容量は各ローカル線CBL=10 fF、共通線CY=100 fF、センス出力10 fF。CBLは従来の2×2 TBと同じ仮の配線容量で、セル・周辺MOSのモデルに含まれる容量に加算されます。2セル分の総容量やレイアウト抽出値ではありません。5 V・27℃のngspiceで全判定PASS。SAE直前のY−YBは約±4.99 Vで、微小差の限界を試すタイミングではありません。コンソールの `diff_4` 等で確認できます。波形には最初の読み出し（行0・列0）を拡大したBL/BLBとY/YBの比較も含めています。

## スタンダードセル行デコーダ＋2×2

- `learning/schematics/row_decoder_1to2.sch` / `.sym`：PDKの `TR-1um_5_stdcell/NAND2` ×2、`INV_X1` ×3で構成。RAとWL_ENから、WL0=NOT RA AND WL_EN、WL1=RA AND WL_ENを生成します。最後のINVが実際のWL負荷を駆動します。VSSは各スタセルのGND端子へ接続します。
- `learning/schematics/sram_tb_array_row_decoder.sch`：列MUX付き2×2 TBのコピーに行デコーダを追加。左側のデコーダから各行のWLへ実配線し、元のWL理想電圧源をRA・WL_ENへ置き換えています。列MUX・プリチャージ・書き込み・SAEの刺激は基準TBを維持します。

各200 ns周期の5〜6 nsと15〜16 nsにRAを切り替え、WL_EN=0の間のアドレス変化でWLが上がらないことを試します。16 ns以降は対象行のアドレスを保持し、70〜71 nsにWL_ENを上げ、140〜141 nsに下げます。既存の全アドレス書き込み・センス読み出し・保持・リセット判定に加え、無効期間の両WLのLOW、アクセス中の選択WLのHIGHと非選択WLのLOW、アクセス終了後のLOWを確認します。

5 V・27℃、既存2×2負荷（各BL追加10 fF）で全判定PASS。WL_ENから実WLまでの2.5 V交差で測った遅延は立上り約2.32 ns、立下り約1.57 ns。レイアウト抽出配線の遅延は含みません。最初の400 nsの行選択と、最初の立上りを拡大するプロットも追加しました。

手順はISHI会ハンズオンの既製スタセル利用に合わせ、論理式→Xschemでゲート接続→シンボル化→実セル負荷を付けたngspice検証→対応GDSの配置・配線→DRC/LVSです。今回は回路図・シンボル・統合シミュレーションまでで、デコーダのGDSは未作成です。Verilog・論理合成は使用していません。

PDK内部の回路図は `MP.sym` / `MN.sym` を短い名前で参照するため、Xschemのライブラリ検索パスには `libs.tech/xschem/TR-1umLIB` も必要です。通常のユーザー設定には登録済みです。簡略rcでバッチ実行するときも同パスを追加してください。

## 行・列デコーダ＋2×2

- `learning/schematics/col_decoder_1to2.sch` / `.sym`：COL_ENを省き、CAが安定すると常に1列を選択します。INV_X1を2段つなぎ、1段目出力をCOL0、2段目出力をCOL1へ接続。COL0=NOT CA、COL1=CAで、両出力とも実スタセルでMUXゲートを駆動します。従来のNAND2×2＋INV×3（14 MOS）からINV×2（4 MOS）へ変更しました。
- `learning/schematics/sram_tb_array_decoders.sch`：行・列デコーダを接続した2×2 TB。COL_EN電圧源を削除しました。行デコーダ以前の比較用TBは、それぞれ従来の列選択刺激を維持します。

各200 ns周期の5〜6 ns、15〜16 nsにCAを切り替え、16 ns以降は対象列のアドレスを保持します。この間は全WLがLOW、書き込みプルダウンがOFFで、全ローカル線と共通線をプリチャージします。39 nsでBL0/BLB0/BL1/BLB1/Y/YBが4.5 V以上へ戻ったことを確認し、40〜41 nsでプリチャージを切ります。書き込みプルダウンは50〜51 ns、WL_ENは70〜71 nsに立ち上がります。アクセス終了後も列選択を保持します。SAE・PD・プリチャージの刺激は従来どおりです。

アドレス遷移中の一時的な複数列接続は許容し、遷移後の25〜199 nsは対象列HIGH・他列LOWを確認します。両INVの遅延差があるため、遷移中まで常にone-hotという保証ではありません。読み書き・保持・行デコード・センスリセットに加えて、アドレス変更後のプリチャージ完了を自動判定します。

5 V・27℃、CBL=10 fF・CY=100 fFの追加負荷条件で全判定PASS。レイアウト抽出前の結果です。CA切り替えとCOL0/1、共通線のプリチャージを拡大したプロットを含みます。

## 書き込み制御＋行・列デコーダ＋2×2

- `sram512/schematics/write_control.sch` / `.sym`：PDKのNAND2×2＋INV_X1×3で、PD_Y=NOT DIN AND WRITE_EN、PD_YB=DIN AND WRITE_ENを生成。出力が共通線の既存プルダウンnMOSを駆動します。WRITE_ENは内部の書き込み許可信号で、外部WEピンの仕様を確定するものではありません。
- `learning/schematics/sram_tb_array_write_control.sch`：行・列デコーダ付きTBをコピーし、PDの理想電圧源をDIN・WRITE_ENの電圧源と実スタセル回路へ置換。左下の書き込み制御から両プルダウンゲートへ実配線しています。列はCA安定時に常時1列選択です。

DINは各周期の5〜6 nsと15〜16 nsに切り替え、以後対象データを保持します。書き込み周期のみ50〜51 nsにWRITE_ENをHIGHにし、155〜156 nsにLOWへ戻します。WL_ENは70〜71 nsにHIGH、140〜141 nsにLOWで、PDを先に立ち上げ、実WLを切った後にPDを解除します。読み出し周期のWRITE_ENは常にLOWです。

全4セルへの0/1書き込み、センス読み出し、保持、行・列選択、プリチャージ・SAリセットの既存判定に加え、DIN切り替え中の両PDのLOW、書き込み中の指定PDだけHIGH、非指定PDと読み出し中の両PDが周期を通してLOW、書き込み終了後の両PDのLOWを自動確認します。DINはWRITE_ENがHIGHの間に変更しない仕様です。

5 V・27℃、CBL=10 fF・CY=100 fFで全判定PASS。WRITE_EN→PDの2.5 V交差による遅延は、立上り約2.16 ns、立下り約1.40 ns。配線抽出前の結果です。DIN/WRITE_EN/PDの波形と、PDがWLより先に立ち上がる部分の拡大プロットを追加しています。入力とアクセス順序はまだTBの電圧源が与えており、シーケンサとシリアル回路は未実装です。

## シリアル制御の次段階

確定した7ピン・シリアル入力仕様は [SEQUENCER_DESIGN.md](SEQUENCER_DESIGN.md) に記載しています。外部CLKで受信から読み書き完了まで進める単一カウンタ方式で、非同期RESETを採用します。

以前の並列入力・START受付・同期RESETのシーケンサーと専用TB、保持レジスタ、専用検証スクリプト・操作一覧は削除しました。新仕様のRTLとデジタルTBは実装・検証済みです。`python3 scripts/verify_rtl.py` で2×2・16×16・32×32・4×8・8×16を自動確認できます。`--waves`を付けると2×2のVCDも保存します。構成・操作方法・結果は [rtl/README.md](../../sram512/rtl/README.md) を参照してください。

## シリアル制御＋実スタセル＋2×2 SRAM

[sram_tb_serial.sch](../schematics/sram_tb_serial.sch) をXschemで開き、Netlist → Simulateで実行します。電圧源はVDD/CLK/RESET/SDI/WEのみで、シリアル入力から実セルの読み書きまで接続したTBです。

制御ブロックの中身は [sram_serial_controller.sch](../schematics/sram_serial_controller.sch)。全48スタセル・13 DFFRを1枚に配置し、MUXで保持する部分も直接描いています。独自の1 bit保持レジスタシンボルは使用していません。統合TBではxctrlを選択して階層を降りると確認できます。

CLK周期100 ns、立上り・立下り1 ns。最初の受信は250/350/450 ns、E0は550 ns、E6は1,150 ns、E7は1,250 ns。次のCLK（1,350 ns）から次の受信が始まります。

- 各セルに書き込み→読み出しを行い、チェッカーボードと反転パターンで16操作。
- 2 bit受信したところでCLKを止め、18,030 nsにRESETをHIGHへ。18,160 nsに解除し、18,280 nsから受信を再開。
- RESET前に保存したセルの読み出しと、追加の書き込み→読み出しで3操作。合計19操作。
- 書き込みはE2でPDを開始、E3でWLを上げ、E5でWLを下げ、E6でPDを終了。
- 読み出しはE4でSAEを上げ、E6でSOUTを結果FFへ保持。外部はE7後にSDOを確認。

Xschemからの実行では、セルの保持値とSDOのPASS/FAIL、入力・カウンタ・操作保持値・制御信号・セル内容・SOUT/SDOの波形を表示します。全項目の確認とRTLとの照合は次で行います。

```sh
python3 scripts/verify_serial_spice.py
```

ネットリスト・ログ・波形・比較結果はGit対象外の `build/serial_spice/` へ保存します。回路図を再生成・上書きせずに検証します。完了済み波形を再判定する場合は `python3 scripts/verify_serial_spice.py --reuse build/serial_spice`。刺激を変更した場合は回路図のPWLと `scripts/serial_spice_stimulus.py` の両方を合わせます。

通常実行では、Xschemの情報ウィンドウに出る階層全体のERCメッセージも `netlist.log` に保存し、警告・エラーがあればシミュレーション前に停止します。Q/QB・E7・PC_ON・TRACKのNC表示は、意図的に回路負荷を接続しない端子の印です。ネットを切断する素子ではなく、SPICEにはコメントとして出力されるため、名前による波形観測は引き続きできます。

5 V・27℃、ローカル線追加10 fF、共通線追加100 fF、SA各出力・SDO追加10 fFでPASS。2026-09-12、保持段共有後に3,408件のRTL比較と954件の区間判定で、保持・選択・プリチャージ・実WL/PD・SA・受信途中の非同期RESETを確認しました。RA/CA/DINは受信中にシフトし、アクセス中は同じFFで保持します。受信中のWL/PD停止と、書き換え対象を含む全既知セルの保持も確認しています。初期値の `.ic` はありません。最短周期・ばらつき・配線抽出・実パッド負荷は未評価です。
