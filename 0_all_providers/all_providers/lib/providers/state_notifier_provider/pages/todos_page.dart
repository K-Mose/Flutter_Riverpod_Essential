import 'package:all_providers/providers/state_notifier_provider/pages/todos_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodosPage extends ConsumerWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosProvider);
    print(todos);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
      ),
      body: Column(
        children: [
          const AddTodo(),
          const SizedBox(height: 30,),
          Expanded(
            child: ListView(
              children: [
                for (final todo in todos)
                  CheckboxListTile(
                    value: todo.completed,
                    onChanged: (value) {
                      ref.read(todosProvider.notifier).toggleTodo(todo.id);
                    },
                    title: Text(todo.desc),
                    secondary: IconButton(
                      onPressed: () {
                        ref.read(todosProvider.notifier).removeTodo(todo.id);
                      },
                      icon: const Icon(Icons.delete_forever),
                    ),
                  )
              ],
            ),
          )
        ],
      )
    );
  }
}

class AddTodo extends ConsumerStatefulWidget {
  const AddTodo({super.key});

  @override
  ConsumerState<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends ConsumerState<AddTodo> {
  final tcDesc = TextEditingController();

  @override
  void dispose() {
    tcDesc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: tcDesc,
        decoration: const InputDecoration(
          labelText: 'New Todo',
        ),
        onSubmitted: (desc) {
          if (desc.isNotEmpty) {
            ref.read(todosProvider.notifier).addTodo(desc);
          }
        },
      ),
    );
  }
}
