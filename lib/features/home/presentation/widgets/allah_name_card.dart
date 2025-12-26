import 'package:awwaab_app/core/res/allah_names_data.dart';
import 'package:flutter/material.dart';

class AllahNameCard extends StatelessWidget {
  const AllahNameCard({super.key});

  @override
  Widget build(BuildContext context) {
    // =========================================================
    // منطق اختيار الاسم اليومي
    // =========================================================
    final now = DateTime.now();
    final difference = now.difference(DateTime(2020, 1, 1)).inDays;
    final int index = difference % AllahNamesData.names.length;
    final AllahNameModel todaysName = AllahNamesData.names[index];
    // =========================================================

    final isDark = Theme.of(context).brightness == Brightness.dark;

    // الألوان
    final cardColor = isDark
        ? Theme.of(context).cardTheme.color!
        : const Color(0xFFF9F5EB);
    final borderColor = isDark ? Colors.white12 : const Color(0xFFE3DCC8);
    final nameColor = const Color(0xFFC8B88A); // ذهبي
    final textColor = isDark ? Colors.grey.shade300 : const Color(0xFF1F3C2E);

    // لون الباترن: بياخد نفس لون الاسم (ذهبي) بس شفاف جداً
    final patternColor = nameColor.withOpacity(isDark ? 0.05 : 0.08);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10),
      clipBehavior: Clip.hardEdge, // عشان الصورة لو كبيرة تتقص على قد الكارت
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          // ========================================================
          // 🖼️ صورة الباترن الإسلامي (Background)
          // ========================================================
          Positioned.fill(
            child: Opacity(
              opacity: 1.0, // التحكم في الشفافية بيتم عن طريق الـ color تحت
              child: Image.asset(
                'assets/images/islamic_pattern.png', // ⚠️ تأكد إن الاسم والمسار صح
                fit: BoxFit.cover, // تملا الكارت كله
                // التركة هنا: بنلون الصورة بلون ذهبي شفاف عشان تليق مع الثيم
                color: patternColor,
                colorBlendMode: BlendMode.srcIn, // بيصبغ الصورة باللون اللي فوق
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // الاسم
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white10
                        : Colors.white.withOpacity(
                            0.9,
                          ), // زودنا الـ opacity عشان الكلام يبان فوق الباترن
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: nameColor.withOpacity(0.5),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: nameColor.withOpacity(0.15),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      todaysName.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: nameColor,
                        fontFamily: 'Cairo',
                        shadows: [
                          Shadow(
                            blurRadius: 1,
                            color: nameColor.withOpacity(0.3),
                            offset: const Offset(0, 1),
                          ),
                        ],
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
                      Row(
                        children: [
                          Icon(
                            Icons.format_quote_rounded,
                            size: 16,
                            color: nameColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "من أسماء الله الحسنى",
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w600,
                              color: nameColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        todaysName.meaning,
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.6,
                          fontFamily: 'Cairo',
                          color: textColor,
                          fontWeight: FontWeight.w500,
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
