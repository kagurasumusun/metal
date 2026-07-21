// scene P10T: tensor builtin wrapper (build_tensor_probes.py@1.0.0)
// 一次情報: metal_tensor ヘッダ (observer/accessor/ctor 構造実測)
#include <metal_stdlib>
#include <metal_tensor>
using namespace metal;

// builtin=__metal_get_extent_tensor cls=tensor
extern "C" int probe_p10t_extent_0(void) { tensor<float, extents<int, 4, 8>> __t; return __t.get_extent(0); }

// builtin=__metal_get_stride_tensor cls=tensor
extern "C" int probe_p10t_stride_1(void) { tensor<float, extents<int, 4, 8>> __t; return __t.get_stride(0); }

// builtin=__metal_descriptor_size_tensor cls=tensor
extern "C" ulong probe_p10t_desc_2(void) { tensor<float, extents<int, 4, 8>> __t; return descriptor_size(__t); }

// builtin=__metal_get_data_pointer_tensor cls=tensor
extern "C" ulong probe_p10t_dptr_3(void) { tensor<float, extents<int, 4, 8>> __t; return (ulong)__t[0,0]; }

// builtin=__metal_load_tensor cls=tensor
extern "C" float probe_p10t_load_4(void) { tensor<float, extents<int, 4, 8>> __t; auto __r = __t[0,0]; return __r; }

// builtin=__metal_store_tensor cls=tensor
extern "C" void probe_p10t_store_5(void) { tensor<float, extents<int, 4, 8>> __t; __t[0,0] = 1.0f; return; }

// builtin=__metal_slice_tensor cls=tensor
extern "C" int probe_p10t_slice_6(void) { tensor<float, extents<int, 4, 8>> __t; auto __s = __t.template slice<extents<int,4,4>>(0,0); return __s.get_stride(0); }

// builtin=__metal_is_null_tensor cls=tensor
extern "C" bool probe_p10t_isnull_7(void) { tensor<float, extents<int, 4, 8>> __t; return is_null_tensor(__t); }

// builtin=__metal_get_null_tensor cls=tensor
extern "C" bool probe_p10t_null_8(void) { tensor<float, extents<int, 4, 8>> __t; return is_null_tensor(__t); }

// builtin=__metal_get_tensor_handle cls=tensor
extern "C" ulong probe_p10t_handle_9(void) { tensor<float, extents<int, 4, 8>> __t; return (ulong)__t.handle(); }

// builtin=__metal_init_strided_tensor cls=tensor
extern "C" int probe_p10t_init_10(void) { tensor<float, extents<int, 4, 8>> __t; return __t.get_stride(0); }
