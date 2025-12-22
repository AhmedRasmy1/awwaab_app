import 'package:awwaab_app/core/res/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class CustomSplashScreen extends StatefulWidget {
  const CustomSplashScreen({Key? key}) : super(key: key);

  @override
  State<CustomSplashScreen> createState() => _CustomSplashScreenState();
}

class _CustomSplashScreenState extends State<CustomSplashScreen> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, RoutesManager.mainLayoutRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 600;

    return Scaffold(
      backgroundColor: const Color(0xFF1F3C2E),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: const Duration(seconds: 2),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.scale(
                      scale: 0.5 + (value * 0.5),
                      child: child,
                    ),
                  );
                },
                child: Image.asset(
                  'assets/icons/logo.png',
                  width: isMobile ? screenWidth * 0.4 : 150,
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              Text(
                'أَوَّابٌ',
                style: TextStyle(
                  fontSize: isMobile ? screenWidth * 0.12 : 40,
                  color: const Color(0xFFC8B88A),
                  fontFamily: 'Cairo',
                ),
              ),
              Text(
                'عودة إلى الله',
                style: TextStyle(
                  fontSize: isMobile ? screenWidth * 0.05 : 18,
                  color: const Color(0xFFC8B88A).withValues(alpha: 0.7),
                  fontFamily: 'ArefRuqaa',
                ),
              ),
              SizedBox(height: screenHeight * 0.08),
            ],
          ),
        ),
      ),
    );
  }
}
