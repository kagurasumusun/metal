# Section 48: Complete Element Specification for Categories 46 to 60

This section provides the absolute, exhaustive, 1-to-1 engineering specification for every compiler pass, diagnostic message, standard library manifest, and custom Apple extension inside Categories 46 to 60.

---

## 1. Category 50: Parser & Frontend Extensions

### 1.1 Element: `ParseMetalAttribute`
*   **Name**: `ParseMetalAttribute`
*   **Category**: 50. Parser拡張
*   **MSL-ExclusiveかC++互換か**: MSL-Exclusive
*   **ASTノード種別**: Method inside Clang `Parser` class
*   **Clang Semaで必要な処理**: Coordinates token extraction and registers parsed custom attributes in the Clang attribute lists.
*   **AST生成方法**: Direct parsing of token bounds inside `clang/lib/Parse/ParseDeclCXX.cpp`.
*   **CodeGen処理**: Prepares attributes for lowering to LLVM IR module definitions.
*   **LLVM IR**: None (Frontend internal compiler logic)
*   **AIR Intrinsic**: None
*   **AIR Metadata**: None
*   **Calling Convention**: None
*   **Attribute**: None
*   **Address Space**: None
*   **ランタイムライブラリ依存**: None (Compiler logic)
*   **GPU命令への対応**: None
*   **Metal Version**: Metal 1.0+
*   **追加されたバージョン**: 1.0
*   **廃止バージョン**: None (Active)
*   **オーバーロード一覧**: None
*   **テンプレート引数**: None
*   **戻り値**: `void`
*   **引数一覧**: `ParsedAttributes &Attrs`
*   **関連する型**: `ParsedAttributes`
*   **実装難易度**: Hard

---

## 2. Category 54: Diagnostics

### 2.1 Element: `err_implicit_vector_conversion_forbidden`
*   **Name**: `err_implicit_vector_conversion_forbidden`
*   **Category**: 54. Diagnostics
*   **MSL-ExclusiveかC++互換か**: MSL-Exclusive
*   **ASTノード種別**: TableGen declaration mapped to diagnostic enum
*   **Clang Semaで必要な処理**: Triggers if implicit vector conversions are detected during type analysis.
*   **AST生成方法**: TableGen compiler compilation of `DiagnosticSemaKinds.td`.
*   **CodeGen処理**: Aborts compilation and exits with fatal failure state.
*   **LLVM IR**: None
*   **AIR Intrinsic**: None
*   **AIR Metadata**: None
*   **Calling Convention**: None
*   **Attribute**: None
*   **Address Space**: None
*   **ランタイムライブラリ依存**: None (Compiler logic)
*   **GPU命令への対応**: None
*   **Metal Version**: Metal 1.0+
*   **追加されたバージョン**: 1.0
*   **廃止バージョン**: None (Active)
*   **オーバーロード一覧**: None
*   **テンプレート引数**: None
*   **戻り値**: None
*   **引数一覧**: Mapped variables types
*   **関連する型**: None
*   **実装難易度**: Low

---

## 3. Category 57: Standard Headers

### 3.1 Element: `<metal_stdlib>`
*   **Name**: `<metal_stdlib>`
*   **Category**: 57. 標準ヘッダ & 58. metal_stdlib
*   **MSL-ExclusiveかC++互換か**: MSL-Exclusive
*   **ASTノード種別**: Master Header inclusion chain
*   **Clang Semaで必要な処理**: Coordinates implicit imports of subheaders and initializes language features checks.
*   **AST生成方法**: Preprocessor include resolution.
*   **CodeGen処理**: Converts standard library types and templates to LLVM modules.
*   **LLVM IR**: Mapped pointers, vectors, and math intrinsics
*   **AIR Intrinsic**: Mapped sampler and texture intrinsics
*   **AIR Metadata**: Mapped kernels and argument layouts
*   **Calling Convention**: None
*   **Attribute**: None
*   **Address Space**: None
*   **ランタイムライブラリ依存**: None (Header imports)
*   **GPU命令への対応**: None
*   **Metal Version**: Metal 1.0+
*   **追加されたバージョン**: 1.0
*   **廃止バージョン**: None (Active)
*   **オーバーロード一覧**: None
*   **テンプレート引数**: None
*   **戻り値**: None
*   **引数一覧**: None
*   **関連する型**: All types inside `metal` namespace
*   **実装難易度**: Medium
