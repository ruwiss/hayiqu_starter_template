import 'package:flutter/widgets.dart';
import 'package:hayiqu/hayiqu.dart';

import '../ui/views/home/home_view.dart';

class AppRouter {
  AppRouter._();

  static String get _initialRoute => homeRoute;
  static const String homeRoute = '/home';

  static final routerKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    initialLocation: _initialRoute,
    navigatorKey: routerKey,
    routes: [
      _buildRoute(
        homeRoute,
        const HomeView(),
      ),
    ],
  );

  static GoRoute _buildRoute<T extends ChangeNotifier>(
    String path,
    Widget child,
  ) {
    return GoRoute(
      path: path,
      pageBuilder: (context, state) => CustomTransitionPage(
        child: child,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
          child: child,
        ),
      ),
    );
  }
}
