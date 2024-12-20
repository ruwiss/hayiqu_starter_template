part of '../viewmodel.dart';

abstract class BaseViewModel extends ChangeNotifier
    with StateHelper, BuilderHelper {
  @override
  void notifyListeners() {
    if (!disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    disposed = true;
    setInitialised(false);
    super.dispose();
  }
}
