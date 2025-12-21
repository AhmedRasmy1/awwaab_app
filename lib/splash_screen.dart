import 'package:awwaab_app/core/res/routes_manager.dart';
import 'package:awwaab_app/main.dart';
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
      Navigator.pushReplacementNamed(context, RoutesManager.homePageRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F3C2E),
      body: Center(
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
              child: Image.asset('assets/icons/logo.png', width: 150),
            ),
            const SizedBox(height: 35),
            const Text(
              'أَوَّابٌ',
              style: TextStyle(
                fontSize: 40,
                color: Color(0xFFC8B88A),
                fontFamily: 'Cairo',
              ),
            ),
            Text(
              'عودة إلى الله',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFFC8B88A).withOpacity(0.7),
                fontFamily: 'Cairo',
              ),
            ),

            const SizedBox(height: 40),
            // const CircularProgressIndicator(
            //   valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFC8B88A)),
            // ),
          ],
        ),
      ),
    );
  }
}
