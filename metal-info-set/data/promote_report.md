# 対応表 v2 確度レポート

生成: 2026-07-21T04:54Z by promote_map.py@1.0.0 (冪等: audit 直後の状態の集計)

## evidence × confidence

| evidence | confirmed | high | medium | low | 計 |
|---|---|---|---|---|---|
| observed_ir | 97 | 0 | 0 | 0 | 97 |
| inferred | 0 | 22 | 111 | 2 | 135 |
| probed_xcode_ll | 450 | 0 | 0 | 0 | 450 |
| rtlib_layer_backing | 4 | 0 | 0 | 0 | 4 |
| **計** | **551** | **22** | **111** | **2** | **686** |

## probe 必須セル残: **569** 件
(probe_cells.csv 全 576 セル中、対応表行に連結済 569 件)

## evidence_source 分布

- xcode_probe_golden: 452
- this_repo_inference: 135
- apple_rtlib_ir: 99

## 検証日付カバレッジ

- verified_at 記録済: 686/686
- observed_at (一次観測日) 記録済: 454/686 (不明なものは推測で埋めない方針のため空)
