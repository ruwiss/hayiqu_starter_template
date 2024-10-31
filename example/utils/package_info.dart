import 'dart:developer';

import 'package:hayiqu/src/utils/utils.dart';

void main() async {
  await PackageInfoUtils().init();

  final String appName = PackageInfoUtils().getAppName();
  final String appVersionName = PackageInfoUtils().getAppVersion();

  log(appName);
  log(appVersionName);
}
