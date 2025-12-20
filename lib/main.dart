import 'package:awwaab_app/core/res/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const Awwaab());
}

class Awwaab extends StatelessWidget {
  const Awwaab({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar')],
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
      title: 'Awwaab App',
      theme: AppTheme.lightTheme,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('أَوَّابٌ')),
      body: const Center(child: Text('مرحبًا بك في تطبيق أَوَّابٌ!')),
    );
  }
}
