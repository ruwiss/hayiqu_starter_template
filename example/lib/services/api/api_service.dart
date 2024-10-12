import 'dart:async';
import 'dart:developer';

import 'package:example/models/todo.dart';
import 'package:example/services/api/api_repository.dart';
import 'package:hayiqu/hayiqu.dart';

class ApiService implements ApiRepository {
  final _http = getIt<HttpService>();

  ApiService() {
    _http
      ..setBaseUrl('https://jsonplaceholder.typicode.com')
      ..enableLogger(false);
  }

  @override
  Future<List<Todo>> getTodos() async {
    try {
      final response = await _http.get('/todos');
      if (response.statusCode == 200) {
        return (response.data as List).map((e) => Todo.fromMap(e)).toList();
      }
    } catch (e) {
      log(e.toString());
    }
    return [];
  }
}
