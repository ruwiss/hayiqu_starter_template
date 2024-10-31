import 'package:flutter/material.dart';
import 'package:hayiqu/hayiqu.dart';

class ExampleView extends StatelessWidget {
  const ExampleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RichTextWidget(
        styleForAll: Theme.of(context).textTheme.displayMedium,
        texts: [
          BaseText.plain(
            text: 'Welcome to my blog at ',
          ),
          BaseText.link(
            text: 'https://example.com/',
            onTap: () {
              'Tapped'.log();
            },
          ),
        ],
      ),
    );
  }
}
