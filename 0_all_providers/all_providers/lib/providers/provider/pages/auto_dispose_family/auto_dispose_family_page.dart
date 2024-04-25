import 'package:all_providers/providers/provider/pages/auto_dispose_family/auto_dispose_family_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AutoDisposeFamilyPage extends ConsumerWidget {
  const AutoDisposeFamilyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final helloJohn = ref.watch(autoDisPoseFamilyHelloProvider('John'));
    final helloJane = ref.watch(autoDisPoseFamilyHelloProvider('Jane'));

    ref.watch(counterProvider(Counter(count: 0)));
    ref.watch(counterProvider(Counter(count: 0)));
    return Scaffold(
      appBar: AppBar(
        title: const Text('AutoDisposeFamilyProvider'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(helloJohn),
            const SizedBox(height: 10.0,),
            Text(helloJane)
          ],
        ),
      ),
    );
  }
}
