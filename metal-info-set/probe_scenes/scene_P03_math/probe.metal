// scene P03: 数学 builtin 代表: fast/precise 両 namespace, v 接尾辞, __METAL_FAST_MATH__ 解釈
// 生成: 2026-07-21 build_probe_scenes.py@1.0.0 (再生成可能: 一次入力 data/probe_cells.csv 他)
// 実機未検証: コンパイル可否は docs/PROBING_PLAN.md §1 の手順 (xcrun metal) で確認
#include <metal_stdlib>
using namespace metal;

// cell=__metal_divide candidate=air.divide
extern "C" float probe_p03_divide(float x, float y) { return metal::divide(x, y); }

// cell=__metal_fmax3 candidate=air.fmax3
extern "C" float probe_p03_fmax3(float x, float y, float z) { return metal::fmax3(x, y, z); }

// cell=__metal_fmedian3 candidate=air.fmedian3
extern "C" float probe_p03_fmedian3(float x, float y, float z) { return metal::fmedian3(x, y, z); }

// cell=__metal_fmin3 candidate=air.fmin3
extern "C" float probe_p03_fmin3(float x, float y, float z) { return metal::fmin3(x, y, z); }

// ==== TODO(manual_needed): __metal_frexp ====
//   candidate: air.frexp
//   stdlib 実呼出: metal_math:155: float frexp(float x, thread int &exp)
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p03_xxx 系で extern "C" 推奨)

// cell=__metal_ilogb candidate=air.ilogb
extern "C" int probe_p03_ilogb(float x) { return metal::ilogb(x); }

// cell=__metal_select candidate=air.select
extern "C" float probe_p03_fdim(float x, float y) { return metal::fdim(x, y); }
