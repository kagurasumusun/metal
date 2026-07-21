// scene P26M: texture ulong4 atomic max/min 全8次元 (metal4.0, __HAVE_DEVICE_COHERENT_READ_WRITE_TEXTURES__ 専用)
// 一次: __bits/metal_texture* 各 _textureXd_atomic_modify<ulong, a, c, read&&write> 専用化 + cudaull ulong4 operand
// cap2 単騎検証 RC=0 済 (texture2d<ulong, access::read_write>)
#include <metal_stdlib>
#include <metal_atomic>
using namespace metal;

#if !defined(__HAVE_DEVICE_COHERENT_READ_WRITE_TEXTURES__)
#error REQUIRES_DEVICE_COHERENT_READ_WRITE_TEXTURES
#endif

// builtin=__metal_atomic_max_explicit_texture_1d_t
[[kernel]] void probe_p26m_1d_max(texture1d<ulong, access::read_write> __t [[texture(0)]]) {
    __t.atomic_max(ushort(0), ulong4(42));
}
// builtin=__metal_atomic_min_explicit_texture_1d_t
[[kernel]] void probe_p26m_1d_min(texture1d<ulong, access::read_write> __t [[texture(0)]]) {
    __t.atomic_min(ushort(0), ulong4(1));
}
// builtin=__metal_atomic_max_explicit_texture_1d_array_t
[[kernel]] void probe_p26m_1da_max(texture1d_array<ulong, access::read_write> __t [[texture(0)]]) {
    __t.atomic_max(ushort(0), ushort(0), ulong4(42));
}
// builtin=__metal_atomic_min_explicit_texture_1d_array_t
[[kernel]] void probe_p26m_1da_min(texture1d_array<ulong, access::read_write> __t [[texture(0)]]) {
    __t.atomic_min(ushort(0), ushort(0), ulong4(1));
}
// builtin=__metal_atomic_max_explicit_texture_2d_t
[[kernel]] void probe_p26m_2d_max(texture2d<ulong, access::read_write> __t [[texture(0)]]) {
    __t.atomic_max(ushort2(ushort(0)), ulong4(42));
}
// builtin=__metal_atomic_min_explicit_texture_2d_t
[[kernel]] void probe_p26m_2d_min(texture2d<ulong, access::read_write> __t [[texture(0)]]) {
    __t.atomic_min(ushort2(ushort(0)), ulong4(1));
}
// builtin=__metal_atomic_max_explicit_texture_2d_array_t
[[kernel]] void probe_p26m_2da_max(texture2d_array<ulong, access::read_write> __t [[texture(0)]]) {
    __t.atomic_max(ushort2(ushort(0)), ushort(0), ulong4(42));
}
// builtin=__metal_atomic_min_explicit_texture_2d_array_t
[[kernel]] void probe_p26m_2da_min(texture2d_array<ulong, access::read_write> __t [[texture(0)]]) {
    __t.atomic_min(ushort2(ushort(0)), ushort(0), ulong4(1));
}
// builtin=__metal_atomic_max_explicit_texture_3d_t
[[kernel]] void probe_p26m_3d_max(texture3d<ulong, access::read_write> __t [[texture(0)]]) {
    __t.atomic_max(ushort3(ushort(0)), ulong4(42));
}
// builtin=__metal_atomic_min_explicit_texture_3d_t
[[kernel]] void probe_p26m_3d_min(texture3d<ulong, access::read_write> __t [[texture(0)]]) {
    __t.atomic_min(ushort3(ushort(0)), ulong4(1));
}
// builtin=__metal_atomic_max_explicit_texture_buffer_1d_t
[[kernel]] void probe_p26m_buf1d_max(texture_buffer<ulong, access::read_write> __t [[texture(0)]]) {
    __t.atomic_max(ushort(0), ulong4(42));
}
// builtin=__metal_atomic_min_explicit_texture_buffer_1d_t
[[kernel]] void probe_p26m_buf1d_min(texture_buffer<ulong, access::read_write> __t [[texture(0)]]) {
    __t.atomic_min(ushort(0), ulong4(1));
}
// builtin=__metal_atomic_max_explicit_texture_cube_t
[[kernel]] void probe_p26m_cube_max(texturecube<ulong, access::read_write> __t [[texture(0)]]) {
    __t.atomic_max(ushort2(ushort(0)), ushort(0), ulong4(42));
}
// builtin=__metal_atomic_min_explicit_texture_cube_t
[[kernel]] void probe_p26m_cube_min(texturecube<ulong, access::read_write> __t [[texture(0)]]) {
    __t.atomic_min(ushort2(ushort(0)), ushort(0), ulong4(1));
}
// builtin=__metal_atomic_max_explicit_texture_cube_array_t
[[kernel]] void probe_p26m_cubearr_max(texturecube_array<ulong, access::read_write> __t [[texture(0)]]) {
    __t.atomic_max(ushort2(ushort(0)), ushort(0), ushort(0), ulong4(42));
}
// builtin=__metal_atomic_min_explicit_texture_cube_array_t
[[kernel]] void probe_p26m_cubearr_min(texturecube_array<ulong, access::read_write> __t [[texture(0)]]) {
    __t.atomic_min(ushort2(ushort(0)), ushort(0), ushort(0), ulong4(1));
}
