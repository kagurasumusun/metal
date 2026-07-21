// scene P06: texture 代表: 不透明 IR 型, ch 型接尾辞, read/write/sample/query/fence
// 生成: 2026-07-21 build_probe_scenes.py@1.0.0 (再生成可能: 一次入力 data/probe_cells.csv 他)
// 実機未検証: コンパイル可否は docs/PROBING_PLAN.md §1 の手順 (xcrun metal) で確認
#include <metal_stdlib>
using namespace metal;

// ==== TODO(manual_needed): __metal_atomic_compare_exchange_weak_explicit_texture_1d_array_t ====
//   candidate: air.atomic_compare_exchange_weak_explicit_texture_1d_array
//   stdlib 実呼出: __bits/metal_texture1d_array:736: return __metal_atomic_compare_exchange_weak_explicit_texture_1d_array_t(derived.t, coo
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_compare_exchange_weak_explicit_texture_1d_t ====
//   candidate: air.atomic_compare_exchange_weak_explicit_texture_1d
//   stdlib 実呼出: __bits/metal_texture1d:736: return __metal_atomic_compare_exchange_weak_explicit_texture_1d_t(derived.t, coord, expected
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_compare_exchange_weak_explicit_texture_2d_array_t ====
//   candidate: air.atomic_compare_exchange_weak_explicit_texture_2d_array
//   stdlib 実呼出: __bits/metal_texture2d_array:1392: return __metal_atomic_compare_exchange_weak_explicit_texture_2d_array_t(derived.t, co
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_compare_exchange_weak_explicit_texture_2d_t ====
//   candidate: air.atomic_compare_exchange_weak_explicit_texture_2d
//   stdlib 実呼出: __bits/metal_texture2d:1404: return __metal_atomic_compare_exchange_weak_explicit_texture_2d_t(derived.t, coord, ushort2
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_compare_exchange_weak_explicit_texture_3d_t ====
//   candidate: air.atomic_compare_exchange_weak_explicit_texture_3d
//   stdlib 実呼出: __bits/metal_texture3d:1290: return __metal_atomic_compare_exchange_weak_explicit_texture_3d_t(derived.t, coord, ushort3
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_compare_exchange_weak_explicit_texture_buffer_1d_t ====
//   candidate: air.atomic_compare_exchange_weak_explicit_texture_buffer_1d
//   stdlib 実呼出: __bits/metal_texture_buffer:402: return __metal_atomic_compare_exchange_weak_explicit_texture_buffer_1d_t(derived.t, coo
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_compare_exchange_weak_explicit_texture_cube_array_t ====
//   candidate: air.atomic_compare_exchange_weak_explicit_texture_cube_array
//   stdlib 実呼出: __bits/metal_texturecube_array:1419: return __metal_atomic_compare_exchange_weak_explicit_texture_cube_array_t(derived.t
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_compare_exchange_weak_explicit_texture_cube_t ====
//   candidate: air.atomic_compare_exchange_weak_explicit_texture_cube
//   stdlib 実呼出: __bits/metal_texturecube:1422: return __metal_atomic_compare_exchange_weak_explicit_texture_cube_t(derived.t, coord, fac
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_exchange_explicit_texture_1d_array_t ====
//   candidate: air.atomic_exchange_explicit_texture_1d_array
//   stdlib 実呼出: __bits/metal_texture1d_array:816: return __metal_atomic_exchange_explicit_texture_1d_array_t(derived.t, coord, array, de
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_exchange_explicit_texture_1d_t ====
//   candidate: air.atomic_exchange_explicit_texture_1d
//   stdlib 実呼出: __bits/metal_texture1d:816: return __metal_atomic_exchange_explicit_texture_1d_t(derived.t, coord, desired, __METAL_MEMO
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_exchange_explicit_texture_2d_array_t ====
//   candidate: air.atomic_exchange_explicit_texture_2d_array
//   stdlib 実呼出: __bits/metal_texture2d_array:1472: return __metal_atomic_exchange_explicit_texture_2d_array_t(derived.t, coord, array, u
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_exchange_explicit_texture_2d_t ====
//   candidate: air.atomic_exchange_explicit_texture_2d
//   stdlib 実呼出: __bits/metal_texture2d:1484: return __metal_atomic_exchange_explicit_texture_2d_t(derived.t, coord, ushort2(0), desired,
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_exchange_explicit_texture_3d_t ====
//   candidate: air.atomic_exchange_explicit_texture_3d
//   stdlib 実呼出: __bits/metal_texture3d:1370: return __metal_atomic_exchange_explicit_texture_3d_t(derived.t, coord, ushort3(0), desired,
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_exchange_explicit_texture_buffer_1d_t ====
//   candidate: air.atomic_exchange_explicit_texture_buffer_1d
//   stdlib 実呼出: __bits/metal_texture_buffer:482: return __metal_atomic_exchange_explicit_texture_buffer_1d_t(derived.t, coord, desired, 
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_exchange_explicit_texture_cube_array_t ====
//   candidate: air.atomic_exchange_explicit_texture_cube_array
//   stdlib 実呼出: __bits/metal_texturecube_array:1499: return __metal_atomic_exchange_explicit_texture_cube_array_t(derived.t, coord, face
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_exchange_explicit_texture_cube_t ====
//   candidate: air.atomic_exchange_explicit_texture_cube
//   stdlib 実呼出: __bits/metal_texturecube:1502: return __metal_atomic_exchange_explicit_texture_cube_t(derived.t, coord, face, desired, _
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_add_explicit_texture_1d_array_t ====
//   candidate: air.atomic_fetch_add_explicit_texture_1d_array
//   stdlib 実呼出: __bits/metal_texture1d_array:1216: return __metal_atomic_fetch_add_explicit_texture_1d_array_t(derived.t, coord, array, 
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_add_explicit_texture_1d_t ====
//   candidate: air.atomic_fetch_add_explicit_texture_1d
//   stdlib 実呼出: __bits/metal_texture1d:1216: return __metal_atomic_fetch_add_explicit_texture_1d_t(derived.t, coord, operand, __METAL_ME
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_add_explicit_texture_2d_array_t ====
//   candidate: air.atomic_fetch_add_explicit_texture_2d_array
//   stdlib 実呼出: __bits/metal_texture2d_array:1872: return __metal_atomic_fetch_add_explicit_texture_2d_array_t(derived.t, coord, array, 
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_add_explicit_texture_2d_t ====
//   candidate: air.atomic_fetch_add_explicit_texture_2d
//   stdlib 実呼出: __bits/metal_texture2d:1884: return __metal_atomic_fetch_add_explicit_texture_2d_t(derived.t, coord, ushort2(0), operand
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_add_explicit_texture_3d_t ====
//   candidate: air.atomic_fetch_add_explicit_texture_3d
//   stdlib 実呼出: __bits/metal_texture3d:1770: return __metal_atomic_fetch_add_explicit_texture_3d_t(derived.t, coord, ushort3(0), operand
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_add_explicit_texture_buffer_1d_t ====
//   candidate: air.atomic_fetch_add_explicit_texture_buffer_1d
//   stdlib 実呼出: __bits/metal_texture_buffer:882: return __metal_atomic_fetch_add_explicit_texture_buffer_1d_t(derived.t, coord, operand,
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_add_explicit_texture_cube_array_t ====
//   candidate: air.atomic_fetch_add_explicit_texture_cube_array
//   stdlib 実呼出: __bits/metal_texturecube_array:1899: return __metal_atomic_fetch_add_explicit_texture_cube_array_t(derived.t, coord, fac
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_add_explicit_texture_cube_t ====
//   candidate: air.atomic_fetch_add_explicit_texture_cube
//   stdlib 実呼出: __bits/metal_texturecube:1902: return __metal_atomic_fetch_add_explicit_texture_cube_t(derived.t, coord, face, operand, 
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_and_explicit_texture_1d_array_t ====
//   candidate: air.atomic_fetch_and_explicit_texture_1d_array
//   stdlib 実呼出: __bits/metal_texture1d_array:896: return __metal_atomic_fetch_and_explicit_texture_1d_array_t(derived.t, coord, array, o
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_and_explicit_texture_1d_t ====
//   candidate: air.atomic_fetch_and_explicit_texture_1d
//   stdlib 実呼出: __bits/metal_texture1d:896: return __metal_atomic_fetch_and_explicit_texture_1d_t(derived.t, coord, operand, __METAL_MEM
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_and_explicit_texture_2d_array_t ====
//   candidate: air.atomic_fetch_and_explicit_texture_2d_array
//   stdlib 実呼出: __bits/metal_texture2d_array:1552: return __metal_atomic_fetch_and_explicit_texture_2d_array_t(derived.t, coord, array, 
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_and_explicit_texture_2d_t ====
//   candidate: air.atomic_fetch_and_explicit_texture_2d
//   stdlib 実呼出: __bits/metal_texture2d:1564: return __metal_atomic_fetch_and_explicit_texture_2d_t(derived.t, coord, ushort2(0), operand
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_and_explicit_texture_3d_t ====
//   candidate: air.atomic_fetch_and_explicit_texture_3d
//   stdlib 実呼出: __bits/metal_texture3d:1450: return __metal_atomic_fetch_and_explicit_texture_3d_t(derived.t, coord, ushort3(0), operand
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_and_explicit_texture_buffer_1d_t ====
//   candidate: air.atomic_fetch_and_explicit_texture_buffer_1d
//   stdlib 実呼出: __bits/metal_texture_buffer:562: return __metal_atomic_fetch_and_explicit_texture_buffer_1d_t(derived.t, coord, operand,
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_and_explicit_texture_cube_array_t ====
//   candidate: air.atomic_fetch_and_explicit_texture_cube_array
//   stdlib 実呼出: __bits/metal_texturecube_array:1579: return __metal_atomic_fetch_and_explicit_texture_cube_array_t(derived.t, coord, fac
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_and_explicit_texture_cube_t ====
//   candidate: air.atomic_fetch_and_explicit_texture_cube
//   stdlib 実呼出: __bits/metal_texturecube:1582: return __metal_atomic_fetch_and_explicit_texture_cube_t(derived.t, coord, face, operand, 
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_max_explicit_texture_1d_array_t ====
//   candidate: air.atomic_fetch_max_explicit_texture_1d_array
//   stdlib 実呼出: __bits/metal_texture1d_array:901: return __metal_atomic_fetch_max_explicit_texture_1d_array_t(derived.t, coord, array, o
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_max_explicit_texture_1d_t ====
//   candidate: air.atomic_fetch_max_explicit_texture_1d
//   stdlib 実呼出: __bits/metal_texture1d:901: return __metal_atomic_fetch_max_explicit_texture_1d_t(derived.t, coord, operand, __METAL_MEM
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_max_explicit_texture_2d_array_t ====
//   candidate: air.atomic_fetch_max_explicit_texture_2d_array
//   stdlib 実呼出: __bits/metal_texture2d_array:1562: return __metal_atomic_fetch_max_explicit_texture_2d_array_t(derived.t, coord, array, 
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_max_explicit_texture_2d_t ====
//   candidate: air.atomic_fetch_max_explicit_texture_2d
//   stdlib 実呼出: __bits/metal_texture2d:1574: return __metal_atomic_fetch_max_explicit_texture_2d_t(derived.t, coord, ushort2(0), operand
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_max_explicit_texture_3d_t ====
//   candidate: air.atomic_fetch_max_explicit_texture_3d
//   stdlib 実呼出: __bits/metal_texture3d:1460: return __metal_atomic_fetch_max_explicit_texture_3d_t(derived.t, coord, ushort3(0), operand
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_max_explicit_texture_buffer_1d_t ====
//   candidate: air.atomic_fetch_max_explicit_texture_buffer_1d
//   stdlib 実呼出: __bits/metal_texture_buffer:567: return __metal_atomic_fetch_max_explicit_texture_buffer_1d_t(derived.t, coord, operand,
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_max_explicit_texture_cube_array_t ====
//   candidate: air.atomic_fetch_max_explicit_texture_cube_array
//   stdlib 実呼出: __bits/metal_texturecube_array:1584: return __metal_atomic_fetch_max_explicit_texture_cube_array_t(derived.t, coord, fac
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_max_explicit_texture_cube_t ====
//   candidate: air.atomic_fetch_max_explicit_texture_cube
//   stdlib 実呼出: __bits/metal_texturecube:1587: return __metal_atomic_fetch_max_explicit_texture_cube_t(derived.t, coord, face, operand, 
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_min_explicit_texture_1d_array_t ====
//   candidate: air.atomic_fetch_min_explicit_texture_1d_array
//   stdlib 実呼出: __bits/metal_texture1d_array:906: return __metal_atomic_fetch_min_explicit_texture_1d_array_t(derived.t, coord, array, o
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_min_explicit_texture_1d_t ====
//   candidate: air.atomic_fetch_min_explicit_texture_1d
//   stdlib 実呼出: __bits/metal_texture1d:906: return __metal_atomic_fetch_min_explicit_texture_1d_t(derived.t, coord, operand, __METAL_MEM
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_min_explicit_texture_2d_array_t ====
//   candidate: air.atomic_fetch_min_explicit_texture_2d_array
//   stdlib 実呼出: __bits/metal_texture2d_array:1572: return __metal_atomic_fetch_min_explicit_texture_2d_array_t(derived.t, coord, array, 
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_min_explicit_texture_2d_t ====
//   candidate: air.atomic_fetch_min_explicit_texture_2d
//   stdlib 実呼出: __bits/metal_texture2d:1584: return __metal_atomic_fetch_min_explicit_texture_2d_t(derived.t, coord, ushort2(0), operand
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_min_explicit_texture_3d_t ====
//   candidate: air.atomic_fetch_min_explicit_texture_3d
//   stdlib 実呼出: __bits/metal_texture3d:1470: return __metal_atomic_fetch_min_explicit_texture_3d_t(derived.t, coord, ushort3(0), operand
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_min_explicit_texture_buffer_1d_t ====
//   candidate: air.atomic_fetch_min_explicit_texture_buffer_1d
//   stdlib 実呼出: __bits/metal_texture_buffer:572: return __metal_atomic_fetch_min_explicit_texture_buffer_1d_t(derived.t, coord, operand,
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_min_explicit_texture_cube_array_t ====
//   candidate: air.atomic_fetch_min_explicit_texture_cube_array
//   stdlib 実呼出: __bits/metal_texturecube_array:1589: return __metal_atomic_fetch_min_explicit_texture_cube_array_t(derived.t, coord, fac
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_min_explicit_texture_cube_t ====
//   candidate: air.atomic_fetch_min_explicit_texture_cube
//   stdlib 実呼出: __bits/metal_texturecube:1592: return __metal_atomic_fetch_min_explicit_texture_cube_t(derived.t, coord, face, operand, 
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_or_explicit_texture_1d_array_t ====
//   candidate: air.atomic_fetch_or_explicit_texture_1d_array
//   stdlib 実呼出: __bits/metal_texture1d_array:911: return __metal_atomic_fetch_or_explicit_texture_1d_array_t(derived.t, coord, array, op
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_or_explicit_texture_1d_t ====
//   candidate: air.atomic_fetch_or_explicit_texture_1d
//   stdlib 実呼出: __bits/metal_texture1d:911: return __metal_atomic_fetch_or_explicit_texture_1d_t(derived.t, coord, operand, __METAL_MEMO
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_or_explicit_texture_2d_array_t ====
//   candidate: air.atomic_fetch_or_explicit_texture_2d_array
//   stdlib 実呼出: __bits/metal_texture2d_array:1582: return __metal_atomic_fetch_or_explicit_texture_2d_array_t(derived.t, coord, array, u
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_or_explicit_texture_2d_t ====
//   candidate: air.atomic_fetch_or_explicit_texture_2d
//   stdlib 実呼出: __bits/metal_texture2d:1594: return __metal_atomic_fetch_or_explicit_texture_2d_t(derived.t, coord, ushort2(0), operand,
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_or_explicit_texture_3d_t ====
//   candidate: air.atomic_fetch_or_explicit_texture_3d
//   stdlib 実呼出: __bits/metal_texture3d:1480: return __metal_atomic_fetch_or_explicit_texture_3d_t(derived.t, coord, ushort3(0), operand,
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_or_explicit_texture_buffer_1d_t ====
//   candidate: air.atomic_fetch_or_explicit_texture_buffer_1d
//   stdlib 実呼出: __bits/metal_texture_buffer:577: return __metal_atomic_fetch_or_explicit_texture_buffer_1d_t(derived.t, coord, operand, 
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_or_explicit_texture_cube_array_t ====
//   candidate: air.atomic_fetch_or_explicit_texture_cube_array
//   stdlib 実呼出: __bits/metal_texturecube_array:1594: return __metal_atomic_fetch_or_explicit_texture_cube_array_t(derived.t, coord, face
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_or_explicit_texture_cube_t ====
//   candidate: air.atomic_fetch_or_explicit_texture_cube
//   stdlib 実呼出: __bits/metal_texturecube:1597: return __metal_atomic_fetch_or_explicit_texture_cube_t(derived.t, coord, face, operand, _
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_sub_explicit_texture_1d_array_t ====
//   candidate: air.atomic_fetch_sub_explicit_texture_1d_array
//   stdlib 実呼出: __bits/metal_texture1d_array:1221: return __metal_atomic_fetch_sub_explicit_texture_1d_array_t(derived.t, coord, array, 
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_sub_explicit_texture_1d_t ====
//   candidate: air.atomic_fetch_sub_explicit_texture_1d
//   stdlib 実呼出: __bits/metal_texture1d:1221: return __metal_atomic_fetch_sub_explicit_texture_1d_t(derived.t, coord, operand, __METAL_ME
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_sub_explicit_texture_2d_array_t ====
//   candidate: air.atomic_fetch_sub_explicit_texture_2d_array
//   stdlib 実呼出: __bits/metal_texture2d_array:1882: return __metal_atomic_fetch_sub_explicit_texture_2d_array_t(derived.t, coord, array, 
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_sub_explicit_texture_2d_t ====
//   candidate: air.atomic_fetch_sub_explicit_texture_2d
//   stdlib 実呼出: __bits/metal_texture2d:1894: return __metal_atomic_fetch_sub_explicit_texture_2d_t(derived.t, coord, ushort2(0), operand
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_sub_explicit_texture_3d_t ====
//   candidate: air.atomic_fetch_sub_explicit_texture_3d
//   stdlib 実呼出: __bits/metal_texture3d:1780: return __metal_atomic_fetch_sub_explicit_texture_3d_t(derived.t, coord, ushort3(0), operand
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_sub_explicit_texture_buffer_1d_t ====
//   candidate: air.atomic_fetch_sub_explicit_texture_buffer_1d
//   stdlib 実呼出: __bits/metal_texture_buffer:887: return __metal_atomic_fetch_sub_explicit_texture_buffer_1d_t(derived.t, coord, operand,
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_sub_explicit_texture_cube_array_t ====
//   candidate: air.atomic_fetch_sub_explicit_texture_cube_array
//   stdlib 実呼出: __bits/metal_texturecube_array:1904: return __metal_atomic_fetch_sub_explicit_texture_cube_array_t(derived.t, coord, fac
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_sub_explicit_texture_cube_t ====
//   candidate: air.atomic_fetch_sub_explicit_texture_cube
//   stdlib 実呼出: __bits/metal_texturecube:1907: return __metal_atomic_fetch_sub_explicit_texture_cube_t(derived.t, coord, face, operand, 
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_xor_explicit_texture_1d_array_t ====
//   candidate: air.atomic_fetch_xor_explicit_texture_1d_array
//   stdlib 実呼出: __bits/metal_texture1d_array:916: return __metal_atomic_fetch_xor_explicit_texture_1d_array_t(derived.t, coord, array, o
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_xor_explicit_texture_1d_t ====
//   candidate: air.atomic_fetch_xor_explicit_texture_1d
//   stdlib 実呼出: __bits/metal_texture1d:916: return __metal_atomic_fetch_xor_explicit_texture_1d_t(derived.t, coord, operand, __METAL_MEM
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_xor_explicit_texture_2d_array_t ====
//   candidate: air.atomic_fetch_xor_explicit_texture_2d_array
//   stdlib 実呼出: __bits/metal_texture2d_array:1592: return __metal_atomic_fetch_xor_explicit_texture_2d_array_t(derived.t, coord, array, 
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_xor_explicit_texture_2d_t ====
//   candidate: air.atomic_fetch_xor_explicit_texture_2d
//   stdlib 実呼出: __bits/metal_texture2d:1604: return __metal_atomic_fetch_xor_explicit_texture_2d_t(derived.t, coord, ushort2(0), operand
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_xor_explicit_texture_3d_t ====
//   candidate: air.atomic_fetch_xor_explicit_texture_3d
//   stdlib 実呼出: __bits/metal_texture3d:1490: return __metal_atomic_fetch_xor_explicit_texture_3d_t(derived.t, coord, ushort3(0), operand
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_xor_explicit_texture_buffer_1d_t ====
//   candidate: air.atomic_fetch_xor_explicit_texture_buffer_1d
//   stdlib 実呼出: __bits/metal_texture_buffer:582: return __metal_atomic_fetch_xor_explicit_texture_buffer_1d_t(derived.t, coord, operand,
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_xor_explicit_texture_cube_array_t ====
//   candidate: air.atomic_fetch_xor_explicit_texture_cube_array
//   stdlib 実呼出: __bits/metal_texturecube_array:1599: return __metal_atomic_fetch_xor_explicit_texture_cube_array_t(derived.t, coord, fac
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_fetch_xor_explicit_texture_cube_t ====
//   candidate: air.atomic_fetch_xor_explicit_texture_cube
//   stdlib 実呼出: __bits/metal_texturecube:1602: return __metal_atomic_fetch_xor_explicit_texture_cube_t(derived.t, coord, face, operand, 
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_load_explicit_texture_1d_array_t ====
//   candidate: air.atomic_load_explicit_texture_1d_array
//   stdlib 実呼出: __bits/metal_texture1d_array:576: return __metal_atomic_load_explicit_texture_1d_array_t(derived.t, coord, array, __META
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_load_explicit_texture_1d_t ====
//   candidate: air.atomic_load_explicit_texture_1d
//   stdlib 実呼出: __bits/metal_texture1d:576: return __metal_atomic_load_explicit_texture_1d_t(derived.t, coord, __METAL_MEMORY_ORDER_RELA
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_load_explicit_texture_2d_array_t ====
//   candidate: air.atomic_load_explicit_texture_2d_array
//   stdlib 実呼出: __bits/metal_texture2d_array:1232: return __metal_atomic_load_explicit_texture_2d_array_t(derived.t, coord, array, ushor
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_load_explicit_texture_2d_t ====
//   candidate: air.atomic_load_explicit_texture_2d
//   stdlib 実呼出: __bits/metal_texture2d:1244: return __metal_atomic_load_explicit_texture_2d_t(derived.t, coord, ushort2(0), __METAL_MEMO
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_load_explicit_texture_3d_t ====
//   candidate: air.atomic_load_explicit_texture_3d
//   stdlib 実呼出: __bits/metal_texture3d:1130: return __metal_atomic_load_explicit_texture_3d_t(derived.t, coord, ushort3(0), __METAL_MEMO
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_load_explicit_texture_buffer_1d_t ====
//   candidate: air.atomic_load_explicit_texture_buffer_1d
//   stdlib 実呼出: __bits/metal_texture_buffer:242: return __metal_atomic_load_explicit_texture_buffer_1d_t(derived.t, coord, __METAL_MEMOR
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_load_explicit_texture_cube_array_t ====
//   candidate: air.atomic_load_explicit_texture_cube_array
//   stdlib 実呼出: __bits/metal_texturecube_array:1259: return __metal_atomic_load_explicit_texture_cube_array_t(derived.t, coord, face, ar
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_load_explicit_texture_cube_t ====
//   candidate: air.atomic_load_explicit_texture_cube
//   stdlib 実呼出: __bits/metal_texturecube:1262: return __metal_atomic_load_explicit_texture_cube_t(derived.t, coord, face, __METAL_MEMORY
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_max_explicit_texture_1d_array_t ====
//   candidate: air.atomic_max_explicit_texture_1d_array
//   stdlib 実呼出: __bits/metal_texture1d_array:1356: __metal_atomic_max_explicit_texture_1d_array_t(derived.t, coord, array, operand, __ME
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_max_explicit_texture_1d_t ====
//   candidate: air.atomic_max_explicit_texture_1d
//   stdlib 実呼出: __bits/metal_texture1d:1356: __metal_atomic_max_explicit_texture_1d_t(derived.t, coord, operand, __METAL_MEMORY_ORDER_RE
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_max_explicit_texture_2d_array_t ====
//   candidate: air.atomic_max_explicit_texture_2d_array
//   stdlib 実呼出: __bits/metal_texture2d_array:2012: __metal_atomic_max_explicit_texture_2d_array_t(derived.t, coord, array, ushort2(0), o
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_max_explicit_texture_2d_t ====
//   candidate: air.atomic_max_explicit_texture_2d
//   stdlib 実呼出: __bits/metal_texture2d:2022: __metal_atomic_max_explicit_texture_2d_t(derived.t, coord, ushort2(0), operand, __METAL_MEM
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_max_explicit_texture_3d_t ====
//   candidate: air.atomic_max_explicit_texture_3d
//   stdlib 実呼出: __bits/metal_texture3d:1910: __metal_atomic_max_explicit_texture_3d_t(derived.t, coord, ushort3(0), operand, __METAL_MEM
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_max_explicit_texture_buffer_1d_t ====
//   candidate: air.atomic_max_explicit_texture_buffer_1d
//   stdlib 実呼出: __bits/metal_texture_buffer:1022: __metal_atomic_max_explicit_texture_buffer_1d_t(derived.t, coord, operand, __METAL_MEM
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_max_explicit_texture_cube_array_t ====
//   candidate: air.atomic_max_explicit_texture_cube_array
//   stdlib 実呼出: __bits/metal_texturecube_array:2031: __metal_atomic_max_explicit_texture_cube_array_t(derived.t, coord, face, array, ope
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_max_explicit_texture_cube_t ====
//   candidate: air.atomic_max_explicit_texture_cube
//   stdlib 実呼出: __bits/metal_texturecube:2041: __metal_atomic_max_explicit_texture_cube_t(derived.t, coord, face, operand, __METAL_MEMOR
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_min_explicit_texture_1d_array_t ====
//   candidate: air.atomic_min_explicit_texture_1d_array
//   stdlib 実呼出: __bits/metal_texture1d_array:1361: __metal_atomic_min_explicit_texture_1d_array_t(derived.t, coord, array, operand, __ME
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_min_explicit_texture_1d_t ====
//   candidate: air.atomic_min_explicit_texture_1d
//   stdlib 実呼出: __bits/metal_texture1d:1361: __metal_atomic_min_explicit_texture_1d_t(derived.t, coord, operand, __METAL_MEMORY_ORDER_RE
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_min_explicit_texture_2d_array_t ====
//   candidate: air.atomic_min_explicit_texture_2d_array
//   stdlib 実呼出: __bits/metal_texture2d_array:2022: __metal_atomic_min_explicit_texture_2d_array_t(derived.t, coord, array, ushort2(0), o
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_min_explicit_texture_2d_t ====
//   candidate: air.atomic_min_explicit_texture_2d
//   stdlib 実呼出: __bits/metal_texture2d:2032: __metal_atomic_min_explicit_texture_2d_t(derived.t, coord, ushort2(0), operand, __METAL_MEM
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_min_explicit_texture_3d_t ====
//   candidate: air.atomic_min_explicit_texture_3d
//   stdlib 実呼出: __bits/metal_texture3d:1920: __metal_atomic_min_explicit_texture_3d_t(derived.t, coord, ushort3(0), operand, __METAL_MEM
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_min_explicit_texture_buffer_1d_t ====
//   candidate: air.atomic_min_explicit_texture_buffer_1d
//   stdlib 実呼出: __bits/metal_texture_buffer:1027: __metal_atomic_min_explicit_texture_buffer_1d_t(derived.t, coord, operand, __METAL_MEM
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_min_explicit_texture_cube_array_t ====
//   candidate: air.atomic_min_explicit_texture_cube_array
//   stdlib 実呼出: __bits/metal_texturecube_array:2036: __metal_atomic_min_explicit_texture_cube_array_t(derived.t, coord, face, array, ope
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_min_explicit_texture_cube_t ====
//   candidate: air.atomic_min_explicit_texture_cube
//   stdlib 実呼出: __bits/metal_texturecube:2046: __metal_atomic_min_explicit_texture_cube_t(derived.t, coord, face, operand, __METAL_MEMOR
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_store_explicit_texture_1d_array_t ====
//   candidate: air.atomic_store_explicit_texture_1d_array
//   stdlib 実呼出: __bits/metal_texture1d_array:656: __metal_atomic_store_explicit_texture_1d_array_t(derived.t, color, coord, array, __MET
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_store_explicit_texture_1d_t ====
//   candidate: air.atomic_store_explicit_texture_1d
//   stdlib 実呼出: __bits/metal_texture1d:656: __metal_atomic_store_explicit_texture_1d_t(derived.t, color, coord, __METAL_MEMORY_ORDER_REL
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_store_explicit_texture_2d_array_t ====
//   candidate: air.atomic_store_explicit_texture_2d_array
//   stdlib 実呼出: __bits/metal_texture2d_array:1312: __metal_atomic_store_explicit_texture_2d_array_t(derived.t, color, coord, array, usho
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_store_explicit_texture_2d_t ====
//   candidate: air.atomic_store_explicit_texture_2d
//   stdlib 実呼出: __bits/metal_texture2d:1324: __metal_atomic_store_explicit_texture_2d_t(derived.t, color, coord, ushort2(0), __METAL_MEM
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_store_explicit_texture_3d_t ====
//   candidate: air.atomic_store_explicit_texture_3d
//   stdlib 実呼出: __bits/metal_texture3d:1210: __metal_atomic_store_explicit_texture_3d_t(derived.t, color, coord, ushort3(0), __METAL_MEM
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_store_explicit_texture_buffer_1d_t ====
//   candidate: air.atomic_store_explicit_texture_buffer_1d
//   stdlib 実呼出: __bits/metal_texture_buffer:322: __metal_atomic_store_explicit_texture_buffer_1d_t(derived.t, color, coord, __METAL_MEMO
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_store_explicit_texture_cube_array_t ====
//   candidate: air.atomic_store_explicit_texture_cube_array
//   stdlib 実呼出: __bits/metal_texturecube_array:1339: __metal_atomic_store_explicit_texture_cube_array_t(derived.t, color, coord, face, a
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_atomic_store_explicit_texture_cube_t ====
//   candidate: air.atomic_store_explicit_texture_cube
//   stdlib 実呼出: __bits/metal_texturecube:1342: __metal_atomic_store_explicit_texture_cube_t(derived.t, color, coord, face, __METAL_MEMOR
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_calculate_clamped_lod_depth_2d_array_t ====
//   candidate: air.calculate.clamped.lod.depth.2d.array.t
//   stdlib 実呼出: __bits/metal_depth2d_array:135: return __metal_calculate_clamped_lod_depth_2d_array_t(derived.t, s.val, coord, int(a));
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_calculate_clamped_lod_depth_2d_t ====
//   candidate: air.calculate.clamped.lod.depth.2d.t
//   stdlib 実呼出: __bits/metal_depth2d:135: return __metal_calculate_clamped_lod_depth_2d_t(derived.t, s.val, coord, int(a));
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_calculate_clamped_lod_depth_cube_array_t ====
//   candidate: air.calculate.clamped.lod.depth.cube.array.t
//   stdlib 実呼出: __bits/metal_depthcube_array:136: return __metal_calculate_clamped_lod_depth_cube_array_t(derived.t, s.val, coord, int(a
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_calculate_clamped_lod_depth_cube_t ====
//   candidate: air.calculate.clamped.lod.depth.cube.t
//   stdlib 実呼出: __bits/metal_depthcube:135: return __metal_calculate_clamped_lod_depth_cube_t(derived.t, s.val, coord, int(a));
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_calculate_clamped_lod_texture_2d_array_t ====
//   candidate: air.calculate_clamped_lod_texture_2d_array
//   stdlib 実呼出: __bits/metal_texture2d_array:140: return __metal_calculate_clamped_lod_texture_2d_array_t(derived.t, s.val, coord, int(a
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_calculate_clamped_lod_texture_2d_t ====
//   candidate: air.calculate_clamped_lod_texture_2d
//   stdlib 実呼出: __bits/metal_texture2d:142: return __metal_calculate_clamped_lod_texture_2d_t(derived.t, s.val, coord, int(a));
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_calculate_clamped_lod_texture_3d_t ====
//   candidate: air.calculate_clamped_lod_texture_3d
//   stdlib 実呼出: __bits/metal_texture3d:142: return __metal_calculate_clamped_lod_texture_3d_t(derived.t, s.val, coord, int(a));
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_calculate_clamped_lod_texture_cube_array_t ====
//   candidate: air.calculate_clamped_lod_texture_cube_array
//   stdlib 実呼出: __bits/metal_texturecube_array:143: return __metal_calculate_clamped_lod_texture_cube_array_t(derived.t, s.val, coord, i
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_calculate_clamped_lod_texture_cube_t ====
//   candidate: air.calculate_clamped_lod_texture_cube
//   stdlib 実呼出: __bits/metal_texturecube:142: return __metal_calculate_clamped_lod_texture_cube_t(derived.t, s.val, coord, int(a));
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_calculate_unclamped_lod_depth_2d_array_t ====
//   candidate: air.calculate.unclamped.lod.depth.2d.array.t
//   stdlib 実呼出: __bits/metal_depth2d_array:140: return __metal_calculate_unclamped_lod_depth_2d_array_t(derived.t, s.val, coord, int(a))
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_calculate_unclamped_lod_depth_2d_t ====
//   candidate: air.calculate.unclamped.lod.depth.2d.t
//   stdlib 実呼出: __bits/metal_depth2d:140: return __metal_calculate_unclamped_lod_depth_2d_t(derived.t, s.val, coord, int(a));
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_calculate_unclamped_lod_depth_cube_array_t ====
//   candidate: air.calculate.unclamped.lod.depth.cube.array.t
//   stdlib 実呼出: __bits/metal_depthcube_array:141: return __metal_calculate_unclamped_lod_depth_cube_array_t(derived.t, s.val, coord, int
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_calculate_unclamped_lod_depth_cube_t ====
//   candidate: air.calculate.unclamped.lod.depth.cube.t
//   stdlib 実呼出: __bits/metal_depthcube:140: return __metal_calculate_unclamped_lod_depth_cube_t(derived.t, s.val, coord, int(a));
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_calculate_unclamped_lod_texture_2d_array_t ====
//   candidate: air.calculate_unclamped_lod_texture_2d_array
//   stdlib 実呼出: __bits/metal_texture2d_array:145: return __metal_calculate_unclamped_lod_texture_2d_array_t(derived.t, s.val, coord, int
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_calculate_unclamped_lod_texture_2d_t ====
//   candidate: air.calculate_unclamped_lod_texture_2d
//   stdlib 実呼出: __bits/metal_texture2d:147: return __metal_calculate_unclamped_lod_texture_2d_t(derived.t, s.val, coord, int(a));
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_calculate_unclamped_lod_texture_3d_t ====
//   candidate: air.calculate_unclamped_lod_texture_3d
//   stdlib 実呼出: __bits/metal_texture3d:147: return __metal_calculate_unclamped_lod_texture_3d_t(derived.t, s.val, coord, int(a));
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_calculate_unclamped_lod_texture_cube_array_t ====
//   candidate: air.calculate_unclamped_lod_texture_cube_array
//   stdlib 実呼出: __bits/metal_texturecube_array:148: return __metal_calculate_unclamped_lod_texture_cube_array_t(derived.t, s.val, coord,
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_calculate_unclamped_lod_texture_cube_t ====
//   candidate: air.calculate_unclamped_lod_texture_cube
//   stdlib 実呼出: __bits/metal_texturecube:147: return __metal_calculate_unclamped_lod_texture_cube_t(derived.t, s.val, coord, int(a));
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_depth_2d_array_t ====
//   candidate: air.depth.2d.array.t
//   stdlib 実呼出: __bits/metal_depth2d_array:2187: __metal_depth_2d_array_t t;
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_depth_2d_ms_array_t ====
//   candidate: air.depth.2d.ms.array.t
//   stdlib 実呼出: __bits/metal_depth2d_ms_array:651: __metal_depth_2d_ms_array_t t;
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_depth_2d_ms_t ====
//   candidate: air.depth.2d.ms.t
//   stdlib 実呼出: __bits/metal_depth2d_ms:620: __metal_depth_2d_ms_t t;
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_depth_2d_t ====
//   candidate: air.depth.2d.t
//   stdlib 実呼出: __bits/metal_depth2d:2157: __metal_depth_2d_t t;
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_depth_cube_array_t ====
//   candidate: air.depth.cube.array.t
//   stdlib 実呼出: __bits/metal_depthcube_array:2176: __metal_depth_cube_array_t t;
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_depth_cube_t ====
//   candidate: air.depth.cube.t
//   stdlib 実呼出: __bits/metal_depthcube:2159: __metal_depth_cube_t t;
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_dfdx ====
//   candidate: air.dfdx
//   stdlib 実呼出: metal_graphics:17: return __metal_dfdx(p);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_dfdy ====
//   candidate: air.dfdy
//   stdlib 実呼出: metal_graphics:21: return __metal_dfdy(p);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_discard_fragment ====
//   candidate: air.discard.fragment
//   stdlib 実呼出: metal_graphics:184: __metal_discard_fragment();
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_fwidth ====
//   candidate: air.fwidth
//   stdlib 実呼出: metal_graphics:25: return __metal_fwidth(p);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_gather_compare_depth_2d_array_t ====
//   candidate: air.gather.compare.depth.2d.array.t
//   stdlib 実呼出: __bits/metal_depth2d_array:1670: return __metal_gather_compare_depth_2d_array_t(derived.t, s.val, coord, array, compare_
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_gather_compare_depth_2d_t ====
//   candidate: air.gather.compare.depth.2d.t
//   stdlib 実呼出: __bits/metal_depth2d:1670: return __metal_gather_compare_depth_2d_t(derived.t, s.val, coord, compare_value, true, offset
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_gather_compare_depth_cube_array_t ====
//   candidate: air.gather.compare.depth.cube.array.t
//   stdlib 実呼出: __bits/metal_depthcube_array:1659: return __metal_gather_compare_depth_cube_array_t(derived.t, s.val, coord, array, comp
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_gather_compare_depth_cube_t ====
//   candidate: air.gather.compare.depth.cube.t
//   stdlib 実呼出: __bits/metal_depthcube:1672: return __metal_gather_compare_depth_cube_t(derived.t, s.val, coord, compare_value, int(a), 
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_gather_depth_2d_array_t ====
//   candidate: air.gather.depth.2d.array.t
//   stdlib 実呼出: __bits/metal_depth2d_array:1571: return __metal_gather_depth_2d_array_t(derived.t, s.val, coord, array, true, offset, in
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_gather_depth_2d_t ====
//   candidate: air.gather.depth.2d.t
//   stdlib 実呼出: __bits/metal_depth2d:1571: return __metal_gather_depth_2d_t(derived.t, s.val, coord, true, offset, int(a), static_cast<t
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_gather_depth_cube_array_t ====
//   candidate: air.gather.depth.cube.array.t
//   stdlib 実呼出: __bits/metal_depthcube_array:1560: return __metal_gather_depth_cube_array_t(derived.t, s.val, coord, array, int(a), stat
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_gather_depth_cube_t ====
//   candidate: air.gather.depth.cube.t
//   stdlib 実呼出: __bits/metal_depthcube:1573: return __metal_gather_depth_cube_t(derived.t, s.val, coord, int(a), static_cast<thread bool
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_array_size_depth_2d_array_t ====
//   candidate: air.get.array.size.depth.2d.array.t
//   stdlib 実呼出: __bits/metal_depth2d_array:1807: return __metal_get_array_size_depth_2d_array_t(derived.t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_array_size_depth_2d_ms_array_t ====
//   candidate: air.get.array.size.depth.2d.ms.array.t
//   stdlib 実呼出: __bits/metal_depth2d_ms_array:271: return __metal_get_array_size_depth_2d_ms_array_t(derived.t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_array_size_depth_cube_array_t ====
//   candidate: air.get.array.size.depth.cube.array.t
//   stdlib 実呼出: __bits/metal_depthcube_array:1796: return __metal_get_array_size_depth_cube_array_t(derived.t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_array_size_texture_cube_array_t ====
//   candidate: air.get_array_size_texture_cube_array
//   stdlib 実呼出: __bits/metal_texturecube_array:2250: return __metal_get_array_size_texture_cube_array_t(derived.t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_control_point ====
//   candidate: air.get.control.point
//   stdlib 実呼出: metal_tessellation:36: return __metal_get_control_point(pcp, static_cast<uint>(pos), T());
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_height_depth_2d_array_t ====
//   candidate: air.get.height.depth.2d.array.t
//   stdlib 実呼出: __bits/metal_depth2d_array:1802: return __metal_get_height_depth_2d_array_t(derived.t, lod);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_height_depth_2d_ms_array_t ====
//   candidate: air.get.height.depth.2d.ms.array.t
//   stdlib 実呼出: __bits/metal_depth2d_ms_array:266: return __metal_get_height_depth_2d_ms_array_t(derived.t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_height_depth_2d_ms_t ====
//   candidate: air.get.height.depth.2d.ms.t
//   stdlib 実呼出: __bits/metal_depth2d_ms:265: return __metal_get_height_depth_2d_ms_t(derived.t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_height_depth_2d_t ====
//   candidate: air.get.height.depth.2d.t
//   stdlib 実呼出: __bits/metal_depth2d:1802: return __metal_get_height_depth_2d_t(derived.t, lod);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_height_depth_cube_array_t ====
//   candidate: air.get.height.depth.cube.array.t
//   stdlib 実呼出: __bits/metal_depthcube_array:1791: return __metal_get_height_depth_cube_array_t(derived.t, lod);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_height_depth_cube_t ====
//   candidate: air.get.height.depth.cube.t
//   stdlib 実呼出: __bits/metal_depthcube:1804: return __metal_get_height_depth_cube_t(derived.t, lod);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_height_texture_cube_array_t ====
//   candidate: air.get_height_texture_cube_array
//   stdlib 実呼出: __bits/metal_texturecube_array:2245: return __metal_get_height_texture_cube_array_t(derived.t, lod);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_height_texture_cube_t ====
//   candidate: air.get_height_texture_cube
//   stdlib 実呼出: __bits/metal_texturecube:2255: return __metal_get_height_texture_cube_t(derived.t, lod);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_imageblock_color_coverage_mask ====
//   candidate: air.get.imageblock.color.coverage.mask
//   stdlib 実呼出: metal_imageblocks:169: return __metal_get_imageblock_color_coverage_mask(_imgblock, coord, color_index);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_imageblock_height ====
//   candidate: air.get.imageblock.height
//   stdlib 実呼出: metal_imageblocks:154: return __metal_get_imageblock_height(_imgblock);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_imageblock_num_colors ====
//   candidate: air.get.imageblock.num.colors
//   stdlib 実呼出: metal_imageblocks:164: return __metal_get_imageblock_num_colors(_imgblock, coord);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_imageblock_samples ====
//   candidate: air.get.imageblock.samples
//   stdlib 実呼出: metal_imageblocks:159: return __metal_get_imageblock_samples(_imgblock);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_imageblock_width ====
//   candidate: air.get.imageblock.width
//   stdlib 実呼出: metal_imageblocks:149: return __metal_get_imageblock_width(_imgblock);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_null_depth_2d_array_t ====
//   candidate: air.get.null.depth.2d.array.t
//   stdlib 実呼出: __bits/metal_depth2d_array:2221: METAL_FUNC depth2d_array() thread  : t(__metal_get_null_depth_2d_array_t()) {}
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_null_depth_2d_ms_array_t ====
//   candidate: air.get.null.depth.2d.ms.array.t
//   stdlib 実呼出: __bits/metal_depth2d_ms_array:681: METAL_FUNC depth2d_ms_array() thread : t(__metal_get_null_depth_2d_ms_array_t()) {}
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_null_depth_2d_ms_t ====
//   candidate: air.get.null.depth.2d.ms.t
//   stdlib 実呼出: __bits/metal_depth2d_ms:650: METAL_FUNC depth2d_ms() thread : t(__metal_get_null_depth_2d_ms_t()) {}
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_null_depth_2d_t ====
//   candidate: air.get.null.depth.2d.t
//   stdlib 実呼出: __bits/metal_depth2d:2191: METAL_FUNC depth2d() thread : t(__metal_get_null_depth_2d_t()) {}
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_null_depth_cube_array_t ====
//   candidate: air.get.null.depth.cube.array.t
//   stdlib 実呼出: __bits/metal_depthcube_array:2210: METAL_FUNC depthcube_array() thread : t(__metal_get_null_depth_cube_array_t()) {}
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_null_depth_cube_t ====
//   candidate: air.get.null.depth.cube.t
//   stdlib 実呼出: __bits/metal_depthcube:2193: METAL_FUNC depthcube() thread : t(__metal_get_null_depth_cube_t()) {}
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_null_texture_1d_array_t ====
//   candidate: air.get_null_texture_1d_array
//   stdlib 実呼出: __bits/metal_texture1d_array:1972: METAL_FUNC texture1d_array() thread : t(__metal_get_null_texture_1d_array_t()) {}
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_null_texture_1d_t ====
//   candidate: air.get_null_texture_1d
//   stdlib 実呼出: __bits/metal_texture1d:1940: METAL_FUNC texture1d() thread : t(__metal_get_null_texture_1d_t()) {}
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_null_texture_2d_array_t ====
//   candidate: air.get_null_texture_2d_array
//   stdlib 実呼出: __bits/metal_texture2d_array:2661: METAL_FUNC texture2d_array() thread : t(__metal_get_null_texture_2d_array_t()) {}
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_null_texture_2d_ms_array_t ====
//   candidate: air.get_null_texture_2d_ms_array
//   stdlib 実呼出: __bits/metal_texture2d_ms_array:688: METAL_FUNC texture2d_ms_array() thread : t(__metal_get_null_texture_2d_ms_array_t()
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_null_texture_2d_ms_t ====
//   candidate: air.get_null_texture_2d_ms
//   stdlib 実呼出: __bits/metal_texture2d_ms:657: METAL_FUNC texture2d_ms() thread : t(__metal_get_null_texture_2d_ms_t()) {}
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_null_texture_2d_t ====
//   candidate: air.get_null_texture_2d
//   stdlib 実呼出: __bits/metal_texture2d:2641: METAL_FUNC texture2d() thread : t(__metal_get_null_texture_2d_t()) {}
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_null_texture_3d_t ====
//   candidate: air.get_null_texture_3d
//   stdlib 実呼出: __bits/metal_texture3d:2555: METAL_FUNC texture3d() thread : t(__metal_get_null_texture_3d_t()) {}
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_null_texture_buffer_1d_t ====
//   candidate: air.get_null_texture_buffer_1d
//   stdlib 実呼出: __bits/metal_texture_buffer:1575: METAL_FUNC texture_buffer() thread : t(__metal_get_null_texture_buffer_1d_t()) {}
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_null_texture_cube_array_t ====
//   candidate: air.get_null_texture_cube_array
//   stdlib 実呼出: __bits/metal_texturecube_array:2682: METAL_FUNC texturecube_array() thread : t(__metal_get_null_texture_cube_array_t()) 
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_null_texture_cube_t ====
//   candidate: air.get_null_texture_cube
//   stdlib 実呼出: __bits/metal_texturecube:2662: METAL_FUNC texturecube() thread : t(__metal_get_null_texture_cube_t()) {}
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_num_mip_levels_depth_2d_array_t ====
//   candidate: air.get.num.mip.levels.depth.2d.array.t
//   stdlib 実呼出: __bits/metal_depth2d_array:1812: return __metal_get_num_mip_levels_depth_2d_array_t(derived.t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_num_mip_levels_depth_2d_t ====
//   candidate: air.get.num.mip.levels.depth.2d.t
//   stdlib 実呼出: __bits/metal_depth2d:1807: return __metal_get_num_mip_levels_depth_2d_t(derived.t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_num_mip_levels_depth_cube_array_t ====
//   candidate: air.get.num.mip.levels.depth.cube.array.t
//   stdlib 実呼出: __bits/metal_depthcube_array:1801: return __metal_get_num_mip_levels_depth_cube_array_t(derived.t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_num_mip_levels_depth_cube_t ====
//   candidate: air.get.num.mip.levels.depth.cube.t
//   stdlib 実呼出: __bits/metal_depthcube:1809: return __metal_get_num_mip_levels_depth_cube_t(derived.t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_num_mip_levels_texture_1d_array_t ====
//   candidate: air.get_num_mip_levels_texture_1d_array
//   stdlib 実呼出: __bits/metal_texture1d_array:1574: return __metal_get_num_mip_levels_texture_1d_array_t(derived.t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_num_mip_levels_texture_1d_t ====
//   candidate: air.get_num_mip_levels_texture_1d
//   stdlib 実呼出: __bits/metal_texture1d:1567: return __metal_get_num_mip_levels_texture_1d_t(derived.t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_num_mip_levels_texture_2d_array_t ====
//   candidate: air.get_num_mip_levels_texture_2d_array
//   stdlib 実呼出: __bits/metal_texture2d_array:2236: return __metal_get_num_mip_levels_texture_2d_array_t(derived.t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_num_mip_levels_texture_2d_t ====
//   candidate: air.get_num_mip_levels_texture_2d
//   stdlib 実呼出: __bits/metal_texture2d:2241: return __metal_get_num_mip_levels_texture_2d_t(derived.t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_num_mip_levels_texture_3d_t ====
//   candidate: air.get_num_mip_levels_texture_3d
//   stdlib 実呼出: __bits/metal_texture3d:2132: return __metal_get_num_mip_levels_texture_3d_t(derived.t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_num_mip_levels_texture_cube_array_t ====
//   candidate: air.get_num_mip_levels_texture_cube_array
//   stdlib 実呼出: __bits/metal_texturecube_array:2255: return __metal_get_num_mip_levels_texture_cube_array_t(derived.t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_num_mip_levels_texture_cube_t ====
//   candidate: air.get_num_mip_levels_texture_cube
//   stdlib 実呼出: __bits/metal_texturecube:2260: return __metal_get_num_mip_levels_texture_cube_t(derived.t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_num_patch_control_points ====
//   candidate: air.get.num.patch.control.points
//   stdlib 実呼出: metal_tessellation:31: return __metal_get_num_patch_control_points();
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_num_samples ====
//   candidate: air.get.num.samples
//   stdlib 実呼出: metal_graphics:172: return __metal_get_num_samples(0);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_num_samples_depth_2d_ms_array_t ====
//   candidate: air.get.num.samples.depth.2d.ms.array.t
//   stdlib 実呼出: __bits/metal_depth2d_ms_array:276: return __metal_get_num_samples_depth_2d_ms_array_t(derived.t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_num_samples_depth_2d_ms_t ====
//   candidate: air.get.num.samples.depth.2d.ms.t
//   stdlib 実呼出: __bits/metal_depth2d_ms:270: return __metal_get_num_samples_depth_2d_ms_t(derived.t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_read_sampler ====
//   candidate: air.get.read.sampler
//   stdlib 実呼出: __bits/metal_depth2d:1360: return __metal_read_depth_2d_t(derived.t, __metal_get_read_sampler(), coord, ushort2(0), lod,
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_sample_position ====
//   candidate: air.get.sample.position
//   stdlib 実呼出: metal_graphics:177: return __metal_get_sample_position(indx, 0);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_sampler ====
//   candidate: air.get.sampler
//   stdlib 実呼出: __bits/metal_texture_common:846: return __metal_get_sampler(s.s_address_v, s.t_address_v, s.r_address_v,
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_vertex_value ====
//   candidate: air.get.vertex.value
//   stdlib 実呼出: metal_vertex_value:26: return __metal_get_vertex_value(impl, int(i), T());
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_width_depth_2d_array_t ====
//   candidate: air.get.width.depth.2d.array.t
//   stdlib 実呼出: __bits/metal_depth2d_array:1797: return __metal_get_width_depth_2d_array_t(derived.t, lod);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_width_depth_2d_ms_array_t ====
//   candidate: air.get.width.depth.2d.ms.array.t
//   stdlib 実呼出: __bits/metal_depth2d_ms_array:261: return __metal_get_width_depth_2d_ms_array_t(derived.t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_width_depth_2d_ms_t ====
//   candidate: air.get.width.depth.2d.ms.t
//   stdlib 実呼出: __bits/metal_depth2d_ms:260: return __metal_get_width_depth_2d_ms_t(derived.t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_width_depth_2d_t ====
//   candidate: air.get.width.depth.2d.t
//   stdlib 実呼出: __bits/metal_depth2d:1797: return __metal_get_width_depth_2d_t(derived.t, lod);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_width_depth_cube_array_t ====
//   candidate: air.get.width.depth.cube.array.t
//   stdlib 実呼出: __bits/metal_depthcube_array:1786: return __metal_get_width_depth_cube_array_t(derived.t, lod);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_width_depth_cube_t ====
//   candidate: air.get.width.depth.cube.t
//   stdlib 実呼出: __bits/metal_depthcube:1799: return __metal_get_width_depth_cube_t(derived.t, lod);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_width_texture_cube_array_t ====
//   candidate: air.get_width_texture_cube_array
//   stdlib 実呼出: __bits/metal_texturecube_array:2240: return __metal_get_width_texture_cube_array_t(derived.t, lod);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_width_texture_cube_t ====
//   candidate: air.get_width_texture_cube
//   stdlib 実呼出: __bits/metal_texturecube:2250: return __metal_get_width_texture_cube_t(derived.t, lod);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_imageblock_explicit_data ====
//   candidate: air.imageblock.data
//   stdlib 実呼出: metal_imageblocks:184: return __metal_imageblock_explicit_data(_imgblock, uint(0), coord, ushort(0), T());
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_imageblock_explicit_mask_write ====
//   candidate: air.imageblock.mask.write
//   stdlib 実呼出: metal_imageblocks:216: __metal_imageblock_explicit_mask_write(data(coord), color_coverage_mask, &t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_imageblock_implicit_data ====
//   candidate: air.imageblock.implicit.data
//   stdlib 実呼出: metal_imageblocks:255: return imageblock_slice<E, imageblock_layout_implicit>(__metal_imageblock_implicit_data(_imgblock
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_imageblock_implicit_mask_write ====
//   candidate: air.imageblock.implicit.mask.write
//   stdlib 実呼出: metal_imageblocks:249: __metal_imageblock_implicit_mask_write(_imgblock, coord, color_coverage_mask, &data);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_imageblock_implicit_read ====
//   candidate: air.imageblock.implicit.read
//   stdlib 実呼出: metal_imageblocks:226: __metal_imageblock_implicit_read(_imgblock, uint(0), coord, ushort(0), &data);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_imageblock_implicit_write ====
//   candidate: air.imageblock.implicit.write
//   stdlib 実呼出: metal_imageblocks:239: __metal_imageblock_implicit_write(_imgblock, uint(0), coord, ushort(0), &data);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_imageblock_t ====
//   candidate: air.imageblock.t
//   stdlib 実呼出: metal_imageblocks:173: __metal_imageblock_t _imgblock;
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_interpolant_t ====
//   candidate: air.interpolant.t
//   stdlib 実呼出: metal_interpolate:46: __metal_interpolant_t impl;
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_interpolate_center_no_perspective ====
//   candidate: air.interpolate.center.no.perspective
//   stdlib 実呼出: metal_interpolate:54: return __metal_interpolate_center_no_perspective(impl, T());
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_interpolate_center_perspective ====
//   candidate: air.interpolate.center.perspective
//   stdlib 実呼出: metal_interpolate:30: return __metal_interpolate_center_perspective(impl, T());
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_interpolate_centroid_no_perspective ====
//   candidate: air.interpolate.centroid.no.perspective
//   stdlib 実呼出: metal_interpolate:58: return __metal_interpolate_centroid_no_perspective(impl, T());
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_interpolate_centroid_perspective ====
//   candidate: air.interpolate.centroid.perspective
//   stdlib 実呼出: metal_interpolate:34: return __metal_interpolate_centroid_perspective(impl, T());
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_interpolate_offset_no_perspective ====
//   candidate: air.interpolate.offset.no.perspective
//   stdlib 実呼出: metal_interpolate:66: return __metal_interpolate_offset_no_perspective(impl, offset, T());
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_interpolate_offset_perspective ====
//   candidate: air.interpolate.offset.perspective
//   stdlib 実呼出: metal_interpolate:42: return __metal_interpolate_offset_perspective(impl, offset, T());
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_interpolate_sample_no_perspective ====
//   candidate: air.interpolate.sample.no.perspective
//   stdlib 実呼出: metal_interpolate:62: return __metal_interpolate_sample_no_perspective(impl, sample, T());
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_interpolate_sample_perspective ====
//   candidate: air.interpolate.sample.perspective
//   stdlib 実呼出: metal_interpolate:38: return __metal_interpolate_sample_perspective(impl, sample, T());
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_is_null_depth_2d_array_t ====
//   candidate: air.is.null.depth.2d.array.t
//   stdlib 実呼出: __bits/metal_depth2d_array:2499: return __metal_is_null_depth_2d_array_t(tex.t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_is_null_depth_2d_ms_array_t ====
//   candidate: air.is.null.depth.2d.ms.array.t
//   stdlib 実呼出: __bits/metal_depth2d_ms_array:955: return __metal_is_null_depth_2d_ms_array_t(tex.t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_is_null_depth_2d_ms_t ====
//   candidate: air.is.null.depth.2d.ms.t
//   stdlib 実呼出: __bits/metal_depth2d_ms:924: return __metal_is_null_depth_2d_ms_t(tex.t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_is_null_depth_2d_t ====
//   candidate: air.is.null.depth.2d.t
//   stdlib 実呼出: __bits/metal_depth2d:2469: return __metal_is_null_depth_2d_t(tex.t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_is_null_depth_cube_array_t ====
//   candidate: air.is.null.depth.cube.array.t
//   stdlib 実呼出: __bits/metal_depthcube_array:2488: return __metal_is_null_depth_cube_array_t(tex.t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_is_null_depth_cube_t ====
//   candidate: air.is.null.depth.cube.t
//   stdlib 実呼出: __bits/metal_depthcube:2471: return __metal_is_null_depth_cube_t(tex.t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_is_null_texture_1d_array_t ====
//   candidate: air.is_null_texture_1d_array
//   stdlib 実呼出: __bits/metal_texture1d_array:2266: return __metal_is_null_texture_1d_array_t(tex.t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_is_null_texture_1d_t ====
//   candidate: air.is_null_texture_1d
//   stdlib 実呼出: __bits/metal_texture1d:2234: return __metal_is_null_texture_1d_t(tex.t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_is_null_texture_2d_array_t ====
//   candidate: air.is_null_texture_2d_array
//   stdlib 実呼出: __bits/metal_texture2d_array:2957: return __metal_is_null_texture_2d_array_t(tex.t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_is_null_texture_2d_ms_array_t ====
//   candidate: air.is_null_texture_2d_ms_array
//   stdlib 実呼出: __bits/metal_texture2d_ms_array:962: return __metal_is_null_texture_2d_ms_array_t(tex.t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_is_null_texture_2d_ms_t ====
//   candidate: air.is_null_texture_2d_ms
//   stdlib 実呼出: __bits/metal_texture2d_ms:931: return __metal_is_null_texture_2d_ms_t(tex.t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_is_null_texture_2d_t ====
//   candidate: air.is_null_texture_2d
//   stdlib 実呼出: __bits/metal_texture2d:2937: return __metal_is_null_texture_2d_t(tex.t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_is_null_texture_3d_t ====
//   candidate: air.is_null_texture_3d
//   stdlib 実呼出: __bits/metal_texture3d:2849: return __metal_is_null_texture_3d_t(tex.t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_is_null_texture_buffer_1d_t ====
//   candidate: air.is_null_texture_buffer_1d
//   stdlib 実呼出: __bits/metal_texture_buffer:1867: return __metal_is_null_texture_buffer_1d_t(tex.t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_is_null_texture_cube_array_t ====
//   candidate: air.is_null_texture_cube_array
//   stdlib 実呼出: __bits/metal_texturecube_array:2979: return __metal_is_null_texture_cube_array_t(tex.t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_is_null_texture_cube_t ====
//   candidate: air.is_null_texture_cube
//   stdlib 実呼出: __bits/metal_texturecube:2960: return __metal_is_null_texture_cube_t(tex.t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_map_physical_to_screen_coordinates ====
//   candidate: air.map.physical.to.screen.coordinates
//   stdlib 実呼出: metal_graphics:217: return __metal_map_physical_to_screen_coordinates(coords, reinterpret_cast<constant void *>(&data), 
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_map_screen_to_physical_coordinates ====
//   candidate: air.map.screen.to.physical.coordinates
//   stdlib 実呼出: metal_graphics:227: return __metal_map_screen_to_physical_coordinates(coords, reinterpret_cast<constant void *>(&data), 
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_patch_control_point_t ====
//   candidate: air.patch.control.point.t
//   stdlib 実呼出: metal_tessellation:40: __metal_patch_control_point_t pcp;
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_read_depth_2d_array_t ====
//   candidate: air.read.depth.2d.array.t
//   stdlib 実呼出: __bits/metal_depth2d_array:1360: return __metal_read_depth_2d_array_t(derived.t, __metal_get_read_sampler(), coord, arra
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_read_depth_2d_ms_array_t ====
//   candidate: air.read.depth.2d.ms.array.t
//   stdlib 実呼出: __bits/metal_depth2d_ms_array:42: return __metal_read_depth_2d_ms_array_t(derived.t, __metal_get_read_sampler(), coord, 
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_read_depth_2d_ms_t ====
//   candidate: air.read.depth.2d.ms.t
//   stdlib 実呼出: __bits/metal_depth2d_ms:41: return __metal_read_depth_2d_ms_t(derived.t, __metal_get_read_sampler(), coord, sample, int(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_read_depth_2d_t ====
//   candidate: air.read.depth.2d.t
//   stdlib 実呼出: __bits/metal_depth2d:1360: return __metal_read_depth_2d_t(derived.t, __metal_get_read_sampler(), coord, ushort2(0), lod,
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_read_depth_cube_array_t ====
//   candidate: air.read.depth.cube.array.t
//   stdlib 実呼出: __bits/metal_depthcube_array:1349: return __metal_read_depth_cube_array_t(derived.t, __metal_get_read_sampler(), coord, 
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_read_depth_cube_t ====
//   candidate: air.read.depth.cube.t
//   stdlib 実呼出: __bits/metal_depthcube:1361: return __metal_read_depth_cube_t(derived.t, __metal_get_read_sampler(), coord, face, lod, i
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_sample_compare_depth_2d_array_t ====
//   candidate: air.sample.compare.depth.2d.array.t
//   stdlib 実呼出: __bits/metal_depth2d_array:691: return __metal_sample_compare_depth_2d_array_t(derived.t, s.val, coord, array, compare_v
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_sample_compare_depth_2d_array_t_grad ====
//   candidate: air.sample.compare.depth.2d.array.t.grad
//   stdlib 実呼出: __bits/metal_depth2d_array:723: return __metal_sample_compare_depth_2d_array_t_grad(derived.t, s.val, coord, array, comp
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_sample_compare_depth_2d_t ====
//   candidate: air.sample.compare.depth.2d.t
//   stdlib 実呼出: __bits/metal_depth2d:691: return __metal_sample_compare_depth_2d_t(derived.t, s.val, coord, compare_value, true, offset,
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_sample_compare_depth_2d_t_grad ====
//   candidate: air.sample.compare.depth.2d.t.grad
//   stdlib 実呼出: __bits/metal_depth2d:723: return __metal_sample_compare_depth_2d_t_grad(derived.t, s.val, coord, compare_value, options.
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_sample_compare_depth_cube_array_t ====
//   candidate: air.sample.compare.depth.cube.array.t
//   stdlib 実呼出: __bits/metal_depthcube_array:692: return __metal_sample_compare_depth_cube_array_t(derived.t, s.val, coord, array, compa
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_sample_compare_depth_cube_array_t_grad ====
//   candidate: air.sample.compare.depth.cube.array.t.grad
//   stdlib 実呼出: __bits/metal_depthcube_array:722: return __metal_sample_compare_depth_cube_array_t_grad(derived.t, s.val, coord, array, 
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_sample_compare_depth_cube_t ====
//   candidate: air.sample.compare.depth.cube.t
//   stdlib 実呼出: __bits/metal_depthcube:691: return __metal_sample_compare_depth_cube_t(derived.t, s.val, coord, compare_value, false, 0.
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_sample_compare_depth_cube_t_grad ====
//   candidate: air.sample.compare.depth.cube.t.grad
//   stdlib 実呼出: __bits/metal_depthcube:723: return __metal_sample_compare_depth_cube_t_grad(derived.t, s.val, coord, compare_value, opti
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_sample_depth_2d_array_t ====
//   candidate: air.sample.depth.2d.array.t
//   stdlib 実呼出: __bits/metal_depth2d_array:40: return __metal_sample_depth_2d_array_t(derived.t, s.val, coord, array, true, offset, fals
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_sample_depth_2d_array_t_grad ====
//   candidate: air.sample.depth.2d.array.t.grad
//   stdlib 実呼出: __bits/metal_depth2d_array:67: return __metal_sample_depth_2d_array_t_grad(derived.t, s.val, coord, array, options.dPdx,
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_sample_depth_2d_t ====
//   candidate: air.sample.depth.2d.t
//   stdlib 実呼出: __bits/metal_depth2d:40: return __metal_sample_depth_2d_t(derived.t, s.val, coord, true, offset, false, 0.0f, 0.0f, int(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_sample_depth_2d_t_grad ====
//   candidate: air.sample.depth.2d.t.grad
//   stdlib 実呼出: __bits/metal_depth2d:67: return __metal_sample_depth_2d_t_grad(derived.t, s.val, coord, options.dPdx, options.dPdy, 0.0f
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_sample_depth_cube_array_t ====
//   candidate: air.sample.depth.cube.array.t
//   stdlib 実呼出: __bits/metal_depthcube_array:41: return __metal_sample_depth_cube_array_t(derived.t, s.val, coord, array, false, 0.0f, 0
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_sample_depth_cube_array_t_grad ====
//   candidate: air.sample.depth.cube.array.t.grad
//   stdlib 実呼出: __bits/metal_depthcube_array:68: return __metal_sample_depth_cube_array_t_grad(derived.t, s.val, coord, array, options.d
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_sample_depth_cube_t ====
//   candidate: air.sample.depth.cube.t
//   stdlib 実呼出: __bits/metal_depthcube:40: return __metal_sample_depth_cube_t(derived.t, s.val, coord, false, 0.0f, 0.0f, int(a), static
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_sample_depth_cube_t_grad ====
//   candidate: air.sample.depth.cube.t.grad
//   stdlib 実呼出: __bits/metal_depthcube:67: return __metal_sample_depth_cube_t_grad(derived.t, s.val, coord, options.dPdx, options.dPdy, 
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_sample_texture_2d_array_t_grad ====
//   candidate: air.sample.texture.2d.array.t.grad
//   stdlib 実呼出: __bits/metal_texture2d_array:74: return __metal_sample_texture_2d_array_t_grad(derived.t, s.val, coord, array, options.d
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_sample_texture_2d_t_grad ====
//   candidate: air.sample.texture.2d.t.grad
//   stdlib 実呼出: __bits/metal_texture2d:74: return __metal_sample_texture_2d_t_grad(derived.t, s.val, coord, options.dPdx, options.dPdy, 
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_sample_texture_3d_t_grad ====
//   candidate: air.sample.texture.3d.t.grad
//   stdlib 実呼出: __bits/metal_texture3d:74: return __metal_sample_texture_3d_t_grad(derived.t, s.val, coord, options.dPdx, options.dPdy, 
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_sample_texture_cube_array_t_grad ====
//   candidate: air.sample.texture.cube.array.t.grad
//   stdlib 実呼出: __bits/metal_texturecube_array:75: return __metal_sample_texture_cube_array_t_grad(derived.t, s.val, coord, array, optio
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_sample_texture_cube_t_grad ====
//   candidate: air.sample.texture.cube.t.grad
//   stdlib 実呼出: __bits/metal_texturecube:74: return __metal_sample_texture_cube_t_grad(derived.t, s.val, coord, options.dPdx, options.dP
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_sampler_t ====
//   candidate: air.sampler.t
//   stdlib 実呼出: __bits/metal_texture_common:841: __metal_sampler_t val;
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_struct_has_render_target ====
//   candidate: air.struct.has.render.target
//   stdlib 実呼出: metal_imageblocks:10: #define METAL_VALID_RENDER_TARGET(A, E, T) METAL_ENABLE_IF(__metal_struct_has_render_target(index,
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_texture_1d_array_t ====
//   candidate: air.texture.1d.array.t
//   stdlib 実呼出: __bits/metal_texture1d_array:1923: __metal_texture_1d_array_t t;
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_texture_1d_t ====
//   candidate: air.texture.1d.t
//   stdlib 実呼出: __bits/metal_texture1d:1891: __metal_texture_1d_t t;
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_texture_2d_array_t ====
//   candidate: air.texture.2d.array.t
//   stdlib 実呼出: __bits/metal_texture2d_array:2610: __metal_texture_2d_array_t t;
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_texture_2d_ms_array_t ====
//   candidate: air.texture.2d.ms.array.t
//   stdlib 実呼出: __bits/metal_texture2d_ms_array:658: __metal_texture_2d_ms_array_t t;
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_texture_2d_ms_t ====
//   candidate: air.texture.2d.ms.t
//   stdlib 実呼出: __bits/metal_texture2d_ms:627: __metal_texture_2d_ms_t t;
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_texture_2d_t ====
//   candidate: air.texture.2d.t
//   stdlib 実呼出: __bits/metal_texture2d:2590: __metal_texture_2d_t t;
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_texture_3d_t ====
//   candidate: air.texture.3d.t
//   stdlib 実呼出: __bits/metal_texture3d:2506: __metal_texture_3d_t t;
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_texture_buffer_1d_t ====
//   candidate: air.texture.buffer.1d.t
//   stdlib 実呼出: __bits/metal_texture_buffer:1527: __metal_texture_buffer_1d_t t;
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_texture_cube_array_t ====
//   candidate: air.texture.cube.array.t
//   stdlib 実呼出: __bits/metal_texturecube_array:2629: __metal_texture_cube_array_t t;
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_texture_cube_t ====
//   candidate: air.texture.cube.t
//   stdlib 実呼出: __bits/metal_texturecube:2609: __metal_texture_cube_t t;
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_unpack_snorm1x16 ====
//   candidate: air.unpack.snorm1x16
//   stdlib 実呼出: metal_pixel:1145: return __metal_unpack_snorm1x16(data, T());
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_unpack_snorm1x8 ====
//   candidate: air.unpack.snorm1x8
//   stdlib 実呼出: metal_pixel:1095: return __metal_unpack_snorm1x8(data, T());
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_unpack_snorm2x8 ====
//   candidate: air.unpack.snorm2x8
//   stdlib 実呼出: metal_pixel:1195: return __metal_unpack_snorm2x8(data, T());
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_unpack_snorm4x16 ====
//   candidate: air.unpack.snorm4x16
//   stdlib 実呼出: metal_pixel:1371: return __metal_unpack_snorm4x16(data, T());
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_unpack_unorm1x16 ====
//   candidate: air.unpack.unorm1x16
//   stdlib 実呼出: metal_pixel:1121: return __metal_unpack_unorm1x16(data, T());
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_unpack_unorm1x8 ====
//   candidate: air.unpack.unorm1x8
//   stdlib 実呼出: metal_pixel:1069: return __metal_unpack_unorm1x8(data, T());
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_unpack_unorm2x8 ====
//   candidate: air.unpack.unorm2x8
//   stdlib 実呼出: metal_pixel:1169: return __metal_unpack_unorm2x8(data, T());
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_unpack_unorm4x16 ====
//   candidate: air.unpack.unorm4x16
//   stdlib 実呼出: metal_pixel:1347: return __metal_unpack_unorm4x16(data, T());
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_unpack_unorm_rg11b10f ====
//   candidate: air.unpack.unorm.rg11b10f
//   stdlib 実呼出: metal_pixel:1421: return __metal_unpack_unorm_rg11b10f(data, T());
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_unpack_unorm_rgb9e5 ====
//   candidate: air.unpack.unorm.rgb9e5
//   stdlib 実呼出: metal_pixel:1447: return __metal_unpack_unorm_rgb9e5(data, T());
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_vertex_value_t ====
//   candidate: air.vertex.value.t
//   stdlib 実呼出: metal_vertex_value:30: __metal_vertex_value_t impl;
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_write_imageblock_slice_to_texture_1d_array_t ====
//   candidate: air.write_imageblock_slice_to_texture_1d_array
//   stdlib 実呼出: __bits/metal_texture1d_array:383: __metal_write_imageblock_slice_to_texture_1d_array_t(derived.t, slice._imgblkptr, slic
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_write_imageblock_slice_to_texture_1d_t ====
//   candidate: air.write_imageblock_slice_to_texture_1d
//   stdlib 実呼出: __bits/metal_texture1d:383: __metal_write_imageblock_slice_to_texture_1d_t(derived.t, slice._imgblkptr, slice._size_vali
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_write_imageblock_slice_to_texture_2d_array_t ====
//   candidate: air.write_imageblock_slice_to_texture_2d_array
//   stdlib 実呼出: __bits/metal_texture2d_array:923: __metal_write_imageblock_slice_to_texture_2d_array_t(derived.t, slice._imgblkptr, slic
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_write_imageblock_slice_to_texture_2d_t ====
//   candidate: air.write_imageblock_slice_to_texture_2d
//   stdlib 実呼出: __bits/metal_texture2d:935: __metal_write_imageblock_slice_to_texture_2d_t(derived.t, slice._imgblkptr, slice._size_vali
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_write_imageblock_slice_to_texture_3d_t ====
//   candidate: air.write_imageblock_slice_to_texture_3d
//   stdlib 実呼出: __bits/metal_texture3d:936: __metal_write_imageblock_slice_to_texture_3d_t(derived.t, slice._imgblkptr, slice._size_vali
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_write_imageblock_slice_to_texture_cube_array_t ====
//   candidate: air.write_imageblock_slice_to_texture_cube_array
//   stdlib 実呼出: __bits/metal_texturecube_array:950: __metal_write_imageblock_slice_to_texture_cube_array_t(derived.t, slice._imgblkptr, 
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_write_imageblock_slice_to_texture_cube_t ====
//   candidate: air.write_imageblock_slice_to_texture_cube
//   stdlib 実呼出: __bits/metal_texturecube:952: __metal_write_imageblock_slice_to_texture_cube_t(derived.t, slice._imgblkptr, slice._size_
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p06_xxx 系で extern "C" 推奨)
