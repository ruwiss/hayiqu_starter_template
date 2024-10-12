import 'package:example/app/router.dart';
import 'package:example/dialogs/test_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hayiqu/hayiqu.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Auth'),
          IconButton(
            onPressed: () => context.push(AppRouter.authSettingsRoute),
            icon: const Icon(Icons.settings),
          ),
          const Gap(30),
          OutlinedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => FluidDialog(
                  rootPage: FluidDialogPage(
                    alignment: Alignment.bottomCenter,
                    builder: (context) => const TestDialog(),
                  ),
                ),
              );
            },
            child: const Text('Open Dialog'),
          ),
        ],
      )),
    );
  }
}
