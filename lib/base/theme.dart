import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hayiqu/base/viewmodel.dart';

abstract class BaseTheme extends BaseViewModel {
  static Brightness get brightness =>
      SchedulerBinding.instance.platformDispatcher.platformBrightness;

  ThemeMode _themeMode =
      brightness == Brightness.light ? ThemeMode.light : ThemeMode.dark;

  ThemeMode get themeMode => _themeMode;
  ThemeData get themeData =>
      _themeMode == ThemeMode.light ? lightTheme : darkTheme;

  void setTheme(ThemeMode theme) {
    _themeMode = theme;
    notifyListeners();
  }

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6200ee),
          brightness: Brightness.light,
        ),
      );

  ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFbb86fc),
          brightness: Brightness.dark,
        ),
      );
}
