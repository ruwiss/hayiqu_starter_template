import 'package:flutter/material.dart';

/// ```dart
/// TextWithStroke(
///     text: 'Flutter with Stroke',
///     style: TextStyle(
///     fontSize: 120,
///     color: Color(0xFF7DCFFF),
///     ),
/// ),
/// ```
class TextWithStroke extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign align;
  final double strokeWidth;
  final Color strokeColor;

  const TextWithStroke({
    super.key,
    required this.text,
    this.style,
    this.align = TextAlign.center,
    this.strokeWidth = 2,
    this.strokeColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          textAlign: TextAlign.center,
          style: style?.withStroke(
            strokeWidth: strokeWidth,
            strokeColor: strokeColor,
          ),
        ),
        Text(
          text,
          textAlign: align,
          style: style,
        ),
      ],
    );
  }
}

extension StrokeTextStyle on TextStyle {
  TextStyle withStroke({
    required double strokeWidth,
    required Color strokeColor,
  }) =>
      copyWith(
        foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..color = strokeColor,
      );
}
