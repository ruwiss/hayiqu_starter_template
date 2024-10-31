import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:hayiqu/src/services/http.dart';

final GetIt getIt = GetIt.instance;
final GetIt locator = GetIt.instance;

Future<void> setupLocator(FutureOr<void> Function()? func) async {
  getIt.registerLazySingleton<HttpService>(() => HttpService());
  await func?.call();
}
