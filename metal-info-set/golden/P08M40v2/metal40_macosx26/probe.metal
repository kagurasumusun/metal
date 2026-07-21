// scene P08M: construct 系 builtin wrapper (build_construct_probes.py@1.0.0)
// 生成: 2026-07-21 — 実ヘッダ一次情報に基づく構築、実機削りループで収束
#include <metal_stdlib>
#include <metal_raytracing>
using namespace metal;
using namespace metal::raytracing;

#if defined(__HAVE_RENDER_COMMANDS__) || defined(__HAVE_RENDER_DRAW_PATCHES_TESSELLATION_FACTOR_SCALE__)
// builtin=__metal_draw_indexed_patches_render_command cls=render_command
// DISABLED_BY_LOOP extern "C" void probe_p08m_rc_0(device const uint * p0, device const void * p1, device const int * p2) {
// DISABLED_LINE     command_buffer __cb;
// DISABLED_LINE     render_command __rc(__cb, 0u);
// DISABLED_LINE     __rc.draw_indexed_patches(0u, 0u, 0u, p0, p1, 0u, 0u, p2, 0u, 1.0f); return;
// DISABLED_LINE }
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RENDER_COMMANDS__)
// builtin=__metal_draw_indexed_primitives_render_command cls=render_command
// DISABLED_BY_LOOP extern "C" void probe_p08m_rc_1(device const int * p0) {
// DISABLED_LINE     command_buffer __cb;
// DISABLED_LINE     render_command __rc(__cb, 0u);
// DISABLED_LINE     __rc.draw_indexed_primitives(primitive_type::triangle, 0u, p0, 0u, 0u, 0u); return;
// DISABLED_LINE }
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RENDER_COMMANDS__) || defined(__HAVE_RENDER_DRAW_PATCHES_TESSELLATION_FACTOR_SCALE__)
// builtin=__metal_draw_patches_render_command cls=render_command
// DISABLED_BY_LOOP extern "C" void probe_p08m_rc_2(device const uint * p0, device const int * p1) {
// DISABLED_LINE     command_buffer __cb;
// DISABLED_LINE     render_command __rc(__cb, 0u);
// DISABLED_LINE     __rc.draw_patches(0u, 0u, 0u, p0, 0u, 0u, p1, 0u, 1.0f); return;
// DISABLED_LINE }
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_MULTI_LEVEL_INSTANCING__)
// builtin=__metal_get_candidate_instance_count_intersection_query cls=_intersection_query_instancing_ext
// DISABLED_BY_LOOP extern "C" uint probe_p08m_iq_3(void) {
// DISABLED_LINE     ray __r;
// DISABLED_LINE     intersection_query<instancing, triangle_data> __q;
// DISABLED_LINE     return __q.get_candidate_instance_count();
// DISABLED_LINE }
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_MULTI_LEVEL_INSTANCING__)
// builtin=__metal_get_committed_instance_count_intersection_query cls=_intersection_query_instancing_ext
// DISABLED_BY_LOOP extern "C" uint probe_p08m_iq_4(void) {
// DISABLED_LINE     ray __r;
// DISABLED_LINE     intersection_query<instancing, triangle_data> __q;
// DISABLED_LINE     return __q.get_committed_instance_count();
// DISABLED_LINE }
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_get_curve_parameter_intersection_result cls=_intersection_result_ref_curve_data_ext
extern "C" float probe_p08m_irr_5(void) {
    ray __r;
    primitive_acceleration_structure __as;
    intersector<instancing, triangle_data> __i;
    float __out{};
// DISABLED_LINE     __i.intersect(__r, __as, [&](intersection_result_ref<instancing, triangle_data> __ref){ __out = __ref.get_curve_parameter(); });
    return (__out);
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_get_distance_intersection_result cls=intersection_result_ref
extern "C" float probe_p08m_irr_6(void) {
    ray __r;
    primitive_acceleration_structure __as;
    intersector<instancing, triangle_data> __i;
    float __out{};
// DISABLED_LINE     __i.intersect(__r, __as, [&](intersection_result_ref<instancing, triangle_data> __ref){ __out = __ref.get_distance(); });
    return (__out);
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_get_geometry_id_intersection_result cls=intersection_result_ref
extern "C" uint probe_p08m_irr_7(void) {
    ray __r;
    primitive_acceleration_structure __as;
    intersector<instancing, triangle_data> __i;
    uint __out{};
// DISABLED_LINE     __i.intersect(__r, __as, [&](intersection_result_ref<instancing, triangle_data> __ref){ __out = __ref.get_geometry_id(); });
    return (__out);
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_get_instance_count_intersection_result cls=_intersection_result_ref_instancing_ext
extern "C" uint probe_p08m_irr_8(void) {
    ray __r;
    primitive_acceleration_structure __as;
    intersector<instancing, triangle_data> __i;
    uint __out{};
// DISABLED_LINE     __i.intersect(__r, __as, [&](intersection_result_ref<instancing, triangle_data> __ref){ __out = __ref.get_instance_count(); });
    return (__out);
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_get_instance_id_intersection_result cls=_intersection_result_ref_instancing_ext
extern "C" uint probe_p08m_irr_9(void) {
    ray __r;
    primitive_acceleration_structure __as;
    intersector<instancing, triangle_data> __i;
    uint __out{};
// DISABLED_LINE     __i.intersect(__r, __as, [&](intersection_result_ref<instancing, triangle_data> __ref){ __out = __ref.get_instance_id(); });
    return (__out);
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_get_object_to_world_transform_intersection_result cls=_intersection_result_ref_world_space_data_ext
extern "C" float4x3 probe_p08m_irr_10(void) {
    ray __r;
    primitive_acceleration_structure __as;
    intersector<instancing, triangle_data> __i;
    float4x3 __out{};
// DISABLED_LINE     __i.intersect(__r, __as, [&](intersection_result_ref<instancing, triangle_data> __ref){ __out = __ref.get_object_to_world_transform(); });
    return (__out);
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_get_primitive_id_intersection_result cls=intersection_result_ref
extern "C" uint probe_p08m_irr_11(void) {
    ray __r;
    primitive_acceleration_structure __as;
    intersector<instancing, triangle_data> __i;
    uint __out{};
// DISABLED_LINE     __i.intersect(__r, __as, [&](intersection_result_ref<instancing, triangle_data> __ref){ __out = __ref.get_primitive_id(); });
    return (__out);
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_get_ray_direction_intersection_result cls=intersection_result_ref
extern "C" float3 probe_p08m_irr_12(void) {
    ray __r;
    primitive_acceleration_structure __as;
    intersector<instancing, triangle_data> __i;
    float3 __out{};
// DISABLED_LINE     __i.intersect(__r, __as, [&](intersection_result_ref<instancing, triangle_data> __ref){ __out = __ref.get_ray_direction(); });
    return (__out);
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_get_ray_min_distance_intersection_result cls=intersection_result_ref
extern "C" float probe_p08m_irr_13(void) {
    ray __r;
    primitive_acceleration_structure __as;
    intersector<instancing, triangle_data> __i;
    float __out{};
// DISABLED_LINE     __i.intersect(__r, __as, [&](intersection_result_ref<instancing, triangle_data> __ref){ __out = __ref.get_ray_min_distance(); });
    return (__out);
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_get_ray_origin_intersection_result cls=intersection_result_ref
extern "C" float3 probe_p08m_irr_14(void) {
    ray __r;
    primitive_acceleration_structure __as;
    intersector<instancing, triangle_data> __i;
    float3 __out{};
// DISABLED_LINE     __i.intersect(__r, __as, [&](intersection_result_ref<instancing, triangle_data> __ref){ __out = __ref.get_ray_origin(); });
    return (__out);
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__)
// builtin=__metal_get_size_intersection_function_table cls=intersection_result
extern "C" uint probe_p08m_ir_15(void) {
    ray __r;
    instance_acceleration_structure __as;
    intersector<instancing, triangle_data> __i;
    auto __res = __i.intersect(__r, __as);
// DISABLED_LINE     return __res.size();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_get_triangle_barycentric_coord_intersection_result cls=_intersection_result_ref_triangle_data_ext
extern "C" float2 probe_p08m_irr_16(void) {
    ray __r;
    primitive_acceleration_structure __as;
    intersector<instancing, triangle_data> __i;
    float2 __out{};
// DISABLED_LINE     __i.intersect(__r, __as, [&](intersection_result_ref<instancing, triangle_data> __ref){ __out = __ref.get_triangle_barycentric_coord(); });
    return (__out);
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_get_type_intersection_result cls=_intersection_result_ref_instancing_ext
extern "C" uint probe_p08m_irr_17(void) {
    ray __r;
    primitive_acceleration_structure __as;
    intersector<instancing, triangle_data> __i;
    uint __out{};
// DISABLED_LINE     __i.intersect(__r, __as, [&](intersection_result_ref<instancing, triangle_data> __ref){ __out = __ref.get_instance_count(); });
    return (__out);
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_get_user_instance_id_intersection_result cls=_intersection_result_ref_instancing_ext
extern "C" uint probe_p08m_irr_18(void) {
    ray __r;
    primitive_acceleration_structure __as;
    intersector<instancing, triangle_data> __i;
    uint __out{};
// DISABLED_LINE     __i.intersect(__r, __as, [&](intersection_result_ref<instancing, triangle_data> __ref){ __out = __ref.get_user_instance_id(); });
    return (__out);
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_get_world_to_object_transform_intersection_result cls=_intersection_result_ref_world_space_data_ext
extern "C" float4x3 probe_p08m_irr_19(void) {
    ray __r;
    primitive_acceleration_structure __as;
    intersector<instancing, triangle_data> __i;
    float4x3 __out{};
// DISABLED_LINE     __i.intersect(__r, __as, [&](intersection_result_ref<instancing, triangle_data> __ref){ __out = __ref.get_world_to_object_transform(); });
    return (__out);
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_is_triangle_front_facing_intersection_result cls=_intersection_result_ref_triangle_data_ext
extern "C" bool probe_p08m_irr_20(void) {
    ray __r;
    primitive_acceleration_structure __as;
    intersector<instancing, triangle_data> __i;
    bool __out{};
// DISABLED_LINE     __i.intersect(__r, __as, [&](intersection_result_ref<instancing, triangle_data> __ref){ __out = __ref.is_triangle_front_facing(); });
    return (__out);
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_TABLE_SET_BUFFERS__)
// builtin=__metal_set_buffer_intersection_function_table cls=intersection_result
extern "C" void probe_p08m_ir_21(device const void * p0) {
    ray __r;
    instance_acceleration_structure __as;
    intersector<instancing, triangle_data> __i;
    auto __res = __i.intersect(__r, __as);
// DISABLED_LINE     __res.set_buffer(p0, 0u); return;
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RENDER_COMMANDS__)
// builtin=__metal_set_fragment_buffer_render_command cls=render_command
extern "C" void probe_p08m_rc_22(device int * p0) {
    command_buffer __cb;
    render_command __rc(__cb, 0u);
    __rc.set_fragment_buffer(p0, 0u); return;
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RENDER_COMMANDS__) || defined(__HAVE_RENDER_COMMAND_RENDERING__)
// builtin=__metal_set_front_facing_winding_render_command cls=render_command
// DISABLED_BY_LOOP extern "C" void probe_p08m_rc_23(void) {
// DISABLED_LINE     command_buffer __cb;
// DISABLED_LINE     render_command __rc(__cb, 0u);
// DISABLED_LINE     __rc.set_front_facing_winding(winding::counter_clockwise); return;
// DISABLED_LINE }
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_COMPUTE_COMMANDS__)
// builtin=__metal_set_kernel_buffer_compute_command cls=compute_pipeline_state
extern "C" void probe_p08m_cc_24(device int * p0) {
    command_buffer __cb;
    compute_command __cc(__cb, 0u);
    __cc.set_kernel_buffer(p0, 0u); return;
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RENDER_COMMANDS__) || defined(__HAVE_RENDER_COMMAND_MESH__)
// builtin=__metal_set_mesh_buffer_render_command cls=render_command
extern "C" void probe_p08m_rc_25(device int * p0) {
    command_buffer __cb;
    render_command __rc(__cb, 0u);
    __rc.set_mesh_buffer(p0, 0u); return;
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RENDER_COMMANDS__) || defined(__HAVE_RENDER_COMMAND_MESH__)
// builtin=__metal_set_object_buffer_render_command cls=render_command
extern "C" void probe_p08m_rc_26(device int * p0) {
    command_buffer __cb;
    render_command __rc(__cb, 0u);
    __rc.set_object_buffer(p0, 0u); return;
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RENDER_COMMANDS__)
// builtin=__metal_set_vertex_buffer_render_command cls=render_command
extern "C" void probe_p08m_rc_27(device int * p0) {
    command_buffer __cb;
    render_command __rc(__cb, 0u);
    __rc.set_vertex_buffer(p0, 0u); return;
}
#else
// guard 無効ターゲットでは無効化
#endif

// builtin=__metal_compute_pipeline_state_t cls=type_passthrough
extern "C" compute_pipeline_state probe_p08m_type_28(compute_pipeline_state p) { return p; }

// builtin=__metal_depth_stencil_state_t cls=type_passthrough
extern "C" depth_stencil_state probe_p08m_type_29(depth_stencil_state p) { return p; }

// builtin=__metal_intersection_function_table_t cls=type_passthrough
extern "C" intersection_function_table<instancing, triangle_data> probe_p08m_type_30(intersection_function_table<instancing, triangle_data> p) { return p; }

// builtin=__metal_render_pipeline_state_t cls=type_passthrough
extern "C" render_pipeline_state probe_p08m_type_31(render_pipeline_state p) { return p; }
