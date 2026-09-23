# OpenSUSI-TR10 CMOS Inverter

CMOS inverter designed using the OpenSUSI-TR10 PDK.

## Files

- inverter_drc_rev1.sch
- inverter_drc_rev1.gds

## Tools

- OpenSUSI-TR10
- Xschem
- ngspice
- KLayout

## Verification

- DC simulation
- Transient simulation
- DRC

## Impressions

今回のハンズオンでは、CMOSインバータの回路図作成からSPICEシミュレーション、レイアウト作成、DRCまで一通り経験しました。

回路図では単純に見えるCMOSインバータでも、実際にレイアウトすると、PMOSとNMOSの配置、コンタクト、配線、ウェルなどを意識する必要があり、回路設計とは違った難しさがあると感じました。

特に、回路図上の接続を実際の物理レイアウトとして構成していく過程が印象に残りました。KLayoutの操作には少し苦戦しましたが、回路図からレイアウトまで一連の流れを経験できたことで、IC設計の流れを具体的に理解できました。

## Notes

Created as part of the ISHI-Kai OpenSUSI-TR10 hands-on exercise.
