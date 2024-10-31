part of '../future_dialog.dart';

abstract class BaseLoadingView extends StatelessWidget {
  final String text;

  const BaseLoadingView({super.key, this.text = "Loading"});

  BaseLoadingView copyWith({String? newText});

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Placeholder(),
    );
  }
}

class LoadingView extends BaseLoadingView {
  const LoadingView({super.key, super.text});

  @override
  LoadingView copyWith({String? newText}) {
    return LoadingView(
      key: key,
      text: newText ?? text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: .8.vw,
          maxHeight: .8.vw,
          minWidth: 150,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const CircularProgressIndicator().resized(18),
              Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
