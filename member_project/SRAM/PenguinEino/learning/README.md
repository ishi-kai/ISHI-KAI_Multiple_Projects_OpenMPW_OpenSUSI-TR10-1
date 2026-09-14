# 単セル・2×2の学習用回路

16×32の完成版へ進む前に、動作を段階的に確認した回路です。
提出対象の完成版は[../sram512/](../sram512/README.md)、提出物は[../submission/](../submission/README.md)です。

| 内容 | 場所 |
|---|---|
| 単セル、2×2、行列デコーダ、各段階のTB | [schematics/](schematics/) |
| 手描きセル・2×2、dense版GDSと抽出結果 | [layout/](layout/) |
| 以前の波形、容量・SA入力差の検討 | [simulation/](simulation/) |
| TBの説明 | [docs/TESTBENCHES.md](docs/TESTBENCHES.md) |
| シリアル操作の設計説明 | [docs/SEQUENCER_DESIGN.md](docs/SEQUENCER_DESIGN.md) |
| 学習用Verilog TB | [tb/](tb/) |

## 学習順

1. `sram.sch`と`sram_tb_tran_write_pulldown.sch`：最小6Tセル、片側プルダウン書き込み。
2. `sram_tb_sense_amp.sch`、`sram_tb_cell_sense.sch`：7T SA単体とセル接続。
3. `sram_tb_array_mux.sch`：2×2と列MUX。
4. `sram_tb_array_decoders.sch`、`sram_tb_array_write_control.sch`：行列選択と書き込み制御。
5. `sram_tb_serial.sch`：シリアル受信とシーケンスを含む2×2。

```sh
python3 learning/open.py
python3 learning/open.py sram_tb_tran_write_pulldown.sch
python3 scripts/verify_rtl.py --row-bits 1 --col-bits 1 --exhaustive
```

`sense_amp_7t`と`write_control`は`../sram512/schematics/`を共用します。
`open.py`は両方の検索先とdev PDKを設定します。
旧試作はそのまま保存してあり、512 bitの合格結果を旧試作へ適用したという意味ではありません。
