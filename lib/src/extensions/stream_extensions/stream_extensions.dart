part of '../extensions.dart';

extension StreamExtensions<T> on Stream<T> {
  /// Eventler arasında bekleme işlemi
  /// ```dart
  ///await for (final name in getNames().withTimeoutBetweenEvents(
  ///    const Duration(
  ///      seconds: 3,
  ///    ),
  ///  )) {
  ///    name.log();
  ///  }
  /// ```
  Stream<T> withTimeoutBetweenEvents(Duration duration) {
    return transform(TimeoutBetweenEvents(duration: duration));
  }

  /// Stream Hata Kurtarma işlemi
  /// Hata meydana gelirse, bu durumu kurtarmanıza olana sağlar
  /// ```dart
  ///Stream<String> getNames() async* {
  ///  yield 'Foo';
  ///  yield 'Bar';
  ///  throw Exception('Something went wrong');
  ///}
  ///
  /// final names = getNames().onErrorRecoverWith(
  ///   (error) {
  ///     error.log();
  ///     return 'Baz';
  ///   },
  /// );
  ///
  /// await for (final name in names) {
  ///       name.log(); // Foo, Bar, Baz
  /// }
  ///```
  Stream<T> onErrorRecoverWith(T? Function(Object error) onError) {
    return transform(StreamErrorHandler<T>(onError: onError));
  }

  /// Stream üzerinde hata meydana gelirse, kendisini durdurur
  /// ```dart
  ///Stream<String> getNames() async* {
  ///  yield 'Vandad';
  ///  await Future.delayed(const Duration(seconds: 1));
  ///  yield 'John';
  ///  await Future.delayed(const Duration(seconds: 1));
  ///  throw 'Enough names for you';
  ///}
  ///
  ///Future<void> testIt() async {
  ///  await for (final name in getNames().absorbErrors()) {
  ///    name.log(); // Vandad, John, then stream closes
  ///  }
  ///}
  ///```
  Stream<T> absorbErrors() {
    return transform(ErrorAbsorberTransformer());
  }
}
