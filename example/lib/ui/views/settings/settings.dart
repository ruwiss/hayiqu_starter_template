import 'package:example/app/theme.dart';
import 'package:flutter/material.dart';
import 'package:hayiqu/hayiqu.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                themeProvider.themeMode == ThemeMode.dark
                    ? 'Dark Theme'
                    : 'Light Theme',
              ),
              const Gap(15),
              Switch(
                value: themeProvider.themeMode == ThemeMode.dark,
                onChanged: (_) => themeProvider.toggleTheme(),
              )
            ],
          );
        }),
      ),
    );
  }
}
