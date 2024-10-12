import 'package:example/ui/views/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:hayiqu/hayiqu.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewmodel>();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (viewModel.todos.isEmpty && viewModel.isBusy)
              const CircularProgressIndicator(),
            if (viewModel.todos.isEmpty && !viewModel.isBusy)
              const Text('No Todos'),
            if (viewModel.todos.isNotEmpty)
              Flexible(
                child: ListView.builder(
                  itemCount: viewModel.todos.length,
                  itemBuilder: (context, index) {
                    final todo = viewModel.todos[index];
                    return ListTile(
                      title: Text(todo.title),
                      subtitle: Text("User: ${todo.userId}"),
                      trailing: Icon(todo.completed
                          ? Icons.check_box
                          : Icons.check_box_outline_blank),
                    );
                  },
                ),
              )
          ],
        ),
      ),
    );
  }
}
