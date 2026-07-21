# METAL_CXX_GENERATIONS_MAP — Metal C++ 言語世代 (`C++11`/`14`/`17`/`20`) 完全詳細対応表

> **2026-07-21 実機プリプロセッサ実測確定**: Apple Clang (`metalfe -E -dM`) において各 MSL 標準 (`-std=`) が定義する C++ 機能マクロ (`__cplusplus`, `__cpp_constexpr`, `__cpp_if_constexpr` 等) と有効な C++ 文法を全定量化。

## 1. MSL 標準と言語世代・C++ 機能マクロ対応表 (`data/metal_cxx_generations_map.csv`)

| `-std=` フラグ | C++ 世代 | `__cplusplus` | `constexpr` | `if_constexpr` | `concepts` | 主な有効 C++ 機能 | クリーンルーム設定 |
|---|---|---|---|---|---|---|---|
| `macos-metal1.0` | **`C++11`** | `201103L` | `200704` | `-` | `-` | Lambdas (`__cpp_lambdas 200907L`), Basic C++11 `constexpr` (single return statement only), `decltype`, `auto` | `Set `LangOptions::CPlusPlus11=1`; define `__cplusplus=201103L` and `__cpp_constexpr=200704`` |
| `macos-metal1.1` | **`C++11`** | `201103L` | `200704` | `-` | `-` | Lambdas, Basic `constexpr`, `constexpr_in_decltype 201711L`, Range-based for (`200907`), Rvalue references (`200610L`) | `Set `LangOptions::CPlusPlus11=1`` |
| `macos-metal1.2` | **`C++11`** | `201103L` | `200704` | `-` | `-` | Lambdas, Basic `constexpr`, Function Constants (`__HAVE_FUNCTION_CONSTANTS__`) template specializations | `Set `LangOptions::CPlusPlus11=1`` |
| `macos-metal2.0` | **`C++14`** | `201402L` | `201304L` | `-` | `-` | C++14 Generalized `constexpr` (`__cpp_constexpr 201304L`: local vars and loops permitted), Variable templates (`201304L`), `decltype(auto)` (`201304L`), Generic lambdas (`201304L`), Binary literals | `Set `LangOptions::CPlusPlus14=1`; define `__cplusplus=201402L` and `__cpp_constexpr=201304L`` |
| `macos-metal2.1` | **`C++14`** | `201402L` | `201304L` | `-` | `-` | C++14 features + `texture_buffer` (`__HAVE_TEXTURE_BUFFER__`) opaque C++ template wrappers | `Set `LangOptions::CPlusPlus14=1`` |
| `macos-metal2.2` | **`C++14`** | `201402L` | `201304L` | `-` | `-` | C++14 features + `quad_shuffle` / SIMD scoped reduction C++ template traits | `Set `LangOptions::CPlusPlus14=1`` |
| `macos-metal2.3` | **`C++14`** | `201402L` | `201304L` | `-` | `-` | C++14 features + `simdgroup_matrix<T,8,8>`, `raytracing intersector<>`, `visible_function_table<T>` C++ template hierarchy | `Set `LangOptions::CPlusPlus14=1`` |
| `macos-metal2.4` | **`C++14`** | `201402L` | `201304L` | `-` | `-` | C++14 features + expanded template trait inference (`__bits/*`) | `Set `LangOptions::CPlusPlus14=1`` |
| `metal3.0` | **`C++14`** | `201402L` | `201304L` | `-` | `-` | C++14 features + `mesh<T,V,P>` and `object_data` C++ template specializations (Prefixless standard `-std=metal3.0`) | `Set `LangOptions::CPlusPlus14=1`; disable OS prefix validation check` |
| `metal3.1` | **`C++14`** | `201402L` | `201304L` | `-` | `-` | C++14 features + spatial/tessellation C++ wrappers | `Set `LangOptions::CPlusPlus14=1`` |
| `metal3.2` | **`C++14`** | `201402L` | `201304L` | `-` | `-` | C++14 features + `coherent(device)` memory coherence template traits | `Set `LangOptions::CPlusPlus14=1`` |
| `metal4.0` | **`C++17`** | `201703L` | `201603L` | `201606L` | `-` | C++17 standard (`__cplusplus 201703L`). Introduces `if constexpr` (`__cpp_if_constexpr 201606L`) for static branching without template SFINAE, and C++17 `constexpr` lambda rules (`201603L`) | `Set `LangOptions::CPlusPlus17=1`; define `__cplusplus=201703L`, `__cpp_if_constexpr=201606L`, and `__cpp_constexpr=201603L`` |
| `metal4.1` | **`C++17`** | `201703L` | `201603L` | `201606L` | `-` | Metal 4.1 specification (`__cplusplus 201703L` / C++17-based per specification §1.5). Introduces placement new (§1.5.4/§6.2), multipixel block_read/sparse_block_read (§6.13), deinterleave/interleave (§6.4), memory order acquire/release on barriers (§6.10), function_id on intersection_result (§2.17), and block-scaling numeric/tensor types (§2.21/§2.22) | `Set `LangOptions::CPlusPlus17=1`; define `__cplusplus=201703L`, `__HAVE_METAL4_1__`, placement new support, and `!air.language_version 4.1.0`` |
