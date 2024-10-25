part of '../future_dialog.dart';

typedef CloseLoadingScreen = bool Function();
typedef UpdateLoadingScreen = bool Function(String text);

final class LoadingDialogController {
  final CloseLoadingScreen close; // to closs our dialog
  final UpdateLoadingScreen
      update; // to update anytext with in our dialog if needed

  const LoadingDialogController({
    required this.close,
    required this.update,
  });
}
