import 'package:awwaab_app/bottom_navigation_bar_widget.dart';
import 'package:awwaab_app/features/settings/views/settings_page.dart';
import 'package:awwaab_app/splash_screen.dart';
import 'package:flutter/material.dart';

class RoutesManager {
  static const String initialRoute = '/';
  static const String mainLayoutRoute = '/mainLayout';
  static const String settingsRoute = '/settings';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesManager.initialRoute:
        return MaterialPageRoute(builder: (_) => const CustomSplashScreen());
      case RoutesManager.mainLayoutRoute:
        return MaterialPageRoute(builder: (_) => const MainLayoutScreen());
      case RoutesManager.settingsRoute:
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text("No Route Found")),
        body: const Center(child: Text("No Route Found")),
      ),
    );
  }
}
