# 512 bit専用の生成・検証ツール

普段の入口は`python3 sram512/run.py --help`です。

| 目的 | 主なファイル |
|---|---|
| 開く・描画する | `open.py`、`export_schematics.py` |
| 回路図生成 | `design.py`、`schematics.py` |
| 論理・MOS試験 | `verify_digital.py`、`analog.py`、`postlayout.py` |
| 配線モデル・電流・保持 | `wire_rc.py`、`signal_mesh.py`、`power_mesh.py`、`all_cell_retention.py` |
| 保存GDS検証 | `verify_saved_layout.py`、`manufacturing.py`、`pcell_preservation.py` |
| 最終配線改善 | `strengthen_signal_routes.py`、`reinforce_decoder_routes.py`、`widen_decoder_poly.py` |
| 長時間試験 | `verification_jobs.py`、`startup_tests.py`、`reset_address_test.py` |
| 合否・提出物 | `validation_summary.py`、`build_submission.py`、`package.py` |
| 配置配線の試行・共通部品 | `layout_*`、`routing*`など |

コマンドは[../README.md](../README.md)と[../EXPERIMENTS.md](../EXPERIMENTS.md)にあります。
共通関数を参照する試行用モジュールも同じ場所に保持しています。
