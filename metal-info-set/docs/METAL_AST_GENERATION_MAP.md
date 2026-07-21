# METAL_AST_GENERATION_MAP — Metal 固有 AST 生成規則およびノード構造対応表

> **2026-07-21 実機 AST ダンプ実測確定**: Apple Clang (`metalfe`) の `-Xclang -ast-dump` 出力に基づいて AST ノード名 (`MetalKernelAttr`, `MetalBufferIndexAttr` 等) と内部フィールドを全確定。

## 1. AST ノード構造・シリアライズ仕様表 (`data/metal_ast_generation_map.csv`)

| AST ノード名 | カテゴリ | 内部構造・保持フィールド | 実測 AST ダンプ文字列 (`ast_dump_observed`) | CodeGen における効果 |
|---|---|---|---|---|---|
| **`MetalKernelAttr`** | `EntryStageAttr` | Inherits `InheritableAttr`. Fields: none (marker attribute). Attached to `FunctionDecl` (`kernel void`). | `MetalKernelAttr 0x718d306a0` | Marks entry point for `!air.kernel` metadata emission during CodeGen |
| **`MetalVertexAttr`** | `EntryStageAttr` | Inherits `InheritableAttr`. Attached to `FunctionDecl` (`vertex vertex_out`). | `MetalVertexAttr` | Marks vertex stage for `!air.vertex` metadata emission |
| **`MetalFragmentAttr`** | `EntryStageAttr` | Inherits `InheritableAttr`. Attached to `FunctionDecl` (`fragment half4`). | `MetalFragmentAttr` | Marks fragment stage for `!air.fragment` metadata emission |
| **`MetalBufferIndexAttr`** | `ResourceIndexAttr` | Inherits `InheritableAttr`. Fields: `int Index` (`IntegerLiteral`). Attached to `ParmVarDecl` / `FieldDecl`. | `MetalBufferIndexAttr 0x...` | Drives argument buffer slot mapping (`!air.arg_type_name` / `!air.buffer_size`) |
| **`MetalTextureIndexAttr`** | `ResourceIndexAttr` | Inherits `InheritableAttr`. Fields: `int Index`. Attached to `ParmVarDecl` (`texture2d<T>`). | `MetalTextureIndexAttr` | Maps to texture binding slot `#N` in argument metadata |
| **`MetalSamplerIndexAttr`** | `ResourceIndexAttr` | Inherits `InheritableAttr`. Fields: `int Index`. Attached to `ParmVarDecl` (`sampler`). | `MetalSamplerIndexAttr` | Maps to sampler binding slot `#N` |
| **`MetalThreadPosGridAttr`** | `BuiltinInputAttr` | Inherits `InheritableParamAttr`. Fields: none. Attached to `ParmVarDecl` (`uint3/uint2/uint`). | `MetalThreadPosGridAttr 0x...` | Informs CodeGen to inject `air.get_global_id` system register read (`s0..s2`) |
| **`MetalThreadIndexInThreadGroupAttr`** | `BuiltinInputAttr` | Inherits `InheritableParamAttr`. Fields: none. Attached to `ParmVarDecl` (`uint/ushort`). | `MetalThreadIndexInThreadGroupAttr` | Informs CodeGen to inject `air.get_local_id` / `air.get_local_linear_id` |
| **`MetalStageInAttr`** | `PipelineInterfaceAttr` | Inherits `InheritableParamAttr`. Fields: none. Attached to `ParmVarDecl` (`vertex_in` struct). | `MetalStageInAttr` | Unpacks struct fields into vertex attribute inputs or fragment interpolants |
| **`ImplicitCastExpr (AddressSpaceConversion)`** | `TypeConversionExpr` | CastKind: `CK_AddressSpaceConversion`. Converts `QualType` from address space A (`device`) to generic (`default`) or vice versa. | `ImplicitCastExpr 0x... 'device float *' <LValueToRValue>` | Generates LLVM `addrspacecast` instruction (`addrspace(1)* to addrspace(0)*`) |
| **`TypedefDecl (__metal_texture_2d_t)`** | `BuiltinOpaqueDecl` | Implicit builtin typedef node injected by ASTContext during initialization when `-x metal` is active. | `TypedefDecl 0x... implicit __metal_texture_2d_t '__metal_texture_2d_t'` | Underlying representation of `metal::texture2d<T>` mapping to opaque LLVM struct `%struct._texture_2d_t = type opaque` |
