// scene P02: vertex/fragment 最小対 — air.vertex/air.fragment + IO metadata
// 設計一次ソース: docs/PROBING_PLAN.md §2 P2 (実機未検証)
#include <metal_stdlib>
using namespace metal;

struct VSIn  { float4 pos [[attribute(0)]]; float2 uv [[attribute(1)]]; };
struct FSIn  { float4 pos [[position]]; float2 uv; };

struct VSOut { float4 pos [[position]]; float2 uv; };

vertex VSOut probe_p02_vertex(VSIn in [[stage_in]],
                              uint vid [[vertex_id]],
                              uint iid [[instance_id]]) {
    VSOut o;
    o.pos = in.pos;
    o.uv = in.uv + float2(float(vid & 1), float(iid & 1));
    return o;
}

fragment float4 probe_p02_fragment(FSIn in [[stage_in]],
                                   texture2d<float> t [[texture(0)]],
                                   sampler s [[sampler(0)]]) {
    return t.sample(s, in.uv);
}

[[early_fragment_tests]]
fragment float4 probe_p02_fragment_rog(FSIn in [[stage_in, raster_order_group(0)]]) {
    return in.pos;
}
