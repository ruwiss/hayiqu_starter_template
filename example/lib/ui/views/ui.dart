import 'package:example/app/router.dart';
import 'package:flutter/material.dart';
import 'package:hayiqu/hayiqu.dart';

class UILayout extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const UILayout({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example'),
        actions: [
          IconButton(
            onPressed: () => context.push(AppRouter.settingsRoute),
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        indicatorColor: Colors.transparent,
        onDestinationSelected: navigationShell.goBranch,
        destinations: [
          _menuItem(
            context,
            index: 0,
            currentIndex: navigationShell.currentIndex,
            icon: Icons.face,
            label: 'Auth',
          ),
          _menuItem(
            context,
            index: 1,
            currentIndex: navigationShell.currentIndex,
            icon: Icons.bookmark,
            label: 'Home',
          ),
        ],
      ),
    );
  }

  Widget _menuItem(
    BuildContext context, {
    required int index,
    required int currentIndex,
    required String label,
    required IconData icon,
  }) {
    return NavigationDestination(
      icon: Icon(
        icon,
        color: currentIndex == index
            ? Theme.of(context).colorScheme.tertiary
            : null,
      ),
      label: label,
    );
  }
}
