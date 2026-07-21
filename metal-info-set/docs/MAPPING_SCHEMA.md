# 対応表スキーマ v2 (builtin_to_air_map)

> 目的: `data/builtin_to_air_map.csv` を **確度・出所・日時・検証手順を追跡できる器** に拡張する。
> 原則: **additive のみ (列追加のみ、列の削除・リネーム・行削除をしない)**。v1 7 列は意味そのまま維持。
> 変更は全て `docs/EVENTLOG.md` に ISO 日時付きで記録される (generate-and-verify 方式: 人手編集せずスクリプトで生成)。

## 1. 列定義

### v1 継承列 (意味固定)

| # | 列 | 意味 |
|---|---|---|
| 1 | `__metal_builtin` | 主キー。stdlib が呼ぶ clang 内蔵 builtin 名 (686) |
| 2 | `used_via` | 使用経路: `free` / `method` / `free+method` / `none`(呼出サイト無し) |
| 3 | `n_call_sites` | stdlib ヘッダ内の呼出箇所数 |
| 4 | `air_intrinsic_candidate` | AIR 候補名 (型 suffix 付きの例示形 or stem) |
| 5 | `evidence` | 証拠等級 enum (下記 §2)。v1 値を後方互換で維持 |
| 6 | `status` | 日本語の人間向け注記 (絵文字含む) |
| 7 | `stdlib_sample` | stdlib 内代表呼出箇所 `file:line: text` |

### v2 追加列

| # | 列 | 意味 / 値域 |
|---|---|---|
| 8 | `evidence_source` | 証拠の主体 (誰の言質か): `apple_rtlib_ir` (純正ランタイム bitcode の実 IR) / `apple_gpucompiler_symbols` (.tbd シンボル) / `apple_stdlib_headers` / `apple_msl_spec_pdf` / `community_airconv_src` (3Shain/dxmt) / `community_naga_wiki` / `this_repo_inference` (命名文法からの我々の推論) / `xcode_probe_golden` (実機 Xcode 出力) |
| 9 | `evidence_ref` | 証拠の場所: `file:line` / `doc#section` / golden 相对パス / CSV 名 |
| 10 | `protocol` | 検証手順 ID (§3)。複数は `+` 連結 |
| 11 | `confidence` | `confirmed` / `high` / `medium` / `low` (§4 の機械ルールで再計算される。手入力しない) |
| 12 | `grammar_eligible` | `yes` / `no`: candidate が AIR 命名文法に照合可能か (P-GR1) |
| 13 | `probe_cell` | `data/probe_cells.csv` の cell と一致 (=probe 必須) か空 (=probe 不要) |
| 14 | `observed_at` | 証拠の観測日 (ISO 日付)。**不明なら空のまま** (推測で日付を埋めない) |
| 15 | `verified_at` | 直近の機械検証 (audit) 成功日。`scripts/promote_map.py audit` が書く |
| 16 | `verified_by` | 検証スクリプト識別子 `promote_map.py@<ver>` |
| 17 | `last_change` | 行の最終変更 (ISO datetime) |
| 18 | `changed_by` | 変更主体スクリプト |

## 2. evidence enum (v1 → v2 拡張)

| 値 | 意味 | confidence に与える影響 |
|---|---|---|
| `observed_ir` (v1) | 純正ランタイム bitcode 内で AIR 実シグネチャを確認 | confirmed (audit 再検算成功時) |
| `observed_airconv` (v1) | airconv (dxmt) ソース内 literal で AIR 名を確認 | high |
| `inferred` (v1) | 命名文法からの推測 (probe 必須) | §4 ルールで medium/high/low |
| `probed_xcode_ll` (v2 新) | 実機 Xcode 生成 .ll (golden corpus) で確認 | confirmed (最強) |
| `recomputed_callgraph` (v2 新) | コールグラフ抽出で定義側からの寄与を確認 | high (補助証拠。単独では confirmed にしない) |
| `rtlib_layer_backing` (v2 新) | **AIR intrinsic に直接写像せず rtlib 実装 `__air_impl_<base>_*` 呼出に lowering される builtin** (callgraph で実装関数実在を確認)。candidate 列は `rtlib:__air_impl_<base>` 表記になり grammar 照合対象外 | confirmed |

## 3. protocol ID (検証手順の銘々)

| ID | 手順 | 実施器 |
|---|---|---|
| P-IR1 | llvmlite で runtime bitcode を全文 parse し `air.*` declare/call の実在を確認 | `dump_ir_ground_truth.py` / `promote_map.py audit` |
| P-AC1 | airconv ソース内の `air.*` literal との文字列一致 | `build_air_definitive.py` / audit |
| P-GR1 | AIR 命名文法 (セグメント式: `rt[zpen]`, `(p\d+)?v?\d*[fibuh]\d+`) への機械照合 | `promote_map.py audit` |
| P-ST1 | air_stems_binaries.txt (バイナリ実測 stem 辞書) への包含照合 | audit |
| P-CG1 | コールグラフ (`callgraph_edges.csv`) で rtlib 実装の実在・当該 air.* 呼出を確認 (L4 層判定を含む) | `build_callgraph.py` → `promote_map.py apply-rtlib-layer` / `ingest-callgraph` |
| P-XC1 | golden `.ll` のエントリ関数から `air.*` 呼出を抽出し builtin と突合 (MANIFEST 突合) | `promote_map.py apply-golden` |
| P-MN1 | マッピング生成 (stdlib 呼出解析) 自体 — v1 生成時の手続き | `build_mapping.py` |

## 4. confidence 機械ルール (audit が各行に適用)

```
observed_ir        + P-IR1 再検算OK                          → confirmed
probed_xcode_ll    + P-XC1 (golden 存在し突合一致)           → confirmed
observed_airconv   + P-AC1 + P-GR1 照合OK                    → high
recomputed_callgraph + P-CG1                                 → high
inferred           + grammar_eligible かつ P-ST1 包含        → high
inferred           + grammar_eligible のみ                   → medium
上記以外 / audit 失敗 (candidate が文法にも辞書にも合わない) → low (要再調査: EVENTLOG QUARANTINE)
```

- `confirmed`/`high` でも `probe_cell` が残っている行は実機確定の対象のまま (probe による最終確定を否定しない)。
- audit は **冪等**: 同じ入力に同じ結果。失敗した行を削除せず confidence=low に落とすだけ (暴力で帳尻を合わせない)。

## 5. ファイル体系

| ファイル | 役割 | 生成器 |
|---|---|---|
| `data/builtin_to_air_map.v2.csv` | 対応表 v2 (正本) | `migrate_map_v2.py` → 以後 `promote_map.py` が更新 |
| `data/builtin_to_air_map.csv` | v1 (凍結・改変しない。再現用に保持) | `build_final_tables.py` |
| `docs/EVENTLOG.md` | 全変更イベントの日時ログ | 各スクリプトが append |
| `data/promote_report.md` | 確度集計の最新スナップショット | `promote_map.py report` |
| `data/callgraph_edges.csv` | 全ランタイム call グラフ (L4 判定・補助証拠の一次情報) | `build_callgraph.py` |
| `data/rtlib_layer_map.csv` | `__air_impl_*` → `__metal_*` 逆引き辞書 | `build_rtlib_layer.py` |
| `probe_scenes/` + `MANIFEST.csv` | golden 昇格の鍵となる probe シーン (機械生成) | `build_probe_scenes.py` |
| `data/scene_cell_coverage.csv` | セル割当の人間検証ビュー | `build_probe_scenes.py` |

## 5b. 昇格オペレーション一覧 (promote_map.py)

| コマンド | 作用 | 冪等性 |
|---|---|---|
| `audit` | 全行を一次辞書で再検算、confidence 再付与 (降格は QUARANTINE 記録) | 冪等 |
| `report` | 確度集計を `data/promote_report.md` へ | 冪等 |
| `apply-rtlib-layer` | `rtlib_layer_map.csv` を適用し L4 帰属を確定 (偽の air.* 候補は EVENTLOG 記録の上で値修正) | 冪等 (適用済は already に計上) |
| `ingest-callgraph` | callgraph の直接 air 参照を補助証拠として昇格 (名マッチ+stem 照合の両立のみ) | 冪等 |
| `apply-golden DIR --manifest M` | golden corpus で `probed_xcode_ll` 昇格 (selftest 済) | 冪等 (昇格済は skip) |
| `selftest` | apply-golden 器の自己検証 (正本のコピーで実行・汚染なし) | — |

## 6. golden corpus → 昇格の接続 (apply-golden 契約)

`probe_scenes/MANIFEST.csv` (build_probe_scenes.py 生成) の各行:
`scene, file, symbol, builtin, stage1_source` — 「このシーンのこの関数はこの builtin を叩く設計」の宣言。

実機実行後 `golden/<SCENE>/<std>_<target>/probe.ll` を置くと、`promote_map.py apply-golden` は:

1. MANIFEST の (file, symbol) ごとに golden 内の対応 `define` を特定
2. その関数体内の `air.*` 呼出シグネチャを抽出
3. MANIFEST の builtin ↔ 抽出 air 名を突合 (命名文法照合で同種判定)
4. 一致 → 対応表行を `evidence=probed_xcode_ll, confidence=confirmed, observed_at=<golden の meta.yml の日付>, evidence_ref=<golden パス>, protocol+=P-XC1` に昇格
5. 不一致 → 行を **降格せず** EVENTLOG に MISMATCH として記録 (要人間判断)

突合に必要以上の推測をしない: 「この関数はこの builtin を叩く」は MANIFEST のみを信頼 (関数名パターン推測はしない)。
