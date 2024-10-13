import 'dart:async';

class ErrorAbsorberTransformer<T> extends StreamTransformerBase<T, T> {
  final _controller = StreamController<T>.broadcast();
  ErrorAbsorberTransformer();

  @override
  Stream<T> bind(Stream<T> stream) {
    final sub = stream
        .handleError(
          (_) => _controller.close(),
        )
        .listen(
          _controller.sink.add,
        );
    _controller.onCancel = () {
      sub.cancel();
    };
    return _controller.stream;
  }
}
