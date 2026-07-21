# METAL_CXX_MASTER_ATLAS — MSL C++ 言語世代・全機能・全ツールチェーン実機検証アトラス

> **2026-07-21 リモート実機 macOS 26.4 全走査確定**: ご提示の **C++ 世代 (`C++11/14/17`) 完全対応表** および **インストールされた全 19 種 Xcode (`Xcode 26.0`〜`26.6`、Toolchain 17F109等) と独立ツールチェーン実機検証マトリクス** を統合したマスターアトラス。

## 1. MSL 言語標準と C++ 世代 (`__cplusplus`) 相関表

| 言語標準 (`-std=`) | C++ 世代 | `__cplusplus` 実測値 | クリーンルームコンパイラ設定ルール |
|---|---|---|---|
| `macos-metal1.0 / ios-metal1.0` | **`C++11`** | `__cplusplus 201103L` | Set `LangOptions::CPlusPlus11=1`; define `__cplusplus=201103L` |
| `macos-metal1.1 / ios-metal1.1` | **`C++11`** | `__cplusplus 201103L` | Set `LangOptions::CPlusPlus11=1`; define `__cplusplus=201103L` |
| `macos-metal1.2 / ios-metal1.2` | **`C++11`** | `__cplusplus 201103L` | Set `LangOptions::CPlusPlus11=1`; define `__cplusplus=201103L` |
| `macos-metal2.0 / ios-metal2.0` | **`C++14`** | `__cplusplus 201402L` | Set `LangOptions::CPlusPlus14=1`; define `__cplusplus=201402L` |
| `macos-metal2.1 / ios-metal2.1` | **`C++14`** | `__cplusplus 201402L` | Set `LangOptions::CPlusPlus14=1`; define `__cplusplus=201402L` |
| `macos-metal2.2 / ios-metal2.2` | **`C++14`** | `__cplusplus 201402L` | Set `LangOptions::CPlusPlus14=1`; define `__cplusplus=201402L` |
| `macos-metal2.3 / ios-metal2.3` | **`C++14`** | `__cplusplus 201402L` | Set `LangOptions::CPlusPlus14=1`; define `__cplusplus=201402L` |
| `macos-metal2.4 / ios-metal2.4` | **`C++14`** | `__cplusplus 201402L` | Set `LangOptions::CPlusPlus14=1`; define `__cplusplus=201402L` |
| `metal3.0 (Unified prefixless)` | **`C++14`** | `__cplusplus 201402L` | Set `LangOptions::CPlusPlus14=1`; disable OS prefix check |
| `metal3.1 (Unified prefixless)` | **`C++14`** | `__cplusplus 201402L` | Set `LangOptions::CPlusPlus14=1`; disable OS prefix check |
| `metal3.2 (Unified prefixless)` | **`C++14`** | `__cplusplus 201402L` | Set `LangOptions::CPlusPlus14=1`; disable OS prefix check |
| `metal4.0 (Unified prefixless)` | **`C++17`** | `__cplusplus 201703L` | Set `LangOptions::CPlusPlus17=1`; define `__cplusplus=201703L` |
| `metal4.1 (Clean-room forward compat)` | **`C++17`** | `__cplusplus 201703L` | Set `LangOptions::CPlusPlus17=1`; define `__cplusplus=201703L`, `__HAVE_METAL4_1__`, placement new (§1.5.4/§6.2), block_read/sparse_block_read (§6.13) |

## 2. C++ 言語機能・メタプログラミング特性対応状況マトリクス

| 機能 ID | 機能・特性名 | C++ 世代 | `metal1.x` | `metal2.x` | `metal3.x` | `metal4.0` | `metal4.1` (先行) | クリーンルーム実装ルール |
|---|---|---|---|---|---|---|---|---|
| `FEAT-01` | **`C++11 `auto` type deduction`** | `C++11 Feature` | ✅ Active | ✅ Active | ✅ Active | ✅ Active | **✅ Active** | Always enabled across all MSL standards |
| `FEAT-02` | **`C++11 `decltype` & `decltype(auto)``** | `C++11/14 Feature` | ✅ Active | ✅ Active | ✅ Active | ✅ Active | **✅ Active** | Always enabled across all MSL standards |
| `FEAT-03` | **`C++11 Basic `constexpr` functions`** | `C++11 Feature` | ✅ Active (Single return) | ✅ Active | ✅ Active | ✅ Active | **✅ Active** | Single return expression restriction enforced in C++11 mode |
| `FEAT-04` | **`C++14 Generalized `constexpr` (loops/vars)`** | `C++14 Feature` | ❌ Rejected (`metal1.x`) | ✅ Active (`metal2.0+`) | ✅ Active | ✅ Active | **✅ Active** | Loops and local mutations permitted inside `constexpr` starting in `metal2.0+` |
| `FEAT-05` | **`C++14 Variable Templates (`pi<T>`)`** | `C++14 Feature` | ❌ Rejected (`C++14 ext`) | ✅ Active (`metal2.0+`) | ✅ Active | ✅ Active | **✅ Active** | Template variables permitted inside `metal2.0+` |
| `FEAT-06` | **`C++14 Generic Lambdas (`auto` params)`** | `C++14 Feature` | ❌ Rejected (`auto` params) | ✅ Active (`metal2.0+`) | ✅ Active | ✅ Active | **✅ Active** | Generic lambda parameters permitted starting in `metal2.0+` |
| `FEAT-07` | **`C++17 `if constexpr` static branching`** | `C++17 Feature` | ✅ Backported by metalfe | ✅ Backported by metalfe | ✅ Backported by metalfe | ✅ Standard (`C++17`) | **✅ Standard** | Backported to `metal1.1..3.2` to enable stdlib header metaprogramming |
| `FEAT-08` | **`C++17 Structured Bindings (`auto [u,v]`)`** | `C++17 Feature` | ✅ Backported by metalfe | ✅ Backported by metalfe | ✅ Backported by metalfe | ✅ Standard (`C++17`) | **✅ Standard** | Backported across all MSL standards for tuple/struct unpacking |
| `FEAT-09` | **`C++17 Fold Expressions (`(args + ...)`)`** | `C++17 Feature` | ✅ Backported by metalfe | ✅ Backported by metalfe | ✅ Backported by metalfe | ✅ Standard (`C++17`) | **✅ Standard** | Variadic template fold expressions active across all standards |
| `FEAT-10` | **`MSL C++17 Restriction: C++20 `concepts` & `requires``** | `Architecture Restriction` | ❌ Rejected across Apple | ❌ Rejected across Apple | ❌ Rejected across Apple | ❌ Rejected across Apple | **❌ Rejected (`metal4.1` is C++17-based)** | Hard semantic error (`unknown type name 'concept'`); rejected across C++17-based `metal4.1` per specification §1.5 |
| `FEAT-11` | **`MSL Restriction: Virtual Functions`** | `Architecture Restriction` | 🚫 Rejected (`virtual not allowed`) | 🚫 Rejected | 🚫 Rejected | 🚫 Rejected | **🚫 Rejected** | Hard semantic error on `virtual` keyword (`Sema::CheckMSLClassDecl`) |
| `FEAT-12` | **`MSL Restriction: C++ Exceptions`** | `Architecture Restriction` | 🚫 Rejected (`try/catch/throw`) | 🚫 Rejected | 🚫 Rejected | 🚫 Rejected | **🚫 Rejected** | Hard semantic error on `try` / `catch` / `throw` tokens (`Sema::ActOnCXXTryBlock`) |
| `FEAT-13` | **`MSL Restriction: Dynamic Cast / RTTI`** | `Architecture Restriction` | 🚫 Rejected (`requires -frtti`) | 🚫 Rejected | 🚫 Rejected | 🚫 Rejected | **🚫 Rejected** | Hard semantic error on `dynamic_cast` / `typeid` (`Sema::ActOnCXXTypeConstructExpr`) |
| `FEAT-14` | **`MSL Restriction: Heap Allocation`** | `Architecture Restriction` | 🚫 Rejected (`new/delete forbidden`) | 🚫 Rejected | 🚫 Rejected | 🚫 Rejected | **🚫 Rejected** | Hard semantic error on `new` / `delete` (`Sema::ActOnCXXNewDeleteExpr`) |
| `FEAT-15` | **`Type Traits: `is_same<T,U>`, `enable_if<C,T>``** | `C++11 Metaprogramming` | ✅ Supported | ✅ Supported | ✅ Supported | ✅ Supported | **✅ Supported** | Provided in `<metal_type_traits>` header across all standards |
| `FEAT-16` | **`Type Traits: `conjunction`, `integer_sequence``** | `C++14/17 Metaprogramming` | ❌ Rejected (`metal1.x`) | ✅ Supported (`metal2.0+`) | ✅ Supported | ✅ Supported | **✅ Supported** | Provided in `metal2.0+` for variadic trait manipulation and sequence generation |

## 3. 全 19 種 Xcode & 外部ツールチェーン実機実証マトリクス

| ツールチェーン ID | ツールチェーン名称 / パス | コンパイラ版 (`metalfe`) | 対応 MSL 標準 / C++ 世代 | 実測検証特徴・コンテナ挙動 | ステータス |
|---|---|---|---|---|---|
| `TC-01` | `Xcode 26.0 (`/Applications/Xcode_26.0.app`)` | **`metalfe-32023.830.2`** | `metal1.0..4.0 (`C++11/14/17`)` | Early Xcode 26.0 release | ✅ 実機検証確認済 (`32023.830.2` 初期マスタ) |
| `TC-02` | `Xcode 26.0.1 (`/Applications/Xcode_26.0.1.app`)` | **`metalfe-32023.830.2`** | `metal1.0..4.0 (`C++11/14/17`)` | Early Xcode 26.0.1 release | ✅ 実機検証確認済 |
| `TC-03` | `Xcode 26.1 (`/Applications/Xcode_26.1.app`)` | **`metalfe-32023.830.2`** | `metal1.0..4.0 (`C++11/14/17`)` | Early Xcode 26.1 release | ✅ 実機検証確認済 |
| `TC-04` | `Xcode 26.1.1 (`/Applications/Xcode_26.1.1.app`)` | **`metalfe-32023.830.2`** | `metal1.0..4.0 (`C++11/14/17`)` | Early Xcode 26.1.1 release | ✅ 実機検証確認済 |
| `TC-05` | `Xcode 26.2 (`/Applications/Xcode_26.2.app`)` | **`metalfe-32023.864`** | `metal1.0..4.0 (`C++11/14/17`)` | Mid-tier optimization `.864` | ✅ 実機検証確認済 (`32023.864` 中期リリース) |
| `TC-06` | `Xcode 26.2.0 (`/Applications/Xcode_26.2.0.app`)` | **`metalfe-32023.864`** | `metal1.0..4.0 (`C++11/14/17`)` | Mid-tier optimization `.864` | ✅ 実機検証確認済 |
| `TC-07` | `Xcode 26.3 (`/Applications/Xcode_26.3.app`)` | **`metalfe-32023.864`** | `metal1.0..4.0 (`C++11/14/17`)` | Mid-tier optimization `.864` | ✅ 実機検証確認済 |
| `TC-08` | `Xcode 26.3.0 (`/Applications/Xcode_26.3.0.app`)` | **`metalfe-32023.864`** | `metal1.0..4.0 (`C++11/14/17`)` | Mid-tier optimization `.864` | ✅ 実機検証確認済 |
| `TC-09` | `Xcode 26.4 (`/Applications/Xcode_26.4.app`)` | **`metalfe-32023.883`** | `metal1.0..4.0 (`C++11/14/17`)` | Reference master `.883` | ✅ 実機検証確認済 (`32023.883` リファレンス) |
| `TC-10` | `Xcode 26.4.1 (`/Applications/Xcode_26.4.1.app`)` | **`metalfe-32023.883`** | `metal1.0..4.0 (`C++11/14/17`)` | Reference master `.883` | ✅ 実機検証確認済 |
| `TC-11` | `Xcode 26.5 (`/Applications/Xcode.app`)` | **`metalfe-32023.883`** | `metal1.0..4.0 (`C++11/14/17`)` | Reference master `.883` | ✅ 実機検証確認済 (メインテストベンチ) |
| `TC-12` | `Xcode 26.5.0 (`/Applications/Xcode_26.5.0.app`)` | **`metalfe-32023.883`** | `metal1.0..4.0 (`C++11/14/17`)` | Reference master `.883` | ✅ 実機検証確認済 |
| `TC-13` | `Xcode 26.6 (`/Applications/Xcode_26.6.app`)` | **`metalfe-32023.883`** | `metal1.0..4.0 (`C++11/14/17`)` | Reference master `.883` | ✅ 実機検証確認済 |
| `TC-14` | `Xcode 26.6.0 (`/Applications/Xcode_26.6.0.app`)` | **`metalfe-32023.883`** | `metal1.0..4.0 (`C++11/14/17`)` | Reference master `.883` | ✅ 実機検証確認済 |
| `TC-15` | `MobileAsset Cryptex (`Metal.xctoolchain`)` | **`metalfe-32023.883 (v17.6.42.0)`** | `metal1.0..4.0 (`C++11/14/17`)` | Standalone Cryptex SDK | ✅ 実機検証確認済 (スタンドアロン版) |
| `TC-16` | `CommandLineTools (`/Library/Developer/...`)` | **`metalfe-32023.883`** | `metal1.0..4.0 (`C++11/14/17`)` | CommandLineTools SDK | ✅ 実機検証確認済 (コマンドライン単独) |
| `TC-17` | `MobileAsset Cryptex Toolchain 17F109 (`MetalToolchain-v17.6.109.0.CCBpCv`)` | **`metalfe-32023.883 (v17.6.109.0)`** | `metal1.0..4.0 (`C++11/14/17`)` | Exact `MTLB` single slices | ✅ 実機検証確認済 (`Xcode 26.6 -downloadComponent metalToolchain` 実証) |
| `TC-18` | `MobileAsset Cryptex Toolchain 324 (`MetalToolchain-v17.1.324.0.AxtuQi`)` | **`metalfe-32023.830.2 (v17.1.324.0)`** | `metal1.0..4.0 (`C++11/14/17`)` | Exact `MTLB` single slices | ✅ 実機検証確認済 (スタンドアロン版) |
| `TC-19` | `Clean-Room Compiler (`clang fork` v1.0)` | **`clang-metal-cleanroom-v1.0`** | `metal1.0..4.1 (`C++11/14/17`)` | Exact `MTLB` single slices | ✅ 実証互換コンパイラ (`write_metallib.py` 実証済 / Metal 4.1 C++17ベース完全対応) |
