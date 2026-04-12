Yamada3チーム用ディレクトリ

# ブロック図
![Radio_block_diagram](image/radio_block_diagram.png)

# 全体
## トランジェント解析
[tb_all_tran.sch](xschem/tb_all_tran.sch)
![tb_all_tran](image/tb_all_tran_1.png)
![tb_all_tran](image/tb_all_tran_2.png)

# 高周波増幅回路
## トランジェント解析
[tb_lna_tran.sch](xschem/tb_lna_tran.sch)
![tb_lna_tran](image/tb_lna_tran.png)

# 検波回路
## 絶対値回路
要求事項：AMの検波用なので、基準電圧より上は入力と同じ出力電圧、基準電圧より下は基準電圧と同じ電圧を出力する。

制約条件：
トランジスタで作る場合：ゲートを入力として使うと、スレッショルド電圧分必ずオフセットが出る。
ダイオードで作る場合：VFのある、シリコンダイオードは検波に適さない。

解決方法：トランジスタで作る。ゲート接地回路を使う。ゲートを電圧＝(基準電圧-スレッショルド電圧分の電圧)となるような電源に接続する。

### DC解析
[tb_abs_dc.sch](xschem/tb_abs_dc.sch)

![Absolute_dc](image/tb_abs_dc.png)

### トランジェント解析
[tb_abs_tran.sch](xschem/tb_abs_tran.sch)
![Absolute_tran](image/tb_abs_tran.png)

## LPF
要求事項：可聴周波数帯域(20Khz以下)は通過させ、AMキャリア周波数(500k～1MHz)は除外させる。

制約条件：
LPF決定用の抵抗・コンデンサを外付けする場合：外付けの分、貴重なピン数を使用してしまう。
LPF決定用の抵抗・コンデンサを内蔵する場合：低い周波数のLPFを作るには、高い値の抵抗・コンデンサが必要になる。

解決方法：
オペアンプでは電圧を基準とした設計になり、ピンが外付けになる設計にするしかない。
そこで、電流を基準とした設計に適した方式を使う。オペアンプではなく、OTAを使う。
OTAであれば、抵抗を使用しなくて済む。gmを少なめにすることで、少ない値のコンデンサでも必要な帯域のLPFを構成できる。

### AC解析
[tb_lpf_ac.sch](xschem/tb_lpf_ac.sch)
![lpf_ac](image/tb_lpf_ac.png)

# 低周波増幅回路

[tb_pa_tran.sch](xschem/tb_pa_tran.sch)
![tb_pa_tran](image/tb_pa_tran.png)

# AMチップ外

## 同調回路

### AC解析
[tb_tuner_ac.sch](xschem/tb_tuner_ac.sch)
![tb_tuner_ac](image/tb_tuner_ac.png)


### トランジェント解析
[tb_tuner_tran.sch](xschem/tb_tuner_tran.sch)
![tb_tuner_tran](image/tb_tuner_tran.png)

## 筐体

## アンテナ

## その他

