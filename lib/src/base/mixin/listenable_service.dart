part of 'mixins.dart';

/// Adds functionality to easily listen to all reactive values in a service
mixin ListenableServiceMixin {
  final List<Function> _listeners = List<Function>.empty(growable: true);

  int get listenersCount => _listeners.length;

  /// List to the values and react when there are any changes
  void listenToStatefulValues(List<dynamic> statefulValues) {
    for (var statefulValue in statefulValues) {
      if (statefulValue is ChangeNotifier) {
        statefulValue.addListener(notifyListeners);
      } else if (statefulValue is StatefulValue) {
        statefulValue.values.listen((value) => notifyListeners());
      } else if (statefulValue is StatefulList) {
        statefulValue.onChange.listen((event) => notifyListeners());
      }
    }
  }

  /// Registers a listener with this service
  void addListener(void Function() listener) {
    _listeners.add(listener);
  }

  /// Removes a listener from the service
  void removeListener(void Function() listener) {
    _listeners.remove(listener);
  }

  /// Notifies all the listeners attached to this service
  @protected
  @visibleForTesting
  void notifyListeners() {
    for (var listener in _listeners) {
      listener();
    }
  }
}
