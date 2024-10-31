import 'package:flutter/material.dart';
import 'package:hayiqu/hayiqu.dart';

class GapExample extends StatelessWidget {
  const GapExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Gap(10),
            Text('Hello'),
            Gap(10),
          ],
        ),
        Gap(15),
        Column(
          children: [
            Gap(5),
            Text('World'),
            Gap(5),
          ],
        )
      ],
    );
  }
}
