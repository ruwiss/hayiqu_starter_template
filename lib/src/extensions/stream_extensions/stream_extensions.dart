part of '../extensions.dart';

extension StreamExtensions<T> on Stream<T> {
  /// Waits for a specified duration between events.
  /// Example usage:
  /// ```dart
  /// await for (final name in getNames().withTimeoutBetweenEvents(
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

  /// Error recovery for the stream.
  /// Allows you to recover from errors that occur in the stream.
  /// Example usage:
  /// ```dart
  /// Stream<String> getNames() async* {
  ///   yield 'Foo';
  ///   yield 'Bar';
  ///   throw Exception('Something went wrong');
  /// }
  ///
  /// final names = getNames().onErrorRecoverWith(
  ///   (error) {
  ///     error.log(); // Log the error
  ///     return 'Baz'; // Provide a fallback value
  ///   },
  /// );
  ///
  /// await for (final name in names) {
  ///       name.log(); // Foo, Bar, Baz
  /// }
  /// ```
  Stream<T> onErrorRecoverWith(T? Function(Object error) onError) {
    return transform(StreamErrorHandler<T>(onError: onError));
  }

  /// Stops the stream if an error occurs.
  /// Example usage:
  /// ```dart
  /// Stream<String> getNames() async* {
  ///   yield 'Vandad';
  ///   await Future.delayed(const Duration(seconds: 1));
  ///   yield 'John';
  ///   await Future.delayed(const Duration(seconds: 1));
  ///   throw 'Enough names for you'; // Throws an error
  /// }
  ///
  /// Future<void> testIt() async {
  ///   await for (final name in getNames().absorbErrors()) {
  ///     name.log(); // Vandad, John, then stream closes
  ///   }
  /// }
  /// ```
  Stream<T> absorbErrors() {
    return transform(ErrorAbsorberTransformer());
  }
}
