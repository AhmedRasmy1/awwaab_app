import 'package:awwaab_app/features/settings/viewmodels/theme/theme_cubit_cubit.dart';
import 'package:awwaab_app/features/settings/widgets/about_app_card.dart';
import 'package:awwaab_app/core/res/app_constants.dart';
import 'package:awwaab_app/core/res/color_manager.dart';
import 'package:awwaab_app/core/res/values_manager.dart';
import 'package:awwaab_app/features/settings/widgets/font_size_setting_card.dart';
import 'package:awwaab_app/features/settings/widgets/settings_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final textColor =
        Theme.of(context).textTheme.titleLarge?.color ??
        ColorManager.textPrimary;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppConstants.settingsArabic,
          style: TextStyle(
            color: textColor,
            fontFamily: AppConstants.fontFamily,
            fontWeight: FontWeight.bold,
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
                  color: textColor,
                ),
              ),
              const SizedBox(height: AppSize.s10),

              BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, state) {
                  final isDark =
                      context.read<ThemeCubit>().state.themeMode ==
                      ThemeMode.dark;

                  return SettingsItem(
                    icon: isDark
                        ? Icons.nightlight_round
                        : Icons.light_mode_outlined,

                    title: AppConstants.darkModeArabic,

                    subtitle: isDark
                        ? AppConstants.enabledArabic
                        : AppConstants.disabledArabic,

                    trailing: Switch(
                      value: isDark,
                      activeColor: ColorManager.primary,
                      onChanged: (bool value) {
                        context.read<ThemeCubit>().changeTheme(isDark: value);
                      },
                    ),
                  );
                },
              ),

              // ===============================================
              const SizedBox(height: AppSize.s14),

              Text(
                AppConstants.readingArabic,
                style: TextStyle(
                  fontSize: AppSize.s20,
                  fontFamily: AppConstants.fontFamily,
                  color: textColor,
                ),
              ),

              FontSizeSettingsCard(
                initialFontSize: 18.0,
                onFontSizeChanged: (newSize) {
                  // Handle font size change
                },
              ),

              const SizedBox(height: AppSize.s14),

              Text(
                AppConstants.notificationsArabic,
                style: TextStyle(
                  fontSize: AppSize.s20,
                  fontFamily: AppConstants.fontFamily,
                  color: textColor,
                ),
              ),

              const SizedBox(height: AppSize.s10),

              SettingsItem(
                icon: Icons.notifications_none_rounded,
                title: AppConstants.notificationsArabic,
                subtitle: AppConstants.disabledArabic,
                trailing: Switch(
                  value: true,
                  activeColor: ColorManager.primary,
                  onChanged: (bool value) {
                    // Handle notifications toggle
                  },
                ),
              ),

              const SizedBox(height: AppSize.s14),

              Text(
                AppConstants.aboutAppArabic,
                style: TextStyle(
                  fontSize: AppSize.s20,
                  fontFamily: AppConstants.fontFamily,
                  color: textColor,
                ),
              ),

              const SizedBox(height: AppSize.s10),

              const AboutAppCard(),

              const SizedBox(height: AppSize.s14),

              QuoteCard(), // تأكد إن QuoteCard موجودة أو اعملها import
            ],
          ),
        ),
      ),
    );
  }
}
