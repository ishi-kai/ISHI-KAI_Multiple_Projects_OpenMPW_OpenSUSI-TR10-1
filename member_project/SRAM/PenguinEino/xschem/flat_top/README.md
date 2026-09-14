# Xschem Flat出力の最上位subckt保持

Xschem本体と `/usr/local/share/xschem/` のインストール済みファイルは変更しません。
`inject.tcl` は起動後にTclの `netlist` 手続き内の `flatten.awk` の参照先だけを変更します。
`flatten.awk` はインストール済みのGPLスクリプトのコピーで、追加差分は次の2点です。

- 元の最上位宣言が `.subckt` なら、宣言（継続行・端子・パラメータを含む）と `.ENDS` を出力。
- 元の最上位宣言が `**.subckt`（通常のテストベンチ）なら、従来と同じFlat出力。

素子・接続の展開処理は変更していません。Flat無効時やSPICE以外の出力も従来の処理です。
注入先のTclコードが将来変更された場合は、想定箇所が1個だけ存在することを確認し、
適用できなければエラーを出します。

## 導入済みの設定

`~/.xschem/flat_top` はこのディレクトリへのシンボリックリンクです。
`~/.xschem/xschemrc` の末尾に以下を追加しています。
既存の `postinit_commands` は置き換えません。

```tcl
append postinit_commands "\n" [list source [file join $env(HOME) .xschem flat_top inject.tcl]] "\n"
```

既に起動中のXschemでは、Tclコンソールから次を実行して読み込めます。

```tcl
source ~/.xschem/flat_top/inject.tcl
```

現在のセッションには適用済みです。二重読み込みでも追加変更はしません。
解除は `xschemrc` の `BEGIN SRAM flat-top injection` から `END` までのブロックを削除し、
Xschemを再起動します。追加前の設定は `~/.xschem/xschemrc.before-flat-top-injection` に保存しています。

## 操作と検証

SRAM arrayでは **Flat netlist** と **LVS netlist + Top level is a .subckt** を有効にし、
出力先をプロジェクトの `simulation/` にしてNetlistを実行します。
最上位だけが`.SUBCKT SRAM_ARRAY ...`として残り、内部は24 MOSに展開されます。
その生成ファイルをそのまま標準TR-1um LVSで比較します。

```sh
python3 -m unittest discover -s xschem/flat_top/tests -v
python3 klayout/lvs/run.py
```

ヘッダー継続行、素子本体が従来と同一であること、通常のテストベンチFlat出力が
従来とバイト単位で同じであることをテストしています。
GUIの起動時読み込み、および実際に開いている回路図からのネットリスト生成も確認済みです。
