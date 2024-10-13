part of 'extensions.dart';

extension FunctionExtensions on VoidCallback {
  /// Fonksiyon çağrısını beklemeli olarak çağırma işlemi
  /// ```dart
  ///_counterClockwiseRotationController.forward.delayedCall(
  ///    const Duration(
  ///    seconds: 1,
  ///    ),
  ///);
  ///```
  Future<void> delayedCall(Duration duration) => Future.delayed(duration, this);
}

extension Unwrap<T> on Future<T?> {
  /// Future Unwrap fonksiyonu (Null Safety)
  /// Eğer gelen değer null ise then fonksiyonu çalışmayacaktır.
  /// ```dart
  /// static Future<File> pickImageFromGallery() => _imagePicker
  ///   .pickImage(source: ImageSource.gallery)
  ///   .unwrap() // null check
  ///   .then((xFile) => xFile.path)
  ///   .then((filePath) => File(filePath))
  /// ```
  Future<T> unwrap() => then(
        (value) => value != null ? Future<T>.value(value) : Future.any([]),
      );
}

extension PresentAsyncSnapshot<E> on AsyncSnapshot<E> {
  /// Future.futureBuilder() fonksiyonu
  /// Bu fonksiyon, FutureBuilder ile aynı işlevi yapar
  /// ```dart
  /// @override
  /// Widget build(BuildContext context) {
  ///   return Scaffold(
  ///     body: SafeArea(
  ///       child: getName().present(
  ///         onData: (_, name) => Text(name),
  ///         onNone: onNone,
  ///         onError: ..,
  ///         onDoneWithoutDataOrError: ..,
  ///         onWaiting: ..,
  ///       ),
  ///     ),
  ///   );
  /// }
  /// ```
  Widget futureBuilder({
    required BuildContext context,
    Widget Function(BuildContext context)? onNone,
    Widget Function(BuildContext context, E data)? onData,
    Widget Function(BuildContext, Object error, StackTrace stackTrace)? onError,
    Widget Function(BuildContext context)? onDoneWithoutDataOrError,
    Widget Function(BuildContext context)? onWaiting,
  }) {
    switch (connectionState) {
      case ConnectionState.none:
        return onNone?.call(context) ?? const SizedBox.shrink();
      case ConnectionState.active:
      case ConnectionState.waiting:
        return onWaiting?.call(context) ?? const CircularProgressIndicator();
      case ConnectionState.done:
        if (hasError) {
          return onError?.call(context, error!, stackTrace!) ??
              const SizedBox.shrink();
        } else if (hasData) {
          return onData?.call(context, data as E) ?? const SizedBox.shrink();
        } else {
          return onDoneWithoutDataOrError?.call(context) ??
              const SizedBox.shrink();
        }
    }
  }
}

extension PresentFuture<E> on Future<E> {
  Widget present({
    Widget Function(BuildContext context)? onNone,
    Widget Function(BuildContext context, E data)? onData,
    Widget Function(BuildContext, Object error, StackTrace stackTrace)? onError,
    Widget Function(BuildContext context)? onDoneWithoutDataOrError,
    Widget Function(BuildContext context)? onWaiting,
  }) {
    return FutureBuilder<E>(
      future: this,
      builder: (context, snapshot) => snapshot.futureBuilder(
        context: context,
        onNone: onNone,
        onData: onData,
        onError: onError,
        onDoneWithoutDataOrError: onDoneWithoutDataOrError,
        onWaiting: onWaiting,
      ),
    );
  }
}
