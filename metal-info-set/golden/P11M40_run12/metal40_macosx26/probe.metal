// scene P11M: misc builtin wrapper (build_misc_probes.py@1.0.0)
// 一次情報: __bits/metal_texture* ctor / metal_quadgroup / metal_graphics / metal_command_buffer
#include <metal_stdlib>
#include <metal_raytracing>
#include <metal_graphics>
#include <metal_command_buffer>
#include <metal_tessellation>
#include <metal_visible_function_table>
#include <metal_quadgroup>
using namespace metal;
using namespace metal::raytracing;

// builtin=__metal_get_null_depth_2d_t cls=misc
extern "C" int probe_p11m_texnull_0(void) { depth2d<float> __t; (void)__t; return 0; }

// builtin=__metal_get_null_depth_2d_array_t cls=misc
extern "C" int probe_p11m_texnull_1(void) { depth2d_array<float> __t; (void)__t; return 0; }

// builtin=__metal_get_null_depth_2d_ms_t cls=misc
extern "C" int probe_p11m_texnull_2(void) { depth2d_ms<float> __t; (void)__t; return 0; }

// builtin=__metal_get_null_depth_2d_ms_array_t cls=misc
extern "C" int probe_p11m_texnull_3(void) { depth2d_ms_array<float> __t; (void)__t; return 0; }

// builtin=__metal_get_null_depth_cube_t cls=misc
extern "C" int probe_p11m_texnull_4(void) { depthcube<float> __t; (void)__t; return 0; }

// builtin=__metal_get_null_depth_cube_array_t cls=misc
extern "C" int probe_p11m_texnull_5(void) { depthcube_array<float> __t; (void)__t; return 0; }

// builtin=__metal_get_null_texture_1d_t cls=misc
extern "C" int probe_p11m_texnull_6(void) { texture1d<float> __t; (void)__t; return 0; }

// builtin=__metal_get_null_texture_1d_array_t cls=misc
extern "C" int probe_p11m_texnull_7(void) { texture1d_array<float> __t; (void)__t; return 0; }

// builtin=__metal_get_null_texture_2d_t cls=misc
extern "C" int probe_p11m_texnull_8(void) { texture2d<float> __t; (void)__t; return 0; }

// builtin=__metal_get_null_texture_2d_array_t cls=misc
extern "C" int probe_p11m_texnull_9(void) { texture2d_array<float> __t; (void)__t; return 0; }

// builtin=__metal_get_null_texture_2d_ms_t cls=misc
extern "C" int probe_p11m_texnull_10(void) { texture2d_ms<float> __t; (void)__t; return 0; }

// builtin=__metal_get_null_texture_2d_ms_array_t cls=misc
extern "C" int probe_p11m_texnull_11(void) { texture2d_ms_array<float> __t; (void)__t; return 0; }

// builtin=__metal_get_null_texture_3d_t cls=misc
extern "C" int probe_p11m_texnull_12(void) { texture3d<float> __t; (void)__t; return 0; }

// builtin=__metal_get_null_texture_buffer_1d_t cls=misc
extern "C" int probe_p11m_texnull_13(void) { texture_buffer<float> __t; (void)__t; return 0; }

// builtin=__metal_get_null_texture_cube_t cls=misc
extern "C" int probe_p11m_texnull_14(void) { texturecube<float> __t; (void)__t; return 0; }

// builtin=__metal_get_null_texture_cube_array_t cls=misc
extern "C" int probe_p11m_texnull_15(void) { texturecube_array<float> __t; (void)__t; return 0; }

// builtin=__metal_get_null_primitive_acceleration_structure cls=misc
extern "C" int probe_p11m_asnull_16(void) { metal::raytracing::primitive_acceleration_structure __as; (void)__as; return 0; }

// builtin=__metal_get_null_function_handle cls=misc
extern "C" int probe_p11m_fhandle_17(void) { metal::raytracing::intersection_function_handle<> __h; (void)__h; return 0; }

// builtin=__metal_get_null_intersection_function_table cls=misc
extern "C" int probe_p11m_iftnull_18(void) { metal::raytracing::intersection_function_table<metal::raytracing::instancing, metal::raytracing::triangle_data> __t; (void)__t; return 0; }

// builtin=__metal_get_null_visible_function_table cls=misc
extern "C" int probe_p11m_vftnull_19(void) { metal::visible_function_table<void(uint)> __v; (void)__v; return 0; }

// builtin=__metal_is_equal_function_handle cls=misc
extern "C" bool probe_p11m_fequal_20(void) { metal::raytracing::intersection_function_handle<> __a, __b; return __a == __b; }

// builtin=__metal_divide cls=misc
extern "C" float probe_p11m_divide_21(void) { return divide(1.0f, 2.0f); }

// builtin=__metal_select cls=misc
extern "C" float probe_p11m_select_22(void) { float __t=1.0f; return copysign(__t, -2.0f); }

// builtin=__metal_sampler_t cls=misc
extern "C" int probe_p11m_sampler_23(void) { sampler __s; (void)__s; return 0; }

// builtin=__metal_get_sampler cls=misc
extern "C" int probe_p11m_getsampler_24(void) { sampler __s; (void)__s; return 0; }

// builtin=__metal_get_size_visible_function_table cls=misc
extern "C" uint probe_p11m_vftsize_25(void) { metal::visible_function_table<void(uint)> __v; return __v.size(); }

// builtin=__metal_draw_indexed_primitives_render_command cls=misc
extern "C" void probe_p11m_draw1_26(metal::command_buffer __cb) { metal::render_command __rc(__cb, 0u); __rc.draw_indexed_primitives(metal::primitive_type::triangle, 0u, (const device uint *)nullptr, 0u); return; }

// builtin=__metal_draw_patches_render_command cls=misc
extern "C" void probe_p11m_draw2_27(metal::command_buffer __cb) { metal::render_command __rc(__cb, 0u); __rc.draw_patches(0u, 0u, 0u, (const device uint *)nullptr, 0u, 0u, (const device metal::MTLQuadTessellationFactorsHalf *)nullptr); return; }

// builtin=__metal_draw_indexed_patches_render_command cls=misc
extern "C" void probe_p11m_draw3_28(metal::command_buffer __cb) { metal::render_command __rc(__cb, 0u); __rc.draw_indexed_patches(0u, 0u, 0u, (const device uint *)nullptr, (const device void *)nullptr, 0u, 0u, (const device metal::MTLQuadTessellationFactorsHalf *)nullptr); return; }
