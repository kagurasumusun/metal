// scene P06M: method 系 builtin wrapper (build_method_probes.py@1.0.0)
// 生成: 2026-07-21 — リモート エラー駆動削りループで収束させる
#include <metal_stdlib>
using namespace metal;

#if defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_max_explicit_texture_1d_array_t cls=_texture1d_array_atomic_modify
extern "C" void probe_p06m_atomic_max_0(texture1d_array<uint, access::read_write> t) { t.atomic_max(0, 0, ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_max_explicit_texture_1d_t cls=_texture1d_atomic_modify
extern "C" void probe_p06m_atomic_max_1(texture1d<uint, access::read_write> t) { t.atomic_max(0, ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_max_explicit_texture_2d_array_t cls=_texture2d_array_atomic_modify
extern "C" void probe_p06m_atomic_max_2(texture2d_array<uint, access::read_write> t) { t.atomic_max(ushort2(0), 0, ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_max_explicit_texture_2d_t cls=_texture2d_atomic_modify
extern "C" void probe_p06m_atomic_max_3(texture2d<uint, access::read_write> t) { t.atomic_max(ushort2(0), ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_max_explicit_texture_3d_t cls=_texture3d_atomic_modify
extern "C" void probe_p06m_atomic_max_4(texture3d<uint, access::read_write> t) { t.atomic_max(ushort3(0), ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_BUFFER__) || defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_max_explicit_texture_buffer_1d_t cls=_texture_buffer_atomic_modify
extern "C" void probe_p06m_atomic_max_5(texture_buffer<uint, access::read_write> t) { t.atomic_max(0, ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_BUFFER__|__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_ARRAY__) || defined(__HAVE_TEXTURE_CUBE_ARRAY_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_max_explicit_texture_cube_array_t cls=_texturecube_array_atomic_modify
extern "C" void probe_p06m_atomic_max_6(texturecube_array<uint, access::read_write> t) { t.atomic_max(ushort2(0), 0, 0, ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_CUBE_ARRAY__|__HAVE_TEXTURE_CUBE_ARRAY_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_max_explicit_texture_cube_t cls=_texturecube_atomic_modify
extern "C" void probe_p06m_atomic_max_7(texturecube<uint, access::read_write> t) { t.atomic_max(ushort2(0), 0, ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_CUBE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_min_explicit_texture_1d_array_t cls=_texture1d_array_atomic_modify
extern "C" void probe_p06m_atomic_min_8(texture1d_array<uint, access::read_write> t) { t.atomic_min(0, 0, ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_min_explicit_texture_1d_t cls=_texture1d_atomic_modify
extern "C" void probe_p06m_atomic_min_9(texture1d<uint, access::read_write> t) { t.atomic_min(0, ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_min_explicit_texture_2d_array_t cls=_texture2d_array_atomic_modify
extern "C" void probe_p06m_atomic_min_10(texture2d_array<uint, access::read_write> t) { t.atomic_min(ushort2(0), 0, ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_min_explicit_texture_2d_t cls=_texture2d_atomic_modify
extern "C" void probe_p06m_atomic_min_11(texture2d<uint, access::read_write> t) { t.atomic_min(ushort2(0), ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_min_explicit_texture_3d_t cls=_texture3d_atomic_modify
extern "C" void probe_p06m_atomic_min_12(texture3d<uint, access::read_write> t) { t.atomic_min(ushort3(0), ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_BUFFER__) || defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_min_explicit_texture_buffer_1d_t cls=_texture_buffer_atomic_modify
extern "C" void probe_p06m_atomic_min_13(texture_buffer<uint, access::read_write> t) { t.atomic_min(0, ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_BUFFER__|__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_ARRAY__) || defined(__HAVE_TEXTURE_CUBE_ARRAY_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_min_explicit_texture_cube_array_t cls=_texturecube_array_atomic_modify
extern "C" void probe_p06m_atomic_min_14(texturecube_array<uint, access::read_write> t) { t.atomic_min(ushort2(0), 0, 0, ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_CUBE_ARRAY__|__HAVE_TEXTURE_CUBE_ARRAY_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_min_explicit_texture_cube_t cls=_texturecube_atomic_modify
extern "C" void probe_p06m_atomic_min_15(texturecube<uint, access::read_write> t) { t.atomic_min(ushort2(0), 0, ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_CUBE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

// builtin=__metal_get_height_depth_2d_t cls=_depth2d
extern "C" uint probe_p06m_get_height_16(depth2d<float> d) { return d.get_height(0u); }

// builtin=__metal_get_num_samples_depth_2d_ms_t cls=_depth2d_ms
extern "C" uint probe_p06m_get_num_samples_17(depth2d_ms<float> d) { return d.get_num_samples(); }

// builtin=__metal_sample_texture_cube_t_grad cls=_texturecube_sample
extern "C" float4 probe_p06m_sample_18(texturecube<float> t, sampler s) { return t.sample(s, float3(1.0f), gradientcube(float3(0.5f), float3(0.5f))); }

#if defined(__HAVE_TEXTURE_CUBE_ARRAY__) || defined(__HAVE_16B_COORDS__)
// builtin=__metal_write_texture_cube_array_t cls=_texturecube_array_write
extern "C" void probe_p06m_write_19(texturecube_array<float, access::write> t) { t.write(float4(1.0f), ushort2(0), 0, 0, 0); }
#else
// guard __HAVE_TEXTURE_CUBE_ARRAY__|__HAVE_16B_COORDS__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_WRITE__) || defined(__HAVE_16B_COORDS__)
// builtin=__metal_write_texture_cube_t cls=_texturecube_write
extern "C" void probe_p06m_write_20(texturecube<float, access::write> t) { t.write(float4(1.0f), ushort2(0), 0, 0); }
#else
// guard __HAVE_TEXTURE_CUBE_WRITE__|__HAVE_16B_COORDS__ 無効ターゲットでは無効化
#endif
