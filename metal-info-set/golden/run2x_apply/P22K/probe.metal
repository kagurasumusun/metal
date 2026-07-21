// scene P22K: imageblock kernel 正規形 (MSL4.0 §5.6.4/§6.13 一次例どおり:
// kernel param は imageblock<T> を属性なし宣言。[[imageblock_data]] は fragment raw struct 専用)
#include <metal_stdlib>
#include <metal_graphics>
#include <metal_imageblocks>
#include <metal_texture>
using namespace metal;

struct FooImp { float4 a [[color(0)]]; int4 b [[color(1)]]; };
struct FooExp { half4 a; int b; float c; };

// builtin=__metal_get_imageblock_width/height/num_colors/samples/color_coverage_mask
[[kernel]] void probe_p22k_ib_size(imageblock<FooImp> __ib, device float *__out [[buffer(0)]], ushort2 __lid [[thread_position_in_threadgroup]]) {
    __out[0] = float(__ib.get_width());
    __out[1] = float(__ib.get_height());
    __out[2] = float(__ib.get_num_colors(__lid));
    __out[3] = float(__ib.get_num_samples());
    __out[4] = float(__ib.get_color_coverage_mask(__lid, ushort(0)));
}

// builtin=__metal_imageblock_implicit_read
[[kernel]] void probe_p22k_ib_iread(imageblock<FooImp> __ib, device float4 *__out [[buffer(0)]], ushort2 __lid [[thread_position_in_threadgroup]]) {
    FooImp __f = __ib.read(__lid);
    __out[0] = __f.a;
}

// builtin=__metal_imageblock_implicit_write
[[kernel]] void probe_p22k_ib_iwrite(imageblock<FooImp> __ib, device float4 *__in [[buffer(0)]], ushort2 __lid [[thread_position_in_threadgroup]]) {
    FooImp __f; __f.a = __in[0]; __f.b = int4(0);
    __ib.write(__f, __lid, ushort(0), imageblock_data_rate::color);
}

// builtin=__metal_imageblock_explicit_data
[[kernel]] void probe_p22k_ib_eread(imageblock<FooExp> __ib, device float4 *__out [[buffer(0)]], ushort2 __lid [[thread_position_in_threadgroup]]) {
    threadgroup_imageblock FooExp *__f = __ib.data(__lid);
    __out[0] = float4(__f->a);
}

// builtin=__metal_imageblock_explicit_mask_write
[[kernel]] void probe_p22k_ib_ewrite(imageblock<FooExp> __ib, device float4 *__in [[buffer(0)]], ushort2 __lid [[thread_position_in_threadgroup]]) {
    FooExp __f; __f.a = half4(__in[0]); __f.b = 0; __f.c = 0.0f;
    __ib.write(__f, __lid, ushort(0xffff));
}

// builtin=__metal_imageblock_implicit_data + __metal_write_imageblock_slice_to_texture_2d_t
[[kernel]] void probe_p22k_ib_slice(imageblock<FooImp> __ib, texture2d<float, access::write> __t [[texture(0)]], ushort2 __lid [[thread_position_in_threadgroup]]) {
// DISABLED_LINE     auto __s = __ib.slice(ushort(0));
// DISABLED_LINE     __t.write(__s, __lid);
}
