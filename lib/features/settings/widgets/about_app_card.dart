import 'package:awwaab_app/core/res/app_constants.dart';
import 'package:flutter/material.dart';

class AboutAppCard extends StatelessWidget {
  const AboutAppCard({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // 1. متغيرات الثيم
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark
        ? Theme.of(context).cardTheme.color!
        : Colors.white;
    final borderColor = isDark ? Colors.white12 : Colors.grey.shade300;

    final circleColor = isDark ? Colors.white10 : const Color(0xFFE8ECE9);
    final titleColor = isDark ? Colors.white : const Color(0xFF1F3C2E);
    final textColor = isDark ? Colors.grey.shade300 : Colors.grey.shade700;

    return Container(
      width: screenWidth * 0.9,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: cardColor, // متغير
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: 1), // متغير
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: circleColor, // متغير
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                AppConstants.appNameArabic,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: titleColor, // متغير
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          Text(
            'الإصدار 1.0.0',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),

          const SizedBox(height: 16),

          Text(
            'تطبيق إسلامي عصري يهدف إلى مساعدتك على\nأداء العبادات بسكينة وطمأنينة',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: textColor, // متغير
            ),
          ),
        ],
      ),
    );
  }
}

class QuoteCard extends StatelessWidget {
  const QuoteCard({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // في الوضع الليلي، مش هينفع الخلفية البيج الفاتحة، هنخليها غامقة بس بإطار ذهبي
    final bgColor = isDark ? const Color(0xFF242826) : const Color(0xFFF9F5EB);
    final borderColor = isDark
        ? const Color(0xFFC8B88A).withOpacity(0.3)
        : const Color(0xFFE3DCC8);
    final textColor = const Color(0xFFC8B88A); // الذهبي يمشي في الاتنين

    return Container(
      width: screenWidth * 0.9,
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: bgColor, // متغير
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: 1.5), // متغير
      ),
      child: Center(
        child: Text(
          '"وَمَنْ أَحْسَنُ قَوْلًا مِّمَّن دَعَا إِلَى اللَّهِ وَعَمِلَ صَالِحًا"',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor, // الذهبي
          ),
        ),
      ),
    );
  }
}
