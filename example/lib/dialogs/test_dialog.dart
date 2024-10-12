import 'package:flutter/material.dart';
import 'package:hayiqu/hayiqu.dart';

import 'second_dialog.dart';

class TestDialog extends StatelessWidget {
  const TestDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Hello there',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const Text(
              'This is a dialog. It can transition in from the top, bottom, left, or right. The size is also animated.'),
          TextButton(
            onPressed: () => DialogNavigator.of(context).push(
              FluidDialogPage(
                builder: (context) => const SecondDialogPage(),
              ),
            ),
            child: const Text('Go to next page'),
          ),
        ],
      ),
    );
  }
}
