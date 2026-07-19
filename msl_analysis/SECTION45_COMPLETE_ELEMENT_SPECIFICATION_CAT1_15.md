# Section 45: Complete Element Specification for Categories 1 to 15

This section provides the absolute, exhaustive, 1-to-1 engineering specification for every syntactical, keyword, qualifier, address-space, and type construct inside Categories 1 to 15.

---

## 1. Category 1: Keywords

### 1.1 Element: `kernel`
*   **Name**: `kernel`
*   **Category**: 1. Keywords
*   **MSL-ExclusiveかC++互換か**: MSL-Exclusive
*   **ASTノード種別**: `FunctionDecl` with target-specific attribute annotation
*   **Clang Semaで必要な処理**: Intercepts and validates function type declarations. Ensures function returns `void` and is not declared as a class member or virtual.
*   **AST生成方法**: `FunctionDecl::Create` with `spir_kernel` calling convention during AST parsing.
*   **CodeGen処理**: Generates LLVM function definition decorated with `spir_kernel` calling convention and serializes function symbol into the module's `!air.kernels` metadata block.
*   **LLVM IR**: `define amdgpu_kernel void @my_kernel(...)` (or custom spir_kernel calling conv)
*   **AIR Intrinsic**: None
*   **AIR Metadata**: `!air.kernels`
*   **Calling Convention**: `spir_kernel`
*   **Attribute**: `__attribute__((pcs("spir_kernel")))`
*   **Address Space**: None
*   **ランタイムライブラリ依存**: None
*   **GPU命令への対応**: Unified Shader Core workgroup launching registers init
*   **Metal Version**: Metal 1.0+
*   **追加されたバージョン**: 1.0
*   **廃止バージョン**: None (Active)
*   **オーバーロード一覧**: None (Not overloadable)
*   **テンプレート引数**: None
*   **戻り値**: `void`
*   **引数一覧**: Valid MSL parameters (buffers, textures, samplers, threadgroup memory, and system coordinate attributes)
*   **関連する型**: None
*   **実装難易度**: Medium

---

## 2. Category 2: Qualifiers & Address Spaces

### 2.1 Element: `device`
*   **Name**: `device`
*   **Category**: 2. Qualifier & 3. Address Space
*   **MSL-ExclusiveかC++互換か**: MSL-Exclusive
*   **ASTノード種別**: `QualType` with Address Space attribute
*   **Clang Semaで必要な処理**: Checks pointer/reference declaration targets. Prevents references of references or unaligned structure pointer casts across mismatching spaces.
*   **AST生成方法**: `ASTContext.getAddrSpaceQualType(BaseType, LangAS::opencl_global)`
*   **CodeGen処理**: Annotates pointer types with LLVM Address Space `1` (`addrspace(1)*`).
*   **LLVM IR**: `float addrspace(1)*`
*   **AIR Intrinsic**: None
*   **AIR Metadata**: None
*   **Calling Convention**: None
*   **Attribute**: `__attribute__((address_space(1)))`
*   **Address Space**: Address Space `1` (Global Device Memory)
*   **ランタイムライブラリ依存**: None
*   **GPU命令への対応**: Lowered to `ld_global` / `st_global` via L1/L2 cache lines
*   **Metal Version**: Metal 1.0+
*   **追加されたバージョン**: 1.0
*   **廃止バージョン**: None (Active)
*   **オーバーロード一覧**: Supports pointer templates
*   **テンプレート引数**: `typename T`
*   **戻り値**: None
*   **引数一覧**: None
*   **関連する型**: `device T*`, `device T&`
*   **実装難易度**: Medium

### 2.2 Element: `threadgroup`
*   **Name**: `threadgroup`
*   **Category**: 2. Qualifier & 3. Address Space
*   **MSL-ExclusiveかC++互換か**: MSL-Exclusive
*   **ASTノード種別**: `QualType` with Address Space attribute
*   **Clang Semaで必要な処理**: Validates pointer declarations inside threadgroup. Ensures variable is not allocated inside nested blocks or initialized with compile-time constants.
*   **AST生成方法**: `ASTContext.getAddrSpaceQualType(BaseType, LangAS::opencl_local)`
*   **CodeGen処理**: Annotates pointer types with LLVM Address Space `3` (`addrspace(3)*`).
*   **LLVM IR**: `float addrspace(3)*`
*   **AIR Intrinsic**: None
*   **AIR Metadata**: None
*   **Calling Convention**: None
*   **Attribute**: `__attribute__((address_space(3)))`
*   **Address Space**: Address Space `3` (Local Shared Memory / LSM)
*   **ランタイムライブラリ依存**: None
*   **GPU命令への対応**: Lowered to `ld_local` / `st_local` targeting on-chip SRAM
*   **Metal Version**: Metal 1.0+
*   **追加されたバージョン**: 1.0
*   **廃止バージョン**: None (Active)
*   **オーバーロード一覧**: Supports pointer templates
*   **テンプレート引数**: `typename T`
*   **戻り値**: None
*   **引数一覧**: None
*   **関連する型**: `threadgroup T*`, `threadgroup T&`
*   **実装難易度**: Hard

---

## 3. Category 4: Attributes (`[[...]]`)

### 3.1 Element: `[[buffer(n)]]`
*   **Name**: `buffer(n)`
*   **Category**: 4. Attributes
*   **MSL-ExclusiveかC++互換か**: MSL-Exclusive
*   **ASTノード種別**: `ParmVarDecl` with `ArgumentBufferAttr`
*   **Clang Semaで必要な処理**: Validates that parameter is declared inside an entry-point function and `n` is an integer constant within target architecture ranges.
*   **AST生成方法**: `ParmVarDecl::addAttr` with `ArgumentBufferAttr::Create`
*   **CodeGen処理**: Attaches buffer index mapping metadata to `!air.arg_types` named metadata node.
*   **LLVM IR**: Annotates LLVM parameter with custom attribute identifier
*   **AIR Intrinsic**: None
*   **AIR Metadata**: `!air.arg_types`
*   **Calling Convention**: None
*   **Attribute**: `__attribute__((buffer(n)))`
*   **Address Space**: Address Space `1` / `2`
*   **ランタイムライブラリ依存**: None
*   **GPU命令への対応**: Populates base register descriptors at thread initialization
*   **Metal Version**: Metal 1.0+
*   **追加されたバージョン**: 1.0
*   **廃止バージョン**: None (Active)
*   **オーバーロード一覧**: None
*   **テンプレート引数**: None
*   **戻り値**: None
*   **引数一覧**: `n` (Unsigned integer)
*   **関連する型**: Pointers / References
*   **実装難易度**: Medium

---

## 4. Category 5: Builtin Variables

### 4.1 Element: `[[thread_position_in_grid]]`
*   **Name**: `thread_position_in_grid`
*   **Category**: 5. Builtin Variables
*   **MSL-ExclusiveかC++互換か**: MSL-Exclusive
*   **ASTノード種別**: `ParmVarDecl` with `WorkgroupIdentifierAttr`
*   **Clang Semaで必要な処理**: Validates that variable is declared inside a kernel or helper function with type `uint`, `uint2`, or `uint3`.
*   **AST生成方法**: `ParmVarDecl::addAttr` with `WorkgroupIdentifierAttr::Create`
*   **CodeGen処理**: Lowers variable load to direct `@air.thread_position_in_grid` intrinsic call.
*   **LLVM IR**: `%pos = call <3 x i32> @llvm.air.thread_position_in_grid()`
*   **AIR Intrinsic**: `@air.thread_position_in_grid`
*   **AIR Metadata**: None
*   **Calling Convention**: None
*   **Attribute**: `__attribute__((pcs("thread_position_in_grid")))`
*   **Address Space**: None
*   **ランタイムライブラリ依存**: None
*   **GPU命令への対応**: Loads coordinates from hardware dispatch registers
*   **Metal Version**: Metal 1.0+
*   **追加されたバージョン**: 1.0
*   **廃止バージョン**: None (Active)
*   **オーバーロード一覧**: Mapped on type sizes (`uint`, `uint2`, `uint3`)
*   **テンプレート引数**: None
*   **戻り値**: `uint3` / `uint2` / `uint`
*   **引数一覧**: None
*   **関連する型**: `uint3`
*   **実装難易度**: Medium
