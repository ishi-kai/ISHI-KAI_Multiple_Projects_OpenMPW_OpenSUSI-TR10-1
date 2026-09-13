# 512 bitの編集用回路図

| ファイル | 役割 |
|---|---|
| **sram512_macro.sch** | 7端子の最上位。LVSで照合する階層入口 |
| **sram512.sch** | アレイ・デコーダ・書き込み・SA・制御を含む全体 |
| **sram512_tb.sch** | 外部電圧源と追加負荷を含むMOSテストベンチ |
| sram512_array.sch / sram512_bitcell.sch | 16×32アレイと6Tセル |
| sram512_row_decoder.sch / sram512_col_decoder.sch | 行・列のデコード |
| sram512_column.sch | 各列のプリチャージとnMOS MUX |
| sense_amp_7t.sch | 共通7Tセンスアンプ |
| sram512_controller.sch | シリアルコントローラー全体 |
| sram512_frame.sch / sram512_phase.sch / sram512_control.sch | 受信FF、カウンタ、制御出力 |
| sram512_input_clamp.sch | 小型DP/DN。パッドESDとは別 |
| write_control.sch | 学習用2×2から共用する書き込み制御 |

`python3 sram512/run.py circuit`または`python3 sram512/run.py tb`で開きます。
同名`.sym`は階層回路のシンボルです。まとめて同じフォルダに保持してください。
