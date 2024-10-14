part of 'extensions.dart';

extension Log on Object? {
  /// Logs the object. If the value is null, prints a colored 'NULL'.
  void log() =>
      devtools.log(this?.toString() ?? '\x1b[101m\x1b[30mNULL\x1b[0m');
}

extension DetailedWhere<K, V> on Map<K, V> {
  /// Performs detailed filtering on the Map object.
  ///
  /// Usage examples:
  /// ```dart
  /// people.where((key, value) => key.length > 4 && value > 20).log();
  /// // Output: {Peter: 22}
  ///
  /// people.whereKey((key) => key.length < 5).log();
  /// // Output: {John: 20, Mary: 21}
  ///
  /// people.whereValue((value) => value.isEven).log();
  /// // Output: {John: 20, Peter: 22}
  /// ```
  Map<K, V> where(bool Function(K key, V value) f) => Map<K, V>.fromEntries(
        entries.where((entry) => f(entry.key, entry.value)),
      );

  /// Filters the Map based on keys.
  Map<K, V> whereKey(bool Function(K key) f) =>
      {...where((key, value) => f(key))};

  /// Filters the Map based on values.
  Map<K, V> whereValue(bool Function(V value) f) =>
      {...where((key, value) => f(value))};
}

extension Flatten<T extends Object> on Iterable<T> {
  /// Flattens a nested list structure.
  ///
  /// Usage example:
  /// ```dart
  /// void testIt() {
  ///   final flat = [
  ///     [[1, 2, 3], 4, 5],
  ///     [6, [7, [8, 9]], 10],
  ///     11, 12
  ///   ].flatten().log();
  ///   // Output: (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
  /// }
  /// ```
  Iterable<T> flatten() {
    Iterable<T> flatten(Iterable<T> list) sync* {
      for (final value in list) {
        if (value is List<T>) {
          yield* flatten(value);
        } else {
          yield value;
        }
      }
    }

    return flatten(this);
  }
}
