import 'package:awwaab_app/main.dart';
import 'package:awwaab_app/splash_screen.dart';
import 'package:flutter/material.dart';

class RoutesManager {
  static const String initialRoute = '/';
  static const String homePageRoute = '/home';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesManager.initialRoute:
        return MaterialPageRoute(builder: (_) => const CustomSplashScreen());
      case RoutesManager.homePageRoute:
        return MaterialPageRoute(builder: (_) => const HomePage());
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
