# METAL_AST_ATTRIBUTE_MATRIX — MSL 全 30 種属性 (`[[...]]`) と AST ノード相関マトリクス

> **2026-07-21 実機 AST 解析確定**: Apple Clang (`metalfe`) の `-Xclang -ast-dump` 実測において観測された **全 30 AST 属性クラス (`Metal*Attr`)** と MSL 二重角括弧属性構文の完全相関仕様。

## 1. 全 30 属性構文・AST ノード・CodeGen 効果表 (`data/metal_ast_attribute_matrix.csv`)

| 属性構文 (`syntax_example`) | AST ノードクラス名 (`Metal*Attr`) | 付与対象 | 引数要件 | CodeGen における効果・レジスタ注入 |
|---|---|---|---|---|
| **`[[kernel]]`** | `MetalKernelAttr` | `FunctionDecl (`kernel void`)` | `No arguments` | Emits `!air.kernel` metadata node and sets calling convention `fastcc` / `air_kernel` |
| **`[[vertex]]`** | `MetalVertexAttr` | `FunctionDecl (`vertex VertexOut`)` | `No arguments` | Emits `!air.vertex` metadata node and sets vertex shader calling convention |
| **`[[fragment]]`** | `MetalFragmentAttr` | `FunctionDecl (`fragment half4`)` | `No arguments` | Emits `!air.fragment` metadata node and sets fragment shader calling convention |
| **`[[buffer(N)]]`** | `MetalBufferIndexAttr` | `ParmVarDecl / FieldDecl` | ``int Index` (`IntegerLiteral N < 31`)` | Maps parameter/field to argument buffer slot `#N` inside `!air.kernel` parameter descriptor (`!"buffer", i32 N`) |
| **`[[texture(N)]]`** | `MetalTextureIndexAttr` | `ParmVarDecl / FieldDecl` | ``int Index` (`IntegerLiteral N < 128`)` | Maps to texture binding slot `#N` inside argument metadata (`!"texture", i32 N`) |
| **`[[sampler(N)]]`** | `MetalSamplerIndexAttr` | `ParmVarDecl / FieldDecl` | ``int Index` (`IntegerLiteral N < 16`)` | Maps to sampler binding slot `#N` inside argument metadata (`!"sampler", i32 N`) |
| **`[[threadgroup(N)]]`** | `MetalBufferIndexAttr` | `ParmVarDecl (`threadgroup T*`)` | ``int Index` (`IntegerLiteral N < 31`)` | Maps to shared memory (`LDS`) allocation slot `#N` in `!air.kernel` argument descriptor (`!"threadgroup_buffer", i32 N`) |
| **`[[stage_in]]`** | `MetalStageInAttr` | `ParmVarDecl (`FragIn in`)` | `No arguments` | Unpacks struct fields into vertex input layout or fragment interpolant registers during CodeGen |
| **`[[thread_position_in_grid]]`** | `MetalThreadPosGridAttr` | `ParmVarDecl (`uint3/uint2/uint`)` | `No arguments` | Injects system register read `air.get_global_id` (`s0..s2`) directly into kernel prologue |
| **`[[thread_position_in_threadgroup]]`** | `MetalThreadPosGroupAttr` | `ParmVarDecl (`uint3/uint2/uint`)` | `No arguments` | Injects `air.get_local_id` system register read (`v0..v2` local coordinates) |
| **`[[thread_index_in_threadgroup]]`** | `MetalThreadIndexGroupAttr` | `ParmVarDecl (`uint/ushort`)` | `No arguments` | Injects `air.get_local_linear_id` (`tid.x + tid.y*dim.x + ...`) scalar calculation |
| **`[[threads_per_grid]]`** | `MetalThreadsPerGridAttr` | `ParmVarDecl (`uint3/uint2/uint`)` | `No arguments` | Injects `air.get_global_size` system register read (total compute grid dimensions) |
| **`[[threads_per_threadgroup]]`** | `MetalThreadsPerGroupAttr` | `ParmVarDecl (`uint3/uint2/uint`)` | `No arguments` | Injects `air.get_local_size` system register read (threadgroup block dimensions) |
| **`[[threadgroups_per_grid]]`** | `MetalThreadGroupsPerGridAttr` | `ParmVarDecl (`uint3/uint2/uint`)` | `No arguments` | Injects `air.get_num_groups` system register read (number of threadgroups in grid) |
| **`[[dispatch_threads_per_grid]]`** | `MetalLocalIndexAttr` | `ParmVarDecl (`uint3/uint2/uint`)` | `No arguments` | Injects `__lowering_get_dispatch_threads` hook reading hidden dispatch metadata slot |
| **`[[grid_origin]]`** | `MetalStageInGridOriginAttr` | `ParmVarDecl (`uint3/uint2/uint`)` | `No arguments` | Injects `air.get_grid_origin` reading base coordinate offset of dispatch grid |
| **`[[simdgroup_index_in_threadgroup]]`** | `MetalSIMDGroupIndexGroupAttr` | `ParmVarDecl (`uint/ushort`)` | `No arguments` | Injects `air.get_simdgroup_index` (wavefront index inside threadgroup `tid / 32`) |
| **`[[thread_index_in_simdgroup]]`** | `MetalThreadIndexSIMDGroupAttr` | `ParmVarDecl (`uint/ushort`)` | `No arguments` | Injects `air.get_simd_lane_id` (`laneid` / `tid % 32` / `sreg`) |
| **`[[vertex_id]]`** | `MetalVertexIdAttr` | `ParmVarDecl (`uint/ushort`)` | `No arguments` | Injects `air.get_vertex_id` system input register read (`gl_VertexID`) |
| **`[[instance_id]]`** | `MetalInstanceIdAttr` | `ParmVarDecl (`uint/ushort`)` | `No arguments` | Injects `air.get_instance_id` system input register read (`gl_InstanceID`) |
| **`[[position]]`** | `MetalPositionAttr` | `FieldDecl (`float4`)` | `No arguments` | Marks vertex position output or fragment pixel coordinate input (`gl_Position` / `gl_FragCoord`) |
| **`[[color(N)]]`** | `MetalColorAttr` | `FieldDecl (`float4/half4/uint4`)` | ``int Index N` (`0..7`)` | Maps struct field to framebuffer render target color attachment `#N` (`gl_FragColor[N]`) |
| **`[[point_size]]`** | `MetalPointSizeAttr` | `FieldDecl (`float/half`)` | `No arguments` | Marks point sprite point size output parameter (`gl_PointSize`) |
| **`[[clip_distance]]`** | `MetalClipDistanceAttr` | `FieldDecl (`float/float[N]`)` | `Optional array size` | Marks user clip plane distance output (`gl_ClipDistance`) |
| **`[[render_target_array_index]]`** | `MetalRenderTargetArrayIndexAttr` | `FieldDecl (`uint/int/ushort`)` | `No arguments` | Marks layered rendering slice destination index (`gl_Layer` / RT array slice) |
| **`[[viewport_array_index]]`** | `MetalViewportArrayIndexAttr` | `FieldDecl (`uint/int/ushort`)` | `No arguments` | Marks multi-viewport selection index (`gl_ViewportIndex`) |
| **`[[barycentric_coord]]`** | `MetalBarycentricCoordAttr` | `FieldDecl / ParmVarDecl (`float3/float2`)` | `No arguments` | Injects sub-triangle barycentric coordinates `(u,v,w)` inside fragment shader (`gl_BaryCoord`) |
| **`[[front_facing]]`** | `MetalFrontFacingAttr` | `FieldDecl / ParmVarDecl (`bool`)` | `No arguments` | Injects triangle winding orientation boolean `is_front_facing` (`gl_FrontFacing`) |
| **`[[sample_id]]`** | `MetalSampleIdAttr` | `FieldDecl / ParmVarDecl (`uint`)` | `No arguments` | Injects MSAA subpixel sample invocation ID (`gl_SampleID`) |
| **`[[sample_mask]]`** | `MetalSampleMaskAttr` | `FieldDecl / ParmVarDecl (`uint`)` | `No arguments` | Injects / outputs MSAA coverage bitmask (`gl_SampleMask` / `gl_SampleMaskIn`) |
| **`[[user(locnN)]]`** | `MetalUserDefinedAttr` | `FieldDecl` | ``string locnN` / `int N`` | Assigns explicit user-defined varying location `#N` between vertex and fragment stages |

## 2. クリーンルームコンパイラにおける AST 属性シリアライズ・検証仕様

1. **リソースインデックス検証 (`SemaDeclAttr::CheckMSLResourceIndexBounds`)**:
   `[[buffer(N)]]`, `[[texture(N)]]`, `[[sampler(N)]]` に渡される `N` は定数式評価によって `IntegerLiteral` となり、`TargetInfo` で定義される最大制限 (`max_device_buffers` 等) に違反する場合はコンパイルエラーとする。
2. **システムレジスタ読出命令の prologue 注入 (`BuiltinInputAttr`)**:
   `MetalThreadPosGridAttr` 等が引数 `ParmVarDecl` に付与されている場合、CodeGen はエントリ関数の先頭 (`Prologue`) で対応するシステムレジスタ読出 (`air.get_global_id` 等) を発行し、当該引数への参照をそのレジスタ値に置換する。
