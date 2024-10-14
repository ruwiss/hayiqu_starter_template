import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hayiqu/src/base/viewmodel.dart';

abstract class BaseTheme extends BaseViewModel {
  // Gets the current platform brightness (light or dark mode).
  static Brightness get brightness =>
      SchedulerBinding.instance.platformDispatcher.platformBrightness;

  // Initializes the theme mode based on the current brightness.
  ThemeMode _themeMode =
      brightness == Brightness.light ? ThemeMode.light : ThemeMode.dark;

  // Returns the current theme mode (light or dark).
  ThemeMode get themeMode => _themeMode;

  // Returns the current theme data based on the theme mode.
  ThemeData get themeData =>
      _themeMode == ThemeMode.light ? lightTheme : darkTheme;

  // Sets the theme mode and notifies listeners of the change.
  void setTheme(ThemeMode theme) {
    _themeMode = theme;
    notifyListeners();
  }

  // Toggles between light and dark theme modes and notifies listeners.
  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  // Defines the light theme with its properties.
  ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor:
            Colors.white, // Sets background color to white.
        colorScheme: ColorScheme.fromSeed(
          seedColor:
              const Color(0xFF6200ee), // Base color for the color scheme.
          brightness: Brightness.light,
        ),
      );

  // Defines the dark theme with its properties.
  ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor:
              const Color(0xFFbb86fc), // Base color for the color scheme.
          brightness: Brightness.dark,
        ),
      );
}
