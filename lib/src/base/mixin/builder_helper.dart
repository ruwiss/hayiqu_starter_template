part of 'mixins.dart';

/// A mixin that provides helper methods for building and managing the state of a widget.
mixin BuilderHelper {
  /// Whether the widget has been disposed.
  bool disposed = false;

  /// Whether the widget has been initialised.
  bool _initialised = false;
  bool get initialised => _initialised;

  /// Called when the ViewModel is first created.
  void setInitialised(bool value) {
    _initialised = value;
  }
}
