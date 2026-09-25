# MACのシリコンアート

M2（20/0）に、2行の「EINOSUKE」「OKAZAKI」とペンギンを配置した。範囲はx=1517〜1733、y=450〜694 µm。文字幅20 µm、文字間隔8 µm（送り28 µm）。名前・絵はGDS内の実ポリゴンで、silicon_artセルに格納する。

右上の外部端子を次の位置へ引き出した。全体は1800×1000 µm内に収まり、外形は1788.4×780.85 µm。

| 端子 | 層 | 座標 (µm) |
|---|---|---|
| VDD | M1 | (1780, 744.6) |
| and_out | M2 | (1780, 715) |
| or_out | M2 | (1780, 705) |

ペンギンは以前のインバータGDSから取り出した。変換元・ハッシュは[art/source.json](art/source.json)、実寸を保ってDBU=0.001 µmへ変換した元図形は[art/original_inverter_art.gds](art/original_inverter_art.gds)。配置と文字生成は[silicon_art.py](silicon_art.py)に実装した。

以前のSVG変換ツールは、この環境の `/home/ishi-kai/OpenEDA-PDK_SetupScript/samples/inverter/OpenSUSI-TR10/svg_to_metal2_gds.py` にある。

再生成はリポジトリのルートで `python3 layout/build_mac_layout.py`。生成後、`python3 scripts/verify_arithmetic_layout.py mac`、`python3 scripts/check_mac_art_geometry.py`、`python3 scripts/check_mac_edge_access.py`、`python3 scripts/requalify_mac_edge_ports.py`で検証する。

Drawing DRC 0件、strict LVS一致、全9電気回路の端子名・素子端子・全パラメータの同等性、抽出81入力＋復帰の合格を確認した。アートと機能回路のM1/M2/ビアの間には3 µm以上の間隔がある。DBUは0.001 µm、全ポリゴン頂点は0.05 µm格子上にある。

アートの証跡は `reports/mac_art_geometry.json`。全端子を境界へ引き出した最新版の証跡は `reports/mac_edge_ports.json` と `reports/mac_edge_access.json`。全6,480/648遷移は電気的に同じ基準版の結果を継承している。
