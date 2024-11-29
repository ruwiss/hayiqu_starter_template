import 'package:example/app/theme.dart';
import 'package:example/services/example_service.dart';
import 'package:flutter/material.dart';
import 'package:hayiqu/hayiqu.dart';

import 'app/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator(() {
    locator.registerLazySingleton(() => ExampleService());
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppTheme(),
      child: Consumer<AppTheme>(
        builder: (context, value, child) {
          return MaterialApp.router(
            routerConfig: AppRouter.router,
            theme: value.themeData,
            themeMode: value.themeMode,
          );
        },
      ),
    );
  }
}
