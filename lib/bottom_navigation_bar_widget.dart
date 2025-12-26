import 'package:awwaab_app/core/res/app_constants.dart';
import 'package:awwaab_app/core/res/color_manager.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // ألوان البار
    final navBarColor = isDark ? const Color(0xFF242826) : Colors.white;
    final shadowColor = isDark
        ? Colors.black.withOpacity(0.3)
        : Colors.black.withOpacity(0.1);

    final selectedIconColor = isDark
        ? const Color(0xFFB8E4D6)
        : const Color(0xFF1F3C2E);

    final selectedBgColor = isDark
        ? const Color(0xFF3E413E)
        : const Color(0xFFE8ECE9);

    final unselectedIconColor = isDark
        ? Colors.grey.shade500
        : ColorManager.inactiveIconColor;

    return Scaffold(
      // 👇 1. خليناها false عشان المحتوى يخلص عند حرف البار من فوق
      extendBody: false,

      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: screens[_selectedIndex],
      ),

      bottomNavigationBar: Container(
        // 👇 2. شيلنا الـ margin عشان يلزق في الحواف
        decoration: BoxDecoration(
          color: navBarColor, // لون الخلفية عشان يغطي اللي وراه
          // 👇 3. الكيرف من فوق بس (يمين وشمال)
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              blurRadius: 20,
              spreadRadius: 0,
              offset: const Offset(0, -5), // الضل طالع لفوق
            ),
          ],
        ),
        // لازم ClipRRect عشان يقص الزوايا بتاعة NavigationBar
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: NavigationBarTheme(
            data: NavigationBarThemeData(
              indicatorColor: Colors.transparent,
              labelTextStyle: WidgetStateProperty.all(
                const TextStyle(fontSize: 0),
              ),
              overlayColor: WidgetStateProperty.resolveWith(
                (states) => Colors.transparent,
              ),
            ),
            child: NavigationBar(
              height: isSmallScreen ? 70 : 80, // ارتفاع مناسب
              backgroundColor:
                  Colors.transparent, // شفاف عشان ياخد لون الكونتينر
              elevation: 0,
              selectedIndex: _selectedIndex,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              animationDuration: const Duration(milliseconds: 400),
              onDestinationSelected: (index) =>
                  setState(() => _selectedIndex = index),
              destinations: [
                _buildCustomDestination(
                  icon: SolarIconsOutline.homeSmile,
                  selectedIcon: SolarIconsBold.homeSmile,
                  label: AppConstants.homeArabic,
                  isSelected: _selectedIndex == 0,
                  activeColor: selectedIconColor,
                  bgColor: selectedBgColor,
                  inactiveColor: unselectedIconColor,
                  isSmallScreen: isSmallScreen,
                ),
                _buildCustomDestination(
                  icon: FlutterIslamicIcons.quran2,
                  selectedIcon: FlutterIslamicIcons.solidQuran2,
                  label: AppConstants.quranArabic,
                  isSelected: _selectedIndex == 1,
                  activeColor: selectedIconColor,
                  bgColor: selectedBgColor,
                  inactiveColor: unselectedIconColor,
                  isSmallScreen: isSmallScreen,
                ),
                _buildCustomDestination(
                  icon: FlutterIslamicIcons.tasbih2,
                  selectedIcon: FlutterIslamicIcons.solidTasbih2,
                  label: AppConstants.azkarArabic,
                  isSelected: _selectedIndex == 2,
                  activeColor: selectedIconColor,
                  bgColor: selectedBgColor,
                  inactiveColor: unselectedIconColor,
                  isSmallScreen: isSmallScreen,
                ),
                _buildCustomDestination(
                  icon: FlutterIslamicIcons.sajadah,
                  selectedIcon: FlutterIslamicIcons.solidSajadah,
                  label: AppConstants.prayerArabic,
                  isSelected: _selectedIndex == 3,
                  activeColor: selectedIconColor,
                  bgColor: selectedBgColor,
                  inactiveColor: unselectedIconColor,
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
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: selectedWidth,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
        ),
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
      ),
      label: label,
    );
  }
}
