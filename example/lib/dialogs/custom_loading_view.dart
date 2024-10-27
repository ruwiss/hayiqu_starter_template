import 'package:flutter/material.dart';
import 'package:hayiqu/hayiqu.dart';

class CustomLoadingView extends BaseLoadingView {
  const CustomLoadingView({super.key, super.text});

  @override
  CustomLoadingView copyWith({String? newText}) {
    return CustomLoadingView(
      key: key,
      text: newText ?? text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withAlpha(150),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: .8.vw,
            maxHeight: .8.vw,
            minWidth: 150,
          ),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const CircularProgressIndicator().resized(18),
                Text(text, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
