# SRAMテストベンチのシミュレーション出力

このプロジェクトの `sram_tb*.sch` をGUIでNetlistするとき、
LVSモードを一時的に解除し、階層付きのシミュレーション用SPICEを生成します。
処理後は元のLVS・spiceprefix・Flat設定を戻します。

Xschem 3.4.8RCでは `netlist_options` の処理前に最上位の `.subckt` 出力可否が
決まるため、シンボルの設定だけではLVSモードを完全に解除できません。
`inject.tcl` は `xschem netlist` の実行直前に設定を切り替えます。
Xschem本体は変更しません。

`~/.xschem/xschemrc` の `postinit_commands` から読み込み済みです。
設定変更後はXschemを再起動してください。現在のセッションだけ読み込む場合は
Tclコンソールで次を実行できます。

```tcl
source /home/ishi-kai/sram/xschem/testbench_mode/inject.tcl
```

CLIの `-n` はTclの実行フックを通らないため、検証時は起動後のコマンドとして
`--command 'xschem netlist; exit'` を使うか、起動時に明示的に
`lvs_netlist=0`、`top_is_subckt=0`、`spiceprefix=1` を設定します。

端末起動の `||: No such file or directory` は別の問題でした。
`~/.xschem/simrc` のNgspice interactiveコマンドを、設定済みのgnome-terminalに合わせて
`$terminal -- ngspice -i "$N" -a` に修正しています。
