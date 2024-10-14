import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

@immutable
class BaseText {
  final String text;
  final TextStyle? style;

  const BaseText({
    required this.text,
    this.style,
  });

  factory BaseText.plain({
    required String text,
    TextStyle? style,
  }) =>
      BaseText(
        text: text,
        style: style ?? const TextStyle(),
      );

  factory BaseText.link({
    required String text,
    required VoidCallback onTap,
    TextStyle? style,
  }) =>
      LinkText(
        text: text,
        onTap: onTap,
        style: style ??
            const TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
      );
}

@immutable
class LinkText extends BaseText {
  final VoidCallback onTap;

  const LinkText({
    required super.text,
    required this.onTap,
    super.style,
  });
}

/// ```dart
/// body: Padding(
///     padding: const EdgeInsets.all(8.0),
///     child: RichTextWidget(
///         styleForAll: Theme.of(context).textTheme.displayMedium,
///         texts: [
///         BaseText.plain(
///             text: 'Welcome to my blog at ',
///         ),
///         BaseText.link(
///             text: 'https://example.com/',
///             onTap: () {
///             // Add logging or handling here
///             },
///         ),
///         ],
///     ),
/// );
/// ```
class RichTextWidget extends StatelessWidget {
  final TextStyle? styleForAll;
  final Iterable<BaseText> texts;

  const RichTextWidget({
    super.key,
    required this.texts,
    this.styleForAll,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          children: texts.map(
        (baseText) {
          final textStyle = styleForAll?.merge(baseText.style);
          if (baseText is LinkText) {
            return TextSpan(
              text: baseText.text,
              style: textStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  baseText.onTap();
                },
            );
          } else {
            return TextSpan(
              text: baseText.text,
              style: textStyle,
            );
          }
        },
      ).toList()),
    );
  }
}
