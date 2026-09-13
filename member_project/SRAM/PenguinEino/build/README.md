# 再生成できる計算出力

大きな波形・コンパイル出力・配線途中のGDS・ログです。Gitにはこの案内だけを登録します。
今回の整理では計算データを削除・移動していません。

| 場所 | 内容 |
|---|---|
| `sram512/submission/` | 提出ZIP。最小版は`sram512_submission_56810ad742a7.zip` |
| `sram512/analog/decoderfix_power_paths_ramp/` | 最終GDS・5 V/27°Cの16操作とraw |
| `sram512/analog/decoderfix_pg_rc3_lowhot/` | 最終GDS・4.5 V/85°C/信号RC×3の16操作 |
| `sram512/layout/rechecked16x32/` | 保存GDSの再検証と公式抽出結果 |
| `sram512/organization/` | 移動後のネットリスト比較・提出物確認 |
| `sram512/jobs/` | 長時間解析のコマンドと状態記録 |
| `rtl/`、`serial_spice/`、`shared_frame/` | 学習段階の論理・MOS・FF共用試験 |
| その他の`sram_*` | セル配置比較と途中候補の出力 |

最終結果は[検証一覧](../sram512/reports/validation_summary.json)から辿ってください。
