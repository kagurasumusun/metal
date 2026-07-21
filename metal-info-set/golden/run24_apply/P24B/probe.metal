// scene P24M: 残 raytracing/ift/vft/command/patch/simdgroup/uniform/divide/select 一括 oneoff
#include <metal_stdlib>
#include <metal_raytracing>
#include <metal_visible_function_table>
#include <metal_command_buffer>
#include <metal_tessellation>
#include <metal_simdgroup_matrix>
#include <metal_uniform>
#include <metal_math>
#include <metal_relational>
using namespace metal;
using namespace metal::raytracing;

// ---- raytracing query: primitive_data / next / reset ----
// builtin=__metal_get_candidate_primitive_data_intersection_query
extern "C" const device void * probe_p24m_pdc() {
    intersection_query<instancing, triangle_data> __q;
    return __q.get_candidate_primitive_data();
}
// builtin=__metal_get_committed_primitive_data_intersection_query
extern "C" const device void * probe_p24m_pdc2() {
    intersection_query<instancing, triangle_data> __q;
    return __q.get_committed_primitive_data();
}
// builtin=__metal_get_primitive_data_intersection_result
extern "C" bool probe_p24m_pdr(instance_acceleration_structure __as) {
    ray __r;
    intersector<instancing, triangle_data> __i;
    bool __out = false;
    __i.intersect(__r, __as, [&](intersection_result_ref<instancing, triangle_data> __ref){
        __out = (__ref.get_primitive_data() != nullptr);
    });
    return __out;
}
// builtin=__metal_next_intersection_query
extern "C" bool probe_p24m_next(instance_acceleration_structure __as) {
    intersection_query<instancing, triangle_data> __q;
    ray __r;
    __q.reset(__r, __as);
    return __q.next();
}
// builtin=__metal_reset_intersection_query
extern "C" bool probe_p24m_reset(instance_acceleration_structure __as) {
    intersection_query<instancing, triangle_data> __q;
    ray __r;
    __q.reset(__r, __as);
    return true;
}

// ---- AS: is_null / resource_id / get_acceleration_structure ----
// builtin=__metal_is_null_instance_acceleration_structure
extern "C" bool probe_p24m_asnull(instance_acceleration_structure __a) {
    return metal::raytracing::is_null_instance_acceleration_structure(__a);
}
// builtin=__metal_is_null_primitive_acceleration_structure
extern "C" bool probe_p24m_asnullp(primitive_acceleration_structure __a) {
    return metal::raytracing::is_null_primitive_acceleration_structure(__a);
}
// builtin=__metal_get_instance_acceleration_structure_instance_acceleration_structure
extern "C" uint probe_p24m_subas(instance_acceleration_structure __as) {
    auto __sub = __as.get_acceleration_structure<instancing>(0u);
    return (uint)is_null_instance_acceleration_structure(__sub);
}
// builtin=__metal_get_primitive_acceleration_structure_instance_acceleration_structure
extern "C" uint probe_p24m_subasp(instance_acceleration_structure __as) {
    auto __sub = __as.get_acceleration_structure<>(0u);
    return (uint)is_null_primitive_acceleration_structure(__sub);
}

// ---- ift: get_buffer / get_visible_function_table ----
// builtin=__metal_get_buffer_intersection_function_table
extern "C" bool probe_p24m_iftbuf(intersection_function_table<instancing, triangle_data> __ift) {
    return __ift.get_buffer<device int *>(0u) != nullptr;
}
// builtin=__metal_get_visible_function_table_intersection_function_table
extern "C" bool probe_p24m_iftvft(intersection_function_table<instancing, triangle_data> __ift) {
    auto __vt = __ift.get_visible_function_table<void(uint)>(0u);
    return __vt.size() == 0u;
}

// ---- vft function pointer ----
// builtin=__metal_get_function_pointer_visible_function_table
extern "C" bool probe_p24m_vftfp(visible_function_table<void(uint)> __v) {
    auto __fp = __v[0u];
    return __fp == nullptr;
}

// ---- command_buffer size ----
// builtin=__metal_get_size_command_buffer
extern "C" ulong probe_p24m_cbsize(metal::command_buffer __cb) {
    return (ulong)__cb.size();
}

// ---- patch control point operator[] ----
struct CP { float4 p [[attribute(0)]]; };
// builtin=__metal_get_control_point
[[vertex, patch(triangle, 3)]] float4 probe_p24m_cp(patch_control_point<CP> __cp [[stage_in]], ushort __pid [[patch_id]]) {
    CP __c = __cp[__pid % 3];
    return __c.p;
}

// ---- simdgroup matrix load (結果を消費して DCE 防止) ----
// builtin=__metal_simdgroup_matrix_8x8_load
extern "C" void probe_p24m_mload(const device float *__src, device float *__dst) {
    metal::simdgroup_float8x8 __m;
    metal::simdgroup_load(__m, __src);
    metal::simdgroup_store(__m, __dst);
}

// ---- uniform is_uniform ----
// builtin=__metal_is_uniform
extern "C" int probe_p24m_unif(int __x) {
    metal::uniform<int> __u = metal::make_uniform(__x);
    int __v = __u;
    return __v;
}

// ---- divide/select (非 fold のため runtime 引数) ----
// builtin=__metal_divide
extern "C" float probe_p24m_div(float __a, float __b) { return metal::divide(__a, __b); }
// builtin=__metal_select
extern "C" float probe_p24m_sel(float __a, float __b, int __c) { return metal::select(__a, __b, __c >= 0); }
