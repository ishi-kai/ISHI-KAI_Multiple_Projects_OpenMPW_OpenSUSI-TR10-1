# シリアルSRAM制御のVerilog

[確定仕様](../../learning/docs/SEQUENCER_DESIGN.md)の制御部をRTLとして記述し、デジタルシミュレーションで検証する。このディレクトリは論理仕様とデジタル検証を扱う。2×2のXschem回路図・SPICE統合検証は別途実装済み。自動論理合成と周辺回路の配置配線は行っていない。

## ファイルと読む順序

| ファイル | 内容 |
|---|---|
| [sram_serial_controller.v](sram_serial_controller.v) | 実装対象の制御RTL。最初に読む。単一カウンタ・受信兼アクセス保持シフトレジスタ・WE保持FF・制御出力FF・読み出し結果FF |
| [sram_functional_model.v](../../learning/tb/sram_functional_model.v) | TB専用のSRAM＋センスアンプ動作モデル。制御出力に応じて1 bitを書き込み・読み出す |
| [tb_sram_serial_controller.sv](../../learning/tb/tb_sram_serial_controller.sv) | 外部ピンからの操作、状態表の照合、期待メモリとの比較、RESETなどの自動テスト |
| [verify_rtl.py](../../scripts/verify_rtl.py) | Icarus Verilogでコンパイル・実行する入口 |

本体はVerilog、TBは文字列などを扱いやすいSystemVerilogで記述している。TBのモデルをチップへ実装・合成する対象にはしない。

## 本体の読み方

`ROW_BITS`と`COL_BITS`が行・列アドレス幅。初期値は各1で2×2に対応する。受信は `RAのMSB→LSB、CAのMSB→LSB、DIN` の順。Nはその合計bit数。

`count`は次のCLK立上りで実行する手順番号。立上り直前の値で処理を決める。

- `count < N`：1 bit受信する。RA/CA/DINはそのシフト結果に従って変わる。WL・書き込みはOFF。
- `count == N`：E0。受信段の全bitは保持を継続。外部WEをWへ取り込み、プリチャージを始める。
- その後の `case` のE1〜E7：設計書の各手順と1対1で対応する。
- E7の立上り後にcount=0となり、次の立上りが次の受信になる。

`<=`はFF更新のノンブロッキング代入。同じ立上りの処理では更新前の値を読む。E0の `TRACK <= ~WE` は今回の読み書きを反映するためで、古いWは使わない。

PC_ON、TRACK、WRITE_EN、WL_ENは全てFFに保持する値。各CLKでまず非アクセス値を指定し、該当する手順だけ値を変更する。shift_regは受信時だけ更新し、RA/CA/DINはその出力を直接使う。WはE0、READ_DATAは読み出しE6でだけ更新する。RA/CA/DIN専用の第2保持段はない。

RESETで全保持値を0へ戻す。PREB/YPREBはPC_ONの反転、SAEはTRACKの反転なので、外へはHIGHが出る。スタセル化時にはDFFRのQBを使える表現になっている。

外部の信号ピンはCLK、RESET、SDI、WE、SDOの5本で、VDD/VSSを加えて7本。RTL本体のRA/CA/DIN/PREB/YPREB/WRITE_EN/WL_EN/SAE/SOUTは、チップ内部でSRAMや周辺回路と接続する端子。追加の外部ピンではない。電源とパッドは論理RTLには含めていない。

## 実行方法

必要なものはPython 3とIcarus Verilog（`iverilog`、`vvp`）。この作業環境では、UbuntuのIcarus Verilog 12.0パッケージをユーザー領域の `~/.local/share/sram-tools/iverilog/` に展開済み。スクリプトが自動検出する。別環境ではIcarus VerilogをインストールしてPATHへ置くか、環境変数IVERILOG/VVPで各実行ファイルを指定する。

リポジトリのルートから、全構成を実行する。

```sh
python3 scripts/verify_rtl.py
```

2×2だけを実行し、波形を残す。

```sh
python3 scripts/verify_rtl.py --row-bits 1 --col-bits 1 --waves
```

全構成を実行しつつ2×2の波形を残すには `python3 scripts/verify_rtl.py --waves`。任意の構成を指定する場合は行・列の両方を指定する。

ログと実行ファイルは `build/rtl/<行数>x<列数>/` に保存する。`--waves`指定時の波形は同ディレクトリの `serial_controller.vcd`。VCD対応ビューアで開ける。全て再生成できるためGit管理しない。検証が失敗するとスクリプトは非ゼロで終了する。

波形はCLK/RESET/SDI/WE、dut.count、dut.shift_reg、RA/CA/DIN/dut.W、PREB/WRITE_EN/WL_EN/SAE、SOUT/SDOの順に並べると追いやすい。countはエッジ後には次の手順番号へ進んでいる点に注意する。

## テストが確認すること

- 受信順、受信中のRA/CA/DINの更新とアクセス停止・セル保持、E0でのWE取り込み、E0〜E7中のSDI/WE変更の無視。
- 各手順の制御値、カウンタ更新、1操作がN+8立上りで完了すること。
- 全セルに0と1を書き、逆順の読み出しと混在操作でSDOを照合すること。期待値は外部から要求したアドレスとデータから作り、DUTのアドレスを流用しない。
- SDOが読み出しE6でだけ更新し、それ以外の手順で保持されること。
- CLKを止めた状態での非同期RESET、CLKがある場合のRESET優先、非アクセス時のRESETでSRAM内容が消えないこと。
- 受信途中の停止・再開、受信途中および読み書きの各段階でのRESET、その後の再操作。
- カウンタの未使用符号から受信先頭への復帰。

2×2では各操作後に全セルの保持内容も確認する。大きい構成では全アドレスの読み戻しと、操作群の後の全セル比較を行う。行・列の幅が異なる4×8は分割位置の検証、8×16は総手順数がちょうど16になるカウンタ境界の検証に使う。

初回は意図的に未書き込みセルを読み、SDOがXになることを確認している。テスト失敗ではない。モデルは未書き込みセルを0で初期化せず、RESETでも消去しない。

## 検証結果と限界

2026-09-12、保持段共有後にIcarus Verilog 12.0で以下がPASS。

| 構成 | 完了操作数 | 自動判定数 | CLKなしRESETの試験回数 |
|---|---:|---:|---:|
| 2×2 | 184 | 22,304 | 22 |
| 16×16 | 1,198 | 173,553 | 28 |
| 32×32 | 4,272 | 677,568 | 30 |
| 4×8 | 299 | 37,467 | 25 |
| 8×16 | 685 | 94,672 | 27 |

モデルはCLKやcountを参照せず、WL_ENの立下り時にWRITE_ENがHIGHなら書き込み、WL_ENがHIGHでWRITE_ENがLOWのときのSAE立上りで読み出す。書き込み内容をWL立下りで確定するのはデジタル検証用の近似であり、実セルの反転時刻を表していない。

SAの追従・プリチャージ中にはSOUTをXにして、古い判定を有効データとして扱わないようにする。これは実回路の両出力HIGHやアナログ波形を再現するものではない。電圧、寄生RC、ゲート遅延、センス感度、読み出しディスターブ、RESET中断時の実セル挙動は未評価。

ここで確認できたのは制御の論理仕様。2×2についてはスタセル回路＋既存SRAMのSPICE統合検証も実装済みで、`python3 scripts/verify_serial_spice.py` から実行できる。[回路図とSPICE検証の説明](../../learning/docs/SEQUENCER_DESIGN.md#12-2×2のスタセル実装とrtl照合)を参照。RTLの配列拡張試験と、2×2のアナログ検証は別の確認範囲である。
