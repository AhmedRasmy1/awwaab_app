import 'package:awwaab_app/features/settings/widgets/about_app_card.dart';
import 'package:awwaab_app/core/res/app_constants.dart';
import 'package:awwaab_app/core/res/color_manager.dart';
import 'package:awwaab_app/core/res/values_manager.dart';
import 'package:awwaab_app/features/settings/widgets/font_size_setting_card.dart';
import 'package:awwaab_app/features/settings/widgets/settings_item.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          AppConstants.settingsArabic,
          style: TextStyle(
            color: ColorManager.textPrimary,
            fontFamily: AppConstants.fontFamily,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p20,
            vertical: AppPadding.p0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppConstants.appearanceArabic,
                style: TextStyle(
                  fontSize: AppSize.s20,
                  fontFamily: AppConstants.fontFamily,
                ),
              ),
              SizedBox(height: AppSize.s10),
              SettingsItem(
                icon: Icons.light_mode_outlined,
                title: AppConstants.darkModeArabic,
                subtitle: AppConstants.disabledArabic,
                trailing: Switch(
                  value: true,
                  onChanged: (bool value) {
                    // Handle dark mode toggle
                  },
                ),
              ),
              SizedBox(height: AppSize.s14),
              Text(
                AppConstants.readingArabic,
                style: TextStyle(
                  fontSize: AppSize.s20,
                  fontFamily: AppConstants.fontFamily,
                ),
              ),
              FontSizeSettingsCard(
                initialFontSize: 18.0,
                onFontSizeChanged: (newSize) {
                  // Handle font size change
                },
              ),
              SizedBox(height: AppSize.s14),
              Text(
                AppConstants.notificationsArabic,
                style: TextStyle(
                  fontSize: AppSize.s20,
                  fontFamily: AppConstants.fontFamily,
                ),
              ),
              SizedBox(height: AppSize.s10),
              SettingsItem(
                icon: Icons.notifications_none_rounded,
                title: AppConstants.notificationsArabic,
                subtitle: AppConstants.disabledArabic,
                trailing: Switch(
                  value: true,
                  onChanged: (bool value) {
                    // Handle notifications toggle
                  },
                ),
              ),
              SizedBox(height: AppSize.s14),
              Text(
                AppConstants.aboutAppArabic,
                style: TextStyle(
                  fontSize: AppSize.s20,
                  fontFamily: AppConstants.fontFamily,
                ),
              ),
              SizedBox(height: AppSize.s10),
              const AboutAppCard(),
              SizedBox(height: AppSize.s14),
              QuoteCard(),
            ],
          ),
        ),
      ),
    );
  }
}
