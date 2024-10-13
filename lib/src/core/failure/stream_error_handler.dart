import 'dart:async';

class StreamErrorHandler<T> extends StreamTransformerBase<T, T> {
  final _controller = StreamController<T>.broadcast();
  final T? Function(Object error) onError;
  StreamErrorHandler({
    required this.onError,
  });

  @override
  Stream<T> bind(Stream<T> stream) {
    final sub = stream.handleError((error) {
      final value = onError(error);
      if (value != null) {
        _controller.sink.add(value);
      }
    }).listen(_controller.sink.add);

    _controller.onCancel = () {
      sub.cancel();
    };

    return _controller.stream;
  }
}
