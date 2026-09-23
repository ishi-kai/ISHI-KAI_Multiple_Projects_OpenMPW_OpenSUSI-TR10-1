# OPAMP設計 成果物

## 概要
想定用途は照度センサーの出力増幅。速度動作は不要。
TR-1um PDKのPCellを用いた2段OPAMP。M1〜M12 + F_CSIO容量(位相補償)構成。

## レイアウトチェック
DRC合格､LVS一致を確認

F_CSIOが正方形(120um×120um)だとLVSエラー(浮動小数点の問題か?)が出るため、
120um×119.8umに調整。

## AC解析(sable_AC解析結果.png)
- 利得: 49.4 dB (1kHzでの利得)
- 単位利得周波数(ugf): 608 kHz
- 位相余裕: 59.2度
- ※シミュレーションではCSIOモデルの互換性問題により理想容量で代用
- ※レイアウトでは、Cc寸法をわずかに変更

## ファイル
- sable_myopamp_v02.sch: 回路図(変更なし)
- sable_myopamp_v2-29.gds: レイアウト
- sable_AC解析結果.png: AC解析結果
