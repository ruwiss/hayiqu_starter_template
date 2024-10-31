import 'package:flutter/material.dart';
import 'package:hayiqu/hayiqu.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  // Example Future Function
  Future<void> _futureExample() {
    return Future.delayed(const Duration(seconds: 2));
  }

  // With Extension (Short Method)
  void _example1(BuildContext context) async {
    _futureExample().showWithLoadingDialog(context: context, text: "Loading..");
  }

  // Without Extension (Long Method)
  void _example2(BuildContext context) async {
    LoadingDialog.instance.show(context: context, text: "Fetching..");
    await _futureExample();
    if (context.mounted) {
      LoadingDialog.instance.show(context: context, text: "Almost Done");
    }
    await _futureExample();
    LoadingDialog.instance.hide();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => _example1(context),
              child: const Text("Example 1"),
            ),
            ElevatedButton(
              onPressed: () => _example2(context),
              child: const Text("Example 2"),
            ),
          ],
        ),
      ),
    );
  }
}
