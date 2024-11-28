part of '../stateful.dart';

class StoredValue<T> implements StatefulValue<T> {
  T _value;
  @override
  T get value => _value;
  @override
  set value(T val) {
    if (_value == val) {
      return;
    }
    T old = _value;
    _value = val;
    _change.add(Change<T>(val, old, _curBatch));
  }

  final StreamController<Change<T>> _change;

  final Stream<Change<T>> _onChange;

  int _curBatch = 0;

  StoredValue._(this._value, this._change, this._onChange);

  factory StoredValue(T initial) {
    // ignore: close_sinks
    final controller = StreamController<Change<T>>();
    return StoredValue._(
        initial, controller, controller.stream.asBroadcastStream());
  }

  @override
  void setCast(dynamic /* T */ val) => value = val;

  @override
  Stream<Change<T>> get onChange {
    _curBatch++;
    // ignore: close_sinks
    final ret = StreamController<Change<T>>();
    ret.add(Change<T>(value, value, _curBatch));
    ret.addStream(_onChange.skipWhile((v) => v.batch < _curBatch));
    return ret.stream.asBroadcastStream();
  }

  @override
  Stream<T> get values => onChange.map((c) => c.newValue);

  @override
  void bind(StatefulValue<T> stateful) {
    value = stateful.value;
    stateful.values.listen((v) => value = v);
  }

  @override
  void bindStream(Stream<T> stream) => stream.listen((v) => value = v);

  @override
  void bindOrSet(/* T | Stream<T> | Stateful<T> */ other) {
    if (other is StatefulValue<T>) {
      bind(other);
    } else if (other is Stream<T>) {
      bindStream(other.cast<T>());
    } else {
      value = other;
    }
  }

  @override
  StreamSubscription<T> listen(ValueCallback<T> callback) =>
      values.listen(callback);

  @override
  Stream<R> map<R>(R Function(T data) mapper) => values.map(mapper);
}
