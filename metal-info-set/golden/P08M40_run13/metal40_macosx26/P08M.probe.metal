// scene P08M: construct 系 builtin wrapper (build_construct_probes.py@1.0.0)
// 生成: 2026-07-21 — 実ヘッダ一次情報に基づく構築、実機削りループで収束
#include <metal_stdlib>
#include <metal_raytracing>
#include <metal_tensor>
#include <metal_tessellation>
using namespace metal;
using namespace metal::raytracing;

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_MULTI_LEVEL_INSTANCING__)
// builtin=__metal_get_candidate_instance_count_intersection_query cls=_intersection_query_instancing_ext
extern "C" uint probe_p08m_iq_0(void) {
    ray __r;
    intersection_query<instancing, max_levels<2>, triangle_data> __q;
    return __q.get_candidate_instance_count();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_MULTI_LEVEL_INSTANCING__)
// builtin=__metal_get_committed_instance_count_intersection_query cls=_intersection_query_instancing_ext
extern "C" uint probe_p08m_iq_1(void) {
    ray __r;
    intersection_query<instancing, max_levels<2>, triangle_data> __q;
    return __q.get_committed_instance_count();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_get_curve_parameter_intersection_result cls=_intersection_result_ref_curve_data_ext
extern "C" float probe_p08m_irr_2(instance_acceleration_structure __as) {
    ray __r;
    intersector<instancing, triangle_data, curve_data> __i;
    float __out{};
    __i.intersect(__r, __as, [&](intersection_result_ref<instancing, triangle_data, curve_data> __ref){ __out = __ref.get_curve_parameter(); });
    return (__out);
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_get_distance_intersection_result cls=intersection_result_ref
extern "C" float probe_p08m_irr_3(instance_acceleration_structure __as) {
    ray __r;
    intersector<instancing, triangle_data> __i;
    float __out{};
    __i.intersect(__r, __as, [&](intersection_result_ref<instancing, triangle_data> __ref){ __out = __ref.get_distance(); });
    return (__out);
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_get_geometry_id_intersection_result cls=intersection_result_ref
extern "C" uint probe_p08m_irr_4(instance_acceleration_structure __as) {
    ray __r;
    intersector<instancing, triangle_data> __i;
    uint __out{};
    __i.intersect(__r, __as, [&](intersection_result_ref<instancing, triangle_data> __ref){ __out = __ref.get_geometry_id(); });
    return (__out);
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_get_instance_count_intersection_result cls=_intersection_result_ref_instancing_ext
extern "C" uint probe_p08m_irr_5(instance_acceleration_structure __as) {
    ray __r;
    intersector<instancing, max_levels<2>, triangle_data> __i;
    uint __out{};
    __i.intersect(__r, __as, [&](intersection_result_ref<instancing, max_levels<2>, triangle_data> __ref){ __out = __ref.get_instance_count(); });
    return (__out);
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_get_instance_id_intersection_result cls=_intersection_result_ref_instancing_ext
extern "C" uint probe_p08m_irr_6(instance_acceleration_structure __as) {
    ray __r;
    intersector<instancing, triangle_data> __i;
    uint __out{};
    __i.intersect(__r, __as, [&](intersection_result_ref<instancing, triangle_data> __ref){ __out = __ref.get_instance_id(); });
    return (__out);
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_get_object_to_world_transform_intersection_result cls=_intersection_result_ref_world_space_data_ext
extern "C" float4x3 probe_p08m_irr_7(instance_acceleration_structure __as) {
    ray __r;
    intersector<instancing, triangle_data, world_space_data> __i;
    float4x3 __out{};
    __i.intersect(__r, __as, [&](intersection_result_ref<instancing, triangle_data, world_space_data> __ref){ __out = __ref.get_object_to_world_transform(); });
    return (__out);
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_get_primitive_id_intersection_result cls=intersection_result_ref
extern "C" uint probe_p08m_irr_8(instance_acceleration_structure __as) {
    ray __r;
    intersector<instancing, triangle_data> __i;
    uint __out{};
    __i.intersect(__r, __as, [&](intersection_result_ref<instancing, triangle_data> __ref){ __out = __ref.get_primitive_id(); });
    return (__out);
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_get_ray_direction_intersection_result cls=intersection_result_ref
extern "C" float3 probe_p08m_irr_9(instance_acceleration_structure __as) {
    ray __r;
    intersector<instancing, triangle_data> __i;
    float3 __out{};
    __i.intersect(__r, __as, [&](intersection_result_ref<instancing, triangle_data> __ref){ __out = __ref.get_ray_direction(); });
    return (__out);
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_get_ray_min_distance_intersection_result cls=intersection_result_ref
extern "C" float probe_p08m_irr_10(instance_acceleration_structure __as) {
    ray __r;
    intersector<instancing, triangle_data> __i;
    float __out{};
    __i.intersect(__r, __as, [&](intersection_result_ref<instancing, triangle_data> __ref){ __out = __ref.get_ray_min_distance(); });
    return (__out);
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_get_ray_origin_intersection_result cls=intersection_result_ref
extern "C" float3 probe_p08m_irr_11(instance_acceleration_structure __as) {
    ray __r;
    intersector<instancing, triangle_data> __i;
    float3 __out{};
    __i.intersect(__r, __as, [&](intersection_result_ref<instancing, triangle_data> __ref){ __out = __ref.get_ray_origin(); });
    return (__out);
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_get_triangle_barycentric_coord_intersection_result cls=_intersection_result_ref_triangle_data_ext
extern "C" float2 probe_p08m_irr_12(instance_acceleration_structure __as) {
    ray __r;
    intersector<instancing, triangle_data> __i;
    float2 __out{};
    __i.intersect(__r, __as, [&](intersection_result_ref<instancing, triangle_data> __ref){ __out = __ref.get_triangle_barycentric_coord(); });
    return (__out);
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_get_type_intersection_result cls=_intersection_result_ref_instancing_ext
// DISABLED_BY_LOOP extern "C" uint probe_p08m_irr_13(instance_acceleration_structure __as) {
// DISABLED_LINE     ray __r;
// DISABLED_LINE     intersector<instancing, triangle_data> __i;
// DISABLED_LINE     uint __out{};
// DISABLED_LINE     __i.intersect(__r, __as, [&](intersection_result_ref<instancing, triangle_data> __ref){ __out = __ref.get_instance_count(); });
// DISABLED_LINE     return (__out);
// DISABLED_LINE }
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_get_user_instance_id_intersection_result cls=_intersection_result_ref_instancing_ext
extern "C" uint probe_p08m_irr_14(instance_acceleration_structure __as) {
    ray __r;
    intersector<instancing, triangle_data> __i;
    uint __out{};
    __i.intersect(__r, __as, [&](intersection_result_ref<instancing, triangle_data> __ref){ __out = __ref.get_user_instance_id(); });
    return (__out);
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_get_world_to_object_transform_intersection_result cls=_intersection_result_ref_world_space_data_ext
extern "C" float4x3 probe_p08m_irr_15(instance_acceleration_structure __as) {
    ray __r;
    intersector<instancing, triangle_data, world_space_data> __i;
    float4x3 __out{};
    __i.intersect(__r, __as, [&](intersection_result_ref<instancing, triangle_data, world_space_data> __ref){ __out = __ref.get_world_to_object_transform(); });
    return (__out);
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_is_triangle_front_facing_intersection_result cls=_intersection_result_ref_triangle_data_ext
extern "C" bool probe_p08m_irr_16(instance_acceleration_structure __as) {
    ray __r;
    intersector<instancing, triangle_data> __i;
    bool __out{};
    __i.intersect(__r, __as, [&](intersection_result_ref<instancing, triangle_data> __ref){ __out = __ref.is_triangle_front_facing(); });
    return (__out);
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_TABLE_SET_BUFFERS__)
// builtin=__metal_set_visible_function_table_intersection_function_table cls=intersection_function_table
extern "C" void probe_p08m_ift_17(visible_function_table<void(uint)> vft0) {
    intersection_function_table<instancing, triangle_data> __ift;
    __ift.set_visible_function_table(vft0, 0u); return;
}
#else
// guard 無効ターゲットでは無効化
#endif

// builtin=__metal_compute_pipeline_state_t cls=type_passthrough
extern "C" compute_pipeline_state probe_p08m_type_18(compute_pipeline_state p) { return p; }

// builtin=__metal_depth_stencil_state_t cls=type_passthrough
extern "C" depth_stencil_state probe_p08m_type_19(depth_stencil_state p) { return p; }

// builtin=__metal_intersection_function_table_t cls=type_passthrough
extern "C" intersection_function_table<instancing, triangle_data> probe_p08m_type_20(intersection_function_table<instancing, triangle_data> p) { return p; }

// builtin=__metal_intersection_result_t cls=type_passthrough
extern "C" intersection_result<instancing, triangle_data> probe_p08m_type_21(intersection_result<instancing, triangle_data> p) { return p; }

// builtin=__metal_render_pipeline_state_t cls=type_passthrough
extern "C" render_pipeline_state probe_p08m_type_22(render_pipeline_state p) { return p; }

// builtin=__metal_tensor_t cls=type_passthrough
extern "C" tensor<float, extents<int, 4, 8>> probe_p08m_type_23(tensor<float, extents<int, 4, 8>> p) { return p; }

// builtin=__metal_visible_function_table_t cls=type_passthrough
extern "C" visible_function_table<void(uint)> probe_p08m_type_24(visible_function_table<void(uint)> p) { return p; }
