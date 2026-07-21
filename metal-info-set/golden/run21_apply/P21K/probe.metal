// scene P21K: imageblock class メソッド = kernel 側 (MSL4.0 §5.6.2 一次事実:
// kernel では raster_order_group 無視 / imageblock<T> クラス param valid)
#include <metal_stdlib>
#include <metal_graphics>
#include <metal_imageblocks>
#include <metal_texture>
using namespace metal;

struct FragImp { float4 c [[color(0)]]; };

// builtin=__metal_get_imageblock_width/height/num_colors/samples/color_coverage_mask
// DISABLED_LINE [[kernel]] void probe_p21k_ib_size(imageblock<FragImp> __ib [[imageblock_data]], device float *__out [[buffer(0)]]) {
// DISABLED_LINE     ushort2 __c(0,0);
// DISABLED_LINE     __out[0] = float(__ib.get_width());
// DISABLED_LINE     __out[1] = float(__ib.get_height());
// DISABLED_LINE     __out[2] = float(__ib.get_num_colors(__c));
// DISABLED_LINE     __out[3] = float(__ib.get_num_samples());
// DISABLED_LINE     __out[4] = float(__ib.get_color_coverage_mask(__c, ushort(0)));
// DISABLED_LINE }

// builtin=__metal_imageblock_implicit_read
// DISABLED_LINE [[kernel]] void probe_p21k_ib_iread(imageblock<FragImp> __ib [[imageblock_data]], device float4 *__out [[buffer(0)]]) {
// DISABLED_LINE     FragImp __d = __ib.read(ushort2(0,0));
// DISABLED_LINE     __out[0] = __d.c;
// DISABLED_LINE }

// builtin=__metal_imageblock_implicit_write
// DISABLED_LINE [[kernel]] void probe_p21k_ib_iwrite(imageblock<FragImp> __ib [[imageblock_data]], float4 __c) {
// DISABLED_LINE     FragImp __d; __d.c = __c;
// DISABLED_LINE     __ib.write(__d, ushort2(0,0), ushort(0), imageblock_data_rate::vertex);
// DISABLED_LINE }

// ---- explicit (kernel: raster_order_group は無視/不要) ----
struct IMExp { half3 color; };

// builtin=__metal_imageblock_explicit_data
// DISABLED_LINE [[kernel]] void probe_p21k_ib_eread(imageblock<IMExp> __ib [[imageblock_data(IMExp)]], device float4 *__out [[buffer(0)]]) {
// DISABLED_LINE     threadgroup_imageblock const IMExp *__p = __ib.data(ushort2(0,0));
// DISABLED_LINE     __out[0] = float4(float(__p->color.x), float(__p->color.y), float(__p->color.z), 1.0f);
// DISABLED_LINE }

// builtin=__metal_imageblock_explicit_mask_write
// DISABLED_LINE [[kernel]] void probe_p21k_ib_ewrite(imageblock<IMExp> __ib [[imageblock_data(IMExp)]], float4 __c) {
// DISABLED_LINE     IMExp __d; __d.color = half3(__c.x, __c.y, __c.z);
// DISABLED_LINE     __ib.write(__d, ushort2(0,0), ushort(0xffff));
// DISABLED_LINE }

// builtin=__metal_imageblock_implicit_data (slice→texture write 経路の slice data)
// builtin=__metal_write_imageblock_slice_to_texture_2d_t
// DISABLED_LINE [[kernel]] void probe_p21k_ib_slice(imageblock<FragImp> __ib [[imageblock_data]], texture2d<float, access::write> __t [[texture(0)]]) {
// DISABLED_LINE     auto __s = __ib.slice(0u);
// DISABLED_LINE     __t.write(__s.data(0, ushort2(0,0)).c, ushort2(0,0));
// DISABLED_LINE }
