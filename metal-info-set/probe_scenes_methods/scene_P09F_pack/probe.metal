// scene P09F: pack/unpack builtin wrapper (build_pack_probes.py@1.0.0)
// 一次情報: metal_pixel _pixel_type_traits (pack/unpack 直通) + _is_pixel_type 許容 T
#include <metal_stdlib>
#include <metal_pixel>
using namespace metal;

// builtin=__metal_pack_snorm1x16 cls=pixel_traits tag=_r16snorm_tag
extern "C" ushort probe_p09f_pack_0(float a) { return _pixel_type_traits<_r16snorm_tag>::pack(a); }

// builtin=__metal_unpack_snorm1x16 cls=pixel_traits tag=_r16snorm_tag
extern "C" float probe_p09f_unpack_1(ushort a) { return _pixel_type_traits<_r16snorm_tag>::unpack<float>(a); }

// builtin=__metal_pack_unorm1x16 cls=pixel_traits tag=_r16unorm_tag
extern "C" ushort probe_p09f_pack_2(float a) { return _pixel_type_traits<_r16unorm_tag>::pack(a); }

// builtin=__metal_unpack_unorm1x16 cls=pixel_traits tag=_r16unorm_tag
extern "C" float probe_p09f_unpack_3(ushort a) { return _pixel_type_traits<_r16unorm_tag>::unpack<float>(a); }

// builtin=__metal_pack_snorm1x8 cls=pixel_traits tag=_r8snorm_tag
extern "C" uchar probe_p09f_pack_4(half a) { return _pixel_type_traits<_r8snorm_tag>::pack(a); }

// builtin=__metal_unpack_snorm1x8 cls=pixel_traits tag=_r8snorm_tag
extern "C" half probe_p09f_unpack_5(uchar a) { return _pixel_type_traits<_r8snorm_tag>::unpack<half>(a); }

// builtin=__metal_pack_unorm1x8 cls=pixel_traits tag=_r8unorm_tag
extern "C" uchar probe_p09f_pack_6(half a) { return _pixel_type_traits<_r8unorm_tag>::pack(a); }

// builtin=__metal_unpack_unorm1x8 cls=pixel_traits tag=_r8unorm_tag
extern "C" half probe_p09f_unpack_7(uchar a) { return _pixel_type_traits<_r8unorm_tag>::unpack<half>(a); }

// builtin=__metal_pack_unorm_rg11b10f cls=pixel_traits tag=_rg11b10f_tag
extern "C" uint probe_p09f_pack_8(half3 a) { return _pixel_type_traits<_rg11b10f_tag>::pack(a); }

// builtin=__metal_unpack_unorm_rg11b10f cls=pixel_traits tag=_rg11b10f_tag
extern "C" half3 probe_p09f_unpack_9(uint a) { return _pixel_type_traits<_rg11b10f_tag>::unpack<half3>(a); }

// builtin=__metal_pack_snorm2x8 cls=pixel_traits tag=_rg8snorm_tag
extern "C" ushort probe_p09f_pack_10(half2 a) { return _pixel_type_traits<_rg8snorm_tag>::pack(a); }

// builtin=__metal_unpack_snorm2x8 cls=pixel_traits tag=_rg8snorm_tag
extern "C" half2 probe_p09f_unpack_11(ushort a) { return _pixel_type_traits<_rg8snorm_tag>::unpack<half2>(a); }

// builtin=__metal_pack_unorm2x8 cls=pixel_traits tag=_rg8unorm_tag
extern "C" ushort probe_p09f_pack_12(half2 a) { return _pixel_type_traits<_rg8unorm_tag>::pack(a); }

// builtin=__metal_unpack_unorm2x8 cls=pixel_traits tag=_rg8unorm_tag
extern "C" half2 probe_p09f_unpack_13(ushort a) { return _pixel_type_traits<_rg8unorm_tag>::unpack<half2>(a); }

// builtin=__metal_pack_unorm_rgb9e5 cls=pixel_traits tag=_rgb9e5_tag
extern "C" uint probe_p09f_pack_14(half3 a) { return _pixel_type_traits<_rgb9e5_tag>::pack(a); }

// builtin=__metal_unpack_unorm_rgb9e5 cls=pixel_traits tag=_rgb9e5_tag
extern "C" half3 probe_p09f_unpack_15(uint a) { return _pixel_type_traits<_rgb9e5_tag>::unpack<half3>(a); }

// builtin=__metal_pack_snorm4x16 cls=pixel_traits tag=_rgba16snorm_tag
extern "C" size_t probe_p09f_pack_16(float4 a) { return _pixel_type_traits<_rgba16snorm_tag>::pack(a); }

// builtin=__metal_unpack_snorm4x16 cls=pixel_traits tag=_rgba16snorm_tag
extern "C" float4 probe_p09f_unpack_17(size_t a) { return _pixel_type_traits<_rgba16snorm_tag>::unpack<float4>(a); }

// builtin=__metal_pack_unorm4x16 cls=pixel_traits tag=_rgba16unorm_tag
extern "C" size_t probe_p09f_pack_18(float4 a) { return _pixel_type_traits<_rgba16unorm_tag>::pack(a); }

// builtin=__metal_unpack_unorm4x16 cls=pixel_traits tag=_rgba16unorm_tag
extern "C" float4 probe_p09f_unpack_19(size_t a) { return _pixel_type_traits<_rgba16unorm_tag>::unpack<float4>(a); }
