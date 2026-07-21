// scene P20K: imageblock implicit/explicit 両形 (MSL4.0 spec §5.6 一次情報構成)
// implicit: [[color(n)]] struct + [[imageblock_data]]
// explicit: master/view struct + [[imageblock_data(Master)]] (MSL4.0 p150 一次例)
#include <metal_stdlib>
#include <metal_graphics>
#include <metal_imageblocks>
using namespace metal;

// ---- implicit ----
struct FragImp { float4 c [[color(0)]]; };

// builtin=__metal_imageblock_implicit_read
// DISABLED_LINE [[fragment]] float4 probe_p20k_ib_iread(imageblock<FragImp, imageblock_layout_implicit> __ib [[imageblock_data]]) {
// DISABLED_LINE     FragImp __d = __ib.read(ushort2(0,0));
// DISABLED_LINE     return __d.c;
// DISABLED_LINE }

// builtin=__metal_imageblock_implicit_write
// DISABLED_LINE [[fragment]] float4 probe_p20k_ib_iwrite(imageblock<FragImp, imageblock_layout_implicit> __ib [[imageblock_data]], float4 __c) {
// DISABLED_LINE     FragImp __d; __d.c = __c;
// DISABLED_LINE     __ib.write(__d, ushort2(0,0), ushort(0), imageblock_data_rate::vertex);
// DISABLED_LINE     return __c;
// DISABLED_LINE }

// ---- explicit (master/view) ----
struct IMExp { half3 color [[raster_order_group(0)]]; };
struct IVIn { half3 color; };

// builtin=__metal_imageblock_explicit_data
// DISABLED_LINE [[fragment]] float4 probe_p20k_ib_eread(imageblock<IVIn> __ib [[imageblock_data(IMExp)]]) {
// DISABLED_LINE     threadgroup_imageblock const IVIn *__p = __ib.data(ushort2(0,0));
// DISABLED_LINE     return float4((float)__p->color.x, (float)__p->color.y, (float)__p->color.z, 1.0f);
// DISABLED_LINE }

// builtin=__metal_imageblock_explicit_mask_write
// DISABLED_LINE [[fragment]] float4 probe_p20k_ib_ewrite(imageblock<IVIn> __ib [[imageblock_data(IMExp)]], float4 __c) {
// DISABLED_LINE     IVIn __d; __d.color = half3(__c.x, __c.y, __c.z);
// DISABLED_LINE     __ib.write(__d, ushort2(0,0), ushort(0xffff));
// DISABLED_LINE     return __c;
// DISABLED_LINE }

// builtin=__metal_get_imageblock_width/height/num_colors/samples/color_coverage_mask (_imageblock_base)
// DISABLED_LINE [[fragment]] float4 probe_p20k_ib_size(imageblock<FragImp, imageblock_layout_implicit> __ib [[imageblock_data]]) {
// DISABLED_LINE     ushort2 __c(0,0);
// DISABLED_LINE     return float4(float(__ib.get_width()), float(__ib.get_height()),
// DISABLED_LINE                   float(__ib.get_num_colors(__c)) + float(__ib.get_num_samples())
// DISABLED_LINE                   + float(__ib.get_color_coverage_mask(__c, ushort(0))), 1.0f);
// DISABLED_LINE }
