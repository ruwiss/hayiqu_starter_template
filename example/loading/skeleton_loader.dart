import 'package:flutter/material.dart';
import 'package:hayiqu/hayiqu.dart';

class ExampleView extends StatelessWidget {
  const ExampleView({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonLoader(
      loading: true,
      // cornerRadius: ,
      // duration: ,
      // startColor: ,
      // endColor: ,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Example"),
            const SizedBox(height: 10),
            ...List.generate(
              10,
              (index) => Text("Hey $index"),
            ),
          ],
        ),
      ),
    );
  }
}