import 'package:example/services/api/api_repository.dart';
import 'package:example/services/api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:hayiqu/hayiqu.dart';

import 'app/router.dart';
import 'app/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator(() {
    // GetIt servis kayıtlarınızı burada yapınız
    getIt.registerLazySingleton<ApiRepository>(() => ApiService());
  });
  runApp(const MyApp());
}

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
