# callgraph 再構築サマリ

生成: 2026-07-21T01:20Z by build_callgraph.py@1.0.0

- 入力: `/home/user/metal-repo/reference/clang/32023.883/lib/darwin` (1778 units → unique modules 1764)
- 総 call エッジ: 31134 (callee 名解決 31134)
- air.* callee (unique 名): 8111
- `__air_impl_*` → air.* 直接呼出のある公開実装: 2 件
- parse エラー: 0

## 例 (impl → air)

- `__air_impl_convert_f_f64_f_f32` → ['air.clz.i64']
- `__air_impl_os_log` → ['air.atomic.fence', 'air.get_private_data']

## rtlib_pairing との整合検証

- pairing 行 51 件 (no_impl 除く): 直接 call エッジ確認 20 件 / 未確認 4 件
- 未確認は 2-hop 以上 (別 internal 経由) か pairing のarchive非対応 (osxのみ検証対象外) の可能性。一覧:
  - libpost_mesh_dump_rt_osx.rtlib!__loweringlib.internal.0: 公開 []… 直接エッジ無し
  - libresource_tracking_rt_osx.rtlib!__loweringlib.internal.0: 公開 []… 直接エッジ無し
  - libresource_tracking_rt_osx.rtlib!__loweringlib.internal.1: 公開 []… 直接エッジ無し
  - libresource_tracking_rt_osx.rtlib!__loweringlib.internal.2: 公開 []… 直接エッジ無し
