// scene P06M: method 系 builtin wrapper (build_method_probes.py@1.0.0)
// 生成: 2026-07-21 — リモート エラー駆動削りループで収束させる
#include <metal_stdlib>
using namespace metal;

#if defined(__HAVE_TEXTURE_BUFFER__) || defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_exchange_explicit_texture_buffer_1d_t cls=_texture_buffer_atomic_exchange
extern "C" uint4 probe_p06m_atomic_exchange_0(texture_buffer<uint, access::read_write> t) { return t.atomic_exchange(0u, uint4(0u)); }
#else
// guard __HAVE_TEXTURE_BUFFER__|__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_ARRAY__) || defined(__HAVE_TEXTURE_CUBE_ARRAY_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_exchange_explicit_texture_cube_array_t cls=_texturecube_array_atomic_exchange
// DISABLED_BY_LOOP extern "C" uint4 probe_p06m_atomic_exchange_1(texturecube_array<uint, access::read_write> t) { return t.atomic_exchange(uint2(0u), 0u, 0u, uint4(0u)); }
#else
// guard __HAVE_TEXTURE_CUBE_ARRAY__|__HAVE_TEXTURE_CUBE_ARRAY_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_exchange_explicit_texture_cube_t cls=_texturecube_atomic_exchange
extern "C" uint4 probe_p06m_atomic_exchange_2(texturecube<uint, access::read_write> t) { return t.atomic_exchange(uint2(0u), 0u, uint4(0u)); }
#else
// guard __HAVE_TEXTURE_CUBE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_BUFFER__) || defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_fetch_add_explicit_texture_buffer_1d_t cls=_texture_buffer_atomic_fetch_and_arith
extern "C" uint4 probe_p06m_atomic_fetch_add_3(texture_buffer<uint, access::read_write> t) { return t.atomic_fetch_add(0u, uint4(0u)); }
#else
// guard __HAVE_TEXTURE_BUFFER__|__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_ARRAY__) || defined(__HAVE_TEXTURE_CUBE_ARRAY_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_fetch_add_explicit_texture_cube_array_t cls=_texturecube_array_atomic_fetch_and_arith
// DISABLED_BY_LOOP extern "C" uint4 probe_p06m_atomic_fetch_add_4(texturecube_array<uint, access::read_write> t) { return t.atomic_fetch_add(uint2(0u), 0u, 0u, uint4(0u)); }
#else
// guard __HAVE_TEXTURE_CUBE_ARRAY__|__HAVE_TEXTURE_CUBE_ARRAY_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_fetch_add_explicit_texture_cube_t cls=_texturecube_atomic_fetch_and_arith
extern "C" uint4 probe_p06m_atomic_fetch_add_5(texturecube<uint, access::read_write> t) { return t.atomic_fetch_add(uint2(0u), 0u, uint4(0u)); }
#else
// guard __HAVE_TEXTURE_CUBE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_BUFFER__) || defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_fetch_and_explicit_texture_buffer_1d_t cls=_texture_buffer_atomic_fetch_and
extern "C" uint4 probe_p06m_atomic_fetch_and_6(texture_buffer<uint, access::read_write> t) { return t.atomic_fetch_and(0u, uint4(0u)); }
#else
// guard __HAVE_TEXTURE_BUFFER__|__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_ARRAY__) || defined(__HAVE_TEXTURE_CUBE_ARRAY_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_fetch_and_explicit_texture_cube_array_t cls=_texturecube_array_atomic_fetch_and
// DISABLED_BY_LOOP extern "C" uint4 probe_p06m_atomic_fetch_and_7(texturecube_array<uint, access::read_write> t) { return t.atomic_fetch_and(uint2(0u), 0u, 0u, uint4(0u)); }
#else
// guard __HAVE_TEXTURE_CUBE_ARRAY__|__HAVE_TEXTURE_CUBE_ARRAY_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_fetch_and_explicit_texture_cube_t cls=_texturecube_atomic_fetch_and
extern "C" uint4 probe_p06m_atomic_fetch_and_8(texturecube<uint, access::read_write> t) { return t.atomic_fetch_and(uint2(0u), 0u, uint4(0u)); }
#else
// guard __HAVE_TEXTURE_CUBE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_BUFFER__) || defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_fetch_max_explicit_texture_buffer_1d_t cls=_texture_buffer_atomic_fetch_and
extern "C" uint4 probe_p06m_atomic_fetch_max_9(texture_buffer<uint, access::read_write> t) { return t.atomic_fetch_max(0u, uint4(0u)); }
#else
// guard __HAVE_TEXTURE_BUFFER__|__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_ARRAY__) || defined(__HAVE_TEXTURE_CUBE_ARRAY_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_fetch_max_explicit_texture_cube_array_t cls=_texturecube_array_atomic_fetch_and
// DISABLED_BY_LOOP extern "C" uint4 probe_p06m_atomic_fetch_max_10(texturecube_array<uint, access::read_write> t) { return t.atomic_fetch_max(uint2(0u), 0u, 0u, uint4(0u)); }
#else
// guard __HAVE_TEXTURE_CUBE_ARRAY__|__HAVE_TEXTURE_CUBE_ARRAY_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_fetch_max_explicit_texture_cube_t cls=_texturecube_atomic_fetch_and
extern "C" uint4 probe_p06m_atomic_fetch_max_11(texturecube<uint, access::read_write> t) { return t.atomic_fetch_max(uint2(0u), 0u, uint4(0u)); }
#else
// guard __HAVE_TEXTURE_CUBE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_BUFFER__) || defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_fetch_min_explicit_texture_buffer_1d_t cls=_texture_buffer_atomic_fetch_and
extern "C" uint4 probe_p06m_atomic_fetch_min_12(texture_buffer<uint, access::read_write> t) { return t.atomic_fetch_min(0u, uint4(0u)); }
#else
// guard __HAVE_TEXTURE_BUFFER__|__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_ARRAY__) || defined(__HAVE_TEXTURE_CUBE_ARRAY_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_fetch_min_explicit_texture_cube_array_t cls=_texturecube_array_atomic_fetch_and
// DISABLED_BY_LOOP extern "C" uint4 probe_p06m_atomic_fetch_min_13(texturecube_array<uint, access::read_write> t) { return t.atomic_fetch_min(uint2(0u), 0u, 0u, uint4(0u)); }
#else
// guard __HAVE_TEXTURE_CUBE_ARRAY__|__HAVE_TEXTURE_CUBE_ARRAY_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_fetch_min_explicit_texture_cube_t cls=_texturecube_atomic_fetch_and
extern "C" uint4 probe_p06m_atomic_fetch_min_14(texturecube<uint, access::read_write> t) { return t.atomic_fetch_min(uint2(0u), 0u, uint4(0u)); }
#else
// guard __HAVE_TEXTURE_CUBE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_BUFFER__) || defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_fetch_or_explicit_texture_buffer_1d_t cls=_texture_buffer_atomic_fetch_and
extern "C" uint4 probe_p06m_atomic_fetch_or_15(texture_buffer<uint, access::read_write> t) { return t.atomic_fetch_or(0u, uint4(0u)); }
#else
// guard __HAVE_TEXTURE_BUFFER__|__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_ARRAY__) || defined(__HAVE_TEXTURE_CUBE_ARRAY_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_fetch_or_explicit_texture_cube_array_t cls=_texturecube_array_atomic_fetch_and
// DISABLED_BY_LOOP extern "C" uint4 probe_p06m_atomic_fetch_or_16(texturecube_array<uint, access::read_write> t) { return t.atomic_fetch_or(uint2(0u), 0u, 0u, uint4(0u)); }
#else
// guard __HAVE_TEXTURE_CUBE_ARRAY__|__HAVE_TEXTURE_CUBE_ARRAY_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_fetch_or_explicit_texture_cube_t cls=_texturecube_atomic_fetch_and
extern "C" uint4 probe_p06m_atomic_fetch_or_17(texturecube<uint, access::read_write> t) { return t.atomic_fetch_or(uint2(0u), 0u, uint4(0u)); }
#else
// guard __HAVE_TEXTURE_CUBE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_BUFFER__) || defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_fetch_sub_explicit_texture_buffer_1d_t cls=_texture_buffer_atomic_fetch_and_arith
extern "C" uint4 probe_p06m_atomic_fetch_sub_18(texture_buffer<uint, access::read_write> t) { return t.atomic_fetch_sub(0u, uint4(0u)); }
#else
// guard __HAVE_TEXTURE_BUFFER__|__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_ARRAY__) || defined(__HAVE_TEXTURE_CUBE_ARRAY_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_fetch_sub_explicit_texture_cube_array_t cls=_texturecube_array_atomic_fetch_and_arith
// DISABLED_BY_LOOP extern "C" uint4 probe_p06m_atomic_fetch_sub_19(texturecube_array<uint, access::read_write> t) { return t.atomic_fetch_sub(uint2(0u), 0u, 0u, uint4(0u)); }
#else
// guard __HAVE_TEXTURE_CUBE_ARRAY__|__HAVE_TEXTURE_CUBE_ARRAY_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_fetch_sub_explicit_texture_cube_t cls=_texturecube_atomic_fetch_and_arith
extern "C" uint4 probe_p06m_atomic_fetch_sub_20(texturecube<uint, access::read_write> t) { return t.atomic_fetch_sub(uint2(0u), 0u, uint4(0u)); }
#else
// guard __HAVE_TEXTURE_CUBE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_BUFFER__) || defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_fetch_xor_explicit_texture_buffer_1d_t cls=_texture_buffer_atomic_fetch_and
extern "C" uint4 probe_p06m_atomic_fetch_xor_21(texture_buffer<uint, access::read_write> t) { return t.atomic_fetch_xor(0u, uint4(0u)); }
#else
// guard __HAVE_TEXTURE_BUFFER__|__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_ARRAY__) || defined(__HAVE_TEXTURE_CUBE_ARRAY_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_fetch_xor_explicit_texture_cube_array_t cls=_texturecube_array_atomic_fetch_and
// DISABLED_BY_LOOP extern "C" uint4 probe_p06m_atomic_fetch_xor_22(texturecube_array<uint, access::read_write> t) { return t.atomic_fetch_xor(uint2(0u), 0u, 0u, uint4(0u)); }
#else
// guard __HAVE_TEXTURE_CUBE_ARRAY__|__HAVE_TEXTURE_CUBE_ARRAY_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_fetch_xor_explicit_texture_cube_t cls=_texturecube_atomic_fetch_and
extern "C" uint4 probe_p06m_atomic_fetch_xor_23(texturecube<uint, access::read_write> t) { return t.atomic_fetch_xor(uint2(0u), 0u, uint4(0u)); }
#else
// guard __HAVE_TEXTURE_CUBE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_BUFFER__) || defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_load_explicit_texture_buffer_1d_t cls=_texture_buffer_atomic_load
extern "C" uint4 probe_p06m_atomic_load_24(texture_buffer<uint, access::read_write> t) { return t.atomic_load(0u); }
#else
// guard __HAVE_TEXTURE_BUFFER__|__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_ARRAY__) || defined(__HAVE_TEXTURE_CUBE_ARRAY_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_load_explicit_texture_cube_array_t cls=_texturecube_array_atomic_load
// DISABLED_BY_LOOP extern "C" uint4 probe_p06m_atomic_load_25(texturecube_array<uint, access::read_write> t) { return t.atomic_load(uint2(0u), 0u, 0u); }
#else
// guard __HAVE_TEXTURE_CUBE_ARRAY__|__HAVE_TEXTURE_CUBE_ARRAY_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_load_explicit_texture_cube_t cls=_texturecube_atomic_load
extern "C" uint4 probe_p06m_atomic_load_26(texturecube<uint, access::read_write> t) { return t.atomic_load(uint2(0u), 0u); }
#else
// guard __HAVE_TEXTURE_CUBE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_max_explicit_texture_1d_array_t cls=_texture1d_array_atomic_modify
// DISABLED_BY_LOOP extern "C" void probe_p06m_atomic_max_27(texture1d_array<uint, access::read_write> t) { t.atomic_max(0u, 0u, ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_max_explicit_texture_1d_t cls=_texture1d_atomic_modify
// DISABLED_BY_LOOP extern "C" void probe_p06m_atomic_max_28(texture1d<uint, access::read_write> t) { t.atomic_max(0u, ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_max_explicit_texture_2d_array_t cls=_texture2d_array_atomic_modify
// DISABLED_BY_LOOP extern "C" void probe_p06m_atomic_max_29(texture2d_array<uint, access::read_write> t) { t.atomic_max(uint2(0u), 0u, ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_max_explicit_texture_2d_t cls=_texture2d_atomic_modify
// DISABLED_BY_LOOP extern "C" void probe_p06m_atomic_max_30(texture2d<uint, access::read_write> t) { t.atomic_max(uint2(0u), ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_max_explicit_texture_3d_t cls=_texture3d_atomic_modify
// DISABLED_BY_LOOP extern "C" void probe_p06m_atomic_max_31(texture3d<uint, access::read_write> t) { t.atomic_max(uint3(0u), ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_BUFFER__) || defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_max_explicit_texture_buffer_1d_t cls=_texture_buffer_atomic_modify
// DISABLED_BY_LOOP extern "C" void probe_p06m_atomic_max_32(texture_buffer<uint, access::read_write> t) { t.atomic_max(0u, ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_BUFFER__|__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_ARRAY__) || defined(__HAVE_TEXTURE_CUBE_ARRAY_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_max_explicit_texture_cube_array_t cls=_texturecube_array_atomic_modify
// DISABLED_BY_LOOP extern "C" void probe_p06m_atomic_max_33(texturecube_array<uint, access::read_write> t) { t.atomic_max(uint2(0u), 0u, 0u, ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_CUBE_ARRAY__|__HAVE_TEXTURE_CUBE_ARRAY_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_max_explicit_texture_cube_t cls=_texturecube_atomic_modify
extern "C" void probe_p06m_atomic_max_34(texturecube<uint, access::read_write> t) { t.atomic_max(uint2(0u), 0u, ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_CUBE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_min_explicit_texture_1d_array_t cls=_texture1d_array_atomic_modify
// DISABLED_BY_LOOP extern "C" void probe_p06m_atomic_min_35(texture1d_array<uint, access::read_write> t) { t.atomic_min(0u, 0u, ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_min_explicit_texture_1d_t cls=_texture1d_atomic_modify
// DISABLED_BY_LOOP extern "C" void probe_p06m_atomic_min_36(texture1d<uint, access::read_write> t) { t.atomic_min(0u, ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_min_explicit_texture_2d_array_t cls=_texture2d_array_atomic_modify
// DISABLED_BY_LOOP extern "C" void probe_p06m_atomic_min_37(texture2d_array<uint, access::read_write> t) { t.atomic_min(uint2(0u), 0u, ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_min_explicit_texture_2d_t cls=_texture2d_atomic_modify
// DISABLED_BY_LOOP extern "C" void probe_p06m_atomic_min_38(texture2d<uint, access::read_write> t) { t.atomic_min(uint2(0u), ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_min_explicit_texture_3d_t cls=_texture3d_atomic_modify
// DISABLED_BY_LOOP extern "C" void probe_p06m_atomic_min_39(texture3d<uint, access::read_write> t) { t.atomic_min(uint3(0u), ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_BUFFER__) || defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_min_explicit_texture_buffer_1d_t cls=_texture_buffer_atomic_modify
// DISABLED_BY_LOOP extern "C" void probe_p06m_atomic_min_40(texture_buffer<uint, access::read_write> t) { t.atomic_min(0u, ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_BUFFER__|__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_ARRAY__) || defined(__HAVE_TEXTURE_CUBE_ARRAY_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_min_explicit_texture_cube_array_t cls=_texturecube_array_atomic_modify
// DISABLED_BY_LOOP extern "C" void probe_p06m_atomic_min_41(texturecube_array<uint, access::read_write> t) { t.atomic_min(uint2(0u), 0u, 0u, ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_CUBE_ARRAY__|__HAVE_TEXTURE_CUBE_ARRAY_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_min_explicit_texture_cube_t cls=_texturecube_atomic_modify
extern "C" void probe_p06m_atomic_min_42(texturecube<uint, access::read_write> t) { t.atomic_min(uint2(0u), 0u, ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_CUBE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_BUFFER__) || defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_store_explicit_texture_buffer_1d_t cls=_texture_buffer_atomic_store
extern "C" void probe_p06m_atomic_store_43(texture_buffer<uint, access::read_write> t) { t.atomic_store(uint4(0u), 0u); }
#else
// guard __HAVE_TEXTURE_BUFFER__|__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_ARRAY__) || defined(__HAVE_TEXTURE_CUBE_ARRAY_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_store_explicit_texture_cube_array_t cls=_texturecube_array_atomic_store
// DISABLED_BY_LOOP extern "C" void probe_p06m_atomic_store_44(texturecube_array<uint, access::read_write> t) { t.atomic_store(uint4(0u), uint2(0u), 0u, 0u); }
#else
// guard __HAVE_TEXTURE_CUBE_ARRAY__|__HAVE_TEXTURE_CUBE_ARRAY_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_store_explicit_texture_cube_t cls=_texturecube_atomic_store
extern "C" void probe_p06m_atomic_store_45(texturecube<uint, access::read_write> t) { t.atomic_store(uint4(0u), uint2(0u), 0u); }
#else
// guard __HAVE_TEXTURE_CUBE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_MESH__) || defined(__HAVE_CALCULATE_LOD__)
// builtin=__metal_calculate_clamped_lod_depth_2d_array_t cls=_depth2d_array_sample
extern "C" float probe_p06m_calculate_clamped_lod_46(depth2d_array<float> d, sampler s) { return d.calculate_clamped_lod(s, float2(1.0f)); }
#else
// guard __HAVE_MESH__|__HAVE_CALCULATE_LOD__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_MESH__) || defined(__HAVE_CALCULATE_LOD__)
// builtin=__metal_calculate_clamped_lod_depth_2d_t cls=_depth2d_sample
extern "C" float probe_p06m_calculate_clamped_lod_47(depth2d<float> d, sampler s) { return d.calculate_clamped_lod(s, float2(1.0f)); }
#else
// guard __HAVE_MESH__|__HAVE_CALCULATE_LOD__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_DEPTH_CUBE_ARRAY__) || defined(__HAVE_MESH__) || defined(__HAVE_CALCULATE_LOD__)
// builtin=__metal_calculate_clamped_lod_depth_cube_array_t cls=_depthcube_array_sample
extern "C" float probe_p06m_calculate_clamped_lod_48(depthcube_array<float> d, sampler s) { return d.calculate_clamped_lod(s, float3(1.0f)); }
#else
// guard __HAVE_DEPTH_CUBE_ARRAY__|__HAVE_MESH__|__HAVE_CALCULATE_LOD__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_MESH__) || defined(__HAVE_CALCULATE_LOD__)
// builtin=__metal_calculate_clamped_lod_depth_cube_t cls=_depthcube_sample
extern "C" float probe_p06m_calculate_clamped_lod_49(depthcube<float> d, sampler s) { return d.calculate_clamped_lod(s, float3(1.0f)); }
#else
// guard __HAVE_MESH__|__HAVE_CALCULATE_LOD__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_MESH__) || defined(__HAVE_CALCULATE_LOD__)
// builtin=__metal_calculate_clamped_lod_texture_2d_array_t cls=_texture2d_array_sample
extern "C" float probe_p06m_calculate_clamped_lod_50(texture2d_array<float> t, sampler s) { return t.calculate_clamped_lod(s, float2(1.0f)); }
#else
// guard __HAVE_MESH__|__HAVE_CALCULATE_LOD__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_MESH__) || defined(__HAVE_CALCULATE_LOD__)
// builtin=__metal_calculate_clamped_lod_texture_2d_t cls=_texture2d_sample
extern "C" float probe_p06m_calculate_clamped_lod_51(texture2d<float> t, sampler s) { return t.calculate_clamped_lod(s, float2(1.0f)); }
#else
// guard __HAVE_MESH__|__HAVE_CALCULATE_LOD__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_MESH__) || defined(__HAVE_CALCULATE_LOD__)
// builtin=__metal_calculate_clamped_lod_texture_3d_t cls=_texture3d_sample
extern "C" float probe_p06m_calculate_clamped_lod_52(texture3d<float> t, sampler s) { return t.calculate_clamped_lod(s, float3(1.0f)); }
#else
// guard __HAVE_MESH__|__HAVE_CALCULATE_LOD__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_ARRAY__) || defined(__HAVE_MESH__) || defined(__HAVE_CALCULATE_LOD__)
// builtin=__metal_calculate_clamped_lod_texture_cube_array_t cls=_texturecube_array_sample
extern "C" float probe_p06m_calculate_clamped_lod_53(texturecube_array<float> t, sampler s) { return t.calculate_clamped_lod(s, float3(1.0f)); }
#else
// guard __HAVE_TEXTURE_CUBE_ARRAY__|__HAVE_MESH__|__HAVE_CALCULATE_LOD__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_MESH__) || defined(__HAVE_CALCULATE_LOD__)
// builtin=__metal_calculate_clamped_lod_texture_cube_t cls=_texturecube_sample
extern "C" float probe_p06m_calculate_clamped_lod_54(texturecube<float> t, sampler s) { return t.calculate_clamped_lod(s, float3(1.0f)); }
#else
// guard __HAVE_MESH__|__HAVE_CALCULATE_LOD__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_MESH__) || defined(__HAVE_CALCULATE_LOD__)
// builtin=__metal_calculate_unclamped_lod_depth_2d_array_t cls=_depth2d_array_sample
extern "C" float probe_p06m_calculate_unclamped_lod_55(depth2d_array<float> d, sampler s) { return d.calculate_unclamped_lod(s, float2(1.0f)); }
#else
// guard __HAVE_MESH__|__HAVE_CALCULATE_LOD__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_MESH__) || defined(__HAVE_CALCULATE_LOD__)
// builtin=__metal_calculate_unclamped_lod_depth_2d_t cls=_depth2d_sample
extern "C" float probe_p06m_calculate_unclamped_lod_56(depth2d<float> d, sampler s) { return d.calculate_unclamped_lod(s, float2(1.0f)); }
#else
// guard __HAVE_MESH__|__HAVE_CALCULATE_LOD__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_DEPTH_CUBE_ARRAY__) || defined(__HAVE_MESH__) || defined(__HAVE_CALCULATE_LOD__)
// builtin=__metal_calculate_unclamped_lod_depth_cube_array_t cls=_depthcube_array_sample
extern "C" float probe_p06m_calculate_unclamped_lod_57(depthcube_array<float> d, sampler s) { return d.calculate_unclamped_lod(s, float3(1.0f)); }
#else
// guard __HAVE_DEPTH_CUBE_ARRAY__|__HAVE_MESH__|__HAVE_CALCULATE_LOD__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_MESH__) || defined(__HAVE_CALCULATE_LOD__)
// builtin=__metal_calculate_unclamped_lod_depth_cube_t cls=_depthcube_sample
extern "C" float probe_p06m_calculate_unclamped_lod_58(depthcube<float> d, sampler s) { return d.calculate_unclamped_lod(s, float3(1.0f)); }
#else
// guard __HAVE_MESH__|__HAVE_CALCULATE_LOD__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_MESH__) || defined(__HAVE_CALCULATE_LOD__)
// builtin=__metal_calculate_unclamped_lod_texture_2d_array_t cls=_texture2d_array_sample
extern "C" float probe_p06m_calculate_unclamped_lod_59(texture2d_array<float> t, sampler s) { return t.calculate_unclamped_lod(s, float2(1.0f)); }
#else
// guard __HAVE_MESH__|__HAVE_CALCULATE_LOD__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_MESH__) || defined(__HAVE_CALCULATE_LOD__)
// builtin=__metal_calculate_unclamped_lod_texture_2d_t cls=_texture2d_sample
extern "C" float probe_p06m_calculate_unclamped_lod_60(texture2d<float> t, sampler s) { return t.calculate_unclamped_lod(s, float2(1.0f)); }
#else
// guard __HAVE_MESH__|__HAVE_CALCULATE_LOD__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_MESH__) || defined(__HAVE_CALCULATE_LOD__)
// builtin=__metal_calculate_unclamped_lod_texture_3d_t cls=_texture3d_sample
extern "C" float probe_p06m_calculate_unclamped_lod_61(texture3d<float> t, sampler s) { return t.calculate_unclamped_lod(s, float3(1.0f)); }
#else
// guard __HAVE_MESH__|__HAVE_CALCULATE_LOD__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_ARRAY__) || defined(__HAVE_MESH__) || defined(__HAVE_CALCULATE_LOD__)
// builtin=__metal_calculate_unclamped_lod_texture_cube_array_t cls=_texturecube_array_sample
extern "C" float probe_p06m_calculate_unclamped_lod_62(texturecube_array<float> t, sampler s) { return t.calculate_unclamped_lod(s, float3(1.0f)); }
#else
// guard __HAVE_TEXTURE_CUBE_ARRAY__|__HAVE_MESH__|__HAVE_CALCULATE_LOD__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_MESH__) || defined(__HAVE_CALCULATE_LOD__)
// builtin=__metal_calculate_unclamped_lod_texture_cube_t cls=_texturecube_sample
extern "C" float probe_p06m_calculate_unclamped_lod_63(texturecube<float> t, sampler s) { return t.calculate_unclamped_lod(s, float3(1.0f)); }
#else
// guard __HAVE_MESH__|__HAVE_CALCULATE_LOD__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_READWRITE__) || defined(__HAVE_MESH__)
// builtin=__metal_fence_texture_1d_array_t cls=_texture1d_array
extern "C" void probe_p06m_fence_64(texture1d_array<float> t) { t.fence(); }
#else
// guard __HAVE_TEXTURE_READWRITE__|__HAVE_MESH__ 無効ターゲットでは無効化
#endif

// builtin=__metal_fence_texture_1d_t cls=_texture1d
extern "C" void probe_p06m_fence_65(texture1d<float> t) { t.fence(); }

#if defined(__HAVE_TEXTURE_READWRITE__) || defined(__HAVE_MESH__)
// builtin=__metal_fence_texture_2d_array_t cls=_texture2d_array
extern "C" void probe_p06m_fence_66(texture2d_array<float> t) { t.fence(); }
#else
// guard __HAVE_TEXTURE_READWRITE__|__HAVE_MESH__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_READWRITE__) || defined(__HAVE_MESH__)
// builtin=__metal_fence_texture_2d_t cls=_texture2d
extern "C" void probe_p06m_fence_67(texture2d<float> t) { t.fence(); }
#else
// guard __HAVE_TEXTURE_READWRITE__|__HAVE_MESH__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_READWRITE__) || defined(__HAVE_MESH__)
// builtin=__metal_fence_texture_3d_t cls=_texture3d
extern "C" void probe_p06m_fence_68(texture3d<float> t) { t.fence(); }
#else
// guard __HAVE_TEXTURE_READWRITE__|__HAVE_MESH__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_BUFFER__) || defined(__HAVE_MESH__)
// builtin=__metal_fence_texture_buffer_1d_t cls=_texture_buffer
extern "C" void probe_p06m_fence_69(texture_buffer<float> t) { t.fence(); }
#else
// guard __HAVE_TEXTURE_BUFFER__|__HAVE_MESH__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_ARRAY__) || defined(__HAVE_TEXTURE_READWRITE__) || defined(__HAVE_MESH__)
// builtin=__metal_fence_texture_cube_array_t cls=_texturecube_array
extern "C" void probe_p06m_fence_70(texturecube_array<float> t) { t.fence(); }
#else
// guard __HAVE_TEXTURE_CUBE_ARRAY__|__HAVE_TEXTURE_READWRITE__|__HAVE_MESH__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_READWRITE__) || defined(__HAVE_MESH__)
// builtin=__metal_fence_texture_cube_t cls=_texturecube
extern "C" void probe_p06m_fence_71(texturecube<float> t) { t.fence(); }
#else
// guard __HAVE_TEXTURE_READWRITE__|__HAVE_MESH__ 無効ターゲットでは無効化
#endif

// builtin=__metal_gather_compare_depth_2d_t cls=_depth2d_gather
extern "C" float4 probe_p06m_gather_compare_72(depth2d<float> d, sampler s) { return d.gather_compare(s, float2(1.0f), 1.0f, int2(0)); }

#if defined(__HAVE_DEPTH_CUBE_ARRAY__) || defined(__HAVE_MESH__) || defined(__HAVE_SPARSE_TEXTURES__)
// builtin=__metal_gather_compare_depth_cube_array_t cls=_depthcube_array_gather
extern "C" sparse_color<float4> probe_p06m_sparse_gather_compare_73(depthcube_array<float> d, sampler s) { return d.sparse_gather_compare(s, float3(1.0f), 0u, 1.0f); }
#else
// guard __HAVE_DEPTH_CUBE_ARRAY__|__HAVE_MESH__|__HAVE_SPARSE_TEXTURES__ 無効ターゲットでは無効化
#endif

// builtin=__metal_gather_depth_2d_t cls=_depth2d_gather
extern "C" float4 probe_p06m_gather_74(depth2d<float> d, sampler s) { return d.gather(s, float2(1.0f), int2(0)); }

#if defined(__HAVE_DEPTH_CUBE_ARRAY__) || defined(__HAVE_MESH__) || defined(__HAVE_SPARSE_TEXTURES__)
// builtin=__metal_gather_depth_cube_array_t cls=_depthcube_array_gather
extern "C" sparse_color<float4> probe_p06m_sparse_gather_75(depthcube_array<float> d, sampler s) { return d.sparse_gather(s, float3(1.0f), 0u); }
#else
// guard __HAVE_DEPTH_CUBE_ARRAY__|__HAVE_MESH__|__HAVE_SPARSE_TEXTURES__ 無効ターゲットでは無効化
#endif

// builtin=__metal_get_array_size_depth_2d_array_t cls=_depth2d_array
extern "C" uint probe_p06m_get_array_size_76(depth2d_array<float> d) { return d.get_array_size(); }

#if defined(__HAVE_DEPTH_2D_MS_ARRAY__) || defined(__HAVE_MESH__)
// builtin=__metal_get_array_size_depth_2d_ms_array_t cls=_depth2d_ms_array
extern "C" uint probe_p06m_get_array_size_77(depth2d_ms_array<float> d) { return d.get_array_size(); }
#else
// guard __HAVE_DEPTH_2D_MS_ARRAY__|__HAVE_MESH__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_DEPTH_CUBE_ARRAY__) || defined(__HAVE_MESH__)
// builtin=__metal_get_array_size_depth_cube_array_t cls=_depthcube_array
extern "C" uint probe_p06m_get_array_size_78(depthcube_array<float> d) { return d.get_array_size(); }
#else
// guard __HAVE_DEPTH_CUBE_ARRAY__|__HAVE_MESH__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_ARRAY__) || defined(__HAVE_MESH__)
// builtin=__metal_get_array_size_texture_cube_array_t cls=_texturecube_array
extern "C" uint probe_p06m_get_array_size_79(texturecube_array<float> t) { return t.get_array_size(); }
#else
// guard __HAVE_TEXTURE_CUBE_ARRAY__|__HAVE_MESH__ 無効ターゲットでは無効化
#endif

// builtin=__metal_get_height_depth_2d_array_t cls=_depth2d_array
extern "C" uint probe_p06m_get_height_80(depth2d_array<float> d) { return d.get_height(0u); }

#if defined(__HAVE_DEPTH_2D_MS_ARRAY__) || defined(__HAVE_MESH__)
// builtin=__metal_get_height_depth_2d_ms_array_t cls=_depth2d_ms_array
extern "C" uint probe_p06m_get_height_81(depth2d_ms_array<float> d) { return d.get_height(); }
#else
// guard __HAVE_DEPTH_2D_MS_ARRAY__|__HAVE_MESH__ 無効ターゲットでは無効化
#endif

// builtin=__metal_get_height_depth_2d_t cls=_depth2d
extern "C" uint probe_p06m_get_height_82(depth2d<float> d) { return d.get_height(0u); }

#if defined(__HAVE_DEPTH_CUBE_ARRAY__) || defined(__HAVE_MESH__)
// builtin=__metal_get_height_depth_cube_array_t cls=_depthcube_array
extern "C" uint probe_p06m_get_height_83(depthcube_array<float> d) { return d.get_height(0u); }
#else
// guard __HAVE_DEPTH_CUBE_ARRAY__|__HAVE_MESH__ 無効ターゲットでは無効化
#endif

// builtin=__metal_get_height_depth_cube_t cls=_depthcube
extern "C" uint probe_p06m_get_height_84(depthcube<float> d) { return d.get_height(0u); }

#if defined(__HAVE_TEXTURE_CUBE_ARRAY__) || defined(__HAVE_MESH__)
// builtin=__metal_get_height_texture_cube_array_t cls=_texturecube_array
extern "C" uint probe_p06m_get_height_85(texturecube_array<float> t) { return t.get_height(0u); }
#else
// guard __HAVE_TEXTURE_CUBE_ARRAY__|__HAVE_MESH__ 無効ターゲットでは無効化
#endif

// builtin=__metal_get_num_mip_levels_depth_2d_t cls=_depth2d
extern "C" uint probe_p06m_get_num_mip_levels_86(depth2d<float> d) { return d.get_num_mip_levels(); }

#if defined(__HAVE_DEPTH_CUBE_ARRAY__) || defined(__HAVE_MESH__)
// builtin=__metal_get_num_mip_levels_depth_cube_array_t cls=_depthcube_array
extern "C" uint probe_p06m_get_num_mip_levels_87(depthcube_array<float> d) { return d.get_num_mip_levels(); }
#else
// guard __HAVE_DEPTH_CUBE_ARRAY__|__HAVE_MESH__ 無効ターゲットでは無効化
#endif

// builtin=__metal_get_num_mip_levels_texture_3d_t cls=_texture3d
extern "C" uint probe_p06m_get_num_mip_levels_88(texture3d<float> t) { return t.get_num_mip_levels(); }

#if defined(__HAVE_TEXTURE_CUBE_ARRAY__) || defined(__HAVE_MESH__)
// builtin=__metal_get_num_mip_levels_texture_cube_array_t cls=_texturecube_array
extern "C" uint probe_p06m_get_num_mip_levels_89(texturecube_array<float> t) { return t.get_num_mip_levels(); }
#else
// guard __HAVE_TEXTURE_CUBE_ARRAY__|__HAVE_MESH__ 無効ターゲットでは無効化
#endif

// builtin=__metal_get_num_mip_levels_texture_cube_t cls=_texturecube
extern "C" uint probe_p06m_get_num_mip_levels_90(texturecube<float> t) { return t.get_num_mip_levels(); }

#if defined(__HAVE_DEPTH_2D_MS_ARRAY__) || defined(__HAVE_MESH__)
// builtin=__metal_get_num_samples_depth_2d_ms_array_t cls=_depth2d_ms_array
extern "C" uint probe_p06m_get_num_samples_91(depth2d_ms_array<float> d) { return d.get_num_samples(); }
#else
// guard __HAVE_DEPTH_2D_MS_ARRAY__|__HAVE_MESH__ 無効ターゲットでは無効化
#endif

// builtin=__metal_get_num_samples_depth_2d_ms_t cls=_depth2d_ms
// DISABLED_BY_LOOP extern "C" uint probe_p06m_get_num_samples_92(depth2d<float> d) { return d.get_num_samples(); }

// builtin=__metal_get_width_depth_2d_array_t cls=_depth2d_array
extern "C" uint probe_p06m_get_width_93(depth2d_array<float> d) { return d.get_width(0u); }

#if defined(__HAVE_DEPTH_2D_MS_ARRAY__) || defined(__HAVE_MESH__)
// builtin=__metal_get_width_depth_2d_ms_array_t cls=_depth2d_ms_array
extern "C" uint probe_p06m_get_width_94(depth2d_ms_array<float> d) { return d.get_width(); }
#else
// guard __HAVE_DEPTH_2D_MS_ARRAY__|__HAVE_MESH__ 無効ターゲットでは無効化
#endif

// builtin=__metal_get_width_depth_2d_t cls=_depth2d
extern "C" uint probe_p06m_get_width_95(depth2d<float> d) { return d.get_width(0u); }

#if defined(__HAVE_DEPTH_CUBE_ARRAY__) || defined(__HAVE_MESH__)
// builtin=__metal_get_width_depth_cube_array_t cls=_depthcube_array
extern "C" uint probe_p06m_get_width_96(depthcube_array<float> d) { return d.get_width(0u); }
#else
// guard __HAVE_DEPTH_CUBE_ARRAY__|__HAVE_MESH__ 無効ターゲットでは無効化
#endif

// builtin=__metal_get_width_depth_cube_t cls=_depthcube
extern "C" uint probe_p06m_get_width_97(depthcube<float> d) { return d.get_width(0u); }

#if defined(__HAVE_TEXTURE_CUBE_ARRAY__) || defined(__HAVE_MESH__)
// builtin=__metal_get_width_texture_cube_array_t cls=_texturecube_array
extern "C" uint probe_p06m_get_width_98(texturecube_array<float> t) { return t.get_width(0u); }
#else
// guard __HAVE_TEXTURE_CUBE_ARRAY__|__HAVE_MESH__ 無効ターゲットでは無効化
#endif

// builtin=__metal_read_depth_2d_array_t cls=_depth2d_array_read
extern "C" float probe_p06m_read_99(depth2d_array<float> d) { return d.read(uint2(0u), 0u, 0u); }

#if defined(__HAVE_DEPTH_2D_MS_ARRAY__) || defined(__HAVE_MESH__) || defined(__HAVE_SPARSE_TEXTURES__)
// builtin=__metal_read_depth_2d_ms_array_t cls=_depth2d_ms_array_read
// DISABLED_BY_LOOP extern "C" sparse_color<T> probe_p06m_sparse_read_100(depth2d_ms_array<float> d) { return d.sparse_read(uint2(0u), 0u, 0u); }
#else
// guard __HAVE_DEPTH_2D_MS_ARRAY__|__HAVE_MESH__|__HAVE_SPARSE_TEXTURES__ 無効ターゲットでは無効化
#endif

// builtin=__metal_read_depth_2d_t cls=_depth2d_read
extern "C" float probe_p06m_read_101(depth2d<float> d) { return d.read(uint2(0u), 0u); }

#if defined(__HAVE_DEPTH_CUBE_ARRAY__) || defined(__HAVE_MESH__) || defined(__HAVE_SPARSE_TEXTURES__)
// builtin=__metal_read_depth_cube_array_t cls=_depthcube_array_read
// DISABLED_BY_LOOP extern "C" sparse_color<T> probe_p06m_sparse_read_102(depthcube_array<float> d) { return d.sparse_read(uint2(0u), 0u, 0u, 0u); }
#else
// guard __HAVE_DEPTH_CUBE_ARRAY__|__HAVE_MESH__|__HAVE_SPARSE_TEXTURES__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_DEPTH_CUBE_READ__) || defined(__HAVE_MESH__) || defined(__HAVE_SPARSE_TEXTURES__)
// builtin=__metal_read_depth_cube_t cls=_depthcube_read
// DISABLED_BY_LOOP extern "C" sparse_color<T> probe_p06m_sparse_read_103(depthcube<float> d) { return d.sparse_read(uint2(0u), 0u, 0u); }
#else
// guard __HAVE_DEPTH_CUBE_READ__|__HAVE_MESH__|__HAVE_SPARSE_TEXTURES__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_ARRAY__) || defined(__HAVE_MESH__) || defined(__HAVE_SPARSE_TEXTURES__)
// builtin=__metal_read_texture_cube_array_t cls=_texturecube_array_read
extern "C" sparse_color<float4> probe_p06m_sparse_read_104(texturecube_array<float> t) { return t.sparse_read(uint2(0u), 0u, 0u, 0u); }
#else
// guard __HAVE_TEXTURE_CUBE_ARRAY__|__HAVE_MESH__|__HAVE_SPARSE_TEXTURES__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_READ__) || defined(__HAVE_MESH__) || defined(__HAVE_SPARSE_TEXTURES__)
// builtin=__metal_read_texture_cube_t cls=_texturecube_read
extern "C" sparse_color<float4> probe_p06m_sparse_read_105(texturecube<float> t) { return t.sparse_read(uint2(0u), 0u, 0u); }
#else
// guard __HAVE_TEXTURE_CUBE_READ__|__HAVE_MESH__|__HAVE_SPARSE_TEXTURES__ 無効ターゲットでは無効化
#endif

// builtin=__metal_sample_compare_depth_2d_array_t cls=_depth2d_array_sample
extern "C" float probe_p06m_sample_compare_106(depth2d_array<float> d, sampler s) { return d.sample_compare(s, float2(1.0f), 0u, 1.0f, int2(0)); }

#if defined(__HAVE_MESH__) || defined(__HAVE_SPARSE_TEXTURES__) || defined(__HAVE_SPARSE_SAMPLE_COMPARE_GRADIENT2D_OVERLOAD__)
// builtin=__metal_sample_compare_depth_2d_array_t_grad cls=_depth2d_array_sample
// DISABLED_BY_LOOP extern "C" sparse_color<T> probe_p06m_sparse_sample_compare_107(depth2d_array<float> d, sampler s) { return d.sparse_sample_compare(s, float2(1.0f), 0u, 1.0f, gradient2d(float2(0.5f), float2(0.5f)), int2(0)); }
#else
// guard __HAVE_MESH__|__HAVE_SPARSE_TEXTURES__|__HAVE_SPARSE_SAMPLE_COMPARE_GRADIENT2D_OVERLOAD__ 無効ターゲットでは無効化
#endif

// builtin=__metal_sample_compare_depth_2d_t cls=_depth2d_sample
extern "C" float probe_p06m_sample_compare_108(depth2d<float> d, sampler s) { return d.sample_compare(s, float2(1.0f), 1.0f, int2(0)); }

#if defined(__HAVE_MESH__) || defined(__HAVE_SPARSE_TEXTURES__) || defined(__HAVE_SPARSE_SAMPLE_COMPARE_GRADIENT2D_OVERLOAD__) || defined(__HAVE_MIN_LOD_CLAMP__)
// builtin=__metal_sample_compare_depth_2d_t_grad cls=_depth2d_sample
// DISABLED_BY_LOOP extern "C" sparse_color<T> probe_p06m_sparse_sample_compare_109(depth2d<float> d, sampler s) { return d.sparse_sample_compare(s, float2(1.0f), 1.0f, gradient2d(float2(0.5f), float2(0.5f)), min_lod_clamp(1.0f), int2(0)); }
#else
// guard __HAVE_MESH__|__HAVE_SPARSE_TEXTURES__|__HAVE_SPARSE_SAMPLE_COMPARE_GRADIENT2D_OVERLOAD__|__HAVE_MIN_LOD_CLAMP__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_DEPTH_CUBE_ARRAY__) || defined(__HAVE_MESH__) || defined(__HAVE_SPARSE_TEXTURES__) || defined(__HAVE_MIN_LOD_CLAMP__) || defined(__HAVE_SPARSE_SAMPLE_COMPARE_BIAS_OVERLOAD__)
// builtin=__metal_sample_compare_depth_cube_array_t cls=_depthcube_array_sample
// DISABLED_BY_LOOP extern "C" sparse_color<T> probe_p06m_sparse_sample_compare_110(depthcube_array<float> d, sampler s) { return d.sparse_sample_compare(s, float3(1.0f), 0u, 1.0f, bias(1.0f), min_lod_clamp(1.0f)); }
#else
// guard __HAVE_DEPTH_CUBE_ARRAY__|__HAVE_MESH__|__HAVE_SPARSE_TEXTURES__|__HAVE_MIN_LOD_CLAMP__|__HAVE_SPARSE_SAMPLE_COMPARE_BIAS_OVERLOAD__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_DEPTH_CUBE_ARRAY__) || defined(__HAVE_MESH__) || defined(__HAVE_SPARSE_TEXTURES__) || defined(__HAVE_SPARSE_SAMPLE_COMPARE_GRADIENTCUBE_OVERLOAD__) || defined(__HAVE_MIN_LOD_CLAMP__)
// builtin=__metal_sample_compare_depth_cube_array_t_grad cls=_depthcube_array_sample
// DISABLED_BY_LOOP extern "C" sparse_color<T> probe_p06m_sparse_sample_compare_111(depthcube_array<float> d, sampler s) { return d.sparse_sample_compare(s, float3(1.0f), 0u, 1.0f, gradientcube(float3(0.5f), float3(0.5f)), min_lod_clamp(1.0f)); }
#else
// guard __HAVE_DEPTH_CUBE_ARRAY__|__HAVE_MESH__|__HAVE_SPARSE_TEXTURES__|__HAVE_SPARSE_SAMPLE_COMPARE_GRADIENTCUBE_OVERLOAD__|__HAVE_MIN_LOD_CLAMP__ 無効ターゲットでは無効化
#endif

// builtin=__metal_sample_compare_depth_cube_t cls=_depthcube_sample
extern "C" float probe_p06m_sample_compare_112(depthcube<float> d, sampler s) { return d.sample_compare(s, float3(1.0f), 1.0f); }

#if defined(__HAVE_MESH__) || defined(__HAVE_SPARSE_TEXTURES__) || defined(__HAVE_SAMPLE_COMPARE_GRADIENTCUBE_OVERLOAD__) || defined(__HAVE_MIN_LOD_CLAMP__)
// builtin=__metal_sample_compare_depth_cube_t_grad cls=_depthcube_sample
// DISABLED_BY_LOOP extern "C" sparse_color<T> probe_p06m_sparse_sample_compare_113(depthcube<float> d, sampler s) { return d.sparse_sample_compare(s, float3(1.0f), 1.0f, gradientcube(float3(0.5f), float3(0.5f)), min_lod_clamp(1.0f)); }
#else
// guard __HAVE_MESH__|__HAVE_SPARSE_TEXTURES__|__HAVE_SAMPLE_COMPARE_GRADIENTCUBE_OVERLOAD__|__HAVE_MIN_LOD_CLAMP__ 無効ターゲットでは無効化
#endif

// builtin=__metal_sample_depth_2d_t_grad cls=_depth2d_sample
extern "C" float probe_p06m_sample_114(depth2d<float> d, sampler s) { return d.sample(s, float2(1.0f), gradient2d(float2(0.5f), float2(0.5f)), int2(0)); }

#if defined(__HAVE_DEPTH_CUBE_ARRAY__) || defined(__HAVE_MESH__) || defined(__HAVE_SPARSE_TEXTURES__) || defined(__HAVE_MIN_LOD_CLAMP__)
// builtin=__metal_sample_depth_cube_array_t cls=_depthcube_array_sample
// DISABLED_BY_LOOP extern "C" sparse_color<T> probe_p06m_sparse_sample_115(depthcube_array<float> d, sampler s) { return d.sparse_sample(s, float3(1.0f), 0u, bias(1.0f), min_lod_clamp(1.0f)); }
#else
// guard __HAVE_DEPTH_CUBE_ARRAY__|__HAVE_MESH__|__HAVE_SPARSE_TEXTURES__|__HAVE_MIN_LOD_CLAMP__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_DEPTH_CUBE_ARRAY__) || defined(__HAVE_MESH__) || defined(__HAVE_SPARSE_TEXTURES__) || defined(__HAVE_MIN_LOD_CLAMP__)
// builtin=__metal_sample_depth_cube_array_t_grad cls=_depthcube_array_sample
// DISABLED_BY_LOOP extern "C" sparse_color<T> probe_p06m_sparse_sample_116(depthcube_array<float> d, sampler s) { return d.sparse_sample(s, float3(1.0f), 0u, gradientcube(float3(0.5f), float3(0.5f)), min_lod_clamp(1.0f)); }
#else
// guard __HAVE_DEPTH_CUBE_ARRAY__|__HAVE_MESH__|__HAVE_SPARSE_TEXTURES__|__HAVE_MIN_LOD_CLAMP__ 無効ターゲットでは無効化
#endif

// builtin=__metal_sample_texture_3d_t_grad cls=_texture3d_sample
extern "C" float4 probe_p06m_sample_117(texture3d<float> t, sampler s) { return t.sample(s, float3(1.0f), gradient3d(float3(0.5f), float3(0.5f)), int3(0)); }

#if defined(__HAVE_TEXTURE_CUBE_ARRAY__) || defined(__HAVE_MESH__) || defined(__HAVE_SPARSE_TEXTURES__) || defined(__HAVE_MIN_LOD_CLAMP__)
// builtin=__metal_sample_texture_cube_array_t cls=_texturecube_array_sample
extern "C" sparse_color<float4> probe_p06m_sparse_sample_118(texturecube_array<float> t, sampler s) { return t.sparse_sample(s, float3(1.0f), 0u, bias(1.0f), min_lod_clamp(1.0f)); }
#else
// guard __HAVE_TEXTURE_CUBE_ARRAY__|__HAVE_MESH__|__HAVE_SPARSE_TEXTURES__|__HAVE_MIN_LOD_CLAMP__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_ARRAY__) || defined(__HAVE_MESH__) || defined(__HAVE_SPARSE_TEXTURES__) || defined(__HAVE_MIN_LOD_CLAMP__)
// builtin=__metal_sample_texture_cube_array_t_grad cls=_texturecube_array_sample
extern "C" sparse_color<float4> probe_p06m_sparse_sample_119(texturecube_array<float> t, sampler s) { return t.sparse_sample(s, float3(1.0f), 0u, gradientcube(float3(0.5f), float3(0.5f)), min_lod_clamp(1.0f)); }
#else
// guard __HAVE_TEXTURE_CUBE_ARRAY__|__HAVE_MESH__|__HAVE_SPARSE_TEXTURES__|__HAVE_MIN_LOD_CLAMP__ 無効ターゲットでは無効化
#endif

// builtin=__metal_sample_texture_cube_t_grad cls=_texturecube_sample
extern "C" float4 probe_p06m_sample_120(texturecube<float> t, sampler s) { return t.sample(s, float3(1.0f), gradientcube(float3(0.5f), float3(0.5f))); }

#if defined(__HAVE_TEXTURE_CUBE_ARRAY__) || defined(__HAVE_MESH__)
// builtin=__metal_write_texture_cube_array_t cls=_texturecube_array_write
// DISABLED_BY_LOOP extern "C" void probe_p06m_write_121(texturecube_array<float> t) { t.write(float4(1.0f), uint2(0u), 0u, 0u, 0u); }
#else
// guard __HAVE_TEXTURE_CUBE_ARRAY__|__HAVE_MESH__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_WRITE__) || defined(__HAVE_MESH__)
// builtin=__metal_write_texture_cube_t cls=_texturecube_write
// DISABLED_BY_LOOP extern "C" void probe_p06m_write_122(texturecube<float> t) { t.write(float4(1.0f), uint2(0u), 0u, 0u); }
#else
// guard __HAVE_TEXTURE_CUBE_WRITE__|__HAVE_MESH__ 無効ターゲットでは無効化
#endif
