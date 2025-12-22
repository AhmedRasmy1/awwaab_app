import 'package:awwaab_app/core/res/app_constants.dart';
import 'package:awwaab_app/core/res/color_manager.dart';
import 'package:awwaab_app/core/res/values_manager.dart';
import 'package:awwaab_app/settings_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:solar_icons/solar_icons.dart';

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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p20,
          vertical: AppPadding.p0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Divider(color: ColorManager.divider),
            // SizedBox(height: AppSize.s10),
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
            // Text(
            //   AppConstants.appearanceArabic,
            //   style: TextStyle(
            //     fontSize: AppSize.s20,
            //     fontFamily: AppConstants.fontFamily,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
