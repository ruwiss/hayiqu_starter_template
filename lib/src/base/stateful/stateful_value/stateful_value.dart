part of '../stateful.dart';

/// Interface of an Reactive value of type [T]
abstract class StatefulValue<T> {
  factory StatefulValue(T initial) => StoredValue<T>(initial);
  factory StatefulValue.proxy(ValueGetter<T> getterProxy) =>
      ProxyValue<T>(getterProxy);

  /// Get current value
  T get value;

  /// Set value
  set value(T val);

  /// Cast [val] to [T] before setting
  void setCast(dynamic val);

  /// Stream of record of [Change]s of value
  Stream<Change<T>> get onChange;

  /// Stream of changes of value
  Stream<T> get values;

  /// Binds if [other] is [Stream] or [RxValue] of type [T]. Sets if [other] is
  /// instance of [T]
  void bindOrSet(/* T | Stream<T> | Reactive<T> */ other);

  /// Binds [other] to this
  void bind(StatefulValue<T> other);

  /// Binds the [stream] to this
  void bindStream(Stream<T> stream);

  /// Calls [callback] with current value, when the value changes.
  StreamSubscription<T> listen(ValueCallback<T> callback);

  /// Maps the changes into a [Stream] of [R]
  Stream<R> map<R>(R Function(T data) mapper);
}

/// A record of change in [RxValue]
class Change<T> {
  /// Value before change
  final T oldValue;

  /// Value after change
  final T newValue;

  final DateTime time;

  final int batch;

  Change(
    this.newValue,
    this.oldValue,
    this.batch, {
    DateTime? time,
  }) : time = DateTime.now();

  @override
  String toString() => 'Change(new: $newValue, old: $oldValue)';
}
