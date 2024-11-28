part of 'extensions.dart';

final _size =
    WidgetsBinding.instance.platformDispatcher.views.first.physicalSize;

extension NumExtensions on num {
  // Ekran genişliği * değer
  double get vw => _size.width * toDouble();

  // Ekran yüksekliği * değer
  double get vh => _size.height * toDouble();
}
