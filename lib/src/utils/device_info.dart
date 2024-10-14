part of 'utils.dart';

final class DeviceInfoUtils {
  static final DeviceInfoUtils _instance = DeviceInfoUtils._();

  factory DeviceInfoUtils() {
    return _instance;
  }

  DeviceInfoUtils._();

  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  Future<String?> getDeviceId() async {
    if (kIsWeb) {
      return const Uuid().v4();
    } else {
      if (Platform.isIOS) {
        final iosDeviceInfo = await _deviceInfo.iosInfo;
        return iosDeviceInfo.identifierForVendor;
      } else if (Platform.isAndroid) {
        final androidDeviceInfo = await _deviceInfo.androidInfo;
        return androidDeviceInfo.id;
      } else {
        return null;
      }
    }
  }

  Future<String?> getDeviceInfo() async {
    if (kIsWeb) {
      final webBrowserInfo = await _deviceInfo.webBrowserInfo;
      return webBrowserInfo.platform;
    } else if (Platform.isIOS) {
      final iosDeviceInfo = await _deviceInfo.iosInfo;
      return iosDeviceInfo.utsname.machine;
    } else if (Platform.isAndroid) {
      final androidDeviceInfo = await _deviceInfo.androidInfo;
      return androidDeviceInfo.model;
    } else {
      return null;
    }
  }
}
