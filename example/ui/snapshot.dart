import 'package:flutter/material.dart';
import 'package:hayiqu/hayiqu.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<String> getName() => Future.delayed(
        const Duration(seconds: 2),
        () => 'Example',
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<String>(
        future: getName(),
        builder: (context, snapshot) => snapshot.asWidget(
          context: context,
          onData: (_, name) => Text(name),
          // onError: ..,
          // onDoneWithoutDataOrError: ..,
          // onWaiting: ..,
        ),
      ),
    );
  }
}
