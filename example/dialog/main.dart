import 'package:flutter/material.dart';
import 'package:hayiqu/hayiqu.dart';

class ExampleView extends StatelessWidget {
  const ExampleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: OutlinedButton(
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
      ),
    );
  }
}

class TestDialog extends StatelessWidget {
  const TestDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => DialogNavigator.of(context).push(
        FluidDialogPage(
          // New dialog page to be displayed
          builder: (context) => const SecondDialogPage(),
        ),
      ),
      child: const Text('Go to next page'),
    );
  }
}

class SecondDialogPage extends StatelessWidget {
  const SecondDialogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
