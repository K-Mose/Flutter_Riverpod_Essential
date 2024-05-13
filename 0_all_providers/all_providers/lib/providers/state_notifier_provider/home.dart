import 'package:all_providers/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'pages/todos_page.dart';

class StateNotifierProviderScreen extends StatelessWidget {
  const StateNotifierProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StateNotifierProvider'),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(20),
          shrinkWrap: true,
          children: const [
            CustomButton(
              title: 'Todo List',
              child: TodosPage(),
            ),
          ],
        ),
      ),
    );
  }
}
