import 'package:flutter/material.dart';

class CurrentPrayerCard extends StatelessWidget {
  // 1. المتغيرات اللي هتستقبل البيانات
  final String currentName;
  final String currentTime;
  final String nextName;
  final String nextTime;

  const CurrentPrayerCard({
    super.key,
    required this.currentName,
    required this.currentTime,
    required this.nextName,
    required this.nextTime,
  });

  @override
  Widget build(BuildContext context) {
    // اللون الأخضر الداكن من الصورة
    final cardColor = const Color(0xFF1B4332);
    final textColor = Colors.white;
    final secondaryTextColor = Colors.white70;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ===========================
          // القسم العلوي: الصلاة الحالية
          // ===========================
          Text(
            "الصلاة الحالية",
            style: TextStyle(
              color: secondaryTextColor,
              fontSize: 16,
              fontFamily: 'Cairo',
            ),
          ),
          const SizedBox(height: 10),

          // اسم الصلاة الحالية (متغير)
          Text(
            currentName,
            style: TextStyle(
              color: textColor,
              fontSize: 45,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
              height: 1.0,
            ),
          ),

          // وقت الصلاة الحالية (متغير)
          Text(
            currentTime,
            style: TextStyle(
              color: textColor,
              fontSize: 30,
              fontFamily: 'Cairo',
            ),
          ),

          const SizedBox(height: 20),

          // ===========================
          // الفاصل (Divider)
          // ===========================
          const Divider(color: Colors.white24, thickness: 1),

          const SizedBox(height: 15),

          // ===========================
          // القسم السفلي: الصلاة القادمة
          // ===========================
          Text(
            "الصلاة القادمة",
            style: TextStyle(
              color: secondaryTextColor,
              fontSize: 14,
              fontFamily: 'Cairo',
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // اسم الصلاة القادمة (متغير)
              Text(
                nextName,
                style: TextStyle(
                  color: textColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
              const SizedBox(width: 10),

              // وقت الصلاة القادمة (متغير)
              Text(
                nextTime,
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
