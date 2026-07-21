# MSL pixel データ形式対応表 (metal_pixel 一次情報機械抽出)

| alias (metal::) | tag | storage (METAL_ALIGN) | 許容 T (_is_pixel_type) | pack builtin | unpack builtin |
|---|---|---|---|---|---|
| r8unorm | _r8unorm_tag | uchar METAL_ALIGN(1) | half, float | __metal_pack_unorm1x8 | __metal_unpack_unorm1x8 |
| r8snorm | _r8snorm_tag | uchar METAL_ALIGN(1) | half, float | __metal_pack_snorm1x8 | __metal_unpack_snorm1x8 |
| r16unorm | _r16unorm_tag | ushort METAL_ALIGN(2) | float | __metal_pack_unorm1x16 | __metal_unpack_unorm1x16 |
| r16snorm | _r16snorm_tag | ushort METAL_ALIGN(2) | float | __metal_pack_snorm1x16 | __metal_unpack_snorm1x16 |
| rg8unorm | _rg8unorm_tag | ushort METAL_ALIGN(1) | half2, float2 | __metal_pack_unorm2x8 | __metal_unpack_unorm2x8 |
| rg8snorm | _rg8snorm_tag | ushort METAL_ALIGN(1) | half2, float2 | __metal_pack_snorm2x8 | __metal_unpack_snorm2x8 |
| rg16unorm | _rg16unorm_tag | uint METAL_ALIGN(2) | float2 | __metal_pack_unorm2x16 | __metal_unpack_unorm2x16 |
| rg16snorm | _rg16snorm_tag | uint METAL_ALIGN(2) | float2 | __metal_pack_snorm2x16 | __metal_unpack_snorm2x16 |
| rgba8unorm | _rgba8unorm_tag | uint METAL_ALIGN(1) | half4, float4 | __metal_pack_unorm4x8 | __metal_unpack_unorm4x8 |
| srgba8unorm | _srgba8unorm_tag | uint METAL_ALIGN(1) | half4, float4 | __metal_pack_unorm4x8_srgb | __metal_unpack_unorm4x8_srgb |
| rgba8snorm | _rgba8snorm_tag | uint METAL_ALIGN(1) | half4, float4 | __metal_pack_snorm4x8 | __metal_unpack_snorm4x8 |
| rgba16unorm | _rgba16unorm_tag | size_t METAL_ALIGN(2) | float4 | __metal_pack_unorm4x16 | __metal_unpack_unorm4x16 |
| rgba16snorm | _rgba16snorm_tag | size_t METAL_ALIGN(2) | float4 | __metal_pack_snorm4x16 | __metal_unpack_snorm4x16 |
| rgb10a2 | _rgb10a2_tag | uint METAL_ALIGN(4) | half4, float4 | __metal_pack_unorm_rgb10a2 | __metal_unpack_unorm_rgb10a2 |
| rg11b10f | _rg11b10f_tag | uint METAL_ALIGN(4) | half3, float3 | __metal_pack_unorm_rg11b10f | __metal_unpack_unorm_rg11b10f |
| rgb9e5 | _rgb9e5_tag | uint METAL_ALIGN(4) | half3, float3 | __metal_pack_unorm_rgb9e5 | __metal_unpack_unorm_rgb9e5 |
