import 'dart:developer';

import 'package:hayiqu/src/utils/utils.dart';

void main() async {
  final String? info = await DeviceInfoUtils().getDeviceInfo();
  final String? id = await DeviceInfoUtils().getDeviceId();

  log(info ?? "-");
  log(id ?? "-");
}
