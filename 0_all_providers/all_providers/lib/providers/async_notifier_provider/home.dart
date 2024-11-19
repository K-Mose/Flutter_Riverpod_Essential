import 'package:all_providers/providers/async_notifier_provider/pages/counter/counter_page.dart';
import 'package:flutter/material.dart';

import 'package:all_providers/widgets/custom_button.dart';

class AsyncNotifierProviderScreen extends StatelessWidget {
  const AsyncNotifierProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AsyncNotifierProvider'),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(20),
          shrinkWrap: true,
          children: const [
            CustomButton(
              title: 'Counter',
              child: CounterPage(),
            ),
          ],
        ),
      ),
    );
  }
}
