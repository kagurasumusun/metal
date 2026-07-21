# probe_scenes — 機械生成 probe シーン集

> **これは生成物** (喪失したら `python3 scripts/build_probe_scenes.py` で再生成)。
> 一次入力: `data/probe_cells.csv` + `data/msl_stage1_api_to_builtin.csv`
> + `data/builtin_to_air_map.v2.csv` (rtlib 層) + `docs/PROBING_PLAN.md` §2。
> 生成日時: 2026-07-21T01:22Z

## 使い方 (docs/PROBING_PLAN.md §1 のコマンド形で実行)

```bash
xcrun -sdk macosx metal -x metal -std=metal3.2 -O2 -S -emit-llvm \
    probe_scenes/scene_P03_math/probe.metal -o probe.ll
```

## golden 回収後の昇格

```
golden/<SCENE>/<std>_<target>/probe.ll + meta.yml (date: YYYY-MM-DD 必須)
    ↓
python3 scripts/promote_map.py apply-golden golden --manifest probe_scenes/MANIFEST.csv
    ↓ builtin_to_air_map.v2.csv が probed_xcode_ll / confirmed に昇格 (EVENTLOG 記録)
```

## 生成内訳

- セル総数: 579 (auto_wrapper: 35 / manual_needed: 544)
- シーン別:

  - P03 (math): auto 6 / manual 1
  - P04 (integer): auto 12 / manual 0
  - P05 (convert): auto 17 / manual 11
  - P06 (texture): auto 0 / manual 293
  - P07 (atomic): auto 0 / manual 13
  - P08 (sync): auto 0 / manual 59
  - P09 (function_constant): auto 0 / manual 1
  - P10 (visible_rt): auto 0 / manual 91
  - P11 (mesh_tensor): auto 0 / manual 26
  - P13 (rtlib_funcs): auto 0 / manual 1
  - UNASSIGNED (unassigned): auto 0 / manual 48

manual_needed ブロックはコンパイルに影響しないコメントのみで、
stdlib の実呼出箇所 (file:line) を同封。実機作業時に最小 wrapper を手書き追加する。
P01/P02 は PROBING_PLAN §2 の設計の直訳テンプレ (実機未検証)。
割当はヒューリスティック — `data/scene_cell_coverage.csv` を人間が検証して修正する。
