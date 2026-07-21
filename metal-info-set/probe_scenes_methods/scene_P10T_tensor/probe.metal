// scene P10T: tensor builtin wrapper v2 (build_tensor_probes.py@1.0.0)
// 一次情報: metal_tensor (ElementType は device/constant 修飾必須)
#include <metal_stdlib>
#include <metal_tensor>
using namespace metal;

// builtin=__metal_get_extent_tensor cls=tensor
extern "C" int probe_p10t_extent_0(void) { tensor<device float, extents<int, 4, 8>> __t; return __t.get_extent(0); }

// builtin=__metal_slice_tensor cls=tensor
extern "C" void probe_p10t_slice_1(device tensor<device float, extents<int, 4, 8>> *__p) { tensor<device float, extents<int, 4, 8>> __t; __t = *__p; return; }

// builtin=__metal_init_strided_tensor cls=tensor
extern "C" void probe_p10t_init_2(void) { tensor<device float, extents<int, 4, 8>, tensor_inline> __t; (void)__t; return; }

// builtin=__metal_get_tensor_handle cls=tensor
extern "C" int probe_p10t_handle_3(void) { tensor<device float, extents<int, 4, 8>> __t; return __t.get_extent(0); }

// builtin=__metal_descriptor_size_tensor cls=tensor
extern "C" void probe_p10t_descsize_4(void) { tensor<device float, extents<int, 4, 8>, tensor_inline> __t; (void)__t; return; }

// builtin=__metal_tensor_t cls=tensor
extern "C" bool probe_p10t_type_h_5(void) { tensor<device float, extents<int, 4, 8>> __t; return is_null_tensor(__t); }

// builtin=__metal_tensor_thread_t cls=tensor
extern "C" bool probe_p10t_type_th_6(void) { tensor<device float, extents<int, 4, 8>> __t; return is_null_tensor(__t); }
