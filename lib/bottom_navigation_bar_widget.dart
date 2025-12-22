import 'package:awwaab_app/core/res/app_constants.dart';
import 'package:awwaab_app/core/res/color_manager.dart';
import 'package:awwaab_app/core/res/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:solar_icons/solar_icons.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;
    final isMediumScreen = screenSize.width < 600;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.95, end: 1.0).animate(animation),
              child: child,
            ),
          );
        },
        child: screens[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.fromLTRB(
          isSmallScreen ? AppMargin.m10 : AppMargin.m20,
          AppMargin.m0,
          isSmallScreen ? AppMargin.m10 : AppMargin.m20,
          isSmallScreen ? AppMargin.m12 : AppMargin.m20,
        ),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(AppSize.s30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              spreadRadius: 5,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: NavigationBarTheme(
            data: NavigationBarThemeData(
              indicatorColor: Colors.transparent,
              labelTextStyle: WidgetStateProperty.all(
                const TextStyle(fontSize: 0),
              ),
            ),
            child: NavigationBar(
              height: isSmallScreen ? 70 : AppSize.s85,
              backgroundColor: Colors.white,
              elevation: AppSize.s0,
              selectedIndex: _selectedIndex,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              animationDuration: const Duration(milliseconds: 500),
              onDestinationSelected: (index) =>
                  setState(() => _selectedIndex = index),
              destinations: [
                _buildCustomDestination(
                  icon: SolarIconsOutline.homeSmile,
                  selectedIcon: SolarIconsBold.homeSmile,
                  label: AppConstants.homeArabic,
                  isSelected: _selectedIndex == 0,
                  activeColor: ColorManager.activeIconColor,
                  bgColor: ColorManager.activeBackgroundColor,
                  inactiveColor: ColorManager.inactiveIconColor,
                  isSmallScreen: isSmallScreen,
                ),
                _buildCustomDestination(
                  icon: FlutterIslamicIcons.quran2,
                  selectedIcon: FlutterIslamicIcons.solidQuran2,
                  label: AppConstants.quranArabic,
                  isSelected: _selectedIndex == 1,
                  activeColor: ColorManager.activeIconColor,
                  bgColor: ColorManager.activeBackgroundColor,
                  inactiveColor: ColorManager.inactiveIconColor,
                  isSmallScreen: isSmallScreen,
                ),
                _buildCustomDestination(
                  icon: FlutterIslamicIcons.tasbih2,
                  selectedIcon: FlutterIslamicIcons.solidTasbih2,
                  label: AppConstants.azkarArabic,
                  isSelected: _selectedIndex == 2,
                  activeColor: ColorManager.activeIconColor,
                  bgColor: ColorManager.activeBackgroundColor,
                  inactiveColor: ColorManager.inactiveIconColor,
                  isSmallScreen: isSmallScreen,
                ),
                _buildCustomDestination(
                  icon: FlutterIslamicIcons.sajadah,
                  selectedIcon: FlutterIslamicIcons.solidSajadah,
                  label: AppConstants.prayerArabic,
                  isSelected: _selectedIndex == 3,
                  activeColor: ColorManager.activeIconColor,
                  bgColor: ColorManager.activeBackgroundColor,
                  inactiveColor: ColorManager.inactiveIconColor,
                  isSmallScreen: isSmallScreen,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  NavigationDestination _buildCustomDestination({
    required IconData icon,
    required IconData selectedIcon,
    required String label,
    required bool isSelected,
    required Color activeColor,
    required Color bgColor,
    required Color inactiveColor,
    required bool isSmallScreen,
  }) {
    final iconSize = isSmallScreen ? 24.0 : 26.0;
    final selectedWidth = isSmallScreen ? 70.0 : 85.0;

    return NavigationDestination(
      icon: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: inactiveColor, size: iconSize),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: inactiveColor,
              fontWeight: FontWeight.w500,
              fontSize: isSmallScreen ? 10 : 12,
            ),
          ),
        ],
      ),
      selectedIcon: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutBack,
        width: selectedWidth,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutBack,
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(selectedIcon, color: activeColor, size: iconSize + 2),
                  const SizedBox(height: 4),
                  Text(
                    label,
                    style: TextStyle(
                      color: activeColor,
                      fontWeight: FontWeight.bold,
                      fontSize: isSmallScreen ? 10 : 12,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      label: label,
    );
  }
}
