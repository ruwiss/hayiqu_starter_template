import 'package:example/app/router.dart';
import 'package:example/dialogs/test_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hayiqu/hayiqu.dart';

import '../../../dialogs/custom_loading_view.dart';

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
          const Gap(10),
          ElevatedButton(
            onPressed: () {
              LoadingDialog.instance.setView(const CustomLoadingView());
              Future.delayed(const Duration(seconds: 2))
                  .showWithLoadingDialog(context: context, text: "Loading..");
            },
            child: const Text("Show Loading UseCase 1"),
          ),
          const Gap(10),
          ElevatedButton(
            onPressed: () async {
              LoadingDialog.instance.setDefaultView();
              LoadingDialog.instance.show(context: context, text: "Fetching..");
              await Future.delayed(const Duration(seconds: 2));
              if (context.mounted) {
                LoadingDialog.instance
                    .show(context: context, text: "Almost Done");
              }
              await Future.delayed(const Duration(seconds: 1));
              LoadingDialog.instance.hide();
            },
            child: const Text("Show Loading UseCase 2"),
          ),
        ],
      )),
    );
  }
}
