import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:hayiqu/services/http.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupLocator(FutureOr<void> Function()? func) async {
  getIt.registerLazySingleton<HttpService>(() => HttpService());
  await func?.call();
}
