// scene P25M final v3 (run25): imageblock implicit slice family + get_null_* + rt payload + resource_id + sampler/ifcd oneoff
// OK判定済 segment 結合 v3 (v2 concat bug 修正: e 系 header は 9 行 + 各 body 全行)
#include <metal_stdlib>
#include <metal_raytracing>
#include <metal_visible_function_table>
#include <metal_imageblocks>
#include <metal_texture>
#include <metal_types>
using namespace metal;
using namespace metal::raytracing;
struct IB25C { float4 a [[color(0)]]; float4 b [[color(1)]]; };
struct PL25 { float2 bary; uint tag; };
[[kernel]] void probe_p25m_islice1d(imageblock<IB25C> __ib, texture1d<float, access::write> __t [[texture(0)]], ushort2 __lid [[thread_position_in_threadgroup]]) {
    auto __s = __ib.slice<float4>(0u);
    __t.write(__s, ushort(0));
}
[[kernel]] void probe_p25m_islice1da(imageblock<IB25C> __ib, texture1d_array<float, access::write> __t [[texture(0)]], ushort2 __lid [[thread_position_in_threadgroup]]) {
    auto __s = __ib.slice<float4>(0u);
    __t.write(__s, ushort(0), ushort(0));
}
[[kernel]] void probe_p25m_islice2d(imageblock<IB25C> __ib, texture2d<float, access::write> __t [[texture(0)]], ushort2 __lid [[thread_position_in_threadgroup]]) {
    auto __s = __ib.slice<float4>(0u);
    __t.write(__s, __lid);
}
[[kernel]] void probe_p25m_islice2da(imageblock<IB25C> __ib, texture2d_array<float, access::write> __t [[texture(0)]], ushort2 __lid [[thread_position_in_threadgroup]]) {
    auto __s = __ib.slice<float4>(0u);
    __t.write(__s, __lid, ushort(0));
}
[[kernel]] void probe_p25m_islice3d(imageblock<IB25C> __ib, texture3d<float, access::write> __t [[texture(0)]], ushort2 __lid [[thread_position_in_threadgroup]]) {
    auto __s = __ib.slice<float4>(0u);
    __t.write(__s, ushort3(__lid, ushort(0)));
}
[[kernel]] void probe_p25m_islicecube(imageblock<IB25C> __ib, texturecube<float, access::write> __t [[texture(0)]], ushort2 __lid [[thread_position_in_threadgroup]]) {
    auto __s = __ib.slice<float4>(0u);
    __t.write(__s, __lid, ushort(0));
}
[[kernel]] void probe_p25m_islicecubearr(imageblock<IB25C> __ib, texturecube_array<float, access::write> __t [[texture(0)]], ushort2 __lid [[thread_position_in_threadgroup]]) {
    auto __s = __ib.slice<float4>(0u);
    __t.write(__s, __lid, ushort(0), ushort(0));
}
[[kernel]] void probe_p25m_imw(imageblock<IB25C> __ib, device float4 *__in [[buffer(0)]], ushort2 __lid [[thread_position_in_threadgroup]]) {
    ushort __m = __ib.get_color_coverage_mask(__lid, ushort(0));
    IB25C __v; __v.a = __in[0]; __v.b = __in[1];
    __ib.write(__v, __lid, __m);
}
extern "C" ushort probe_p25m_nt1d() { texture1d<float> __t; return __t.get_width(); }
extern "C" ushort probe_p25m_nt1da() { texture1d_array<float> __t; return __t.get_width(); }
extern "C" ushort probe_p25m_nt2d() { texture2d<float> __t; return __t.get_width(); }
extern "C" ushort probe_p25m_nt2da() { texture2d_array<float> __t; return __t.get_width(); }
extern "C" ushort probe_p25m_nt2ms() { texture2d_ms<float> __t; return __t.get_width(); }
extern "C" ushort probe_p25m_nt2msa() { texture2d_ms_array<float> __t; return __t.get_width(); }
extern "C" ushort probe_p25m_nt3d() { texture3d<float> __t; return __t.get_width(); }
extern "C" uint probe_p25m_ntbuf1d() { texture_buffer<float> __t; return __t.get_width(); }
extern "C" ushort probe_p25m_ntcube() { texturecube<float> __t; return __t.get_width(); }
extern "C" ushort probe_p25m_ntcubearr() { texturecube_array<float> __t; return __t.get_width(); }
extern "C" ushort probe_p25m_nd2d() { depth2d<float> __d; return __d.get_width(); }
extern "C" ushort probe_p25m_nd2ms() { depth2d_ms<float> __d; return __d.get_width(); }
extern "C" ushort probe_p25m_nd2da() { depth2d_array<float> __d; return __d.get_width(); }
extern "C" ushort probe_p25m_nd2msa() { depth2d_ms_array<float> __d; return __d.get_width(); }
extern "C" ushort probe_p25m_ndcube() { depthcube<float> __d; return __d.get_width(); }
extern "C" ushort probe_p25m_ndcubearr() { depthcube_array<float> __d; return __d.get_width(); }
extern "C" uint probe_p25m_nullvft() { visible_function_table<void(uint)> __v; return __v.size(); }
extern "C" function_handle probe_p25m_nullfh() { function_handle __h; return __h; }
extern "C" primitive_acceleration_structure probe_p25m_nullpas() { primitive_acceleration_structure __p; return __p; }
extern "C" bool probe_p25m_itpl(primitive_acceleration_structure __as, intersection_function_table<triangle_data> __ft) {
    ray __r;
    PL25 __pl;
    intersector<triangle_data> __i;
    auto __res = __i.intersect(__r, __as, __ft, __pl);
    return __pl.tag == 42u;
}
extern "C" uint probe_p25m_itplcb(primitive_acceleration_structure __as, intersection_function_table<triangle_data> __ft) {
    ray __r;
    PL25 __pl;
    uint __hits = 0;
    intersector<triangle_data> __i;
    __i.intersect(__r, __as, __ft, __pl, [&__hits](intersection_result_ref<triangle_data> __ref, const ray_data PL25 &__p2) {
        __hits += __p2.tag;
    });
    return __hits;
}
extern "C" bool probe_p25m_rtype(primitive_acceleration_structure __as, intersection_function_table<triangle_data> __ft) {
    ray __r;
    intersector<triangle_data> __i;
    bool __out = false;
    __i.intersect(__r, __as, [&](intersection_result_ref<triangle_data> __ref) {
        __out = (__ref.get_type() == intersection_type::triangle);
    });
    return __out;
}
extern "C" bool probe_p25m_ridias(instance_acceleration_structure __as) {
    MTLResourceID __rid = __as;
    return __rid._impl == 0;
}
extern "C" bool probe_p25m_ridpas(primitive_acceleration_structure __as) {
    MTLResourceID __rid = __as;
    return __rid._impl == 0;
}
[[kernel]] void probe_p25m_gsampler(texture2d<float> __t [[texture(0)]], device float4 *__out [[buffer(0)]]) {
    constexpr sampler __s(filter::linear);
    __out[0] = __t.sample(__s, float2(0.25f, 0.5f));
}
constant bool __fc25 [[function_constant(0)]];
[[kernel]] void probe_p25m_ifcd(device uint *__out [[buffer(0)]]) {
    __out[0] = is_function_constant_defined(__fc25) ? 1u : 0u;
}
