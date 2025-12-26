import 'package:awwaab_app/features/azkar/data/azkar_model.dart';
import 'package:awwaab_app/features/azkar/presentation/views/azkar_details_page.dart';
import 'package:flutter/material.dart';

class AzkarCategoryCard extends StatelessWidget {
  final AzkarCategoryModel category;

  const AzkarCategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = const Color(0xFF1B4332); // اللون الأساسي

    // تحديد الأيقونة حسب القسم
    IconData iconData = Icons.spa;
    if (category.category.contains("الصباح")) {
      iconData = Icons.wb_sunny_outlined;
    } else if (category.category.contains("المساء")) {
      iconData = Icons.nightlight_round;
    } else if (category.category.contains("الصلاة")) {
      iconData = Icons.mosque;
    } else if (category.category.contains("النوم")) {
      iconData = Icons.bed;
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AzkarDetailsPage(category: category),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: isDark ? Colors.white10 : const Color(0xFFF0F0F0),
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            // ==========================================
            // التعديل هنا: ضبط ألوان الزغرفة الخلفية
            // ==========================================
            Positioned(
              left: -20,
              bottom: -20,
              child: Opacity(
                // زودت الشفافية سنة بسيطة في اللايت عشان تبان أحلى
                opacity: isDark ? 0.05 : 0.1,
                child: Icon(
                  iconData,
                  size: 100,
                  // 👈 التركة هنا: لو دارك خليها أبيض، لو لايت خليها أخضر
                  color: isDark ? Colors.white : primaryColor,
                ),
              ),
            ),

            // المحتوى
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      iconData,
                      color:
                          primaryColor, // الأيقونة الصغيرة تفضل خضراء دايماً عشان التناسق
                      size: 24,
                    ),
                  ),
                  Text(
                    category.category,
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
