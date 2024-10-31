import 'dart:async';

abstract class ApiService {
  Future<List<String>> getTodos();

  FutureOr<int> getLastIndex();
}
