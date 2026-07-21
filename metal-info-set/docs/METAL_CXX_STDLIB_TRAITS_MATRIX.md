# METAL_CXX_STDLIB_TRAITS_MATRIX — MSL 標準ライブラリ C++ 型特性・ユーティリティ相関表

> **2026-07-21 リモート実機 macOS 26.4 全走査確定**: `test_cxx_type_traits_probe.py` による実測に基づき、`metal_type_traits`, `metal_utility`, `metal_initializer_list` 等の C++ メタプログラミング機能の対応状況を全定量化。

## 1. 型特性・ユーティリティ標準世代別相関表 (`data/metal_cxx_stdlib_traits_matrix.csv`)

| 特性 ID | シンボル名 (`trait_name`) | モジュール | C++ 世代 | `metal1.x` | `metal2.x` | `metal3.x` | `metal4.0` | `metal4.1` (自前先行) | クリーンルーム実装ルール |
|---|---|---|---|---|---|---|---|---|---|
| `TRAIT_IS_SAME` | **`metal::is_same<T,U>`** | `metal_type_traits` | `C++11` | ✅ Supported | ✅ Supported | ✅ Supported | ✅ Supported | **✅ Supported** | Define `struct is_same` with `value = false/true` across all standards |
| `TRAIT_ENABLE_IF` | **`metal::enable_if<C,T>`** | `metal_type_traits` | `C++11` | ✅ Supported | ✅ Supported | ✅ Supported | ✅ Supported | **✅ Supported** | Define SFINAE template `struct enable_if` across all standards |
| `TRAIT_ENABLE_IF_T` | **`metal::enable_if_t<C,T> (_t alias)`** | `metal_type_traits` | `C++14` | ✅ Supported (`metal1.1+`) | ✅ Supported | ✅ Supported | ✅ Supported | **✅ Supported** | Define `template<bool C, class T> using enable_if_t = typename enable_if<C,T>::type` across all standards |
| `TRAIT_IS_SAME_V` | **`metal::is_same_v<T,U> (_v var template)`** | `metal_type_traits` | `C++14/17` | ❌ Rejected (`variable templates C++14`) | ✅ Supported (`metal2.0+`) | ✅ Supported | ✅ Supported | **✅ Supported** | Define `template<class T, class U> constexpr bool is_same_v = is_same<T,U>::value` starting in `metal2.0+` |
| `TRAIT_CONJUNCTION` | **`metal::conjunction<Traits...>`** | `metal_type_traits` | `C++17` | ❌ Rejected | ✅ Supported (`metal2.0+`) | ✅ Supported | ✅ Supported | **✅ Supported** | Define variadic trait logical AND `struct conjunction` starting in `metal2.0+` |
| `TRAIT_DISJUNCTION` | **`metal::disjunction<Traits...>`** | `metal_type_traits` | `C++17` | ❌ Rejected | ✅ Supported (`metal2.0+`) | ✅ Supported | ✅ Supported | **✅ Supported** | Define variadic trait logical OR `struct disjunction` starting in `metal2.0+` |
| `TRAIT_NEGATION` | **`metal::negation<Trait>`** | `metal_type_traits` | `C++17` | ❌ Rejected | ✅ Supported (`metal2.0+`) | ✅ Supported | ✅ Supported | **✅ Supported** | Define logical NOT `struct negation` starting in `metal2.0+` |
| `TRAIT_VOID_T` | **`metal::void_t<Args...>`** | `metal_type_traits` | `C++17` | ❌ Omitted in Apple stdlib | ❌ Omitted in Apple stdlib | ❌ Omitted in Apple stdlib | ❌ Omitted in Apple stdlib | **✅ Added in Clean-Room stdlib** | Define `template<typename... Args> using void_t = void` in Clean-Room `metal_type_traits.metal` for full C++ metaprogramming support |
| `TRAIT_IS_TRIVIAL` | **`metal::is_trivially_copyable<T>`** | `metal_type_traits` | `C++11` | ✅ Supported | ✅ Supported | ✅ Supported | ✅ Supported | **✅ Supported** | Driven by compiler builtin `__is_trivially_copyable(T)` |
| `TRAIT_IS_POINTER` | **`metal::is_pointer<T>`** | `metal_type_traits` | `C++11` | ✅ Supported | ✅ Supported | ✅ Supported | ✅ Supported | **✅ Supported** | Specialized for pointer types across address spaces (`device T*`, `constant T*`, etc.) |
| `UTIL_MOVE` | **`metal::move(T&&)`** | `metal_utility` | `C++11` | ✅ Supported | ✅ Supported | ✅ Supported | ✅ Supported | **✅ Supported** | Cast lvalue to rvalue reference (`static_cast<remove_reference_t<T>&&>(t)`) |
| `UTIL_FORWARD` | **`metal::forward<T>(T&&)`** | `metal_utility` | `C++11` | ❌ Omitted (`rvalue forwarding restricted`) | ❌ Omitted | ❌ Omitted | ❌ Omitted | **✅ Added in Clean-Room stdlib** | Define `forward<T>(remove_reference_t<T>&)` in Clean-Room stdlib |
| `UTIL_DECLVAL` | **`metal::declval<T>()`** | `metal_utility` | `C++11` | ✅ Supported | ✅ Supported | ✅ Supported | ✅ Supported | **✅ Supported** | Declare unevaluated rvalue reference (`add_rvalue_reference_t<T> declval() noexcept`) for `decltype` SFINAE |
| `UTIL_INT_SEQ` | **`metal::integer_sequence<T, N...>`** | `metal_utility` | `C++14` | ❌ Rejected (`metal1.x`) | ✅ Supported (`metal2.0+`) | ✅ Supported | ✅ Supported | **✅ Supported** | Define `struct integer_sequence` and `make_integer_sequence` starting in `metal2.0+` |
| `INIT_LIST` | **`metal::initializer_list<T>`** | `metal_initializer_list` | `C++11` | ✅ Supported | ✅ Supported | ✅ Supported | ✅ Supported | **✅ Supported** | Define `struct initializer_list` (`const T* _begin, size_t _size`) mapping to compiler array construction |
