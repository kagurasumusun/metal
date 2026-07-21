# TYPE_LAYOUT_MAP — opaque `_t` 型の IR 型レイアウト定量表

生成: scripts/build_type_layout_map.py (機械生成、golden corpus 全 51 ファイル走査)

MSL のハンドル型 (texture/depth/sampler/AS/ift/vft/pipeline state/tensor/imageblock 等) は
AIR IR では **`%struct._<name>_t = type opaque`** (正体不明の opaque 構造体) として現れ、
実体サイズはメタデータ (`!air.arg_type_size`) およびホスト側 ABI でのみ意味を持つ。
本表は golden corpus に実在する全 opaque `_t` 構造体の宣言・addrspace 使用・出現度数を定量した正本。

| ir_struct | builtin 行 | addrspace 使用 | 出現 (型宣言箇所) | ヘッダ文脈 (最初の1件) |
|---|---|---|---|---|
| `%struct._command_buffer_t` | __metal_command_buffer_t | as1 | 7 | metal/metal_command_buffer:203: __metal_command_buffer_t t; |
| `%struct._compute_pipeline_state_t` | __metal_compute_pipeline_state_t | as1 | 7 | metal/metal_command_buffer:373: __metal_compute_pipeline_state_t t; |
| `%struct._depth_2d_array_t` | __metal_depth_2d_array_t | as1 | 6 | metal/__bits/metal_depth2d_array:2187: __metal_depth_2d_array_t t; |
| `%struct._depth_2d_ms_array_t` | __metal_depth_2d_ms_array_t | as1 | 6 | metal/__bits/metal_depth2d_ms_array:651: __metal_depth_2d_ms_array_t t; |
| `%struct._depth_2d_ms_t` | __metal_depth_2d_ms_t | as1 | 3 | metal/__bits/metal_depth2d_ms:620: __metal_depth_2d_ms_t t; |
| `%struct._depth_2d_t` | __metal_depth_2d_t | as1 | 8 | metal/__bits/metal_depth2d:2157: __metal_depth_2d_t t; |
| `%struct._depth_cube_array_t` | __metal_depth_cube_array_t | as1 | 6 | metal/__bits/metal_depthcube_array:2176: __metal_depth_cube_array_t t; |
| `%struct._depth_cube_t` | __metal_depth_cube_t | as1 | 6 | metal/__bits/metal_depthcube:2159: __metal_depth_cube_t t; |
| `%struct._depth_stencil_state_t` | __metal_depth_stencil_state_t | as1 | 6 | metal/metal_command_buffer:790: __metal_depth_stencil_state_t s; |
| `%struct._function_handle_t` | __metal_function_handle_t | as1 | 3 | metal/metal_visible_function_table:18: static METAL_FUNC function_handle __get_from_opaque_handle(__metal_function_handle_t f) { |
| `%struct._imageblock_t` | __metal_imageblock_t | as4 | 2 | metal/metal_imageblocks:173: __metal_imageblock_t _imgblock; |
| `%struct._instance_acceleration_structure_t` | __metal_instance_acceleration_structure_t | as1 | 9 | metal/metal_raytracing:681: using handle_type = __metal_instance_acceleration_structure_t; |
| `%struct._interpolant_t` | __metal_interpolant_t | as1 | 1 | metal/metal_interpolate:46: __metal_interpolant_t impl; |
| `%struct._intersection_function_table_t` | __metal_intersection_function_table_t | as1 | 11 | metal/metal_raytracing:1868: __metal_intersection_function_table_t t; |
| `%struct._intersection_query_t` | __metal_intersection_query_t | (宣言のみ) | 5 | metal/metal_raytracing:4552: __metal_intersection_query_t q; |
| `%struct._intersection_result_t` | __metal_intersection_result_t | as9 | 5 | metal/metal_raytracing:2432: __metal_intersection_result_t result; |
| `%struct._mesh_grid_properties_t` | __metal_mesh_grid_properties_t | as3 | 1 | metal/metal_mesh:118: __metal_mesh_grid_properties_t p; |
| `%struct._mesh_t` | __metal_mesh_t | as7 | 1 | metal/metal_mesh:98: __metal_mesh_t m; |
| `%struct._patch_control_point_t` | __metal_patch_control_point_t | (宣言のみ) | 2 | metal/metal_tessellation:40: __metal_patch_control_point_t pcp; |
| `%struct._primitive_acceleration_structure_t` | __metal_primitive_acceleration_structure_t | as1 | 2 | metal/metal_raytracing:660: using handle_type = __metal_primitive_acceleration_structure_t; |
| `%struct._render_pipeline_state_t` | __metal_render_pipeline_state_t | as1 | 6 | metal/metal_command_buffer:620: __metal_render_pipeline_state_t t; |
| `%struct._sampler_t` | __metal_sampler_t | as2 | 9 | metal/__bits/metal_texture_common:841: __metal_sampler_t val; |
| `%struct._tensor_t` | __metal_tensor_t | as1 | 3 | metal/metal_tensor:1451: METAL_FUNC tensor(__metal_tensor_t other, const thread offsets_type &other_offsets) thread |
| `%struct._texture_1d_array_t` | __metal_texture_1d_array_t | as1 | 6 | metal/__bits/metal_texture1d_array:1923: __metal_texture_1d_array_t t; |
| `%struct._texture_1d_t` | __metal_texture_1d_t | as1 | 6 | metal/__bits/metal_texture1d:1891: __metal_texture_1d_t t; |
| `%struct._texture_2d_array_t` | __metal_texture_2d_array_t | as1 | 6 | metal/__bits/metal_texture2d_array:2610: __metal_texture_2d_array_t t; |
| `%struct._texture_2d_ms_array_t` | __metal_texture_2d_ms_array_t | as1 | 2 | metal/__bits/metal_texture2d_ms_array:658: __metal_texture_2d_ms_array_t t; |
| `%struct._texture_2d_ms_t` | __metal_texture_2d_ms_t | as1 | 2 | metal/__bits/metal_texture2d_ms:627: __metal_texture_2d_ms_t t; |
| `%struct._texture_2d_t` | __metal_texture_2d_t | as1 | 9 | metal/__bits/metal_texture2d:2590: __metal_texture_2d_t t; |
| `%struct._texture_3d_t` | __metal_texture_3d_t | as1 | 6 | metal/__bits/metal_texture3d:2506: __metal_texture_3d_t t; |
| `%struct._texture_buffer_1d_t` | __metal_texture_buffer_1d_t | as1 | 6 | metal/__bits/metal_texture_buffer:1527: __metal_texture_buffer_1d_t t; |
| `%struct._texture_cube_array_t` | __metal_texture_cube_array_t | as1 | 7 | metal/__bits/metal_texturecube_array:2629: __metal_texture_cube_array_t t; |
| `%struct._texture_cube_t` | __metal_texture_cube_t | as1 | 7 | metal/__bits/metal_texturecube:2609: __metal_texture_cube_t t; |
| `%struct._vertex_value_t` | __metal_vertex_value_t | as1 | 1 | metal/metal_vertex_value:30: __metal_vertex_value_t impl; |
| `%struct._visible_function_table_t` | __metal_visible_function_table_t | as1 | 5 | metal/metal_visible_function_table:184: static METAL_FUNC visible_function_table __get_from_opaque_handle(__metal_visible_function_table_t t) { |
