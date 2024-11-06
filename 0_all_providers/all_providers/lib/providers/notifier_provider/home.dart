import 'package:flutter/material.dart';

import 'package:all_providers/widgets/custom_button.dart';

import 'pages/counter/counter_page.dart';

class NotifierProviderScreen extends StatelessWidget {
  const NotifierProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NotifierProvider'),
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
