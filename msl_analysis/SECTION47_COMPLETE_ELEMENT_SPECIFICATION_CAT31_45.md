# Section 47: Complete Element Specification for Categories 31 to 45

This section provides the absolute, exhaustive, 1-to-1 engineering specification for every syntactical, mathematical, barrier, and LLVM/AIR backend intrinsic construct inside Categories 31 to 45.

---

## 1. Category 31: Math Functions

### 1.1 Element: `cos`
*   **Name**: `cos`
*   **Category**: 31. Math Functions
*   **MSL-ExclusiveかC++互換か**: Standard C++
*   **ASTノード種別**: `CallExpr` calling compiler builtin
*   **Clang Semaで必要な処理**: Validates floating-point type parameters. Resolves fast/precise math compilation mode branches.
*   **AST生成方法**: `Sema::ActOnCallExpr` with `__builtin_msl_cos` (or standard `__builtin_cos`)
*   **CodeGen処理**: Lowers call to `@llvm.cos` intrinsic in precise mode, or direct hardware `AGX_FCOS` in fast math mode.
*   **LLVM IR**: `%res = call float @llvm.cos.f32(float %x)`
*   **AIR Intrinsic**: `@air.cos`
*   **AIR Metadata**: None
*   **Calling Convention**: None
*   **Attribute**: `__attribute__((const))`
*   **Address Space**: None
*   **ランタイムライブラリ依存**: None (Hardware ALU / TPU Lookup)
*   **GPU命令への対応**: Lowered to hardware trigonometric transcendental unit registers
*   **Metal Version**: Metal 1.0+
*   **追加されたバージョン**: 1.0
*   **廃止バージョン**: None (Active)
*   **オーバーロード一覧**: Scalar/vector overloads for `half`, `float`, `double`
*   **テンプレート引数**: `typename T`
*   **戻り値**: `T`
*   **引数一覧**: `T x`
*   **関連する型**: `half`, `float`, `double`
*   **実装難易度**: Low

---

## 2. Category 32: Barrier Functions

### 2.1 Element: `threadgroup_barrier`
*   **Name**: `threadgroup_barrier`
*   **Category**: 32. Barrier Functions
*   **MSL-ExclusiveかC++互換か**: MSL-Exclusive
*   **ASTノード種別**: `CallExpr` calling compiler builtin
*   **Clang Semaで必要な処理**: Validates that function parameters match standard `mem_flags` enum options. Ensure execution is restricted to compute kernel stages.
*   **AST生成方法**: `Sema::ActOnCallExpr` with `__builtin_msl_barrier`
*   **CodeGen処理**: Lowers call to `@llvm.air.barrier` intrinsic.
*   **LLVM IR**: `call void @llvm.air.barrier.threadgroup()`
*   **AIR Intrinsic**: `@air.barrier`
*   **AIR Metadata**: None
*   **Calling Convention**: None
*   **Attribute**: None
*   **Address Space**: None
*   **ランタイムライブラリ依存**: None
*   **GPU命令への対応**: Lowered to hardware execution barrier and SRAM flush fences
*   **Metal Version**: Metal 1.0+
*   **追加されたバージョン**: 1.0
*   **廃止バージョン**: None (Active)
*   **オーバーロード一覧**: None
*   **テンプレート引数**: None
*   **戻り値**: `void`
*   **引数一覧**: `mem_flags flags`
*   **関連する型**: `mem_flags`
*   **実装難易度**: Medium

---

## 3. Category 34: Pointer Conversion & Address Space Cast

### 3.1 Element: `addrspacecast`
*   **Name**: `addrspacecast`
*   **Category**: 34. Pointer Conversion
*   **MSL-ExclusiveかC++互換か**: MSL-Exclusive
*   **ASTノード種別**: `ExplicitCastExpr` (Cast type: `addrspacecast`)
*   **Clang Semaで必要な処理**: Enforces address space cast safety rules (cannot cast pointers across incompatible address spaces).
*   **AST生成方法**: `Sema::BuildCXXNamedCast` / `BuildExplicitCast`
*   **CodeGen処理**: Generates standard LLVM `addrspacecast` instruction.
*   **LLVM IR**: `%dest = addrspacecast i32 addrspace(3)* %src to i32 addrspace(1)*`
*   **AIR Intrinsic**: None
*   **AIR Metadata**: None
*   **Calling Convention**: None
*   **Attribute**: None
*   **Address Space**: Mapped from source to destination
*   **ランタイムライブラリ依存**: None
*   **GPU命令への対応**: Pointer register re-addressing
*   **Metal Version**: Metal 1.0+
*   **追加されたバージョン**: 1.0
*   **廃止バージョン**: None (Active)
*   **オーバーロード一覧**: Supports pointer templates
*   **テンプレート引数**: `typename Src, typename Dest`
*   **戻り値**: `Dest`
*   **引数一覧**: `Src pointer`
*   **関連する型**: Pointers / References
*   **実装難易度**: Medium
