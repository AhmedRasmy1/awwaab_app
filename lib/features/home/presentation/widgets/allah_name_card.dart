import 'package:flutter/material.dart';

class AllahNameCard extends StatelessWidget {
  const AllahNameCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // الألوان
    final cardColor = isDark
        ? Theme.of(context).cardTheme.color!
        : const Color(0xFFF9F5EB); // بيج فاتح مميز
    final borderColor = isDark ? Colors.white12 : const Color(0xFFE3DCC8);
    final nameColor = const Color(0xFFC8B88A); // ذهبي ثابت للاسم
    final textColor = isDark ? Colors.grey.shade300 : const Color(0xFF1F3C2E);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Stack(
        children: [
          // زخرفة خفيفة في الخلفية (اختياري لو عندك الصورة)
          /*
          Positioned(
            left: -20,
            bottom: -20,
            child: Opacity(
              opacity: 0.05,
              child: Icon(Icons.star, size: 150, color: nameColor), // مثال مكان الصورة
            ),
          ),
          */
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // الاسم بتصميم مميز
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white10 : Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: nameColor.withOpacity(0.3)),
                  ),
                  child: Center(
                    child: Text(
                      "الرَّحِيمُ",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: nameColor, // ذهبي
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 20),

                // المعنى
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "اسم من أسماء الله الحسنى",
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark
                              ? Colors.grey.shade500
                              : Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "هو الذي تتعدد رحمته وتكثر، وتشمل جميع خلقه في الدنيا، والمؤمنين خاصة في الآخرة.",
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
