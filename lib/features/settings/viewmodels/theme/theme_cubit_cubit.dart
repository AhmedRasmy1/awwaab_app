import 'package:awwaab_app/core/utils/cashed_data_shared_preferences.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'theme_cubit_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(themeMode: ThemeMode.light)) {}

  void changeTheme({required bool isDark}) async {
    final themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    emit(ThemeState(themeMode: themeMode));

    await CacheService.setData(key: CacheConstants.themeMode, value: isDark);
  }

  void _loadTheme() {
    final savedIsDark = CacheService.getData(key: CacheConstants.themeMode);

    bool isDark = false;
    if (savedIsDark != null && savedIsDark is bool) {
      isDark = savedIsDark;
    }
    emit(ThemeState(themeMode: isDark ? ThemeMode.dark : ThemeMode.light));
  }
}
