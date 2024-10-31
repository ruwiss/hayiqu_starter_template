import 'package:flutter/material.dart';
import 'package:hayiqu/hayiqu.dart';

class ExampleView extends StatelessWidget {
  const ExampleView({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextWithStroke(
      text: 'Flutter with Stroke',
      style: TextStyle(
        fontSize: 120,
        color: Color(0xFF7DCFFF),
      ),
    );
  }
}
