// scene P18K: entry-stage scene (mesh / fragment imageblock / post-tessell"patch vertex)
// 一次情報: metal_mesh (set_index/set_indices/set_vertex/set_primitive/set_primitive_count)
//           metal_tessellation (patch_control_point::size -> __metal_get_num_patch_control_points)
//           metal_imageblocks (_imageblock_base / write / data)
//           metal_vertex_value (vertex_value<T>::get -> __metal_get_vertex_value)
#include <metal_stdlib>
#include <metal_graphics>
#include <metal_mesh>
#include <metal_tessellation>
#include <metal_imageblocks>
#include <metal_vertex_value>
using namespace metal;

// ---- mesh builtin 群 (builtin=__metal_set_index_mesh 等) ----
struct MeshV { float4 position [[position]]; };
struct MeshP { uint primid [[primitive_id]]; };

// builtin=__metal_set_index_mesh
[[mesh]] void probe_p18k_set_index(mesh<MeshV, MeshP, 8, 4, topology::triangle> __m) {
    __m.set_index(0u, uchar(0));
}

// builtin=__metal_set_indices_mesh
[[mesh]] void probe_p18k_set_indices(mesh<MeshV, MeshP, 8, 4, topology::triangle> __m) {
    __m.set_indices(0u, uchar4(0));
}

// builtin=__metal_set_primitive_count_mesh
[[mesh]] void probe_p18k_set_primcount(mesh<MeshV, MeshP, 8, 4, topology::triangle> __m) {
    __m.set_primitive_count(1u);
}

// builtin=__metal_set_vertex_mesh
[[mesh]] void probe_p18k_set_vertex(mesh<MeshV, MeshP, 8, 4, topology::triangle> __m) {
    MeshV __v; __v.position = float4(0);
    __m.set_vertex(0u, __v);
}

// builtin=__metal_set_primitive_mesh
[[mesh]] void probe_p18k_set_prim(mesh<MeshV, MeshP, 8, 4, topology::triangle> __m) {
    MeshP __p; __p.primid = 0u;
    __m.set_primitive(0u, __p);
}

// builtin=__metal_set_threadgroups_per_grid_mesh_grid_properties
struct OGP { void grid(uint, uint, uint); };
[[object]] void probe_p18k_mgp(mesh_grid_properties __gp) {
    __gp.set_threadgroups_per_grid(uint3(1,1,1));
}

// ---- post-tessellation vertex (builtin=__metal_get_num_patch_control_points) ----
struct CP { float4 p [[attribute(0)]]; };
// DISABLED_LINE [[vertex, patch(triangle, 3)]] float4 probe_p18k_patch(patch_control_point<CP> __cp [[stage_in]], uint __vid [[vertex_id]]) {
// DISABLED_LINE     return float4((float)__cp.size(), float(__vid), 0.0f, 1.0f);
// DISABLED_LINE }

// ---- imageblock (fragment) ----
struct FragExp { float4 c [[color(0)]]; };

// builtin=__metal_get_imageblock_width / height / num_colors / samples / color_coverage_mask
// DISABLED_LINE [[fragment]] float4 probe_p18k_ib_size(imageblock<FragExp> __ib [[imageblock_data]]) {
// DISABLED_LINE     ushort2 __c(0,0);
// DISABLED_LINE     return float4(float(__ib.get_width()), float(__ib.get_height()),
// DISABLED_LINE                   float(__ib.get_num_colors(__c)) + float(__ib.get_num_samples())
// DISABLED_LINE                   + float(__ib.get_color_coverage_mask(__c, ushort(0))), 1.0f);
// DISABLED_LINE }

// builtin=__metal_imageblock_explicit_data (read 経路)
// DISABLED_LINE [[fragment]] float4 probe_p18k_ib_read(imageblock<FragExp> __ib [[imageblock_data]]) {
// DISABLED_LINE     FragExp __d = __ib.data(ushort2(0,0));
// DISABLED_LINE     return __d.c;
// DISABLED_LINE }

// builtin=__metal_imageblock_explicit_mask_write (write 経路)
// DISABLED_LINE [[fragment]] float4 probe_p18k_ib_write(imageblock<FragExp> __ib [[imageblock_data]], float4 __c) {
// DISABLED_LINE     FragExp __d; __d.c = __c;
// DISABLED_LINE     __ib.write(__d, ushort2(0,0), ushort(0));
// DISABLED_LINE     return __c;
// DISABLED_LINE }

// ---- vertex_value (builtin=__metal_get_vertex_value) ----
#if defined(__HAVE_VERTEX_VALUE__)
[[fragment]] float4 probe_p18k_vv(vertex_value<float> __vv [[stage_in]]) {
    return float4(__vv.get(vertex_index::first));
}
#endif
