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

全語彙 (本日 286 unique): `data/air_golden_names.csv` (golden *.ll から機械抽出、要上当番再生成)。
網羅性注意: golden probe カバレッジ外の op (mesh/tensor/OS log 等) は引続きバイナリ stems と airconv 語彙で補完する。
