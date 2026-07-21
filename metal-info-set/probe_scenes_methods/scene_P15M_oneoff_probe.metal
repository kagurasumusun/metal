// scene P15M: max_levels<3> インスタンシング深層 oneoff (run14 delegation 実測の追調査)
// 一次情報: metal_raytracing L2280/L4192/L4237 (max_levels==2 速経路; >=3 で真 instance_count)
#include <metal_stdlib>
#include <metal_raytracing>
using namespace metal;
using namespace metal::raytracing;

extern "C" uint probe_p15m_iq_0() {
    intersection_query<instancing, max_levels<3>, triangle_data> __q;
    return __q.get_candidate_instance_count();
}

extern "C" uint probe_p15m_iq_1() {
    intersection_query<instancing, max_levels<3>, triangle_data> __q;
    return __q.get_committed_instance_count();
}

extern "C" uint probe_p15m_irr_2(instance_acceleration_structure __as) {
    ray __r;
    intersector<instancing, max_levels<3>, triangle_data> __i;
    uint __out{};
    __i.intersect(__r, __as, [&](intersection_result_ref<instancing, max_levels<3>, triangle_data> __ref){
        __out = __ref.get_instance_count();
    });
    return __out;
}
