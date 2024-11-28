import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:hayiqu/src/services/http.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator(FutureOr<void> Function()? func) async {
  locator.registerLazySingleton<HttpService>(() => HttpService());
  await func?.call();
}
