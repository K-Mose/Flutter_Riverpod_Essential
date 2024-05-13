import 'package:all_providers/providers/state_notifier_provider/models/todo_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoNotifier extends StateNotifier<List<Todo>>{
  TodoNotifier(): super([]);

  void addTodo(String desc) {
    state = [...state, Todo.add(desc: desc)];
  }

  void toggleTodo(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id) todo.copyWith(completed: !todo.completed) else todo
    ];
  }

  void removeTodo(String id ) {
    state = [
      for (final todo in state)
        if (todo.id != id) todo
    ];
  }
}

final todosProvider = StateNotifierProvider<TodoNotifier, List<Todo>>((ref) {
  return TodoNotifier();
});
