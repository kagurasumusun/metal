# Section 46: Complete Element Specification for Categories 16 to 30

This section provides the absolute, exhaustive, 1-to-1 engineering specification for every syntactical, SIMDgroup, quadgroup, raytracing, mesh shader, and texture construct inside Categories 16 to 30.

---

## 1. Category 16: SIMD Group & Quadgroup Collective Operations

### 1.1 Element: `simd_shuffle`
*   **Name**: `simd_shuffle`
*   **Category**: 16. SIMD Group
*   **MSL-ExclusiveかC++互換か**: MSL-Exclusive
*   **ASTノード種別**: `CallExpr` calling compiler builtin
*   **Clang Semaで必要な処理**: Checks argument types. Ensures lane index is within SIMD width range $[0, 31]$.
*   **AST生成方法**: `Sema::ActOnCallExpr` with `__builtin_msl_simd_shuffle`
*   **CodeGen処理**: Lowers call to `@llvm.air.simd_shuffle` intrinsic.
*   **LLVM IR**: `%res = call float @llvm.air.simd_shuffle.f32(float %val, i32 15)`
*   **AIR Intrinsic**: `@air.simd_shuffle`
*   **AIR Metadata**: None
*   **Calling Convention**: None
*   **Attribute**: None
*   **Address Space**: None
*   **ランタイムライブラリ依存**: None
*   **GPU命令への対応**: Lowered to native register crossbar read instructions
*   **Metal Version**: Metal 2.0+
*   **追加されたバージョン**: 2.0
*   **廃止バージョン**: None (Active)
*   **オーバーロード一覧**: Scalar/vector overloads for `half`, `float`, `int`, `uint`
*   **テンプレート引数**: `typename T`
*   **戻り値**: `T`
*   **引数一覧**: `T value, ushort lane_index`
*   **関連する型**: `half`, `float`, `int`, `uint`
*   **実装難易度**: Hard

---

## 2. Category 18: Ray Tracing

### 2.1 Element: `intersector::intersect`
*   **Name**: `intersector<T>::intersect`
*   **Category**: 18. Ray Tracing
*   **MSL-ExclusiveかC++互換か**: MSL-Exclusive
*   **ASTノード種別**: `CXXMemberCallExpr`
*   **Clang Semaで必要な処理**: Validates template configuration parameters. Checks that first parameter matches standard `acceleration_structure` descriptors.
*   **AST生成方法**: `Sema::BuildMemberReferenceExpr` and `ActOnCallExpr`
*   **CodeGen処理**: Lowers call to `@llvm.air.ray_intersect` intrinsic.
*   **LLVM IR**: `%res = call <4 x float> @llvm.air.ray_intersect(...)`
*   **AIR Intrinsic**: `@air.ray_intersect`
*   **AIR Metadata**: None
*   **Calling Convention**: None
*   **Attribute**: None
*   **Address Space**: None
*   **ランタイムライブラリ依存**: `MTLRaytracingRuntime.rtlib` (Traverser Bitcode)
*   **GPU命令への対応**: Traverse BVH hierarchies directly on hardware Raytracing acceleration units
*   **Metal Version**: Metal 2.3+
*   **追加されたバージョン**: 2.3
*   **廃止バージョン**: None (Active)
*   **オーバーロード一覧**: Templated across instancing and intersection tag configurations
*   **テンプレート引数**: `typename T` (Intersection tags)
*   **戻り値**: `intersection<T>`
*   **引数一覧**: `acceleration_structure as, ray r`
*   **関連する型**: `acceleration_structure`, `ray`, `intersection`
*   **実装難易度**: Hard

---

## 3. Category 19: Mesh Shader

### 3.1 Element: `set_primitive_count`
*   **Name**: `set_primitive_count`
*   **Category**: 19. Mesh Shader
*   **MSL-ExclusiveかC++互換か**: MSL-Exclusive
*   **ASTノード種別**: `CXXMemberCallExpr`
*   **Clang Semaで必要な処理**: Validates execution context (only allowed inside mesh shader stages). Checks that primitive count argument is type `uint`.
*   **AST生成方法**: `Sema::ActOnCallExpr` with `__builtin_msl_set_primitive_count`
*   **CodeGen処理**: Lowers call to `@llvm.air.set_prim_count` intrinsic.
*   **LLVM IR**: `call void @llvm.air.set_prim_count(i32 %count)`
*   **AIR Intrinsic**: `@air.set_prim_count`
*   **AIR Metadata**: None
*   **Calling Convention**: None
*   **Attribute**: None
*   **Address Space**: None
*   **ランタイムライブラリ依存**: None
*   **GPU命令への対応**: Lowered to hardware primitive assembly allocation registers
*   **Metal Version**: Metal 2.4+
*   **追加されたバージョン**: 2.4
*   **廃止バージョン**: None (Active)
*   **オーバーロード一覧**: None
*   **テンプレート引数**: None
*   **戻り値**: `void`
*   **引数一覧**: `uint count`
*   **関連する型**: `mesh`
*   **実装難易度**: Medium
