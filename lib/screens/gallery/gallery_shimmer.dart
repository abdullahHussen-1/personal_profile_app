import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/themes/app_media_query.dart';

class GalleryShimmer extends StatelessWidget {
  const GalleryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Shimmer.fromColors(
      // استخدام درجات الرمادي المناسبة لكل وضع
      baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
      child: GridView.builder(
        // نفس الـ Padding والـ GridDelegate بتاع الـ UI الأصلي
        padding: EdgeInsets.all(AppMediaQuery.sizeWidth(context) * 0.04),
        itemCount: 6, // عرض 6 كروت وهمية أثناء التحميل
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white, // اللون هنا شكلي فقط لأن الشيمر بيغطيه
              borderRadius: BorderRadius.circular(20),
            ),
          );
        },
      ),
    );
  }
}
