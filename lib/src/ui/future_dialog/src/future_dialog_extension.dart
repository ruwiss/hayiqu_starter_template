part of '../future_dialog.dart';

extension FutureDialog<T> on Future<T> {
  Future<T> showWithLoadingDialog(
      {required BuildContext context, String text = "Loading"}) async {
    LoadingDialog.instance.show(context: context, text: text);

    late final T response;

    try {
      response = await this;
    } catch (e) {
      rethrow;
    } finally {
      LoadingDialog.instance.hide();
    }
    return response;
  }
}
