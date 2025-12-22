import 'package:awwaab_app/bottom_navigation_bar_widget.dart';
import 'package:awwaab_app/core/res/app_constants.dart';
import 'package:awwaab_app/core/res/app_theme.dart';
import 'package:awwaab_app/core/res/color_manager.dart';
import 'package:awwaab_app/core/res/routes_manager.dart';
import 'package:awwaab_app/core/res/values_manager.dart';
import 'package:awwaab_app/core/utils/cashed_data_shared_preferences.dart';
import 'package:awwaab_app/features/settings/viewmodels/theme/theme_cubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await CacheService.cacheInitialization();
  runApp(const Awwaab());
}

class Awwaab extends StatelessWidget {
  const Awwaab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            onGenerateRoute: RouteGenerator.getRoute,
            initialRoute: RoutesManager.initialRoute,
            debugShowCheckedModeBanner: false,
            locale: const Locale('ar'),
            supportedLocales: const [Locale('ar')],
            localizationsDelegates: const [
              GlobalCupertinoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            builder: (context, child) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: child!,
              );
            },
            title: 'Awwaab App',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.themeMode,
          );
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // الألوان بتتاخد أوتوماتيك من الثيم دلوقتي
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppConstants.appNameArabic,
          // شيلنا الستايل المثبت عشان ياخد من الثيم (أبيض في الداكن/أسود في الفاتح)
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings_outlined,
              size: 24, // الحجم بس، اللون بيتاخد من IconTheme
            ),
            onPressed: () {
              Navigator.pushNamed(context, RoutesManager.settingsRoute);
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'مرحبًا بك في تطبيق أَوَّابٌ!',
          style: Theme.of(context).textTheme.bodyLarge, // عشان يتلون صح
        ),
      ),
    );
  }
}
