part of '../future_dialog.dart';

class LoadingDialog {
  LoadingDialog._private();
  static final LoadingDialog _instance = LoadingDialog._private();
  static LoadingDialog get instance => _instance;

  LoadingDialogController? _controller;
  BaseLoadingView _view = const LoadingView();

  void setView(BaseLoadingView view) => _view = view;
  void setDefaultView() => _view = const LoadingView();

  void show({
    required BuildContext context,
    String text = "Loading",
  }) {
    if (_controller?.update(text) ?? false) {
      return;
    } else {
      _controller = _showOverlay(context: context, text: text);
    }
  }

  void hide() {
    _controller?.close();
    _controller = null;
  }

  LoadingDialogController? _showOverlay({
    required BuildContext context,
    required String text,
  }) {
    final textController = StreamController<String>();
    textController.add(text);
    final state = Overlay.of(context);

    final overlay = OverlayEntry(
      builder: (_) => Material(
        color: Colors.black.withAlpha(150),
        child: StreamBuilder(
          stream: textController.stream,
          builder: (context, snapshot) =>
              _view.copyWith(newText: snapshot.data),
        ),
      ),
    );

    state.insert(overlay);

    return LoadingDialogController(
      close: () {
        textController.close();
        overlay.remove();
        return true;
      },
      update: (String text) {
        textController.add(text);
        return true;
      },
    );
  }
}
