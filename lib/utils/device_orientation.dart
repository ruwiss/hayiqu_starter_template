part of 'utils.dart';

// Cihazın yatay ya da diket olarak kullanılacağını belirlediğimiz kısım
final class DeviceOrientationSettings {
  DeviceOrientationSettings._();

  static Future<void> screenVertical() async {
    await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );
  }

  static Future<void> screenHorizontal() async {
    await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight],
    );
  }

  static Future<void> screenRight() async {
    await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeRight],
    );
  }

  static Future<void> screenLeft() async {
    await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft],
    );
  }
}
