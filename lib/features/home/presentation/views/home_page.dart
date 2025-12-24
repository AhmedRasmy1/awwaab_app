import 'package:awwaab_app/core/res/app_constants.dart';
import 'package:awwaab_app/core/res/routes_manager.dart';
import 'package:awwaab_app/features/home/presentation/widgets/allah_name_card.dart';
import 'package:awwaab_app/features/home/presentation/widgets/ayah_of_day_card.dart';
import 'package:awwaab_app/features/home/presentation/widgets/feeling_card.dart';
import 'package:awwaab_app/features/home/presentation/widgets/next_prayer_card.dart';
import 'package:awwaab_app/features/home/presentation/widgets/zekr_of_time_card.dart';
import 'package:awwaab_app/features/home/presentation/widgets/hijri_date_section.dart'; // Import الجديد
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // استدعينا الودجت الجديد هنا بكل بساطة
            const HijriDateSection(),

            const SizedBox(height: 20),
            const AyahOfTheDayCard(),
            const FeelingsSection(),
            const NextPrayerCard(),
            const ZekrOfTimeCard(),
            const AllahNameCard(),
          ],
        ),
      ),
    );
  }
}
