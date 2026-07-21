// scene P08M: construct 系 builtin wrapper (build_construct_probes.py@1.0.0)
// 生成: 2026-07-21 — 実ヘッダ一次情報に基づく構築、実機削りループで収束
#include <metal_stdlib>
#include <metal_raytracing>
using namespace metal;
using namespace metal::raytracing;

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__)
// builtin=__metal_abort_intersection_query cls=intersection_query
extern "C" void probe_p08m_iq_0(void) {
    ray __r;
    intersection_query<instancing, triangle_data> __q;
    __q.abort(); return;
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_COMPUTE_COMMANDS__)
// builtin=__metal_clear_barrier_compute_command cls=compute_pipeline_state
extern "C" void probe_p08m_cc_1(void) {
    command_buffer __cb;
    compute_command __cc(__cb, 0u);
    __cc.clear_barrier(); return;
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RENDER_COMMANDS__) || defined(__HAVE_RENDER_COMMAND_MESH__)
// builtin=__metal_clear_barrier_render_command cls=render_command
extern "C" void probe_p08m_rc_2(void) {
    command_buffer __cb;
    render_command __rc(__cb, 0u);
    __rc.clear_barrier(); return;
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__)
// builtin=__metal_commit_bounding_box_intersection_intersection_query cls=intersection_query
extern "C" void probe_p08m_iq_3(void) {
    ray __r;
    intersection_query<instancing, triangle_data> __q;
    __q.commit_bounding_box_intersection(1.0f); return;
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_CURVES__)
// builtin=__metal_commit_curve_intersection_intersection_query cls=intersection_query
extern "C" void probe_p08m_iq_4(void) {
    ray __r;
    intersection_query<instancing, triangle_data, curve_data> __q;
    __q.commit_curve_intersection(); return;
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__)
// builtin=__metal_commit_triangle_intersection_intersection_query cls=intersection_query
extern "C" void probe_p08m_iq_5(void) {
    ray __r;
    intersection_query<instancing, triangle_data> __q;
    __q.commit_triangle_intersection(); return;
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_COMPUTE_COMMANDS__)
// builtin=__metal_concurrent_dispatch_threadgroups_compute_command cls=compute_pipeline_state
extern "C" void probe_p08m_cc_6(void) {
    command_buffer __cb;
    compute_command __cc(__cb, 0u);
    __cc.concurrent_dispatch_threadgroups(uint3(0u), uint3(0u)); return;
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_COMPUTE_COMMANDS__)
// builtin=__metal_concurrent_dispatch_threads_compute_command cls=compute_pipeline_state
extern "C" void probe_p08m_cc_7(void) {
    command_buffer __cb;
    compute_command __cc(__cb, 0u);
    __cc.concurrent_dispatch_threads(uint3(0u), uint3(0u)); return;
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_COMPUTE_COMMANDS__)
// builtin=__metal_copy_compute_command cls=compute_pipeline_state
extern "C" void probe_p08m_cc_8(compute_command cc2) {
    command_buffer __cb;
    compute_command __cc(__cb, 0u);
    __cc.copy_command(cc2); return;
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RENDER_COMMANDS__)
// builtin=__metal_copy_render_command cls=render_command
extern "C" void probe_p08m_rc_9(render_command rc2) {
    command_buffer __cb;
    render_command __rc(__cb, 0u);
    __rc.copy_command(rc2); return;
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RENDER_COMMANDS__) || defined(__HAVE_RENDER_COMMAND_MESH__)
// builtin=__metal_draw_mesh_threadgroups_render_command cls=render_command
extern "C" void probe_p08m_rc_10(void) {
    command_buffer __cb;
    render_command __rc(__cb, 0u);
    __rc.draw_mesh_threadgroups(uint3(0u), uint3(0u), uint3(0u)); return;
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RENDER_COMMANDS__) || defined(__HAVE_RENDER_COMMAND_MESH__)
// builtin=__metal_draw_mesh_threads_render_command cls=render_command
extern "C" void probe_p08m_rc_11(void) {
    command_buffer __cb;
    render_command __rc(__cb, 0u);
    __rc.draw_mesh_threads(uint3(0u), uint3(0u), uint3(0u)); return;
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RENDER_COMMANDS__)
// builtin=__metal_draw_primitives_render_command cls=render_command
extern "C" void probe_p08m_rc_12(void) {
    command_buffer __cb;
    render_command __rc(__cb, 0u);
    __rc.draw_primitives(primitive_type::triangle, 0u, 0u, 0u, 0u); return;
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_CURVES__)
// builtin=__metal_get_candidate_curve_distance_intersection_query cls=intersection_query
extern "C" float probe_p08m_iq_13(void) {
    ray __r;
    intersection_query<instancing, triangle_data, curve_data> __q;
    return __q.get_candidate_curve_distance();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_CURVES__)
// builtin=__metal_get_candidate_curve_parameter_intersection_query cls=_intersection_query_curve_data_ext
extern "C" float probe_p08m_iq_14(void) {
    ray __r;
    intersection_query<instancing, triangle_data, curve_data> __q;
    return __q.get_candidate_curve_parameter();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__)
// builtin=__metal_get_candidate_geometry_id_intersection_query cls=intersection_query
extern "C" uint probe_p08m_iq_15(void) {
    ray __r;
    intersection_query<instancing, triangle_data> __q;
    return __q.get_candidate_geometry_id();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_MULTI_LEVEL_INSTANCING__)
// builtin=__metal_get_candidate_instance_count_intersection_query cls=_intersection_query_instancing_ext
// DISABLED_BY_LOOP extern "C" uint probe_p08m_iq_16(void) {
// DISABLED_LINE     ray __r;
// DISABLED_LINE     intersection_query<instancing, triangle_data> __q;
// DISABLED_LINE     return __q.get_candidate_instance_count();
// DISABLED_LINE }
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__)
// builtin=__metal_get_candidate_instance_id_intersection_query cls=_intersection_query_instancing_ext
extern "C" uint probe_p08m_iq_17(void) {
    ray __r;
    intersection_query<instancing, triangle_data> __q;
    return __q.get_candidate_instance_id();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__)
// builtin=__metal_get_candidate_intersection_type_intersection_query cls=intersection_query
extern "C" intersection_type probe_p08m_iq_18(void) {
    ray __r;
    intersection_query<instancing, triangle_data> __q;
    return __q.get_candidate_intersection_type();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__)
// builtin=__metal_get_candidate_object_to_world_transform_intersection_query cls=_intersection_query_instancing_ext
extern "C" float4x3 probe_p08m_iq_19(void) {
    ray __r;
    intersection_query<instancing, triangle_data> __q;
    return __q.get_candidate_object_to_world_transform();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__)
// builtin=__metal_get_candidate_primitive_id_intersection_query cls=intersection_query
extern "C" uint probe_p08m_iq_20(void) {
    ray __r;
    intersection_query<instancing, triangle_data> __q;
    return __q.get_candidate_primitive_id();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__)
// builtin=__metal_get_candidate_ray_direction_intersection_query cls=intersection_query
extern "C" float3 probe_p08m_iq_21(void) {
    ray __r;
    intersection_query<instancing, triangle_data> __q;
    return __q.get_candidate_ray_direction();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__)
// builtin=__metal_get_candidate_ray_origin_intersection_query cls=intersection_query
extern "C" float3 probe_p08m_iq_22(void) {
    ray __r;
    intersection_query<instancing, triangle_data> __q;
    return __q.get_candidate_ray_origin();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__)
// builtin=__metal_get_candidate_triangle_barycentric_coord_intersection_query cls=_intersection_query_triangle_data_ext
extern "C" float2 probe_p08m_iq_23(void) {
    ray __r;
    intersection_query<instancing, triangle_data> __q;
    return __q.get_candidate_triangle_barycentric_coord();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__)
// builtin=__metal_get_candidate_triangle_distance_intersection_query cls=intersection_query
extern "C" float probe_p08m_iq_24(void) {
    ray __r;
    intersection_query<instancing, triangle_data> __q;
    return __q.get_candidate_triangle_distance();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__)
// builtin=__metal_get_candidate_user_instance_id_intersection_query cls=_intersection_query_instancing_ext
extern "C" uint probe_p08m_iq_25(void) {
    ray __r;
    intersection_query<instancing, triangle_data> __q;
    return __q.get_candidate_user_instance_id();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__)
// builtin=__metal_get_candidate_world_to_object_transform_intersection_query cls=_intersection_query_instancing_ext
extern "C" float4x3 probe_p08m_iq_26(void) {
    ray __r;
    intersection_query<instancing, triangle_data> __q;
    return __q.get_candidate_world_to_object_transform();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_CURVES__)
// builtin=__metal_get_committed_curve_parameter_intersection_query cls=_intersection_query_curve_data_ext
extern "C" float probe_p08m_iq_27(void) {
    ray __r;
    intersection_query<instancing, triangle_data, curve_data> __q;
    return __q.get_committed_curve_parameter();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__)
// builtin=__metal_get_committed_distance_intersection_query cls=intersection_query
extern "C" float probe_p08m_iq_28(void) {
    ray __r;
    intersection_query<instancing, triangle_data> __q;
    return __q.get_committed_distance();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__)
// builtin=__metal_get_committed_geometry_id_intersection_query cls=intersection_query
extern "C" uint probe_p08m_iq_29(void) {
    ray __r;
    intersection_query<instancing, triangle_data> __q;
    return __q.get_committed_geometry_id();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_MULTI_LEVEL_INSTANCING__)
// builtin=__metal_get_committed_instance_count_intersection_query cls=_intersection_query_instancing_ext
// DISABLED_BY_LOOP extern "C" uint probe_p08m_iq_30(void) {
// DISABLED_LINE     ray __r;
// DISABLED_LINE     intersection_query<instancing, triangle_data> __q;
// DISABLED_LINE     return __q.get_committed_instance_count();
// DISABLED_LINE }
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__)
// builtin=__metal_get_committed_instance_id_intersection_query cls=_intersection_query_instancing_ext
extern "C" uint probe_p08m_iq_31(void) {
    ray __r;
    intersection_query<instancing, triangle_data> __q;
    return __q.get_committed_instance_id();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__)
// builtin=__metal_get_committed_intersection_type_intersection_query cls=intersection_query
extern "C" intersection_type probe_p08m_iq_32(void) {
    ray __r;
    intersection_query<instancing, triangle_data> __q;
    return __q.get_committed_intersection_type();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__)
// builtin=__metal_get_committed_object_to_world_transform_intersection_query cls=_intersection_query_instancing_ext
extern "C" float4x3 probe_p08m_iq_33(void) {
    ray __r;
    intersection_query<instancing, triangle_data> __q;
    return __q.get_committed_object_to_world_transform();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__)
// builtin=__metal_get_committed_primitive_id_intersection_query cls=intersection_query
extern "C" uint probe_p08m_iq_34(void) {
    ray __r;
    intersection_query<instancing, triangle_data> __q;
    return __q.get_committed_primitive_id();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__)
// builtin=__metal_get_committed_ray_direction_intersection_query cls=intersection_query
extern "C" float3 probe_p08m_iq_35(void) {
    ray __r;
    intersection_query<instancing, triangle_data> __q;
    return __q.get_committed_ray_direction();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__)
// builtin=__metal_get_committed_ray_origin_intersection_query cls=intersection_query
extern "C" float3 probe_p08m_iq_36(void) {
    ray __r;
    intersection_query<instancing, triangle_data> __q;
    return __q.get_committed_ray_origin();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__)
// builtin=__metal_get_committed_triangle_barycentric_coord_intersection_query cls=_intersection_query_triangle_data_ext
extern "C" float2 probe_p08m_iq_37(void) {
    ray __r;
    intersection_query<instancing, triangle_data> __q;
    return __q.get_committed_triangle_barycentric_coord();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__)
// builtin=__metal_get_committed_user_instance_id_intersection_query cls=_intersection_query_instancing_ext
extern "C" uint probe_p08m_iq_38(void) {
    ray __r;
    intersection_query<instancing, triangle_data> __q;
    return __q.get_committed_user_instance_id();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__)
// builtin=__metal_get_committed_world_to_object_transform_intersection_query cls=_intersection_query_instancing_ext
extern "C" float4x3 probe_p08m_iq_39(void) {
    ray __r;
    intersection_query<instancing, triangle_data> __q;
    return __q.get_committed_world_to_object_transform();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_get_curve_parameter_intersection_result cls=_intersection_result_ref_curve_data_ext
extern "C" float probe_p08m_irr_40(void) {
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
extern "C" float probe_p08m_irr_41(void) {
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
extern "C" uint probe_p08m_irr_42(void) {
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

// builtin=__metal_get_instance_count_instance_acceleration_structure cls=_acceleration_structure_base
extern "C" uint probe_p08m_as_43(void) {
    instance_acceleration_structure __as;
    return __as.get_instance_count();
}

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_get_instance_count_intersection_result cls=_intersection_result_ref_instancing_ext
extern "C" uint probe_p08m_irr_44(void) {
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
extern "C" uint probe_p08m_irr_45(void) {
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

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__)
// builtin=__metal_get_intersection_params_intersection_query cls=intersection_query
extern "C" intersection_params probe_p08m_iq_46(void) {
    ray __r;
    intersection_query<instancing, triangle_data> __q;
    return __q.get_intersection_params();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__)
// builtin=__metal_get_null_instance_acceleration_structure cls=_acceleration_structure_base
extern "C" bool probe_p08m_as_47(void) {
    instance_acceleration_structure __as;
    return is_null_instance_acceleration_structure(__as);
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_get_object_to_world_transform_intersection_result cls=_intersection_result_ref_world_space_data_ext
extern "C" float4x3 probe_p08m_irr_48(void) {
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
extern "C" uint probe_p08m_irr_49(void) {
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
extern "C" float3 probe_p08m_irr_50(void) {
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

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__)
// builtin=__metal_get_ray_min_distance_intersection_query cls=intersection_query
extern "C" float probe_p08m_iq_51(void) {
    ray __r;
    intersection_query<instancing, triangle_data> __q;
    return __q.get_ray_min_distance();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_get_ray_min_distance_intersection_result cls=intersection_result_ref
extern "C" float probe_p08m_irr_52(void) {
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
extern "C" float3 probe_p08m_irr_53(void) {
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
extern "C" uint probe_p08m_ir_54(void) {
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
extern "C" float2 probe_p08m_irr_55(void) {
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
extern "C" uint probe_p08m_irr_56(void) {
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
extern "C" uint probe_p08m_irr_57(void) {
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

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__)
// builtin=__metal_get_world_space_ray_direction_intersection_query cls=intersection_query
extern "C" float3 probe_p08m_iq_58(void) {
    ray __r;
    intersection_query<instancing, triangle_data> __q;
    return __q.get_world_space_ray_direction();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__)
// builtin=__metal_get_world_space_ray_origin_intersection_query cls=intersection_query
extern "C" float3 probe_p08m_iq_59(void) {
    ray __r;
    intersection_query<instancing, triangle_data> __q;
    return __q.get_world_space_ray_origin();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_get_world_to_object_transform_intersection_result cls=_intersection_result_ref_world_space_data_ext
extern "C" float4x3 probe_p08m_irr_60(void) {
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

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__)
// builtin=__metal_is_candidate_non_opaque_bounding_box_intersection_query cls=intersection_query
extern "C" bool probe_p08m_iq_61(void) {
    ray __r;
    intersection_query<instancing, triangle_data> __q;
    return __q.is_candidate_non_opaque_bounding_box();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__)
// builtin=__metal_is_candidate_triangle_front_facing_intersection_query cls=_intersection_query_triangle_data_ext
extern "C" bool probe_p08m_iq_62(void) {
    ray __r;
    intersection_query<instancing, triangle_data> __q;
    return __q.is_candidate_triangle_front_facing();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__)
// builtin=__metal_is_committed_triangle_front_facing_intersection_query cls=_intersection_query_triangle_data_ext
extern "C" bool probe_p08m_iq_63(void) {
    ray __r;
    intersection_query<instancing, triangle_data> __q;
    return __q.is_committed_triangle_front_facing();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RAYTRACING__) || defined(__HAVE_RAYTRACING_INTERSECTION_FUNCTION_BUFFER__) || defined(__HAVE_RAYTRACING_DIRECT_ACCESS__)
// builtin=__metal_is_triangle_front_facing_intersection_result cls=_intersection_result_ref_triangle_data_ext
extern "C" bool probe_p08m_irr_64(void) {
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

#if defined(__HAVE_COMPUTE_COMMANDS__)
// builtin=__metal_reset_compute_command cls=compute_pipeline_state
extern "C" void probe_p08m_cc_65(void) {
    command_buffer __cb;
    compute_command __cc(__cb, 0u);
    __cc.reset(); return;
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RENDER_COMMANDS__)
// builtin=__metal_reset_render_command cls=render_command
extern "C" void probe_p08m_rc_66(void) {
    command_buffer __cb;
    render_command __rc(__cb, 0u);
    __rc.reset(); return;
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_COMPUTE_COMMANDS__)
// builtin=__metal_set_barrier_compute_command cls=compute_pipeline_state
extern "C" void probe_p08m_cc_67(void) {
    command_buffer __cb;
    compute_command __cc(__cb, 0u);
    __cc.set_barrier(); return;
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RENDER_COMMANDS__) || defined(__HAVE_RENDER_COMMAND_MESH__)
// builtin=__metal_set_barrier_render_command cls=render_command
extern "C" void probe_p08m_rc_68(void) {
    command_buffer __cb;
    render_command __rc(__cb, 0u);
    __rc.set_barrier(); return;
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RENDER_COMMANDS__) || defined(__HAVE_RENDER_COMMAND_RENDERING__)
// builtin=__metal_set_cull_mode_render_command cls=render_command
extern "C" void probe_p08m_rc_69(void) {
    command_buffer __cb;
    render_command __rc(__cb, 0u);
    __rc.set_cull_mode(cull_mode::back); return;
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RENDER_COMMANDS__) || defined(__HAVE_RENDER_COMMAND_DEPTH_BIAS__)
// builtin=__metal_set_depth_bias_render_command cls=render_command
extern "C" void probe_p08m_rc_70(void) {
    command_buffer __cb;
    render_command __rc(__cb, 0u);
    __rc.set_depth_bias(1.0f, 1.0f, 1.0f); return;
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RENDER_COMMANDS__) || defined(__HAVE_RENDER_COMMAND_DEPTH_CLIP_MODE__)
// builtin=__metal_set_depth_clip_mode_render_command cls=render_command
extern "C" void probe_p08m_rc_71(void) {
    command_buffer __cb;
    render_command __rc(__cb, 0u);
    __rc.set_depth_clip_mode(depth_clip_mode::clip); return;
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RENDER_COMMANDS__) || defined(__HAVE_RENDER_COMMAND_DEPTH_STENCIL_STATE__)
// builtin=__metal_set_depth_stencil_state_render_command cls=render_command
extern "C" void probe_p08m_rc_72(depth_stencil_state dss) {
    command_buffer __cb;
    render_command __rc(__cb, 0u);
    __rc.set_depth_stencil_state(dss); return;
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RENDER_COMMANDS__) || defined(__HAVE_RENDER_COMMAND_RENDERING__)
// builtin=__metal_set_front_facing_winding_render_command cls=render_command
// DISABLED_BY_LOOP extern "C" void probe_p08m_rc_73(void) {
// DISABLED_LINE     command_buffer __cb;
// DISABLED_LINE     render_command __rc(__cb, 0u);
// DISABLED_LINE     __rc.set_front_facing_winding(winding::counter_clockwise); return;
// DISABLED_LINE }
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_COMPUTE_COMMANDS__) || defined(__HAVE_COMPUTE_COMMANDS_SET_IMAGEBLOCK_SIZE__)
// builtin=__metal_set_imageblock_size_compute_command cls=compute_pipeline_state
extern "C" void probe_p08m_cc_74(void) {
    command_buffer __cb;
    compute_command __cc(__cb, 0u);
    __cc.set_imageblock_size(ushort2(0u)); return;
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RENDER_COMMANDS__) || defined(__HAVE_RENDER_COMMAND_MESH__)
// builtin=__metal_set_object_threadgroup_memory_length_render_command cls=render_command
extern "C" void probe_p08m_rc_75(void) {
    command_buffer __cb;
    render_command __rc(__cb, 0u);
    __rc.set_object_threadgroup_memory_length(0u, 0u); return;
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_COMPUTE_COMMANDS__)
// builtin=__metal_set_stage_in_region_compute_command cls=compute_pipeline_state
extern "C" void probe_p08m_cc_76(void) {
    command_buffer __cb;
    compute_command __cc(__cb, 0u);
    __cc.set_stage_in_region(uint3(0u), uint3(0u)); return;
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_COMPUTE_COMMANDS__)
// builtin=__metal_set_threadgroup_memory_length_compute_command cls=compute_pipeline_state
extern "C" void probe_p08m_cc_77(void) {
    command_buffer __cb;
    compute_command __cc(__cb, 0u);
    __cc.set_threadgroup_memory_length(0u, 0u); return;
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_RENDER_COMMANDS__) || defined(__HAVE_RENDER_COMMAND_RENDERING__)
// builtin=__metal_set_triangle_fill_mode_render_command cls=render_command
extern "C" void probe_p08m_rc_78(void) {
    command_buffer __cb;
    render_command __rc(__cb, 0u);
    __rc.set_triangle_fill_mode(triangle_fill_mode::fill); return;
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_SIMDGROUP__) || defined(__HAVE_SIMDGROUP_BALLOT__)
// builtin=__metal_simd_vote_all cls=simd_vote
extern "C" bool probe_p08m_vote_79(void) {
    simd_vote __v;
    return __v.all();
}
#else
// guard 無効ターゲットでは無効化
#endif

#if defined(__HAVE_SIMDGROUP__) || defined(__HAVE_SIMDGROUP_BALLOT__)
// builtin=__metal_simd_vote_any cls=simd_vote
extern "C" bool probe_p08m_vote_80(void) {
    simd_vote __v;
    return __v.any();
}
#else
// guard 無効ターゲットでは無効化
#endif

// builtin=__metal_compute_pipeline_state_t cls=type_passthrough
extern "C" compute_pipeline_state probe_p08m_type_81(compute_pipeline_state p) { return p; }

// builtin=__metal_depth_stencil_state_t cls=type_passthrough
extern "C" depth_stencil_state probe_p08m_type_82(depth_stencil_state p) { return p; }

// builtin=__metal_intersection_function_table_t cls=type_passthrough
extern "C" intersection_function_table<instancing, triangle_data> probe_p08m_type_83(intersection_function_table<instancing, triangle_data> p) { return p; }

// builtin=__metal_render_pipeline_state_t cls=type_passthrough
extern "C" render_pipeline_state probe_p08m_type_84(render_pipeline_state p) { return p; }
