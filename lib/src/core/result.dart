import 'package:flutter/material.dart';

enum ResultType { value, error }

/// ```dart
/// Future<Result<int, FirebaseException>> getUserId() async {
///     try {
///       final userId = await _authService.getUserId();
///       return Result.value(input: userId);
///     } on FirebaseException catch (e) {
///       return Result.error(input: e);
///     }
/// }
///
/// final result = await getUserId();
///
/// if (result.hasError) {///
///  result.requireError.log();
/// } else {///
///  result.requireValue.log();
///}
///```
@immutable
class Result<T, E> {
  final T? value;
  final E? error;
  final ResultType type;
  const Result.error({required E input})
      : error = input,
        value = null,
        type = ResultType.error;
  const Result.value({required T input})
      : value = input,
        error = null,
        type = ResultType.value;
  E get requireError => error!;
  T get requireValue => value!;

  bool get hasError => type == ResultType.error;
  bool get hasValue => type == ResultType.value;

  @override
  String toString() {
    switch (type) {
      case ResultType.value:
        return 'Value => ${requireValue.toString()}';
      case ResultType.error:
        return 'Error => ${requireError.toString()}';
    }
  }
}
