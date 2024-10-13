part of 'extensions.dart';

extension Log on Object? {
  // Nesneyi loglamak için kullanılır
  // Eğer değer null ise, Renkli NULL yazdırılır
  void log() =>
      devtools.log(this?.toString() ?? '\x1b[101m\x1b[30mNULL\x1b[0m');
}

extension DetailedWhere<K, V> on Map<K, V> {
  /// Map objesinde detaylı Where filtreleme işlemi
  /// ```dart
  /// people.where((key, value) => key.length > 4 && value > 20).log();
  /// -> {Peter: 22}
  ///
  /// people.whereKey((key) => key.length < 5).log();
  /// -> {John: 20, Mary: 21}
  ///
  /// people.whereValue((value) => value.isEven).log();
  /// -> {John: 20, Peter: 22}
  ///```
  Map<K, V> where(bool Function(K key, V value) f) => Map<K, V>.fromEntries(
        entries.where((entry) => f(entry.key, entry.value)),
      );

  Map<K, V> whereKey(bool Function(K key) f) =>
      {...where((key, value) => f(key))};
  Map<K, V> whereValue(bool Function(V value) f) =>
      {...where((key, value) => f(value))};
}

extension Flatten<T extends Object> on Iterable<T> {
  /// Listeyi düzleştirme işlemi
  /// ```dart
  ///void testIt() {
  ///  final flat = [
  ///    [[1, 2, 3], 4, 5],
  ///    [6, [7, [8, 9]], 10],
  ///    11,12
  ///  ].flatten().log();
  ///  -> (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
  ///}
  ///```
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
