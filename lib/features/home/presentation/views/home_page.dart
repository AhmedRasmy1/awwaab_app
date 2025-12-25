import 'package:awwaab_app/core/res/app_constants.dart';
import 'package:awwaab_app/core/res/routes_manager.dart';
import 'package:awwaab_app/features/home/presentation/widgets/allah_name_card.dart';
import 'package:awwaab_app/features/home/presentation/widgets/ayah_of_day_card.dart';
import 'package:awwaab_app/features/home/presentation/widgets/feeling_card.dart';
import 'package:awwaab_app/features/home/presentation/widgets/next_prayer_card.dart';
import 'package:awwaab_app/features/home/presentation/widgets/zekr_of_time_card.dart';
import 'package:awwaab_app/features/home/presentation/widgets/hijri_date_section.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppConstants.appNameArabic,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, size: 24),
            onPressed: () {
              Navigator.pushNamed(context, RoutesManager.settingsRoute);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: isSmallScreen ? 12 : 20,
          right: isSmallScreen ? 12 : 20,
          bottom: screenHeight * 0.15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const HijriDateSection(),
            SizedBox(height: screenHeight * 0.01),
            const AyahOfTheDayCard(),
            SizedBox(height: screenHeight * 0.01),
            const FeelingsSection(),
            SizedBox(height: screenHeight * 0.01),
            const NextPrayerCard(),
            SizedBox(height: screenHeight * 0.01),
            const ZekrOfTimeCard(),
            SizedBox(height: screenHeight * 0.01),
            const AllahNameCard(),
          ],
        ),
      ),
    );
  }
}
