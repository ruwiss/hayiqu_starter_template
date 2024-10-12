import 'dart:async';

import 'package:example/models/todo.dart';

abstract interface class ApiRepository {
  Future<List<Todo>> getTodos();
}
