part of 'mixins.dart';

mixin StateHelper on ChangeNotifier {
  final Map<int, bool> _busyStates = <int, bool>{};

  /// Returns the busy state of an object if it exists. Returns false otherwise.
  bool busy(Object? object) => _busyStates[object.hashCode] ?? false;

  /// Returns the busy state of the ViewModel.
  bool get isBusy => busy(this);

  // Returns true if any object is still in a busy state.
  bool get anyObjectsBusy => _busyStates.values.any((busy) => busy);

  /// Sets the busy state for the object to the specified value and notifies listeners.
  /// If you're using a simple type, the value MUST NOT BE MODIFIED, because Hashcode == value is used.
  void setBusyForObject(Object? object, {required bool value}) {
    _busyStates[object.hashCode] = value;
    notifyListeners();
  }

  /// Marks the ViewModel as busy and notifies listeners.
  void setBusy(bool value) => setBusyForObject(this, value: value);

  /// Marks the ViewModel as busy, runs the Future function, and removes the busy state when completed.
  /// If throwException is true, [Exception] is rethrown.
  Future<T> runBusyFuture<T>(
    Future<T> busyFuture, {
    Object? busyObject,
    bool throwException = false,
  }) async {
    _setBusyForModelOrObject(true, busyObject: busyObject);
    try {
      final value = await _runErrorFuture<T>(
        busyFuture,
        key: busyObject,
        throwException: throwException,
      );
      return value;
    } catch (e) {
      if (throwException) rethrow;
      return Future.value();
    } finally {
      _setBusyForModelOrObject(false, busyObject: busyObject);
    }
  }

  void _setBusyForModelOrObject(bool value, {Object? busyObject}) {
    if (busyObject != null) {
      setBusyForObject(busyObject, value: value);
    } else {
      setBusyForObject(this, value: value);
    }
  }

  final Map<int, dynamic> _errorStates = <int, dynamic>{};
  T error<T>(Object object) => _errorStates[object.hashCode] as T;

  /// Returns the error state of the ViewModel.
  bool get hasError => error<dynamic>(this) != null;

  /// Returns the error state of the ViewModel.
  T modelError<T>() => error<T>(this);

  /// Clears all errors.
  void clearErrors() => _errorStates.clear();

  /// Returns a boolean indicating whether there is an error for a key in the ViewModel.
  bool hasErrorForKey(Object key) => error<dynamic>(key) != null;

  /// Sets the error for the ViewModel.
  void setError(dynamic error) => setErrorForObject(this, error);

  void _setErrorForModelOrObject(dynamic value, {Object? key}) {
    if (key != null) {
      setErrorForObject(key, value);
    } else {
      setErrorForObject(this, value);
    }
  }

  /// Sets the error state for an object to the specified value and notifies listeners.
  /// If you're using a simple type, the value MUST NOT BE MODIFIED, because Hashcode == value is used.
  void setErrorForObject(Object object, dynamic value) {
    _errorStates[object.hashCode] = value;
    notifyListeners();
  }

  Future<T> _runErrorFuture<T>(
    Future<T> future, {
    Object? key,
    bool throwException = false,
  }) async {
    try {
      _setErrorForModelOrObject(null, key: key);
      return await future;
    } catch (e) {
      _setErrorForModelOrObject(e, key: key);
      onFutureError(e, key);
      if (throwException) rethrow;
      return Future.value();
    }
  }

  /// When a Busy Future is executed and an error occurs,
  /// this is used to handle that error in general.
  void onFutureError(dynamic error, Object? key) {}
}
