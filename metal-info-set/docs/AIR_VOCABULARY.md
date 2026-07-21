# AIR intrinsic 語彙分析 (バイナリ実測)

> 出所: リポジトリ同梱バイナリ (libair_rt/libmetal_rt/libtracepoint_rt 等 64 アーカイブ + 10 metallib) の bitcode 文字列を全走査した機械抽出結果。
> データ: `../data/air_strings_binaries.csv` (8,132 トークン) / `../data/air_stems_binaries.txt` (2,530 基底ステム) / 再現: `scripts/build_final_tables.py`

## 1. 命名文法 (実測から確定)

AIR intrinsic は **オーバーロードを型サフィックスで名前に畳み込む** (LLVM 標準 intrinsic と同じ方式):

```
air.<op>[.<qual>...][.<type>...]
  type  := [v<N>]<t><bits>      t ∈ {f(float), i(int), u(uint), b(bool), h(half相当)}
         | v<N><t><bits>         ベクトル (例: v4f32 = <4 x float>)
  ptr   := p<addrspace><type>   ポインタ (例: p1i8 = i8 addrspace(1)*)
  qual  := s | u                 整数の符号付き/なし (例: air.max.s / air.max.u)
         | rt{z,p,n,e}           丸め (convert 系: toward-zero/+inf/-inf/even)
例:
  air.max.u.v3i8
  air.convert.f.v16f16.u.v16i8.rtp
  air.atomic.global.add.u.i32
  air.async_wg_copy.p1v2f16.p3v2f16
```

## 2. アドレス空間番号の強力な裏付け

`air.async_wg_copy.*` の両向きバリアントが **`p1* ↔ p3*`** のペアで存在:
→ **device(global) = addrspace(1), threadgroup(local) = addrspace(3)** を実データで確認 (ほぼ確定。残確認: constant=2, thread=0 は datalayout/`PU11MTLconstant` マングリング実測と整合)。

## 3. ファミリー分類 (ステム実測値)

| ファミリー | 例 (実測ステム) | 備考 |
|---|---|---|
| convert | `air.convert.f.v16f16.u.v16i8.rtp` | 4,631 バリアント = 全型×丸めの直積。文法化済 |
| 数学 (三角/指数/双曲/pi系) | `air.sin` `air.acospi` `air.atan2pi` `air.tanpi` `air.sincos` `air.cosh` `air.rsqrt` `air.fract` `air.mix` | f16/f32/f64 + ベクトル幅 v2〜v16 |
| 整数 | `air.abs.s/u` `air.abs_diff.s/u` `air.add_sat.s/u` `air.clamp.s/u` `air.clz` `air.ctz` `air.popcount` `air.hadd` `air.mad24` `air.rotate` `air.rhadd` | `.s/.u` 符号規則 |
| 丸め/基本 | `air.ceil` `air.floor` `air.rint` `air.round` `air.trunc` `air.fma` `air.fmax` `air.fmin` `air.fmod` `air.ldexp` `air.sign` | — |
| リダクション | `air.all` `air.any` `air.dot` | v4i1 等 |
| アトミック | `air.atomic.global.{add,and,max,or,sub,xor,xchg}.{s,u}.i32` `air.atomic.global.cmpxchg.weak` `air.atomic.global.load` `air.atomic.fence` | global/local 別空間系あり |
| バリア | `air.wg.barrier` `air.simdgroup.barrier` | — |
| shuffle | `air.shuffle.{s,u}` `air.shuffle2.{s,u}` | 64 バリアント/系 |
| ベクトル load/store | `air.vload.{private,global,local,constant}` `air.vstore.*` `air.vload_half` `air.vstorea_half` | addrspace 別 |
| 非同期コピー | `air.async_wg_copy.*` `air.async_wg_strided_copy.*` | p1↔p3 (MSL3 async copy) |
| texture read/write/sample/gather | `air.read_texture_2d[_array/_ms/...]` `air.write_texture_*` `air.sample_texture_*` `air.gather_*` `air.fence_texture_*` | `.s/.u.v4i32` 等の ch 型 |
| texture クエリ | `air.get_{width,height,depth}_texture_*` `air.get_array_size_texture_*` `air.get_num_samples[_texture_*]` `air.get_channel_{data_type,order}_texture_*` | cube→2d_array 系への正規化の兆候 (要probe) |
| 可視関数 | `air.is_null_visible_function_table` | — |
| エントリ変数 | `air.thread_position_in_grid` `air.thread_position_in_threadgroup` … (airconv 実測) | 一覧は airconv_air_ops.csv |
| メタデータ | `air.compile.fast_math_enable` `air.compile.denorms_disable` `air.compile.framebuffer_fetch_enable` `air.max_{device,constant,threadgroup}_buffers` `air.max_textures` `air.max_samplers` | 名前付き metadata キー |

## 4. 語彙の網羅性についての注意

- 本表は **ランタイムライブラリが参照する** intrinsic に限定される。エントリ処理 (補間/stage_in) や mesh/RT/tensor 系はランタイムに現れないため、airconv 語彙 (121 literal) との合流で補完。**フル網羅は macOS probe 実測が必須** (`probe_cells.csv` 579 件)。
- GPUCompiler.framework の strings (clang 組み込み intrinsic 一覧) を取得すればほぼ完全網羅になる見込み (macOS 実測タスク §6)。

## 5. golden 実測による訂正命名則 (2026-07-21, Xcode 26.5/metalfe 32023.883 確定)

§1 の文法はバイナリ実測ベースで正しいが、**長い複合 op 名の区切り**について v1 推測
(`air.abs.diff.s` 等のドット区切り) は golden で**全否定**された。実機コンパイルの確定規則:

1. **複合 op 名はアンダースコア連結** (型サフィックスは引き続きドット):
   `air.abs_diff.s.i8` `air.add_sat.s.i8` `air.extract_bits.s.i8` `air.mad_hi.s.i8`
2. **fast-math 有効時 (既定) では FP 高速版は `air.fast_*` 接頭**: `air.fast_saturate.f32` 等。
3. texture/depth は総じてアンダースコア:
   `air.sample_texture_2d.v4f32` `air.sample_compare_depth_2d.f32` `air.gather_depth_2d_array.v4f32`
   `air.get_num_mip_levels_depth_cube` `air.is_null_depth_2d_array` (depth も同系統)
   - texture 引数は `%struct._texture_2d_t addrspace(1)*`、sampler は `%struct._sampler_t addrspace(2)*`。
4. texture atomic (read_write):
   `air.atomic_texture_2d.add.u` 系 (クラス/型/オペレーションのアンダースコア形式;
   `__metal_atomic_fetch_add_explicit_texture_2d_t` → `air.atomic_fetch_add_explicit_texture_2d` 系列実測)。
5. RT (raytracing):
   - query ライフサイクル: `air.allocate_intersection_query.<tags>` /
     `air.deallocate_intersection_query.<tags>` / `air.abort_intersection_query.<tags>`
     (tags = `instancing.triangle_data[.curve_data]` のドット結合)
   - `air.commit_{triangle,curve,bounding_box}_intersection_intersection_query.<tags>`
   - `air.get_{candidate,committed}_*_intersection_query.<tags>` `air.next_intersection_query`
   - `air.intersect.<tags>` `air.get_null_instance_acceleration_structure` `air.get_null_intersection_function_table`
6. コマンド (ICB, MSL3.1 render/compute command):
   `air.set_pipeline_state_render_command` `air.set_kernel_buffer_compute_command`
   `air.concurrent_dispatch_threadgroups_compute_command` `air.draw_primitives_render_command` 等
7. simd/quad group: `air.simd_shuffle_down.f32` `air.simd_sum.f32` `air.quad_sum.f32`
   `air.quad_shuffle_rotate_up.i32` `air.simd_vote.{all,any}` 形式 (名はアンダースコア連結)。
8. 補間 (MSL4 interpolant): `air.interpolate_center_{perspective,no_perspective}.f32` 等
   (%struct._interpolant_t = type opaque)
9. `air.discard_fragment` / `air.wg.barrier(i32 scope, i32 mem)` 実測。

## 6. run10 golden 追補 (2026-07-21, std=metal4.0, -O2)

1. **quad/simd 整数 reduction**: `air.quad_and.s.i32` `air.quad_or.s.i32` `air.quad_xor.s.i32`
   `air.simd_and.s.i32` `air.simd_or.s.i32` `air.simd_xor.s.i32` (アンダースコア連結則どおり)。
   vote: `air.quad_vote_all` / `air.quad_vote_any` (型サフィックス無し、実測)。
2. **MSL4 rate-map (realtime render map)**: `air.map_physical_to_screen_coordinates.v2f32.p2i8.i32`
   `air.map_screen_to_physical_coordinates.v2f32.p2i8.i32` (u32 版は v2i32 prefix のみ差異、実測)。
3. **tensor (MSL4 device/global tensor)**: `air.get_null_global_tensor` `air.is_null_global_tensor`
   `air.get_stride_global_tensor.i32` `air.load_global_tensor.s.i32.global.f32`
   `air.store_global_tensor.s.i32.global.f32` `air.get_data_pointer_typed_global_tensor.s.i32.global`
   - `global_tensor` 語が必ず入る (typed handle/strided descriptor 系)。
   - **fold 則**: extent/descriptor_size/handle/slice/init_strided は -O2 で compile-time 定数化
     (`ret i32 4` / `ret void`) し air call として残らない (probe 観測は -O0 variant が必須; EVENTLOG XW_P10T_FOLD)。
   - tensor **型別名** (MSL の `tensor<...>` クラス名) に対応する専用 air op は存在しない
     (実測 block は null/is_null のみ) — `__metal_tensor_t`/`__metal_tensor_thread_t` は candidate 空欄の low。
4. **depth2d (texture class 非 ms)**: get_width=`air.get_width_depth_2d`, read=`air.read_depth_2d.f32`。
   ms 版も golden 上同名 (型 variant 共有)。read block 内の `air.get_read_sampler` は probe の
   `sampler s{}` 既定生成由来であり read op 本体ではない (harness artifact 注意)。
5. **fragment での `get_null_sampler`**: fragment stage では null 定数として型のみ現れ
   air call にならない場合がある (compute では call が出る — stage 依存則)。

全語彙 (本日 379 unique): `data/air_golden_names.csv` (golden *.ll から機械抽出、要上当番再生成)。
網羅性注意: golden probe カバレッジ外の op (mesh/[[patch]]/fragten/OS log 深部等) は引続き
バイナリ stems と airconv 語彙で補完する。P10T(-O0 variant)/P18K(entry stage 構成) probe で拡張予定。

## 7. run18–24 追補 (2026-07-21)

1. **imageblock (kernel 形のみ、MSL4.0 §5.6.4)**: `air.get_imageblock_{width,height,num_colors,samples}`
   / `air.get_color_coverage_mask` (imageblock 語が抜ける点に注意)
   / `air.load.implicit_imageblock.v4f32` / `air.store.implicit_imageblock.{v4f32,v4i32}`
   / `air.imageblock_data` / `air.store.imageblock.mask.{v4f16,i32,f32}` (メンバ型 suffix 分散)。
   `-O0/-O2` とも叫び順序で現れる load/store 系 (D-block 語は dot 区切り)。
2. **mesh (MSL4 [[mesh]]/[[object]])**: `air.set_index_mesh` / `air.set_indices_mesh.v4i8`
   / `air.set_primitive_count_mesh` / `air.set_primitive_id_mesh` / `air.set_position_mesh`
   / `air.set_threadgroups_per_grid_mesh_properties` (mesh_grid_properties)。vertex 属性毎に op 分散
   (position メンバのみでは air.set_position_mesh)。
3. **u64 buffer atomic min/max**: `air.atomic.global.{max,min}.u.i64`
   (min/max は device ulong 専用 = ヘッダ `_valid_{max,min}_type` 一次事実)。
4. **simdgroup_matrix 8x8**: `air.simdgroup_matrix_8x8_{init_diag,init_filled,store,multiply_accumulate,load}`
   引数型 suffix `.v64f32...` (vec<T,64> ストレージ)。
5. **AS タグ suffix**: `multi_level_instancing` (max_levels>=3 インスタンシングで出る tag 語)。
   `air.get_{candidate,committed}_instance_count_intersection_query.multi_level_instancing.triangle_data` 実測。
6. **変換系**: `air.convert.f.f32.u.i16` (u16→f32) のように **to-from とも符号付きかつ語順は to→from**
   (run19 patch 由来実測、§5 既定則と整合)。
7. **post-tess vertex**: `patch_control_point::size()` は `[[patch(triangle,3)]]` から compile-time 定数 fold
   (専用 air op 非存在 = frontend-consteval)。entry 属性制約: post-tess vertex では `vertex_id` 不可、
   `patch_id` が正 (一次診断)。

## 8. run24–26 追補 (2026-07-21、正本全確定化フェーズ)

1. **intersection query/result (P24B)**: primitive_data 系列も `intersection_query` 語を伴う
   (`air.get_{candidate,committed}_primitive_data_intersection_query.<tags>`)。
   `air.next_intersection_query` / `air.reset_intersection_query` (query reset は ctor でも
   `air.allocate_intersection_query`/`air.deallocate_intersection_query` が出る)。
   callback(ref) 形は direct_access 経路のまま `air.intersect_direct_access.<tags>` +
   `air.release_intersection_result.<tags>`。**payload 持ち値返却形は別 op**:
   `air.intersect.<tags>` (`__metal_intersect`) と `air.release_intersect_payload.<tags>`。
   `air.get_type_intersection_result.<tags>` は result**_ref** 由来 (result 値に accessor は無し)。
2. **AS/handle 系**: `air.is_null_{instance,primitive}_acceleration_structure` /
   `air.get_{instance,primitive}_acceleration_structure_instance_acceleration_structure` /
   `air.get_null_{intersection_function_table, visible_function_table, function_handle,
   primitive_acceleration_structure}` / `air.get_function_pointer_visible_function_table` /
   `air.get_size_command_buffer` / resource_id: `air.get_resource_id_{instance,primitive}_acceleration_structure`
   (公開 API は `operator MTLResourceID()`、`._impl` は uintptr_t)。
3. **ift/vft スロット**: vft は ift の i8 buffer slot 格納 —
   set/get とも buffer op 共有: `air.set_buffer_intersection_function_table.p1i8` /
   `air.get_buffer_intersection_function_table.p1i8` + bitcast (get_vft_ift も同 op)。
4. **get_null texture/depth (14)**: 実 air op として存在 `air.get_null_texture_{1d,1d_array,
   2d,2d_array,2d_ms,2d_ms_array,3d,buffer_1d,cube,cube_array}` / `air.get_null_depth_{2d,
   2d_ms,2d_array,2d_ms_array,cube,cube_array}` (型 suffix なし素名)。
5. **imageblock implicit slice family (P25M)**: implicit imageblock は **[[color(n)]] 属性付き
   struct のみ** (素 struct/float4 は layout 未定義で不可)。slice は `slice<E>(unsigned const index)`
   — E 明示 + Sema trait。`air.implicit_imageblock_data` (non-dot 語順: implicit_imageblock_data) /
   `air.write_imageblock_slice_to_texture_{1d,1d_array,2d,2d_array,3d,cube,cube_array}.i16.v4f32`
   (slice index i16 + 要素 vec) / `air.store.implicit_imageblock.mask.v4f32` (mask write)。
6. **frontend-consteval 確定 (air op 非存在 family)**: `__metal_get_control_point`
   (post-tess vertex: clang 合成関数 `_Z2CP.MTL_CONTROL_POINT_FN` 呼出形式へ降下、index は
   urem wrap) / `__metal_divide` (native fdiv) / `__metal_select` (native select) /
   `__metal_get_sampler` (constexpr sampler → module `@__air_sampler_state [2 x i64] addrspace(2)`
   定数 + `!air.sampler_states` metadata; sample op には bitcast で渡る) /
   `__metal_struct_has_render_target` (Sema 時評価専用: runtime 直叩きで metalfe-32023.883 は
   **frontend crash exit 138**) / 純粋型 builtin `_t` 系 (AIR では %struct._*_t opaque 型) /
   tensor extents/slice/handle (constexpr/field access fold)。**`air.is_function_constant_defined`
   は逆に実 air op として存在** (kernel 内で残る、function_constant 廃止にならない)。
7. **texture ulong4 atomic max/min (P26M)**: `air.atomic_{max,min}_explicit_texture_
   {1d,1d_array,2d,2d_array,3d,buffer_1d,cube,cube_array}.i16.u.v4i64` — coord index i16、
   unsigned `u`、operand `<4 x i64>`。**型制約が真因**: `_textureXd_atomic_modify<ulong,
   access read&&write> 専用化 (:__HAVE_DEVICE_COHERENT_READ_WRITE_TEXTURES__ でメンバ解放)` のため
   `texture2d<ulong, access::read_write>` 系で執行可能 (過去の「cap-gate で probe 不能」判断は
   この toolchain 次元では誤り)。buffer atomic u64 (P23) の `air.atomic.global.{max,min}.u.i64` と
   suffix 系統が異なる点 (global 語と型列) に注意。
8. **命名総則の訂正済語順**: 「`air.<verb>_<subject>` (u区切り) は subject 名詞句を連結、
   tags は `.<tag>...`、型 suffix は最後に `.to.from` (convert) / `.i16.u.v4i64` (atomic) /
   `.v64f32...` (matrix) / `.p1i8` (ポインタ引数)。推測段階の doc-dot 形式は全て
   golden 訂正へ置換済み (candidate 欄は golden 実名が唯一の最終値)。

**正本状態 (run26 反映後)**: 686 行全確定。confirmed 641 (93.4%) は golden 実測名、
low 45 (6.6%) は「air op 非存在」を実測で確定した行 (上記 §6)。未確定 (medium/high) は 0。
