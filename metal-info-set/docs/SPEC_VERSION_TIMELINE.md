# MSL 仕様書 全バージョン横断タイムライン

11 全バージョンの新機能セクション (新版: "New in Metal X.Y" / 旧版: 8 Revision History) 原文抜粋と、`[[属性]]`・章の導入時期マトリクス。データ: `data/spec_attrs_matrix.csv`, `data/spec_chapters_matrix.csv` (章検出は ToC パースのヒューリスティック由来)

## 属性導入時期サマリ

| MSL | 新出属性 |
|---|---|
| **1.2** (38) | `attribute`, `base_instance`, `base_vertex`, `buffer`, `center_no_perspective`, `center_perspective`, `clip_distance`, `color`, `depth`, `early_fragment_tests`, `flat`, `front_facing`, `function_constant`, `instance_id`, `patch`, `patch_id`, `point_coord`, `point_size`, `position`, `position_in_patch`, `render_target_array_index`, `sample_id`, `sample_mask`, `sample_perspective`, `sampler`, `stage_in`, `texture`, `thread_execution_width`, `thread_index_in_threadgroup`, `thread_position_in_grid`, `thread_position_in_threadgroup`, `threadgroup`, `threadgroup_position_in_grid`, `threadgroups_per_grid`, `threads_per_grid`, `threads_per_threadgroup`, `user`, `vertex_id` |
| **2.0** (9) | `dispatch_simdgroups_per_threadgroup`, `dispatch_threads_per_threadgroup`, `id`, `raster_order_group`, `simdgroup_index_in_threadgroup`, `simdgroups_per_threadgroup`, `thread_index_in_simdgroup`, `threads_per_simdgroup`, `viewport_array_index` |
| **2.1** (12) | `alias_implicit_imageblock`, `alias_implicit_imageblock_color`, `dispatch_quadgroups_per_threadgroup`, `imageblock_data`, `invariant`, `max_total_threads_per_threadgroup`, `pixel_position_in_tile`, `pixels_per_tile`, `quadgroup_index_in_threadgroup`, `quadgroups_per_threadgroup`, `thread_index_in_quadgroup`, `tile_index` |
| **2.2** (9) | `amplification_count`, `amplification_id`, `barycentric_coord`, `host_name`, `hostname`, `primitive_id`, `shared`, `stencil`, `thread_index_in_grid` |
| **2.3** (15) | `accept_intersection`, `continue_search`, `direction`, `distance`, `fragment`, `function_group`, `function_groups`, `intersection`, `kernel`, `max_distance`, `min_distance`, `origin`, `payload`, `vertex`, `visible` |
| **2.4** (4) | `centroid_no_perspective`, `centroid_perspective`, `sample_no_perspective`, `stitchable` |
| **3.0** (4) | `max_total_threadgroups_per_mesh_grid`, `mesh`, `object`, `primitive_culled` |
| **4.0** (1) | `user_annotation` |
| **4.1** (1) | `required_threads_per_threadgroup` |

## 章レベルの構造変遷 (4.1 ToC 基準の出現検出)

主要トピックの初出: `ray_data`=2.3, `object_data`=3.0, imageblock=2.1

---

## 各バージョンの新機能 (原文)

### Metal 1.2 (出典: Revision History)

```
Revision History 
Version Date Notes
1.2 2016-10-21 Updated for iOS 10, tvOS 10, and macOS 10.12
 
2016-10-21   |  Copyright © 2016 Apple Inc. All Rights Reserved.  
Page   of  121122

<<<PAGE 122>>>
 
Apple Inc. 
Copyright © 2016 Apple Inc. 
All rights reserved. 
No part of this publication may be 
reproduced, stored in a retrieval system, 
or transmitted, in any form or by any 
means, mechanical, electronic, 
photocopying, recording, or otherwise, 
without prior written permission of Apple 
Inc., with the following exceptions: Any 
person is hereby authorized to store 
documentation on a single computer or 
device for personal use only and to print 
copies of documentation for personal 
use provided that the documentation 
contains Apple’s copyright notice. 
No licenses, express or implied, are 
granted with respect to any of the 
technology described in this document. 
Apple retains all intellectual property 
rights associated with the technology 
described in this document. This 
document is intended to assist 
application developers to develop 
applications only for Apple-branded 
products. 
Apple Inc. 
1 Inﬁnite Loop 
Cupertino, CA 95014 
408-996-1010 
Apple is a trademark of Apple Inc., 
registered in the U.S. and other 
countries. 
APPLE MAKES NO WARRANTY OR 
REPRESENTATION, EITHER EXPRESS OR 
IMPLIED, WITH RESPECT TO THIS 
DOCUMENT, ITS QUALITY , ACCURACY , 
MERCHANTABILITY , OR FITNESS FOR A 
PARTICULAR PURPOSE. AS A RESULT, 
THIS DOCUMENT IS PROVIDED “AS IS,” 
AND YOU, THE READER, ARE ASSUMING 
THE ENTIRE RISK AS TO ITS QUALITY AND 
ACCURACY . 
IN NO EVENT WILL APPLE BE LIABLE FOR 
DIRECT, INDIRECT, SPECIAL, INCIDENTAL, 
OR CONSEQUENTIAL DAMAGES 
RESULTING FROM ANY DEFECT, ERROR 
OR INACCURACY IN THIS DOCUMENT, 
even if advised of the possibility of such 
damages. 
Some jurisdictions do not allow the 
exclusion of implied warranties or liability, 
so the above exclusion may not apply to 
you.
 
2016-10-21   |  Copyright © 2016 Apple Inc. All Rights Reserved.  
Page   of  122122
```

### Metal 2.0 (出典: Revision History)

```
Revision History 
Version Date Notes
2.0 2017-6-5 Updated for iOS 11, tvOS 11, and macOS 10.13
1.2 2016-10-21 Updated for iOS 10, tvOS 10, and macOS 10.12
 
2017-6-5   |  Copyright © 2017 Apple Inc. All Rights Reserved.  
Page   of  152 153

<<<PAGE 153>>>
  
Apple Inc. 
Copyright © 2017 Apple Inc. 
All rights reserved.  
No part of this publication may be 
reproduced, stored in a retrieval system, 
or transmitted, in any form or by any 
means, mechanical, electronic, 
photocopying, recording, or otherwise, 
without prior written permission of 
Apple Inc., with the following 
exceptions: Any person is hereby 
authorized to store documentation on a 
single computer or device for personal 
use only and to print copies of 
documentation for personal use 
provided that the documentation 
contains Apple’s copyright notice.  
No licenses, express or implied, are 
granted with respect to any of the 
technology described in this document. 
Apple retains all intellectual property 
rights associated with the technology 
described in this document. This 
document is intended to assist 
application developers to develop 
applications only for Apple-branded 
products.  
Apple Inc. 
1 Infinite Loop 
Cupertino, CA 95014 
408-996-1010  
Apple is a trademark of Apple Inc., 
registered in the U.S. and other 
countries.  
APPLE MAKES NO WARRANTY OR 
REPRESENTATION, EITHER EXPRESS OR 
IMPLIED, WITH RESPECT TO THIS 
DOCUMENT, ITS QUALITY , ACCURACY , 
MERCHANTABILITY , OR FITNESS FOR A 
PARTICULAR PURPOSE. AS A RESULT, 
THIS DOCUMENT IS PROVIDED “AS IS,” 
AND YOU, THE READER, ARE ASSUMING 
THE ENTIRE RISK AS TO ITS QUALITY AND 
ACCURACY.  
IN NO EVENT WILL APPLE BE LIABLE FOR 
DIRECT, INDIRECT, SPECIAL, INCIDENTAL, 
OR CONSEQUENTIAL DAMAGES 
RESULTING FROM ANY DEFECT, ERROR OR 
INACCURACY IN THIS DOCUMENT, even if 
advised of the possibility of such damages.  
Some jurisdictions do not allow the 
exclusion of implied warranties or liability, 
so the above exclusion may not apply to 
you.
 
2017-6-5   |  Copyright © 2017 Apple Inc. All Rights Reserved.  
Page   of  153 153
```

### Metal 2.1 (出典: (該当セクション無し: Apple は 3.2 から新機能節を新設))

```

```

### Metal 2.2 (出典: (該当セクション無し: Apple は 3.2 から新機能節を新設))

```

```

### Metal 2.3 (出典: (該当セクション無し: Apple は 3.2 から新機能節を新設))

```

```

### Metal 2.4 (出典: (該当セクション無し: Apple は 3.2 から新機能節を新設))

```

```

### Metal 3.0 (出典: (該当セクション無し: Apple は 3.2 から新機能節を新設))

```

```

### Metal 3.1 (出典: (該当セクション無し: Apple は 3.2 から新機能節を新設))

```

```

### Metal 3.2 (出典: New in Metal)

```
New in Metal 3.2 Metal 3.2 introduces the following new features: • Relaxed Math (section 1.6.3) • Intersection Result Reference (section 2.17.5) 

<<<PAGE 11>>>
 
2024-06-06 | Copyright © 2024 Apple Inc. | All Rights Reserved.  Page 11 of 298 
• Texture and Buffer Memory Coherency (section 2.9 and section 4.8) • Global Bindings (section 5.9) • Logging (section 6.19)  1.4 References C++14 Stroustrup, Bjarne. The C++ Programming Language (Fourth Edition). Harlow: Addison-Wesley, 2013. Metal Here is a link to the Metal documentation on apple.com: https://developer.apple.com/documentation/metal  1.5 Metal and C++14 The Metal programming language is a C++14-based Specification with extensions and restrictions. Refer to the C++14 Specification (also known as the ISO/IEC JTC1/SC22/WG21 N4431 Language Specification) for a detailed description of the language grammar.  This section and its subsections describe the modifications and restrictions to the C++14 language supported in Metal.  For more about Metal preprocessing directives and compiler options, see section 1.6 of this document.  1.5.1 Overloading Metal supports overloading, as defined by section 13 of the C++14 Specification. Metal extends the function overloading rules to include the address space attribute of an argument. You cannot overload Metal graphics and kernel functions. (For a definition of graphics and kernel functions, see section 5.1 of this document.)  1.5.2 Templates Metal supports templates, as defined by section 14 of the C++14 Specification.  1.5.3 Preprocessing Directives Metal supports the preprocessing directives, as defined by section 16 of the C++14 Specification.  

<<<PAGE 12>>>
 
2024-06-06 | Copyright © 2024 Apple Inc. | All Rights Reserved.  Page 12 of 298 
1.5.4 Restrictions The following C++14 features are not available in Metal (section numbers in this list refer to the C++14 Specification):  • lambda expressions (section 5.1.2) • dynamic_cast operator (section 5.2.7) • type identification (section 5.2.8) • new and delete operators (sections 5.3.4 and 5.3.5) • noexcept operator (section 5.3.7) • goto statement (section 6.6) • register, thread_local storage attributes (section 7.1.1) • virtual function attribute (section 7.1.2) • derived classes (section 10, section 11) • exception handling (section 15)  Do not use the C++ standard library in Metal code. Instead, Metal has its own standard library, as discussed in section 5 of this document.  Metal restricts the use of pointers: • You must declare arguments to Metal graphics and kernel functions that are pointers with the Metal device, constant, threadgroup, or threadgroup_imageblock address space attribute. (For more about Metal address space attributes, see section 4 of this document.) • Metal 2.3 and later support function pointers.   Metal supports recursive function calls (C++ section 5.2.2, item 9) in compute (kernel) context starting with Metal 2.4. You can’t call a Metal function main.  1.6 Compiler and Prep
```

### Metal 4.0 (出典: New in Metal)

```
New in Metal 3.2 .................................................................................................................... 321  Tables and Figures  Table 1.1. Rounding mode .................................................................................................................... 17 Figure 1. Normalized device coordinate system ............................................................................... 22 Figure 2. Viewport coordinate system ............................................................................................... 22 Figure 3. Normalized 2D texture coordinate system ....................................................................... 23 Table 2.1. Metal scalar data types ..................................................................................................... 24 Table 2.2. Size and alignment of scalar data types ......................................................................... 25 Table 2.3. Size and alignment of vector data types ......................................................................... 27 Table 2.4. Size and alignment of packed vector data types ........................................................... 33 Table 2.5. Size and alignment of matrix data types ......................................................................... 35 Table 2.6. Metal pixel data types ....................................................................................................... 39 Table 2.7. Sampler state enumeration values .................................................................................. 45 Table 2.8. Imageblock slices and compatible target texture formats ........................................... 47 Table 2.9. Intersection tags ................................................................................................................ 60 Table 2.10. Mesh template parameter ............................................................................................... 72 Table 2.11. Mesh vertex attributes ...................................................................................................... 73 Table 2.12. Mesh primitive attributes ................................................................................................. 73 Table 2.13. Mesh static members ....................................................................................................... 75 Table 2.14 Extents template parameters .......................................................................................... 76 Table 2.15 Tensor template parameters ............................................................................................ 77 Table 2.16 Tensor type definition ....................................................................................................... 78 Table 2.17 Cooperative tensor template parameters ....................................................................... 81 Table 2.18 Cooperative Tensor type definitio
```

### Metal 4.1 (出典: New in Metal)

```
New in Metal 4.1 Metal 4.1 introduces the following new features: • Support for placement new (see sections 1.5.4 and 6.2) • An option to set default rounding mode for float-to-float conversions to round toward zero (section 1.6.3) • Adds function_id to intersection result type (sections 2.17.4 and 2.17.5) • Support for packed numeric types for block-scaling formats (section 2.21) • Support for multiplane tensors and tensor_blockwise with block-scaling data formats (section 2.22) • Support for deinterleave and interleave (section 6.4) • Support for memory order (including acquire and release) to barriers and atomics (sections 6.10, 6.16.1.2, and 6.16.4) • Support for clamp-to-edge texture reads, integer-coordinate texture reads with offsets, and multi-pixel texture reads (section 6.13) • Updates the supported data types for Metal Performance Primitives matrix multiply (section 17.2.1)  1.4 References Metal Here is a link to the Metal documentation on apple.com: https://developer.apple.com/documentation/metal  1.5 Metal and C++17 In Metal 4 and later, the Metal programming language is a C++17-based specification with extensions and restrictions. Refer to the C++17 specification (also known as ISO/IEC 14882:2017) for a detailed description of the language grammar.  Prior language versions of Metal are a C++14-based specification with extensions and restrictions.  This section and its subsections describe the modifications and restrictions to the C++17 and C++14 language supported in Metal.  For more about Metal preprocessing directives and compiler options, see section 1.6 of this document.  1.5.1 Overloading Metal supports overloading, as defined by section 13 of the C++17 and C++14 specification. Metal extends the function overloading rules to include the address space attribute of an 

<<<PAGE 13>>>
  
2026-06-04 | Copyright © 2026 Apple Inc. | All Rights Reserved.  Page 13 of 383 
argument. You cannot overload Metal graphics and kernel functions. (For a definition of graphics and kernel functions, see section 5.1 of this document.)  1.5.2 Templates Metal supports templates, as defined by section 14 of the C++17 and C++14 specification.  1.5.3 Preprocessing Directives Metal supports the preprocessing directives, as defined by section 16 of the C++17 and C++14 Specification.  1.5.4 Restrictions All OS: Metal 3.2 and later support lambda expressions. All OS: Metal 4.1 and later support placement new.    The following C++17 features are not available in Metal (section numbers in this list refer to the C++17 Specification):  • lambda expressions (section 5.1.2) prior to Metal 3.2 • dynamic_cast operator (section 5.2.7) • type identification (section 5.2.8) • new and delete operators (sections 5.3.4 and 5.3.5). Metal 4.1 and later supports placement new. • noexcept operator (section 5.3.7) • goto statement (section 6.6) • register, thread_local storage attributes (section 7.1.1) • virtual function attribute (section 7.1.2) • derived classes (section
```
