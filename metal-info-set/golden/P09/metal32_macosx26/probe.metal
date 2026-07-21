// scene P09: [[function_constant]] + パイプライン特殊化の IR/metadata 実体
// 生成: 2026-07-21 build_probe_scenes.py@1.0.0 (再生成可能: 一次入力 data/probe_cells.csv 他)
// 実機未検証: コンパイル可否は docs/PROBING_PLAN.md §1 の手順 (xcrun metal) で確認
#include <metal_stdlib>
using namespace metal;

// ==== TODO(manual_needed): __metal_is_uniform ====
//   candidate: air.is.uniform
//   stdlib 実呼出: metal_uniform:150: __builtin_assume(__metal_is_uniform(__v));
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p09_xxx 系で extern "C" 推奨)
