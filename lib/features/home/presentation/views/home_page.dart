import 'package:awwaab_app/core/res/app_constants.dart';
import 'package:awwaab_app/core/res/routes_manager.dart';
import 'package:awwaab_app/features/home/presentation/widgets/ayah_of_day_card.dart';
import 'package:awwaab_app/features/home/presentation/widgets/next_prayer_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final String hijriDate = "١٤ رجب ١٤٤٦ هـ";

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
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  hijriDate,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const AyahOfTheDayCard(),
            const NextPrayerCard(),
          ],
        ),
      ),
    );
  }
}
