import 'package:flutter/material.dart';
import 'package:hayiqu/hayiqu.dart';

import 'services/api_service.dart';
import 'services/api_service_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator(() {
    getIt.registerLazySingleton<ApiService>(() => ApiServiceImpl());
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Placeholder());
  }
}
