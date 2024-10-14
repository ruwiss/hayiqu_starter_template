import 'package:example/services/api/api_repository.dart';
import 'package:example/models/todo.dart';
import 'package:hayiqu/hayiqu.dart';
import 'dart:async';

class ApiService implements ApiRepository {
  final _http = getIt<HttpService>();

  ApiService() {
    _http
      ..setBaseUrl('https://jsonplaceholder.typicode.com')
      ..enableLogger(false);
  }

  @override
  Future<List<Todo>> getTodos() async {
    final result = await _http.get('/todos');
    if (result.hasValue) {
      return (result.requireValue.data as List)
          .map((e) => Todo.fromMap(e))
          .toList();
    } else {
      result.requireError.message.log();
    }
    return [];
  }
}
