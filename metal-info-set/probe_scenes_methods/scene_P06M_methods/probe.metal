// scene P06M: method 系 builtin wrapper (build_method_probes.py@1.0.0)
// 生成: 2026-07-21 — リモート エラー駆動削りループで収束させる
#include <metal_stdlib>
using namespace metal;

#if defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_compare_exchange_weak_explicit_texture_1d_array_t cls=_texture1d_array_atomic_compare_exchange
extern "C" bool probe_p06m_atomic_compare_exchange_weak_0(texture1d_array<uint, access::read_write> t) { uint4 loc0 = uint4(0); return t.atomic_compare_exchange_weak(0u, 0u, &loc0, uint4(0u)); }
#else
// guard __HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_compare_exchange_weak_explicit_texture_1d_t cls=_texture1d_atomic_compare_exchange
extern "C" bool probe_p06m_atomic_compare_exchange_weak_1(texture1d<uint, access::read_write> t) { uint4 loc0 = uint4(0); return t.atomic_compare_exchange_weak(0u, &loc0, uint4(0u)); }
#else
// guard __HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_compare_exchange_weak_explicit_texture_2d_array_t cls=_texture2d_array_atomic_compare_exchange
extern "C" bool probe_p06m_atomic_compare_exchange_weak_2(texture2d_array<uint, access::read_write> t) { uint4 loc0 = uint4(0); return t.atomic_compare_exchange_weak(uint2(0u), 0u, &loc0, uint4(0u)); }
#else
// guard __HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_compare_exchange_weak_explicit_texture_2d_t cls=_texture2d_atomic_compare_exchange
extern "C" bool probe_p06m_atomic_compare_exchange_weak_3(texture2d<uint, access::read_write> t) { uint4 loc0 = uint4(0); return t.atomic_compare_exchange_weak(uint2(0u), &loc0, uint4(0u)); }
#else
// guard __HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_compare_exchange_weak_explicit_texture_3d_t cls=_texture3d_atomic_compare_exchange
extern "C" bool probe_p06m_atomic_compare_exchange_weak_4(texture3d<uint, access::read_write> t) { uint4 loc0 = uint4(0); return t.atomic_compare_exchange_weak(uint3(0u), &loc0, uint4(0u)); }
#else
// guard __HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_BUFFER__) || defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_compare_exchange_weak_explicit_texture_buffer_1d_t cls=_texture_buffer_atomic_compare_exchange
extern "C" bool probe_p06m_atomic_compare_exchange_weak_5(texture_buffer<uint, access::read_write> t) { uint4 loc0 = uint4(0); return t.atomic_compare_exchange_weak(0u, &loc0, uint4(0u)); }
#else
// guard __HAVE_TEXTURE_BUFFER__|__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_ARRAY__) || defined(__HAVE_TEXTURE_CUBE_ARRAY_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_compare_exchange_weak_explicit_texture_cube_array_t cls=_texturecube_array_atomic_compare_exchange
extern "C" bool probe_p06m_atomic_compare_exchange_weak_6(texturecube_array<uint, access::read_write> t) { uint4 loc0 = uint4(0); return t.atomic_compare_exchange_weak(uint2(0u), 0u, 0u, &loc0, uint4(0u)); }
#else
// guard __HAVE_TEXTURE_CUBE_ARRAY__|__HAVE_TEXTURE_CUBE_ARRAY_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_compare_exchange_weak_explicit_texture_cube_t cls=_texturecube_atomic_compare_exchange
extern "C" bool probe_p06m_atomic_compare_exchange_weak_7(texturecube<uint, access::read_write> t) { uint4 loc0 = uint4(0); return t.atomic_compare_exchange_weak(uint2(0u), 0u, &loc0, uint4(0u)); }
#else
// guard __HAVE_TEXTURE_CUBE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_max_explicit_texture_1d_array_t cls=_texture1d_array_atomic_modify
extern "C" void probe_p06m_atomic_max_8(texture1d_array<uint, access::read_write> t) { t.atomic_max(0u, 0u, ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_max_explicit_texture_1d_t cls=_texture1d_atomic_modify
extern "C" void probe_p06m_atomic_max_9(texture1d<uint, access::read_write> t) { t.atomic_max(0u, ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_max_explicit_texture_2d_array_t cls=_texture2d_array_atomic_modify
extern "C" void probe_p06m_atomic_max_10(texture2d_array<uint, access::read_write> t) { t.atomic_max(uint2(0u), 0u, ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_max_explicit_texture_2d_t cls=_texture2d_atomic_modify
extern "C" void probe_p06m_atomic_max_11(texture2d<uint, access::read_write> t) { t.atomic_max(uint2(0u), ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_max_explicit_texture_3d_t cls=_texture3d_atomic_modify
extern "C" void probe_p06m_atomic_max_12(texture3d<uint, access::read_write> t) { t.atomic_max(uint3(0u), ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_BUFFER__) || defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_max_explicit_texture_buffer_1d_t cls=_texture_buffer_atomic_modify
extern "C" void probe_p06m_atomic_max_13(texture_buffer<uint, access::read_write> t) { t.atomic_max(0u, ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_BUFFER__|__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_ARRAY__) || defined(__HAVE_TEXTURE_CUBE_ARRAY_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_max_explicit_texture_cube_array_t cls=_texturecube_array_atomic_modify
extern "C" void probe_p06m_atomic_max_14(texturecube_array<uint, access::read_write> t) { t.atomic_max(uint2(0u), 0u, 0u, ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_CUBE_ARRAY__|__HAVE_TEXTURE_CUBE_ARRAY_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_max_explicit_texture_cube_t cls=_texturecube_atomic_modify
extern "C" void probe_p06m_atomic_max_15(texturecube<uint, access::read_write> t) { t.atomic_max(uint2(0u), 0u, ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_CUBE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_min_explicit_texture_1d_array_t cls=_texture1d_array_atomic_modify
extern "C" void probe_p06m_atomic_min_16(texture1d_array<uint, access::read_write> t) { t.atomic_min(0u, 0u, ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_min_explicit_texture_1d_t cls=_texture1d_atomic_modify
extern "C" void probe_p06m_atomic_min_17(texture1d<uint, access::read_write> t) { t.atomic_min(0u, ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_min_explicit_texture_2d_array_t cls=_texture2d_array_atomic_modify
extern "C" void probe_p06m_atomic_min_18(texture2d_array<uint, access::read_write> t) { t.atomic_min(uint2(0u), 0u, ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_min_explicit_texture_2d_t cls=_texture2d_atomic_modify
extern "C" void probe_p06m_atomic_min_19(texture2d<uint, access::read_write> t) { t.atomic_min(uint2(0u), ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_min_explicit_texture_3d_t cls=_texture3d_atomic_modify
extern "C" void probe_p06m_atomic_min_20(texture3d<uint, access::read_write> t) { t.atomic_min(uint3(0u), ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_BUFFER__) || defined(__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_min_explicit_texture_buffer_1d_t cls=_texture_buffer_atomic_modify
extern "C" void probe_p06m_atomic_min_21(texture_buffer<uint, access::read_write> t) { t.atomic_min(0u, ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_BUFFER__|__HAVE_TEXTURE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_ARRAY__) || defined(__HAVE_TEXTURE_CUBE_ARRAY_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_min_explicit_texture_cube_array_t cls=_texturecube_array_atomic_modify
extern "C" void probe_p06m_atomic_min_22(texturecube_array<uint, access::read_write> t) { t.atomic_min(uint2(0u), 0u, 0u, ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_CUBE_ARRAY__|__HAVE_TEXTURE_CUBE_ARRAY_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_RELAXED_ORDER_ATOMIC__)
// builtin=__metal_atomic_min_explicit_texture_cube_t cls=_texturecube_atomic_modify
extern "C" void probe_p06m_atomic_min_23(texturecube<uint, access::read_write> t) { t.atomic_min(uint2(0u), 0u, ulong4(0ul)); }
#else
// guard __HAVE_TEXTURE_CUBE_RELAXED_ORDER_ATOMIC__ 無効ターゲットでは無効化
#endif

// builtin=__metal_gather_texture_2d_array_t cls=_texture2d_array_gather
extern "C" float4 probe_p06m_gather_24(texture2d_array<float> t, sampler s) { return t.gather(s, float2(1.0f), 0u, int2(0), component::x); }

// builtin=__metal_gather_texture_2d_t cls=_texture2d_gather
extern "C" float4 probe_p06m_gather_25(texture2d<float> t, sampler s) { return t.gather(s, float2(1.0f), int2(0), component::x); }

#if defined(__HAVE_TEXTURE_CUBE_ARRAY__) || defined(__HAVE_MESH__) || defined(__HAVE_SPARSE_TEXTURES__)
// builtin=__metal_gather_texture_cube_array_t cls=_texturecube_array_gather
extern "C" sparse_color<float4> probe_p06m_sparse_gather_26(texturecube_array<float> t, sampler s) { return t.sparse_gather(s, float3(1.0f), 0u, component::x); }
#else
// guard __HAVE_TEXTURE_CUBE_ARRAY__|__HAVE_MESH__|__HAVE_SPARSE_TEXTURES__ 無効ターゲットでは無効化
#endif

// builtin=__metal_gather_texture_cube_t cls=_texturecube_gather
extern "C" float4 probe_p06m_gather_27(texturecube<float> t, sampler s) { return t.gather(s, float3(1.0f), component::x); }

// builtin=__metal_get_height_depth_2d_t cls=_depth2d
extern "C" uint probe_p06m_get_height_28(depth2d<float> d) { return d.get_height(0u); }

// builtin=__metal_get_num_samples_depth_2d_ms_t cls=_depth2d_ms
extern "C" uint probe_p06m_get_num_samples_29(depth2d<float> d) { return d.get_num_samples(); }

// builtin=__metal_get_width_depth_2d_t cls=_depth2d
extern "C" uint probe_p06m_get_width_30(depth2d<float> d) { return d.get_width(0u); }

// builtin=__metal_read_depth_2d_array_t cls=_depth2d_array_read
extern "C" float probe_p06m_read_31(depth2d_array<float> d) { return d.read(uint2(0u), 0u, 0u); }

#if defined(__HAVE_DEPTH_2D_MS_ARRAY__) || defined(__HAVE_MESH__) || defined(__HAVE_SPARSE_TEXTURES__)
// builtin=__metal_read_depth_2d_ms_array_t cls=_depth2d_ms_array_read
extern "C" sparse_color<float> probe_p06m_sparse_read_32(depth2d_ms_array<float> d) { return d.sparse_read(uint2(0u), 0u, 0u); }
#else
// guard __HAVE_DEPTH_2D_MS_ARRAY__|__HAVE_MESH__|__HAVE_SPARSE_TEXTURES__ 無効ターゲットでは無効化
#endif

// builtin=__metal_read_depth_2d_t cls=_depth2d_read
extern "C" float probe_p06m_read_33(depth2d<float> d) { return d.read(uint2(0u), 0u); }

#if defined(__HAVE_DEPTH_CUBE_ARRAY__) || defined(__HAVE_MESH__) || defined(__HAVE_SPARSE_TEXTURES__)
// builtin=__metal_read_depth_cube_array_t cls=_depthcube_array_read
extern "C" sparse_color<float> probe_p06m_sparse_read_34(depthcube_array<float> d) { return d.sparse_read(uint2(0u), 0u, 0u, 0u); }
#else
// guard __HAVE_DEPTH_CUBE_ARRAY__|__HAVE_MESH__|__HAVE_SPARSE_TEXTURES__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_DEPTH_CUBE_READ__) || defined(__HAVE_MESH__) || defined(__HAVE_SPARSE_TEXTURES__)
// builtin=__metal_read_depth_cube_t cls=_depthcube_read
extern "C" sparse_color<float> probe_p06m_sparse_read_35(depthcube<float> d) { return d.sparse_read(uint2(0u), 0u, 0u); }
#else
// guard __HAVE_DEPTH_CUBE_READ__|__HAVE_MESH__|__HAVE_SPARSE_TEXTURES__ 無効ターゲットでは無効化
#endif

// builtin=__metal_sample_compare_depth_2d_array_t cls=_depth2d_array_sample
extern "C" float probe_p06m_sample_compare_36(depth2d_array<float> d, sampler s) { return d.sample_compare(s, float2(1.0f), 0u, 1.0f, int2(0)); }

#if defined(__HAVE_MESH__) || defined(__HAVE_SPARSE_TEXTURES__) || defined(__HAVE_SPARSE_SAMPLE_COMPARE_GRADIENT2D_OVERLOAD__)
// builtin=__metal_sample_compare_depth_2d_array_t_grad cls=_depth2d_array_sample
extern "C" sparse_color<float> probe_p06m_sparse_sample_compare_37(depth2d_array<float> d, sampler s) { return d.sparse_sample_compare(s, float2(1.0f), 0u, 1.0f, gradient2d(float2(0.5f), float2(0.5f)), int2(0)); }
#else
// guard __HAVE_MESH__|__HAVE_SPARSE_TEXTURES__|__HAVE_SPARSE_SAMPLE_COMPARE_GRADIENT2D_OVERLOAD__ 無効ターゲットでは無効化
#endif

// builtin=__metal_sample_compare_depth_2d_t cls=_depth2d_sample
extern "C" float probe_p06m_sample_compare_38(depth2d<float> d, sampler s) { return d.sample_compare(s, float2(1.0f), 1.0f, int2(0)); }

#if defined(__HAVE_MESH__) || defined(__HAVE_SPARSE_TEXTURES__) || defined(__HAVE_SPARSE_SAMPLE_COMPARE_GRADIENT2D_OVERLOAD__) || defined(__HAVE_MIN_LOD_CLAMP__)
// builtin=__metal_sample_compare_depth_2d_t_grad cls=_depth2d_sample
extern "C" sparse_color<float> probe_p06m_sparse_sample_compare_39(depth2d<float> d, sampler s) { return d.sparse_sample_compare(s, float2(1.0f), 1.0f, gradient2d(float2(0.5f), float2(0.5f)), min_lod_clamp(1.0f), int2(0)); }
#else
// guard __HAVE_MESH__|__HAVE_SPARSE_TEXTURES__|__HAVE_SPARSE_SAMPLE_COMPARE_GRADIENT2D_OVERLOAD__|__HAVE_MIN_LOD_CLAMP__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_DEPTH_CUBE_ARRAY__) || defined(__HAVE_MESH__) || defined(__HAVE_SPARSE_TEXTURES__) || defined(__HAVE_MIN_LOD_CLAMP__) || defined(__HAVE_SPARSE_SAMPLE_COMPARE_BIAS_OVERLOAD__)
// builtin=__metal_sample_compare_depth_cube_array_t cls=_depthcube_array_sample
extern "C" sparse_color<float> probe_p06m_sparse_sample_compare_40(depthcube_array<float> d, sampler s) { return d.sparse_sample_compare(s, float3(1.0f), 0u, 1.0f, bias(1.0f), min_lod_clamp(1.0f)); }
#else
// guard __HAVE_DEPTH_CUBE_ARRAY__|__HAVE_MESH__|__HAVE_SPARSE_TEXTURES__|__HAVE_MIN_LOD_CLAMP__|__HAVE_SPARSE_SAMPLE_COMPARE_BIAS_OVERLOAD__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_DEPTH_CUBE_ARRAY__) || defined(__HAVE_MESH__) || defined(__HAVE_SPARSE_TEXTURES__) || defined(__HAVE_SPARSE_SAMPLE_COMPARE_GRADIENTCUBE_OVERLOAD__) || defined(__HAVE_MIN_LOD_CLAMP__)
// builtin=__metal_sample_compare_depth_cube_array_t_grad cls=_depthcube_array_sample
extern "C" sparse_color<float> probe_p06m_sparse_sample_compare_41(depthcube_array<float> d, sampler s) { return d.sparse_sample_compare(s, float3(1.0f), 0u, 1.0f, gradientcube(float3(0.5f), float3(0.5f)), min_lod_clamp(1.0f)); }
#else
// guard __HAVE_DEPTH_CUBE_ARRAY__|__HAVE_MESH__|__HAVE_SPARSE_TEXTURES__|__HAVE_SPARSE_SAMPLE_COMPARE_GRADIENTCUBE_OVERLOAD__|__HAVE_MIN_LOD_CLAMP__ 無効ターゲットでは無効化
#endif

// builtin=__metal_sample_compare_depth_cube_t cls=_depthcube_sample
extern "C" float probe_p06m_sample_compare_42(depthcube<float> d, sampler s) { return d.sample_compare(s, float3(1.0f), 1.0f); }

#if defined(__HAVE_MESH__) || defined(__HAVE_SPARSE_TEXTURES__) || defined(__HAVE_SAMPLE_COMPARE_GRADIENTCUBE_OVERLOAD__) || defined(__HAVE_MIN_LOD_CLAMP__)
// builtin=__metal_sample_compare_depth_cube_t_grad cls=_depthcube_sample
extern "C" sparse_color<float> probe_p06m_sparse_sample_compare_43(depthcube<float> d, sampler s) { return d.sparse_sample_compare(s, float3(1.0f), 1.0f, gradientcube(float3(0.5f), float3(0.5f)), min_lod_clamp(1.0f)); }
#else
// guard __HAVE_MESH__|__HAVE_SPARSE_TEXTURES__|__HAVE_SAMPLE_COMPARE_GRADIENTCUBE_OVERLOAD__|__HAVE_MIN_LOD_CLAMP__ 無効ターゲットでは無効化
#endif

// builtin=__metal_sample_depth_2d_t_grad cls=_depth2d_sample
extern "C" float probe_p06m_sample_44(depth2d<float> d, sampler s) { return d.sample(s, float2(1.0f), gradient2d(float2(0.5f), float2(0.5f)), int2(0)); }

#if defined(__HAVE_DEPTH_CUBE_ARRAY__) || defined(__HAVE_MESH__) || defined(__HAVE_SPARSE_TEXTURES__) || defined(__HAVE_MIN_LOD_CLAMP__)
// builtin=__metal_sample_depth_cube_array_t cls=_depthcube_array_sample
extern "C" sparse_color<float> probe_p06m_sparse_sample_45(depthcube_array<float> d, sampler s) { return d.sparse_sample(s, float3(1.0f), 0u, bias(1.0f), min_lod_clamp(1.0f)); }
#else
// guard __HAVE_DEPTH_CUBE_ARRAY__|__HAVE_MESH__|__HAVE_SPARSE_TEXTURES__|__HAVE_MIN_LOD_CLAMP__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_DEPTH_CUBE_ARRAY__) || defined(__HAVE_MESH__) || defined(__HAVE_SPARSE_TEXTURES__) || defined(__HAVE_MIN_LOD_CLAMP__)
// builtin=__metal_sample_depth_cube_array_t_grad cls=_depthcube_array_sample
extern "C" sparse_color<float> probe_p06m_sparse_sample_46(depthcube_array<float> d, sampler s) { return d.sparse_sample(s, float3(1.0f), 0u, gradientcube(float3(0.5f), float3(0.5f)), min_lod_clamp(1.0f)); }
#else
// guard __HAVE_DEPTH_CUBE_ARRAY__|__HAVE_MESH__|__HAVE_SPARSE_TEXTURES__|__HAVE_MIN_LOD_CLAMP__ 無効ターゲットでは無効化
#endif

// builtin=__metal_sample_texture_cube_t_grad cls=_texturecube_sample
extern "C" float4 probe_p06m_sample_47(texturecube<float> t, sampler s) { return t.sample(s, float3(1.0f), gradientcube(float3(0.5f), float3(0.5f))); }

#if defined(__HAVE_TEXTURE_CUBE_ARRAY__) || defined(__HAVE_MESH__)
// builtin=__metal_write_texture_cube_array_t cls=_texturecube_array_write
extern "C" void probe_p06m_write_48(texturecube_array<float> t) { t.write(float4(1.0f), uint2(0u), 0u, 0u, 0u); }
#else
// guard __HAVE_TEXTURE_CUBE_ARRAY__|__HAVE_MESH__ 無効ターゲットでは無効化
#endif

#if defined(__HAVE_TEXTURE_CUBE_WRITE__) || defined(__HAVE_MESH__)
// builtin=__metal_write_texture_cube_t cls=_texturecube_write
extern "C" void probe_p06m_write_49(texturecube<float> t) { t.write(float4(1.0f), uint2(0u), 0u, 0u); }
#else
// guard __HAVE_TEXTURE_CUBE_WRITE__|__HAVE_MESH__ 無効ターゲットでは無効化
#endif
