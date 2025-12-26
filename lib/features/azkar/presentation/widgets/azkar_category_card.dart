import 'package:awwaab_app/features/azkar/data/azkar_model.dart';
import 'package:awwaab_app/features/azkar/presentation/views/azkar_details_page.dart';
import 'package:flutter/material.dart';

class AzkarCategoryCard extends StatelessWidget {
  final AzkarCategoryModel category;

  const AzkarCategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = const Color(0xFF1B4332);
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 600;

    IconData iconData = Icons.spa;
    String catName = category.category;

    if (catName.contains("الصباح")) {
      iconData = Icons.wb_sunny_outlined;
    } else if (catName.contains("المساء")) {
      iconData = Icons.nightlight_round;
    } else if (catName.contains("النوم")) {
      iconData = Icons.bed;
    } else if (catName.contains("الاستيقاظ")) {
      iconData = Icons.alarm;
    } else if (catName.contains("الصلاة") || catName.contains("الآذان")) {
      iconData = Icons.mosque;
    } else if (catName.contains("الوضوء")) {
      iconData = Icons.water_drop;
    } else if (catName.contains("المنزل")) {
      iconData = Icons.home;
    } else if (catName.contains("الطعام")) {
      iconData = Icons.restaurant;
    } else if (catName.contains("السفر")) {
      iconData = Icons.flight;
    } else if (catName.contains("الخلاء")) {
      iconData = Icons.wc;
    } else if (catName.contains("الهم") || catName.contains("الدين")) {
      iconData = Icons.favorite;
    } else if (catName.contains("المرض")) {
      iconData = Icons.local_hospital;
    } else if (catName.contains("الاستخارة")) {
      iconData = Icons.done_all;
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
              color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
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
            Positioned(
              left: -20,
              bottom: -20,
              child: Opacity(
                opacity: isDark ? 0.05 : 0.1,
                child: Icon(
                  iconData,
                  size: isMobile ? 80 : 100,
                  color: isDark ? Colors.white : primaryColor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(isMobile ? 12 : 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(isMobile ? 8 : 10),
                    decoration: BoxDecoration(
                      color: primaryColor.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      iconData,
                      color: primaryColor,
                      size: isMobile ? 20 : 24,
                    ),
                  ),
                  Text(
                    category.category,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      fontSize: isMobile ? 14 : 16,
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
