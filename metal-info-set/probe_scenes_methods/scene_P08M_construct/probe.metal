// scene P08M: construct 系 builtin wrapper (build_construct_probes.py@1.0.0)
// 生成: 2026-07-21 — 実ヘッダ一次情報に基づく構築、実機削りループで収束
#include <metal_stdlib>
#include <metal_raytracing>
using namespace metal;
using namespace metal::raytracing;

#if defined(__HAVE_RENDER_COMMANDS__) || defined(__HAVE_RENDER_DRAW_PATCHES_TESSELLATION_FACTOR_SCALE__)
// builtin=__metal_draw_indexed_patches_render_command cls=render_command
extern "C" void probe_p08m_rc_0(device const uint * p0, device const void * p1, device const int * p2) {
    command_buffer __cb;
    render_command __rc(__cb, 0u);
    __rc.draw_indexed_patches(0u, 0u, 0u, p0, p1, 0u, 0u, p2, 0u, 1.0f); return;
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RENDER_COMMANDS__)
// builtin=__metal_draw_indexed_primitives_render_command cls=render_command
extern "C" void probe_p08m_rc_1(device const int * p0) {
    command_buffer __cb;
    render_command __rc(__cb, 0u);
    __rc.draw_indexed_primitives(primitive_type::triangle, 0u, p0, 0u, 0u, 0u); return;
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RENDER_COMMANDS__) || defined(__HAVE_RENDER_DRAW_PATCHES_TESSELLATION_FACTOR_SCALE__)
// builtin=__metal_draw_patches_render_command cls=render_command
extern "C" void probe_p08m_rc_2(device const uint * p0, device const int * p1) {
    command_buffer __cb;
    render_command __rc(__cb, 0u);
    __rc.draw_patches(0u, 0u, 0u, p0, 0u, 0u, p1, 0u, 1.0f); return;
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_MULTI_LEVEL_INSTANCING__)
// builtin=__metal_get_candidate_instance_count_intersection_query cls=_intersection_query_instancing_ext
extern "C" uint probe_p08m_iq_3(void) {
    ray __r;
    intersection_query<instancing, triangle_data> __q;
    return __q.get_candidate_instance_count();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_MULTI_LEVEL_INSTANCING__)
// builtin=__metal_get_committed_instance_count_intersection_query cls=_intersection_query_instancing_ext
extern "C" uint probe_p08m_iq_4(void) {
    ray __r;
    intersection_query<instancing, triangle_data> __q;
    return __q.get_committed_instance_count();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_get_curve_parameter_intersection_result cls=_intersection_result_ref_curve_data_ext
extern "C" float probe_p08m_irr_5(primitive_acceleration_structure __as) {
    ray __r;
    intersector<instancing, triangle_data> __i;
    float __out{};
    __i.intersect(__r, __as, [&](intersection_result_ref<instancing, triangle_data> __ref){ __out = __ref.get_curve_parameter(); });
    return (__out);
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_get_distance_intersection_result cls=intersection_result_ref
extern "C" float probe_p08m_irr_6(primitive_acceleration_structure __as) {
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
extern "C" uint probe_p08m_irr_7(primitive_acceleration_structure __as) {
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
extern "C" uint probe_p08m_irr_8(primitive_acceleration_structure __as) {
    ray __r;
    intersector<instancing, triangle_data> __i;
    uint __out{};
    __i.intersect(__r, __as, [&](intersection_result_ref<instancing, triangle_data> __ref){ __out = __ref.get_instance_count(); });
    return (__out);
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_get_instance_id_intersection_result cls=_intersection_result_ref_instancing_ext
extern "C" uint probe_p08m_irr_9(primitive_acceleration_structure __as) {
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
extern "C" float4x3 probe_p08m_irr_10(primitive_acceleration_structure __as) {
    ray __r;
    intersector<instancing, triangle_data> __i;
    float4x3 __out{};
    __i.intersect(__r, __as, [&](intersection_result_ref<instancing, triangle_data> __ref){ __out = __ref.get_object_to_world_transform(); });
    return (__out);
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_get_primitive_id_intersection_result cls=intersection_result_ref
extern "C" uint probe_p08m_irr_11(primitive_acceleration_structure __as) {
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
extern "C" float3 probe_p08m_irr_12(primitive_acceleration_structure __as) {
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
extern "C" float probe_p08m_irr_13(primitive_acceleration_structure __as) {
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
extern "C" float3 probe_p08m_irr_14(primitive_acceleration_structure __as) {
    ray __r;
    intersector<instancing, triangle_data> __i;
    float3 __out{};
    __i.intersect(__r, __as, [&](intersection_result_ref<instancing, triangle_data> __ref){ __out = __ref.get_ray_origin(); });
    return (__out);
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__)
// builtin=__metal_get_size_intersection_function_table cls=intersection_function_table
extern "C" uint probe_p08m_ift_15(void) {
    intersection_function_table<instancing, triangle_data> __ift;
    return __ift.size();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_get_triangle_barycentric_coord_intersection_result cls=_intersection_result_ref_triangle_data_ext
extern "C" float2 probe_p08m_irr_16(primitive_acceleration_structure __as) {
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
extern "C" uint probe_p08m_irr_17(primitive_acceleration_structure __as) {
    ray __r;
    intersector<instancing, triangle_data> __i;
    uint __out{};
    __i.intersect(__r, __as, [&](intersection_result_ref<instancing, triangle_data> __ref){ __out = __ref.get_instance_count(); });
    return (__out);
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_get_user_instance_id_intersection_result cls=_intersection_result_ref_instancing_ext
extern "C" uint probe_p08m_irr_18(primitive_acceleration_structure __as) {
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
extern "C" float4x3 probe_p08m_irr_19(primitive_acceleration_structure __as) {
    ray __r;
    intersector<instancing, triangle_data> __i;
    float4x3 __out{};
    __i.intersect(__r, __as, [&](intersection_result_ref<instancing, triangle_data> __ref){ __out = __ref.get_world_to_object_transform(); });
    return (__out);
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_INTERPOLATION_FUNCTIONS__)
// builtin=__metal_interpolate_center_no_perspective cls=interpolant
extern "C" int probe_p08m_ip_20(void) {
    interpolant<float, interpolation::no_perspective> __ip;
    return __ip.interpolate_at_center();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_INTERPOLATION_FUNCTIONS__)
// builtin=__metal_interpolate_center_perspective cls=interpolant
extern "C" int probe_p08m_ip_21(void) {
    interpolant<float, interpolation::perspective> __ip;
    return __ip.interpolate_at_center();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_INTERPOLATION_FUNCTIONS__)
// builtin=__metal_interpolate_centroid_no_perspective cls=interpolant
extern "C" int probe_p08m_ip_22(void) {
    interpolant<float, interpolation::no_perspective> __ip;
    return __ip.interpolate_at_centroid();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_INTERPOLATION_FUNCTIONS__)
// builtin=__metal_interpolate_centroid_perspective cls=interpolant
extern "C" int probe_p08m_ip_23(void) {
    interpolant<float, interpolation::perspective> __ip;
    return __ip.interpolate_at_centroid();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_INTERPOLATION_FUNCTIONS__)
// builtin=__metal_interpolate_offset_no_perspective cls=interpolant
extern "C" int probe_p08m_ip_24(void) {
    interpolant<float, interpolation::no_perspective> __ip;
    return __ip.interpolate_at_offset(float2(0.0f));
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_INTERPOLATION_FUNCTIONS__)
// builtin=__metal_interpolate_offset_perspective cls=interpolant
extern "C" int probe_p08m_ip_25(void) {
    interpolant<float, interpolation::perspective> __ip;
    return __ip.interpolate_at_offset(float2(0.0f));
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_INTERPOLATION_FUNCTIONS__)
// builtin=__metal_interpolate_sample_no_perspective cls=interpolant
extern "C" int probe_p08m_ip_26(void) {
    interpolant<float, interpolation::no_perspective> __ip;
    return __ip.interpolate_at_sample(0u);
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_INTERPOLATION_FUNCTIONS__)
// builtin=__metal_interpolate_sample_perspective cls=interpolant
extern "C" int probe_p08m_ip_27(void) {
    interpolant<float, interpolation::perspective> __ip;
    return __ip.interpolate_at_sample(0u);
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_is_triangle_front_facing_intersection_result cls=_intersection_result_ref_triangle_data_ext
extern "C" bool probe_p08m_irr_28(primitive_acceleration_structure __as) {
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
// builtin=__metal_set_buffer_intersection_function_table cls=intersection_function_table
extern "C" void probe_p08m_ift_29(device const void * p0) {
    intersection_function_table<instancing, triangle_data> __ift;
    __ift.set_buffer(p0, 0u); return;
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RENDER_COMMANDS__) || defined(__HAVE_RENDER_COMMAND_RENDERING__)
// builtin=__metal_set_front_facing_winding_render_command cls=render_command
extern "C" void probe_p08m_rc_30(void) {
    command_buffer __cb;
    render_command __rc(__cb, 0u);
    __rc.set_front_facing_winding(winding::counter_clockwise); return;
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_TABLE_SET_BUFFERS__)
// builtin=__metal_set_visible_function_table_intersection_function_table cls=intersection_function_table
extern "C" void probe_p08m_ift_31(visible_function_table<> vft0) {
    intersection_function_table<instancing, triangle_data> __ift;
    __ift.set_visible_function_table(vft0, 0u); return;
}
#else
// guard 無効ターゲットでは無効化
#endif

// builtin=__metal_compute_pipeline_state_t cls=type_passthrough
extern "C" compute_pipeline_state probe_p08m_type_32(compute_pipeline_state p) { return p; }

// builtin=__metal_depth_stencil_state_t cls=type_passthrough
extern "C" depth_stencil_state probe_p08m_type_33(depth_stencil_state p) { return p; }

// builtin=__metal_intersection_function_table_t cls=type_passthrough
extern "C" intersection_function_table<instancing, triangle_data> probe_p08m_type_34(intersection_function_table<instancing, triangle_data> p) { return p; }

// builtin=__metal_intersection_result_t cls=type_passthrough
extern "C" intersection_result<instancing, triangle_data> probe_p08m_type_35(intersection_result<instancing, triangle_data> p) { return p; }

// builtin=__metal_render_pipeline_state_t cls=type_passthrough
extern "C" render_pipeline_state probe_p08m_type_36(render_pipeline_state p) { return p; }

// builtin=__metal_visible_function_table_t cls=type_passthrough
extern "C" visible_function_table<> probe_p08m_type_37(visible_function_table<> p) { return p; }
