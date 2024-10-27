part of '../future_dialog.dart';

class LoadingDialog {
  LoadingDialog._private();
  static final LoadingDialog _instance = LoadingDialog._private();
  static LoadingDialog get instance => _instance;

  BaseLoadingView _view = const LoadingView();
  OverlayEntry? _overlay;
  StreamController<String>? _textController;

  void setView(BaseLoadingView view) => _view = view;
  void setDefaultView() => _view = const LoadingView();

  void show({
    required BuildContext context,
    String text = "Loading",
  }) {
    // If an overlay is already open, just update the text
    if (_overlay != null) {
      _textController?.add(text);
      return;
    }

    // Create a new StreamController
    _textController = StreamController<String>();
    _textController?.add(text);

    // Show Overlay
    _overlay = OverlayEntry(
      builder: (_) => Material(
        color: Colors.black.withAlpha(150),
        child: StreamBuilder<String>(
          stream: _textController!.stream,
          builder: (context, snapshot) =>
              _view.copyWith(newText: snapshot.data ?? text),
        ),
      ),
    );

    Overlay.of(context).insert(_overlay!);
  }

  void hide() {
    // Clear Overlay and StreamController    _textController?.close();
    _overlay?.remove();
    _textController = null;
    _overlay = null;
  }
}
