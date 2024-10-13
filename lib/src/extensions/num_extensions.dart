part of 'extensions.dart';

final _size =
    WidgetsBinding.instance.platformDispatcher.views.first.physicalSize;

extension NumExtensions on num {
  // SizedBox(height: value)
  SizedBox sbh() => SizedBox(height: toDouble());

  // SizedBox(width: value)
  SizedBox sbw() => SizedBox(width: toDouble());

  // Ekran genişliği * değer
  double get vw => _size.width * toDouble();

  // Ekran yüksekliği * değer
  double get vh => _size.height * toDouble();
}
