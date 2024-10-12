import 'package:example/models/todo.dart';
import 'package:example/services/api/api_repository.dart';
import 'package:hayiqu/hayiqu.dart';

class HomeViewmodel extends BaseViewModel {
  final _apiService = getIt<ApiRepository>();
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  HomeViewmodel() {
    runBusyFuture(_getTodos());
  }

  Future<void> _getTodos() async {
    _todos = await _apiService.getTodos();
  }
}
