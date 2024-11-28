part of '../viewmodel.dart';

/// A [BaseViewModel] that provides functionality to subscribe to a reactive service.
abstract class StatefulViewModel extends BaseViewModel {
  List<ListenableServiceMixin> _listenableServices = [];
  List<ListenableServiceMixin> get listenableServices => [];

  StatefulViewModel() {
    if (listenableServices.isNotEmpty) _notifyToServices(listenableServices);
  }

  void _notifyToServices(List<ListenableServiceMixin> listenableServices) {
    _listenableServices = listenableServices;
    for (var listenableService in _listenableServices) {
      listenableService.addListener(_indicateChange);
    }
  }

  @override
  void dispose() {
    for (var listenableService in _listenableServices) {
      listenableService.removeListener(_indicateChange);
    }
    super.dispose();
  }

  void _indicateChange() {
    notifyListeners();
  }
}
