import 'package:flutter/material.dart';

class PrayerReminderCard extends StatelessWidget {
  const PrayerReminderCard({super.key});

  @override
  Widget build(BuildContext context) {
    // سحب الألوان من الثيم الحالي (سواء فاتح أو غامق)
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        // لون الخلفية: في الغامق بياخد لون الكارت الطبيعي، في الفاتح ممكن نديله لمسة خفيفة
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          // البوردر بياخد لون التطبيق الأساسي بس شفاف جداً عشان الشياكة
          color: colorScheme.primary.withOpacity(0.3),
          width: 1.5,
        ),
        // ضل خفيف يظهر بس في الوضع الفاتح عشان يبرز الكارت
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // أيقونة صغيرة جنب العنوان تدي منظر
              Icon(
                Icons.volunteer_activism,
                size: 18,
                color: colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                "تذكير لطيف",
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  // لون العنوان هو لون التطبيق الأساسي
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "الصلاة في وقتها من أعظم الأعمال عند الله. احرص على أدائها في أول وقتها.",
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14,
              // لون النص بيتغير لوحده (أبيض في الغامق / أسود في الفاتح)
              color: theme.textTheme.bodyMedium?.color?.withOpacity(0.8),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
