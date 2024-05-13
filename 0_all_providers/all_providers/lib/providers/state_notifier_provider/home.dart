import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'pages/todos_page.dart';
import 'widgets/custom_button.dart';

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
