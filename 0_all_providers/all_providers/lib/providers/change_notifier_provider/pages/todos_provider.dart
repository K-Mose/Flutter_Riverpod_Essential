import 'package:all_providers/providers/change_notifier_provider/models/todo_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class TodoNotifier extends ChangeNotifier{
  List<Todo> todos = [];

  void addTodo(String desc) {
    todos.add(Todo.add(desc: desc));
    notifyListeners();
  }

  void toggleTodo(String id) {
    final todo = todos.firstWhere((todo) => todo.id == id);
    todo.completed = !todo.completed;
    // todos = todos.map((todo) => (todo.id == id)
    //     ? todo.copyWith(completed: !todo.completed)
    //     : todo
    // ).toList();
    notifyListeners();
  }

  void removeTodo(String id ) {
    todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }
}

final todosProvider = ChangeNotifierProvider<TodoNotifier>((ref) {
  return TodoNotifier();
});
