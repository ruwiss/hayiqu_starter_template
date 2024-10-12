import 'package:example/ui/views/auth/auth.dart';
import 'package:example/ui/views/auth/auth_viewmodel.dart';
import 'package:example/ui/views/auth/settings/auth_settings.dart';
import 'package:example/ui/views/home/home.dart';
import 'package:example/ui/views/home/home_viewmodel.dart';
import 'package:example/ui/views/settings/settings.dart';
import 'package:example/ui/views/ui.dart';
import 'package:flutter/widgets.dart';
import 'package:hayiqu/hayiqu.dart';

final class AppRouter {
  // Singleton Pattern
  static final AppRouter _instance = AppRouter._internal();
  factory AppRouter() => _instance;

  AppRouter._internal();

  static String get homeRoute => '/';
  static String get authRoute => '/auth';
  static String get settingsRoute => '/settings';
  static String get authSettingsRoute => '/auth/settings';
  static String get _authSettingsRoute => 'settings';

  String get _initialRoute => homeRoute;

  static final GoRouter _router = GoRouter(
    navigatorKey: GlobalKey<NavigatorState>(),
    initialLocation: _instance._initialRoute,
    routes: [
      // Bottom Navbar Routes
      _bottomNavbarRoutes,

      // Settings Route
      GoRoute(
        path: settingsRoute,
        builder: (context, state) => const SettingsView(),
      ),
    ],
  );

  static GoRouter get router => _router;

  /// Bottom Navbar Routes
  static final StatefulShellRoute _bottomNavbarRoutes =
      StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) =>
        UILayout(navigationShell: navigationShell),
    branches: [
      // Auth Route
      StatefulShellBranch(
        navigatorKey: GlobalKey<NavigatorState>(),
        routes: [
          GoRoute(
            path: authRoute,
            builder: (context, state) => ChangeNotifierProvider(
              create: (context) => AuthViewmodel(),
              child: const AuthView(),
            ),
            routes: [
              GoRoute(
                path: _authSettingsRoute,
                builder: (context, state) => const AuthSettingsView(),
              ),
            ],
          ),
        ],
      ),
      // Home Route
      StatefulShellBranch(
        navigatorKey: GlobalKey<NavigatorState>(),
        routes: [
          GoRoute(
            path: homeRoute,
            builder: (context, state) => ChangeNotifierProvider(
              create: (context) => HomeViewmodel(),
              child: const HomeView(),
            ),
          ),
        ],
      ),
    ],
  );
}
