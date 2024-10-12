part of 'mixins.dart';

/// Bir verinin durumunu kontrol altına almak için yardımcı sınıf
mixin DataStateHelper<T> on StateHelper {
  T? _data;

  T? get data => _data;

  set data(T? data) {
    _data = data;
  }

  /// Veri var ise, meşgul değilse ve hata mevcut değilse true döner
  bool get dataReady => _data != null && !hasError && !isBusy;
}
