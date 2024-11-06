import 'package:all_providers/providers/notifier_provider/pages/counter/counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterPage extends ConsumerWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    final autoDisposeCounter = ref.watch(autoDisposeCounterProvider);
    final familyCounter = ref.watch(familyCounterProvider(10));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("$counter", style: Theme.of(context).textTheme.headlineLarge,),
                const SizedBox(width: 20,),
                Text("$autoDisposeCounter", style: Theme.of(context).textTheme.headlineLarge,),
                const SizedBox(width: 20,),
                Text("$familyCounter", style: Theme.of(context).textTheme.headlineLarge,),
              ],
            ),
            const SizedBox(height: 50,),
            OutlinedButton(
              onPressed: () {
                ref.read(counterProvider.notifier).increment();
                ref.read(autoDisposeCounterProvider.notifier).increment();
                ref.read(familyCounterProvider(10).notifier).increment();
              },
              child: Text(
                'Increment',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
