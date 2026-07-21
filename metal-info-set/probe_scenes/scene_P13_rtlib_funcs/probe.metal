// scene P13: rtlib 使用関数: __air_impl_* 呼出の IR 形 (宣言参照か)
// 生成: 2026-07-21 build_probe_scenes.py@1.0.0 (再生成可能: 一次入力 data/probe_cells.csv 他)
// 実機未検証: コンパイル可否は docs/PROBING_PLAN.md §1 の手順 (xcrun metal) で確認
#include <metal_stdlib>
using namespace metal;

// ==== TODO(manual_needed): __metal_os_log ====
//   candidate: air.os.log
//   stdlib 実呼出: metal_logging:52: __metal_os_log(subsystem(), category(), int(type), format, args, METAL_VALIST_SIZE);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p13_xxx 系で extern "C" 推奨)
