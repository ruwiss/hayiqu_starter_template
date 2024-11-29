import 'dart:async';

import 'package:example/services/example_service.dart';
import 'package:hayiqu/hayiqu.dart';

class HomeViewModel extends StatefulViewModel {
  final _exampleService = locator<ExampleService>();

  void startCounter() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _changeCount());
  }

  late final Timer _timer;

  int _count = 0;
  int get count => _count;

  int get serviceValue => _exampleService.currentValue;
  List<int> get fetchedValue => _exampleService.fetchedNumbers;

  void _changeCount() {
    _count++;
    notifyListeners();
  }

  void stopCounter() {
    _timer.cancel();
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_exampleService];
}
