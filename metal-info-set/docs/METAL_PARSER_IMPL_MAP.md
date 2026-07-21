# METAL_PARSER_IMPL_MAP — Metal 固有 Parser (構文解析・キーワード・属性) 完全詳細対応表

> **2026-07-21 実機解析確定**: Apple Clang (`metalfe`) のパーサ動作およびキーワード／属性トークン (`[[...]]`) 解析メカニズムを全体系化。

## 1. 構文解析ルールおよび AST 生成ノード表 (`data/metal_parser_impl_map.csv`)

| 区分 | トークン/構文 | パーサ処理 (`parser_action`) | 生成 AST ノード | Clang 実装ポイント |
|---|---|---|---|---|---|
| `entry_keywords` | **``kernel`, `vertex`, `fragment`, `mesh`, `object`, `tile``** | Intercept function declaration specifiers; attach MSL entry stage token (`tok::kw_kernel` etc.). | `DeclSpec -> FunctionDecl with `MetalKernelAttr` / `MetalVertexAttr` etc.` | `Parser::ParseFunctionDeclarator / ParseDeclSpec` |
| `address_spaces` | **``device`, `constant`, `threadgroup`, `thread`, `ray_data`, `object_data``** | Parse address space type qualifiers; attach `Qualifiers::AddressSpace` (`LangAS::opencl_global` -> `as1` device, `as2` constant, `as3` threadgroup). | `AttributedType / QualType with exact address space modifier (`as1..as9`)` | `Parser::ParseTypeQualifierListOpt / ParseDeclarator` |
| `attributes_bracket` | **``[[buffer(N)]]`, `[[texture(N)]]`, `[[sampler(N)]]`, `[[threadgroup(N)]]``** | Parse C++11 double bracket attribute syntax `[[...]]`; evaluate integer constant expression `N` inside parentheses. | `MetalBufferIndexAttr / MetalTextureIndexAttr / MetalSamplerIndexAttr (`IntegerLiteral` `N`)` | `Parser::ParseCXX11Attributes -> SemaDeclAttr::handleMetalResourceIndexAttr` |
| `attributes_grid` | **``[[thread_position_in_grid]]`, `[[thread_index_in_threadgroup]]`, `[[dispatch_threads_per_grid]]``** | Parse zero-argument entry stage parameter attributes `[[...]]`. | `MetalThreadPosGridAttr / MetalThreadIndexInThreadGroupAttr / MetalDispatchThreadsPerGridAttr` | `Parser::ParseCXX11Attributes -> SemaDeclAttr::handleMetalThreadPosAttr` |
| `attributes_stage` | **``[[stage_in]]`, `[[color(N)]]`, `[[position]]`, `[[point_size]]``** | Parse vertex/fragment pipeline input/output semantics attributes. | `MetalStageInAttr / MetalColorIndexAttr / MetalPositionAttr / MetalPointSizeAttr` | `Parser::ParseCXX11Attributes -> SemaDeclAttr::handleMetalPipelineStageAttr` |
| `opaque_templates` | **``vec<T,N>`, `matrix<T,C,R>`, `texture2d<T,access>``** | Parse MSL standard library C++ template specialization syntax (`ClassTemplateSpecializationDecl`). | `ClassTemplateSpecializationDecl / TypedefDecl (e.g. `__metal_texture_2d_t`)` | `Parser::ParseClassTemplateId -> SemaTemplateInstantiate` |
| `pragmas` | **``#pragma unroll N`, `#pragma clang fp contract(fast)``** | Parse compiler directives controlling loop unrolling and floating point contraction. | `LoopHintAttr / FloatingPointModeAttr inside `AttributedStmt`` | `Parser::ParsePragmaLoopHint / ParsePragmaClangFP` |
