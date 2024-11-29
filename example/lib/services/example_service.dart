import 'dart:async';

import 'package:hayiqu/hayiqu.dart';

class ExampleService with ListenableServiceMixin {
  final _httpService = locator<HttpService>();

  int _currentValue = 0;
  int get currentValue => _currentValue;

  List<int> _fetchedNumbers = [];
  List<int> get fetchedNumbers => _fetchedNumbers;

  ExampleService() {
    _httpService.setBaseUrl("https://www.randomnumberapi.com/api/v1.0");
    _startUpdating();
    listenToStatefulValues([_currentValue, _fetchedNumbers]);
  }

  void _startUpdating() {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      _currentValue++;
      _fetchNumbers();
    });
  }

  void _fetchNumbers() async {
    final res = await _httpService.get("/random?min=100&max=1000&count=5");
    if (res.hasError) {
      res.requireError.log();
      throw res.requireError;
    }

    _fetchedNumbers = res.requireValue.data.cast<int>();
  }
}
