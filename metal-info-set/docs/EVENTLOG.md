# EVENTLOG ― 情報セット全変更の日時記録

> 全スクリプト (migrate/promote/scene builder/callgraph) がここに append する唯一の変更ログ。
> 形式: `| 日時 (ISO) | event | actor | target | detail |`

| 日時 | event | actor | target | detail |
|---|---|---|---|---|
| 2026-07-21T00:00Z | INIT | human | repo | probe_scenes/ と airlib callgraph 抽出木の喪失を確認 (workspace snapshot 外)。PROBING_PLAN.md・probe_cells.csv・全一次 CSV は残存。以後「生成器で再生する筋」を採用 (削除で帳尻合わせしない) |
| 2026-07-21T00:00Z | SCHEMA_V2 | human | docs/MAPPING_SCHEMA.md | 対応表 v2 スキーマ制定。additive 拡張 (v1 7列→v2 18列)、evidence/protocol/confidence/observed_at/verified_at を導入。EVENTLOG 開始 |
| 2026-07-21T01:10Z | MIGRATE_V2 | migrate_map_v2.py@1.0.0 | data/builtin_to_air_map.v2.csv | v1 の 686 行から v2 を additive 生成。初期 confidence 分布: {'medium': 520, 'confirmed': 98, 'high': 68} |
| 2026-07-21T01:12Z | AUDIT | promote_map.py@1.0.0 | data/builtin_to_air_map.v2.csv | 再検算 686 行; 変動 0 行; 分布 {'medium': 1, 'confirmed': 1, 'high': 2} |
| 2026-07-21T01:12Z | APPLY_GOLDEN | promote_map.py@1.0.0 | /tmp/promote_selftest_2lgc5q7x/golden | manifest 1 件: 昇格 1, 不一致 0, 未回収 0 |
| 2026-07-21T01:12Z | SELFTEST | promote_map.py@1.0.0 | docs/samples/tracepoint.metal.air.ll | apply-golden 器の自己検証: OK (symbol=_Z24kernel_thread_tracepointPU11MTLconstantKjjDv3_j, builtin=__metal_all) |
| 2026-07-21T01:12Z | REPORT | promote_map.py@1.0.0 | data/promote_report.md | 686 行を集計 |
| 2026-07-21T01:17Z | CALLGRAPH | build_callgraph.py@1.0.0 | data/callgraph_edges.csv 他 | units=1778 unique=1764 edges=31134 air_impl=2 errors=0 |
| 2026-07-21T01:17Z | INGEST_CALLGRAPH | promote_map.py@1.0.0 | /home/user/metal-info-set/data/callgraph_edges.csv | 昇格 1 件 (recomputed_callgraph); 対応表に無い impl 565 件; 照合不一致 0 件 |
| 2026-07-21T01:18Z | RTLIB_LAYER | build_rtlib_layer.py@1.0.0 | /home/user/metal-info-set/data/rtlib_layer_map.csv | __air_impl_* 26 関数 → __metal 逆引き 25 件 (base 一致のみ)。未接続 1 件: ['__metal_convert_f_f64_f']… |
| 2026-07-21T01:19Z | RTLIB_BACKING | promote_map.py@1.0.0 | __metal_nextafter | observed_ir(air.nextafter.f16) -> rtlib_layer_backing(rtlib:__air_impl_nextafter); variants=24 |
| 2026-07-21T01:19Z | RTLIB_BACKING | promote_map.py@1.0.0 | __metal_os_log | recomputed_callgraph(air.os.log) -> rtlib_layer_backing(rtlib:__air_impl_os_log); variants=1 |
| 2026-07-21T01:19Z | APPLY_RTLIB_LAYER | promote_map.py@1.0.0 | /home/user/metal-info-set/data/rtlib_layer_map.csv | rtlib 層確定 1 件 + recomputed_callgraph から格上げ 1 件 (既適用 0) |
| 2026-07-21T01:20Z | CALLGRAPH | build_callgraph.py@1.0.0 | data/callgraph_edges.csv 他 | units=1778 unique=1764 edges=31134 air_impl=2 errors=0 |
| 2026-07-21T01:21Z | GEN_PROBE_SCENES | build_probe_scenes.py@1.0.0 | probe_scenes/ | セル 579 を 11 シーンに割当: auto=35 manual=544 (P01/P02 は PLAN テンプレ) |
| 2026-07-21T01:40Z | RENAME_HEADER | human+script | data/probe_cells.csv | ヘッダ名が実データと1列ズレていた事実を修正 (subject→air_candidate, air_candidate→used_via)。値行は無変更。発見経路: build_probe_scenes.py の生成結果検証 |
| 2026-07-21T01:22Z | GEN_PROBE_SCENES | build_probe_scenes.py@1.0.0 | probe_scenes/ | セル 579 を 11 シーンに割当: auto=35 manual=544 (P01/P02 は PLAN テンプレ) |
| 2026-07-21T01:22Z | AUDIT | promote_map.py@1.0.0 | data/builtin_to_air_map.v2.csv | 再検算 686 行; 変動 0 行; 分布 {'medium': 1, 'confirmed': 2, 'high': 2} |
| 2026-07-21T01:22Z | REPORT | promote_map.py@1.0.0 | data/promote_report.md | 686 行を集計 |
| 2026-07-21T01:26Z | AUDIT | promote_map.py@1.0.0 | data/builtin_to_air_map.v2.csv | 再検算 686 行; 変動 0 行; 分布 {'medium': 1, 'confirmed': 2, 'high': 2} |
| 2026-07-21T01:26Z | REPORT | promote_map.py@1.0.0 | data/promote_report.md | 686 行を集計 |
| 2026-07-21T01:50Z | SESSION_SUMMARY | human+scripts | metal-info-set/ | 器の建設完了: MAPPING_SCHEMA/EVENTLOG/promote_map/apply-golden selftest OK/build_callgraph(1,764 modules・31,134 edges・0 errors)/build_rtlib_layer(25接続)/build_probe_scenes(576セル被覆)・対応表 v2 は confirmed 99/high 68/medium 519・訂正2件(nextafter 偽候補→rtlib 層確定, probe_cells ヘッダズレ修正)。docs 4件整合。残留: golden 実機回収のみ |
| 2026-07-21T02:05Z | CLEANUP | human | metal-repo/msl_analysis/ | 虚偽情報の整理: msl_analysis/ (AI 生成・実証済誤り多発) を削除。虚偽内容の記録は metal-missing-info.md §1 と INFO_SET.md に残存 (根拠は残し文書のみ削除) |
| 2026-07-21T02:05Z | CLEANUP | human | metal-info-set/work/ | 再生成可能な中間物 (ir_all 展開 15MB・v1 frozen 重複) を削除。正本は data/ とスクリプト (dump_ir_all_os.py で再展開可能) |
| 2026-07-21T02:12Z | PUSH | human | github.com/kagurasumusun/metal@jules-2822063734237814689-7500b921 | 整理後一式を push (5ce83fb, fast-forward): metal-info-set/ 新設 + msl_analysis/ 削除 + README 整備。author は kagurasumusun <284823681+kagurasumusun@users.noreply.github.com> に統一 (既存履歴と一致)。push 用作業ツリー work_push/ は二重管理防止のため削除 |
| 2026-07-21T02:15Z | CLEANUP | human | /home/user 直下の散乱 | libLLVMContainer.tbd (GPUCompiler.framework tbd、コレクション未収録) を reference-external/gpucompiler-tbd/ へ移動 (全 10 件に)。metal-missing-info.md は docs/INITIAL_GAP_ANALYSIS.md へ移動済につき原本整理 |
