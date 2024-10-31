// app/theme.dart
import 'package:flutter/material.dart';
import 'package:hayiqu/hayiqu.dart';

import 'router.dart';

class ThemeProvider extends BaseTheme {
  @override
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

  @override
  ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor:
              const Color(0xFFbb86fc), // Base color for the color scheme.
          brightness: Brightness.dark,
        ),
      );
}

// theme.dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
      ],
      builder: (context, child) {
        final themeProvider = context.watch<ThemeProvider>();
        return MaterialApp.router(
          title: 'Example',
          theme: themeProvider.themeData,
          themeMode: themeProvider.themeMode,
          routerConfig: AppRouter.router,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
