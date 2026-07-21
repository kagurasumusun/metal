# VERIFICATION — 「本当に完成した？」への独立検証記録

最終検証: 2026-07-21 (検証器 `scripts/verify_map.py` v1.0、この日以降の恒常監査器)

本書は `data/builtin_to_air_map.v2.csv` (686 行) の自己申告を**鵜呑みにせず**、
一次ソース (実ヘッダ / golden corpus .ll / Apple rtlib IR 実シグネチャ / rtlib
下降グラフ) と再照合した記録である。検証は機械 (スクリプト) が行い、
人の判断は分類ルールの設計のみに限定した。

## 検査項目と結果 (全緑)

| # | 検査 | 内容 | 結果 |
|---|---|---|---|
| C1 | universe | 実ヘッダ (reference/clang/32023.883/include) の `__metal_*` トークン集合 == 正本 builtin 集合 | **686 : 686 で 1:1 完全一致** (過不足 0) |
| C2 | invariants | evidence↔confidence↔grammar_eligible↔candidate の整合規則 (probed→confirmed+候補あり / inferred→low+grammar no+候補空+disposition文書あり) | 全 686 行整合 |
| C3 | probed 内容 | probed_xcode_ll 540 行の air 候補が参照 golden probe.ll に**実在**するか | live-ok=467 / inline-only=73 / gap=0 (修復 155 件実施、下記) |
| C4 | observed_ir | observed_ir 97 行の候補が Apple rtlib IR 実シグネチャ集 (ir_air_signatures.csv, 8,200 decl) に実在するか | 97/97 実在 |
| C5 | rtlib backing | rtlib_layer_backing 4 行の rtlib シンボルが下降グラフ実在するか | 4/4 実在 |
| C6 | vocab | 全候補 (641) が golden corpus / rtlib IR / 下降グラフのいずれかで観測可能か (辞書外語の混入検出) | 641/641 観測可 |
| C7 | golden index | air_golden_names.csv (545) の example_source パス実在性 | stale 0 |

## 証拠の 3 分類 (probed_xcode_ll 540 行の内訳)

1. **live (467 行)** — 参照先 corpus ファイルが存在し、候補 air 名が
   ファイル内に実在することを機械照合済み。
2. **inline-only (73 行)** — 一次観測行 (`tail call @air.…` の実測行) が
   evidence_ref 内に**インラインで完全保存**されている。原本
   `golden/P06M/metal32_macosx26/probe.ll` は後の probe run で上書き喪失
   したため、パスは歴史的記録として維持し、内容はインラインで担保する。
   (texture atomic 1d/1d_array/2d/2d_array/3d 系、cube/1d_array dims 系)
3. **disposition (45 行、evidence=inferred)** — air op 非存在を実測で確定
   (native fdiv/select, clang 合成関数呼出, opaque 型 passthrough, sampler_state
   定数, frontend-crash trait 等)。evidence_ref に根拠文書あり。

## 検証で発見・修復した欠陥 (2026-07-21)

- evidence_ref の死んだパス **155 件を内容照合つきで修復** (candidate 名の
  変更は一切なし。新レイアウト run18–26_apply への再指向 152、旧 bare scene →
  metal40 収束版 dir への再指向、run10/11/12/14_apply corpus 取り込み 5)。
- `__metal_read_depth_2d_ms_t`: 旧参照のインライン片段が
  `air.get_read_sampler` (別 op) だった不整合を検出 → 実測済み
  golden/P06M40_run10 @probe_p06m_read_19 へ再指向。
- 取り込み dir 名の揺れ (golden_run14_apply) を run14_apply に正規化し
  13 行の ref を追随。

## 残る「薄い」点 (正直な申告)

- inline-only 73 行は原本 .ll 不在のため、**次善として再現 probe** (保存済み
  golden/P06M/metal32_macosx26/probe.metal を現行 toolchain で再コンパイル)
  により file backing を更新する余地がある。候補名自体は inline の実測行で
  一次担保済み。
- `_t` 系 opaque 型のビット精度レイアウト定量表は未整備 (型の size/align の
  正本計測)。対応表の完全性とは独立の拡張項目。

## 運用

```
python3 scripts/verify_map.py          # 全検査 (問題があれば exit 1)
python3 scripts/verify_map.py --repair # 内容照合つき evidence_ref 修復
python3 scripts/promote_map.py audit   # schema/evidence 自己整合
```

今後 EV 変更時は verify_map + audit の両緑をコミット条件とする。
