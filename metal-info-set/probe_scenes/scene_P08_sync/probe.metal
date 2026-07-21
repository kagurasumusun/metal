// scene P08: 同期: threadgroup/simdgroup barrier+shuffle, async copy
// 生成: 2026-07-21 build_probe_scenes.py@1.0.0 (再生成可能: 一次入力 data/probe_cells.csv 他)
// 実機未検証: コンパイル可否は docs/PROBING_PLAN.md §1 の手順 (xcrun metal) で確認
#include <metal_stdlib>
using namespace metal;

// ==== TODO(manual_needed): __metal_get_simdgroup_size ====
//   candidate: air.get.simdgroup.size
//   stdlib 実呼出: metal_simdgroup:222: return __metal_simd_shuffle_and_fill_down(data, filling_data, delta, __metal_get_simdgroup_size(ush
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_quad_active_threads_mask ====
//   candidate: air.quad.active.threads.mask
//   stdlib 実呼出: metal_quadgroup:83: return quad_vote(__metal_quad_active_threads_mask());
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_quad_all ====
//   candidate: air.quad.all
//   stdlib 実呼出: metal_quadgroup:88: return __metal_quad_all(expr);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_quad_and ====
//   candidate: air.quad.and
//   stdlib 実呼出: metal_quadgroup:96: return __metal_quad_and(data);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_quad_any ====
//   candidate: air.quad.any
//   stdlib 実呼出: metal_quadgroup:103: return __metal_quad_any(expr);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_quad_ballot ====
//   candidate: air.quad.ballot
//   stdlib 実呼出: metal_quadgroup:110: return quad_vote(__metal_quad_ballot(expr));
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_quad_broadcast ====
//   candidate: air.quad.broadcast
//   stdlib 実呼出: metal_quadgroup:117: return __metal_quad_broadcast(data, broadcast_lane_id);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_quad_broadcast_first ====
//   candidate: air.quad.broadcast.first
//   stdlib 実呼出: metal_quadgroup:124: return __metal_quad_broadcast_first(data);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_quad_is_first ====
//   candidate: air.quad.is.first
//   stdlib 実呼出: metal_quadgroup:131: return __metal_quad_is_first();
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_quad_is_helper_thread ====
//   candidate: air.quad.is.helper.thread
//   stdlib 実呼出: metal_quadgroup:138: return __metal_quad_is_helper_thread();
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_quad_max ====
//   candidate: air.quad.max
//   stdlib 実呼出: metal_quadgroup:144: return __metal_quad_max(data);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_quad_min ====
//   candidate: air.quad.min
//   stdlib 実呼出: metal_quadgroup:150: return __metal_quad_min(data);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_quad_or ====
//   candidate: air.quad.or
//   stdlib 実呼出: metal_quadgroup:158: return __metal_quad_or(data);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_quad_prefix_exclusive_product ====
//   candidate: air.quad.prefix.exclusive.product
//   stdlib 実呼出: metal_quadgroup:164: return __metal_quad_prefix_exclusive_product(data);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_quad_prefix_exclusive_sum ====
//   candidate: air.quad.prefix.exclusive.sum
//   stdlib 実呼出: metal_quadgroup:170: return __metal_quad_prefix_exclusive_sum(data);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_quad_prefix_inclusive_product ====
//   candidate: air.quad.prefix.inclusive.product
//   stdlib 実呼出: metal_quadgroup:176: return __metal_quad_prefix_inclusive_product(data);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_quad_prefix_inclusive_sum ====
//   candidate: air.quad.prefix.inclusive.sum
//   stdlib 実呼出: metal_quadgroup:182: return __metal_quad_prefix_inclusive_sum(data);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_quad_product ====
//   candidate: air.quad.product
//   stdlib 実呼出: metal_quadgroup:188: return __metal_quad_product(data);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_quad_shuffle ====
//   candidate: air.quad.shuffle
//   stdlib 実呼出: metal_quadgroup:195: return __metal_quad_shuffle(data, quad_lane_id);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_quad_shuffle_and_fill_down ====
//   candidate: air.quad.shuffle.and.fill.down
//   stdlib 実呼出: metal_quadgroup:202: return __metal_quad_shuffle_and_fill_down(data, filling_data, delta, modulo);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_quad_shuffle_and_fill_up ====
//   candidate: air.quad.shuffle.and.fill.up
//   stdlib 実呼出: metal_quadgroup:214: return __metal_quad_shuffle_and_fill_up(data, filling_data, delta, modulo);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_quad_shuffle_down ====
//   candidate: air.quad.shuffle.down
//   stdlib 実呼出: metal_quadgroup:227: return __metal_quad_shuffle_down(data, delta);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_quad_shuffle_rotate_down ====
//   candidate: air.quad.shuffle.rotate.down
//   stdlib 実呼出: metal_quadgroup:240: return __metal_quad_shuffle_rotate_down(data, delta);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_quad_shuffle_rotate_up ====
//   candidate: air.quad.shuffle.rotate.up
//   stdlib 実呼出: metal_quadgroup:248: return __metal_quad_shuffle_rotate_up(data, delta);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_quad_shuffle_up ====
//   candidate: air.quad.shuffle.up
//   stdlib 実呼出: metal_quadgroup:233: return __metal_quad_shuffle_up(data, delta);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_quad_shuffle_xor ====
//   candidate: air.quad.shuffle.xor
//   stdlib 実呼出: metal_quadgroup:255: return __metal_quad_shuffle_xor(data, mask);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_quad_sum ====
//   candidate: air.quad.sum
//   stdlib 実呼出: metal_quadgroup:262: return __metal_quad_sum(data);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_quad_vote_all ====
//   candidate: air.quad.vote.all
//   stdlib 実呼出: metal_quadgroup:69: return __metal_quad_vote_all(v);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_quad_vote_any ====
//   candidate: air.quad.vote.any
//   stdlib 実呼出: metal_quadgroup:74: return __metal_quad_vote_any(v);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_quad_xor ====
//   candidate: air.quad.xor
//   stdlib 実呼出: metal_quadgroup:268: return __metal_quad_xor(data);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_simd_active_threads_mask ====
//   candidate: air.simd.active.threads.mask
//   stdlib 実呼出: metal_simdgroup:101: return simd_vote(__metal_simd_active_threads_mask(simd_vote::vote_t(0)));
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_simd_all ====
//   candidate: air.simd.all
//   stdlib 実呼出: metal_simdgroup:106: return __metal_simd_all(expr);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_simd_and ====
//   candidate: air.simd.and
//   stdlib 実呼出: metal_simdgroup:124: return __metal_simd_and(data);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_simd_any ====
//   candidate: air.simd.any
//   stdlib 実呼出: metal_simdgroup:111: return __metal_simd_any(expr);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_simd_ballot ====
//   candidate: air.simd.ballot
//   stdlib 実呼出: metal_simdgroup:116: return simd_vote(__metal_simd_ballot(expr, simd_vote::vote_t(0)));
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_simd_broadcast ====
//   candidate: air.simd.broadcast
//   stdlib 実呼出: metal_simdgroup:131: return __metal_simd_broadcast(data, broadcast_lane_id);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_simd_broadcast_first ====
//   candidate: air.simd.broadcast.first
//   stdlib 実呼出: metal_simdgroup:138: return __metal_simd_broadcast_first(data);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_simd_is_first ====
//   candidate: air.simd.is.first
//   stdlib 実呼出: metal_simdgroup:145: return __metal_simd_is_first();
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_simd_is_helper_thread ====
//   candidate: air.simd.is.helper.thread
//   stdlib 実呼出: metal_simdgroup:152: return __metal_simd_is_helper_thread();
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_simd_max ====
//   candidate: air.simd.max
//   stdlib 実呼出: metal_simdgroup:158: return __metal_simd_max(data);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_simd_min ====
//   candidate: air.simd.min
//   stdlib 実呼出: metal_simdgroup:164: return __metal_simd_min(data);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_simd_or ====
//   candidate: air.simd.or
//   stdlib 実呼出: metal_simdgroup:172: return __metal_simd_or(data);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_simd_prefix_exclusive_product ====
//   candidate: air.simd.prefix.exclusive.product
//   stdlib 実呼出: metal_simdgroup:178: return __metal_simd_prefix_exclusive_product(data);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_simd_prefix_exclusive_sum ====
//   candidate: air.simd.prefix.exclusive.sum
//   stdlib 実呼出: metal_simdgroup:184: return __metal_simd_prefix_exclusive_sum(data);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_simd_prefix_inclusive_product ====
//   candidate: air.simd.prefix.inclusive.product
//   stdlib 実呼出: metal_simdgroup:190: return __metal_simd_prefix_inclusive_product(data);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_simd_prefix_inclusive_sum ====
//   candidate: air.simd.prefix.inclusive.sum
//   stdlib 実呼出: metal_simdgroup:196: return __metal_simd_prefix_inclusive_sum(data);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_simd_product ====
//   candidate: air.simd.product
//   stdlib 実呼出: metal_simdgroup:202: return __metal_simd_product(data);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_simd_shuffle ====
//   candidate: air.simd.shuffle
//   stdlib 実呼出: metal_simdgroup:209: return __metal_simd_shuffle(data, simd_lane_id);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_simd_shuffle_and_fill_down ====
//   candidate: air.simd.shuffle.and.fill.down
//   stdlib 実呼出: metal_simdgroup:216: return __metal_simd_shuffle_and_fill_down(data, filling_data, delta, modulo);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_simd_shuffle_and_fill_up ====
//   candidate: air.simd.shuffle.and.fill.up
//   stdlib 実呼出: metal_simdgroup:228: return __metal_simd_shuffle_and_fill_up(data, filling_data, delta, modulo);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_simd_shuffle_down ====
//   candidate: air.simd.shuffle.down
//   stdlib 実呼出: metal_simdgroup:241: return __metal_simd_shuffle_down(data, delta);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_simd_shuffle_rotate_down ====
//   candidate: air.simd.shuffle.rotate.down
//   stdlib 実呼出: metal_simdgroup:248: return __metal_simd_shuffle_rotate_down(data, delta);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_simd_shuffle_rotate_up ====
//   candidate: air.simd.shuffle.rotate.up
//   stdlib 実呼出: metal_simdgroup:256: return __metal_simd_shuffle_rotate_up(data, delta);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_simd_shuffle_up ====
//   candidate: air.simd.shuffle.up
//   stdlib 実呼出: metal_simdgroup:263: return __metal_simd_shuffle_up(data, delta);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_simd_shuffle_xor ====
//   candidate: air.simd.shuffle.xor
//   stdlib 実呼出: metal_simdgroup:269: return __metal_simd_shuffle_xor(data, mask);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_simd_sum ====
//   candidate: air.simd.sum
//   stdlib 実呼出: metal_simdgroup:276: return __metal_simd_sum(data);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_simd_vote_all ====
//   candidate: air.simd.vote.all
//   stdlib 実呼出: metal_simdgroup:87: return __metal_simd_vote_all(v);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_simd_vote_any ====
//   candidate: air.simd.vote.any
//   stdlib 実呼出: metal_simdgroup:92: return __metal_simd_vote_any(v);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_simd_xor ====
//   candidate: air.simd.xor
//   stdlib 実呼出: metal_simdgroup:282: return __metal_simd_xor(data);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p08_xxx 系で extern "C" 推奨)
