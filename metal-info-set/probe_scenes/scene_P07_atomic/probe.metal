// scene P07: atomic 代表: 引数列, order/scope エンコード, addrspace 変種
// 生成: 2026-07-21 build_probe_scenes.py@1.0.0 (再生成可能: 一次入力 data/probe_cells.csv 他)
// 実機未検証: コンパイル可否は docs/PROBING_PLAN.md §1 の手順 (xcrun metal) で確認
#include <metal_stdlib>
using namespace metal;

// ==== TODO(manual_needed): __metal_atomic_compare_exchange_weak_explicit ====
//   candidate: air.atomic.compare.exchange.weak
//   stdlib 実呼出: metal_atomic:349: bool swapped = __metal_atomic_compare_exchange_weak_explicit(&object->__s, &next_expected, decltype(ob
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p07_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_exchange_explicit ====
//   candidate: air.atomic.exchange
//   stdlib 実呼出: metal_atomic:294: return T(__metal_atomic_exchange_explicit(&object->__s , decltype(object->__s)(desired), int(order), _
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p07_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_add_explicit ====
//   candidate: air.atomic.fetch.add
//   stdlib 実呼出: metal_atomic:497: return __metal_atomic_fetch_add_explicit(&object->__s, T(operand), int(order), __METAL_MEMORY_SCOPE_TH
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p07_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_and_explicit ====
//   candidate: air.atomic.fetch.and
//   stdlib 実呼出: metal_atomic:517: return __metal_atomic_fetch_and_explicit(&object->__s, T(operand), int(order), __METAL_MEMORY_SCOPE_TH
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p07_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_max_explicit ====
//   candidate: air.atomic.fetch.max
//   stdlib 実呼出: metal_atomic:537: return __metal_atomic_fetch_max_explicit(&object->__s, T(operand), int(order), __METAL_MEMORY_SCOPE_TH
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p07_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_min_explicit ====
//   candidate: air.atomic.fetch.min
//   stdlib 実呼出: metal_atomic:557: return __metal_atomic_fetch_min_explicit(&object->__s, T(operand), int(order), __METAL_MEMORY_SCOPE_TH
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p07_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_or_explicit ====
//   candidate: air.atomic.fetch.or
//   stdlib 実呼出: metal_atomic:577: return __metal_atomic_fetch_or_explicit(&object->__s, T(operand), int(order), __METAL_MEMORY_SCOPE_THR
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p07_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_sub_explicit ====
//   candidate: air.atomic.fetch.sub
//   stdlib 実呼出: metal_atomic:597: return __metal_atomic_fetch_sub_explicit(&object->__s, T(operand), int(order), __METAL_MEMORY_SCOPE_TH
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p07_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_xor_explicit ====
//   candidate: air.atomic.fetch.xor
//   stdlib 実呼出: metal_atomic:617: return __metal_atomic_fetch_xor_explicit(&object->__s, T(operand), int(order), __METAL_MEMORY_SCOPE_TH
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p07_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_load_explicit ====
//   candidate: air.atomic.load
//   stdlib 実呼出: metal_atomic:244: return T(__metal_atomic_load_explicit(&object->__s, int(order), __METAL_MEMORY_SCOPE_THREADGROUP__));
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p07_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_max_explicit ====
//   candidate: air.atomic.max
//   stdlib 実呼出: metal_atomic:656: __metal_atomic_max_explicit(&object->__s, T(operand), int(order), __METAL_MEMORY_SCOPE_DEVICE__);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p07_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_min_explicit ====
//   candidate: air.atomic.min
//   stdlib 実呼出: metal_atomic:680: __metal_atomic_min_explicit(&object->__s, T(operand), int(order), __METAL_MEMORY_SCOPE_DEVICE__);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p07_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_store_explicit ====
//   candidate: air.atomic.store
//   stdlib 実呼出: metal_atomic:194: __metal_atomic_store_explicit(&object->__s, decltype(object->__s)(desired), int(order), __METAL_MEMORY
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p07_xxx 系で extern "C" 推奨)
