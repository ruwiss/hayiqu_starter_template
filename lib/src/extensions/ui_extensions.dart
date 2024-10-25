part of 'extensions.dart';

extension CircularProgressExtension on CircularProgressIndicator {
  SizedBox resized(double size) => SizedBox(
        width: size,
        height: size,
        child: this,
      );
}
