part of 'mixins.dart';
/// A helper class to control the state of a data
mixin DataStateHelper<T> on StateHelper {
  T? _data;

  T? get data => _data;

  set data(T? data) {
    _data = data;
  }

  /// Returns true if data is available, not busy, and no error exists
  bool get dataReady => _data != null && !hasError && !isBusy;
}
