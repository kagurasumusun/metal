# 対応表 v2 確度レポート

生成: 2026-07-21T04:00Z by promote_map.py@1.0.0 (冪等: audit 直後の状態の集計)

## evidence × confidence

| evidence | confirmed | high | medium | low | 計 |
|---|---|---|---|---|---|
| observed_ir | 97 | 0 | 0 | 0 | 97 |
| observed_airconv | 0 | 2 | 0 | 0 | 2 |
| inferred | 0 | 23 | 161 | 2 | 186 |
| probed_xcode_ll | 397 | 0 | 0 | 0 | 397 |
| rtlib_layer_backing | 4 | 0 | 0 | 0 | 4 |
| **計** | **498** | **25** | **161** | **2** | **686** |

## probe 必須セル残: **569** 件
(probe_cells.csv 全 576 セル中、対応表行に連結済 569 件)

## evidence_source 分布

- xcode_probe_golden: 399
- this_repo_inference: 186
- apple_rtlib_ir: 99
- community_airconv_src: 2

## 検証日付カバレッジ

- verified_at 記録済: 686/686
- observed_at (一次観測日) 記録済: 401/686 (不明なものは推測で埋めない方針のため空)
