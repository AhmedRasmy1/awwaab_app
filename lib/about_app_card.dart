import 'package:awwaab_app/core/res/app_constants.dart';
import 'package:flutter/material.dart';

class AboutAppCard extends StatelessWidget {
  const AboutAppCard({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.9, // 90% of screen width
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: Color(0xFFE8ECE9),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                AppConstants.appNameArabic,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1F3C2E),
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
              color: Colors.grey.shade700,
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

    return Container(
      width: screenWidth * 0.9, // 90% of screen width
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F5EB),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE3DCC8), width: 1.5),
      ),
      child: const Center(
        child: Text(
          '"وَمَنْ أَحْسَنُ قَوْلًا مِّمَّن دَعَا إِلَى اللَّهِ وَعَمِلَ صَالِحًا"',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF8D7B68),
          ),
        ),
      ),
    );
  }
}
