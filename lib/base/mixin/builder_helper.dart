part of 'mixins.dart';

mixin BuilderHelper {
  bool disposed = false;

  bool _initialised = false;
  bool get initialised => _initialised;

  /// ViewModel ilk olarak oluşturulduğunda çağırılır
  void setInitialised(bool value) {
    _initialised = value;
  }
}
